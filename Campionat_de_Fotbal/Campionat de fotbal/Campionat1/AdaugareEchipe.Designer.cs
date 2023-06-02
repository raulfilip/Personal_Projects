namespace Campionat1
{
    partial class AdaugareEchipe
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
            this.AdaugaEchipa = new System.Windows.Forms.Button();
            this.Denumire = new System.Windows.Forms.Label();
            this.textBoxDE = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // AdaugaEchipa
            // 
            this.AdaugaEchipa.Location = new System.Drawing.Point(305, 252);
            this.AdaugaEchipa.Name = "AdaugaEchipa";
            this.AdaugaEchipa.Size = new System.Drawing.Size(114, 56);
            this.AdaugaEchipa.TabIndex = 0;
            this.AdaugaEchipa.Text = "Adauga";
            this.AdaugaEchipa.UseVisualStyleBackColor = true;
            this.AdaugaEchipa.Click += new System.EventHandler(this.AdaugaEchipa_Click);
            // 
            // Denumire
            // 
            this.Denumire.AutoSize = true;
            this.Denumire.Location = new System.Drawing.Point(84, 82);
            this.Denumire.Name = "Denumire";
            this.Denumire.Size = new System.Drawing.Size(116, 17);
            this.Denumire.TabIndex = 1;
            this.Denumire.Text = "Denumire Echipa";
            // 
            // textBoxDE
            // 
            this.textBoxDE.Location = new System.Drawing.Point(254, 82);
            this.textBoxDE.Name = "textBoxDE";
            this.textBoxDE.Size = new System.Drawing.Size(165, 22);
            this.textBoxDE.TabIndex = 2;
            // 
            // AdaugareEchipe
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(500, 358);
            this.Controls.Add(this.textBoxDE);
            this.Controls.Add(this.Denumire);
            this.Controls.Add(this.AdaugaEchipa);
            this.Name = "AdaugareEchipe";
            this.Text = "Adaugare Echipe";
            this.Load += new System.EventHandler(this.AdaugareEchipe_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button AdaugaEchipa;
        private System.Windows.Forms.Label Denumire;
        private System.Windows.Forms.TextBox textBoxDE;
    }
}