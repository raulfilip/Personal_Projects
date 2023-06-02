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
    public partial class VizualizareCampionat : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand();
        public VizualizareCampionat()
        {
            InitializeComponent();
        }
        void incarcaJucatori()
        {
            listBox1.Items.Clear();
            con.Open();
            cmd.CommandText = "select denumire,data,dataIncheiere from Campionat order by denumire";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                {
                    listBox1.Items.Add(dr[0].ToString() + " " + dr[1].ToString() + "-" + dr[2].ToString());

                }
            con.Close();

        }
        private void VizualizareCampionat_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            incarcaJucatori();
        }
    }
}
