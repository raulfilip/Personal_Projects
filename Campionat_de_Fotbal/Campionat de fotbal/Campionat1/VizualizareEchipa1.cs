using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Campionat1
{
    public partial class VizualizareEchipa1 : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand();
        void incarcaCampionat()
        {
           
        }
        public VizualizareEchipa1()
        {
            InitializeComponent();
        }

        private void VizualizareEchipa1_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
            incarcaCampionat();
            // TODO: This line of code loads data into the 'database1DataSet.Echipa' table. You can move, or remove it, as needed.
            this.echipaTableAdapter.Fill(this.database1DataSet.Echipa);

        }

        private void fillByToolStripButton_Click(object sender, EventArgs e)
        {
            try
            {
                this.echipaTableAdapter.FillBy(this.database1DataSet.Echipa);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
