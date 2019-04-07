using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebApplication11.Startup))]
namespace WebApplication11
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
