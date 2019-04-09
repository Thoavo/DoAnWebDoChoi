--use master
--drop Database QLBANDOCHOI
--Tao CSDL
create database QLBANDOCHOI
GO
use QLBANDOCHOI
GO
Create Table THUONGHIEU
(
	MaTH INT IDENTITY(1,1),
	Tenthuonghieu NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_THUONGHIEU PRIMARY KEY(MaTH)
)
GO
Create Table CHUDE
(
	MaCD INT IDENTITY(1,1),
	Tenchude NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_ChuDe PRIMARY KEY(MaCD)
)
GO
CREATE TABLE DOCHOI
(
	MaDC INT IDENTITY(1,1),
	TenDC NVARCHAR(100) NOT NULL,
	Donvitinh NVARCHAR(50) DEFAULT 'bộ',
	Dongia MONEY CHECK (Dongia>=0),
	Mota NTEXT,
	Hinhminhhoa VARCHAR(50),
	MaTH INT,
	MaCD INT,
	Ngaycapnhat SMALLDATETIME,
	Soluongban INT CHECK(Soluongban>0),
	solanxem INT DEFAULT 0,
	CONSTRAINT PK_ PRIMARY KEY(MaDC)
)
GO
--CREATE TABLE BETRAI
--(
--	MaSPBT INT IDENTITY(1,1),
--	TenSPBT NVARCHAR(100) NOT NULL,
--	Donvitinh NVARCHAR(50) DEFAULT 'bộ',
--	Dongia MONEY CHECK (Dongia>=0),
--	Mota NTEXT,
--	Hinhminhhoa VARCHAR(50),
--	MaTH INT,
--	Ngaycapnhat SMALLDATETIME,
--	Soluongban INT CHECK(Soluongban>0),
--	solanxem INT DEFAULT 0,
--	CONSTRAINT PK_ PRIMARY KEY(MaSPBT)
--)
--GO
--CREATE TABLE BEGAI
--(
--	MaSPBG INT IDENTITY(1,1),
--	TenBeGai NVARCHAR(100) NOT NULL,
--	Donvitinh NVARCHAR(50) DEFAULT 'bộ',
--	Dongia MONEY CHECK (Dongia>=0),
--	Mota NTEXT,
--	Hinhminhhoa VARCHAR(50),
--	MaTH INT,
--	Ngaycapnhat SMALLDATETIME,
--	Soluongban INT CHECK(Soluongban>0),
--	solanxem INT DEFAULT 0,
--	CONSTRAINT PK_BeGai PRIMARY KEY(MaSPBG)
--)
--GO
--CREATE TABLE LEOGOGIAODUC
--(
--	MaLGGD INT IDENTITY(1,1),
--	TenLGGD NVARCHAR(100) NOT NULL,
--	Donvitinh NVARCHAR(50) DEFAULT 'bộ',
--	Dongia MONEY CHECK (Dongia>=0),
--	Mota NTEXT,
--	Hinhminhhoa VARCHAR(50),
--	MaTH INT,
--	Ngaycapnhat SMALLDATETIME,
--	Soluongban INT CHECK(Soluongban>0),
--	solanxem INT DEFAULT 0,
--	CONSTRAINT PK_LeoGoGiaoDuc PRIMARY KEY(MaLGGD)
--)
--GO
CREATE TABLE KHACHHANG
(
	MaKH INT IDENTITY(1,1),
	HotenKH nVarchar(50) NOT NULL,
	DiachiKH nVarchar(50),
	DienthoaiKH Varchar(10),
	TenDN Varchar(15) UNIQUE,
	Matkhau Varchar(15) NOT NULL,
	--Ngaysinh SMALLDATETIME,
	--Gioitinh Bit Default 1,
	Email Varchar(50) UNIQUE,
	Daduyet Bit Default 0,
	CONSTRAINT PK_KhachHang PRIMARY KEY(MaKH)
)
GO

