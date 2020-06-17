/*Học phần: Cơ sở dữ liệu
Ngày: 11/05/2020
Người thực hiện: Huỳnh Thiên Tân
MSSV: 1812841
Lab06: Quản lý học viên*/

create database Lab06_QuanlyHocvien
go

use Lab06_QuanlyHocvien

create table Cahoc
(MaCHoc tinyint primary key,
GioBDau datetime not null,
GioKThuc datetime not null)

create table Giaovien
(MSgv char(4) primary key,
HoGV nvarchar(20) not null,
TenGV nvarchar(10) not null,
Dienthoai varchar(11) not null)

create table LopDTao
(MaLop char(4) primary key,
TenLop nvarchar(20) not null,
NgayKGiang datetime not null,
Hocphi int not null,
MaCHoc tinyint references Cahoc(MaCHoc),
Sotiet int not null,
SoHVien int,
MSgv char(4) references Giaovien(MSgv))

create table Hocvien
(MShv char(4) primary key,
HoHV nvarchar(20) not null,
TenHV nvarchar(10) not null,
NgSinh datetime not null,
GTinh nvarchar(4),
MaLop char(4) references LopDTao(MaLop))

create table Hocphi
(SoBLai char(6) primary key,
MShv char(4) references Hocvien(MShv),
NgayTTien datetime not null,
SoTienNop int,
LydoThu nvarchar(50) not null,
Nguoithu nvarchar(30) not null)

--4) Cài đặt ràng buộc toàn vẹn sau:
--a) "Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó."
create trigger tr_GioKT_GioBD
on Cahoc for insert, UPDATE
as
if UPDATE(GioBDau) or UPDATE(GioKThuc)
	if exists(select * from inserted i where i.GioKThuc < i.GioBDau)
	begin
	raiserror(N'Giờ kết thúc không được trước giờ bắt đầu của ca học đó',15,1)
	rollback tran
	end
go

--b) "Sĩ số của một lớp học không quá 30 học viên và đúng bằng số học viên thuộc lớp đó."
create trigger tg_Siso
on LopDTao for insert, UPDATE
as
	if UPDATE(MaLop) or UPDATE(SoHVien)
		begin
			if exists(select * from inserted i where i.SoHVien > 30)
				begin
					raiserror(N'Số học viên của một lớp không quá 30', 15, 1)
					rollback tran
				end
			if exists(select * from inserted i where i.SoHVien <> (select COUNT(MShv) from Hocvien where Hocvien.MaLop = i.MaLop))
				begin
					raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó', 15, 1)
					rollback tran
				end
		end
go

--c: Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học
--Hàm trả về số tiền học phí cần phải trả của một học viên
create function fn_SoTienHocphi_Hocvien(@MSHV char(4)) returns int

as
begin
declare @Hocphi int
set @Hocphi = (select Hocphi from Hocvien, lop where Hocvien.MaLop = Lop.MaLop and MSHV = @MSHV)
return @Hocphi
end

--c: Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học.

--Hàm gọi số tiền học phí cần thu của một học viên
create function fn_SoTienHPhi_Hocvien(@MShv char(4))
	returns int
as
	begin
		declare @Hocphi int
		set @Hocphi = (select Hocphi from Hocvien, LopDTao where Hocvien.MaLop = LopDTao.MaLop and MShv = @MShv)
		return @Hocphi
	end
go
print dbo.fn_SoTienHocphi_Hocvien('0001')

create trigger tg_SoTienThu
on Hocphi for insert, UPDATE
as
	if UPDATE(SoTienNop)
		if exists (select * from Hocphi group by MShv having SUM(SoTienNop) > dbo.fn_SoTienHocphi_Hocvien(MShv))
			begin
				raiserror (N'Tổng số tiền thu của một học viên không được vượt quá học phí của lớp mà học viên theo học', 15, 1)
				rollback tran
			end
go

--4) Tạo các thủ tục (Stored Procedure) sau:
--a) Thêm dữ liệu vào các bảng (đảm bảo các ràng buộc toàn vẹn liên quan)
create proc usp_ThemCahoc
	@MaCHoc tinyint, @GioBDau datetime, @GioKThuc datetime
as
	if exists(select * from Cahoc where MaCHoc = @MaCHoc)
		print N'Đã có ca học ' + @MaCHoc + ' trong CSDL!'
	else
		begin
			insert into Cahoc values(@MaCHoc, @GioBDau, @GioKThuc)
			print N'Thêm thành công!'
		end
go

exec usp_ThemCahoc 1, '7:30', '10:45'
exec usp_ThemCahoc 2, '13:30', '16:45'
exec usp_ThemCahoc 3, '17:30', '20:45'

create proc usp_ThemGiaovien
	@MSgv char(4), @HoGV nvarchar(20), @TenGV nvarchar(10), @Dienthoai varchar(11)
