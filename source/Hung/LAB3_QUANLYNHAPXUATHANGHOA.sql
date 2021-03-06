------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 17/04/2020
   Người thực hiện: LÊ SỸ HÙNG
*/
------------------------------------------------
--lenh tao CSDL
CREATE DATABASE LAB3_QUANLYNHAPXUATHANGHOA
GO
-- su dung 
USE LAB3_QUANLYNHAPXUATHANGHOA

-- Tao bang
CREATE TABLE HangHoa
(
MaHH CHAR(6) PRIMARY KEY,
TenHH CHAR(100) NOT NULL,
DVT CHAR(4),
SoLuongTon INT
)
SELECT * FROM HangHoa
GO
-- tao bang Doi Tac
CREATE TABLE DoiTac
(
MaDT CHAR(6) PRIMARY KEY,
TenDT NVARCHAR(30) NOT NULL,
DiaChi NVARCHAR(50),
DienThoai CHAR(11),
)
SELECT *FROM DoiTac
GO
--tao bang Kha nang cung cap
CREATE TABLE KhaNangCC
(
MaDT CHAR(6) REFERENCES DoiTac(MaDT),
MaHH CHAR(6) REFERENCES HangHoa(MaHH),
PRIMARY KEY (MaDT,MaHH)
)
SELECT * FROM KhaNangCC
GO
--Tao Bang Hoa Don
CREATE TABLE HoaDon
(
SoHD CHAR(5) PRIMARY KEY,
NgayLapHD DATETIME,
TongTG CHAR(30),
MaDT CHAR(6) REFERENCES DoiTac(MaDT)
)
-- Xem Bang Vua Tao
SELECT * FROM HoaDon
GO
-- Tao Bang CT hoa don
CREATE TABLE CTHoaDon
(
SoHD CHAR(5) REFERENCES HoaDon(SoHD),
MaHH CHAR(6) REFERENCES HangHoa(MaHH),
PRIMARY KEY(SoHD,MaHH),
DonGia INT,
SoLuong INT
)
SELECT * FROM CTHoaDon
GO
-- nhap du lieu cho bang
--Hang Hoa
INSERT INTO HangHoa VALUES ('CPU01','CPU INTERL, CELERRON 600 BOX',N'CÁI','5')
INSERT INTO HangHoa VALUES ('CPU02','CPU INTEL,PIII 700',N'CÁI','10')
INSERT INTO HangHoa VALUES ('CPU03','CPU AMD K7 ATHL,ON 600',N'CÁI','8')
INSERT INTO HangHoa VALUES ('HDD01','HDD 10.2 GB QUANTUM',N'CÁI','10')
INSERT INTO HangHoa VALUES ('HDD02','HDD 13.6 GB SEAGATE',N'CÁI','15')
INSERT INTO HangHoa VALUES ('HDD03','HDD 20 GB QUANTUM',N'CÁI','6')
INSERT INTO HangHoa VALUES ('KB01',' KB GENIUS',N'CÁI','12')
INSERT INTO HangHoa VALUES ('KB02','KB MITSUMIMI',N'CÁI','5')
INSERT INTO HangHoa VALUES ('MB01','GIGABYTE CHIPSET INTEL',N'CÁI','10')
INSERT INTO HangHoa VALUES ('MB02','ACOPR BX CHIPSET VIA',N'CÁI','10')
INSERT INTO HangHoa VALUES ('MBO3','INTEL PHI CHIPSET INTEL',N'CÁI','10')
INSERT INTO HangHoa VALUES ('MB04','ECS CHIPSET SIS',N'CÁI','10')
INSERT INTO HangHoa VALUES ('MB05','ECS CHIPSET VIA',N'CÁI','10')
INSERT INTO HangHoa VALUES ('MNT01','SAMSUNG 14" SYNCMASTER',N'CÁI','5')
INSERT INTO HangHoa VALUES ('MNT02','LG 14"',N'CÁI','5')
INSERT INTO HangHoa VALUES ('MNT03','ACER 14"',N'CÁI','8')
INSERT INTO HangHoa VALUES ('MNT04','pHILIPS 14"',N'CÁI','6')
INSERT INTO HangHoa VALUES ('MNT05','VIEWSONIC 14"',N'CÁI','7')
-- XEM BANG
SELECT * FROM HangHoa
GO
--bang doi tac
INSERT INTO DoiTac VALUES ('CC001',N'Cty TNC','176 BTX Q1-TPHCM','08.8250259')
INSERT INTO DoiTac VALUES ('CC002',N'Cty Hoàng Long','15A TTT Q1-TPHCM','08.8250898')
INSERT INTO DoiTac VALUES ('CC003',N'Cty Hợp Nhất','152 BTX Q1-TPHCM','08.8252376')
INSERT INTO DoiTac VALUES ('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trổi TP.Đà Lạt','063.831129')
INSERT INTO DoiTac VALUES ('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ.N.Trang','058590270')
INSERT INTO DoiTac VALUES ('K0003',N'Trần Nhật Duật',N'Lê Lợi TP.Huế','054.848376')
INSERT INTO DoiTac VALUES ('K0004',N'Phạm Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi Nghĩa-TP.Đà Lạt','063.823409')
-- xem bang
SELECT * FROM DoiTac
GO
--Bang Kha Nang Cung Cap
INSERT INTO KhaNangCC VALUES('CC001','CPU01')
INSERT INTO KhaNangCC VALUES('CC001','HDD03')
INSERT INTO KhaNangCC VALUES('CC001','KB01')
INSERT INTO KhaNangCC VALUES('CC001','MB02')
INSERT INTO KhaNangCC VALUES('CC001','MB04')
INSERT INTO KhaNangCC VALUES('CC001','MNT01')
INSERT INTO KhaNangCC VALUES('CC002','CPU01')
INSERT INTO KhaNangCC VALUES('CC002','CPU02')
INSERT INTO KhaNangCC VALUES('CC002','CPU03')
INSERT INTO KhaNangCC VALUES('CC002','KB02')
INSERT INTO KhaNangCC VALUES('CC002','MB01')
INSERT INTO KhaNangCC VALUES('CC002','MB05')
INSERT INTO KhaNangCC VALUES('CC002','MNT03')
INSERT INTO KhaNangCC VALUES('CC003','HDD01')
INSERT INTO KhaNangCC VALUES('CC003','HDD02')
INSERT INTO KhaNangCC VALUES('CC003','HDD03')
INSERT INTO KhaNangCC VALUES('CC003','MB03')
-- XEM BANG
SELECT * FROM KhaNangCC
GO
SET DATEFORMAT DMY
-- nhap bang hoa don
INSERT INTO HoaDon VALUES('N0001','25/01/2006','-','CC001')
INSERT INTO HoaDon VALUES('N0002','01/05/2006','-','CC002')
INSERT INTO HoaDon VALUES('X0001','12/05/2006','-','K0001')
INSERT INTO HoaDon VALUES('X0002','16/06/2006','-','K0002')
INSERT INTO HoaDon VALUES('X0003','20/04/2006','-','K0001')
-- xem bang
SELECT * FROM HoaDon
GO
-- nhap bang chi tiet Hoa don
INSERT INTO CTHoaDon VALUES('N0001','CPU01','63','10')
INSERT INTO CTHoaDon VALUES('N0001','HDD03','97','7')
INSERT INTO CTHoaDon VALUES('N0001','KB01','3','5')
INSERT INTO CTHoaDon VALUES('N0001','MB02','57','5')
INSERT INTO CTHoaDon VALUES('N0001','MNT01','112','3')
INSERT INTO CTHoaDon VALUES('N0002','CPU02','115','3')
INSERT INTO CTHoaDon VALUES('N0002','KB02','5','7')
INSERT INTO CTHoaDon VALUES('N0002','MNT03','111','5')
INSERT INTO CTHoaDon VALUES('X0001','CPU01','67','2')
INSERT INTO CTHoaDon VALUES('X0001','HDD03','100','2')
INSERT INTO CTHoaDon VALUES('X0001','KB01','5','2')
INSERT INTO CTHoaDon VALUES('X0001','MB02','62','1')
INSERT INTO CTHoaDon VALUES('X0002','CPU01','67','1')
INSERT INTO CTHoaDon VALUES('X0002','KB02','7','3')
INSERT INTO CTHoaDon VALUES('X0002','MNT01','115','2')
INSERT INTO CTHoaDon VALUES('X0003','CPU01','67','1')
INSERT INTO CTHoaDon VALUES('X0003','MNT03','115','2')
-- XEM BANG
SELECT * FROM CTHoaDon
GO
--1) Liệt kê các mặt hàng thuộc loại đĩa cứng.
SELECT *
FROM HangHoa
WHERE HangHoa.MaHH LIKE 'HDD%';
GO
-- 2) Liệt kê các mặt hàng có số lượng tồn trên 10. 
SELECT *
FROM HangHoa
WHERE HangHoa.SoLuongTon > 10
GO
--3) Cho biết thông tin về các nhà cung cấp
-- ở Thành phố Hồ Chí Minh 
SELECT *
FROM DoiTac
WHERE DoiTac.MaDT LIKE 'CC%' AND DoiTac.DiaChi LIKE '%[TPH]CM';
GO
--4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006,
-- thông tin hiển thị gồm: sohd; ngaylaphd; tên, địa chỉ,
-- và điện thoại của nhà cung cấp; số mặt hàng
SET DATEFORMAT DMY
SELECT CTHoaDon.SoHD,NgayLapHD,TenDT,DiaChi,DienThoai,COUNT(CTHoaDon.MaHH) AS SOMATHANG
FROM DoiTac,HoaDon,CTHoaDon
WHERE DoiTac.MaDT = HoaDon.MaDT AND HoaDon.SoHD = CTHoaDon.SoHD
		AND MONTH(NgayLapHD) = 05
		AND YEAR (NgayLapHD) = 2006
		AND HoaDon.SoHD LIKE 'N%' 
