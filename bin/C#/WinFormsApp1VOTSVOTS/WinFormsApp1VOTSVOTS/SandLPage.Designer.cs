using System.Drawing;
using System.Windows.Forms;

namespace WinFormsApp1VOTSVOTS
{
    partial class SandLPage
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.Button btnSignIn;
        private System.Windows.Forms.Button btnLogIn;
        private System.Windows.Forms.Label lblWelcome;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            btnSignIn = new Button();
            btnLogIn = new Button();
            lblWelcome = new Label();
            SuspendLayout();
            // 
            // btnSignIn
            // 
            btnSignIn.BackColor = Color.FromArgb(45, 45, 45);
            btnSignIn.FlatStyle = FlatStyle.Flat;
            btnSignIn.Font = new Font("Arial", 12F, FontStyle.Bold);
            btnSignIn.ForeColor = Color.White;
            btnSignIn.Location = new Point(300, 300);
            btnSignIn.Name = "btnSignIn";
            btnSignIn.Size = new Size(200, 50);
            btnSignIn.TabIndex = 1;
            btnSignIn.Text = "Sign Up";
            btnSignIn.UseVisualStyleBackColor = false;
            btnSignIn.Click += BtnSignIn_Click;
            // 
            // btnLogIn
            // 
            btnLogIn.BackColor = Color.FromArgb(45, 45, 45);
            btnLogIn.FlatStyle = FlatStyle.Flat;
            btnLogIn.Font = new Font("Arial", 12F, FontStyle.Bold);
            btnLogIn.ForeColor = Color.White;
            btnLogIn.Location = new Point(600, 300);
            btnLogIn.Name = "btnLogIn";
            btnLogIn.Size = new Size(200, 50);
            btnLogIn.TabIndex = 2;
            btnLogIn.Text = "Log In";
            btnLogIn.UseVisualStyleBackColor = false;
            btnLogIn.Click += BtnLogIn_Click;
            // 
            // lblWelcome
            // 
            lblWelcome.AutoSize = true;
            lblWelcome.Font = new Font("Arial", 24F, FontStyle.Bold);
            lblWelcome.ForeColor = Color.White;
            lblWelcome.Location = new Point(338, 101);
            lblWelcome.Name = "lblWelcome";
            lblWelcome.Size = new Size(436, 56);
            lblWelcome.TabIndex = 0;
            lblWelcome.Text = "Welcome to VOTS";
            // 
            // SandLPage
            // 
            BackColor = Color.Black;
            ClientSize = new Size(1087, 623);
            Controls.Add(lblWelcome);
            Controls.Add(btnSignIn);
            Controls.Add(btnLogIn);
            FormBorderStyle = FormBorderStyle.FixedDialog;
            Name = "SandLPage";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Sign In or Log In";
            ResumeLayout(false);
            PerformLayout();

          

        }
    }
}
