/*
using System;
using System.Windows.Forms;

namespace WinFormsApp1VOTSVOTS
{
    partial class SignInForm
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.TextBox UsernameTextBox;
        private System.Windows.Forms.TextBox PasswordTextBox;
        private System.Windows.Forms.Button SignInButton;
        private System.Windows.Forms.Label UsernameLabel;
        private System.Windows.Forms.Label PasswordLabel;

        private void InitializeComponent()
        {
            UsernameTextBox = new TextBox();
            PasswordTextBox = new TextBox();
            SignInButton = new Button();
            UsernameLabel = new Label();
            PasswordLabel = new Label();
            SuspendLayout();
            // 
            // UsernameTextBox
            // 
            UsernameTextBox.Location = new Point(212, 183);
            UsernameTextBox.Margin = new Padding(4, 5, 4, 5);
            UsernameTextBox.Name = "UsernameTextBox";
            UsernameTextBox.Size = new Size(249, 31);
            UsernameTextBox.TabIndex = 0;
            // 
            // PasswordTextBox
            // 
            PasswordTextBox.Location = new Point(213, 286);
            PasswordTextBox.Margin = new Padding(4, 5, 4, 5);
            PasswordTextBox.Name = "PasswordTextBox";
            PasswordTextBox.PasswordChar = '*';
            PasswordTextBox.Size = new Size(249, 31);
            PasswordTextBox.TabIndex = 1;
            // 
            // SignInButton
            // 
            SignInButton.BackColor = Color.FromArgb(45, 45, 45);
            SignInButton.FlatStyle = FlatStyle.Flat;
            SignInButton.Font = new Font("Arial", 10F, FontStyle.Bold);
            SignInButton.ForeColor = Color.White;
            SignInButton.Location = new Point(212, 362);
            SignInButton.Margin = new Padding(4, 5, 4, 5);
            SignInButton.Name = "SignInButton";
            SignInButton.Size = new Size(250, 62);
            SignInButton.TabIndex = 2;
            SignInButton.Text = "Sign In";
            SignInButton.UseVisualStyleBackColor = false;
            SignInButton.Click += SignInButton_Click;
            // 
            // UsernameLabel
            // 
            UsernameLabel.AutoSize = true;
            UsernameLabel.Font = new Font("Arial", 10F, FontStyle.Bold);
            UsernameLabel.ForeColor = Color.White;
            UsernameLabel.Location = new Point(213, 133);
            UsernameLabel.Margin = new Padding(4, 0, 4, 0);
            UsernameLabel.Name = "UsernameLabel";
            UsernameLabel.Size = new Size(112, 24);
            UsernameLabel.TabIndex = 3;
            UsernameLabel.Text = "Username:";
            // 
            // PasswordLabel
            // 
            PasswordLabel.AutoSize = true;
            PasswordLabel.Font = new Font("Arial", 10F, FontStyle.Bold);
            PasswordLabel.ForeColor = Color.White;
            PasswordLabel.Location = new Point(213, 237);
            PasswordLabel.Margin = new Padding(4, 0, 4, 0);
            PasswordLabel.Name = "PasswordLabel";
            PasswordLabel.Size = new Size(110, 24);
            PasswordLabel.TabIndex = 4;
            PasswordLabel.Text = "Password:";
            // 
            // SignInForm
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.Black;
            ClientSize = new Size(674, 594);
            Controls.Add(UsernameTextBox);
            Controls.Add(PasswordTextBox);
            Controls.Add(SignInButton);
            Controls.Add(UsernameLabel);
            Controls.Add(PasswordLabel);
            FormBorderStyle = FormBorderStyle.FixedDialog;
            Margin = new Padding(4, 5, 4, 5);
            Name = "SignInForm";
            Text = "Sign In - VOTS";
            ResumeLayout(false);
            PerformLayout();
        }
    }
}

*/

