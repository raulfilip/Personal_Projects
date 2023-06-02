namespace Campionat1
{
    partial class Form3
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Echipa1 = new System.Windows.Forms.Label();
            this.Echipa2 = new System.Windows.Forms.Label();
            this.Campionat = new System.Windows.Forms.Label();
            this.Data = new System.Windows.Forms.Label();
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.buttonAdaugaM = new System.Windows.Forms.Button();
            this.comboBoxE1 = new System.Windows.Forms.ComboBox();
            this.comboBoxE2 = new System.Windows.Forms.ComboBox();
            this.comboBoxC = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // Echipa1
            // 
            this.Echipa1.AutoSize = true;
            this.Echipa1.Location = new System.Drawing.Point(50, 111);
            this.Echipa1.Name = "Echipa1";
            this.Echipa1.Size = new System.Drawing.Size(59, 17);
            this.Echipa1.TabIndex = 0;
            this.Echipa1.Text = "Echipa1";
            // 
            // Echipa2
            // 
            this.Echipa2.AutoSize = true;
            this.Echipa2.Location = new System.Drawing.Point(50, 158);
            this.Echipa2.Name = "Echipa2";
            this.Echipa2.Size = new System.Drawing.Size(59, 17);
            this.Echipa2.TabIndex = 1;
            this.Echipa2.Text = "Echipa2";
            // 
            // Campionat
            // 
            this.Campionat.AutoSize = true;
            this.Campionat.Location = new System.Drawing.Point(50, 202);
            this.Campionat.Name = "Campionat";
            this.Campionat.Size = new System.Drawing.Size(75, 17);
            this.Campionat.TabIndex = 2;
            this.Campionat.Text = "Campionat";
            // 
            // Data
            // 
            this.Data.AutoSize = true;
            this.Data.Location = new System.Drawing.Point(50, 242);
            this.Data.Name = "Data";
            this.Data.Size = new System.Drawing.Size(93, 17);
            this.Data.TabIndex = 3;
            this.Data.Text = "Data Meciului";
            // 
            // dateTimePicker1
            // 
            this.dateTimePicker1.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dateTimePicker1.Location = new System.Drawing.Point(187, 242);
            this.dateTimePicker1.Name = "dateTimePicker1";
            this.dateTimePicker1.Size = new System.Drawing.Size(238, 22);
            this.dateTimePicker1.TabIndex = 7;
            // 
            // buttonAdaugaM
            // 
            this.buttonAdaugaM.Location = new System.Drawing.Point(320, 295);
            this.buttonAdaugaM.Name = "buttonAdaugaM";
            this.buttonAdaugaM.Size = new System.Drawing.Size(105, 60);
            this.buttonAdaugaM.TabIndex = 8;
            this.buttonAdaugaM.Text = "Adaugare";
            this.buttonAdaugaM.UseVisualStyleBackColor = true;
            this.buttonAdaugaM.Click += new System.EventHandler(this.buttonAdaugaM_Click);
            // 
            // comboBoxE1
            // 
            this.comboBoxE1.FormattingEnabled = true;
            this.comboBoxE1.Location = new System.Drawing.Point(187, 108);
            this.comboBoxE1.Name = "comboBoxE1";
            this.comboBoxE1.Size = new System.Drawing.Size(90, 24);
            this.comboBoxE1.TabIndex = 9;
            this.comboBoxE1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // comboBoxE2
            // 
            this.comboBoxE2.FormattingEnabled = true;
            this.comboBoxE2.Location = new System.Drawing.Point(187, 151);
            this.comboBoxE2.Name = "comboBoxE2";
            this.comboBoxE2.Size = new System.Drawing.Size(90, 24);
            this.comboBoxE2.TabIndex = 10;
            this.comboBoxE2.SelectedIndexChanged += new System.EventHandler(this.comboBoxE2_SelectedIndexChanged);
            // 
            // comboBoxC
            // 
            this.comboBoxC.FormattingEnabled = true;
            this.comboBoxC.Location = new System.Drawing.Point(187, 202);
            this.comboBoxC.Name = "comboBoxC";
            this.comboBoxC.Size = new System.Drawing.Size(90, 24);
            this.comboBoxC.TabIndex = 11;
            
            // 
            // Form3
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(498, 386);
            this.Controls.Add(this.comboBoxC);
            this.Controls.Add(this.comboBoxE2);
            this.Controls.Add(this.comboBoxE1);
            this.Controls.Add(this.buttonAdaugaM);
            this.Controls.Add(this.dateTimePicker1);
            this.Controls.Add(this.Data);
            this.Controls.Add(this.Campionat);
            this.Controls.Add(this.Echipa2);
            this.Controls.Add(this.Echipa1);
            this.Name = "Form3";
            this.Text = "AdaugaMeci";
            this.Load += new System.EventHandler(this.Form3_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label Echipa1;
        private System.Windows.Forms.Label Echipa2;
        private System.Windows.Forms.Label Campionat;
        private System.Windows.Forms.Label Data;
        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.Button buttonAdaugaM;
        private System.Windows.Forms.ComboBox comboBoxE1;
        private System.Windows.Forms.ComboBox comboBoxE2;
        private System.Windows.Forms.ComboBox comboBoxC;
    }
}