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
    public partial class Meci : Form
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\User\Desktop\proiect info\Campionat1\Campionat1\Database1.mdf;Integrated Security=True");
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand();
        string MECI, sub;
        private int ticks;
        public int gol1=0, gol2=0, c;

        void incarcaEchipe()
        {
            comboBoxEchipa1.Items.Clear();
            con.Open();
            cmd.CommandText = "select nume,nr_tricou from Jucator where id_echipa=(select id from Echipa where denumire='" + labelNumeEchipa1.Text + "') order by nume";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                {
                    comboBoxEchipa1.Items.Add(dr[0].ToString() + " " + dr[1].ToString());
                    comboBox1.Items.Add(dr[0].ToString() + " " + dr[1].ToString());
                }
            con.Close();

        }
        void incarcaEchipe1()
        {
            comboBoxEchipa2.Items.Clear();
            con.Open();
            cmd.CommandText = "select nume,nr_tricou from Jucator where id_echipa=(select id from Echipa where denumire='" + labelNumeEchipa2.Text + "') order by nume";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
                while (dr.Read())
                {
                    comboBoxEchipa2.Items.Add(dr[0].ToString() + " " + dr[1].ToString());
                    comboBox2.Items.Add(dr[0].ToString() + " " + dr[1].ToString());
                }
            con.Close();

        }
        public Meci(string meci)
        {

            MECI = meci.ToString();
            //labelNumeEchipa1 myLab = new Label();

            InitializeComponent();
            timer1.Start();
            string[] subs = MECI.Split('-');

            labelNumeEchipa1.Text = subs[0].ToString();
            labelNumeEchipa2.Text = subs[1].ToString();

        }


        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            ticks++;
            labelTimp.Text = ticks.ToString();

        }

        private void labelE1_Click(object sender, EventArgs e)
        {

        }

        private void buttonGolE1_Click(object sender, EventArgs e)
        {
            panelEchipa1.Show();
            incarcaEchipe();
        }

        private void buttonCartonasE1_Click(object sender, EventArgs e)
        {
            incarcaEchipe();
            panel1.Show();
        }

        private void panelEchipa1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panelEchipa2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void Meci_Load(object sender, EventArgs e)
        {
            cmd.Connection = con;
            panelEchipa1.Hide();
            panelEchipa2.Hide();
            panel1.Hide();
            panel2.Hide();
            labelnume.Hide();
            labelnumar.Hide();
            labelnumar2.Hide();
            labelnume2.Hide();
            labelnume3.Hide();
            labelnume4.Hide();
            labelnumar3.Hide();
            labelnumar4.Hide();
        }

        private void buttonGolE2_Click(object sender, EventArgs e)
        {
            incarcaEchipe1();
            panelEchipa2.Show();
        }

        private void buttonCartonasE2_Click(object sender, EventArgs e)
        {

            incarcaEchipe1();
            panel2.Show();
        }

        private void button1Confirmare_Click(object sender, EventArgs e)
        {
            if (comboBoxEchipa1.Text != "")
            {
                con.Open();
                cmd.CommandText = "insert into Gol(id_meci,minut,id_jucator)values((select id from meci where id_echipa1=(select id from Echipa where denumire='" + labelNumeEchipa1.Text + "') and id_echipa2=(select id from Echipa where denumire='" + labelNumeEchipa2.Text + "')),'" + labelTimp.Text + "',(select id from Jucator where nume='" + labelnume.Text + "' and nr_tricou='" + labelnumar.Text + "'))";
                cmd.ExecuteNonQuery();
                MessageBox.Show("Ai Reusit!", "Mesaj");
                con.Close();
                gol1++;
            }

            labelE1.Text = gol1.ToString();
            panelEchipa1.Hide();
        }

        private void button2Confirmare_Click(object sender, EventArgs e)
        {
            if (comboBoxEchipa2.Text != "")
            {
                con.Open();
                cmd.CommandText = "insert into Gol(id_meci,minut,id_jucator)values((select id from meci where id_echipa1=(select id from Echipa where denumire='" + labelNumeEchipa1.Text + "') and id_echipa2=(select id from Echipa where denumire='" + labelNumeEchipa2.Text + "')),'" + labelTimp.Text + "',(select id from Jucator where nume='" + labelnume2.Text + "' and nr_tricou='" + labelnumar2.Text + "'))";
                cmd.ExecuteNonQuery();
                MessageBox.Show("Ai Reusit!", "Mesaj");
                con.Close();
                gol2++;
            }

            labelE2.Text = gol2.ToString();
            panelEchipa2.Hide();
        }

        private void comboBoxEchipa1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string[] subs1 = comboBoxEchipa1.Text.Split(' ');
            labelnumar.Text = subs1[1].ToString();
            labelnume.Text = subs1[0].ToString();


        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            comboBox1.Items.Clear();
            if ((comboBox1.Text != "") && (comboBoxCuloare1.Text != ""))
            {
                con.Open();
                cmd.CommandText = "insert into Cartonas(culoare,id_jucator,id_meci,minut)values('" + comboBoxCuloare1.Text + "',(select id from Jucator where nume='" + labelnume3.Text + "' and nr_tricou='" + labelnumar3.Text + "'),(select id from meci where id_echipa1=(select id from Echipa where denumire='" + labelNumeEchipa1.Text + "') and id_echipa2=(select id from Echipa where denumire='" + labelNumeEchipa2.Text + "')),'" + labelTimp.Text + "')";
                cmd.ExecuteNonQuery();
                MessageBox.Show("Ai Reusit!", "Mesaj");
                con.Close();
            }
            panel1.Hide();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            comboBox2.Items.Clear();
            if ((comboBox2.Text != "") && (comboBoxCuloare2.Text != ""))
            {
                con.Open();
                cmd.CommandText = "insert into Cartonas(culoare,id_jucator,id_meci,minut)values('" + comboBoxCuloare2.Text + "',(select id from Jucator where nume='" + labelnume4.Text + "' and nr_tricou='" + labelnumar4.Text + "'),(select id from meci where id_echipa1=(select id from Echipa where denumire='" + labelNumeEchipa1.Text + "') and id_echipa2=(select id from Echipa where denumire='" + labelNumeEchipa2.Text + "')),'" + labelTimp.Text + "')";
                cmd.ExecuteNonQuery();
                MessageBox.Show("Ai Reusit!", "Mesaj");
                con.Close();
            }
            panel2.Hide();
        }

        private void labelnume_Click(object sender, EventArgs e)
        {

        }

        private void labelnumar_Click(object sender, EventArgs e)
        {

        }

        private void comboBoxEchipa2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string[] subs1 = comboBoxEchipa2.Text.Split(' ');
            labelnumar2.Text = subs1[1].ToString();
            labelnume2.Text = subs1[0].ToString();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string[] subs1 = comboBox1.Text.Split(' ');
            labelnumar3.Text = subs1[1].ToString();
            labelnume3.Text = subs1[0].ToString();

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string[] subs1 = comboBox2.Text.Split(' ');
            labelnumar4.Text = subs1[1].ToString();
            labelnume4.Text = subs1[0].ToString();

        }

        private void comboBoxCuloare1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void buttonPauza_Click(object sender, EventArgs e)
        {
            c++;
            if (c % 2 == 1)
                timer1.Stop();
            else
                timer1.Start();

        }

        private void buttonFinal_Click(object sender, EventArgs e)
        {
            timer1.Stop();
            if (gol1 > gol2)
            {
                {
                    con.Open();
                    cmd.CommandText = ("update Echipa set victorii = victorii + '"+1+"'where denumire='"+labelNumeEchipa1.Text+"'");
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = ("update Echipa set infrangeri = infrangeri+'" + 1 + "'where denumire='" + labelNumeEchipa2.Text + "'");
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = ("update Echipa set puncte=puncte + '" + 3 + "'where denumire='" + labelNumeEchipa1.Text + "'");
                    cmd.ExecuteNonQuery();
                    con.Close();
                   
                }
            }
                if (gol1 < gol2)
                {
                    con.Open();
                    cmd.CommandText = ("update Echipa set victorii=victorii+'" + 1 + "'where denumire='" + labelNumeEchipa2.Text + "'");
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = ("update Echipa set infrangeri=infrangeri+'" + 1 + "'where denumire='" + labelNumeEchipa1.Text + "'");
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = ("update Echipa set puncte=puncte+'" + 3 + "'where denumire='" + labelNumeEchipa2.Text + "'");
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                if(gol1 == gol2)
                {
  
                    
                        con.Open();
                        cmd.CommandText = ("update Echipa set egaluri=egaluri+'" + 1 + "'where denumire='" + labelNumeEchipa1.Text + "'");
                        cmd.ExecuteNonQuery();
                        cmd.CommandText = ("update Echipa set egaluri=egaluri+'" + 1 + "'where denumire='" + labelNumeEchipa2.Text + "'");
                        cmd.ExecuteNonQuery();
                        cmd.CommandText = ("update Echipa set puncte=puncte+'" + 1 + "'where denumire='" + labelNumeEchipa1.Text + "'");
                        cmd.ExecuteNonQuery();
                        cmd.CommandText = ("update Echipa set puncte=puncte+'" + 1 + "'where denumire='" + labelNumeEchipa2.Text + "'");
                        cmd.ExecuteNonQuery();
                        con.Close();

                    

                }
             

            
            con.Open();
            cmd.CommandText = ("update Meci set jucat=jucat+'" + 1 + "'where id_echipa1=(select id from Echipa where denumire='" + labelNumeEchipa1.Text + "') and id_echipa2=(select id from Echipa where denumire='"+labelNumeEchipa2.Text+"')");
            cmd.ExecuteNonQuery();
            con.Close();
            MessageBox.Show("Meciul s a sfarsit", "Mesaj");
            this.Close();
           
        }

        private void labelNumeEchipa2_Click(object sender, EventArgs e)
        {

        }
    }
    

}