as
	if exists(select * from Giaovien where MSgv = @MSgv)
		print N'Đã tồn tại ' + @MSgv
	else
		begin
			insert into Giaovien values(@MSgv, @HoGV, @TenGV, @Dienthoai)
			print N'Thêm thành công!'
		end
go

exec usp_ThemGiaovien 'G001', N'Lê Hoàng', N'Anh', '858936'
exec usp_ThemGiaovien 'G002', N'Nguyễn Ngọc', N'Lan', '845623'
exec usp_ThemGiaovien 'G003', N'Trần Minh', N'Tùng', '823456'
exec usp_ThemGiaovien 'G004', N'Võ Thanh', N'Trung', '841256'

create proc usp_ThemLophoc
	@MaLop char(4), @tenlop nvarchar(20), @ngaykg datetime, @hocphi int, @Ca tinyint, @sotiet int, @SoHV int, @MSGV char(4)
as
	if exists(select * from Cahoc where Ca = @Ca) and exists(select * from Giaovien where MSGV = @MSGV)
		begin
			if exists(select * from Lop where MaLop = @MaLop) 
				print N'Đã có lớp ' + @MaLop + ' trong CSDL!'
			else
				begin				
					insert into Lop values (@MaLop, @tenlop, @ngaykg, @hocphi, @Ca, @sotiet, @SoHV, @MSGV)
					print N'Thêm lớp học thành công!'
				end
		end
	else
		if not exists(select * from Cahoc where Ca = @ca)
			print N'Không có ca học ' + @ca + ' trong CSDL!'
		else
			print N'Không có giáo viên ' + @MSGV + ' trong CSDL!'


create proc usp_ThemLophoc
	@MaLop char(4), @TenLop nvarchar(20), @NgayKGiang datetime, @Hocphi int, @MaCHoc tinyint, @Sotiet int, @SoHVien int, @MSgv char(4)
as
	if exists(select * from Cahoc where MaCHoc = @MaCHoc) and exists(select * from Giaovien where MSgv = @MSgv)
		begin
			if exists(select * from LopDTao where MaLop = @MaLop)
				print N'Đã có lớp '	 + @MaLop
			else
				begin
					insert into LopDTao values (@MaLop, @TenLop, @NgayKGiang, @Hocphi, @MaCHoc, @Sotiet, @SoHVien, @MSGV)
					print N'Thêm lớp học thành công!'
				end
		end
	else
		if not exists(select * from Cahoc where MaCHoc = @MaCHoc)
			print N'Không có ca học ' + @MaCHoc + ' trong CSDL!'
		else
			print N'Không có giáo viên ' + @MSgv + ' trong CSDL!'
go

set dateformat dmy
go
exec usp_ThemLophoc 'A075', N'Access 2-4-6', '18/12/2008', 150000, 3, 60, 3, 'G003'
exec usp_ThemLophoc 'E114', N'Excel 3-5-7', '02/01/2008', 120000, 1, 45, 3, 'G003'
exec usp_ThemLophoc 'A115', N'Excel 2-4-6', '22/01/2008', 120000, 3, 45, 0, 'G001'
exec usp_ThemLophoc 'W123', N'Word 2-4-6', '18/02/2008', 100000, 3, 30, 1, 'G001'
exec usp_ThemLophoc 'W124', N'Word 3-5-7', '01/03/2008', 100000, 1, 30, 0, 'G002'

create proc usp_ThemHocvien
	@MShv char(4), @HoHV nvarchar(20), @TenHV nvarchar(10), @NgSinh datetime, @GTinh nvarchar(4), @MaLop char(4)
as
	if exists(select * from LopDTao where MaLop = @MaLop)
		begin
			if exists(select * from Hocvien where MShv = @MShv)
				print N'Đã tồn tại mã số học viên trong CSDL!'
			else
				begin
					insert into Hocvien values(@MShv, @HoHV, @TenHV, @NgSinh, @GTinh, @MaLop)
					print N'Thêm học viên thành công!'
				end
		end
	else
		print N'Lớp ' + @MaLop + N' Không tồn tại trong csdl'
go

set dateformat dmy
go
exec usp_ThemHocvien '0001', N'Lê Văn', N'Minh', '10/06/1988', N'Nam', 'A075'
exec usp_ThemHocvien '0002', N'Nguyễn Thị', N'Mai', '20/04/1988', N'Nữ', 'A075'
exec usp_ThemHocvien '0003', N'Lê Ngọc', N'Tuấn', '10/06/1984', N'Nam', 'A075'
exec usp_ThemHocvien '0004', N'Vương Tuấn', N'Vũ', '25/03/1979', N'Nam', 'E114'
exec usp_ThemHocvien '0005', N'Lý Ngọc', N'Hân', '01/12/1985', N'Nữ', 'E114'
exec usp_ThemHocvien '0006', N'Trần Mai', N'Linh', '04/06/1980', N'Nữ', 'E114'
exec usp_ThemHocvien '0007', N'Nguyễn Ngọc', N'Tuyết', '12/05/1986', N'Nữ', 'W123'