GROUP BY CTHoaDon.SoHD,NgayLapHD,TenDT,DiaChi,DienThoai
GO
-- 5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng. 
SELECT DoiTac.MaDT,TenDT,DiaChi,DienThoai,TenHH
FROM DoiTac,HoaDon,CTHoaDon,HangHoa
WHERE DoiTac.MaDT = HoaDon.MaDT AND HoaDon.SoHD = CTHoaDon.SoHD
	AND CTHoaDon.MaHH = HangHoa.MaHH
	AND HangHoa.TenHH LIKE 'HDD%'
	AND CTHoaDon.SoHD LIKE 'N%'		
GO
--6) Cho biết tên các nhà cung cấp có thể 
--cung cấp tất cả các loại đĩa cứng. 
SELECT KhaNangCC.MaDT,TenDT,TenHH, KhaNangCC.MaHH
FROM DoiTac, KhaNangCC, HangHoa, CTHoaDon
WHERE DoiTac.MaDT = KhaNangCC.MaDT AND KhaNangCC.MaHH = HangHoa.MaHH
		AND HangHoa.MaHH = CTHoaDon.MaHH
		AND CTHoaDon.SoHD LIKE 'N%'
		AND HangHoa.TenHH LIKE 'HDD%'
GO
--7) Cho biết tên nhà cung cấp không cung cấp đĩa cứng.
SELECT TenDT,DiaChi,DienThoai,CTHoaDon.MaHH
FROM DoiTac, KhaNangCC,HangHoa,CTHoaDon
WHERE DoiTac.MaDT = KhaNangCC.MaDT AND KhaNangCC.MaHH = HangHoa.MaHH
		AND HangHoa.MaHH = CTHoaDon.MaHH
		AND HangHoa.TenHH NOT LIKE 'HDD%'
		-- vì lấy ở hóa đơn nhập sẽ có đối tác cc
		AND CTHoaDon.SoHD LIKE 'N%'
