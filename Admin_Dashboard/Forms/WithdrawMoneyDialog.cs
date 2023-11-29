using Admin_Dashboard.Controllers;
using Admin_Dashboard.Models;
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
    public partial class WithdrawMoneyDialog : Form
    {
        AccountHolder accountHolder;

        public WithdrawMoneyDialog ( AccountHolder accountHolder )
        {
            this.accountHolder = accountHolder;

            InitializeComponent ();
            this.StartPosition = FormStartPosition.CenterScreen;

        }

        private void WithdrawMoneyDialog_Load ( object sender, EventArgs e )
        {

        }

        private async void btnWithdraw_Click ( object sender, EventArgs e )
        {
            if(int.Parse(txtMoney.Text) > accountHolder.Money )
            {

                        MessageBox.Show ("Not enough cash to withdraw", "Out of cash");
            }
            else
            {
                if ( txtMoney.Text.Length != 0 )
                {

                    if ( await AdminController.SendWithdrawRequest (accountHolder.Email, this.txtMoney.Text) )
                    {
                        MessageBox.Show ("Request Sent", "Successful");
                    }
                    else
                    {
                        MessageBox.Show ("Cannot sent request", "Unsuccessful");

                    }
                    this.Close ();
                }
            }
            
        }

        private void btnWithdraw_KeyPress ( object sender, KeyPressEventArgs e )
        {
            // Check if the pressed key is a digit or a control key (e.g., Backspace)
            if ( !char.IsDigit (e.KeyChar) && !char.IsControl (e.KeyChar) )
            {
                // If not a digit or control key, suppress the keypress
                e.Handled = true;
            }

        }

        private void guna2Button1_Click ( object sender, EventArgs e )
        {
            this.Close();
        }
    }
}
