using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class gold : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGold();
            }
        }

        private void LoadGold()
        {
            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT GoldId, Name, Price, ImageURL FROM Gold";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            rptGold.DataSource = dt;
                            rptGold.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error Loading Gold Items: " + ex.Message);
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                RepeaterItem item = (RepeaterItem)btn.NamingContainer;

                HiddenField hfGoldId = (HiddenField)item.FindControl("hfGoldId");
                Label lblPrice = (Label)item.FindControl("lblPrice");
                Label lblName = (Label)item.FindControl("lblName");

                if (hfGoldId != null && lblPrice != null && lblName != null)
                {
                    string productId = hfGoldId.Value;
                    string name = lblName.Text;
                    decimal price = Convert.ToDecimal(lblPrice.Text);
                    string productType = "Gold";
                    int quantity = 1;

                    string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        string query = @"INSERT INTO Cart1 (ProductId, ProductType, Name, Price, Quantity) 
                                         VALUES (@ProductId, @ProductType, @Name, @Price, @Quantity)";

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

                    // Redirect to Cart Page after adding
                    Response.Redirect("cart1.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Error: Could not find required controls.');</script>");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error Adding to Cart: " + ex.Message);
                Response.Write("<script>alert('An error occurred while adding to the cart. Please try again.');</script>");
            }
        }
    }
}