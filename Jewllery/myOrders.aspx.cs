using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class myOrders : System.Web.UI.Page
    {
        private string connectionString = @"Data Source=DESKTOP-GKJ8KIN;Initial Catalog=jewllery;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT OrderID, OrderDate, TotalAmount, PaymentStatus, ShippingStatus, EstimatedDeliveryDate FROM Orders WHERE UserId = @UserId ORDER BY OrderDate DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", 1); // Replace with actual logged-in user ID

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptOrders.DataSource = dt;
                rptOrders.DataBind();
            }
        }
        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CancelOrder")
            {
                try
                {
                    int orderID = Convert.ToInt32(e.CommandArgument);

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string deleteQuery = "DELETE FROM Orders WHERE OrderID = @OrderID AND ShippingStatus = 'Ordered'";


                        using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@OrderID", orderID);
                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "orderCanceled", "alert('Order canceled successfully!');", true);
                            }
                            else
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "cannotCancel", "alert('You cannot cancel this order because it has already been processed.');", true);
                            }
                        }
                    }

                    // Reload the updated orders
                    LoadOrders();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }


        protected void btnBackToShop_Click(object sender, EventArgs e)
        {
            Response.Redirect("homepage.aspx");
        }
    }
}
