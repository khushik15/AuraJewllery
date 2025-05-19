using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class checkout : System.Web.UI.Page
    {
        private string connectionString = @"Data Source=DESKTOP-GKJ8KIN;Initial Catalog=jewllery;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT CartId, ProductType, Name, Price, Quantity, (Price * Quantity) AS TotalPrice FROM Cart1";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvCheckout.DataSource = dt;
                gvCheckout.DataBind();

                // Calculate total amount
                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                {
                    total += Convert.ToDecimal(row["TotalPrice"]);
                }
                lblTotalAmount.Text = "₹" + total.ToString("N2");
                ViewState["TotalAmount"] = total; // Store total for later use
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            // Ensure all required fields are filled
            if (string.IsNullOrWhiteSpace(txtFullName.Text) ||
                string.IsNullOrWhiteSpace(txtAddress.Text) ||
                string.IsNullOrWhiteSpace(txtPhone.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                rblShippingOptions.SelectedItem == null || // Ensure shipping option is selected
                rblDeliveryMode.SelectedItem == null) // Ensure delivery mode is selected
            {
                Response.Write("<script>alert('Please fill in all details and select shipping/delivery options.');</script>");
                return;
            }

            string fullName = txtFullName.Text;
            string address = txtAddress.Text;
            string phone = txtPhone.Text;
            string email = txtEmail.Text;
            string shippingOption = rblShippingOptions.SelectedValue; // Get shipping option
            string deliveryMode = rblDeliveryMode.SelectedValue; // Get delivery mode (COD)
            decimal totalAmount = (decimal)ViewState["TotalAmount"];
            int userId = 1; // Replace with actual logged-in user ID
            int OrderID = 0; // Declare OrderID

            // ✅ Calculate Estimated Delivery Date
            DateTime estimatedDeliveryDate = DateTime.Now;
            if (shippingOption == "Express")
            {
                totalAmount += 150; // Add express shipping charge
                estimatedDeliveryDate = DateTime.Now.AddDays(2); // Express Delivery: 1-2 Days
            }
            else
            {
                estimatedDeliveryDate = DateTime.Now.AddDays(5); // Free Shipping: 3-5 Days
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // ✅ Insert order with Estimated Delivery Date
                string insertOrderQuery = @"INSERT INTO Orders 
                    (UserId, OrderDate, TotalAmount, PaymentStatus, ShippingStatus, Address, ShippingOption, DeliveryMode, EstimatedDeliveryDate) 
                    OUTPUT INSERTED.OrderID 
                    VALUES (@UserId, GETDATE(), @TotalAmount, 'Pending', 'Processing', @Address, @ShippingOption, @DeliveryMode, @EstimatedDeliveryDate)";

                SqlCommand cmd = new SqlCommand(insertOrderQuery, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@ShippingOption", shippingOption);
                cmd.Parameters.AddWithValue("@DeliveryMode", deliveryMode);
                cmd.Parameters.AddWithValue("@EstimatedDeliveryDate", estimatedDeliveryDate);

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    OrderID = Convert.ToInt32(result); // Assign result to OrderID
                }
                else
                {
                    Response.Write("<script>alert('Error: Order not created.');</script>");
                    return;
                }
            }

            // Redirect to order confirmation page with OrderID
            Response.Redirect("orderConfirmation.aspx?OrderID=" + OrderID);
        }

        protected void rblShippingOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            decimal totalAmount = (decimal)ViewState["TotalAmount"];

            if (rblShippingOptions.SelectedValue == "Express")
            {
                totalAmount += 150; // Add express shipping charge
                shippingBill.Visible = true;
            }
            else
            {
                shippingBill.Visible = false;
            }

            lblFinalAmount.Text = "₹" + totalAmount.ToString("N2");
        }
    }
}