CREATE TABLE DONDATHANG
(
	SoDH INT IDENTITY(1,1),
	MaKH INT,
	NgayDH DATETIME,
	Trigia Money Check (Trigia>0),
	Dagiao Bit Default 0,
	Ngaygiaohang DATETIME,
	Tennguoinhan Varchar(50),
	Diachinhan nvarchar,
	Dienthoainhan Varchar(15),
	HTThanhtoan Bit Default 0,
	HTGiaohang Bit Default 0,
	CONSTRAINT PK_DonDatHang PRIMARY KEY(SoDH)
)
GO

CREATE TABLE CTDATHANG
(
	SoDH INT,
	MaDC INT,
	Soluong Int Check(Soluong>0),
	Dongia Decimal(9,2) Check(Dongia>=0),
	Thanhtien AS SoLuong*Dongia ,
	CONSTRAINT PK_CTDatHang PRIMARY KEY(SoDH,MaDC)
)
GO

CREATE TABLE THAMDO
(
	MaCH INT IDENTITY(1,1),
	Ngaydang SMALLDATETIME,
	Noidungthamdo nVarchar(255) NOT NULL,
	Tongsobinhchon Int Default 0,
	CONSTRAINT PK_ThamDo PRIMARY KEY(MaCH)
)
GO

CREATE TABLE CTTHAMDO
(
	MaCH INT,
	STT INT,
	Noidungtraloi nVarchar(255) NOT NULL,
	Solanbinhchon Int Default 0,
	CONSTRAINT PK_CTThamDo PRIMARY KEY(MaCH,STT)
)

GO

ALTER TABLE DOCHOI ADD CONSTRAINT FK_DoChoi_ChuDe FOREIGN KEY (MaCD) REFERENCES CHUDE(MaCD)
ALTER TABLE DOCHOI ADD CONSTRAINT FK_DoChoi_ThuongHieu FOREIGN KEY (MaTH) REFERENCES THUONGHIEU(MaTH)
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_DonDatHang_KhachHang FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
ALTER TABLE CTDATHANG ADD CONSTRAINT FK_CTDatHang_DonDatHang FOREIGN KEY (SoDH) REFERENCES DONDATHANG(SoDH)
ALTER TABLE CTDATHANG ADD CONSTRAINT FK_CTDatHang_DoChoi FOREIGN KEY (SoDH) REFERENCES DOCHOI(MaDC)
ALTER TABLE CTTHAMDO ADD CONSTRAINT FK_CTThamDo_ThamDo FOREIGN KEY (MaCH) REFERENCES THAMDO(MaCH)

GO


