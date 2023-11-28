using Google.Cloud.Firestore.V1;
using Google.Cloud.Firestore;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Admin_Dashboard.Controllers;
using Admin_Dashboard.Forms;

namespace Admin_Dashboard
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }


        private void txtUserName_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }

        private async void guna2Button1_Click(object sender, EventArgs e)
        {
            if( await AdminController.Login (this.txtUserName.Text, this.txtPassword.Text))
            {
                AdminDashboard adminDashboard = new AdminDashboard();
                /*this.Hide ();*/
                adminDashboard.Show();
            }
            else
            {
                this.epLogin.SetError (this.btnLogin, "Incorrect UserName or Password");
            }
        }
    }
}
