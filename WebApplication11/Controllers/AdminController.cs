using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication11.Models;
using PagedList;
using PagedList.Mvc;
using System.IO;

namespace WebApplication11.Controllers
{
    public class AdminController : Controller
    {
        QLBANDOCHOIEntities1 db = new QLBANDOCHOIEntities1();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }


        //----------------------------------------------------------------------------------//
        //-----------------------------------LOGIN------------------------------------------//
        //----------------------------------------------------------------------------------//

        public ActionResult QLAccAdmin(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.Admins.ToList().OrderBy(n => n.UserID).ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(/*Admin adm*/FormCollection collection)
        {
            //using (OurDBContext db = new OurDBContext())
            //{

            //    var usad = db.adminUser.SingleOrDefault(u => u.UserAdmin == adm.UserAdmin && u.PassAdmin == adm.PassAdmin);
            //    if (usad != null)
            //    {
            //        Session["UserID"] = usad.UserID.ToString();
            //        Session["UserAdmin"] = usad.UserAdmin.ToString();
            //        return RedirectToAction("Index", "Admin");
            //    }
            //    else
            //    {
            //        ModelState.AddModelError("", "Loi tai khoan va mat khau");
            //    }
            //}
            //return View();
            var id = collection["id"];
            var tendn = collection["username"];
            var matkhau = collection["password"];
            if (String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "Hãy nhập tên tài khoản";
            }
            if (String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi1"] = "Hãy nhập mật khẩu tài khoản";
            }
            else
            {
                Admin ad = db.Admins.SingleOrDefault(n => n.UserAdmin == tendn && n.PassAdmin == matkhau);
                if (ad != null)
                {
                    Session["UserID"] = ad.UserID.ToString();
                    Session["UserAdmin"] = ad.UserAdmin.ToString();
                    return RedirectToAction("Index","Admin");
                }
                else
                    ViewBag.Thongbao = "Tên đăng nhập mật khẩu không chính xác";
            }
            return View();
        }

        //----------------------------------------------------------------------------------//
        //-----------------------------------DOCHOI-----------------------------------------//
        //----------------------------------------------------------------------------------//
        public ActionResult Dochoi(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.DOCHOIs.ToList().OrderBy(n => n.MaDC).ToPagedList(pageNumber, pageSize));
            //return View(db.DOCHOIs.ToList());
        }

