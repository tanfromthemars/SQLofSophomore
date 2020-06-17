create database Lab01_QuanlyNhanvien
go

use Lab01_QuanlyNhanvien

create table Chinhanh
(MScn char(2) primary key,
TenCN nvarchar(30) not null unique)

create table Nhanvien
(MSnv char(4) primary key,
HoNV nvarchar(20) not null,
TenNV nvarchar(10) not null,
NgaysinhNV datetime,
NgayNVvaolam datetime,
MScn char(2) references Chinhanh(MScn))

create table Kynang
(MSkn char(2) primary key,
TenKN nvarchar(13) not null)

create table TTin_Kynang
(MSnv char(4) references Nhanvien(MSnv),
MSkn char(2) references Kynang(MSkn),
Mucdo tinyint check(Mucdo between 1 and 9),
primary key(MSnv, MSkn))

--II. Cài đặt các ràng buộc sau
--1. Mức độ thuộc tập {1,2,3,4,5,6,7,8,9): Mucdo between 1 and 9
--2. Tên chi nhánh phải phân biệt: TenCN unique
--3. Tên kỹ năng phải phân biệt: TenKN unique
--4. Nhân viên phải đủ 18t khi vào làm
...
insert into ChiNhanh values('01',N'Quận 1')
insert into Chinhanh values('02',N'Quận 5')
insert into Chinhanh values('03',N'Quận Bình Thạnh')

insert into Kynang values('01','Word')
insert into Kynang values('02','Excel')
insert into Kynang values('03','Access')
insert into Kynang values('04','Power Point')

set dateformat dmy
go
insert into Nhanvien Values('0001', N'Lê Văn', N'Minh', '10/06/1960', '02/05/1986', '01')
insert into Nhanvien Values('0002', N'Nguyễn Thị', N'Mai', '20/04/1970', '04/07/2001', '01')
insert into Nhanvien Values('0003', N'Lê Anh', N'Tuấn', '25/06/1975', '01/09/1982', '02')
insert into Nhanvien values('0004', N'Vương Tuấn', N'Vũ', '25/03/1975', '12/01/1986', '02')
insert into Nhanvien values('0005', N'Lý Anh', N'Hân', '01/12/1980', '15/05/2004', '03')
insert into Nhanvien values('0006', N'Phan Lê', N'Tuấn', '04/06/1976', '25/10/2002', '03')
insert into Nhanvien values('0007', N'Lê Tuấn', N'Tú', '15/08/1975', '15/08/2000', '03')

insert into TTin_Kynang values('0001', '01', 2)
insert into TTin_Kynang values('0001', '02', 1)
insert into TTin_Kynang values('0002', '01', 2)
insert into TTin_Kynang values('0002', '03', 2)
insert into TTin_Kynang values('0003', '02', 1)
insert into TTin_Kynang values('0003', '03', 2)
insert into TTin_Kynang values('0004', '01', 5)
insert into TTin_Kynang values('0004', '02', 4)
insert into TTin_Kynang values('0004', '03', 1)
insert into TTin_Kynang values('0005', '02', 4)
insert into TTin_Kynang values('0005', '04', 4)
insert into TTin_Kynang values('0006', '05', 4)
insert into TTin_Kynang values('0006', '02', 4)
insert into TTin_Kynang values('0006', '03', 2)
insert into TTin_Kynang values('0007', '03', 4)
insert into TTin_Kynang values('0007', '04', 3)

--III. Tạo các Query
--1. Truy vấn lựa chọn trên nhiều bảng
--a. Hiển thị mã số nhân viên, họ và tên, số năm làm việc
select MSnv, HoNV + ' ' + TenNV as Hovaten, YEAR(getdate()) - YEAR(NgayNVvaolam) as SoNamCongtac
from Nhanvien

--b. Liệt kê các thông tin về nhân viên: họ và tên, ngày sinh, ngày vào làm, chi nhánh
select HoNV + ' ' + TenNV as HovaTen, NgaysinhNV, NgayNVvaolam, TenCN
from Nhanvien, Chinhanh
where Nhanvien.MScn = Chinhanh.MScn

--c. Liệt kê các thông tin của nhân viên bao gồm: Họ và tên, tên kỹ năng, mức độ của những nhân viên biết sử dụng 'Word'
select HoNV + ' ' + TenNV as HovaTen, TenKN, Mucdo
from Nhanvien, Kynang, TTin_Kynang
where Nhanvien.MSnv = TTin_Kynang.MSnv and Kynang.MSkn = TTin_Kynang.MSkn and TenKN = 'Word'

--d. Liệt kê các kỹ năng: tên kỹ năng, mức độ mà nhân viên 'Lê Anh Tuấn' biết sử dụng
select TenKN, Mucdo
from Nhanvien, Kynang, TTin_Kynang
where Nhanvien.MSnv = TTin_Kynang.MSnv and Kynang.MSkn = TTin_Kynang.MSkn and HoNV = N'Lê Anh' and TenNV = N'Tuấn'

--2. Truy vấn lồng
--a. Liệt kê mã nhân viên, họ và tên, mã số chi nhánh, tên chi nhánh của các nhân viên có mức độ thành thạo về 'Excel' cao nhất trong công ty
select Nhanvien.MSnv, HoNV + ' ' + TenNV as HovaTen, Chinhanh.MScn, TenCN
from Nhanvien, Chinhanh, TTin_Kynang, Kynang
where Nhanvien.MScn = Chinhanh.MScn and Nhanvien.MSnv = TTin_Kynang.MSnv and TTin_Kynang.MSkn = Kynang.MSkn and TenKN = 'Excel' and TTin_Kynang.Mucdo = (select MAX(TTin_Kynang.Mucdo) from TTin_Kynang, Kynang where TTin_Kynang.MSkn = Kynang.MSkn and Kynang.TenKN = 'Excel')

