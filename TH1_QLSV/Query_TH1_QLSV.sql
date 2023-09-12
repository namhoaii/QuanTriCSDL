--A câu lệnh SQL không kết nối

/*
1. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ) , Namsinh
của những sinh viên có họ không bắt đầu bằng chữ N,L,T.
*/
SELECT MaSV, HoTen, MaLop, CONVERT(VARCHAR, NgaySinh, 103) AS NgaySinh,
CASE
	WHEN GioiTinh = 1 THEN N'Nữ'
	WHEN GioiTinh = 0 THEN 'Nam'
	ELSE 'Error'
END AS GioiTinh,
YEAR(NgaySinh) AS NamSinh
FROM dbo.SinhVien
WHERE HoTen NOT LIKE '% [NLT]% %'

/*
2. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ),
Namsinh của những sinh viên nam học lớp CT11
*/
SELECT MaSV, HoTen, MaLop, CONVERT(VARCHAR, NgaySinh, 103) AS NgaySinh,
CASE
	WHEN GioiTinh = 1 THEN N'Nữ'
	WHEN GioiTinh = 0 THEN 'Nam'
	ELSE 'Error'
END AS GioiTinh,
YEAR(NgaySinh) AS NamSinh
FROM dbo.SinhVien
WHERE GioiTinh = 0 AND MaLop = 'CT11'

/*
3. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ)
của những sinh viên học lớp CT11,CT12,CT13
*/
SELECT MaSV, HoTen, MaLop, CONVERT(VARCHAR, NgaySinh, 103) AS NgaySinh,
CASE
	WHEN GioiTinh = 1 THEN N'Nữ'
	WHEN GioiTinh = 0 THEN 'Nam'
	ELSE 'Error'
END AS GioiTinh,
YEAR(NgaySinh) AS NamSinh
FROM dbo.SinhVien
WHERE MaLop IN ('CT11', 'CT12', 'CT13')

/*
4. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ),
Tuổi của những sinh viên có tuổi từ 19-21.
*/
SELECT MaSV, HoTen, MaLop, CONVERT(VARCHAR, NgaySinh, 103) AS NgaySinh,
CASE
	WHEN GioiTinh = 1 THEN N'Nữ'
	WHEN GioiTinh = 0 THEN 'Nam'
	ELSE 'Error'
END AS GioiTinh,
YEAR(NgaySinh) AS NamSinh
FROM dbo.SinhVien
WHERE (YEAR(GETDATE()) - YEAR(NgaySinh)) BETWEEN 19 AND 21

------------------------------------------------------------------------------------------

--B Câu lệnh SQL có kết nối

/*
1. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP,
MaHP của những sinh viên có điểm HP >= 5.
*/
SELECT sv.MaSV, sv.HoTen, sv.MaLop, d.DiemHP, d.MaHP
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
WHERE d.DiemHP >= 5

/*
2. Hiển thị danh sách MaSV, HoTen , MaLop, MaHP,
DiemHP được sắp xếp theo ưu tiên Mã lớp, Họ tên tăng dần.
*/
SELECT sv.MaSV, sv.HoTen, sv.MaLop, d.MaHP, d.DiemHP
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
ORDER BY sv.MaLop, sv.HoTen

/*
3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP,MaHP
của những sinh viên có điểm HP từ 5 đến 7 ở học kỳ I.
*/
SELECT sv.MaSV, sv.HoTen, sv.MaLop, d.DiemHP, hp.MaHP	
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
WHERE hp.HocKy = 1 AND d.DiemHP BETWEEN 5 AND 7

/*
4. Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CN
*/
SELECT sv.MaSV, sv.HoTen, sv.MaLop, l.TenLop, k.MaKhoa
FROM dbo.SinhVien sv
INNER JOIN dbo.DMLop l ON l.MaLop = sv.MaLop
INNER JOIN dbo.DMNganh n ON n.MaNganh = l.MaNganh
INNER JOIN dbo.DMKhoa k ON k.MaKhoa = n.MaKhoa
WHERE k.MaKhoa = 'CN'

-----------------------------------------------------------------

--C Câu lệnh SQL có từ khóa GROUP BY không điều kiện

