/* Học phần: Cơ sở dữ liệu
   Ngày: 30/04/2020
   Người thực hiện: LÊ SỸ HÙNG
*/
------------------------------------------------
--lệnh tạo CSDL
CREATE DATABASE LAB04_QUANLYDATBAO
go
--lenh su dyng CSDL
use LAB04_QUANLYDATBAO
create table Bao_TChi
(MaBaoTC	char(4) primary key, -- khai bao khóa chính
Ten			nvarchar(30) not null,
DinhKy		nvarchar(20), 
SoLuong		int check(SoLuong>0),
GiaBan		int check(GiaBan>0)
)
go
create table PhatHanh
(
MaBaoTC	char(4) references Bao_TChi(MaBaoTC),
SoBaoTC	int,
NgayPH	datetime,
Primary key (MaBaoTC, SoBaoTC) 
)
go
create table KhachHang
(MaKH	char(4) primary key,
TenKH	nvarchar(30) not null,
DiaChi		nvarchar(50)
)
go
create table DatBao
(
MaKH	char(4) references KhachHang(MaKH),
MaBaoTC	char(4) references Bao_TChi(MaBaoTC),
SLMua	int check(SLMua > 0),
NgayDM datetime,
primary key(MaKH, MaBaoTC) 
)
-----xem dữ liệu------
select * from Bao_TChi
select * from PhatHanh
select * from KhachHang
select * from DatBao
GO
--------Thu Tuc ----------
-- nhap du lieu cho bang Bao TC ----
CREATE PROC usp_INSERT_BaoTChi
@MABaoTC CHAR(4),@Ten NVARCHAR(30),
@DinhKy NVARCHAR(20),@SoLuong INT,@GiaBan INT
AS 
-- KIEM TRA CO TRUNG KHOA CHINH MABAOTC KHONG
IF EXISTS(SELECT * FROM Bao_TChi WHERE MaBaoTC = @MaBaoTC)
	PRINT N'Đã có mã báo'+@MaBaoTC + 'TRong CSDL'
ELSE 
	BEGIN
		INSERT INTO Bao_TChi VALUES (@MABaoTC, @Ten, @DinhKy , @SoLuong , @GiaBan )
		print N'Thêm Báo chí thành công.'
	END
GO
-- thuc hien thu tuc nhap
EXEC usp_INSERT_BaoTChi 'TT01',N'Tuổi Trẻ',N'Nhật Báo',1000,1500
EXEC usp_INSERT_BaoTChi 'KT01',N'Kiến Thức Ngày Nay',N'Bán Nguyệt San',3000,6000
EXEC usp_INSERT_BaoTChi 'TN01',N'Thanh Niên', N'Nhật Báo',1000,2000
EXEC usp_INSERT_BaoTChi 'PN01',N'Phụ Nữ',N'Tuần Báo',2000,4000
EXEC usp_INSERT_BaoTChi 'PN02',N'Phụ Nữ',N'Nhật Báo',1000,2000
-- xem bang 
SELECT * FROM Bao_TChi
GO
-- thu tuc nhap bang phat hanh
CREATE PROC usp_INSERT_PhatHanh
@MaBaoTC CHAR(4),@SoBaoTC INT,@NgayPH DATETIME
AS
-- kiem tra dieu kien--
IF EXISTS(SELECT*FROM Bao_TChi WHERE MaBaoTC = @MaBaoTC)
BEGIN
	IF EXISTS(SELECT*FROM PhatHanh WHERE MaBaoTC = @MaBaoTC
		 AND SoBaoTC = @SoBaoTC)
		PRINT N'Đã tồn tại số báo'+@MaBaoTC +' '+ @SoBaoTC +'trong CSDL.'
	ELSE
		BEGIN
			INSERT INTO PhatHanh VALUES(@MaBaoTC,@SoBaoTC,@NgayPH)
			PRINT N'Thêm Báo Phát Hành Thành Công.'
		END
END
ELSE
PRINT N'vi pham RBTV khoa ngoại :  Không tồn tại mã báo tạp chí '+ @MaBaoTC + ' trong CSDL.'
GO
--thuc hien thu tuc nhap
SET DATEFORMAT DMY
GO
EXEC usp_INSERT_PhatHanh 'TT01',123,'15/12/2005'
EXEC usp_INSERT_PhatHanh 'KT01',70,'15/12/2005'
EXEC usp_INSERT_PhatHanh 'TT01',124,'16/12/2005'
EXEC usp_INSERT_PhatHanh 'TN01',256,'17/12/2005'
EXEC usp_INSERT_PhatHanh 'PN01',45,'23/12/2005'
EXEC usp_INSERT_PhatHanh 'PN02',111,'18/12/2005'
EXEC usp_INSERT_PhatHanh 'PN02',112,'19/12/2005'
EXEC usp_INSERT_PhatHanh 'TT01',125,'17/12/2005'
EXEC usp_INSERT_PhatHanh 'PN01',46,'30/12/2005'
GO
-- xem bang
SELECT * FROM dbo.PhatHanh
Go
-- thu tuc nhao bang khach hanh
CREATE PROC usp_INSERT_KhachHang
@MaKH CHAR(4),@TenKH NVARCHAR(30),@DiaChi NVARCHAR(50)
AS
--kiem tra dieu kien
IF EXISTS(SELECT * FROM KhachHang WHERE MaKH = @MaKH)
PRINT N'Đã Có Khách Hàng'+ @MaKH+'Trong CSDL'
ELSE
	BEGIN
		INSERT INTO KhachHang VALUES(@MaKH,@TenKH,@DiaChi)
		PRINT N'Thêm Khách Hàng Thành Công.'
	END
