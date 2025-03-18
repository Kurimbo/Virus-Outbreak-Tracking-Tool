using System;
using System.Windows.Forms;

namespace WinFormsApp1VOTSVOTS
{
    public partial class SandLPage : Form
    {
        public SandLPage()
        {
            InitializeComponent();
        }

        private void BtnSignIn_Click(object sender, EventArgs e)
        {
            SignInForm signInForm = new SignInForm();
            signInForm.Show();
            this.Hide(); // Hide current page
        }

        private void BtnLogIn_Click(object sender, EventArgs e)
        {
            LogInForm logInForm = new LogInForm();
            logInForm.Show();
            this.Hide(); // Hide current page
        }
    }
}