/****** Object:  Table [dbo].[CHUDE]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[CHUDE] ON
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (1, N'Bé trai')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (2, N'Bé gái')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (3, N'Baby')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (4, N'Lego Education')
SET IDENTITY_INSERT [dbo].[CHUDE] OFF


/****** Object:  Table [dbo].[THUONGHIEU]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[THUONGHIEU] ON
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (1, N'Avengers')
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (2, N'B Brand')
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (3, N'Baby Alive')
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (4, N'Battat')
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (5, N'Black Panther')
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (6, N'Bruder')
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (7, N'Carrera')
INSERT [dbo].[THUONGHIEU] ([MaTH], [Tenthuonghieu]) VALUES (8, N'Cat')
SET IDENTITY_INSERT [dbo].[THUONGHIEU] OFF


/****** Object:  Table [dbo].[SACH]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[DOCHOI] ON
INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (1, N'Đồ chơi cát - Xe ben khổng lồ', N'Bộ', 579000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic1.jpg', 6, 2, CAST(0x95270000 AS SmallDateTime), 120, 0)
INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (2, N'ULTRON thế hệ huyền thoại', N'Bộ', 449000, N'Thông tin đồ chơi: 
• Đồ chơi thương hiệu Hasbro - Hoa Kỳ
• Mô hình nhân vật ULTRON thế hệ huyền thoại
• Thiết kế cổ điển và tinh xảo đến từng chi tiết
• Kích thước 9 cm với nhiều điểm khớp nối linh hoạt
• Hãy tưởng tượng tham gia vào cuộc phiêu lưu Vũ trụ Marvel với nhân vật ULTRON thế hệ huyền thoại
• Độ tuổi từ 4 trở lên', N'/Data/files/pic2.jpg', 7, 1, CAST(0x95270000 AS SmallDateTime), 80, 0)
INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (3, N'Bé cưng mít ướt', N'Bộ', 1699000, N'Thông tin đồ chơi: 
• Búp bê có thể khóc nhè và sổ mũi như thật. 
• Sản phẩm gồm 1 búp bê,1 tai  nghe bác sĩ, 1 ống tiêm, 1 lược chải tóc, khăn ăn và bình nước', N'/Data/files/pic3.jpg', 3, 2, CAST(0x95270000 AS SmallDateTime), 50, 0)
INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (4, N'Mô hình Nakia cao cấp', N'Bộ', 749000, N'Thông tin đồ chơi: 
• Mô hình Nakia cao cấp', N'/Data/files/pic4.jpg', 5, 1, CAST(0x95270000 AS SmallDateTime), 150, 0)
INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (5, N'Đĩa xây dựng cỡ nhỏ', N'Bộ', 1679000, N'Thông tin đồ chơi: 
• Tấm gạch xây dựng có ba kích cỡ và màu sắc khác nhau. 
• Sử dụng để tạo cảnh quan, hoặc để xây dựng nhà cao tầng. 
• Màu tấm gạch tương ứng cho nước biển, cỏ xanh, đất vv...', N'/Data/files/pic5.jpg', 4, 4, CAST(0x95270000 AS SmallDateTime), 100, 0)
INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (6, N'Bộ đồ chơi lắp ráp CAT 4 trong 1', N'Bộ', 519000, N'Thông tin đồ chơi: 
• Bộ đồ chơi lắp ráp CAT 4 trong 1 với khả năng biến hóa từ xe tải kéo, sang xe bồn, rồi đến xe đổ rác. 
• Thú vị hơn, bé còn có thể úm ba la ra một chiếc xe khổng lồ đa năng, là sự kết hợp hoàn hảo giữa xe tải kéo, xe bồn và xe đổ rác. 
• Mẹ có thể dạy bé các chức năng và công dụng hữu ích của từng xe, giúp bé khám phá thế giới và tăng cường vận động tinh thông qua việc lắp ráp. 
• Cánh tay cẩu có thể di chuyển được, bồn có thể xoay tròn và nắp thùng xe rác có thể lật lên hạ xuống. 
• Bộ sản phẩm bao gồm các chi tiết lắp ráp + 1 tua vít + 1 công nhân', N'/Data/files/pic6.jpg', 8, 1, CAST(0x95270000 AS SmallDateTime), 220, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (7, N'Mô hình siêu anh hùng ', N'Bộ', 579000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic7.jpg', 8, 2, CAST(0x95270000 AS SmallDateTime), 150, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (8, N'MAGNETO AOA', N'Bộ', 500000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic8.jpg', 8, 4, CAST(0x95270000 AS SmallDateTime), 170, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (9, N'CAPTAIN AMERICA', N'Bộ', 379000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic9.jpg', 7, 3, CAST(0x95270000 AS SmallDateTime), 110, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (10, N'SPIDER-MAN 2099', N'Bộ', 779000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic10.jpg', 6, 2, CAST(0x95270000 AS SmallDateTime), 111, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (11, N'JESSICA JONES', N'Bộ', 879000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic11.jpg', 6, 4, CAST(0x95270000 AS SmallDateTime), 100, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (12, N'LADY DEADPOOL', N'Bộ', 579000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic12.jpg', 1, 4, CAST(0x95270000 AS SmallDateTime), 78, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (13, N'MOON KNIGHT', N'Bộ', 679000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic13.jpg', 2, 3, CAST(0x95270000 AS SmallDateTime), 45, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (14, N'WOLVERINE', N'Bộ', 979000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic14.jpg', 3, 3, CAST(0x95270000 AS SmallDateTime), 55, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (15, N'Thiết bị tấn công', N'Bộ', 79000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic15.jpg', 3, 2, CAST(0x95270000 AS SmallDateTime), 77, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (16, N'Mặt nạ Marvel Spiderman', N'Bộ', 59000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic16.jpg', 3, 2, CAST(0x95270000 AS SmallDateTime), 79, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (17, N'Mặt nạ Marvel Iron Man', N'Bộ', 79000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic17.jpg', 2, 1, CAST(0x95270000 AS SmallDateTime), 80, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (18, N'Mô hình LOKI', N'Bộ', 59000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic18.jpg', 2, 2, CAST(0x95270000 AS SmallDateTime), 80, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (19, N'Bộ Động Cơ Power Functions', N'Bộ', 57000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic19.jpg', 2, 3, CAST(0x95270000 AS SmallDateTime), 77, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (20, N'Mô hình PATRIOT', N'Bộ', 555000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic20.jpg', 2, 4, CAST(0x95270000 AS SmallDateTime), 12, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (21, N'Mô hình Iron Man 6 in', N'Bộ', 779000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic21.jpg', 6, 4, CAST(0x95270000 AS SmallDateTime), 12, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (22, N'Iron Man Amor tinh nhuệ', N'Bộ', 50000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic22.jpg', 5, 3, CAST(0x95270000 AS SmallDateTime), 25, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (23, N'Mặt nạ Thần Sấm THOR', N'Bộ', 595000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic23.jpg', 5, 2, CAST(0x95270000 AS SmallDateTime), 25, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (24, N'WINTER SOLDIER', N'Bộ', 279000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic24.jpg', 5, 1, CAST(0x95270000 AS SmallDateTime), 64, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (25, N'Captain America', N'Bộ', 379000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic25.jpg', 3, 1, CAST(0x95270000 AS SmallDateTime), 55, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (26, N'Găng tay của Iron Man', N'Bộ', 355000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic26.jpg', 3, 2, CAST(0x95270000 AS SmallDateTime), 70, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (27, N'Siêu anh hùng Người Kiến', N'Bộ', 579000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic27.jpg', 4, 3, CAST(0x95270000 AS SmallDateTime), 200, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (28, N'Siêu anh hùng Báo Đen ', N'Bộ', 555000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic28.jpg', 4, 4, CAST(0x95270000 AS SmallDateTime), 300, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (29, N'Mô hình JAKKU', N'Bộ', 258000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic29.jpg', 4, 4, CAST(0x95270000 AS SmallDateTime), 22, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (30, N'Siêu cấp Agent Venom', N'Bộ', 295000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic30.jpg', 5, 3, CAST(0x95270000 AS SmallDateTime), 150, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (31, N'WWII Captain America ', N'Bộ', 230000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic31.jpg', 6, 2, CAST(0x95270000 AS SmallDateTime), 250, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (32, N'Winter Soldier', N'Bộ', 233000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic32.jpg', 7, 1, CAST(0x95270000 AS SmallDateTime), 210, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (33, N'Siêu anh hùng Voltstrike ', N'Bộ', 579000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic33.jpg', 8, 4, CAST(0x95270000 AS SmallDateTime), 122, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (34, N'Mô hình Thor 30cm', N'Bộ', 876000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic34.jpg', 7, 3, CAST(0x95270000 AS SmallDateTime), 144, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (35, N'Mô hình Thần Sấm THOR', N'Bộ', 245000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic35.jpg', 8, 2, CAST(0x95270000 AS SmallDateTime), 125, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (36, N'Mô hình HAWKEYE', N'Bộ', 654000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic36.jpg', 6, 1, CAST(0x95270000 AS SmallDateTime), 222, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (37, N'Mô hình BLACK WIDOW', N'Bộ', 125000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic37.jpg', 6, 4, CAST(0x95270000 AS SmallDateTime), 333, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (38, N'Mô hình Marvel UNV Hulk', N'Bộ', 100000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic38.jpg', 2, 3, CAST(0x95270000 AS SmallDateTime), 444, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (39, N'Đồng tiền ma thuật', N'Bộ', 125000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic39.jpg', 2, 2, CAST(0x95270000 AS SmallDateTime), 420, 0)

INSERT [dbo].[DOCHOI] ([MaDC], [TenDC], [Donvitinh], [Dongia], [Mota], [Hinhminhhoa], [MaTH], [MaCD], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (40, N'Nón ảo thuật thần kì', N'Bộ', 456000, N'Thông tin đồ chơi: 
Sản phẩm gồm chiếc xe và các dụng cụ chơi cát nhỏ xinh, vừa tầm tay của trẻ Giúp trẻ thỏa sức sáng tạo, kích thích khả năng vận đông, cho trẻ cứng cáp và nhanh nhẹn', N'/Data/files/pic40.jpg', 1, 1, CAST(0x95270000 AS SmallDateTime), 425, 0)







SET IDENTITY_INSERT [dbo].[DOCHOI] OFF


/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[KHACHHANG] ON
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (1, N'Dương Thành Phết', N'Trần Huy Liệu', N'0918062755', N'phetcm', N'123', N'pvkhoa@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (2, N'Nguyễn Tiến Luân', N'Quận 6', N'Chua có', N'thang', N'123456', N'ntluan@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (3, N'Đặng Quốc Hòa', N'Sư Vạn Hạnh', N'Chua có', N'dqhoa', N'hoa', N'dqhoa@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (4, N'Ngô Ngọc Ngân', N'Khu chung cư', N'0918544699', N'nnngan', N'ngan', N'nnngan@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (5, N'Đỗ Quỳnh Hương', N'Cống Quỳnh', N'0908123456', N'dqhuong', N'huong', N'dqhuong@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (6, N'Trần Thị Thu Trang', N'Nơ Trang Long', N'Chua có', N'ttttrang', N'trang', N'ttrang@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (7, N'Nguyễn Thiên Thanh', N'Hai Bà Trưng', N'0908320111', N'ntthanh', N'thanh', N'ntthanh@t3h.hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (8, N'Trần Thị Hải Yến', N'Trần Hưng Đạo', N'8111111   ', N'tthyen', N'yen', N'tthyan@vol.vnn.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (9, N'Nguyễn Thị Thanh Mai', N'Trần Quang Diệu', N'81111222', N'nttmai', N'mai', NULL)
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (10, N'Nguyễn Thành Danh', N'Cộng Hòa', N'8103751   ', N'ntdanh', N'danh', N'ntdanh@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (11, N'Phạm Thị Nga', N'Q6 - Tp.HCM', N'0831564512', N'ptnga', N'nga', N'ptnhung@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (12, N'Lê Doanh Doanh', N'2Bis Hùng Vương', N'07077865', N'lddoanh', N'doanh', N'lddoanh@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (13, N'Đòan Ngọc Minh Tâm', N'2 Đinh Tiên Hòang', N'0909092222', N'dnmtam', N'tam', N'ndmtam@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Email]) VALUES (14, N'Trần Khải Nhi', N'3 Bùi Hữu Nghĩa', N'0909095555', N'tknhi', N'nhi', N'tknhi@yahoo.com')
SET IDENTITY_INSERT [dbo].[KHACHHANG] OFF


/****** Object:  Table [dbo].[DONDATHANG]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[DONDATHANG] ON
INSERT [dbo].[DONDATHANG] ([SoDH], [MaKH], [NgayDH], [Trigia], [Dagiao], [Ngaygiaohang]) VALUES (1, 1, CAST(0x9D500000 AS SmallDateTime),  CAST(75000.00 AS Decimal(9, 2)), 0, CAST(0x9D500000 AS SmallDateTime))
INSERT [dbo].[DONDATHANG] ([SoDH], [MaKH], [NgayDH], [Trigia], [Dagiao], [Ngaygiaohang]) VALUES (2, 1, CAST(0x9DA30000 AS SmallDateTime),  CAST(80000.00 AS Decimal(9, 2)), 0, CAST(0x9DA30000 AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[DONDATHANG] OFF


/****** Object:  Table [dbo].[CTDATHANG]    Script Date: 10/19/2010 13:14:22 ******/
INSERT [dbo].[CTDATHANG] ([SoDH], [MaDC], [Soluong], [Dongia]) VALUES (1, 1, 1, 579000)
INSERT [dbo].[CTDATHANG] ([SoDH], [MaDC], [Soluong], [Dongia]) VALUES (1, 2, 2, 449000)
INSERT [dbo].[CTDATHANG] ([SoDH], [MaDC], [Soluong], [Dongia]) VALUES (2, 6, 1, 519000)
INSERT [dbo].[CTDATHANG] ([SoDH], [MaDC], [Soluong], [Dongia]) VALUES (2, 4, 3, 749000)


