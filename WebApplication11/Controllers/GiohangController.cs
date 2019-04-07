using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication11.Models;
namespace WebApplication11.Controllers
{
    public class GiohangController : Controller
    {
         QLBANDOCHOIEntities1 data = new QLBANDOCHOIEntities1();
        // GET: Giohang
        public List<Giohang> Laygiohang()
        {
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if (lstGiohang == null)
            {
                lstGiohang = new List<Giohang>();
                Session["Giohang"] = lstGiohang;
            }
            return lstGiohang;
        }
        public ActionResult ThemGioHang(int mMadochoi, string strURL)
        {
            List<Giohang> lstGiohang = Laygiohang();
            Giohang sanpham = lstGiohang.Find(n => n.mMadochoi == mMadochoi);
            if (sanpham == null)
            {
                sanpham = new Giohang(mMadochoi);
                lstGiohang.Add(sanpham);
                return Redirect(strURL);
            }
            else
            {
                sanpham.mSoluong++;
                return Redirect(strURL);
            }
        }
        public int Tongsoluong()
        {
            int mTongsoluong = 0;
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if (lstGiohang != null)
            {
                mTongsoluong = lstGiohang.Sum(n => n.mSoluong);
            }
            return mTongsoluong;
        }
        public double Tongtien()
        {
            double mTongtien = 0;
            List<Giohang> lstGiohang = Session["Giohang"] as List<Giohang>;
            if (lstGiohang != null)
            {
                mTongtien = lstGiohang.Sum(n => n.mThanhtien);
            }
            return mTongtien;
        }
        public ActionResult GioHang()
        {
            List<Giohang> lstGiohang = Laygiohang();
            if (lstGiohang.Count == 0)
            {
                return RedirectToAction("Index", "TrangChu");
            }
            ViewBag.Tongsoluong = Tongsoluong();
            ViewBag.Tongtien = Tongtien();
            return View(lstGiohang);
        }
        public ActionResult GioHangPartial()
        {

            ViewBag.Tongsoluong = Tongsoluong();
            ViewBag.Tongtien = Tongtien();
            return PartialView();
        }
        public ActionResult XoaGioHang(int mMaSP)
        {
            List<Giohang> lstGiohang = Laygiohang();
            Giohang sanpham = lstGiohang.SingleOrDefault(n => n.mMadochoi == mMaSP);
            if (sanpham != null)
            {
                lstGiohang.RemoveAll(n => n.mMadochoi == mMaSP);
                return RedirectToAction("Giohang");
            }
            if (lstGiohang.Count == 0)
            {
                return RedirectToAction("Index", "TrangChu");
            }
            return RedirectToAction("Giohang");
        }

        public ActionResult CapNhatGioHang(int mMaSP, FormCollection f)
        {
            List<Giohang> lstGiohang = Laygiohang();
            Giohang sanpham = lstGiohang.SingleOrDefault(n => n.mMadochoi == mMaSP);
            if (sanpham != null)
            {
                sanpham.mSoluong = int.Parse(f["txtSoLuong"].ToString());
            }
            return RedirectToAction("Giohang");
        }

        public ActionResult XoaTatCaGioHang()
        {
            List<Giohang> lstGiohang = Laygiohang();
            lstGiohang.Clear();
            return RedirectToAction("Index", "TrangChu");
        }

        [HttpGet]
        public ActionResult Dathang()
        {

            if (Session["MaKH"] == null || Session["MaKH"].ToString() == "")
            {
                return RedirectToAction("Dangnhap", "Nguoidung");
            }
            if (Session["Giohang"] == null)
            {
                return RedirectToAction("Index", "TrangChu");
            }
            List<Giohang> lstGiohang = Laygiohang();
            ViewBag.Tongsoluong = Tongsoluong();
            ViewBag.Tongtien = Tongtien();

            return View(lstGiohang);
        }

        public ActionResult Dathang(FormCollection collection)
        {
            DONDATHANG ddh = new DONDATHANG();
            KHACHHANG kh = (KHACHHANG)Session["Taikhoan"];
            List<Giohang> gh = Laygiohang();
            ddh.MaKH = kh.MaKH;
            ddh.NgayDH = DateTime.Now;
            var ngaygiao = String.Format("{0:dd/MM/yyyy}", collection["Ngaygiaohang"]);
            ddh.Ngaygiaohang = DateTime.Parse(ngaygiao);
            ddh.HTThanhtoan = false;
            ddh.HTThanhtoan = false;
            data.DONDATHANGs.Add(ddh);
            data.SaveChanges();
            foreach (var item in gh)
            {
                CTDATHANG ctdh = new CTDATHANG();
                ctdh.SoDH = ddh.SoDH;
                ctdh.MaDC = item.mMadochoi;
                ctdh.Soluong = item.mSoluong;
                ctdh.Dongia = (decimal)item.mDongia;
                data.CTDATHANGs.Add(ctdh);
            }
            data.SaveChanges();
            Session["Giohang"] = null;
            return RedirectToAction("Xacnhandonhang", "Giohang");
        }
        public ActionResult Xacnhandonhang()
        {
            return View();
        }

    }
}