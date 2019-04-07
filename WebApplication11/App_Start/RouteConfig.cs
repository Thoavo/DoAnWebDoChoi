using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace WebApplication11
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.IgnoreRoute("{*botdetect}",
                new { botdetect = @"(.*)BotDetectCaptcha\.ashx" });

            //routes.MapRoute(
            //    name: "Default",
            //    url: "{controller}/{action}/{id}",
            //    defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            //);

            routes.MapRoute(
                name: "Dangnhap",
                url: "dang-nhap",
                defaults: new { controller = "Nguoidung", action = "Dangnhap", id = UrlParameter.Optional },
                namespaces: new[] { "WebApplication11.Controllers" }
            );

            routes.MapRoute(
        name: "Dangky",
        url: "dang-ky",
        defaults: new { controller = "Nguoidung", action = "Dangky", id = UrlParameter.Optional },
        namespaces: new[] { "WebApplication11.Controllers" }
        );
            routes.MapRoute(
       name: "Chude",
       url: "chu-de",
       defaults: new { controller = "TrangChu", action = "Chude", id = UrlParameter.Optional },
       namespaces: new[] { "WebApplication11.Controllers" }
        );

            routes.MapRoute(
       name: "SPTheochude",
       url: "sp-chu-de",
       defaults: new { controller = "TrangChu", action = "SPTheochude", id = UrlParameter.Optional },
       namespaces: new[] { "WebApplication11.Controllers" }
        );

            routes.MapRoute(
       name: "Thuonghieu",
       url: "thuong-hieu",
       defaults: new { controller = "TrangChu", action = "Thuonghieu", id = UrlParameter.Optional },
       namespaces: new[] { "WebApplication11.Controllers" }
        );

            routes.MapRoute(
       name: "SPTheothuonghieu",
       url: "sp-thuong-hieu",
       defaults: new { controller = "TrangChu", action = "SPTheothuonghieu", id = UrlParameter.Optional },
       namespaces: new[] { "WebApplication11.Controllers" }
        );

            routes.MapRoute(
       name: "GioHangPartial",
       url: "gio-hang-par",
       defaults: new { controller = "Giohang", action = "GioHangPartial", id = UrlParameter.Optional },
       namespaces: new[] { "WebApplication11.Controllers" }
        );

            routes.MapRoute(
      name: "GioHang",
      url: "gio-hang",
      defaults: new { controller = "Giohang", action = "GioHang", id = UrlParameter.Optional },
      namespaces: new[] { "WebApplication11.Controllers" }
       );

            routes.MapRoute(
      name: "DatHang",
      url: "dat-hang",
      defaults: new { controller = "Giohang", action = "Dathang", id = UrlParameter.Optional },
      namespaces: new[] { "WebApplication11.Controllers" }
       );

            routes.MapRoute(
      name: "Xacnhandonhang",
      url: "xac-nhan-don-hang",
      defaults: new { controller = "Giohang", action = "Xacnhandonhang", id = UrlParameter.Optional },
      namespaces: new[] { "WebApplication11.Controllers" }
       );

            routes.MapRoute(
      name: "Details",
      url: "chi-tiet/{metatitle}-{id}",
      defaults: new { controller = "TrangChu", action = "Details", id = UrlParameter.Optional },
      namespaces: new[] { "WebApplication11.Controllers" }
       );

            routes.MapRoute(
      name: "Lienhe",
      url: "lien-he",
      defaults: new { controller = "TrangChu", action = "Lienhe", id = UrlParameter.Optional },
      namespaces: new[] { "WebApplication11.Controllers" }
       );


            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "TrangChu", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "WebApplication11.Controllers" }
            );

        }

    }
}
