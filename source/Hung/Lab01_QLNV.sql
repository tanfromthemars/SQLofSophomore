------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 17/04/2020
   Người thực hiện: LÊ SỸ HÙNG
*/
------------------------------------------------
--lenh tao CSDL
CREATE DATABASE LAB01_QLNV
go
--lenh su dyng CSDL
use LAB01_QLNV
--lenh tao cac bang
create table ChiNhanh
(MSCN	char(2) primary key, -- khai bao MSCN là khóa chính
TenCN	nvarchar(30) not null unique
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
Ngaysinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN) -- khai bao MSCN là khóa ngoại tham chiếu đến khóa chính MSCN của quan hệ ChiNhanh 
)
go
create table KyNang
(MSKN	char(2) primary key,
TenKN	nvarchar(30) not null
)
go
create table NhanVienKyNang
(
MANV char(4) references NhanVien(MANV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=9)
primary key(MANV,MSKN) --khai báo khóa chính gồm nhiều thuộc tính
)
go
--xem cac bang
select * from ChiNhanh
select * from NhanVien
select * from KyNang
select * from NhanVienKyNang
go
-- Nhap Du Lieu Cho Bang
INSERT INTO ChiNhanh VALUES ('01',N'Quận 1')
INSERT INTO ChiNhanh VALUES ('02',N'Quận 5')
INSERT INTO ChiNhanh VALUES ('03',N'Bình Thạch')
--xem Bang chi nhanh
SELECT * FROM ChiNhanh

-- Nhap du lieu Cho Bang Ky Nang
INSERT INTO KyNang VALUES ('01',N'Word')
INSERT INTO KyNang VALUES ('02',N'Excel')
INSERT INTO KyNang VALUES ('03',N'Access')
INSERT INTO KyNang VALUES ('04',N'Power Point')
INSERT INTO KyNang VALUES ('05',N'SPSS')
-- xem bang ky nang
SELECT * FROM KyNang

--Nhap bang NhanVien
set dateformat dmy --Khai báo định dạng ngày tháng 
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bang nhanvien
select * from NhanVien

-- Nhap du lieu Nhan vien Ky Nang
INSERT INTO NhanVienKyNang VALUES ('0001','01',2)
INSERT INTO NhanVienKyNang VALUES ('0001','02',1)
INSERT INTO NhanVienKyNang VALUES ('0002','01',2)
INSERT INTO NhanVienKyNang VALUES ('0002','03',2)
INSERT INTO NhanVienKyNang VALUES ('0003','02',1)
INSERT INTO NhanVienKyNang VALUES ('0003','03',2)
INSERT INTO NhanVienKyNang VALUES ('0004','01',5)
INSERT INTO NhanVienKyNang VALUES ('0004','02',4)
INSERT INTO NhanVienKyNang VALUES ('0004','03',1)
INSERT INTO NhanVienKyNang VALUES ('0005','02',4)
INSERT INTO NhanVienKyNang VALUES ('0005','04',4)
INSERT INTO NhanVienKyNang VALUES ('0006','05',4)
INSERT INTO NhanVienKyNang VALUES ('0006','02',4)
INSERT INTO NhanVienKyNang VALUES ('0006','03',2)
INSERT INTO NhanVienKyNang VALUES ('0007','03',4)
INSERT INTO NhanVienKyNang VALUES ('0007','04',3)
-- xem bang nhan vien ky nang
SELECT * FROM NhanVienKyNang
GO
---check muc do 
 SELECT * FROM NhanVien WHERE MSCN = '01'
 go
 --Hiển thị MSNV, HoTen (Ho + Ten as HoTen), số năm làm việc
SELECT MANV,Ho + ' ' + Ten AS HoVaTen,YEAR(GETDATE()) - YEAR(NgayVaoLam) AS SoNamCT
 FROM NhanVien 
 go
 --Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp xếp theo tên chi nhánh).
--Liệt kê các nhân viên (HoTen, TenKN, MucDo) của những nhân viên biết sử dụng ‘Word’.
select nhanvien.*, ChiNhanh.*
from NhanVien,ChiNhanh
where Nhanvien.mscn=Chinhanh.mscn
---------
select a.*, b.*
from NhanVien a,ChiNhanh b
where a.MSCN =b.MSCN
--Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp xếp theo tên chi nhánh). 
select Ho+' '+Ten as HoTen, Ngaysinh, NgayVaoLam,B.TenCN
from NhanVien A, ChiNhanh B
where	A.MSCN = B.MSCN
order by TenCN, Ten, ho
-- Liệt kê các nhân viên (HoTen, TenKN, MucDo) của những nhân viên biết sử dụng ‘Word’
select Ho+' '+Ten as HoTen,TenKN,mucdo
from NhanVien A, NhanVienkynang B,  KyNang C
where	A.manv = B.MANV and B.MSKN = C.MSKN 
		AND TenKN = 'word'
--Liệt kê các kỹ năng (TenKN, MucDo) mà nhân
-- viên ‘Lê Anh Tuấn’ biết sử dụng.
select TenKN,MucDo
from NhanVien a, NhanVienKyNang c, KyNang d
where A.MANV  = C.MANV and C.MSKN = d.MSKN 
AND Ho = N'Lê Anh' and Ten = N'Tuấn'
-- truy van lồng
-- EXcel cao nhat ----
SELECT a.MANV,Ho+' '+Ten AS HoVaTen,A.MSCN,TenKN,TenCN,C.MucDo
FROM NhanVien A, ChiNhanh B, NhanVienKyNang C,KyNang D
WHERE B.MSCN = A.MSCN AND A.MANV = C.MANV AND C.MSKN = D.MSKN
		AND TenKN = 'Excel'
		AND A.MSCN IN (select e.MANV
					 from NhanVienKyNang e, KyNang f
					 where e.MSKN = f.MSKN and TenKN = 'Word' )
-- vua biet Word va Excel ---
