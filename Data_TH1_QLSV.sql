CREATE DATABASE TH1_QLSV
GO

USE TH1_QLSV
GO

CREATE TABLE DMKhoa
(
    MaKhoa VARCHAR(5) PRIMARY KEY,
    TenKhoa NVARCHAR(30)
)
GO

CREATE TABLE DMNganh
(
    MaNganh VARCHAR(8) PRIMARY KEY,
    TenNganh NVARCHAR(50),
    MaKhoa VARCHAR(5),
    CONSTRAINT FK_DMNganh_DMKhoa FOREIGN KEY(MaKhoa) REFERENCES DMkhoa(MaKhoa)
)
GO

CREATE TABLE DMLop
(
    MaLop VARCHAR(5) PRIMARY KEY,
    TenLop NVARCHAR(40),
    MaNganh VARCHAR(8),
    KhoaHoc int,
    HeDT VARCHAR(5),
    NamNhapHoc int,
    CONSTRAINT FK_DMLop_DMNganh FOREIGN KEY(MaNganh) REFERENCES DMNganh(MaNganh)
)
GO

CREATE TABLE DMHocPhan
(
    MaHP VARCHAR(3) PRIMARY KEY,
    TenHP NVARCHAR(30),
    SoTc int,
    MaNganh VARCHAR(8),
    HocKy int
)
GO

CREATE TABLE SinhVien
(
    MaSV VARCHAR(5) PRIMARY KEY,
    HoTen NVARCHAR(30),
    MaLop VARCHAR(5),
    GioiTinh bit,
    NgaySinh DATE,
    DiaChi NVARCHAR(50),
    
    CONSTRAINT FK_SinhVien_DMLop FOREIGN KEY(MaLop) REFERENCES DMLop(MaLop)
)
GO

CREATE TABLE DiemHP
(
    MaSV VARCHAR(5), 
    MaHP VARCHAR(3),
    DiemHP FLOAT,

    CONSTRAINT PK_DiemHP PRIMARY KEY(MaSV, MaHP),
    CONSTRAINT FK_DiemHP_SinhVien FOREIGN KEY(MaSV) REFERENCES SinhVien(MaSV),
    CONSTRAINT FK_DiemHP_DMHocPhan FOREIGN KEY(MaHP) REFERENCES DMHocPhan(MaHP)
)
GO

--Nhập liệu bảng DMKhoa
INSERT INTO dbo.DMKhoa(MaKhoa, TenKhoa)
VALUES('CN', N'Công nghệ')
INSERT INTO dbo.DMKhoa(MaKhoa, TenKhoa)
VALUES('KT', N'Kinh Tế')
INSERT INTO dbo.DMKhoa(MaKhoa, TenKhoa)
VALUES('NN', N'Nông nghiệp')

--Nhập liệu bảng DMNganh
INSERT INTO dbo.DMNganh(MaNganh, TenNganh, MaKhoa)
VALUES('140902', N'Bảo vệ thực vật', 'NN')
INSERT INTO dbo.DMNganh(MaNganh, TenNganh, MaKhoa)
VALUES('480202', N'Công nghệ thông tin', 'CN')

--Nhập liệu bảng DMLop
INSERT INTO dbo.DMLop(MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
VALUES('CT11', N'Trung cấp tin học', '480202', 11, 'TC', 2013)
INSERT INTO dbo.DMLop(MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
VALUES('CT12', N'Cao đẳng tin học', '480202', 12, N'CD', 2013)
INSERT INTO dbo.DMLop(MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
VALUES('CT13', N'Cao đẳng tin học', '480202', 13, 'CD', 2014)

--Nhập liệu bảng SinhVien
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('001', N'Phan Thanh An', 'CT12', 0, '1990-12-09', N'Hồng Ngự')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('002', N'Nguyễn Thị Cẩm Diệu', 'CT12', 1, '1994-12-01', N'Cao Lãnh')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('003', N'Võ Thị Hà', 'CT12', 1, '1995-02-07', N'Châu Thành')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('004', N'Trần Hoàng Nam', 'CT12', 0, '1994-05-04', N'Lấp Vò')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('005', N'Trần Văn Hoàng', 'CT13', 0, '1995-04-08', N'Tam Nông')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('006', N'Trần Thị Thảo', 'CT13', 1, '1995-12-06', N'Cao Lãnh')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('007', N'Lê Thị Sen', 'CT13', 1, '1994-12-08', N'Sa Đéc')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('008', N'Nguyễn Văn Huy', 'CT11', 0, '1995-04-06', N'Lai Vung')
INSERT INTO dbo.SinhVien(MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
VALUES('009', N'Trần Thị Hoa', 'CT11', 1, '1994-09-08', N'Thanh Bình')

--Nhập liệu bảng DMHocPhan
INSERT INTO dbo.DMHocPhan(MaHP, TenHP, SoTc, MaNganh, HocKy)
VALUES('001', N'Toán cao cấp A1', 4, '480202', 1)
INSERT INTO dbo.DMHocPhan(MaHP, TenHP, SoTc, MaNganh, HocKy)
VALUES('002', N'Tiếng Anh 1', 3, '480202', 1)
INSERT INTO dbo.DMHocPhan(MaHP, TenHP, SoTc, MaNganh, HocKy)
VALUES('003', N'Vật lý đại cương', 4, '480202', 1)
INSERT INTO dbo.DMHocPhan(MaHP, TenHP, SoTc, MaNganh, HocKy)
VALUES('004', N'Tiếng Anh 2', 7, '480202', 1)
INSERT INTO dbo.DMHocPhan(MaHP, TenHP, SoTc, MaNganh, HocKy)
VALUES('005', N'Tiếng Anh 1', 3, '140902', 2)
INSERT INTO dbo.DMHocPhan(MaHP, TenHP, SoTc, MaNganh, HocKy)
VALUES('006', N'Xác suất thống kê', 3, '140902', 2)

--Nhập liệu bảng DiemHP
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('002', '002', 5.9)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('002', '003',4.5)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('003', '001', 4.3)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('003', '002', 6.7)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('003', '003', 7.3)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('004', '001', 4.0)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('004', '002', 5.2)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('004', '003', 3.5)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('005', '001', 9.8)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('005', '002', 7.9)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('005', '003', 7.5)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('006', '001', 6.1)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('006', '002', 5.6)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('006', '003', 4.0)
INSERT INTO dbo.DIemHP(MaSV, MaHP, DiemHP)
VALUES('007', '001', 6.2)