create PROC usp_ThemHocPhi
@SoBL char(6), @MSHV char(4), @NgayThu Datetime, @SoTien	int, @NoiDung nvarchar(50), @NguoiThu nvarchar(30)
As
	If exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocPhi where SoBL = @SoBL) --kiểm tra có trùng khóa(SoBL) 
			print N'Đã có số biên lai học phí này trong CSDL!'
		else
		 begin
			insert into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
			print N'Thêm biên lai học phí thành công.'
		 end
	  End
	Else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này!'
go

create proc usp_ThemHocphi
	@SoBLai char(6), @MShv char(4), @NgayTTien datetime, @SoTienNop int, @LydoThu nvarchar(50), @Nguoithu nvarchar(30)
as
	if exists(select * from Hocvien where MShv = @MShv)
		begin
			if exists(select * from Hocphi where SoBLai = @SoBLai)
				print N'Đã có số biên lai học phí này trong CSDL!'
			else
				begin
					insert into Hocphi values(@SoBLai, @MShv, @NgayTTien, @SoTienNop, @LydoThu, @Nguoithu)
					print N'Thêm thành công'
				end
		end
	else
		print N'Học viên ' + @MShv + N' không tồn tại trong csdl'
go

set dateformat dmy
go
exec usp_ThemHocphi 'A07501', '0001', '16/12/2008', 150000, 'HP Access 2-4-6', N'Lan'
exec usp_ThemHocphi 'A07502', '0002', '16/12/2008', 100000, 'HP Access 2-4-6', N'Lan'
exec usp_ThemHocphi 'A07503', '0003', '18/12/2008', 150000, 'HP Access 2-4-6', N'Vân'
exec usp_ThemHocphi 'A07504', '0002', '15/01/2009', 50000, 'HP Access 2-4-6', N'Vân'
exec usp_ThemHocphi 'E11401', '0004', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocphi 'E11402', '0005', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocphi 'E11403', '0006', '02/01/2008', 80000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocphi 'W12301', '0007', '18/02/2008', 100000, 'HP Word 2-4-6', N'Lan'

create proc Danhsach_Hocvien
	@MaLop char(4)
as
	select MShv, HoHV, TenHV, NgSinh, GTinh
	from Hocvien, LopDTao
	where Hocvien.MaLop = LopDTao.MaLop and LopDTao.MaLop = @MaLop
go

exec Danhsach_Hocvien 'A075'

--Câu 5: Cài đặt các hàm (Function)
--Tính tổng số học phí đã thu được của một lớp khi biết mã lớp
create function fn_TongSoHocphi_Lop(@MaLop char(4)) returns int
as
	begin
	declare @TongHocphi int
	set @TongHocphi = (select SUM(SoTien) from Hocphi where LEFT(SoBL,4) = @MaLop)
	return @TongHocphi
	end
go
/*print dbo.fn_TongSoHocphi_Lop('A075')*/

--Tính tổng số học phí thu được trong một khoảng thời gian cho trước
create function fn_TongSoHocphi_KhoangThoigian (@NgayBD datetime, @NgayKT datetime) returns int
as
begin
declare @Hocphi int
set @Hocphi = (select SUM(SoTien) from Hocphi where Ngaythu between @NgayBD and @NgayKT)
return @Hocphi
end
go

/*print dbo.fn_TongSoHocphi_KhoangThoigian('16/12/2008','18/12/2008')*/

--Cho biết một học viên cho trước đã nộp đủ học phí hay chưa
create function fn_KiemtraDongDuHocphi (@MSHV char(4)) returns bit
as
begin
declare @result bit
declare @SoTien int
set @SoTien = (select SUM(SoTien) from Hocphi where MSHV = @MSHV)
if dbo.fn_SoTienHocphi_Hocvien(@MSHV)=@SoTien
	set @result = 1 --Đã đóng đủ
else
	set @result = 0 --Chưa đóng đủ
return @result
end
go
/*print dbo.fn_KiemtraDongDuHocphi('0002')*/

--Hàm sinh mã số học viên theo quy tắc mã số học viên gồm mã lớp của học viên kết hợp với số thứ tự của học viên trong lớp đó
create function fn_SinhMSHV (@MSHV char(4)) returns char (6)
as
	begin
	declare @MaLop char(4)
	declare @MSHV_MAX char(4)
	declare @stt int
	declare @temp varchar(6)
	declare @i int
	set @MSHV=''
	if exists(select * from Hocvien where MSHV = @MSHV)
		begin
		select @MaLop = MaLop
		from Hocvien
		where MSHV = @MSHV
		if not exists(select * from Hocvien where RIGHT(MSHV,1) = 