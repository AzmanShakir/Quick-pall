using Google.Cloud.Firestore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Admin_Dashboard.Models
{
    [FirestoreData]
 public   class AccountHolder
    {
        public AccountHolder () { }
        public String Email { get; set; }
        public String Password { get; set; }
        public String Name { get; set; }
        public String Country { get; set; }
        public String Phone { get; set; }
        public String Pin { get; set; }
        public String Image { get; set; }
        public int Money { get; set; }
        public bool IsActive { get; set; }
        public Google.Cloud.Firestore.Timestamp createdAt { get; set; }
        public Google.Cloud.Firestore.Timestamp updatedAt { get; set; }
    }
}
