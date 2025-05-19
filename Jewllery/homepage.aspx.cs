using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jewllery
{
    public partial class homepage : System.Web.UI.Page
    {
        protected void btnExplore_Click(object sender, EventArgs e)
        {
            Response.Redirect("products.aspx"); // Redirects to the Products page
        }
    }
}