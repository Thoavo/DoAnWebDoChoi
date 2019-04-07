using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication11.Models;

using PagedList;
using PagedList.Mvc;
namespace WebApplication11.Controllers
{
    public class TrangChuController : Controller
    {
        // GET: TrangChu
        public ActionResult Index(int ? page)
        {
            int pageSize = 6;
            int pageNumber = (page ?? 1);

            var Dochoimoi = Laydochoimoi(12);
            return View(Dochoimoi.ToPagedList(pageNumber, pageSize));
        }
        QLBANDOCHOIEntities1 data = new QLBANDOCHOIEntities1();
        private List<DOCHOI> Laydochoimoi(int count)
        {
            return data.DOCHOIs.OrderByDescending(a => a.Ngaycapnhat).Take(count).ToList();
        }
        
        public ActionResult Chude()
        {
            var chude = from s in data.CHUDEs select s;
            return View(chude);
        }
        public ActionResult Thuonghieu()
        {
            var th = from q in data.THUONGHIEUx select q;
            return View(th);
        }

        public ActionResult SPTheochude(int id)
        {
            var dochoi = from s in data.DOCHOIs where s.MaCD == id select s;
            return View(dochoi);
        }
        public ActionResult SPTheothuonghieu(int id)
        {
            var dochoi = from s in data.DOCHOIs where s.MaTH == id select s;
            return View(dochoi);
        }
        public ActionResult Laytenchude(int id)
        {
            var chude = from s in data.CHUDEs where s.MaCD == id select s;
            return View(chude);
        }

       

        public ActionResult Laytenthuonghieu(int id)
        {
            var th = from q in data.THUONGHIEUx where q.MaTH == id select q;
            return View(th);
        }

        public ActionResult Details(int id)
        {
            var dochoi = from s in data.DOCHOIs where s.MaDC == id select s;
            return View(dochoi.Single());
        }

        public ActionResult Lienhe()
        {
            return View();
        }

    }
}