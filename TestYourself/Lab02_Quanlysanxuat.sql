/*Học phần: Cơ sở dữ liệu
Giảng viên: Tạ Thị Thu Phượng
Người thực hiện: Huỳnh Thiên Tân
MSSV: 1812841
Ngày: 23/05/2020*/

create database Lab02_QLSX
go

use Lab02_QLSX

create table ToSanxuat
(MaTSX char(5) primary key, 
TenTSX nvarchar(10) not null unique)
go

create table Congnhan
(MaCN char(10) primary key,
HoCN nvarchar(20) not null,
TenCN nvarchar(10) not null,
Phai nvarchar(10),
Ngaysinh datetime,
MaTSX char(5) references ToSanxuat(MaTSX))
go

create table Sanpham
(MaSP char(6) primary key,
TenSP nvarchar(30) not null,
dvt nvarchar(5),
Tiencong int check(Tiencong > 0))
go

create table Thanhpham
(MaCN char(10) references Congnhan(MaCN),
MaSP char(6) references Sanpham(MaSP),
Ngay datetime,
Soluong int,
primary key (MaCN, MaSP, Ngay))
go

insert into ToSanxuat values ('TS01', N'Tổ 1')
insert into ToSanxuat values ('TS02', N'Tổ 2')
select * from ToSanxuat

set dateformat dmy
go
insert into Congnhan values ('CN001', N'Nguyễn Trường', 'An', 'Nam', '12/05/1981', 'TS01')
insert into Congnhan values ('CN002', N'Lê Thị Hồng', N'Gấm', N'Nữ', '04/06/1980', 'TS01')
insert into Congnhan values ('CN003', N'Nguyễn Công', N'Thành', 'Nam', '04/05/1981', 'TS02')
insert into Congnhan values ('CN004', N'Võ Hữu', N'Hạnh', N'Nữ', '15/02/1980', 'TS02')
insert into Congnhan values ('CN005', N'Lý Thanh', N'Hân', N'Nữ', '03/12/1981', 'TS01')
select * from Congnhan

insert into Sanpham values ('SP001', N'Nồi đất', N'Cái', 10000)
insert into Sanpham values ('SP002', N'Chén', N'Cái', 2000)
insert into Sanpham values ('SP003', N'Bình gốm nhỏ', N'Cái', 20000)
insert into Sanpham values ('SP004', N'Bình gốm lớn', N'Cái', 25000)
select * from Sanpham

set dateformat dmy
go
insert into Thanhpham values ('CN001', 'SP001', '01/02/2007', 10)
insert into Thanhpham values ('CN002', 'SP001', '01/02/2007', 5)
insert into Thanhpham values ('CN003', 'SP002', '10/01/2007', 50)
insert into Thanhpham values ('CN004', 'SP003', '12/01/2007', 10)
insert into Thanhpham values ('CN005', 'SP002', '12/01/2007', 100)
insert into Thanhpham values ('CN002', 'SP004', '13/02/2007', 10)
insert into Thanhpham values ('CN001', 'SP003', '14/02/2007', 15)
insert into Thanhpham values ('CN003', 'SP001', '15/01/2007', 20)
insert into Thanhpham values ('CN003', 'SP004', '14/02/2007', 15)
insert into Thanhpham values ('CN004', 'SP002', '30/01/2007', 100)
insert into Thanhpham values ('CN005', 'SP003', '01/02/2007', 50)
insert into Thanhpham values ('CN001', 'SP001', '20/02/2007', 30)
select * from Thanhpham

--Q1: Liệt kê các công nhân theo tổ sản xuất
select ToSanxuat.TenTSX, Congnhan.HoCN + ' ' + Congnhan.TenCN as HoTen, CONVERT(char(10), Ngaysinh, 103) as Ngaysinh, Phai
from Congnhan, ToSanxuat
where Congnhan.MaTSX = ToSanxuat.MaTSX
order by TenTSX, TenCN

--Q2: Liệt kê các thành phẩm mà công nhân 'Nguyễn Trường An' làm được
select Sanpham.TenSP, CONVERT(char(10), Ngay, 103) as Ngay, Soluong, Soluong * Tiencong as Thanhtien
from Congnhan, Thanhpham, Sanpham
where Congnhan.MaCN = Thanhpham.MaCN and Thanhpham.MaSP = Sanpham.MaSP and HoCN = N'Nguyễn Trường' and TenCN = 'An'
order by Ngay

