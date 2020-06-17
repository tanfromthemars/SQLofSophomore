/* Học phần: Cơ sở dữ liệu
Người thực hiện: Huỳnh Thiên Tân
MSSV: 1812841
Ngày thực hiện: 06/05/2020
Lab05: Quản lý Tour du lịch*/
create database Lab05_QLTour
go

use Lab05_QLTour

create table Tour
(MaTour char(4) primary key,
TongSongay int)
go

create table Thanhpho
(MaTP char(2) primary key,
TenTP nvarchar(30))
go

create table Tour_TP
(MaTour char(4) references Tour(MaTour),
MaTP char(2) references Thanhpho(MaTP),
SoNgay int,
primary key(MaTour, MaTP))
go

create table Lich_TourDL
(MaTour char(4) references Tour(MaTour),
NgayKhoihanh datetime,
TenHDV nvarchar(5),
SoNguoi int,
TenKhachhang nvarchar(30),
primary key(MaTour, NgayKhoihanh))
go

create proc USP_Insert_Tour
@MaTour char(4), @TongSoNgay int
as
if exists(select * from Tour where MaTour = @MaTour) print 'Already ' + @MaTour + ' in the table!'
else
	begin
	insert into	Tour values(@MaTour, @TongSoNgay)
	print 'Successfully'
	end
go
exec USP_Insert_Tour 'T001',3
exec USP_Insert_Tour 'T002',4
exec USP_Insert_Tour 'T003',5
exec USP_Insert_Tour 'T004',7

create proc USP_Insert_Thanhpho
@MaTP char(2), @TenTP nvarchar(30)
as
if exists(select * from Thanhpho where MaTP = @MaTP) print 'Already ' + @MaTP + ' in the table!'
else
	begin
	insert into Thanhpho values(@MaTP,@TenTP)
	print 'Successfully'
	end
go

exec USP_Insert_Thanhpho '01', N'Đà Lạt'
exec USP_Insert_Thanhpho '02', N'Nha Trang'
exec USP_Insert_Thanhpho '03', N'Phan Thiết'
exec USP_Insert_Thanhpho '04', N'Huế'
exec USP_Insert_Thanhpho '05', N'Đà Nẵng'

create proc USP_Insert_TourTP
@MaTour char(4), @MaTP char(2), @Songay int
as
if exists(select * from Tour where MaTour = @MaTour) and exists(select * from Thanhpho where MaTP = @MaTP)
	begin
	if exists(select * from Tour_TP where MaTour = @MaTour and MaTP = @MaTP) print 'Already ' + @MaTour + ' ' + @MaTP + ' in the table!'
	else
		begin
		insert into Tour_TP values(@MaTour, @MaTP, @Songay)
		print 'Successfully'
		end
	end
else
	if not exists(select * from Tour where MaTour = @MaTour) print 'Not exist ' + @MaTour + ' in the table!'
	else print 'Not exist ' + @MaTP + ' in the table!'
go

exec USP_Insert_TourTP 'T001', '01', 2
exec USP_Insert_TourTP 'T001', '03', 1
exec USP_Insert_TourTP 'T002', '01', 2
exec USP_Insert_TourTP 'T002', '02', 2
exec USP_Insert_TourTP 'T003', '02', 2
exec USP_Insert_TourTP 'T003', '01', 1
exec USP_Insert_TourTP 'T003', '04', 2
exec USP_Insert_TourTP 'T004', '02', 2
exec USP_Insert_TourTP 'T004', '05', 2
exec USP_Insert_TourTP 'T004', '04', 3

create proc USP_Insert_LichTourDL
@MaTour char(4), @NgayKhoihanh datetime, @TenHDV nvarchar(10), @SoNguoi int, @TenKhachhang nvarchar(30)
as
if exists(select * from Tour where MaTour=@MaTour)
	begin
	if exists(select * from Lich_TourDL where MaTour = @MaTour and NgayKhoihanh = @NgayKhoihanh) print 'Already ' + @MaTour + ' in the table!'
	else 
		begin
		insert into Lich_TourDL values(@MaTour, @NgayKhoihanh, @TenHDV, @SoNguoi, @TenKhachhang) print 'Successfully'
		end
	end
else print 'Foreign key error!!! Not exist ' + @MaTour + ' in the table!'
go