GO
-- thuc hien thu tuc nhap
EXEC usp_INSERT_KhachHang 'KH01',N'LAN',N'2 NCT'
EXEC usp_INSERT_KhachHang 'KH02',N'NAM',N'32 THĐ'
EXEC usp_INSERT_KhachHang 'KH03',N'NGỌC',N'16 LHP'
-- xem bang khach hang
SELECT * FROM KhachHang
GO
-- ham thu tuc nhap bang
CREATE PROC usp_Insert_DatBao
@MaKH CHAR(4),@MaBaoTC CHAR(4),@SLMua int,@NgayDM DATETIME
AS
-- kiem tra khoa ngoai
IF EXISTS(SELECT*FROM Bao_TChi WHERE MaBaoTC = @MaBaoTC)
AND EXISTS(SELECT*FROM KhachHang WHERE MaKH = @MaKH)
BEGIN
	IF EXISTS(SELECT*FROM DatBao WHERE MaKH = @MaKH
		AND MaBaoTC=@MaBaoTC)
	PRINT N'Đã có thông tin đặt báo'+@MaKH+' '+@MaBaoTC+'Trong CSDL.'
	ELSE
		BEGIN
			INSERT  INTO DatBao VALUES(@MaKH,@MaBaoTC,@SLMua,@NgayDM)
			PRINT N'Thêm Đạt Báo Thành Công'
		END
END
ELSE
	IF NOT EXISTS(SELECT*FROM Bao_TChi WHERE MaBaoTC=@MaBaoTC)
	PRINT N'không có báo tạp chí'+ @MaBaoTC+'Trong CSDL.'
	ELSE
	PRINT N'Không có khách hang'+@MaKH +'Trong CSDL.'
GO
-- thuc hien nhao bang
set dateformat dmy
exec usp_Insert_DatBao 'KH01','TT01',100,'12/01/2000'
exec usp_Insert_DatBao 'KH02','TN01',150,'01/05/2001'
exec usp_Insert_DatBao 'KH01','PN01',200,'25/06/2001'
exec usp_Insert_DatBao 'KH03','KT01',50,'17/03/2002'
exec usp_Insert_DatBao 'KH03','PN02',200,'26/08/2003'
exec usp_Insert_DatBao 'KH02','TT01',250,'15/01/2004'
exec usp_Insert_DatBao 'KH01','KT01',300,'14/10/2004'
-- xem bang
SELECT*FROM DatBao
GO
------ truy van Du liệu-----------------------
--1/ Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) 
--có định kỳ phát hành hàng tuần (Tuần báo). 
SELECT MaBaoTC,Ten,GiaBan
FROM Bao_TChi
WHERE DinhKy LIKE N'Tuần Báo'
GO
--2) Cho biết thông tin về các tờ báo thuộc loại báo 
--phụ nữ (mã báo tạp chí bắt đầu bằng PN). 
SELECT MaBaoTC,Ten,DinhKy,SoLuong,GiaBan
FROM Bao_TChi
WHERE Ten LIKE N'Phụ Nữ' AND MaBaoTC LIKE 'PN%'
GO
--3) Cho biết tên các khách hàng có đặt mua báo phụ nữ 
--(mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
SELECT DISTINCT KhachHang.MaKH,TenKH,DiaChi,Bao_TChi.MaBaoTC
FROM Bao_TChi,DatBao,KhachHang
WHERE Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
AND Bao_TChi.MaBaoTC LIKE 'PN%'
AND Bao_TChi.Ten LIKE N'Phụ Nữ'
GO
--4) Cho biết tên các khách hàng có đặt mua tất cả các báo 
--phụ nữ (mã báo tạp chí bắt đầu bằng PN). 
SELECT DatBao.MaKH,TenKH,DiaChi,Bao_TChi.MaBaoTC
FROM Bao_TChi,DatBao,KhachHang
WHERE Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
AND Bao_TChi.MaBaoTC LIKE 'PN%'
AND Bao_TChi.Ten LIKE N'Phụ Nữ'
GO
--5) Cho biết các khách hàng không đặt mua báo thanh niên.
SELECT DISTINCT KhachHang.MaKH,TenKH
FROM Bao_TChi,DatBao,KhachHang
WHERE Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
AND Bao_TChi.Ten NOT LIKE N'Thanh niên'
AND KhachHang.MaKH NOT IN (SELECT KhachHang.MaKH
						FROM Bao_TChi,DatBao,KhachHang
						WHERE Bao_TChi.MaBaoTC=DatBao.MaBaoTC 
						AND DatBao.MaKH=KhachHang.MaKH
						AND Bao_TChi.Ten LIKE N'Thanh niên')						
