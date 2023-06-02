namespace Campionat1
{
    partial class VizualizareEchipa1
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
            this.components = new System.ComponentModel.Container();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.idDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.denumireDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.victoriiDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.infrangeriDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.egaluriDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.puncteDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.echipaBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.database1DataSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.database1DataSet = new Campionat1.Database1DataSet();
            this.echipaTableAdapter = new Campionat1.Database1DataSetTableAdapters.EchipaTableAdapter();
            this.database1DataSet1 = new Campionat1.Database1DataSet();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.echipaBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.database1DataSetBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.database1DataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.database1DataSet1)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AllowUserToOrderColumns = true;
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn,
            this.denumireDataGridViewTextBoxColumn,
            this.victoriiDataGridViewTextBoxColumn,
            this.infrangeriDataGridViewTextBoxColumn,
            this.egaluriDataGridViewTextBoxColumn,
            this.puncteDataGridViewTextBoxColumn});
            this.dataGridView1.DataSource = this.echipaBindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(12, 101);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(854, 260);
            this.dataGridView1.TabIndex = 1;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // idDataGridViewTextBoxColumn
            // 
            this.idDataGridViewTextBoxColumn.DataPropertyName = "Id";
            this.idDataGridViewTextBoxColumn.HeaderText = "Id";
            this.idDataGridViewTextBoxColumn.Name = "idDataGridViewTextBoxColumn";
            this.idDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // denumireDataGridViewTextBoxColumn
            // 
            this.denumireDataGridViewTextBoxColumn.DataPropertyName = "denumire";
            this.denumireDataGridViewTextBoxColumn.HeaderText = "denumire";
            this.denumireDataGridViewTextBoxColumn.Name = "denumireDataGridViewTextBoxColumn";
            this.denumireDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // victoriiDataGridViewTextBoxColumn
            // 
            this.victoriiDataGridViewTextBoxColumn.DataPropertyName = "victorii";
            this.victoriiDataGridViewTextBoxColumn.HeaderText = "victorii";
            this.victoriiDataGridViewTextBoxColumn.Name = "victoriiDataGridViewTextBoxColumn";
            this.victoriiDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // infrangeriDataGridViewTextBoxColumn
            // 
            this.infrangeriDataGridViewTextBoxColumn.DataPropertyName = "infrangeri";
            this.infrangeriDataGridViewTextBoxColumn.HeaderText = "infrangeri";
            this.infrangeriDataGridViewTextBoxColumn.Name = "infrangeriDataGridViewTextBoxColumn";
            this.infrangeriDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // egaluriDataGridViewTextBoxColumn
            // 
            this.egaluriDataGridViewTextBoxColumn.DataPropertyName = "egaluri";
            this.egaluriDataGridViewTextBoxColumn.HeaderText = "egaluri";
            this.egaluriDataGridViewTextBoxColumn.Name = "egaluriDataGridViewTextBoxColumn";
            this.egaluriDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // puncteDataGridViewTextBoxColumn
            // 
            this.puncteDataGridViewTextBoxColumn.DataPropertyName = "puncte";
            this.puncteDataGridViewTextBoxColumn.HeaderText = "puncte";
            this.puncteDataGridViewTextBoxColumn.Name = "puncteDataGridViewTextBoxColumn";
            this.puncteDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // echipaBindingSource
            // 
            this.echipaBindingSource.DataMember = "Echipa";
            this.echipaBindingSource.DataSource = this.database1DataSetBindingSource;
            // 
            // database1DataSetBindingSource
            // 
            this.database1DataSetBindingSource.DataSource = this.database1DataSet;
            this.database1DataSetBindingSource.Position = 0;
            // 
            // database1DataSet
            // 
            this.database1DataSet.DataSetName = "Database1DataSet";
            this.database1DataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // echipaTableAdapter
            // 
            this.echipaTableAdapter.ClearBeforeFill = true;
            // 
            // database1DataSet1
            // 
            this.database1DataSet1.DataSetName = "Database1DataSet";
            this.database1DataSet1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // VizualizareEchipa1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1022, 373);
            this.Controls.Add(this.dataGridView1);
            this.Name = "VizualizareEchipa1";
            this.Text = "VizualizareEchipa1";
            this.Load += new System.EventHandler(this.VizualizareEchipa1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.echipaBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.database1DataSetBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.database1DataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.database1DataSet1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private Database1DataSet database1DataSet;
        private System.Windows.Forms.BindingSource database1DataSetBindingSource;
        private System.Windows.Forms.BindingSource echipaBindingSource;
        private Database1DataSetTableAdapters.EchipaTableAdapter echipaTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn denumireDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn victoriiDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn infrangeriDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn egaluriDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn puncteDataGridViewTextBoxColumn;
        private Database1DataSet database1DataSet1;
    }
}