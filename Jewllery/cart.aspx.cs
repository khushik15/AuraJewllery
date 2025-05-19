using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = @"
                        SELECT c.CartId, c.ProductId, c.ProductType, c.Quantity, 
                               CASE 
                                   WHEN c.ProductType = 'Ring' THEN r.Name 
                                   WHEN c.ProductType = 'Earring' THEN e.Name 
                                   WHEN c.ProductType = 'Chain' THEN ch.Name 
                                   WHEN c.ProductType = 'Mangalsutra' THEN m.Name 
                                   WHEN c.ProductType = 'Bracelet' THEN b.Name 
                                   WHEN c.ProductType = 'Pendant' THEN p.Name 
                               END AS Name, 
                               CASE 
                                   WHEN c.ProductType = 'Ring' THEN r.Price 
                                   WHEN c.ProductType = 'Earring' THEN e.Price 
                                   WHEN c.ProductType = 'Chain' THEN ch.Price 
                                   WHEN c.ProductType = 'Mangalsutra' THEN m.Price 
                                   WHEN c.ProductType = 'Bracelet' THEN b.Price 
                                   WHEN c.ProductType = 'Pendant' THEN p.Price 
                               END AS Price, 
                               CASE 
                                   WHEN c.ProductType = 'Ring' THEN r.ImageUrl 
                                   WHEN c.ProductType = 'Earring' THEN e.ImageUrl 
                                   WHEN c.ProductType = 'Chain' THEN ch.ImageUrl 
                                   WHEN c.ProductType = 'Mangalsutra' THEN m.ImageUrl 
                                   WHEN c.ProductType = 'Bracelet' THEN b.ImageUrl 
                                   WHEN c.ProductType = 'Pendant' THEN p.ImageUrl 
                               END AS ImageUrl
                        FROM Cart c
                        LEFT JOIN Rings r ON c.ProductId = r.RingId AND c.ProductType = 'Ring'
                        LEFT JOIN Earrings e ON c.ProductId = e.EarringId AND c.ProductType = 'Earring'
                        LEFT JOIN Chains ch ON c.ProductId = ch.ChainId AND c.ProductType = 'Chain'
                        LEFT JOIN Mangalsutra m ON c.ProductId = m.ID AND c.ProductType = 'Mangalsutra'
                        LEFT JOIN Bracelets b ON c.ProductId = b.BraceletId AND c.ProductType = 'Bracelet'
                        LEFT JOIN Pendants p ON c.ProductId = p.PendantId AND c.ProductType = 'Pendant'
                        WHERE c.UserId = @userId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@userId", userId);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvCart.DataSource = dt;
                        gvCart.DataBind();

                        // Calculate total price
                        decimal total = 0;
                        foreach (DataRow row in dt.Rows)
                        {
                            total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
                        }
                        lblTotalPrice.Text = "Total: ₹" + total.ToString("N2");
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error loading cart: " + ex.Message);
                }
            }
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int cartId = Convert.ToInt32(e.CommandArgument);
                string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    try
                    {
                        conn.Open();
                        string query = "DELETE FROM Cart WHERE CartId = @cartId";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@cartId", cartId);
                            cmd.ExecuteNonQuery();
                        }

                        LoadCart(); // Refresh cart
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Error removing item: " + ex.Message);
                    }
                }
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("checkout.aspx");
        }
    }
}
