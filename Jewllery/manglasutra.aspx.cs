using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class manglasutra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMangalsutras();
            }
        }

        private void LoadMangalsutras()
        {
            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT ID, Name, Material, Price, ImageURL FROM Mangalsutra"; // FIXED COLUMN NAMES
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptMangalsutra.DataSource = dt;
                    rptMangalsutra.DataBind();
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            // Find controls inside Repeater
            HiddenField hfProductId = (HiddenField)item.FindControl("hfProductId");
            Label lblPrice = (Label)item.FindControl("lblPrice");
            Literal litName = (Literal)item.FindControl("litName");

            if (hfProductId != null && lblPrice != null && litName != null)
            {
                string productId = hfProductId.Value;
                string name = litName.Text;
                decimal price = Convert.ToDecimal(lblPrice.Text);

                string productType = "Mangalsutra";
                int quantity = 1;

                string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "INSERT INTO Cart1 (ProductId, ProductType, Name, Price, Quantity) " +
                                   "VALUES (@ProductId, @ProductType, @Name, @Price, @Quantity)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        cmd.Parameters.AddWithValue("@ProductType", productType);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Quantity", quantity);

                        cmd.ExecuteNonQuery();
                    }
                }

                // Redirect to Cart Page
                Response.Redirect("cart1.aspx");
            }
            else
            {
                Response.Write("<script>alert('Error: Could not find required controls.');</script>");
            }
        }
    }
}





