using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class cart1 : System.Web.UI.Page
    {
        private string connectionString = @"Data Source=DESKTOP-GKJ8KIN;Initial Catalog=jewllery;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT CartId, ProductType, Name, Price, Quantity, (Price * Quantity) AS TotalPrice FROM Cart1";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewCart.DataSource = dt;
                GridViewCart.DataBind();

                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                {
                    total += Convert.ToDecimal(row["TotalPrice"]);
                }
                lblTotalAmount.Text = total.ToString("C");
            }
        }

        protected void GridViewCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int cartId;
            if (!int.TryParse(e.CommandArgument.ToString(), out cartId))
            {
                Response.Write("<script>alert('Error: Invalid CartId!');</script>");
                return;
            }

            if (e.CommandName == "UpdateQuantity")
            {
                try
                {
                    foreach (GridViewRow row in GridViewCart.Rows)
                    {
                        HiddenField hfCartId = (HiddenField)row.FindControl("hfCartId");
                        if (hfCartId != null && hfCartId.Value == cartId.ToString())
                        {
                            TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
                            if (txtQuantity != null)
                            {
                                int newQuantity;
                                if (!int.TryParse(txtQuantity.Text, out newQuantity) || newQuantity <= 0)
                                {
                                    Response.Write("<script>alert('Error: Invalid quantity entered!');</script>");
                                    return;
                                }

                                using (SqlConnection conn = new SqlConnection(connectionString))
                                {
                                    string query = "UPDATE Cart1 SET Quantity = @Quantity WHERE CartId = @CartId";
                                    using (SqlCommand cmd = new SqlCommand(query, conn))
                                    {
                                        cmd.Parameters.AddWithValue("@Quantity", newQuantity);
                                        cmd.Parameters.AddWithValue("@CartId", cartId);

                                        conn.Open();
                                        cmd.ExecuteNonQuery();
                                    }
                                }

                                LoadCart();
                                return;
                            }
                        }
                    }

                    Response.Write("<script>alert('Error: CartId not found in GridView!');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
            else if (e.CommandName == "RemoveItem")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "DELETE FROM Cart1 WHERE CartId = @CartId";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@CartId", cartId);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    Response.Write("<script>alert('Item removed successfully!');</script>");
                    LoadCart();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Check if cart is empty before checkout
                    string checkCartQuery = "SELECT COUNT(*) FROM Cart1";
                    using (SqlCommand checkCmd = new SqlCommand(checkCartQuery, conn))
                    {
                        int cartCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                        if (cartCount == 0)
                        {
                            Response.Write("<script>alert('Your cart is empty. Please add items before checkout.');</script>");
                            return;
                        }
                    }

                    // Redirect to checkout page instead of inserting orders here
                    Response.Redirect("checkout.aspx?fromCart=true");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error during checkout: " + ex.Message + "');</script>");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (Request.UrlReferrer != null)
            {
                Response.Redirect(Request.UrlReferrer.ToString()); // Redirects to the previous page
            }
            else
            {
                Response.Write("<script>alert('No previous page found.');</script>");
            }
        }
    }
}
