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
    public partial class AdminDashboard : Form
    {
        // Declare a variable to store the currently displayed form
        private Form currentChildForm;
        public AdminDashboard ()
        {
            InitializeComponent ();
        }

        private void guna2HtmlLabel1_Click ( object sender, EventArgs e )
        {

        }

        private void btnSend_Click ( object sender, EventArgs e )
        {
           
        }

        private void btnSend_Click_1 ( object sender, EventArgs e )
        {
            // Check if there is a form currently displayed
            if ( currentChildForm != null )
            {
                // Dispose or hide the current form
                currentChildForm.Dispose ();
                // Alternatively: currentChildForm.Hide();
            }

            // Create a new instance of the ChildForm
            SendMoneyForm childForm = new SendMoneyForm ();

            // Set TopLevel property to false to allow embedding in the panel
            childForm.TopLevel = false;

            // Set the Parent property to the panel where you want to display the form
            this.pnlContainer.Controls.Add (childForm);

            // Show the form
            childForm.Show ();

            // Update the currently displayed form variable
            currentChildForm = childForm;
        }

        private void btnWithDraw_Click ( object sender, EventArgs e )
        {
            // Check if there is a form currently displayed
            if ( currentChildForm != null )
            {
                // Dispose or hide the current form
                currentChildForm.Dispose ();
                // Alternatively: currentChildForm.Hide();
            }

            // Create a new instance of the ChildForm
            WIthdrawMoneyForm childForm = new WIthdrawMoneyForm ();

            // Set TopLevel property to false to allow embedding in the panel
            childForm.TopLevel = false;

            // Set the Parent property to the panel where you want to display the form
            this.pnlContainer.Controls.Add (childForm);

            // Show the form
            childForm.Show ();

            // Update the currently displayed form variable
            currentChildForm = childForm;
        }

        private void AdminDashboard_Load ( object sender, EventArgs e )
        {

        }
    }
}
