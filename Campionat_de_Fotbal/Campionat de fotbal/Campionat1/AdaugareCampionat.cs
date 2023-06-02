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
    public partial class AdaugareCampionat : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        public AdaugareCampionat()
        {
            InitializeComponent();
        }
        int CampionatExista(string s)
        {
            con.Open();
            cmd.CommandText = "select denumire from Campionat where denumire='" + s + "'";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                con.Close();
                return 1;
            }
            con.Close();
            return 0;


        }
        private void AdaugaEchipa_Click(object sender, EventArgs e)
        {
            if (textBoxDC.Text != "")
            {
                if (CampionatExista(textBoxDC.Text) == 1)
                    MessageBox.Show("Campionatul exista!");
                else
                {
                    con.Open();
                    cmd.CommandText = "insert into Campionat(denumire,data,detalii,dataIncheiere) values('" + textBoxDC.Text + "' , '"+dateTimePicker1.Text+"' , '"+textBoxD.Text+"' , '"+dateTimePicker2.Text+"')";
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Ai reusit!");
                    this.Close();

                }
                con.Close();
            }
           
        }

        private void AdaugareCampionat_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
        }
    }
}
