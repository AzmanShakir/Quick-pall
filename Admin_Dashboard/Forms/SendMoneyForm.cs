using Admin_Dashboard.Controllers;
using Admin_Dashboard.Models;
using Guna.UI2.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Admin_Dashboard.Forms
{
    public partial class SendMoneyForm : Form
    {
        List<AccountHolder> accountHolders;
        public SendMoneyForm ()
        {
            InitializeComponent ();
            this.dgv.CellDoubleClick += Dgv_CellDoubleClick;
        }
        private async void Dgv_CellDoubleClick ( object sender, DataGridViewCellEventArgs e )
        {
            if ( e.RowIndex >= 0 ) // Ensure a valid row index
            {
                String targetEmail = dgv.Rows[e.RowIndex].Cells["Email"].Value.ToString ();

                using ( SendMoneyDialog modalForm = new SendMoneyDialog (accountHolders.FirstOrDefault (holder => holder.Email == targetEmail)) )
                {
                    
                    // Show the modal form as a dialog
                    DialogResult result = modalForm.ShowDialog ();
                    accountHolders = await AdminController.LoadAccountHoldersData (this.dgv);

              
                }

                DataGridViewRow selectedRow = dgv.Rows[e.RowIndex];

              
            }
        }
        private async void SendMoneyForm_Load ( object sender, EventArgs e )

        {
            dgv.AutoGenerateColumns = false;
            dgv.ReadOnly = true;
            accountHolders = await AdminController.LoadAccountHoldersData (this.dgv);
        }

        private void guna2Button1_Click ( object sender, EventArgs e )
        {
            string searchEmail = txtSearch.Text; // Assuming txtSearchEmail is a TextBox for entering the email
            SearchByEmail (this.dgv, searchEmail);
        }


        public static void SearchByEmail ( Guna2DataGridView dgv, string searchEmail )
        {
            bool isFound = false;
            // Iterate through rows to find the matching email
            foreach ( DataGridViewRow row in dgv.Rows )
            {
                if ( row.Cells["Email"].Value != null && row.Cells["Email"].Value.ToString () == searchEmail )
                {
                    // Unselect the previously selected row
                    dgv.ClearSelection ();
                    // Select the matching row
                    row.Selected = true;

                    // Scroll to the selected row (optional)
                    dgv.FirstDisplayedScrollingRowIndex = row.Index;
                    isFound = true;
                    // Exit the loop once a match is found
                    break;
                }
                
            }
            if(!isFound)
             {
                        MessageBox.Show ("Not found", "Serach");
                    }
        }
    }
}