set dateformat dmy
go
exec USP_Insert_LichTourDL 'T001', '14/02/2017', N'Vân', 20, N'Nguyễn Hoàng'
exec USP_Insert_LichTourDL 'T002', '14/02/2017', N'Nam', 30, N'Lê Ngọc'
exec USP_Insert_LichTourDL 'T002', '06/03/2017', N'Hùng', 20, N'Lý Dũng'
exec USP_Insert_LichTourDL 'T003', '18/02/2017', N'Dũng', 20, N'Lý Dũng'
exec USP_Insert_LichTourDL 'T004', '18/02/2017', N'Hùng', 30, N'Dũng Nam'
exec USP_Insert_LichTourDL 'T003', '10/03/2017', N'Nam', 46, N'Nguyễn An'
exec USP_Insert_LichTourDL 'T002', '28/04/2017', N'Vân', 25, N'Ngọc Dung'
exec USP_Insert_LichTourDL 'T004', '29/04/2017', N'Dũng', 35, N'Lê Ngọc'
exec USP_Insert_LichTourDL 'T001', '30/04/2017', N'Nam', 25, N'Trần Nam'
exec USP_Insert_LichTourDL 'T003', '15/06/2017', N'Vân', 20, N'Trịnh Bá'

--a. Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày
select MaTour, TongSongay
from Tour
where Tour.TongSongay >= 3 and Tour.TongSongay <= 5

--b. Cho biết thông tin	các tour được tổ chức trong tháng 2 năm 2017
select *
from Lich_TourDL
where MONTH(NgayKhoihanh) = 2 and YEAR(Ngaykhoihanh) = 2017

--c. Cho biết các tour không đi qua thành phố Nha Trang
select Thanhpho.MaTP, TenTP, MaTour, SoNgay
from Thanhpho, Tour_TP
where Thanhpho.MaTP = Tour_TP.MaTP and Thanhpho.TenTP not like N'Nha Trang'

--d. Cho biết thành phố mà mỗi tour du lịch đi qua
select MaTour, TenTP
from Tour_TP, Thanhpho
where Tour_TP.MaTP = Thanhpho.MaTP

--e. Cho biết số lượng Tour du lịch mỗi hướng dẫn viên hướng dẫn
select TenHDV, COUNT(TenHDV) as SoluongTour
from Lich_TourDL, Tour
where Lich_TourDL.MaTour = Tour.MaTour 
group by TenHDV

--f. Cho biết tên thành phố có nhiều tour du lịch đi qua nhất
select TenTP, COUNT(Tour_TP.MaTP) as SoluongTP
from Thanhpho, Tour_TP
where Thanhpho.MaTP = Tour_TP.MaTP
group by TenTP, Thanhpho.MaTP
having COUNT(Tour_TP.MaTP) >= all (select COUNT(Tour_TP.MaTP) from Thanhpho, Tour_TP where Thanhpho.MaTP = Tour_TP.MaTP group by Thanhpho.MaTP)

--g. Cho biết thông tin của tour du lịch đi qua tất cả các thành phố
select Tour_TP.MaTour, COUNT(Tour_TP.MaTP) as SoTP
from Tour_TP, Tour
where Tour.MaTour = Tour_TP.MaTour
group by Tour_TP.MaTour
having COUNT(Tour_TP.MaTP) >= all(select COUNT(MaTP) from Thanhpho)

--h. Lập danh sách các tour đi qua thành phố Đà Lạt, thông tin cần hiển thị bao gồm: MaTour, SoNgay
select TenTP, MaTour, SoNgay
from Thanhpho, Tour_TP
where Thanhpho.MaTP = Tour_TP.MaTP and TenTP like N'Đà Lạt'

--i. Cho biết thông tin của tour du lịch có tổng lượng khách nhiều nhất
select *
from Tour, Lich_TourDL
where Tour.MaTour = Lich_TourDL.MaTour and SoNguoi >= all (Select SoNguoi from Lich_TourDL)

--j. Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua
select TenTP, COUNT(MaTour) as SoTour
from Tour_TP, Thanhpho
where Tour_TP.MaTP = Thanhpho.MaTP
group by TenTP
having COUNT(MaTour) >= all (select COUNT(MaTour) from Tour)