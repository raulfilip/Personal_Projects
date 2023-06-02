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
     
    public partial class VizualizareJucator : Form
    {
        SqlConnection con=new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand();
        void incarcaEchipe()
        {
            comboBox1.Items.Clear();
            con.Open();
            cmd.CommandText = "select denumire from Echipa order by denumire";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                {
                    
                        comboBox1.Items.Add(dr[0].ToString());
                }
                    
            con.Close();
        }
        public VizualizareJucator()
        {
            InitializeComponent();
        }

        private void VizualizareJucator_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
            // TODO: This line of code loads data into the 'database1DataSet1.Jucator' table. You can move, or remove it, as needed.
            this.jucatorTableAdapter.Fill(this.database1DataSet1.Jucator);
            // TODO: This line of code loads data into the 'database1DataSet.Jucator' table. You can move, or remove it, as needed.
            this.jucatorTableAdapter.Fill(this.database1DataSet.Jucator);
            incarcaEchipe();

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void fillByToolStripButton_Click(object sender, EventArgs e)
        {
            try
            {
                this.jucatorTableAdapter.FillBy(this.database1DataSet.Jucator);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }

        }
        void incarcaJucatori()
        {
            listBox1.Items.Clear();
            con.Open();
            cmd.CommandText = "select nume,nr_tricou from Jucator where id_echipa=(select id from Echipa where denumire='" + comboBox1.Text + "') order by nume";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                {
                    listBox1.Items.Add(dr[0].ToString() + " " + dr[1].ToString());
                
                }
            con.Close();

        }
        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            incarcaJucatori();
        }
    }
}
