namespace Campionat1
{
    partial class AdaugareCampionat
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
            this.DenumireCampionat = new System.Windows.Forms.Label();
            this.DataCampionat = new System.Windows.Forms.Label();
            this.DetaliiCampionat = new System.Windows.Forms.Label();
            this.textBoxDC = new System.Windows.Forms.TextBox();
            this.textBoxD = new System.Windows.Forms.TextBox();
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.dateTimePicker2 = new System.Windows.Forms.DateTimePicker();
            this.AdaugaEchipa = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // DenumireCampionat
            // 
            this.DenumireCampionat.AutoSize = true;
            this.DenumireCampionat.Location = new System.Drawing.Point(28, 46);
            this.DenumireCampionat.Name = "DenumireCampionat";
            this.DenumireCampionat.Size = new System.Drawing.Size(69, 17);
            this.DenumireCampionat.TabIndex = 0;
            this.DenumireCampionat.Text = "Denumire";
            // 
            // DataCampionat
            // 
            this.DataCampionat.AutoSize = true;
            this.DataCampionat.Location = new System.Drawing.Point(28, 93);
            this.DataCampionat.Name = "DataCampionat";
            this.DataCampionat.Size = new System.Drawing.Size(38, 17);
            this.DataCampionat.TabIndex = 1;
            this.DataCampionat.Text = "Data";
            // 
            // DetaliiCampionat
            // 
            this.DetaliiCampionat.AutoSize = true;
            this.DetaliiCampionat.Location = new System.Drawing.Point(28, 167);
            this.DetaliiCampionat.Name = "DetaliiCampionat";
            this.DetaliiCampionat.Size = new System.Drawing.Size(47, 17);
            this.DetaliiCampionat.TabIndex = 2;
            this.DetaliiCampionat.Text = "Detalii";
            // 
            // textBoxDC
            // 
            this.textBoxDC.Location = new System.Drawing.Point(205, 43);
            this.textBoxDC.Name = "textBoxDC";
            this.textBoxDC.Size = new System.Drawing.Size(200, 22);
            this.textBoxDC.TabIndex = 3;
            // 
            // textBoxD
            // 
            this.textBoxD.Location = new System.Drawing.Point(205, 167);
            this.textBoxD.Name = "textBoxD";
            this.textBoxD.Size = new System.Drawing.Size(200, 22);
            this.textBoxD.TabIndex = 4;
            // 
            // dateTimePicker1
            // 
            this.dateTimePicker1.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dateTimePicker1.Location = new System.Drawing.Point(205, 88);
            this.dateTimePicker1.Name = "dateTimePicker1";
            this.dateTimePicker1.Size = new System.Drawing.Size(200, 22);
            this.dateTimePicker1.TabIndex = 5;
            // 
            // dateTimePicker2
            // 
            this.dateTimePicker2.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dateTimePicker2.Location = new System.Drawing.Point(205, 116);
            this.dateTimePicker2.Name = "dateTimePicker2";
            this.dateTimePicker2.Size = new System.Drawing.Size(200, 22);
            this.dateTimePicker2.TabIndex = 6;
            // 
            // AdaugaEchipa
            // 
            this.AdaugaEchipa.Location = new System.Drawing.Point(348, 251);
            this.AdaugaEchipa.Name = "AdaugaEchipa";
            this.AdaugaEchipa.Size = new System.Drawing.Size(127, 57);
            this.AdaugaEchipa.TabIndex = 7;
            this.AdaugaEchipa.Text = "Adauga";
            this.AdaugaEchipa.UseVisualStyleBackColor = true;
            this.AdaugaEchipa.Click += new System.EventHandler(this.AdaugaEchipa_Click);
            // 
            // AdaugareCampionat
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(514, 334);
            this.Controls.Add(this.AdaugaEchipa);
            this.Controls.Add(this.dateTimePicker2);
            this.Controls.Add(this.dateTimePicker1);
            this.Controls.Add(this.textBoxD);
            this.Controls.Add(this.textBoxDC);
            this.Controls.Add(this.DetaliiCampionat);
            this.Controls.Add(this.DataCampionat);
            this.Controls.Add(this.DenumireCampionat);
            this.Name = "AdaugareCampionat";
            this.Text = "AdaugareCampionat";
            this.Load += new System.EventHandler(this.AdaugareCampionat_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label DenumireCampionat;
        private System.Windows.Forms.Label DataCampionat;
        private System.Windows.Forms.Label DetaliiCampionat;
        private System.Windows.Forms.TextBox textBoxDC;
        private System.Windows.Forms.TextBox textBoxD;
        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.DateTimePicker dateTimePicker2;
        private System.Windows.Forms.Button AdaugaEchipa;
    }
}