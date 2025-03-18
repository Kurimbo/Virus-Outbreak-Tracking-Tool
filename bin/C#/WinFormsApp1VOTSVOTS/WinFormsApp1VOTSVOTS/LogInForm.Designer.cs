namespace WinFormsApp1VOTSVOTS
{
    partial class LogInForm
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.TextBox usernameTextBox;
        private System.Windows.Forms.TextBox passwordTextBox;
        private System.Windows.Forms.Button logInButton;

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
            usernameTextBox = new TextBox();
            passwordTextBox = new TextBox();
            logInButton = new Button();
            SuspendLayout();
            // 
            // usernameTextBox
            // 
            usernameTextBox.Location = new Point(173, 194);
            usernameTextBox.Name = "usernameTextBox";
            usernameTextBox.PlaceholderText = "Username";
            usernameTextBox.Size = new Size(210, 31);
            usernameTextBox.TabIndex = 0;
            // 
            // passwordTextBox
            // 
            passwordTextBox.Location = new Point(173, 241);
            passwordTextBox.Name = "passwordTextBox";
            passwordTextBox.PasswordChar = '*';
            passwordTextBox.PlaceholderText = "Password";
            passwordTextBox.Size = new Size(210, 31);
            passwordTextBox.TabIndex = 1;
            // 
            // logInButton
            // 
            logInButton.BackColor = Color.FromArgb(45, 45, 45);
            logInButton.FlatStyle = FlatStyle.Flat;
            logInButton.ForeColor = Color.White;
            logInButton.Location = new Point(173, 294);
            logInButton.Name = "logInButton";
            logInButton.Size = new Size(210, 40);
            logInButton.TabIndex = 2;
            logInButton.Text = "Log In";
            logInButton.UseVisualStyleBackColor = false;
            logInButton.Click += LogInButton_Click;
            // 
            // LogInForm
            // 
            BackColor = Color.Black;
            ClientSize = new Size(546, 392);
            Controls.Add(usernameTextBox);
            Controls.Add(passwordTextBox);
            Controls.Add(logInButton);
            ForeColor = Color.White;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            Name = "LogInForm";
            Text = "Log In";
            ResumeLayout(false);
            PerformLayout();
        }
    }
}
