/*Học phần: Cơ sở dữ liệu
Giảng viên: Tạ Thị Thu Phượng
Người thực hiện: Huỳnh Thiên Tân
MSSV: 1812841
Ngày: 24/05/2020*/

create database Lab04_QuanlyDatbao
go

use Lab04_QuanlyDatbao

create table Bao_Tapchi
(MSb_tc char(4) primary key,
TenB_TC nvarchar(30) not null,
TGPHDKy nvarchar(20),
SLuong int check(SLuong > 0),
Giaban int check(Giaban > 0))

create table Phathanh
(MSb_tc char(4) references Bao_Tapchi(MSb_tc),
SoraB_TC int,
NgayPHanh datetime,
primary key (MSb_tc, SoraB_TC))

create table Khachhang
(MaKH char(4) primary key,
TenKH nvarchar(30) not null,
DiachiKH nvarchar(50))

create table KH_Datbao
(MaKH char(4) references Khachhang(MaKH),
MSb_tc char(4) references Bao_Tapchi(MSb_tc),
SLuongMua int check(SLuongMua > 0),
NgayDMua datetime,
primary key (MaKH,MSb_tc))

--Xây dựng các thủ tục thêm dữ liệu vào các bảng
create proc usp_Insert_BaoTapchi
@MSbaotapchi char(4), @TenBTC nvarchar(30), @TGDinhky nvarchar(20), @Soluong int, @Giaban int
as
if exists(select * from Bao_Tapchi where MSb_tc = @MSbaotapchi)
	print N'Đã có mã báo ' + @MSbaotapchi + ' trong CSDL!'
else
	begin
		insert into Bao_Tapchi values(@MSbaotapchi, @TenBTC, @TGDinhky, @Soluong, @Giaban)
		print N'Thêm thành công!'
	end
go

exec usp_Insert_BaoTapchi 'TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500
exec usp_Insert_BaoTapchi 'KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000
exec usp_Insert_BaoTapchi 'TN01', N'Thanh niên', N'Nhật báo', 1000, 2000
exec usp_Insert_BaoTapchi 'PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000
exec usp_Insert_BaoTapchi 'PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000
select * from Bao_Tapchi

create proc usp_Insert_Phathanh
	@MSBaoTapchi char(4), @SoraBTc int, @NgayPH datetime
as
	if exists(select * from Bao_Tapchi where MSb_tc = @MSBaoTapchi)
		begin
			if exists(select * from Phathanh where MSb_tc = @MSBaoTapchi and SoraB_TC = @SoraBTC)
				print N'Đã có số báo ' + @MSBaoTapchi + ' ' + @SoraBTC + ' trong CSDL!'
			else
				begin
					insert into Phathanh values(@MSBaoTapchi, @SoraBTC, @NgayPH)
						print N'Thêm thành công'
				end
		end
	else print N'Vi phạm ràng buộc khóa ngoại!!! ' + @MSBaoTapchi + ' không tồn tại'
go

set dateformat dmy
go
exec usp_Insert_Phathanh 'TT01', 123, '15/12/2005'
exec usp_Insert_Phathanh 'KT01', 70, '15/12/2005'
exec usp_Insert_Phathanh 'TT01', 124, '16/12/2005'
exec usp_Insert_Phathanh 'TN01', 256, '17/12/2005'
exec usp_Insert_Phathanh 'PN01', 45, '23/12/2005'
exec usp_Insert_Phathanh 'PN02', 111, '18/12/2005'
exec usp_Insert_Phathanh 'PN02', 112, '19/12/2005'
exec usp_Insert_Phathanh 'TT01', 125, '17/12/2005'
exec usp_Insert_Phathanh 'PN01', 46, '30/12/2005'
select * from Phathanh

create proc usp_Insert_Khachhang
	@MaKH char(4), @TenKH nvarchar(30), @Diachi nvarchar(50)
as
	if exists (select * from Khachhang where MaKH = @MaKH) 
		print N'Đã có khách hàng ' + @MaKH + ' trong CSDL!'
	else
		begin
			insert into Khachhang values(@MaKH, @TenKH, @Diachi)
			print N'Thêm khách hàng thành công'
		end
go

exec usp_Insert_Khachhang 'KH01', N'Lan', N'2 NCT'
exec usp_Insert_Khachhang 'KH02', N'Nam', N'32 THĐ'
exec usp_Insert_Khachhang 'KH03', N'Ngọc', N'16 LHP'
select * from Khachhang

create proc usp_Insert_Datbao
	@MaKH char(4), @MaBaoTC char(4), @SoluongMua int, @NgayDM datetime