namespace WinFormsApp1VOTSVOTS
{
    partial class SignInForm
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.TextBox emailTextBox;
        private System.Windows.Forms.TextBox usernameTextBox;
        private System.Windows.Forms.TextBox passwordTextBox;
        private System.Windows.Forms.TextBox zipCodeTextBox;
        private System.Windows.Forms.Button signInButton;
        private System.Windows.Forms.GroupBox diseaseGroupBox;
        private System.Windows.Forms.CheckBox covidCheckBox;
        private System.Windows.Forms.CheckBox fluCheckBox;
        private System.Windows.Forms.CheckBox tbCheckBox;
        private System.Windows.Forms.CheckBox chlamydiaCheckBox;
        private System.Windows.Forms.CheckBox hivCheckBox;

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
            emailTextBox = new TextBox();
            usernameTextBox = new TextBox();
            passwordTextBox = new TextBox();
            zipCodeTextBox = new TextBox();
            signInButton = new Button();
            diseaseGroupBox = new GroupBox();
            covidCheckBox = new CheckBox();
            fluCheckBox = new CheckBox();
            tbCheckBox = new CheckBox();
            chlamydiaCheckBox = new CheckBox();
            hivCheckBox = new CheckBox();
            diseaseGroupBox.SuspendLayout();
            SuspendLayout();
            // 
            // emailTextBox
            // 
            emailTextBox.Location = new Point(104, 182);
            emailTextBox.Name = "emailTextBox";
            emailTextBox.PlaceholderText = "Email";
            emailTextBox.Size = new Size(200, 31);
            emailTextBox.TabIndex = 0;
            // 
            // usernameTextBox
            // 
            usernameTextBox.Location = new Point(480, 182);
            usernameTextBox.Name = "usernameTextBox";
            usernameTextBox.PlaceholderText = "Username";
            usernameTextBox.Size = new Size(200, 31);
            usernameTextBox.TabIndex = 1;
            // 
            // passwordTextBox
            // 
            passwordTextBox.Location = new Point(104, 235);
            passwordTextBox.Name = "passwordTextBox";
            passwordTextBox.PasswordChar = '*';
            passwordTextBox.PlaceholderText = "Password";
            passwordTextBox.Size = new Size(200, 31);
            passwordTextBox.TabIndex = 2;
            // 
            // zipCodeTextBox
            // 
            zipCodeTextBox.Location = new Point(480, 235);
            zipCodeTextBox.Name = "zipCodeTextBox";
            zipCodeTextBox.PlaceholderText = "Zip Code";
            zipCodeTextBox.Size = new Size(200, 31);
            zipCodeTextBox.TabIndex = 3;
            // 
            // signInButton
            // 
            signInButton.BackColor = Color.FromArgb(45, 45, 45);
            signInButton.FlatStyle = FlatStyle.Flat;
            signInButton.ForeColor = Color.White;
            signInButton.Location = new Point(255, 435);
            signInButton.Name = "signInButton";
            signInButton.Size = new Size(258, 47);
            signInButton.TabIndex = 4;
            signInButton.Text = "Sign In";
            signInButton.UseVisualStyleBackColor = false;
            signInButton.Click += SignInButton_Click;
            // 
            // diseaseGroupBox
            // 
            diseaseGroupBox.Controls.Add(covidCheckBox);
            diseaseGroupBox.Controls.Add(hivCheckBox);
            diseaseGroupBox.Controls.Add(chlamydiaCheckBox);
            diseaseGroupBox.Controls.Add(fluCheckBox);
            diseaseGroupBox.Controls.Add(tbCheckBox);
            diseaseGroupBox.Location = new Point(196, 296);
            diseaseGroupBox.Name = "diseaseGroupBox";
            diseaseGroupBox.Size = new Size(371, 115);
            diseaseGroupBox.TabIndex = 5;
            diseaseGroupBox.TabStop = false;
            diseaseGroupBox.Text = "Select Diseases of Interest";
            // 
            // covidCheckBox
            // 
            covidCheckBox.Location = new Point(227, 19);
            covidCheckBox.Name = "covidCheckBox";
            covidCheckBox.Size = new Size(120, 24);
            covidCheckBox.TabIndex = 0;
            covidCheckBox.Text = "COVID-19";
            // 
            // fluCheckBox
            // 
            fluCheckBox.Location = new Point(9, 19);
            fluCheckBox.Name = "fluCheckBox";
            fluCheckBox.Size = new Size(132, 24);
            fluCheckBox.TabIndex = 1;
            fluCheckBox.Text = "Influenza";
            // 
            // tbCheckBox
            // 
            tbCheckBox.Location = new Point(227, 49);
            tbCheckBox.Name = "tbCheckBox";
            tbCheckBox.Size = new Size(138, 24);
            tbCheckBox.TabIndex = 2;
            tbCheckBox.Text = "Tuberculosis";
            // 
            // chlamydiaCheckBox
            // 
            chlamydiaCheckBox.Location = new Point(9, 79);
            chlamydiaCheckBox.Name = "chlamydiaCheckBox";
            chlamydiaCheckBox.Size = new Size(148, 24);
            chlamydiaCheckBox.TabIndex = 3;
            chlamydiaCheckBox.Text = "Chlamydia";
            // 
            // hivCheckBox
            // 
            hivCheckBox.Location = new Point(9, 49);
            hivCheckBox.Name = "hivCheckBox";
            hivCheckBox.Size = new Size(104, 24);
            hivCheckBox.TabIndex = 4;
            hivCheckBox.Text = "HIV";
            // 
            // SignInForm
            // 
            BackColor = Color.Black;
            ClientSize = new Size(772, 515);
            Controls.Add(emailTextBox);
            Controls.Add(usernameTextBox);
            Controls.Add(passwordTextBox);
            Controls.Add(zipCodeTextBox);
            Controls.Add(signInButton);
            Controls.Add(diseaseGroupBox);
            ForeColor = Color.White;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            Name = "SignInForm";
            Text = "Sign In";
            diseaseGroupBox.ResumeLayout(false);
            ResumeLayout(false);
            PerformLayout();
        }
    }
}