GROUP BY TenDT,DiaChi,DienThoai,CTHoaDon.MaHH
GO
-- 8) Cho biết thông tin của mặt hàng chưa bán được ????
SELECT *
FROM HangHoa
WHERE  MaHH NOT IN (SELECT MaHH
					FROM CTHoaDon
					WHERE CTHoaDon.SoHD LIKE 'X%')
GO
-- 9) Cho biết tên và tổng số lượng bán của mặt 
--hàng bán chạy nhất (tính theo số lượng).
SELECT TenHH,CTHoaDon.MaHH,SoLuong,CTHoaDon.SoHD
FROM HangHoa,CTHoaDon,HoaDon
WHERE HangHoa.MaHH = CTHoaDon.MaHH AND CTHoaDon.SoHD = HoaDon.SoHD
	AND HoaDon.SoHD LIKE 'X%'	
	AND CThoaDon.SoLuong >= ALL(SELECT CTHoaDon.SoLuong
							FROM CTHoaDon
							WHERE CTHoaDon.SoHD LIKE 'X%')
GO
--10) Cho biết tên và tổng số lượng của mặt hàng
-- nhập về ít nhất.
SELECT TenHH,SoLuong,CTHoaDon.SoHD
FROM HangHoa,CTHoaDon,HoaDon
WHERE HangHoa.MaHH = CTHoaDon.MaHH AND CTHoaDon.SoHD = HoaDon.SoHD
AND HoaDon.SoHD LIKE 'N%'
AND CTHoaDon.SoLuong <= ALL(SELECT CTHoaDon.SoLuong
							FROM CTHoaDon
							WHERE CTHoaDon.SoHD LIKE 'N%')
