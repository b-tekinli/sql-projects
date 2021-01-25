USE [master]
GO


/****** Veritabanýný Oluþturma ******/


CREATE DATABASE db_PMTP

ON PRIMARY 
(NAME = 'db_PMTP', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\db_PMTP_logdb_PMTP.mdf', SIZE = 5120KB, FILEGROWTH = 1024KB)
LOG ON 
(NAME = 'db_PMTP_log', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\db_PMTP_logdb_PMTP_log.ldf', SIZE = 1024KB , FILEGROWTH = 1024KB)
GO
ALTER DATABASE db_PMTP SET COMPATIBILITY_LEVEL = 150
GO
USE db_PMTP
GO



/****** Tablolarý ve Anahtar Alanlarý Oluþturma – UNIQUE DEFAULT ve PRÝMARY KEYLER TABLOLARIN ÝÇÝNDE BULUNUYOR. ******/


CREATE TABLE tbl_Bolumler
( 
Bolum_ID INT not null  PRIMARY KEY IDENTITY(1,1),
Bolum_Adi nvarchar(27) not null,
Bolum_Tel char(11) not null,
Mudur_ID int not null,
)


CREATE TABLE tbl_Personeller
(
Pers_ID INT not null PRIMARY KEY IDENTITY(1,1),
Pers_Adi nvarchar(30) not null,
Pers_Soyadi nvarchar(30) not null,
[Pers_Ýsim] AS ([Pers_Adi] + [Pers_Soyadi]),
Pers_DTarihi date null,
Pers_Ise_Giris_Tarihi date DEFAULT GETDATE(),
Pers_Isten_Cikis_Tarihi datetime null,
Pers_Adresi nvarchar(300) not null,
Pers_Ili nvarchar(30) not null,
Pers_Kenti nvarchar(30) not null,
Pers_Il_Kodu char(3) not null,
Pers_Tel char(11) not null CONSTRAINT Unq_Pers_Tel UNIQUE(Pers_Tel),
Pers_Cep nvarchar(15) null DEFAULT 02621206141,
Pers_Email nvarchar(120) null,
Bolum_ID int NOT null,
Pers_Maas money null DEFAULT 0,
Pers_Komisyon_Yuzdesi float null DEFAULT 0,
Cinsiyet_ID int null,
Unvan_ID int null,
Pers_SGK_No char(10) null CONSTRAINT Unq_Pers_SGK_No UNIQUE (Pers_SGK_No),
Pers_TC_No nvarchar(11) not null CONSTRAINT Unq_Pers_TC_No UNIQUE (Pers_TC_No),
Pers_Aktif_Mi [bit] not null,
Pers_Foto [image] null,
Pers_CV ntext null,
Pers_CV_File nvarchar(200) null,
Pers_CV_Web nvarchar(3000) null,
Kaydeden nvarchar(100) null,
Kayit_Tarihi smalldatetime null DEFAULT GETDATE(),
)


CREATE TABLE tbl_Kategoriler
(
Kategori_ID INT PRIMARY KEY IDENTITY(1,1),
Cinsiyet char(1) null,
Unvan nvarchar(30) not null,
Kent_Adi nvarchar(30) not null,
Il_Kodu char(3) not null,
Il_Adi nvarchar(20) not null,
Ulke nvarchar(25) not null,
Ay_Adi nvarchar(7) not null,
Kitap_Turu nvarchar(20),
)


CREATE TABLE tbl_PersonelMaaslari
(
Maas_ID INT PRIMARY KEY IDENTITY(1,1),
Pers_ID int not null,
Maas_Odeme_Tarihi date not null,
Maas_Tutari smallmoney not null,
Maas_Komisyon smallmoney not null,
Ay_ID int not null,
[Maas_Toplam]  AS ([Maas_Tutari]+[Maas_Komisyon]),
Maas_Yili date not null,
)



/****** Verileri Girme ******/


insert into tbl_Bolumler(Bolum_Adi,Bolum_Tel,Mudur_ID) values ('Biliþim Sistemi','111','5')
insert into tbl_Bolumler(Bolum_Adi,Bolum_Tel,Mudur_ID) values ('Pazarlama','113','1')
insert into tbl_Bolumler(Bolum_Adi,Bolum_Tel,Mudur_ID) values ('Satýþ','114','1')
insert into tbl_Bolumler(Bolum_Adi,Bolum_Tel,Mudur_ID) values ('Muhasebe','115','2')
insert into tbl_Bolumler(Bolum_Adi,Bolum_Tel,Mudur_ID) values ('Finans','115','4')


insert into tbl_Personeller(Pers_Adi,Pers_Soyadi,Pers_DTarihi,Pers_Ise_Giris_Tarihi,Pers_Isten_Cikis_Tarihi,Pers_Adresi,Pers_Ili,Pers_Kenti,Pers_Il_Kodu,Pers_Tel,Pers_Cep,Pers_Email,Bolum_ID,Pers_Maas,Pers_Komisyon_Yuzdesi,Cinsiyet_ID,Unvan_ID,Pers_SGK_No,Pers_TC_No,Pers_Aktif_Mi,Pers_Foto,Pers_CV,Pers_CV_File,Pers_CV_Web,Kaydeden,Kayit_Tarihi) values('Melike','Þen','07.02.2002','11.11.2020','','4 Temmuz Mah.','Kocaeli','Karamürsel','41','12345678910','6845131831','melike@gmail.com','1','','','0','1','8453121558','45678215469','1','','','','','','')
insert into tbl_Personeller(Pers_Adi,Pers_Soyadi,Pers_DTarihi,Pers_Ise_Giris_Tarihi,Pers_Isten_Cikis_Tarihi,Pers_Adresi,Pers_Ili,Pers_Kenti,Pers_Il_Kodu,Pers_Tel,Pers_Cep,Pers_Email,Bolum_ID,Pers_Maas,Pers_Komisyon_Yuzdesi,Cinsiyet_ID,Unvan_ID,Pers_SGK_No,Pers_TC_No,Pers_Aktif_Mi,Pers_Foto,Pers_CV,Pers_CV_File,Pers_CV_Web,Kaydeden,Kayit_Tarihi) values('Ahmet','Tekin','08.10.1970','01.09.2000','','4 Temmuz Mah. 15/2','Kocaeli','Karamürsel','41','01234567899','6845118321','ahmet@gmail.com','2','','','1','2','8618426545','64651351112','1','','','','','','')
insert into tbl_Personeller(Pers_Adi,Pers_Soyadi,Pers_DTarihi,Pers_Ise_Giris_Tarihi,Pers_Isten_Cikis_Tarihi,Pers_Adresi,Pers_Ili,Pers_Kenti,Pers_Il_Kodu,Pers_Tel,Pers_Cep,Pers_Email,Bolum_ID,Pers_Maas,Pers_Komisyon_Yuzdesi,Cinsiyet_ID,Unvan_ID,Pers_SGK_No,Pers_TC_No,Pers_Aktif_Mi,Pers_Foto,Pers_CV,Pers_CV_File,Pers_CV_Web,Kaydeden,Kayit_Tarihi) values('Selen','Ak','09.12.2000','05.07.2020','','Kentkonutlar','Kocaeli','Karamürsel','41','45674125745','6845131321','selen@gmail.com','3','','','0','3','7624537532','46846512312','1','','','','','','')
insert into tbl_Personeller(Pers_Adi,Pers_Soyadi,Pers_DTarihi,Pers_Ise_Giris_Tarihi,Pers_Isten_Cikis_Tarihi,Pers_Adresi,Pers_Ili,Pers_Kenti,Pers_Il_Kodu,Pers_Tel,Pers_Cep,Pers_Email,Bolum_ID,Pers_Maas,Pers_Komisyon_Yuzdesi,Cinsiyet_ID,Unvan_ID,Pers_SGK_No,Pers_TC_No,Pers_Aktif_Mi,Pers_Foto,Pers_CV,Pers_CV_File,Pers_CV_Web,Kaydeden,Kayit_Tarihi) values('Buse','Yýlmaz','12.12.1999','03.12.2020','','Ferah Mah. Çamlýca','Ýstanbul','Üsküdar','34','78945612332','6851318321','buse@gmail.com','4','','','0','4','7867343455','23453786544','1','','','','','','')
insert into tbl_Personeller(Pers_Adi,Pers_Soyadi,Pers_DTarihi,Pers_Ise_Giris_Tarihi,Pers_Isten_Cikis_Tarihi,Pers_Adresi,Pers_Ili,Pers_Kenti,Pers_Il_Kodu,Pers_Tel,Pers_Cep,Pers_Email,Bolum_ID,Pers_Maas,Pers_Komisyon_Yuzdesi,Cinsiyet_ID,Unvan_ID,Pers_SGK_No,Pers_TC_No,Pers_Aktif_Mi,Pers_Foto,Pers_CV,Pers_CV_File,Pers_CV_Web,Kaydeden,Kayit_Tarihi) values('Aleyna','Öz','11.05.2000','04.02.2020','','Dumlupýnar Mah. 19/05','Trabzon','Of','61','12312312345','68451318321','aleyna@gmail.com','5','','','0','5','4264146748','45126435778','1','','','','','','')


insert into tbl_Kategoriler(Cinsiyet,Unvan,Kent_Adi,Il_Kodu,Il_Adi,Ulke,Ay_Adi,Kitap_Turu) values ('K','VT Yönetimi','Karamürsel','41','Kocaeli','Türkiye','Ocak','Biliþim')
insert into tbl_Kategoriler(Cinsiyet,Unvan,Kent_Adi,Il_Kodu,Il_Adi,Ulke,Ay_Adi,Kitap_Turu) values ('E','Satýþ Elemaný','Karamürsel','41','Kocaeli','Türkiye','Mart','Kentleþme')
insert into tbl_Kategoriler(Cinsiyet,Unvan,Kent_Adi,Il_Kodu,Il_Adi,Ulke,Ay_Adi,Kitap_Turu) values ('K','Pazarlamacý','Karamürsel','41','Kocaeli','Türkiye','Ekim','Bilim')
insert into tbl_Kategoriler(Cinsiyet,Unvan,Kent_Adi,Il_Kodu,Il_Adi,Ulke,Ay_Adi,Kitap_Turu) values ('K','Ofis Yöneticisi','Karamürsel','41','Kocaeli','Türkiye','Aralýk','Öðretim')
insert into tbl_Kategoriler(Cinsiyet,Unvan,Kent_Adi,Il_Kodu,Il_Adi,Ulke,Ay_Adi,Kitap_Turu) values ('K','CIO','Derince','41','Kocaeli','Türkiye','Mayýs','Yönetim')


insert into tbl_PersonelMaaslari(Pers_ID,Maas_Odeme_Tarihi,Maas_Tutari,Maas_Komisyon,Ay_ID,Maas_Yili)values ('1','01.1.2020','5000','600','1','2020')
insert into tbl_PersonelMaaslari(Pers_ID,Maas_Odeme_Tarihi,Maas_Tutari,Maas_Komisyon,Ay_ID,Maas_Yili)values ('2','02.2.2020','3500','600','2','2020')
insert into tbl_PersonelMaaslari(Pers_ID,Maas_Odeme_Tarihi,Maas_Tutari,Maas_Komisyon,Ay_ID,Maas_Yili)values ('3','03.3.2020','3000','500','3','2020')
insert into tbl_PersonelMaaslari(Pers_ID,Maas_Odeme_Tarihi,Maas_Tutari,Maas_Komisyon,Ay_ID,Maas_Yili)values ('4','04.4.2020','7500','650','4','2020')
insert into tbl_PersonelMaaslari(Pers_ID,Maas_Odeme_Tarihi,Maas_Tutari,Maas_Komisyon,Ay_ID,Maas_Yili)values ('5','12.5.2020','8000','750','5','2020')



/****** ALTER TABLE ile FOREIGN KEYLERÝ OLUÞTURMA ******/


ALTER TABLE tbl_Personeller ADD FOREIGN KEY (Bolum_ID) REFERENCES tbl_Bolumler (Bolum_ID)
ALTER TABLE tbl_Personeller ADD FOREIGN KEY (Unvan_ID) REFERENCES tbl_Kategoriler (Kategori_ID)
ALTER TABLE tbl_Bolumler ADD FOREIGN KEY (Mudur_ID) REFERENCES tbl_Personeller (Pers_ID)
ALTER TABLE tbl_PersonelMaaslari ADD FOREIGN KEY (Pers_ID) REFERENCES tbl_Personeller (Pers_ID)
ALTER TABLE tbl_PersonelMaaslari ADD FOREIGN KEY (Ay_ID) REFERENCES tbl_Kategoriler (Kategori_ID)



/****** Tablolarý Sorgulama ******/


SELECT * FROM tbl_Bolumler
SELECT * FROM tbl_Kategoriler
SELECT * FROM tbl_Personeller
SELECT * FROM tbl_PersonelMaaslari
