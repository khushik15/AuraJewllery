using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Ensures the logic runs only once on initial page load
            {
                if (Session["UserId"] != null)
                {
                    if (Request.QueryString["forceLogin"] == null)
                    {
                        Response.Redirect("homepage.aspx", false);
                        Context.ApplicationInstance.CompleteRequest(); // Prevents further execution
                    }
                }
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash = sha256.ComputeHash(bytes);
                return BitConverter.ToString(hash).Replace("-", "").ToLower();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "emptyFields", "alert('Username and Password cannot be empty.');", true);
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            string hashedPassword = HashPassword(password);

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "SELECT UserId, Name FROM users1 WHERE Name = @username AND PasswordHash = @passwordHash";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@passwordHash", hashedPassword);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Session["UserId"] = reader["UserId"].ToString();
                                Session["username"] = reader["Name"].ToString();

                                // Check if returnUrl exists
                                string returnUrl = Request.QueryString["returnUrl"];
                                if (!string.IsNullOrEmpty(returnUrl))
                                {
                                    Response.Redirect(returnUrl, false);
                                }
                                else
                                {
                                    Response.Redirect("homepage.aspx", false);
                                }
                                Context.ApplicationInstance.CompleteRequest();
                            }
                            else
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "loginFail", "alert('Invalid username or password!');", true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "dbError", $"alert('Database error: {ex.Message}');", true);
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtRegName.Text.Trim();
            string email = txtRegEmail.Text.Trim();
            string password = txtRegPassword.Text.Trim();
            string phone = txtRegPhone.Text.Trim();
            string address = txtRegAddress.Text.Trim(); // Added Address Field

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(address))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "emptyFields", "alert('All fields are required.');", true);
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["JewelleryDB"].ConnectionString;
            string hashedPassword = HashPassword(password); // Hash password before storing

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "INSERT INTO users1 (Name, Email, PasswordHash, Phone, Address) VALUES (@name, @email, @passwordHash, @phone, @address)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@passwordHash", hashedPassword);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@address", address); // Store address

                        cmd.ExecuteNonQuery();

                        ClientScript.RegisterStartupScript(this.GetType(), "registerSuccess", "alert('Registration successful! You can now log in.'); toggleForms(false);", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "dbError", $"alert('Database error: {ex.Message}');", true);
            }
        }
    }
}