GO

-- 11) Cho biết hóa đơn nhập nhiều mặt hàng nhất. 
SELECT CTHoaDon.SoHD,CTHoaDon.MaHH,TenHH,SoLuong,DVT
FROM HoaDon,CTHoaDon,HangHoa
WHERE HoaDon.SoHD = CTHoaDon.SoHD AND CTHoaDon.MaHH = HangHoa.MaHH
AND CTHoaDon.SoHD LIKE 'N%'
--12) Cho biết các mặt hàng không được nhập hàng 
--trong tháng 1/2006 
SELECT TenHH,SoLuong AS SoLuongNhap,CONVERT(char(10),NgayLapHD, 103) AS NgayNhap,
		CTHoaDon.MaHH,CTHoaDon.SoHD
FROM HangHoa,CTHoaDon, HoaDon
WHERE HangHoa.MaHH = CTHoaDon.MaHH AND CTHoaDon.SoHD = HoaDon.SoHD
		AND HoaDon.SoHD LIKE 'N%'
		AND MONTH(NgayLapHD) != 1
		OR YEAR(NgayLapHD) != 2006
GO
--13) Cho biết tên các mặt hàng không bán được 
-- trong tháng 6/2006
SELECT DISTINCT TenHH,SoLuong,CONVERT(char(10),NgayLapHD, 103) AS NgayXuat
FROM HangHoa,CTHoaDon,HoaDon
WHERE HangHoa.MaHH = CTHoaDon.MaHH AND CTHoaDon.SoHD = HoaDon.SoHD
		AND HoaDon.SoHD NOT LIKE 'X0002'
		AND MONTH(NgayLapHD) != 6
		OR YEAR(NgayLapHD) != 2006
GO
-- 14) Cho biết cửa hàng bán bao nhiêu mặt hàng
-- cach 1
SELECT TenHH
FROM HangHoa
GO
-- xe xet tren hoa don nhap
--SELECT TenHH,CTHoaDon.MaHH,SoHD
--FROM HangHoa,CTHoaDon
--WHERE HangHoa.MaHH = CTHoaDon.MaHH
--AND CTHoaDon.SoHD LIKE 'N%'
	-- vì nhập về của hàng thì sẽ có bán
GO
-- 15) Cho biết số mặt hàng mà từng nhà cung 
--cấp có khả năng cung cấp.
SELECT TenDT,TenHH 
FROM DoiTac,KhaNangCC,HangHoa,CTHoaDon
WHERE DoiTac.MaDT = KHaNangCC.MaDT AND KHaNangCC.MaHH = HangHoa.MaHH
	AND HangHoa.MaHH = CTHoaDon.MaHH
	--lấy từ hóa đơn nhập sẽ có tên đối tác cc
	AND CTHoaDon.SoHD LIKE 'N%'