/****** Object:  Table [dbo].[Admin]    Script Date: 10/19/2010 13:14:22 ******/
Create Table Admin
(
	UserID INT IDENTITY(1,1),
	UserAdmin varchar(30) not null,
	PassAdmin varchar(30) not null,
	CONSTRAINT PK_Admin PRIMARY KEY(UserID)
)
SET IDENTITY_INSERT [dbo].[Admin] ON
INSERT [dbo].[Admin] ([UserID], [UserAdmin], [PassAdmin]) VALUES (1, 'admin', 'admin')
INSERT [dbo].[Admin] ([UserID], [UserAdmin], [PassAdmin]) VALUES (2, 'vip','123')
INSERT [dbo].[Admin] ([UserID], [UserAdmin], [PassAdmin]) VALUES (3, 'maiquyen','maiquyen')
INSERT [dbo].[Admin] ([UserID], [UserAdmin], [PassAdmin]) VALUES (4, 'quyen','quyen')
SET IDENTITY_INSERT [dbo].[Admin] OFF
--/****** Object:  Table [dbo].[CSDIACHI]    Script Date: 10/19/2010 13:14:22 ******/
--CREATE TABLE CSDIACHI
--(
--	MaDiaChi INT IDENTITY(1,1),
--	Thongtin NTEXT,
--)
--SET IDENTITY_INSERT [dbo].[CSDIACHI] ON
--INSERT [dbo].[CSDIACHI] ([MaDiaChi], [Thongtin]) VALUES (1, N'Công Ty Cổ Phần Việt Tinh Anh
--Địa chỉ: 33-35 Đường D4, Khu Đô Thị Mới Him Lam,
--P.Tân Hưng, Q.7, HCM
--Hotlline: 19001208
--(Thời gian hoạt động của tổng đài là 8h00 đến 17h00, từ thứ 2 đến thứ 7)
--Email CSKH: hotro@mykingdom.com.vn
--Email Hợp tác: hoptac@mykingdom.com.vn')
--INSERT [dbo].[CSDIACHI] ([MaDiaChi], [Thongtin]) VALUES (2, N'Văn Phòng Hà Nội
--Địa chỉ: Tầng 5, tòa nhà công ty bao bì 277
--Số 4, Láng Hạ, Đống Đa, Hà Nội
--Điện thoại: (84-4) 35 37 98 04')
--SET IDENTITY_INSERT [dbo].[CSDIACHI] OFF
