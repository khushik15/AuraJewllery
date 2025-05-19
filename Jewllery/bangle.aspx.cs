using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class bangle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBangles();
            }
        }

        private void LoadBangles()
        {
            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT BangleId, Name, Material, Price, ImageUrl FROM Bangles";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptBangles.DataSource = dt;
                    rptBangles.DataBind();
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            // Ensure the required controls exist
            HiddenField hfProductId = (HiddenField)item.FindControl("hfProductId");
            Label lblPrice = (Label)item.FindControl("lblPrice");
            HtmlGenericControl lblName = (HtmlGenericControl)item.FindControl("lblName");

            if (hfProductId != null && lblPrice != null && lblName != null)
            {
                string productId = hfProductId.Value;
                string name = lblName.InnerText;
                decimal price = Convert.ToDecimal(lblPrice.Text);

                string productType = "Bangle"; // This is specific to this page
                int quantity = 1;
                decimal totalPrice = price * quantity;

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
                // Debugging error message
                Response.Write("<script>alert('Error: Could not find required controls.');</script>");
            }
        }
    }
}
