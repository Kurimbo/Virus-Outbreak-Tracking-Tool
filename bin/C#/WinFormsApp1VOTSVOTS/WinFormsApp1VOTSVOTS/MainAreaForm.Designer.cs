    namespace WinFormsApp1VOTSVOTS
    {
        partial class MainAreaForm
        {
            private System.ComponentModel.IContainer components = null;
            private System.Windows.Forms.Button EnhancedViewButton;

        private void InitializeComponent()
        {
            EnhancedViewButton = new Button();
            SuspendLayout();
            // 
            // EnhancedViewButton
            // 
            EnhancedViewButton.BackColor = Color.FromArgb(45, 45, 45);
            EnhancedViewButton.FlatStyle = FlatStyle.Flat;
            EnhancedViewButton.Font = new Font("Arial", 10F, FontStyle.Bold);
            EnhancedViewButton.ForeColor = Color.White;
            EnhancedViewButton.Location = new Point(549, 868);
            EnhancedViewButton.Margin = new Padding(4, 5, 4, 5);
            EnhancedViewButton.Name = "EnhancedViewButton";
            EnhancedViewButton.Size = new Size(225, 56);
            EnhancedViewButton.TabIndex = 0;
            EnhancedViewButton.Text = "Enhanced View";
            EnhancedViewButton.UseVisualStyleBackColor = false;
            EnhancedViewButton.Click += EnhancedViewButton_Click;
            // 
            // MainAreaForm
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.Black;
            ClientSize = new Size(1250, 938);
            Controls.Add(EnhancedViewButton);
            FormBorderStyle = FormBorderStyle.FixedDialog;
            Margin = new Padding(4, 5, 4, 5);
            Name = "MainAreaForm";
            Text = "Virus Outbreak Tracking System";
            ResumeLayout(false);
        }
    }
    }