--Q3: Liệt kê các nhân viên không sản xuất 'Bình gốm lớn'
select *
from Congnhan
where Congnhan.MaCN not in(select Thanhpham.MaCN from Thanhpham, Sanpham where Sanpham.MaSP = Thanhpham.MaSP and Sanpham.TenSP = N'Bình gốm lớn')

--Q4: Liệt kê thông tin các công nhân có sản xuất cả 'Nồi đất' và 'Bình gốm nhỏ'
select distinct Congnhan.MaCN, HoCN + ' ' + TenCN as Hoten
from Congnhan, Thanhpham, Sanpham
where Congnhan.MaCN = Thanhpham.MaCN and Thanhpham.MaSP = Sanpham.MaSP and TenSP = N'Nồi đất' and Congnhan.MaCN in(select Thanhpham.MaCN from Thanhpham, Sanpham where Thanhpham.MaSP =Sanpham.MaSP and TenSP = N'Bình gốm nhỏ')

--Q5: Thống kê số lượng công nhân theo từng tổ sản xuất
select Congnhan.MaTSX, TenTSX, COUNT(MaCN) as SoluongCN
from ToSanxuat, Congnhan
where ToSanxuat.MaTSX = Congnhan.MaTSX
group by Congnhan.MaTSX, TenTSX

--Q6: Tổng số lượng sản phẩm theo từng loại mà mỗi công nhân làm được
select HoCN + ' ' + TenCN as Hoten, TenSP, SUM(Soluong) as TongSL, SUM(Soluong * Tiencong) as TongThanhtien
from Thanhpham, Sanpham, Congnhan
where Congnhan.MaCN = Thanhpham.MaCN and Thanhpham.MaSP = Sanpham.MaSP
group by HoCN, TenCN, TenSP
order by TenCN

--Q7: Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007 (01/2007)
select SUM(Soluong * Tiencong) as Thanhtien
from Thanhpham, Sanpham
where Thanhpham.MaSP = Sanpham.MaSP and MONTH(Ngay) = 1 and YEAR(Ngay) = 2007

--Q8: Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2 năm 2007 (02/2007)
select Thanhpham.MaSP, TenSP, SUM(Soluong) as TongSL
from Thanhpham, Sanpham
where Thanhpham.MaSP = Sanpham.MaSP and MONTH(Ngay) = 2 and YEAR(Ngay) = 2007
group by Thanhpham.MaSP, TenSP
having SUM(Soluong) >= all(select sum(Thanhpham.Soluong) from Thanhpham where MONTH(Ngay) = 2 and YEAR(Ngay) = 2007 group by Thanhpham.MaSP)

--Q9: Cho biết công nhân sản xuất được nhiều 'Chén' nhất
select Congnhan.MaCN, HoCN + ' ' + TenCN as Hoten, MaTSX, SUM(Soluong) as Soluong
from Congnhan, Thanhpham, Sanpham
where Congnhan.MaCN = Thanhpham.MaCN and Thanhpham.MaSP = Sanpham.MaSP and TenSP = N'Chén'
group by Congnhan.MaCN, HoCN, TenCN, MaTSX
having SUM(Soluong) >= all(select SUM(Soluong) from Thanhpham, Sanpham where Thanhpham.MaSP = Sanpham.MaSP and TenSP = N'Chén' group by Thanhpham.MaCN)

--Q10: Tiền công tháng 2/2006 của công nhân 'CN002'
select SUM(Soluong * Tiencong) as Tiencong
from Thanhpham, Sanpham
where Thanhpham.MaSP = Sanpham.MaSP and MONTH(Ngay) = 2 and YEAR(Ngay) = 2007 and MaCN = 'CN002'

--Q11: Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên
select Congnhan.MaCN, HoCN + ' ' + TenCN as Hoten, COUNT(distinct MaSP) 
from Congnhan, Thanhpham
where Congnhan.MaCN = Thanhpham.MaCN
group by Congnhan.MaCN, HoCN, TenCN
having COUNT(distinct MaSP) >= 3

--Q12: Cập nhật giá tiền công của các loại bình gốm thêm 1000
update Sanpham set Tiencong = Tiencong + 100
where Sanpham.MaSP = 'SP003' or Sanpham.MaSP = 'SP004'

--Q13: Thêm bộ
insert into Congnhan (MaCN, HoCN, TenCN, Phai, MaTSX)
values ('CN006', N'Lê Thị', N'Lan', N'Nữ', 'TS02')
/*delete from Congnhan
where MaCN = 'CN006'*/