/*
1. Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp.
*/
SELECT l.MaLop, l.TenLop, COUNT(*) AS TongSoSV
FROM dbo.SinhVien sv
INNER JOIN dbo.DMLop l ON l.MaLop = sv.MaLop
GROUP BY l.MaLop, l.TenLop


/*
2. Cho biết điểm trung bình chung của mỗi sinh viên, xuất ra bảng mới có tên DIEMTBC,
biết rằng công thức tính DiemTBC như sau: DiemTBC =  (DiemHP * SoDvht) /  (SoDvht)
*/
SELECT sv.MaSV, sv.HoTen,
SUM(d.DiemHP * hp.SoTc) / SUM(hp.SoTc) AS DiemTBC
INTO DiemTBC
FROM dbo.SinhVien sv
LEFT JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
LEFT JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
GROUP BY sv.MaSV, sv.HoTen

/*
3. Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ.
*/
SELECT sv.MaSV, sv.HoTen, hp.TenHP, hp.HocKy, AVG(d.DiemHP) AS DiemTB
FROM dbo.SinhVien sv
LEFT JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
LEFT JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
GROUP BY sv.MaSV, sv.HoTen, hp.TenHP, hp.HocKy


/*
4. Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp
*/
SELECT sv.MaLop, l.TenLop,
CASE
	WHEN sv.GioiTinh = 0 THEN 'Nam'
	ELSE N'Nữ'
END AS GioiTinh,
COUNT(sv.MaSV) AS SoLuong
FROM dbo.SinhVien sv
LEFT JOIN dbo.DMLop l ON l.MaLop = sv.MaLop
GROUP BY sv.MaLop, l.TenLop,
CASE
	WHEN sv.GioiTinh = 0 THEN 'Nam'
	ELSE N'Nữ'
END

--------------------------------------------------------------------
--D. Câu lệnh SQL có từ khoá GROUP BY với điều kiện lọc

/*
1. Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1.
	DiemTBC =  (DiemHP * SoDvht) /  (SoDvht)
*/
SELECT sv.MaSV, sv.HoTen, 
(SUM(d.DiemHP * hp.SoTc) / SUM(hp.SoTc)) AS DiemTBC
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
WHERE hp.HocKy = 1
GROUP BY sv.MaSV, sv.HoTen


/*
2. Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP)
*/
SELECT sv.MaSV, sv.HoTen, COUNT(*) AS SoLuong
FROM dbo.SinhVien sv
LEFT JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
WHERE d.DiemHP IS NULL
GROUP BY sv.MaSV, sv.HoTen


/*
3. Đếm số sinh viên có điểm HP < 5 của mỗi học phần.
*/
SELECT d.MaHP, hp.TenHP, COUNT(*) AS SoLuong
FROM dbo.SinhVien sv 
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
WHERE d.DiemHP < 5
GROUP BY d.MaHP, hp.TenHP


/*
4. Tính tổng số đơn vị học trình có điểm học phần nhỏ hơn 5 của mỗi sinh viên.
*/
SELECT sv.MaSV, sv.HoTen, SUM(hp.SoTc) AS N'Tổng số dvht'
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
WHERE d.DiemHP < 5
GROUP BY sv.MaSV, sv.HoTen


-------------------------------------------------------------------
--E. Câu lệnh SQL có từ khoá GROUP BY với điều kiện nhóm.

/*
1. Cho biết MaLop, TenLop có tổng số sinh viên >10.
*/
SELECT sv.MaLop, l.TenLop, COUNT(*) AS SoLuong
FROM dbo.SinhVien sv
INNER JOIN dbo.DMLop l ON l.MaLop = sv.MaLop
GROUP BY sv.MaLop, l.TenLop
HAVING COUNT(*) > 10

/*
2. Cho biết HoTen sinh viên có điểm Trung bình chung các học phần <3
*/
SELECT sv.HoTen, SUM(d.DiemHP * hp.SoTc) / SUM(hp.SoTc) AS DTB
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
GROUP BY sv.HoTen
HAVING (SUM(d.DiemHP * hp.SoTc) / SUM(hp.SoTc)) < 3


/*
3. Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm nhỏ hơn 5
*/
SELECT sv.HoTen
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
WHERE d.DiemHP < 5
GROUP BY sv.HoTen
HAVING COUNT(*) >= 2


