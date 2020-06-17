/*Học phần: Cơ sở dữ liệu
Giảng viên: Tạ Thị Thu Phượng
Người thực hiện: Huỳnh Thiên Tân
MSSV: 1812841
Ngày: 23/05/2020*/

create database Lab03_QuanlyNhapxuatHanghoa
go

use Lab03_QuanlyNhapxuatHanghoa

create table Hanghoa
(MaHH char(6) primary key,
TenHH char(100) not null,
dvt char(4),
SoluongTon int)

create table Doitac
(MaDT char(6) primary key,
TenDT nvarchar(30) not null,
Diachi nvarchar(50),
Dienthoai char(11))

create table KhanangCC
(MaDT char(6) references Doitac(MaDT),
MaHH char(6) references Hanghoa(MaHH),
primary key (MaDT, MaHH))

create table Hoadon
(SoHD char(5) primary key,
NgaylapHD datetime,
MaDT char(6) references Doitac(MaDT),
TongTG char(30))

create table Chitiet_HD
(SoHD char(5) references Hoadon(SoHD),
MaHH char(6) references Hanghoa(MaHH),
Dongia int,
Soluong int,
primary key (SoHD, MaHH))

insert into Hanghoa values('CPU01', 'CPU INTEL, CELERON 600 BOX', N'CÁI', 5)
insert into Hanghoa values('CPU02', 'CPU INTEL, PIII 700', N'CÁI', 10)
insert into Hanghoa values('CPU03', 'CPU AMD K7 ATHL, ON 600', N'CÁI', 8)
insert into Hanghoa values('HDD01', 'HDD 10.2 GB QUANTUM', N'CÁI', 10)
insert into Hanghoa values('HDD02', 'HDD 13.6 GB SEAGATE', N'CÁI', 15)
insert into Hanghoa values('HDD03', 'HDD 20 GB QUANTUM', N'CÁI', 6)
insert into Hanghoa values('KB01', 'KB GENIUS', N'CÁI', 12)
insert into Hanghoa values('KB02', 'KB MITSUMIMI', N'CÁI', 5)
insert into Hanghoa values('MB01', 'GIGABYTE CHIPSET INTEL', N'CÁI', 10)
insert into Hanghoa values('MB02', 'ACOPR BX CHIPSET VIA', N'CÁI', 10)
insert into Hanghoa values('MB03', 'INTEL PHI CHIPSET INTEL', N'CÁI', 10)
insert into Hanghoa values('MB04', 'ECS CHIPSET SIS', N'CÁI', 10)
insert into Hanghoa values('MB05', 'ECS CHIPSET VIA', N'CÁI', 10)
insert into Hanghoa values('MNT01', 'SAMSUNG 14" SYNCMASTER', N'CÁI', 5)
insert into Hanghoa values('MNT02', 'LG 14"', N'CÁI', 5)
insert into Hanghoa values('MNT03', 'ACER 14"', N'CÁI', 8)
insert into Hanghoa values('MNT04', 'PHILIPS 14"', N'CÁI', 6)
insert into Hanghoa values('MNT05', 'VIEWSONIC 14"', N'CÁI', 7)
select * from Hanghoa

