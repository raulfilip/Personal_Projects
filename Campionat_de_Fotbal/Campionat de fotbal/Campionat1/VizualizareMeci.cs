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
    public partial class VizualizareMeci : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand();
        string meci;
        void incarcaCampionat()
        {
            comboBox1.Items.Clear();
            con.Open();
            cmd.CommandText = "select denumire from Campionat order by denumire";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                    comboBox1.Items.Add(dr[0].ToString());
            con.Close();
        }
        void incarcaMeci()
        {
            comboBox2.Items.Clear();
            con.Open();
            cmd.CommandText = "select (select denumire from Echipa where id=id_echipa1), (select denumire from Echipa where id=id_echipa2) from Meci where jucat='0' order by id ";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                    comboBox2.Items.Add(dr[0].ToString()+"-"+dr[1].ToString());
            con.Close();
        }
        public VizualizareMeci()
        {
            InitializeComponent();
        }

        private void VizualizareMeci_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
            incarcaCampionat();
            incarcaMeci();

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Meci f = new Meci(comboBox2.Text);
            f.Show();
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}