as
	if exists(select * from Bao_Tapchi where Msb_tc = @MaBaoTC) and exists(select * from Khachhang where MaKH = @MaKH)
		begin
			if exists(select * from KH_Datbao where MaKH = @MaKH and MSb_tc = @MaBaoTC)
				print N'Đã có thông tin đặt báo ' + @MaKH + ', ' + @MaBaoTC + ' này trong CSDL!'
			else
				begin
					insert into KH_Datbao values(@MaKH, @MaBaoTC, @SoluongMua, @NgayDM)
						print N'Thêm đặt báo thành công'
				end
		end
	else 
		if not exists(select * from Bao_Tapchi where MSb_tc = @MaBaoTC)
			print N'Không có báo, tạp chí ' + @MaBaoTC + ' trong CSDL!'
		else
			print N'Không có khách hàng ' + @MaKH + ' trong CSDL!'
go

set dateformat dmy
go
exec usp_Insert_Datbao 'KH01', 'TT01', 100, '12/01/2000'
exec usp_Insert_Datbao 'KH02', 'TN01', 150, '01/05/2001'
exec usp_Insert_Datbao 'KH01', 'PN01', 200, '25/06/2001'
exec usp_Insert_Datbao 'KH03', 'KT01', 50, '17/03/2002'
exec usp_Insert_Datbao 'KH03', 'PN02', 200, '26/08/2003'
exec usp_Insert_Datbao 'KH02', 'TT01', 250, '15/01/2004'
exec usp_Insert_Datbao 'KH01', 'KT01', 300, '14/10/2004'
select * from Datbao

--II. Truy vấn dữ liệu
--Q1: Cho biết các tờ báo, tạp chí có định kỳ phát hành hàng tuần
select * from Bao_Tapchi where TGPHDky like N'Tuần báo'

--Q2: Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ
select * from Bao_Tapchi where TenB_TC like N'Phụ nữ' and MSb_tc like 'PN%'

--Q3: Cho biết tên các khách hàng có đặt mua báo phụ nữ
select distinct Khachhang.MaKH, TenKH, DiachiKH
from Bao_Tapchi, Khachhang, KH_Datbao
where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and Khachhang.MaKH = KH_Datbao.MaKH and KH_Datbao.MSb_tc like 'PN%'

--Q4: Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ
select Khachhang.MaKH, TenKH, DiachiKH
from Bao_Tapchi, Khachhang, KH_Datbao
where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and Khachhang.MaKH = KH_Datbao.MaKH and Bao_Tapchi.MSb_tc like 'PN%' and Bao_Tapchi.TenB_TC like N'Phụ nữ'

--Q5: Cho biết các khách hàng không đặt mua báo Thanh niên
select * from Khachhang
where Khachhang.MaKH not in(select a.MaKH from Khachhang a, KH_Datbao b where a.MaKH = b.MaKH and b.MSb_tc like 'TN01')

--Q6: Cho biết số tờ báo mà mỗi khách hàng đặt mua
select Khachhang.MaKH, TenKH, SUM(SLuongMua) as TongSLuongMua
from Bao_Tapchi, KH_Datbao, Khachhang
where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and KH_Datbao.MaKH = Khachhang.MaKH
group by Khachhang.MaKH, TenKH

--Q7: Cho biets số khách hàng đặt mua báo trong năm 2004
select COUNT(distinct KH_Datbao.MaKH) as SoKHDMua
from KH_Datbao
where YEAR(NgayDMua) = 2004

--Q8: Cho biết thông tin đặt báo của các khách hàng
select *
from Bao_Tapchi, KH_Datbao, Khachhang
where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and KH_Datbao.MaKH = Khachhang.MaKH

--Q9: Cho biết các tờ báo, tạp chí và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó
select TenB_TC, TGPHDKy, SUM(SLuongMua) as TongSLuongMua
from Bao_Tapchi, KH_Datbao, Khachhang
where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and KH_Datbao.MaKH = Khachhang.MaKH
group by TenB_TC, TGPHDKy

--Q10: Cho biết tên các tờ báo dành cho học sinh, sinh viên
select TenB_TC
from Bao_Tapchi
where TenB_TC like N'Tuổi trẻ' and Bao_Tapchi.MSb_tc in(select a.MSb_tc from Bao_Tapchi a where a.TenB_TC like N'Thanh niên')

--Q11: Cho biết những tờ báo không có người đặt mua
select *
from Bao_Tapchi where Bao_Tapchi.MSb_tc not in(select distinct KH_Datbao.MSb_tc from KH_Datbao)