insert into Doitac values('CC001', 'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
insert into Doitac values('CC002', N'Cty Hoàng Long', N'15A TTT Q1 - TPHCM', '08.8250898')
insert into Doitac values('CC003', N'Cty Hợp Nhất', N'152 BTX Q1 - TPHCM', '08.8252376')
insert into Doitac values('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trổi - Tp. Đà Lạt', '063.831129')
insert into Doitac values('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ - N.Trang', '058590270')
insert into Doitac values('K0003', N'Trần Nhật Duật', N'Lê Lợi - TP. Huế', '054.848376')
insert into Doitac values('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi Nghĩa - Tp. Đà Lạt', '063.823409')
select * from Doitac

insert into KhanangCC values('CC001', 'CPU01')
insert into KhanangCC values('CC001', 'HDD03')
insert into KhanangCC values('CC001', 'KB01')
insert into KhanangCC values('CC001', 'MB01')
insert into KhanangCC values('CC001', 'MB04')
insert into KhanangCC values('CC001', 'MNT01')
insert into KhanangCC values('CC002', 'CPU01')
insert into KhanangCC values('CC002', 'CPU02')
insert into KhanangCC values('CC002', 'CPU03')
insert into KhanangCC values('CC002', 'KB02')
insert into KhanangCC values('CC002', 'MB01')
insert into KhanangCC values('CC002', 'MB05')
insert into KhanangCC values('CC002', 'MNT03')
insert into KhanangCC values('CC003', 'HDD01')
insert into KhanangCC values('CC003', 'HDD02')
insert into KhanangCC values('CC003', 'HDD03')
insert into KhanangCC values('CC003', 'MB03')
select * from KhanangCC

set dateformat dmy
go
insert into Hoadon values('N0001', '25/01/2006', 'CC001', '')
insert into Hoadon values('N0002', '01/05/2006', 'CC002', '')
insert into Hoadon values('X0001', '12/05/2006', 'K0001', '')
insert into Hoadon values('X0002', '16/06/2006', 'K0002', '')
insert into Hoadon values('X0003', '20/04/2006', 'K0001', '')
select * from Hoadon

insert into Chitiet_HD values('N0001', 'CPU01', 63, 10)
insert into Chitiet_HD values('N0001', 'HDD03', 97, 7)
insert into Chitiet_HD values('N0001', 'KB01', 3, 5)
insert into Chitiet_HD values('N0001', 'MB02', 57, 5)
insert into Chitiet_HD values('N0001', 'MNT01', 112, 3)
insert into Chitiet_HD values('N0002', 'CPU02', 115, 3)
insert into Chitiet_HD values('N0002', 'KB02', 5, 7)
insert into Chitiet_HD values('N0002', 'MNT03', 111, 5)
insert into Chitiet_HD values('X0001', 'CPU01', 67, 2)
insert into Chitiet_HD values('X0001', 'HDD03', 100, 2)
insert into Chitiet_HD values('X0001', 'KB01', 5, 2)
insert into Chitiet_HD values('X0001', 'MB02', 62, 1)
insert into Chitiet_HD values('X0002', 'CPU01', 67, 1)
insert into Chitiet_HD values('X0002', 'KB02', 7, 3)
insert into Chitiet_HD values('X0002', 'MNT01', 115, 2)
insert into Chitiet_HD values('X0003', 'CPU01', 67, 1)
insert into Chitiet_HD values('X0003', 'MNT03', 115, 2)
select * from Chitiet_HD

--Q1: Liệt kê các mặt hàng thuộc loại đĩa cứng
select *
from Hanghoa
where MaHH like 'HDD%'

--Q2: Liệt kê các mặt hàng có số lượng tồn trên 10
select *
from Hanghoa 
where SoluongTon > 10

--Q3: Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
select *
from Doitac
where MaDT like 'CC%' and Diachi like '%TPHCM'

--Q4: Liệt kê các hóa đơn nhập hàng trong tháng 5/2006
select Chitiet_HD.SoHD,	NgaylapHD, TenDT, Diachi, Dienthoai, COUNT(Chitiet_HD.MaHH) as SoMathang
from Doitac, Hoadon, Chitiet_HD
where Doitac.MaDT = Hoadon.MaDT and Hoadon.SoHD = Chitiet_HD.SoHD and MONTH(NgaylapHD) = 05 and YEAR(NgaylapHD) = 2006 and Hoadon.SoHD like 'N%'
group by Chitiet_HD.SoHD, NgaylapHD, TenDT, Diachi, Dienthoai

--Q5: Cho biết tên nhà cung cấp có cung cấp đĩa cứng
select Doitac.MaDT, TenDT, Diachi, Dienthoai, TenHH
from Doitac, Hoadon, Chitiet_HD, Hanghoa
where Doitac.MaDT = Hoadon.MaDT and Hoadon.SoHD = Chitiet_HD.SoHD and Chitiet_HD.MaHH = Hanghoa.MaHH and Hanghoa.TenHH like 'HDD%' and Chitiet_HD.SoHD like 'N%'

--Q6: Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng
select KhanangCC.MaDT, TenDT, TenHH, KhanangCC.MaHH
from Doitac, KhanangCC, Hanghoa, Chitiet_HD
where Doitac.MaDT = KhanangCC.MaDT and KhanangCC.MaHH = Hanghoa.MaHH and Hanghoa.MaHH = Chitiet_HD.MaHH and Chitiet_HD.SoHD like 'N%' and Hanghoa.TenHH like 'HDD%'

--Q7: Cho biết tên nhà cung cấp không cung cấp đĩa cứng
select TenDT, Diachi, Dienthoai, Chitiet_HD.MaHH
from Doitac, KhanangCC, Hanghoa, Chitiet_HD
where Doitac.MaDT = KhanangCC.MaDT and KhanangCC.MaHH = Hanghoa.MaHH and Hanghoa.MaHH = Chitiet_HD.MaHH and Hanghoa.TenHH not like 'HDD%' and Chitiet_HD.SoHD like 'N%'

--Q8: Cho biết thông tin mặt hàng chưa bán được
select * 
from Hanghoa
where MaHH not in(select MaHH from Chitiet_HD where Chitiet_HD.SoHD like 'X%')

--Q9: Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng)
select Hanghoa.MaHH, Hanghoa.TenHH, SUM(Soluong) as SoluongBan
from Hanghoa, Chitiet_HD, Hoadon
where Hanghoa.MaHH = Chitiet_HD.MaHH and Chitiet_HD.SoHD = Hoadon.SoHD and Hoadon.SoHD like 'X%'
group by Hanghoa.MaHH, Hanghoa.TenHH
having SUM(Soluong) >= all(select SUM(Soluong) from Hoadon, Chitiet_HD where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.SoHD like 'X%' group by Chitiet_HD.MaHH)