GROUP BY TenDT,TenHH 
GO
-- 16) Cho biết thông tin của khách hàng có 
--giao dịch với cửa hàng nhiều nhất.
--??
SELECT TenDT,DiaChi,DienThoai
FROM DoiTac,HoaDon,CTHoaDon
WHERE DoiTac.MaDT = HoaDon.MaDT AND HoaDon.SoHD = CTHoaDon.SoHD
GO
-- 17) Tính tổng doanh thu năm 2006. 
--cap nhat ô TongTG cho hoa don dùng để text
SELECT HoaDon.SoHD,NgayLapHD,MaHH,DonGia,SoLuong,SUM(SoLuong * DonGia) AS TONGTG
FROM HoaDon,CTHoaDon
WHERE HoaDon.SoHD = CTHoaDon.SoHD
GROUP BY HoaDon.SoHD,NgayLapHD,MaHH,DonGia,SoLuong
HAVING HoaDon.SoHD LIKE 'X%'
ORDER BY HoaDon.SoHD
--tinh doanh thu
SELECT SUM(SoLuong * DonGia) AS TONGDOANHTHU
FROM CTHoaDon
WHERE CTHoaDon.SoHD LIKE 'X%'
GO
--18) Cho biết loại mặt hàng bán chạy nhất.
SELECT HangHoa.MaHH,TenHH,DVT,SoLuong,CTHoaDon.SoHD
FROM HangHoa,CTHoaDon,HoaDon
WHERE HangHoa.MaHH = CTHoaDon.MaHH AND CTHoaDon.SoHD = HoaDon.SoHD
AND HoaDon.SoHD LIKE 'X%'
AND CTHoaDon.SoLuong >= ALL(SELECT CTHoaDon.SoLuong
							FROM CTHoaDon
							WHERE  CTHoaDon.SoHD LIKE 'X%')
							
GO
--   19) Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm:
-- mahh, tenhh, dvt, tổng số lượng, tổng thành tiền. 
SELECT CTHoaDon.MaHH,TenHH,DVT,SoLuong AS TONGSOLUON,SUM(SoLuong*DonGia) AS TONGTHANHTIEN
FROM HangHoa,CTHoaDon,HoaDon
WHERE HangHoa.MaHH = CTHoaDon.MaHH AND CTHoaDon.SoHD = HoaDon.SoHD
AND HoaDon.SoHD LIKE 'X%'
AND MONTH(NgayLapHD) = 5
AND YEAR(NgayLapHD) = 2006
GROUP BY CTHoaDon.MaHH,TenHH,DVT,SoLuong,DonGia
GO
--20) Liệt kê thông tin của mặt hàng có nhiều người mua nhất.

SELECT HangHoa.MaHH,TenHH, COUNT(DISTINCT MaDT) AS SONGUOIMUA
FROM HangHoa,CTHoaDon,HoaDon
WHERE HangHoa.MaHH = CTHoaDon.MaHH AND CTHoaDon.SoHD = HoaDon.SoHD
AND HoaDon.SoHD LIKE 'X%'
GROUP BY HangHoa.MaHH,TenHH
HAVING COUNT(DISTINCT MaDT) >= ALL(SELECT COUNT(DISTINCT MaDT)
									FROM CTHoaDon,HoaDon
									WHERE CtHoaDon.SoHD = HoaDon.SoHD
									AND CTHoaDon.SoHD LIKE 'X%'
									GROUP BY CTHoaDOn.MaHH)
GO
-- 21) Tính và cập nhật tổng trị giá của các hóa đơn. 
UPDATE HoaDon
SET TongTG = (SELECT SUM(DonGia*SoLuong)
			FROM CTHoaDon
			WHERE CTHoaDon.SoHD = HoaDon.SoHD)
SELECT * FROM HoaDon