--Q12: Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất
select TenB_TC, TGPHDKy, COUNT(KH_Datbao.MSb_tc) as SoNgMua
from Bao_Tapchi, KH_Datbao, Khachhang
where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and KH_Datbao.MaKH = Khachhang.MaKH
group by TenB_TC, TGPHDKy
having COUNT(KH_Datbao.MSb_tc) >= all(select COUNT(a.MSb_tc) from KH_Datbao a, Khachhang b where a.MaKH = b.MaKH group by a.MSb_tc)

--Q13: Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất
select Khachhang.MaKH ,TenKH, DiachiKH
from Khachhang, KH_Datbao
where Khachhang.MaKH = KH_Datbao.MaKH and KH_Datbao.SLuongMua >= all(select SLuongMua from KH_Datbao)

--Q14: Cho biết tờ báo phát hàng định kỳ một tháng 2 lần
select * from Bao_Tapchi where TGPHDKy = N'Bán nguyệt san'

--Q15: Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên
select Bao_Tapchi.MaBaoTC, Ten, COUNT(Datbao.MaKH) as SoNguoiMua
from Bao_Tapchi, Datbao, Khachhang
where Bao_Tapchi.MaBaoTC = Datbao.MaBaoTC and Khachhang.MaKH = Datbao.MaKH
group by Bao_Tapchi.MaBaoTC, Ten
having COUNT(Datbao.MaKH) >= 3

--Q15: Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên
select Bao_Tapchi.MSb_tc, TenB_TC, COUNT(KH_Datbao.MaKH) as SoNgMua
from Bao_Tapchi, Khachhang, KH_Datbao
where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and Khachhang.MaKH = KH_Datbao.MaKH
group by Bao_Tapchi.MSb_tc, TenB_TC
having COUNT(KH_Datbao.MaKH) >= 3

--III. Hàm và thủ tục
--A. Viết các hàm sau
--a.Tính tổng số tiền mua báo/tạp chí phải giao cho một khách hàng cho trước
create function ufn_TTienBaoTapchi(@MaKH char(4))
	returns int
as
	begin declare @Tong int
	select @Tong = SUM(SLuongMua * Giaban)
		from KH_Datbao, Bao_Tapchi
		where KH_Datbao.MSb_tc = Bao_Tapchi.MSb_tc and MaKH = @MaKH

		return @Tong
	end

select dbo.ufn_TTienBaoTapchi('KH01')

--b. Tính tổng số tiền thu được của một tờ báo/tạp chí cho trước
create function ufn_Doanhthu(@MSBaoTapchi char(4))
	returns int
as
	begin
		declare @Tong int
		select @Tong = SUM(SLuongMua * Giaban)
		from KH_Datbao, Bao_Tapchi
		where KH_Datbao.MSb_tc = Bao_Tapchi.MSb_tc and KH_Datbao.MSb_tc = @MSBaoTapchi
		return @Tong
	end

select dbo.ufn_Doanhthu('PN01')

--B. Viết các thủ tục sau
--1. In danh mục báo, tạp chí phải giao cho một khách hàng cho trước
create proc usp_Indanhmuc_BaoTC
	@MaKH char(4)
as
	select Ten, Dinhky, SoluongMua
	from Bao_Tapchi, Datbao
	where Bao_Tapchi.MaBaoTC = Datbao.MaBaoTC and MaKH = @MaKH
go
exec usp_Indanhmuc_BaoTC 'KH01'

--B. Viết các thủ tục sau
--1. In danh mục báo, tạp chí phải giao cho một khách hàng cho trước
create proc usp_Indanhmuc_BaoTC
	@MaKH char(4)
as
	select TenB_TC, TGPHDKy, SLuongMua
	from Bao_Tapchi, KH_Datbao
	where Bao_Tapchi.MSb_tc = KH_Datbao.MSb_tc and MaKH = @MaKH
go

exec usp_Indanhmuc_BaoTC 'KH01'

--2. In danh sách khách hàng đặt mua báo/tạp chí cho trước
create proc usp_InDSKhachhang
	@MaBaoTC char(4)
as
	select TenKH, Diachi
	from Khachhang, Datbao
	where Khachhang.MaKH = Datbao.MaKH and MaBaoTC = @MaBaoTC
go

--2. In danh sách khách hàng đặt mua báo/tạp chí cho trước
create proc usp_InDSKhachhang
	@MSBaoTapchi char(4)
as
	select TenKH, DiachiKH
	from Khachhang, KH_Datbao
	where Khachhang.MaKH = KH_Datbao.MaKH and MSb_tc = @MSBaoTapchi
go

exec usp_InDSKhachhang 'TT01'