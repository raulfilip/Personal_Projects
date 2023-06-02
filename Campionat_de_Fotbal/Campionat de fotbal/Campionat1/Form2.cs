using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Campionat1
{
    public partial class Form2 : Form
    {

        public Form2()
        {
            InitializeComponent();
        }

        private void echipaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AdaugareEchipe f = new AdaugareEchipe();
            f.Show();
        }

        private void campionatToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AdaugareCampionat f = new AdaugareCampionat();
            f.Show();
        }

        private void jucatoriToolStripMenuItem_Click(object sender, EventArgs e)
        {
            t f = new t();
            f.Show();
        }

        private void meciToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form3 f = new Form3();
            f.Show();
        }

        private void meciToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            VizualizareMeci f = new VizualizareMeci();
            f.Show();
        }

        private void campionatToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            VizualizareCampionat f = new VizualizareCampionat();
            f.Show();
        }

        private void jucatorToolStripMenuItem_Click(object sender, EventArgs e)
        {
            VizualizareJucator f = new VizualizareJucator();
            f.Show();
        }

        private void echipaToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            VizualizareEchipa1 f = new VizualizareEchipa1();
            f.Show();
        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }
    }
}