/*
4. Cho biết HoTen sinh viên học TẤT CẢ các học phần ở ngành 140902.
*/
SELECT sv.HoTen
FROM dbo.SinhVien sv
WHERE NOT EXISTS(
	SELECT hp.MaHP FROM dbo.DMHocPhan hp
	WHERE hp.MaNganh = '140902'
	EXCEPT --nếu tất cả các môn ở hp trừ các môn đã học của sv mà tồn tại thì
	SELECT d.MaHP FROM dbo.DiemHP d --sinh viên chưa học hết
	WHERE d.MaSV = sv.MaSV
)
--cách 2
SELECT sv.HoTen, COUNT(d.MaHP) AS SoLuong
FROM dbo.DiemHP d
INNER JOIN dbo.SinhVien sv ON sv.MaSV = d.MaSV
INNER JOIN dbo.DMLop l ON l.MaLop = sv.MaLop
WHERE l.MaNganh = '140902'
GROUP BY sv.HoTen
HAVING COUNT(d.MaHP) = (
	SELECT COUNT(MaHP)
	FROM dbo.DMHocPhan dsub
	WHERE dsub.MaNganh = '140902'
)


/*
5. Cho biết HoTen sinh viên học ít nhất 3 học phần mã ‘001’, ‘002’, ‘003’.
*/
SELECT sv.HoTen
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP hp ON hp.MaSV = sv.MaSV
WHERE hp.MaHP IN ('001', '002', '003')
GROUP BY sv.HoTen
HAVING COUNT(*) >= 3

--------------------------------------------------
--F. Câu lệnh SQL có từ khoá TOP.
/*
1. Cho biết MaSV, HoTen sinh viên có điểm TBC cao nhất ở học kỳ 1
*/
SELECT TOP 1 d.MaSV, sv.HoTen,
SUM(d.DiemHP * hp.SoTc) / SUM(hp.SoTc) AS DiemTBC
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
WHERE hp.HocKy = '1'
GROUP BY d.MaSV, sv.HoTen
ORDER BY DiemTBC DESC


/*
2. Cho biết MaSV, HoTen sinh viên có số học phần điểm HP < 5 nhiều nhất
*/
SELECT TOP 1 sv.MaSV, sv.HoTen, COUNT(*) AS SoHocPhan
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
WHERE d.DiemHP < 5
GROUP BY sv.MaSV, sv.HoTen
ORDER BY SoHocPhan DESC


/*
3. Cho biết MaHP, TenHP có số sinh viên điểm HP < 5 nhiều nhất
*/
SELECT TOP 1 d.MaHP, hp.TenHP, COUNT(d.MaSV) AS SoSV
FROM dbo.DMHocPhan hp
INNER JOIN dbo.DiemHP d ON d.MaHP = hp.MaHP
WHERE d.DiemHP < 5
GROUP BY d.MaHP, hp.TenHP
ORDER BY SoSV DESC


----------------------------------------------------------------------------
--G. Cấu trúc lồng nhau phủ định (KHÔNG, CHƯA).

/*
1. Cho biết Họ tên sinh viên KHÔNG học học phần nào
*/
SELECT sv.HoTen
FROM dbo.SinhVien sv
WHERE sv.MaSV NOT IN (
	SELECT DISTINCT MaSV
	FROM dbo.DiemHP
	)


/*
2. Cho biết Họ tên sinh viên CHƯA học học phần có mã ‘001’
*/
SELECT sv.HoTen
FROM dbo.SinhVien sv
WHERE sv.MaSV NOT IN (
	SELECT MaSV
	FROM dbo.DiemHP
	WHERE MaHP = '001'
)


/*
3. Cho biết Tên học phần KHÔNG có sinh viên điểm HP < 5
*/
SELECT hp.TenHP
FROM dbo.DMHocPhan hp
WHERE hp.MaHP NOT IN (
	SELECT DISTINCT MaHP
	FROM dbo.DiemHP
	WHERE DiemHP < 5
)

/*
4. Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5
*/

SELECT sv.HoTen
FROM dbo.SinhVien sv
WHERE sv.MaSV NOT IN (
	SELECT DISTINCT d.MaSV
	FROM dbo.DiemHP d
	WHERE d.DiemHP < 5
)

