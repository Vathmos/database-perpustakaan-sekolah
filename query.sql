-- Base
CREATE DATABASE db_perpus;

CREATE TABLE buku (
    id_buku INT PRIMARY KEY AUTO_INCREMENT,
    judul_buku VARCHAR(50),
    penulis VARCHAR(50),
    kategori VARCHAR(30),
    stok INT
);

CREATE TABLE siswa (
    id_siswa INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(50),
    kelas VARCHAR(10)
);

CREATE TABLE peminjaman (
    id_peminjaman INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    id_buku INT,
    tgl_pinjam DATE DEFAULT(CURRENT_DATE),
    tgl_kembali DATE,
    status ENUM("Dikembalikan", "Dipinjam")
);
-- Base

-- Procedures
DELIMITER $$

CREATE PROCEDURE insert_buku(
    p_judul_buku VARCHAR(50),
    p_penulis VARCHAR(50),
    p_kategori VARCHAR(30),
    p_stok INT
)
BEGIN
    INSERT INTO buku(judul_buku, penulis, kategori, stok) 
    VALUES (p_judul_buku, p_penulis, p_kategori, p_stok);
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE insert_siswa(
    p_nama VARCHAR(50),
    p_kelas VARCHAR(10)
)
BEGIN
    INSERT INTO siswa(nama, kelas) VALUES (p_nama, p_kelas);
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE insert_peminjaman(
    p_id_buku INT,
    p_id_siswa INT, 
    p_tgl_pinjam DATE, 
    p_tgl_kembali DATE, 
    p_status ENUM("Dikembalikan","Dipinjam")
)
BEGIN
    INSERT INTO peminjaman(id_siswa, id_buku, tgl_pinjam, tgl_kembali, status) 
    VALUES (p_id_buku, p_id_siswa, p_tgl_pinjam, p_tgl_kembali, p_status);
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE insert_peminjaman(
    p_id_buku INT,
    p_id_siswa INT, 
    p_tgl_pinjam DATE, 
    p_tgl_kembali DATE, 
    p_status ENUM("Dikembalikan","Dipinjam")
)
BEGIN
    INSERT INTO peminjaman(id_buku, id_siswa, tgl_pinjam, tgl_kembali, status) 
    VALUES (p_id_buku, p_id_siswa, p_tgl_pinjam, p_tgl_kembali, p_status);
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE update_buku(
    p_id_buku INT,
    p_judul_buku VARCHAR(50),
    p_penulis VARCHAR(50),
    p_kategori VARCHAR(30),
    p_stok INT
)
BEGIN
    UPDATE buku SET 
        judul_buku = p_judul_buku,
        penulis = p_penulis,
        kategori = p_kategori,
        stok = p_stok 
    WHERE id_buku = p_id_buku;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE delete_buku(
    p_id_buku INT
)
BEGIN
    DELETE FROM buku WHERE id_buku = p_id_buku;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE update_siswa(
    p_id_siswa INT,
    p_nama VARCHAR(50),
    p_kelas VARCHAR(10)
)
BEGIN
    UPDATE siswa SET 
        nama = p_nama,
        kelas = p_kelas
    WHERE id_siswa = p_id_siswa;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE delete_siswa(
    p_id_siswa INT
)
BEGIN
    DELETE FROM siswa WHERE id_siswa = p_id_siswa;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE update_peminjaman(
    p_id_peminjaman INT,
    p_id_buku INT,
    p_id_siswa INT, 
    p_tgl_pinjam DATE, 
    p_tgl_kembali DATE, 
    p_status ENUM("Dikembalikan","Dipinjam")
)
BEGIN
    UPDATE peminjaman SET 
        id_buku = p_id_buku,
        id_siswa = p_id_siswa,
        tgl_pinjam = p_tgl_pinjam,
        tgl_kembali = p_tgl_kembali,
        status = p_status 
    WHERE id_peminjaman = p_id_peminjaman;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE delete_peminjaman(
    p_id_peminjaman INT
)
BEGIN
    DELETE FROM peminjaman WHERE id_peminjaman = p_id_peminjaman;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE select_all_buku()
BEGIN
    SELECT * FROM buku;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE select_all_siswa()
BEGIN
    SELECT * FROM siswa;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE select_all_peminjaman()
BEGIN
    SELECT * FROM peminjaman;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE kembalikan_buku(
    p_id_peminjaman INT
)
BEGIN
    UPDATE peminjaman 
    SET status = "Dikembalikan", tgl_kembali = CURRENT_DATE() 
    WHERE id_peminjaman = p_id_peminjaman;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE list_siswa_pinjam()
BEGIN
    SELECT s.nama AS nama_peminjam,
           b.judul_buku AS buku_yang_dipinjam,
           p.tgl_pinjam AS tanggal_pinjam
    FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa
    JOIN buku b ON b.id_buku = p.id_buku;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE list_siswa_pinjam()
BEGIN
    SELECT s.id_siswa, 
           s.nama AS nama,
           b.judul_buku AS buku_yang_dipinjam,
           p.tgl_pinjam AS tanggal_pinjam
    FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa
    JOIN buku b ON b.id_buku = p.id_buku
    ORDER BY s.id_siswa;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE list_siswa()
BEGIN
    SELECT s.id_siswa,
           s.nama AS nama_peminjam, 
           b.judul_buku AS buku_yang_dipinjam,
           p.tgl_pinjam AS tanggal_pinjam
    FROM siswa s
    LEFT JOIN peminjaman p ON s.id_siswa = p.id_siswa
    LEFT JOIN buku b ON b.id_buku = p.id_buku
    ORDER BY s.id_siswa;
END $$
DELIMITER;

