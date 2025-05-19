using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery.images
{
    public partial class mangalsutra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMangalsutra();
            }
        }

        private void LoadMangalsutra()
        {
            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT ID, Name, Material, Price, ImageURL FROM Mangalsutra";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptMangalsutra.DataSource = dt;
                rptMangalsutra.DataBind();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int mangalsutraId = Convert.ToInt32(btn.CommandArgument);

            DataTable cart1;
            if (Session["Cart1"] == null)
            {
                cart1 = new DataTable();
                cart1.Columns.Add("ID", typeof(int));
                cart1.Columns.Add("Name", typeof(string));
                cart1.Columns.Add("Material", typeof(string));
                cart1.Columns.Add("Price", typeof(decimal));
                cart1.Columns.Add("Quantity", typeof(int));
                Session["Cart"] = cart1;
            }
            else
            {
                cart1 = (DataTable)Session["Cart1"];
            }

            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT Name, Material, Price FROM Mangalsutra WHERE ID = @ID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", mangalsutraId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        DataRow row = cart1.NewRow();
                        row["ID"] = mangalsutraId;
                        row["Name"] = reader["Name"].ToString();
                        row["Material"] = reader["Material"].ToString();
                        row["Price"] = Convert.ToDecimal(reader["Price"]);
                        row["Quantity"] = 1;
                        cart1.Rows.Add(row);
                        Session["Cart1"] = cart1;
                    }
                }
            }
        }
    }
}