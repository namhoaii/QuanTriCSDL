--A câu lệnh SQL không kết nối

/*Câu 1
Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ) , Namsinhcủa những sinh viên có họ không bắt đầu bằng chữ N,L,T.
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

/*Câu 2
2. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ),Namsinh của những sinh viên nam học lớp CT11
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

/*Câu 3
3. Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ)của những sinh viên học lớp CT11,CT12,CT13
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

/*Câu 4
Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh (dd/mm/yyyy), GioiTinh (Nam, Nữ),Tuổi của những sinh viên có tuổi từ 19-21.
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

--B Câu lệnh SQL có kết nối
/*Câu 1
1. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP,
MaHP của những sinh viên có điểm HP >= 5.
*/
SELECT sv.MaSV, sv.HoTen, sv.MaLop, d.DiemHP, d.MaHP
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
WHERE d.DiemHP >= 5

/*Câu 2
2. Hiển thị danh sách MaSV, HoTen , MaLop, MaHP,DiemHP được sắp xếp theo ưu tiên Mã lớp, Họ tên tăng dần.
*/

SELECT sv.MaSV, sv.HoTen, sv.MaLop, d.MaHP, d.DiemHP
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
ORDER BY sv.MaLop, sv.HoTen

/*Câu 3
3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP,MaHP
của những sinh viên có điểm HP từ 5 đến 7 ở học kỳ I.
*/
SELECT sv.MaSV, sv.HoTen, sv.MaLop, d.DiemHP, hp.MaHP	
FROM dbo.SinhVien sv
INNER JOIN dbo.DiemHP d ON d.MaSV = sv.MaSV
INNER JOIN dbo.DMHocPhan hp ON hp.MaHP = d.MaHP
WHERE hp.HocKy = 1 AND d.DiemHP BETWEEN 5 AND 7


/*Câu 4
4. Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CN
*/
SELECT sv.MaSV, sv.HoTen, sv.MaLop, l.TenLop, k.MaKhoa
FROM dbo.SinhVien sv
INNER JOIN dbo.DMLop l ON l.MaLop = sv.MaLop
INNER JOIN dbo.DMNganh n ON n.MaNganh = l.MaNganh
INNER JOIN dbo.DMKhoa k ON k.MaKhoa = n.MaKhoa
WHERE k.MaKhoa = 'CN'