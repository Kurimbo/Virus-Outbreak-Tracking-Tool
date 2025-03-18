using System;
using System.Windows.Forms;

namespace WinFormsApp1VOTSVOTS
{
    public partial class EnhancedAreaPage : Form
    {
        public EnhancedAreaPage()
        {
            InitializeComponent();
        }

        private void BtnUserInfo_Click(object sender, EventArgs e)
        {
            UserInformationPage userInfoPage = new UserInformationPage();
            userInfoPage.Show();
        }

        private void BtnSettings_Click(object sender, EventArgs e)
        {
            SettingsCustomizationPage settingsPage = new SettingsCustomizationPage();
            settingsPage.Show();
        }

        private void BtnAlerts_Click(object sender, EventArgs e)
        {
            AlertCatalogPage alertPage = new AlertCatalogPage();
            alertPage.Show();
        }

        private void EnhancedAreaPage_Load(object sender, EventArgs e)
        {

        }
    }
}
