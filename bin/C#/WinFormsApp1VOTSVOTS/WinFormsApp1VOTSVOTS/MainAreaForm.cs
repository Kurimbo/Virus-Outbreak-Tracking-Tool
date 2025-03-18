
using System;
using System.Windows.Forms;
using WinFormsApp1VOTSVOTS;

namespace WinFormsApp1VOTSVOTS
{
    public partial class MainAreaForm : Form
    {
        public MainAreaForm()
        {
            InitializeComponent();
        }

        private void EnhancedViewButton_Click(object sender, EventArgs e)
        {
            SandLPage loginPage = new SandLPage();
            loginPage.Show();
            this.Hide();
        }
    }
}