        [HttpGet]
        public ActionResult Themmoidochoi()
        {
            ViewBag.MaCD = new SelectList(db.CHUDEs.ToList().OrderBy(n => n.Tenchude), "MaCD", "Tenchude");
            ViewBag.MaTH = new SelectList(db.THUONGHIEUx.ToList().OrderBy(n => n.Tenthuonghieu), "MaTH", "Tenthuonghieu");
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themmoidochoi(DOCHOI dochoi, HttpPostedFileBase fileUpload)
        {
            ViewBag.MaCD = new SelectList(db.CHUDEs.ToList().OrderBy(n => n.Tenchude), "MaCD", "Tenchude");
            ViewBag.MaTH = new SelectList(db.THUONGHIEUx.ToList().OrderBy(n => n.Tenthuonghieu), "MaTH", "Tenthuonghieu");
            if (fileUpload == null)
            {
                ViewBag.Thongbao = "Hãy chọn ảnh sản phẩm";
                return View();
            }
            else
            {
                if (ModelState.IsValid)
                {
                    var fileName = Path.GetFileName(fileUpload.FileName);
                    var path = Path.Combine(Server.MapPath("~/images"), fileName);
                    if (System.IO.File.Exists(path))
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    else
                    {
                        fileUpload.SaveAs(path);
                    }
                    dochoi.Hinhminhhoa = fileUpload.FileName;
                    db.DOCHOIs.Add(dochoi);
                    db.SaveChanges();

                }
               
                return RedirectToAction("Dochoi");
            }        
        }

        public ActionResult Chitietdochoi(int id)
        {
            DOCHOI dochoi = db.DOCHOIs.SingleOrDefault(n => n.MaDC == id);
            ViewBag.MaDC = dochoi.MaDC;
            if(dochoi == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(dochoi);
        }

        public ActionResult Xoadochoi(int id)
        {
            DOCHOI dochoi = db.DOCHOIs.SingleOrDefault(n => n.MaDC == id);
            ViewBag.MaDC = dochoi.MaDC;
            if (dochoi == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(dochoi);
        }

        [HttpPost,ActionName("Xoadochoi")]
        public ActionResult XacnhanXoadochoi(int id)
        {
            DOCHOI dochoi = db.DOCHOIs.SingleOrDefault(n => n.MaDC == id);
            ViewBag.MaDC = dochoi.MaDC;
            if (dochoi == null)
            {
                Response.StatusCode =  404;
                return null;
            }
            db.DOCHOIs.Remove(dochoi);
            db.SaveChanges();
            return RedirectToAction("Dochoi");
        }

        [HttpGet]
        public ActionResult Suadochoi(int id)
        {
            DOCHOI dochoi = db.DOCHOIs.SingleOrDefault(n => n.MaDC == id);
            if (dochoi == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            ViewBag.MaCD = new SelectList(db.CHUDEs.ToList().OrderBy(n => n.Tenchude), "MaCD", "Tenchude", dochoi.MaCD);
            ViewBag.MaTH = new SelectList(db.THUONGHIEUx.ToList().OrderBy(n => n.Tenthuonghieu), "MaTH", "Tenthuonghieu", dochoi.MaTH);
            return View(dochoi);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Suadochoi(DOCHOI dochoi, FormCollection f)
        {
                if (ModelState.IsValid)
                {
                  
                    db.Entry(dochoi).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();

                }
                ViewBag.MaCD = new SelectList(db.CHUDEs.ToList().OrderBy(n => n.Tenchude), "MaCD", "Tenchude", dochoi.MaCD);
                ViewBag.MaTH = new SelectList(db.THUONGHIEUx.ToList().OrderBy(n => n.Tenthuonghieu), "MaTH", "Tenthuonghieu", dochoi.MaTH);
                ViewBag.MaDC = dochoi.MaDC;
                return RedirectToAction("Dochoi");
            
        }


        //----------------------------------------------------------------------------------//
        //-----------------------------------CHUDE------------------------------------------//
        //----------------------------------------------------------------------------------//


        public ActionResult QLChude(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.CHUDEs.ToList().OrderBy(n => n.MaCD).ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Themmoichude()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themmoichude(CHUDE chude, FormCollection f)
        {           
                if (ModelState.IsValid)
                {
                    db.Entry(chude).State = System.Data.Entity.EntityState.Added;
                    db.SaveChanges();
                }

                return RedirectToAction("QLChude");            
        }

        [HttpGet]
        public ActionResult Suachude(int id)
        {
            CHUDE chude = db.CHUDEs.SingleOrDefault(n => n.MaCD == id);
            if (chude == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(chude);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Suachude(CHUDE chude, FormCollection f)
        {
            if (ModelState.IsValid)
            {

                db.Entry(chude).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();

            }
            ViewBag.MaDC = chude.MaCD;
            return RedirectToAction("QLChude");

        }

        public ActionResult Xoachude(int id)
        {
            CHUDE chude = db.CHUDEs.SingleOrDefault(n => n.MaCD == id);
            ViewBag.MaDC = chude.MaCD;
            if (chude == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(chude);
        }

        [HttpPost, ActionName("Xoachude")]
        public ActionResult XacnhanXoachude(int id)
        {
            CHUDE chude = db.CHUDEs.SingleOrDefault(n => n.MaCD == id);
            ViewBag.MaCD = chude.MaCD;
            if (chude == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.Entry(chude).State = System.Data.Entity.EntityState.Deleted;
            db.SaveChanges();
            return RedirectToAction("QLChude");
        }


        //----------------------------------------------------------------------------------//
        //-----------------------------------THUONGHIEU-------------------------------------//
        //----------------------------------------------------------------------------------//

        public ActionResult QLThuonghieu(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.THUONGHIEUx.ToList().OrderBy(n => n.MaTH).ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Themmoithuonghieu()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themmoithuonghieu(THUONGHIEU thuonghieu, FormCollection f)
        {
            if (ModelState.IsValid)
            {
                db.Entry(thuonghieu).State = System.Data.Entity.EntityState.Added;
                db.SaveChanges();
            }

            return RedirectToAction("QLThuonghieu");
        }

        [HttpGet]
        public ActionResult Suathuonghieu(int id)
        {
            THUONGHIEU thuonghieu = db.THUONGHIEUx.SingleOrDefault(n => n.MaTH == id);
            if (thuonghieu == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(thuonghieu);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Suathuonghieu(THUONGHIEU thuonghieu, FormCollection f)
        {
            if (ModelState.IsValid)
            {

                db.Entry(thuonghieu).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();

            }
            ViewBag.MaTH = thuonghieu.MaTH;
            return RedirectToAction("QLThuonghieu");

        }

        public ActionResult Xoathuonghieu(int id)
        {
            THUONGHIEU thuonghieu = db.THUONGHIEUx.SingleOrDefault(n => n.MaTH == id);
            ViewBag.MaTH = thuonghieu.MaTH;
            if (thuonghieu == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(thuonghieu);
        }

        [HttpPost, ActionName("Xoathuonghieu")]
        public ActionResult XacnhanXoathuonghieu(int id)
        {
            THUONGHIEU thuonghieu = db.THUONGHIEUx.SingleOrDefault(n => n.MaTH == id);
            ViewBag.MaTH = thuonghieu.MaTH;
            if (thuonghieu == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.Entry(thuonghieu).State = System.Data.Entity.EntityState.Deleted;
            db.SaveChanges();
            return RedirectToAction("QLThuonghieu");
        }

        //----------------------------------------------------------------------------------//
        //-----------------------------------KHACHHANG--------------------------------------//
        //----------------------------------------------------------------------------------//

        public ActionResult QLKhachhang(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.KHACHHANGs.ToList().OrderBy(n => n.MaKH).ToPagedList(pageNumber, pageSize));
            //return View(db.DOCHOIs.ToList());
        }

        [HttpGet]
        public ActionResult Themmoikhachhang()
        {
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themmoikhachhang(KHACHHANG khachhang, FormCollection f)
        {
            if (ModelState.IsValid)
            {
                db.Entry(khachhang).State = System.Data.Entity.EntityState.Added;
                db.SaveChanges();
            }

            return RedirectToAction("QLKhachhang");
        }

        public ActionResult Chitietkhachhang(int id)
        {
            KHACHHANG khachhang = db.KHACHHANGs.SingleOrDefault(n => n.MaKH == id);
            ViewBag.MaKH = khachhang.MaKH;
            if (khachhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(khachhang);
        }

        public ActionResult Xoakhachhang(int id)
        {
            KHACHHANG khachhang = db.KHACHHANGs.SingleOrDefault(n => n.MaKH == id);
            ViewBag.MaKH = khachhang.MaKH;
            if (khachhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(khachhang);
        }

        [HttpPost, ActionName("Xoakhachhang")]
        public ActionResult XacnhanXoakhachhang(int id)
        {
            KHACHHANG khachhang = db.KHACHHANGs.SingleOrDefault(n => n.MaKH == id);
            ViewBag.MaKH = khachhang.MaKH;
            if (khachhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.Entry(khachhang).State = System.Data.Entity.EntityState.Deleted;
            db.SaveChanges();
            return RedirectToAction("QLKhachhang");
        }

        [HttpGet]
        public ActionResult Suakhachhang(int id)
        {
            KHACHHANG khachhang = db.KHACHHANGs.SingleOrDefault(n => n.MaKH == id);
            if (khachhang == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(khachhang);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Suakhachhang(KHACHHANG khachhang, FormCollection f)
        {
            if (ModelState.IsValid)
            {

                db.Entry(khachhang).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();

            }
            ViewBag.MaKH = khachhang.MaKH;
            return RedirectToAction("QLKhachhang");

        }
    }
}