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
    public partial class SendMoneyDialog : Form
    {
        AccountHolder accountHolder;
        public SendMoneyDialog (AccountHolder accountHolder)

        {
            this.accountHolder = accountHolder;
            InitializeComponent ();
            this.StartPosition = FormStartPosition.CenterScreen;
        }

        private void label1_Click ( object sender, EventArgs e )
        {

        }

        private void guna2TextBox1_KeyPress ( object sender, KeyPressEventArgs e )
        {
            // Check if the pressed key is a digit or a control key (e.g., Backspace)
            if ( !char.IsDigit (e.KeyChar) && !char.IsControl (e.KeyChar) )
            {
                // If not a digit or control key, suppress the keypress
                e.Handled = true;
            }
        }

        private async void guna2Button1_Click ( object sender, EventArgs e )
        {
            if(txtMoney.Text.Length != 0) {
                AccountHolder newData = new AccountHolder
                {
                    Country = accountHolder.Country,
                    createdAt = accountHolder.createdAt,
                    Email = accountHolder.Email,
                    Image = accountHolder.Image,
                    IsActive = accountHolder.IsActive,
                    Money = accountHolder.Money,
                    Name = accountHolder.Name,
                    Password = accountHolder.Password,
                    Phone = accountHolder.Phone,
                    Pin = accountHolder.Pin,
                    updatedAt = accountHolder.updatedAt,
                };
                newData.Money = newData.Money + int.Parse (txtMoney.Text);
                bool status = await  AdminController.MakeTransactionAsync(this.accountHolder, newData,txtMoney.Text);
                if(status)
                {
                    MessageBox.Show ("Money Send", "Successful");
                }
                else
                {
                    MessageBox.Show ("Cannot Send", "Unsuccessful");

                }
                this.Close ();
            }
        }

        private void SendMoneyDialog_Load ( object sender, EventArgs e )
        {

        }
    }
}