--Q10: Cho biết tên và tổng số lượng của mặt hàng nhập ít nhất
select Hanghoa.MaHH, Hanghoa.TenHH, SUM(Soluong) as SoluongNhap
from Hanghoa, Chitiet_HD, Hoadon
where Hanghoa.MaHH = Chitiet_HD.MaHH and Chitiet_HD.SoHD = Hoadon.SoHD and Hoadon.SoHD like 'N%'
group by Hanghoa.MaHH, Hanghoa.TenHH
having SUM(Soluong) <= all(select SUM(Soluong) from Hoadon, Chitiet_HD where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.SoHD like 'N%' group by Chitiet_HD.MaHH)

--Q11: Cho biết hóa đơn nhập nhiều mặt hàng nhất
select Hoadon.SoHD, NgaylapHD, TenDT, COUNT(*) as SoluongMH
from Hoadon, Doitac, Chitiet_HD
where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.MaDT = Doitac.MaDT and Hoadon.SoHD like 'N%'
group by Hoadon.SoHD, NgaylapHD, TenDT
having COUNT(*) >= all(select COUNT(*) from Hoadon, Chitiet_HD where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.SoHD like 'N%' group by Hoadon.SoHD)

--Q12: Cho biết các mặt hàng không được nhập trong tháng 1/2006
select *
from Hanghoa
where Hanghoa.MaHH not in(select distinct Chitiet_HD.MaHH from Hoadon, Chitiet_HD where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.SoHD like 'N%' and MONTH(NgaylapHD) = 1 and YEAR(NgaylapHD) = 2006)

--Q13: Cho biết tên các mặt hàng không bán được trong tháng 6/2006
select Hanghoa.TenHH
from Hanghoa
where Hanghoa.MaHH not in(select distinct Chitiet_HD.MaHH from Hoadon, Chitiet_HD where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.SoHD like 'X%' and MONTH(NgaylapHD) = 1 and YEAR(NgaylapHD) = 2006)

--Q14: Cho biết cửa hàng bán bao nhiêu mặt hàng
/*xét trên hóa đơn nhập vì nhập về của cửa hàng thì sẽ có bán*/
select TenHH, Chitiet_HD.MaHH, SoHD
from Hanghoa,Chitiet_HD
where Hanghoa.MaHH = Chitiet_HD.MaHH and Chitiet_HD.SoHD like 'N%' 

--Q15: Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
select TenDT, TenHH
from Doitac, KhanangCC, Hanghoa, Chitiet_HD
where Doitac.MaDT = KhanangCC.MaDT and KhanangCC.MaHH = Hanghoa.MaHH and Hanghoa.MaHH = Chitiet_HD.MaHH and Chitiet_HD.SoHD like 'N%'
group by TenDT, TenHH

--Q16: Cho biết thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất
select Doitac.MaDT, TenDT, Diachi, Dienthoai
from Hoadon, Chitiet_HD, Doitac
where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.MaDT = Doitac.MaDT and Hoadon.MaDT like 'K%'
group by Doitac.MaDT, TenDT, Diachi, Dienthoai
having COUNT(*) >= all(select COUNT(*) from Hoadon, Chitiet_HD where Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.MaDT like 'K%' group by Hoadon.MaDT)

--Q17: Tính tổng doanh thu năm 2006
select SUM(Soluong * Dongia) as TongDoanhthu
from Chitiet_HD
where Chitiet_HD.SoHD like 'X%'

--Q18: Cho biết loại mặt hàng bán chạy nhất
select Hanghoa.MaHH, TenHH
from Hanghoa, Hoadon, Chitiet_HD
where Hanghoa.MaHH = Chitiet_HD.MaHH and Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.SoHD like 'X%' and Chitiet_HD.Soluong >= all(select Chitiet_HD.Soluong from Chitiet_HD where Chitiet_HD.SoHD like 'X%')

--Q19: Liệt kê thông tin bán hàng của tháng 5/2006
select Chitiet_HD.MaHH, TenHH, dvt, SUM(Soluong) as Tongsoluong, SUM(Soluong * Dongia) as TongThanhtien
from Hanghoa, Chitiet_HD, Hoadon
where Hanghoa.MaHH = Chitiet_HD.MaHH and Chitiet_HD.SoHD = Hoadon.SoHD and Hoadon.SoHD like 'X%' and MONTH(NgaylapHD) = 5 and YEAR(NgaylapHD) = 2006
group by Chitiet_HD.MaHH, TenHH, dvt

--Q20: Liệt kê thông tin của mặt hàng có nhiều người mua nhất
select Hanghoa.MaHH, TenHH, dvt, SUM(Soluong) as SoluongBan
from Hanghoa, Chitiet_HD, Hoadon
where Hanghoa.MaHH = Chitiet_HD.MaHH and Hoadon.SoHD = Chitiet_HD.SoHD and Hoadon.SoHD like 'X%'
group by Hanghoa.MaHH, TenHH, dvt
having SUM(Soluong) >= all(select SUM(Soluong) from Chitiet_HD, Hoadon where Chitiet_HD.SoHD = Hoadon.SoHD and Chitiet_HD.SoHD = 'X%' group by Chitiet_HD.MaHH)

--Q21: Tính và cập nhật tổng trị giá của các hóa đơn
update Hoadon 
set TongTG = (select SUM(Soluong * Dongia) from Chitiet_HD where Chitiet_HD.SoHD = Hoadon.SoHD)