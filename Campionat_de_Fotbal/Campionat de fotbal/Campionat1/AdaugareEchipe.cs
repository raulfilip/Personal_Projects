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
    public partial class AdaugareEchipe : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        public AdaugareEchipe()
        {
            InitializeComponent();
        }
        int echipaExista(string s)
        {
            con.Open();
            cmd.CommandText = "select denumire from Echipa where denumire='" + s + "'";
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
            if (textBoxDE.Text != "")
            {
                if (echipaExista(textBoxDE.Text) == 1)
                    MessageBox.Show("Echipa exista!");
                else
                {
                    con.Open();
                    cmd.CommandText = "insert into Echipa(denumire,victorii,infrangeri,egaluri,puncte) values('" + textBoxDE.Text + "','"+0+"','"+0+"','"+0+"','"+0+"')";
                    cmd.ExecuteNonQuery();
                        MessageBox.Show("Ai reusit!");
                    
                }
                con.Close();
            }
           
            
        }

        private void AdaugareEchipe_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
        }
    }
}
