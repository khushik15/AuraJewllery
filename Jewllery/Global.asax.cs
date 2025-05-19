using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace Jewllery
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Ensure routes and bundles are registered properly
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Handle application-level errors
            Exception exception = Server.GetLastError();
            // Log or handle error (you can add logging here)
        }
    }
}
