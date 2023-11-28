using Google.Cloud.Firestore;
using Google.Cloud.Firestore.V1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Admin_Dashboard.Controllers
{
    public class Logger
    {
        public static async void PushLog ( string logMessage, string className, string functionName )
        {
            try
            {
                FirestoreDb db = FirestoreDb.Create ("quickpall", new FirestoreClientBuilder
                {
                    CredentialsPath = "quickpall-firebase-adminsdk-wfso1-77e2bb731a.json"
                }.Build ());
                var timestamp = FieldValue.ServerTimestamp;
                DateTime dateTime = DateTime.Now;

                var doc = db
                    .Collection ("Logs")
                    .Document ($"{className} {functionName} {dateTime.ToString ("h:mm tt")}");

                await doc.SetAsync (new Dictionary<string, object>
                {
                    { "Message", logMessage },
                    { "ClassName", className },
                    { "FunctionName", functionName },
                    { "createdAt", timestamp }
                });
            }
            catch ( Exception e )
            {
                Console.WriteLine (e);
            }
        }
    }

    public class Auditer
    {
        public static async void PushAudit ( Dictionary<string, object> oldData, Dictionary<string, object> newData, string collectionName )
        {
            try
            {
                FirestoreDb db = FirestoreDb.Create ("quickpall", new FirestoreClientBuilder
                {
                    CredentialsPath = "quickpall-firebase-adminsdk-wfso1-77e2bb731a.json"
                }.Build ());
                DateTime dateTime = DateTime.Now;

                Dictionary<string, object> oldModifiedMap = AddPrefixToKeys (oldData, "old");
                Dictionary<string, object> newModifiedMap = AddPrefixToKeys (newData, "new");
                Dictionary<string, object> auditDoc = newModifiedMap.Concat (oldModifiedMap).ToDictionary (x => x.Key, x => x.Value);

                auditDoc["CollectionName"] = collectionName;

                var doc = db
                    .Collection ("Audits")
                    .Document ($"{collectionName} {dateTime.ToString ("h:mm tt")}");

                await doc.SetAsync (auditDoc);
            }
            catch ( Exception e )
            {
                Console.WriteLine (e);
            }
        }

        private static Dictionary<string, object> AddPrefixToKeys ( Dictionary<string, object> originalMap, string prefix )
        {
            return originalMap.ToDictionary (entry => $"{prefix}{entry.Key}", entry => entry.Value);
        }
    }
}
