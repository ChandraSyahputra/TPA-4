-- Membuat database
create database online_retail;
use online_retail;

-- Membuat tabel (semua table harus dibuat)
create table member (
	id int primary key not null auto_increment,
    email varchar(100) unique,
    password varchar(20),
    nama varchar(50),
    alamat varchar(100),
    no_telp varchar(18)
);

create table produk (
	id int primary key not null auto_increment,
    nama_produk varchar(50),
    harga int,
    kategori varchar(30)
);

alter table produk
change kategori kategori_id int;

create table kategori (
	id int primary key not null auto_increment,
    nama_kategori varchar(30)
);

alter table produk
add foreign key (kategori_id) references kategori(id);

create table transaksi (
	id int primary key not null auto_increment,
    member_id int,
    produk_id int,
    jumlah int,
    tanggal_transaksi date,
    foreign key (member_id) references member(id),
    foreign key (produk_id) references produk(id)
);

-- Mengisi data ke tabel (minimal 10 data per tabel)
insert into member (email, password, nama, alamat, no_telp) values
("chandra@gmail.com", "chandra", "Chandra", "Jl. Bratang 5, Surabaya", 085111111111),
("wibawa@gmail.com", "wibawa", "Wibawa", "Jl. Bratang 1, Surabaya", 085222222222),
("syahputra@gmail.com", "syahputra", "Syahputra", "Jl. Bratang 3, Surabaya", 085333333333),
("marquez@gmail.com", "marquez", "Marquez", "Jl. Barcelone 1, Spanyol", 085444444444),
("rossi@gmail.com", "rossi", "Rossi", "Jl. Milan, Italia", 085555555555),
("binder@gmail.com", "binder", "Binder", "Jl. Cape Town, Afrika Selatan", 085666666666),
("miller@gmail.com", "miller", "Miller", "Jl. Sydney, Australia", 085777777777),
("dixon@gmail.com", "dixon", "Dixon", "Jl. London, Inggris", 085888888888),
("quartararo@gmail.com", "quartararo", "Quartararo", "Jl. Paris, Perancis", 085999999999),
("nakagami@gmail.com", "nakagami", "Nakagami", "Jl. Tokyo, Jepang", 085111222333);

insert into kategori (nama_kategori) values
("makanan"),
("minuman"),
("keyboard"),
("televisi"),
("kulkas"),
("laptop"),
("smartphone"),
("mouse"),
("speaker"),
("headset");

insert into produk (nama_produk, harga, kategori_id) values
("samyang", 20000, 1),
("doritos", 10000, 1),
("sprite", 5000, 2),
("rexus daxa m", 600000, 3),
("ducky one", 1000000, 3),
("sharp", 3000000, 4),
("lg", 2000000, 5),
("asus", 12000000, 6),
("acer", 9000000, 6),
("samsung", 12000000, 7),
("oppo", 4600000, 7),
("xiaomi", 3900000, 7),
("iphone", 14000000, 7),
("logitech g", 1200000, 8),
("sony", 1600000, 9),
("sehnheiserr", 1100000, 10);

insert into transaksi (member_id, produk_id, jumlah, tanggal_transaksi) values
(1, 13, 1, '2022-11-1'),
(4, 1, 4, '2022-11-2'),
(8, 2, 2, '2022-11-3'),
(1, 16, 1, '2022-11-4'),
(8, 4, 1, '2022-11-5'),
(4, 6, 1, '2022-11-6'),
(1, 15, 1, '2022-11-7'),
(4, 3, 10, '2022-11-8'),
(8, 10, 1, '2022-11-9'),
(1, 8, 1, '2022-11-10');

-- Mengambil data dari tabel
select * from member;
select * from kategori;
select * from produk;
select * from transaksi;

-- Mengubah data di tabel
update kategori 
set nama_kategori = "headphone"
where id = 10;

-- Menghapus data di tabel
delete from produk where id = 11;

-- Menghapus tabel
drop table member;
drop table produk;
drop table kategori;
drop table transaksi;

-- Menghapus database
drop database online_retail;

-- Melihat 3 produk yang paling sering dibeli oleh pelanggan.
select produk.nama_produk, sum(transaksi.jumlah) as paling_banyak_dibeli, count(transaksi.id) as jumlah_transaksi  
from transaksi inner join produk on transaksi.produk_id = produk.id 
group by produk.nama_produk 
order by sum(transaksi.jumlah) desc limit 3;

-- Melihat Kategori barang yang paling banyak barangnya.
select kategori.nama_kategori, count(produk.id) as jumlah_produk 
from produk inner join kategori on produk.kategori_id = kategori.id 
group by kategori.nama_kategori
order by count(produk.id) desc;

-- Nominal rata-rata transaksi yang dilakukan oleh pelanggan dalam 1 bulan terakhir.
select transaksi.tanggal_transaksi, AVG(transaksi.jumlah*produk.harga) as rata_rata_penjualan
FROM transaksi inner join produk on transaksi.produk_id = produk.id 
GROUP BY YEAR(transaksi.tanggal_transaksi), MONTH(transaksi.tanggal_transaksi);