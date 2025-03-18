using System.Drawing;

namespace WinFormsApp1VOTSVOTS
{
    partial class EnhancedAreaPage
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.Button btnUserInfo;
        private System.Windows.Forms.Button btnSettings;
        private System.Windows.Forms.Button btnAlerts;
        private System.Windows.Forms.Label lblNotifications;
        private System.Windows.Forms.ListBox notificationBox;

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
            btnUserInfo = new Button();
            btnSettings = new Button();
            btnAlerts = new Button();
            lblNotifications = new Label();
            notificationBox = new ListBox();
            diseaseGroupBox = new GroupBox();
            chkCovid = new CheckBox();
            chkFlu = new CheckBox();
            chkTB = new CheckBox();
            chkChlamydia = new CheckBox();
            chkHIV = new CheckBox();
            diseaseGroupBox.SuspendLayout();
            SuspendLayout();
            // 
            // btnUserInfo
            // 
            btnUserInfo.BackColor = Color.FromArgb(45, 45, 45);
            btnUserInfo.FlatStyle = FlatStyle.Flat;
            btnUserInfo.Font = new Font("Arial", 10F, FontStyle.Bold);
            btnUserInfo.ForeColor = Color.White;
            btnUserInfo.Location = new Point(613, 20);
            btnUserInfo.Name = "btnUserInfo";
            btnUserInfo.Size = new Size(150, 40);
            btnUserInfo.TabIndex = 0;
            btnUserInfo.Text = "User Info";
            btnUserInfo.UseVisualStyleBackColor = false;
            btnUserInfo.Click += BtnUserInfo_Click;
            // 
            // btnSettings
            // 
            btnSettings.BackColor = Color.FromArgb(45, 45, 45);
            btnSettings.FlatStyle = FlatStyle.Flat;
            btnSettings.Font = new Font("Arial", 10F, FontStyle.Bold);
            btnSettings.ForeColor = Color.White;
            btnSettings.Location = new Point(769, 20);
            btnSettings.Name = "btnSettings";
            btnSettings.Size = new Size(150, 40);
            btnSettings.TabIndex = 1;
            btnSettings.Text = "Settings";
            btnSettings.UseVisualStyleBackColor = false;
            btnSettings.Click += BtnSettings_Click;
            // 
            // btnAlerts
            // 
            btnAlerts.BackColor = Color.FromArgb(45, 45, 45);
            btnAlerts.FlatStyle = FlatStyle.Flat;
            btnAlerts.Font = new Font("Arial", 10F, FontStyle.Bold);
            btnAlerts.ForeColor = Color.White;
            btnAlerts.Location = new Point(925, 20);
            btnAlerts.Name = "btnAlerts";
            btnAlerts.Size = new Size(150, 40);
            btnAlerts.TabIndex = 2;
            btnAlerts.Text = "Alerts";
            btnAlerts.UseVisualStyleBackColor = false;
            btnAlerts.Click += BtnAlerts_Click;
            // 
            // lblNotifications
            // 
            lblNotifications.Font = new Font("Arial", 14F, FontStyle.Bold);
            lblNotifications.ForeColor = Color.White;
            lblNotifications.Location = new Point(700, 94);
            lblNotifications.Name = "lblNotifications";
            lblNotifications.Size = new Size(230, 47);
            lblNotifications.TabIndex = 3;
            lblNotifications.Text = "Notifications";
            // 
            // notificationBox
            // 
            notificationBox.BackColor = Color.FromArgb(30, 30, 30);
            notificationBox.Font = new Font("Arial", 10F);
            notificationBox.ForeColor = Color.White;
            notificationBox.ItemHeight = 23;
            notificationBox.Items.AddRange(new object[] { "Alert 1: COVID-19 case nearby", "Alert 2: New influenza outbreak", "Alert 3: Vaccine drive this weekend" });
            notificationBox.Location = new Point(700, 144);
            notificationBox.Name = "notificationBox";
            notificationBox.ScrollAlwaysVisible = true;
            notificationBox.Size = new Size(375, 234);
            notificationBox.TabIndex = 4;
            // 
            // diseaseGroupBox
            // 
            diseaseGroupBox.BackColor = Color.FromArgb(30, 30, 30);
            diseaseGroupBox.Controls.Add(chkCovid);
            diseaseGroupBox.Controls.Add(chkFlu);
            diseaseGroupBox.Controls.Add(chkTB);
            diseaseGroupBox.Controls.Add(chkChlamydia);
            diseaseGroupBox.Controls.Add(chkHIV);
            diseaseGroupBox.Font = new Font("Arial", 12F, FontStyle.Bold);
            diseaseGroupBox.ForeColor = Color.White;
            diseaseGroupBox.Location = new Point(700, 398);
            diseaseGroupBox.Name = "diseaseGroupBox";
            diseaseGroupBox.Size = new Size(375, 213);
            diseaseGroupBox.TabIndex = 5;
            diseaseGroupBox.TabStop = false;
            diseaseGroupBox.Text = "Disease Filters";
            // 
            // chkCovid
            // 
            chkCovid.AutoSize = true;
            chkCovid.Font = new Font("Arial", 10F);
            chkCovid.ForeColor = Color.White;
            chkCovid.Location = new Point(17, 34);
            chkCovid.Name = "chkCovid";
            chkCovid.Size = new Size(128, 27);
            chkCovid.TabIndex = 0;
            chkCovid.Text = "COVID-19";
            // 
            // chkFlu
            // 
            chkFlu.AutoSize = true;
            chkFlu.Font = new Font("Arial", 10F);
            chkFlu.ForeColor = Color.White;
            chkFlu.Location = new Point(17, 64);
            chkFlu.Name = "chkFlu";
            chkFlu.Size = new Size(113, 27);
            chkFlu.TabIndex = 1;
            chkFlu.Text = "Influenza";
            // 
            // chkTB
            // 
            chkTB.AutoSize = true;
            chkTB.Font = new Font("Arial", 10F);
            chkTB.ForeColor = Color.White;
            chkTB.Location = new Point(17, 94);
            chkTB.Name = "chkTB";
            chkTB.Size = new Size(145, 27);
            chkTB.TabIndex = 2;
            chkTB.Text = "Tuberculosis";
            // 
            // chkChlamydia
            // 
            chkChlamydia.AutoSize = true;
            chkChlamydia.Font = new Font("Arial", 10F);
            chkChlamydia.ForeColor = Color.White;
            chkChlamydia.Location = new Point(17, 124);
            chkChlamydia.Name = "chkChlamydia";
            chkChlamydia.Size = new Size(127, 27);
            chkChlamydia.TabIndex = 3;
            chkChlamydia.Text = "Chlamydia";
            // 
            // chkHIV
            // 
            chkHIV.AutoSize = true;
            chkHIV.Font = new Font("Arial", 10F);
            chkHIV.ForeColor = Color.White;
            chkHIV.Location = new Point(17, 154);
            chkHIV.Name = "chkHIV";
            chkHIV.Size = new Size(68, 27);
            chkHIV.TabIndex = 4;
            chkHIV.Text = "HIV";
            // 
            // EnhancedAreaPage
            // 
            BackColor = Color.Black;
            ClientSize = new Size(1087, 623);
            Controls.Add(btnUserInfo);
            Controls.Add(btnSettings);
            Controls.Add(btnAlerts);
            Controls.Add(lblNotifications);
            Controls.Add(notificationBox);
            Controls.Add(diseaseGroupBox);
            FormBorderStyle = FormBorderStyle.FixedDialog;
            Name = "EnhancedAreaPage";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Enhanced Area";
            Load += EnhancedAreaPage_Load;
            diseaseGroupBox.ResumeLayout(false);
            diseaseGroupBox.PerformLayout();
            ResumeLayout(false);

            /*
            // PictureBox for Logo
            PictureBox logoPictureBox = new PictureBox();
            logoPictureBox.Location = new Point(400, 50);  // Adjust position as needed
            logoPictureBox.Size = new Size(300, 150);      // Adjust size as needed
            logoPictureBox.SizeMode = PictureBoxSizeMode.StretchImage;
            logoPictureBox.Image = Properties.Resources.VOTSIMAGELOGO;

            // Add PictureBox to Form
            this.Controls.Add(logoPictureBox);

            */
            //what the sigma


        }

        private GroupBox diseaseGroupBox;
        private CheckBox chkCovid;
        private CheckBox chkFlu;
        private CheckBox chkTB;
        private CheckBox chkChlamydia;
        private CheckBox chkHIV;
    }
}
