using System;
using System.Data.SqlClient;
using System.Configuration;

namespace JewelleryWebsite
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // You can load other data if needed
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Orders (UserId, OrderDate, TotalAmount, PaymentStatus, ShippingStatus, Address) 
                                 VALUES (@UserId, GETDATE(), @TotalAmount, @PaymentStatus, @ShippingStatus, @Address)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", 1); // Replace with actual UserId
                    cmd.Parameters.AddWithValue("@TotalAmount", txtTotalAmount.Text);
                    cmd.Parameters.AddWithValue("@PaymentStatus", ddlPaymentStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@ShippingStatus", ddlShippingStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Order placed successfully!";
        }
    }
}