DELIMITER $$

CREATE PROCEDURE list_buku()
BEGIN
    SELECT b.id_buku,
           b.judul_buku,
           s.nama AS nama_peminjam,
           p.tgl_pinjam AS tanggal_pinjam,
           b.stok
    FROM siswa s
    RIGHT JOIN peminjaman p ON s.id_siswa = p.id_siswa
    RIGHT JOIN buku b ON b.id_buku = p.id_buku
    ORDER BY b.id_buku;
END $$
DELIMITER;

-- Procedures

-- Triggers
DELIMITER $$

CREATE TRIGGER after_insert_peminjaman
AFTER INSERT ON peminjaman 
FOR EACH ROW 
BEGIN
    IF NEW.status = "Dipinjam" THEN
        UPDATE buku SET stok = stok - 1 WHERE id_buku = NEW.id_buku;
    ELSEIF NEW.status = "Dikembalikan" THEN
        UPDATE buku SET stok = stok + 1 WHERE id_buku = NEW.id_buku;
    END IF;
END $$
DELIMITER;

DELIMITER $$

CREATE TRIGGER after_update_peminjaman
AFTER INSERT ON peminjaman 
FOR EACH ROW 
BEGIN
    IF NEW.status = "Dipinjam" AND OLD.status = "Dikembalikan" THEN
        UPDATE buku SET stok = stok - 1 WHERE id_buku = NEW.id_buku;
    ELSEIF NEW.status = "Dikembalikan" AND OLD.status = "Dipinjam" THEN
        UPDATE buku SET stok = stok + 1 WHERE id_buku = NEW.id_buku;
    END IF;
END $$
DELIMITER;
-- Triggers

-- Insertions
INSERT INTO buku (judul_buku, penulis, kategori, stok) VALUES 
    ("Algoritma dan Pemrograman", "Andi Wijaya", "Teknologi", 5),
    ("Dasar-dasar Database", "Budi Santoso", "Teknologi", 7),
    ("Matematika Diskrit", "Rina Sari", "Matematika", 4),
    ("Sejarah Dunia", "John Smith", "Sejarah", 3),
    ("Pemrograman Web dengan PHP", "Eko Prasetyo", "Teknologi", 8);

INSERT INTO siswa (nama, kelas) VALUES 
    ("Andi Saputra", "X-RPL"),
    ("Budi Wijaya", "X-TKJ"),
    ("Citra Lestari", "XI-RPL"),
    ("Dewi Kurniawan", "XI-TKJ"),
    ("Eko Prasetyo", "XII-RPL");

INSERT INTO peminjaman (id_siswa, id_buku, tgl_pinjam, tgl_kembali, status) VALUES 
    (11, 2, "2025-02-01", "2025-02-08", "Dipinjam"),
    (2, 5, "2025-01-28", "2025-02-04", "Dikembalikan"),
    (3, 8, "2025-02-02", "2025-02-09", "Dipinjam"),
    (4, 10, "2025-01-30", "2025-02-06", "Dikembalikan"),
    (5, 3, "2025-01-25", "2025-02-01", "Dikembalikan");
-- Insertions

-- Calls
CALL select_all_buku();
CALL select_all_siswa();
CALL select_all_peminjaman();
CALL insert_buku ( "Sistem Operasi", "Dian Kurniawan", "Teknologi", 6 );
CALL insert_buku ( "Jaringan Komputer", "Ahmad Fauzi", "Teknologi", 5 );
CALL insert_buku ( "Cerita Rakyat Nusantara", "Lestari Dewi", "Sastra", 9 );
CALL insert_buku ( "Bahasa Inggris untuk Pemula", "Jane Doe", "Bahasa", 10 );
CALL insert_buku ( "Biologi Dasar", "Budi Rahman", "Sains", 7 );
CALL insert_buku ( "Kimia Organik", "Siti Aminah", "Sains", 5 );
CALL insert_buku ( "Teknik Elektro", "Ridwan Hakim", "Teknik", 6 );
CALL insert_buku ( "Fisika Modern", "Albert Einstein", "Sains", 4 );
CALL insert_buku ( "Manajemen Waktu", "Steven Covey", "Pengembangan", 8 );
CALL insert_buku ( "Strategi Belajar Efektif", "Tony Buzan", "Pendidikan", 6 );
CALL insert_siswa ("Farhan Maulana", "XII-TKJ");
CALL insert_siswa ("Gita Permata", "X-RPL");
CALL insert_siswa ("Hadi Sucipto", "X-TKJ");
CALL insert_siswa ("Intan Permadi", "XI-RPL");
CALL insert_siswa ("Joko Santoso", "XI-TKJ");
CALL insert_siswa ("Kartika Sari", "XII-RPL");
CALL insert_siswa ("Lintang Putri", "XII-TKJ");
CALL insert_siswa ("Muhammad Rizky", "X-RPL");
CALL insert_siswa ("Novi Andriana", "X-TKJ");
CALL insert_siswa ("Olivia Hernanda", "XI-RPL");
CALL insert_peminjaman ( 15, 7, "2025-02-01", "2025-02-08", "Dipinjam" );
CALL insert_peminjaman ( 7, 1, "2025-01-29", "2025-02-05", "Dikembalikan" );
CALL insert_peminjaman ( 8, 9, "2025-02-03", "2025-02-10", "Dipinjam" );
CALL insert_peminjaman ( 13, 4, "2025-01-27", "2025-02-03", "Dikembalikan" );
CALL insert_peminjaman ( 10, 11, "2025-02-01", "2025-02-08", "Dipinjam" );
CALL list_siswa_pinjam();
CALL list_siswa();
CALL list_buku();
-- Calls