GO
--6) Cho biết số tờ báo mà mỗi khách hàng đã đặt mua. 
SELECT TenKH,DiaChi,SLMua,NgayDM,Ten
FROM Bao_TChi,DatBao,KhachHang
WHERE  Bao_TChi.MaBaoTC=DatBao.MaBaoTC
	AND DatBao.MaKH=KhachHang.MaKH
GO
--7) Cho biết số khách hàng đặt mua báo trong năm 2004.
SELECT TenKH,DiaChi,SLMua,NgayDM,Ten
FROM Bao_TChi,DatBao,KhachHang
WHERE  Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
	AND YEAR(NgayDM)= 2004
GO
--8) Cho biết thông tin đặt mua báo của các 
--khách hàng (TenKH, TeN, DinhKy, SLMua, SoTien), 
--trong đó SoTien = SLMua * DonGia.
SELECT KhachHang.TenKH,Ten,DinhKy,SLMua,SUM(SLMua*GiaBan) AS SoTien
FROM Bao_TChi,DatBao,KhachHang
WHERE  Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
GROUP BY KhachHang.TenKH,Ten,DinhKy,SLMua,GiaBan
GO
--9) Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng
-- số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
SELECT Ten,DinhKy,KhachHang.MaKH,TenKH,SUM(SLMua) AS TongSLDM
FROM Bao_TChi,DatBao,KhachHang
WHERE Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
GROUP BY Ten,DinhKy,KhachHang.MaKH,TenKH,SLMua
GO
--10) Cho biết tên các tờ báo dành cho học sinh, sinh viên
-- (mã báo tạp chí bắt đầu bằng HS). ###hs khong co trong csdl
SELECT MaBaoTC,Ten
FROM Bao_TChi
WHERE MaBaoTC LIKE 'HS%'
GO
--11) Cho biết những tờ báo không có người đặt mua. 
SELECT *
FROM Bao_TChi
WHERE  MaBaoTC NOT IN (SELECT MaBaoTC
					FROM DatBao)
GO
--TEST--- thêm vào một tờ báo----
INSERT INTO Bao_TChi 
VALUES ('PN03',N'tuổi teen', N'Tuần Báo',2000,5000);
SELECT * FROM Bao_TChi 
GO
---- trả lại bảng ban đầu----
DELETE FROM Bao_TChi
WHERE MaBaoTC = 'PN03'
SELECT * FROM Bao_TChi
GO
--12) Cho biết tên, định kỳ của những tờ báo có 
--nhiều người đặt mua nhất. 
SELECT DatBao.MaBaoTC,Ten,DinhKy, COUNT( DatBao.MaBaoTC) AS SONGUOIMUA
FROM Bao_TChi,DatBao,KhachHang
WHERE Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
GROUP BY  DatBao.MaBaoTC,Ten,DinhKy
HAVING COUNT(DatBao.MaBaoTC) >= ALL(SELECT COUNT( MaBaoTC)
									FROM DatBao,KhachHang
									WHERE DatBao.MaKH=KhachHang.MaKH
									GROUP BY DatBao.MaBaoTC)		
GO
--13) Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất. 
SELECT KhachHang.MaKH,TenKH,SLMua,MaBaoTC
FROM KhachHang,DatBao
WHERE KhachHang.MaKH=DatBao.MaKH
AND DatBao.SLMua >= ALL(SELECT SLMua
						FROM DatBao)
GO
---14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
SELECT PhatHanh.MaBaoTC,Ten,DinhKy
FROM Bao_TChi,PhatHanh
WHERE  Bao_TChi.MaBaoTC=PhatHanh.MaBaoTC
GROUP BY PhatHanh.MaBaoTC,Ten,DinhKy
HAVING COUNT(PhatHanh.MaBaoTC) = 2
ORDER BY MaBaoTC,Ten
GO
--- 15) Cho biết các tờ báo, tạp chi có từ 3 khách hàng đặt mua trở lên.
SELECT Bao_TChi.MaBaoTC,Ten,COUNT(DatBao.MaKH) AS SONGUOIMUA
FROM Bao_TChi,DatBao,KhachHang
WHERE Bao_TChi.MaBaoTC=DatBao.MaBaoTC AND DatBao.MaKH=KhachHang.MaKH
GROUP BY Bao_TChi.MaBaoTC,Ten
HAVING COUNT( DatBao.MaKH) >= 3
ORDER BY Bao_TChi.MaBaoTC
GO
--- xuat bang dat bao ----
SELECT * FROM DatBao
GO		
--TEST--- thêm vào một tờ báo----
SET DATEFORMAT DMY
INSERT INTO DatBao
VALUES ('KH03','TT01',200,'26/08/2004');
SELECT * FROM DatBao
GO
---- trả lại bảng ban đầu----
DELETE FROM DatBao
WHERE MaKH = 'KH03'AND MaBaoTC = 'TT01'AND SLMua=200
SELECT * FROM DatBao
GO
----Ham Thu Tuc --------

