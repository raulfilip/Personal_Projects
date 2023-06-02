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
    public partial class Form3 : Form
    {
        SqlConnection con=new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand();

        void incarcaEchipe1()
        {
            comboBoxE1.Items.Clear();
            con.Open();
            cmd.CommandText = "select denumire from Echipa order by denumire";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                    if (dr[0].ToString() != comboBoxE2.Text)
                        comboBoxE1.Items.Add(dr[0].ToString());
            con.Close();
        }
        void incarcaEchipe2()
        {
            comboBoxE2.Items.Clear();
            con.Open();
            cmd.CommandText = "select denumire from Echipa order by denumire";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                {
                    if(dr[0].ToString()!=comboBoxE1.Text)
                        comboBoxE2.Items.Add(dr[0].ToString());
                }
                    
            con.Close();
        }
        void incarcaCampionat()
        {
            comboBoxC.Items.Clear();
            con.Open();
            cmd.CommandText = "select denumire from Campionat order by denumire";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                    comboBoxC.Items.Add(dr[0].ToString());
            con.Close();
        } 
        public Form3()
        {
            InitializeComponent();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            incarcaEchipe2();
        }

        private void Form3_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
            incarcaEchipe1();
            incarcaEchipe2();
            incarcaCampionat();
                 
        }

        private void buttonAdaugaM_Click(object sender, EventArgs e)
        {
            if (comboBoxE1.Text != "" && comboBoxE2.Text != "")
            {
                con.Open();
                cmd.CommandText = "insert into Meci(id_echipa1,id_echipa2,id_campionat,data,jucat)values((select id from Echipa where denumire='" + comboBoxE1.Text + "'),(select id from Echipa where denumire='" + comboBoxE2.Text + "'),(select id from Campionat where denumire='" + comboBoxC.Text + "'),'" + dateTimePicker1.Text + "','"+0+"')";
                cmd.ExecuteNonQuery();
                MessageBox.Show("Ai Reusit!", "Mesaj");
                con.Close();
            }
        }

        private void comboBoxE2_SelectedIndexChanged(object sender, EventArgs e)
        {
            incarcaEchipe1();
        }
    }
}
