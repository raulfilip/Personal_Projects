namespace Campionat1
{
    partial class t
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
            this.labelNume = new System.Windows.Forms.Label();
            this.labelNrTricou = new System.Windows.Forms.Label();
            this.labelEchipa = new System.Windows.Forms.Label();
            this.textBoxNJ = new System.Windows.Forms.TextBox();
            this.textBoxNrT = new System.Windows.Forms.TextBox();
            this.buttonAdaugaJucatori = new System.Windows.Forms.Button();
            this.comboBoxEchipaJ = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // labelNume
            // 
            this.labelNume.AutoSize = true;
            this.labelNume.Location = new System.Drawing.Point(35, 44);
            this.labelNume.Name = "labelNume";
            this.labelNume.Size = new System.Drawing.Size(45, 17);
            this.labelNume.TabIndex = 0;
            this.labelNume.Text = "Nume";
            // 
            // labelNrTricou
            // 
            this.labelNrTricou.AutoSize = true;
            this.labelNrTricou.Location = new System.Drawing.Point(33, 87);
            this.labelNrTricou.Name = "labelNrTricou";
            this.labelNrTricou.Size = new System.Drawing.Size(50, 17);
            this.labelNrTricou.TabIndex = 1;
            this.labelNrTricou.Text = "Numar";
            // 
            // labelEchipa
            // 
            this.labelEchipa.AutoSize = true;
            this.labelEchipa.Location = new System.Drawing.Point(33, 136);
            this.labelEchipa.Name = "labelEchipa";
            this.labelEchipa.Size = new System.Drawing.Size(51, 17);
            this.labelEchipa.TabIndex = 2;
            this.labelEchipa.Text = "Echipa";
            // 
            // textBoxNJ
            // 
            this.textBoxNJ.Location = new System.Drawing.Point(198, 44);
            this.textBoxNJ.Name = "textBoxNJ";
            this.textBoxNJ.Size = new System.Drawing.Size(153, 22);
            this.textBoxNJ.TabIndex = 3;
            // 
            // textBoxNrT
            // 
            this.textBoxNrT.Location = new System.Drawing.Point(198, 87);
            this.textBoxNrT.Name = "textBoxNrT";
            this.textBoxNrT.Size = new System.Drawing.Size(153, 22);
            this.textBoxNrT.TabIndex = 4;
            // 
            // buttonAdaugaJucatori
            // 
            this.buttonAdaugaJucatori.Location = new System.Drawing.Point(207, 220);
            this.buttonAdaugaJucatori.Name = "buttonAdaugaJucatori";
            this.buttonAdaugaJucatori.Size = new System.Drawing.Size(144, 54);
            this.buttonAdaugaJucatori.TabIndex = 6;
            this.buttonAdaugaJucatori.Text = "Adauga";
            this.buttonAdaugaJucatori.UseVisualStyleBackColor = true;
            this.buttonAdaugaJucatori.Click += new System.EventHandler(this.buttonAdaugaJucatori_Click);
            // 
            // comboBoxEchipaJ
            // 
            this.comboBoxEchipaJ.FormattingEnabled = true;
            this.comboBoxEchipaJ.Location = new System.Drawing.Point(198, 133);
            this.comboBoxEchipaJ.Name = "comboBoxEchipaJ";
            this.comboBoxEchipaJ.Size = new System.Drawing.Size(153, 24);
            this.comboBoxEchipaJ.TabIndex = 7;
            this.comboBoxEchipaJ.SelectedIndexChanged += new System.EventHandler(this.comboBoxEchipaJ_SelectedIndexChanged);
            // 
            // t
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(470, 350);
            this.Controls.Add(this.comboBoxEchipaJ);
            this.Controls.Add(this.buttonAdaugaJucatori);
            this.Controls.Add(this.textBoxNrT);
            this.Controls.Add(this.textBoxNJ);
            this.Controls.Add(this.labelEchipa);
            this.Controls.Add(this.labelNrTricou);
            this.Controls.Add(this.labelNume);
            this.Name = "t";
            this.Text = "AdaugareJucatori";
            this.Load += new System.EventHandler(this.t_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelNume;
        private System.Windows.Forms.Label labelNrTricou;
        private System.Windows.Forms.Label labelEchipa;
        private System.Windows.Forms.TextBox textBoxNJ;
        private System.Windows.Forms.TextBox textBoxNrT;
        private System.Windows.Forms.Button buttonAdaugaJucatori;
        private System.Windows.Forms.ComboBox comboBoxEchipaJ;
    }
}