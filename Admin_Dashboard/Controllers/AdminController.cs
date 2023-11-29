using Google.Cloud.Firestore.V1;
using Google.Cloud.Firestore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Admin_Dashboard.Models;
using Guna.UI2.WinForms;
using Microsoft.Extensions.Logging;

namespace Admin_Dashboard.Controllers
{
    public class AdminController
    {
        public async static Task<bool> Login(string UserName,String  Password)
        {
            try
            {

                FirestoreDb db = FirestoreDb.Create ("quickpall", new FirestoreClientBuilder
                {
                    CredentialsPath = "quickpall-firebase-adminsdk-wfso1-77e2bb731a.json"
                }.Build ());



                DocumentReference docRef = db.Collection ("Admin").Document ("admin");

                DocumentSnapshot snapshot = await docRef.GetSnapshotAsync ();

                if ( snapshot.Exists )
                {
                    if ( snapshot.GetValue<string> ("UserName") == UserName && snapshot.GetValue<string> ("Password") == Password )
                        return true;
                }
                return false;
            }
            catch(Exception e) {
                Logger.PushLog (e.ToString (), "AdminController", "Login");
                Console.WriteLine (e);
                return false;
            }
        }
        public async static Task<List<AccountHolder>> LoadAccountHoldersData (Guna2DataGridView dgv)
        {

            try
            {
                FirestoreDb db = FirestoreDb.Create ("quickpall", new FirestoreClientBuilder
                {
                    CredentialsPath = "quickpall-firebase-adminsdk-wfso1-77e2bb731a.json"
                }.Build ());
                var collection = db.Collection ("AccountHolder"); // Replace with your actual collection name

                var query = collection.OrderBy ("Name"); // Replace "fieldName" with the field you want to order by

                var querySnapshot = await query.GetSnapshotAsync ();

                var dataList = new List<AccountHolder> (); // Replace YourDataClass with the class representing your Firestore documents

                foreach ( var document in querySnapshot.Documents )
                {
                    var data = MapDocumentToAccountHolder (document);
                    if ( data.IsActive )
                    {

                        dataList.Add (data);
                    }
                }
                // Clear existing columns and data
                dgv.Columns.Clear ();
                dgv.DataSource = null;

                // Add columns to the DataGridView
                dgv.Columns.Add ("Name", "Name");
                dgv.Columns.Add ("Country", "Country");
                dgv.Columns.Add ("Email", "Email");
                dgv.Columns.Add ("Money", "Money");

                // Populate the DataGridView with data
                foreach ( var accountHolder in dataList )
                {
                    dgv.Rows.Add (accountHolder.Name, accountHolder.Country, accountHolder.Email, accountHolder.Money);
                }
                // Assuming you have a DataGridView named dataGridView1
                return dataList;
            }
            catch(Exception e )
            {
                Logger.PushLog (e.ToString (), "AdminController", "LoadAccountHoldersData");
                Console.WriteLine (e);
                return null;
            }
        }
        private static AccountHolder MapDocumentToAccountHolder ( DocumentSnapshot document )
        {
            var accountHolder = new AccountHolder
            {
                Email = document.GetValue<string> ("Email"),
                Password = document.GetValue<string> ("Password"),
                Name = document.GetValue<string> ("Name"),
                Country = document.GetValue<string> ("Country"),
                Phone = document.GetValue<string> ("Phone"),
                Pin = document.GetValue<string> ("Pin"),
                Image = document.GetValue<string> ("Image"),
                Money = document.GetValue<int> ("Money"),
                IsActive = document.GetValue<bool> ("IsActive"),
                createdAt = document.GetValue<Timestamp> ("createdAt"),
                updatedAt = document.GetValue<Timestamp> ("updatedAt")
            };

            return accountHolder;
        }





        public static Dictionary<string, object> GetAccountHolderDictionary ( AccountHolder user )
        {
            return new Dictionary<string, object>
            {
                { "Email", user.Email },
                { "Password", user.Password },
                { "Name", user.Name },
                { "Country", user.Country },
                { "Phone", user.Phone },
                { "Pin", user.Pin },
                { "Image", user.Image },
                { "Money", user.Money },
                { "IsActive", user.IsActive },
                { "createdAt", user.createdAt },
                { "updatedAt", user.updatedAt },
            };
        }



