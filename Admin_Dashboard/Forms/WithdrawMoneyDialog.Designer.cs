namespace Admin_Dashboard.Forms
{
    partial class WithdrawMoneyDialog
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose ( bool disposing )
        {
            if ( disposing && ( components != null ) )
            {
                components.Dispose ();
            }
            base.Dispose (disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent ()
        {
            this.txtMoney = new Guna.UI2.WinForms.Guna2TextBox();
            this.btnWithdraw = new Guna.UI2.WinForms.Guna2Button();
            this.guna2Button1 = new Guna.UI2.WinForms.Guna2Button();
            this.SuspendLayout();
            // 
            // txtMoney
            // 
            this.txtMoney.BorderRadius = 15;
            this.txtMoney.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtMoney.DefaultText = "";
            this.txtMoney.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.txtMoney.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.txtMoney.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtMoney.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtMoney.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtMoney.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.txtMoney.ForeColor = System.Drawing.Color.Black;
            this.txtMoney.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtMoney.Location = new System.Drawing.Point(27, 74);
            this.txtMoney.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtMoney.Name = "txtMoney";
            this.txtMoney.PasswordChar = '\0';
            this.txtMoney.PlaceholderText = "Money to withdraw";
            this.txtMoney.SelectedText = "";
            this.txtMoney.Size = new System.Drawing.Size(281, 48);
            this.txtMoney.TabIndex = 3;
            // 
            // btnWithdraw
            // 
            this.btnWithdraw.BorderRadius = 20;
            this.btnWithdraw.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnWithdraw.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnWithdraw.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnWithdraw.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnWithdraw.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(255)))), ((int)(((byte)(128)))));
            this.btnWithdraw.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnWithdraw.ForeColor = System.Drawing.Color.Black;
            this.btnWithdraw.Location = new System.Drawing.Point(159, 160);
            this.btnWithdraw.Name = "btnWithdraw";
            this.btnWithdraw.Size = new System.Drawing.Size(95, 45);
            this.btnWithdraw.TabIndex = 2;
            this.btnWithdraw.Text = "Withdraw";
            this.btnWithdraw.Click += new System.EventHandler(this.btnWithdraw_Click);
            this.btnWithdraw.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.btnWithdraw_KeyPress);
            // 
            // guna2Button1
            // 
            this.guna2Button1.BorderRadius = 20;
            this.guna2Button1.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.guna2Button1.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.guna2Button1.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.guna2Button1.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.guna2Button1.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.guna2Button1.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.guna2Button1.ForeColor = System.Drawing.Color.Black;
            this.guna2Button1.Location = new System.Drawing.Point(41, 160);
            this.guna2Button1.Name = "guna2Button1";
            this.guna2Button1.Size = new System.Drawing.Size(95, 45);
            this.guna2Button1.TabIndex = 4;
            this.guna2Button1.Text = "Cancel";
            this.guna2Button1.Click += new System.EventHandler(this.guna2Button1_Click);
            // 
            // WithdrawMoneyDialog
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(334, 279);
            this.Controls.Add(this.guna2Button1);
            this.Controls.Add(this.txtMoney);
            this.Controls.Add(this.btnWithdraw);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "WithdrawMoneyDialog";
            this.Text = "WithdrawMoneyDialog";
            this.Load += new System.EventHandler(this.WithdrawMoneyDialog_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private Guna.UI2.WinForms.Guna2TextBox txtMoney;
        private Guna.UI2.WinForms.Guna2Button btnWithdraw;
        private Guna.UI2.WinForms.Guna2Button guna2Button1;
    }
}