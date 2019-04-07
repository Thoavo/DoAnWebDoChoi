using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication11.Models
{
    public class Giohang
    {
        QLBANDOCHOIEntities1 data = new QLBANDOCHOIEntities1();
        public int mMadochoi { set; get; }
        public string mTendochoi { set; get; }
        public string mHinhminhhoa { set; get; }
        public Double mDongia { set; get; }
        public int mSoluong { set; get; }
        public Double mThanhtien
        {
            get { return mSoluong * mDongia; }
        }
        public Giohang(int Masach)
        {
            mMadochoi = Masach;
            DOCHOI sach = data.DOCHOIs.Single(n => n.MaDC == mMadochoi);
            mTendochoi = sach.TenDC;
            mHinhminhhoa = sach.Hinhminhhoa;
            mDongia = double.Parse(sach.Dongia.ToString());
            mSoluong = 1;
        }
    }
}