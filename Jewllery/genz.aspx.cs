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
    public partial class genz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGenZ();
            }
        }

        private void LoadGenZ()
        {
            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT ID, Name, Price, ImageURL FROM GenZ";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptGenZ.DataSource = dt;
                        rptGenZ.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            // Ensure the required controls exist
            HiddenField hfGenZId = (HiddenField)item.FindControl("hfGenZId");
            Label lblPrice = (Label)item.FindControl("lblPrice");
            HtmlGenericControl lblName = (HtmlGenericControl)item.FindControl("lblName");

            if (hfGenZId != null && lblPrice != null && lblName != null)
            {
                string productId = hfGenZId.Value;
                string name = lblName.InnerText;
                decimal price = Convert.ToDecimal(lblPrice.Text);
                string productType = "GenZ";
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

                // Redirect to Cart Page after adding
                Response.Redirect("cart1.aspx");
            }
            else
            {
                Response.Write("<script>alert('Error: Could not find required controls.');</script>");
            }
        }
    }
}