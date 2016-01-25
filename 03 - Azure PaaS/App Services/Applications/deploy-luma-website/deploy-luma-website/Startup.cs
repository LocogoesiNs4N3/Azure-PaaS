using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(deploy_luma_website.Startup))]
namespace deploy_luma_website
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
