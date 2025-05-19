using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class adminOrders : System.Web.UI.Page
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
                string query = "SELECT OrderID, OrderDate, TotalAmount, PaymentStatus, ShippingStatus, EstimatedDeliveryDate FROM Orders";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int orderID = Convert.ToInt32(e.CommandArgument);

                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

                string newStatus = ddlStatus.SelectedValue;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string updateQuery = "UPDATE Orders SET ShippingStatus = @ShippingStatus WHERE OrderID = @OrderID";

                    SqlCommand cmd = new SqlCommand(updateQuery, conn);
                    cmd.Parameters.AddWithValue("@ShippingStatus", newStatus);
                    cmd.Parameters.AddWithValue("@OrderID", orderID);
                    cmd.ExecuteNonQuery();
                }

                // Reload orders after update
                LoadOrders();
            }
        }
    }
}
