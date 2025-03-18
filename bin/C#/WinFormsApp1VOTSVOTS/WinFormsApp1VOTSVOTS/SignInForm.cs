/*
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace WinFormsApp1VOTSVOTS
{
    public partial class SignInForm : Form
    {
        public SignInForm()
        {
            InitializeComponent();
        }

        private void SignInButton_Click(object sender, EventArgs e)
        {
            // You can add login verification logic here
            EnhancedAreaPage enhancedPage = new EnhancedAreaPage();
            enhancedPage.Show();
            this.Hide();
        }
    }
}
*/

using System;
using System.Windows.Forms;

namespace WinFormsApp1VOTSVOTS
{
    public partial class SignInForm : Form
    {
        public SignInForm()
        {
            InitializeComponent();
        }

        private void SignInButton_Click(object sender, EventArgs e)
        {
            // Navigate to EnhancedAreaPage when Sign In is clicked
            EnhancedAreaPage enhancedArea = new EnhancedAreaPage();
            enhancedArea.Show();
            this.Hide();
        }
    }
}
