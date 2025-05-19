using System;
using System.Data.SqlClient;

namespace Jewllery
{
    public partial class orderConfirmation : System.Web.UI.Page
    {
        private string connectionString = @"Data Source=DESKTOP-GKJ8KIN;Initial Catalog=jewllery;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["OrderID"] != null)
                {
                    int orderID = Convert.ToInt32(Request.QueryString["OrderID"]);
                    LoadOrderDetails(orderID);
                }
            }
        }

        private void LoadOrderDetails(int orderID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT OrderID, TotalAmount, Address, ShippingOption, DeliveryMode, EstimatedDeliveryDate FROM Orders WHERE OrderID = @OrderID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@OrderID", orderID);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblOrderID.Text = reader["OrderID"].ToString();
                    lblTotalAmount.Text = "₹" + Convert.ToDecimal(reader["TotalAmount"]).ToString("N2");
                    lblShippingAddress.Text = reader["Address"].ToString();
                    lblShippingOption.Text = reader["ShippingOption"].ToString();
                    lblModeOfPayment.Text = reader["DeliveryMode"].ToString();

                    // ✅ Display Estimated Delivery Date
                    DateTime estimatedDelivery = Convert.ToDateTime(reader["EstimatedDeliveryDate"]);
                    lblDeliveryDate.Text = estimatedDelivery.ToString("dddd, dd MMMM yyyy"); // Format: Friday, 28 March 2025
                }
            }
        }

        // ✅ Redirect to Home Page
        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("homepage.aspx");  // Redirect to home or shopping page
        }

        // ✅ Redirect to My Orders Page
        protected void btnViewOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("myOrders.aspx"); // Redirect to Order History page
        }
    }
}
