using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TheExplorer.Startup))]
namespace TheExplorer
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
