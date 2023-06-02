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
    public partial class t : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand();

        void incarcaEchipe()
        {
            comboBoxEchipaJ.Items.Clear();
            con.Open();
            cmd.CommandText = "select denumire from Echipa order by denumire";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                    comboBoxEchipaJ.Items.Add(dr[0].ToString());
            con.Close();

        }
        public t()
        {
            InitializeComponent();
        }

        private void t_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
            incarcaEchipe();
        }
        int echipaExista(string s, string s1)
        {
            con.Open();
            cmd.CommandText = "select nr_tricou,id_echipa from Jucator where nr_tricou='" + s + "'and id_echipa=(select id from Echipa where denumire='" + s1 + "')";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                con.Close();
                return 1;
            }
            con.Close();
            return 0;


        }
        private void buttonAdaugaJucatori_Click(object sender, EventArgs e)
        {
            if (textBoxNJ.Text != "" && textBoxNrT.Text != "")
                if (echipaExista(textBoxNrT.Text, comboBoxEchipaJ.Text) == 1)
                    MessageBox.Show("Datele nu sunt valide!");
                else
                {
                    con.Open();
                    cmd.CommandText = "insert into Jucator(nume,nr_tricou,id_echipa)values('" + textBoxNJ.Text + "','" + textBoxNrT.Text + "',(select id from Echipa where denumire='" + comboBoxEchipaJ.Text + "'))";
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Ai Reusit!", "Mesaj");
                    con.Close();
                }
        }

        private void comboBoxEchipaJ_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
