using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication11.Models;

namespace WebApplication11.Controllers
{
    public class NguoidungController : Controller
    {
        // GET: Nguoidung
        public ActionResult Index()
        {
            return View();
        }
        QLBANDOCHOIEntities1 db = new QLBANDOCHOIEntities1();
        public ActionResult Dangky()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Dangky(FormCollection collection ,KHACHHANG kh)
        {
            var hoten = collection["HotenKH"];
            var diachi = collection["DiachiKH"];
            var dienthoai = collection["DienthoaiKH"];
            var tendn = collection["TenDN"];
            var matkhau = collection["Matkhau"];
            var emai = collection["Email"];

            if (String.IsNullOrEmpty(hoten))
            {
                ViewData["Loi1"] = "Họ tên khách hàng không được để trống";
            }
            else if (String.IsNullOrEmpty(diachi))
            {
                ViewData["Loi2"] = "Không được để trống địa chỉ";
            }
            else if (String.IsNullOrEmpty(dienthoai))
            {
                ViewData["Loi3"] = "Phải nhập số điện thoại";
            }
            else if(String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi4"] = "Tên đăng nhập không được để trống";
            }
            else if(String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi5"] = "Phải nhập mật khẩu";
            }
            else if (String.IsNullOrEmpty(emai))
            {
                ViewData["Loi6"] = "Không được để trống Email";
            }
            else
            {
                kh.HotenKH = hoten;
                kh.DiachiKH = diachi;
                kh.DienthoaiKH = dienthoai;
                kh.TenDN = tendn;
                kh.Matkhau = matkhau;
                kh.Email = emai;
                db.KHACHHANGs.Add(kh);
                db.SaveChanges();
                return RedirectToAction("Dangnhap");
            }
            return this.Dangky();
        }
        [HttpGet]
        public ActionResult Dangnhap()
        {
            return View();
        }

        public ActionResult Dangnhap(FormCollection collection)
        {
            var tendn = collection["username"];
            var matkhau = collection["password"];
            if(String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Tên đăng nhập không được để trống";
            }
            else if(String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Mật khẩu không được để trống";
            }
                else
                {
                    KHACHHANG kh = db.KHACHHANGs.SingleOrDefault(n => n.TenDN == tendn && n.Matkhau == matkhau);
                    if(kh != null)
                    {
                        Session["Taikhoan"] = kh;
                        Session["MaKH"] = kh.MaKH.ToString();
                        Session["TenDN"] = kh.TenDN.ToString();
                        return RedirectToAction("Index", "TrangChu");
                    }
                    else
                    {
                        ViewBag.Thongbao = "Tên đăng nhập hoăc mật khẩu không đúng";
                    }
            }
            return View();
        }
        public ActionResult Dangxuat()
        {
            Session.Clear();
            Session.RemoveAll();
            return RedirectToAction("Index","TrangChu");
        }
    }
}