--b. Liệt kê mã nhân viên, họ và tên, tên chi nhánh của các nhân viên vừa biết 'Word' vừa biết 'Excel'
select Nhanvien.MSnv, HoNV + ' ' + TenNV as HovaTen, TenCN
from Nhanvien, Chinhanh, Kynang, TTin_Kynang
where Nhanvien.MScn = Chinhanh.MScn and Nhanvien.MSnv = TTin_Kynang.MSnv and TTin_Kynang.MSkn = Kynang.MSkn and TenKN = 'Word' and TTin_Kynang.MSnv in (select TTin_Kynang.MSnv from Kynang, TTin_Kynang where Kynang.Mskn = TTin_Kynang.MSkn and Kynang.TenKN = 'Excel')

--c. Với từng kỹ năng, hãy liệt kê các thông tin (Mã nhân viên, họ và tên, tên chi nhánh, tên kỹ năng, mức độ) của những nhân viên thành thạo kỹ năng đó nhất
select Nhanvien.MSnv, HoNV + ' ' + TenNV as HovaTen, TenCN, TenKN, Mucdo
from Nhanvien, Chinhanh, Kynang d, TTin_Kynang e
where Nhanvien.MSnv = e.MSnv and Nhanvien.MScn = Chinhanh.MScn and d.MSkn = e.MSkn and e.Mucdo >= all(select MAX(a.Mucdo) from TTin_Kynang a where d.MSkn = a.MSkn)
order by d.TenKN

--d. Liệt kê các chi nhánh mà mọi nhân viên trong chi nhánh đó đều biết 'Word'
select distinct TenCN
from Chinhanh, Kynang, Nhanvien, TTin_Kynang
where Chinhanh.MScn = Nhanvien.MScn and Nhanvien.MSnv = TTin_Kynang.MSnv and TTin_Kynang.MSkn = Kynang.MSkn and TenKN = 'Word'

--3. Truy vẫn gom nhóm dữ liệu
--a. Với mỗi chi nhánh, hãy cho biết các thông tin sau: Tên chi nhánh, số nhân viên
select TenCN, COUNT(MSnv) as SoNhanvien
from Chinhanh, Nhanvien
where Chinhanh.MScn = Nhanvien.MScn
group by TenCN

--b. Với mỗi kỹ năng, hãy cho biết tên kỹ năng, số nhân viên sử dụng kỹ năng đó
select TenKN, COUNT(Nhanvien.MSnv) as SoNhanvienSD
from Kynang, Nhanvien, TTin_Kynang
where Kynang.MSkn = TTin_Kynang.MSkn and Nhanvien.MSnv = TTin_Kynang.MSnv
group by TenKN

--c. Cho biết tên kỹ năng có từ 3 nhân viên trong công ty sử dụng trở lên
select TenKN
from Kynang, TTin_Kynang
where Kynang.MSkn = TTin_Kynang.MSkn
group by TenKN
having COUNT(TTin_Kynang.MSkn) >= 3

--d. Cho biết tên chi nhánh có nhiều nhân viên nhất
select TenCN
from Chinhanh, Nhanvien a
where Chinhanh.MScn = a.MScn
group by TenCN
having COUNT(a.MScn) >= all (select count(b.MSnv) from Nhanvien b, Chinhanh where b.MScn = Chinhanh.MScn group by Chinhanh.TenCN)

--e. Cho biết tên chi nhánh có ít nhân viên nhất
select TenCN
from Chinhanh a, Nhanvien b
where a.MScn = b.MScn
group by TenCN
having COUNT(b.MScn) <= all(select COUNT(c.MSnv) from Nhanvien c, Chinhanh d where c.MScn = d.MScn group by d.TenCN)

--f. Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng
select HoNV + ' ' + TenNV, COUNT(b.MSkn) as SoKNang
from Nhanvien a, TTin_Kynang b
where a.MSnv = b.MSnv
group by HoNV, TenNV

--g. Cho biết họ tên, tên chi nhánh của nhân viên sử dụng nhiều kỹ năng nhất
select HoNV + ' ' + TenNV as HovaTen, TenCN
from Nhanvien a, Chinhanh b, TTin_Kynang c
where a.MSnv = c.MSnv and a.MScn = b.MScn
group by HoNV, TenNV, TenCN
having COUNT(c.MSkn) >= all (select COUNT(e.MSkn) from Nhanvien d, TTin_Kynang e where d.MSnv = e.MSnv group by d.MSnv)

--4. Cập nhật dữ liệu
insert into Kynang values('06','Photoshop')
insert into TTin_Kynang values('0001','06',3)
insert into TTin_Kynang values('0005','06',2)

update TTin_Kynang set Mucdo = Mucdo + 1 where MSkn = '01'

create table NhanvienChinhanh1
(MSnv char(4) primary key,
HoTen nvarchar(30),
SoKynang char(2))

insert into NhanvienChinhanh1 values('0001',N'Lê Văn Minh', 2)
insert into NhanvienChinhanh1 values('0002',N'Nguyễn Thị Mai', 2)