        public static async Task<bool> UpdateUserAsync ( AccountHolder oldData, AccountHolder newData )
        {
            try
            {
                FirestoreDb db = FirestoreDb.Create ("quickpall", new FirestoreClientBuilder
                {
                    CredentialsPath = "quickpall-firebase-adminsdk-wfso1-77e2bb731a.json"
                }.Build ());
                var timestamp = FieldValue.ServerTimestamp;
                var id = newData.Email;
                Console.WriteLine ("Creating JSONs");
                Console.WriteLine (newData.Email);

                Dictionary<string, object> oldJson = GetAccountHolderDictionary (oldData);
                Dictionary<string, object> newJson = GetAccountHolderDictionary (newData);

                Console.WriteLine ("JSONs created");

                newJson["updatedAt"] = timestamp;

                var doc =db
                    .Collection ("AccountHolder")
                    .Document (id);

                await doc.SetAsync (newJson);

                Console.WriteLine ("User Updated");
                Auditer.PushAudit (oldJson, newJson, "AccountHolder");

                return true;
            }
            catch ( Exception e )
            {
                Logger.PushLog (e.ToString (), "AdminController", "UpdateUserAsync");
                Console.WriteLine (e);
                return false;
            }
        }








        public static async Task<bool> MakeTransactionAsync ( AccountHolder oldData, AccountHolder newData,String amount
            )
        {
            string senderEmail = "Admin";
            string receiverEmail = newData.Email;
            string reason = "Admin Send This";
            string amountToSend = amount.ToString ();
            try
            {
                if(!(await UpdateUserAsync (oldData, newData) ) )
                {
                    return false;
                }
                var timestamp = FieldValue.ServerTimestamp;
                FirestoreDb db = FirestoreDb.Create ("quickpall", new FirestoreClientBuilder
                {
                    CredentialsPath = "quickpall-firebase-adminsdk-wfso1-77e2bb731a.json"
                }.Build ());
                // Add Receive transactions for Receiver
                var receiveDoc = await db
                    .Collection ("UserTransactions")
                    .AddAsync (new Dictionary<string, object>
                    {
                        { "FriendId", senderEmail },
                        { "IsActive", true },
                        { "Amount", amountToSend },
                        { "Reason", reason },
                        { "TransactionType", "Recieve" },
                        { "createdAt", timestamp },
                        { "updatedAt", timestamp }
                    });
                await db
                    .Collection ("Transactions")
                    .Document (receiverEmail)
                    .SetAsync (new Dictionary<string, object>
                    {
                        { "TransactionArray", FieldValue.ArrayUnion(receiveDoc) }
                    }, SetOptions.MergeAll);

                return true;
            }
            catch ( Exception e )
            {
                Logger.PushLog (e.ToString (), "AdminController", "MakeTransaction");
                Console.WriteLine (e);
                return false;
            }
        }

        internal async static Task<bool> SendWithdrawRequest ( string email ,String amount) 
        {
            try
            {
                var timestamp = FieldValue.ServerTimestamp;
                FirestoreDb db = FirestoreDb.Create ("quickpall", new FirestoreClientBuilder
                {
                    CredentialsPath = "quickpall-firebase-adminsdk-wfso1-77e2bb731a.json"
                }.Build ());
                DocumentReference docRef = db.Collection ("WithdrawIncomingRequest").Document (email);
                DocumentSnapshot snapshot = await docRef.GetSnapshotAsync ();

                if ( !snapshot.Exists )
                {
                    // Document doesn't exist, create a new one
                    Console.WriteLine ("Document does not exist. Creating a new one.");
                    Dictionary<string, object> newJson1 = new Dictionary<string, object>
                {
                    { "IsOpen", true },
                    { "Amount", amount},
                    { "createdAt", timestamp },
                    { "updatedAt", timestamp },
                };
                    await docRef.SetAsync (newJson1);

                    return true;
                }

                Console.WriteLine ("Creating Jsons");
                Dictionary<string, object> oldJson = snapshot.ToDictionary ();
                Dictionary<string, object> newJson = new Dictionary<string, object>
            {
                { "IsOpen", true },
                { "Amount", amount},
                { "createdAt", oldJson["createdAt"] },
                { "updatedAt", timestamp },
            };
                Console.WriteLine ("Jsons created");
                await docRef.SetAsync (newJson);

                // Assuming Auditer.PushAudit is a static method
                Auditer.PushAudit (oldJson, newJson, "WithDrawController");
                return true;
            }
            catch ( Exception e )
            {
                // Assuming Logger.PushLog is a static method
                Logger.PushLog (e.ToString (), "WithDrawController", "OpenWithDrawWindow");
                return false;
            }
        }
    }
}
