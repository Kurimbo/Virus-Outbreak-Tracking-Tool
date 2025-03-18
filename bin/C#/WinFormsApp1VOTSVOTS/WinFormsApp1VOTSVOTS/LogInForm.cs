using System;
using System.Windows.Forms;

namespace WinFormsApp1VOTSVOTS
{
    public partial class LogInForm : Form
    {
        public LogInForm()
        {
            InitializeComponent();
        }

        private void LogInButton_Click(object sender, EventArgs e)
        {
            // Navigate to EnhancedAreaPage when Log In is clicked
            EnhancedAreaPage enhancedArea = new EnhancedAreaPage();
            enhancedArea.Show();
            this.Hide();
        }
    }
}
