Berikut adalah contoh README dengan sudut pandang yang tidak terkesan sebagai tugas, melainkan sebagai implementasi sistem perpustakaan sekolah:

---

# Database Perpustakaan Sekolah

Repository ini berisi implementasi sistem perpustakaan sekolah. Sistem ini dirancang untuk mengelola data buku, siswa, dan peminjaman dengan menggunakan database MySQL, serta dilengkapi dengan berbagai stored procedure untuk operasi data yang dinamis. File import database juga disediakan untuk memudahkan setup awal.

## Deskripsi Sistem

Sistem perpustakaan ini mencakup fitur-fitur berikut:

- **Pembuatan Database:** Membuat database dengan nama `db_perpus`.
- **Pembuatan Tabel:** 
  - **Buku:** Menyimpan informasi mengenai buku (ID, Judul, Penulis, Kategori, Stok).
  - **Siswa:** Menyimpan data siswa (ID, Nama, Kelas).
  - **Peminjaman:** Mencatat transaksi peminjaman buku (ID Peminjaman, ID Siswa, ID Buku, Tanggal Pinjam, Tanggal Kembali, Status).
- **Input Data Awal:**
  - Pengisian 5 record di setiap tabel melalui query INSERT.
  - Pengisian 10 record di setiap tabel melalui stored procedure.
- **Operasi Data:**
  - Stored procedure untuk UPDATE dan DELETE data di setiap tabel.
  - Stored procedure untuk menampilkan seluruh record dari setiap tabel.
- **Otomatisasi Stok Buku:**
  - Pengurangan stok buku secara otomatis saat buku dipinjam.
  - Penambahan stok buku secara otomatis saat buku dikembalikan.
- **Fitur Tambahan:**
  - Stored procedure untuk mengembalikan buku dengan tanggal pengembalian yang disesuaikan dengan tanggal saat itu (CURRENT DATE).
  - Stored procedure untuk menampilkan daftar siswa yang pernah meminjam buku.
  - Stored procedure untuk menampilkan semua data siswa (termasuk yang belum pernah meminjam).
  - Stored procedure untuk menampilkan semua data buku (termasuk yang belum pernah dipinjam).

## Struktur Tabel

### Tabel Buku
- **ID Buku:** Primary key untuk identifikasi buku.
- **Judul Buku:** Nama atau judul buku.
- **Penulis:** Nama penulis buku.
- **Kategori:** Kategori buku (misalnya: Teknologi, Matematika, Sejarah, dll.).
- **Stok:** Jumlah buku yang tersedia.

### Tabel Siswa
- **ID Siswa:** Primary key untuk identifikasi siswa.
- **Nama:** Nama lengkap siswa.
- **Kelas:** Kelas siswa (misalnya: XI-RPL, X-TKJ, dll.).

### Tabel Peminjaman
- **ID Peminjaman:** Primary key untuk transaksi peminjaman.
- **ID Siswa:** Foreign key yang mengacu pada tabel siswa.
- **ID Buku:** Foreign key yang mengacu pada tabel buku.
- **Tanggal Pinjam:** Tanggal buku dipinjam.
- **Tanggal Kembali:** Tanggal buku harus dikembalikan.
- **Status:** Status peminjaman (misalnya: "Dipinjam" atau "Dikembalikan").

## File SQL yang Tersedia

- **db_perpus.sql:** Berisi perintah SQL untuk membuat database `db_perpus` beserta seluruh tabel dan struktur yang diperlukan.
- **query.sql:** Berisi query untuk memasukkan data awal dan pembuatan stored procedure untuk operasi INSERT, UPDATE, DELETE, SELECT, serta fitur-fitur tambahan.

## Teknologi Yang Digunakan

- **Local Development Environment:** Laragon  
  *Alternatif: XAMPP, WAMP*
- **Database:** MySQL  
  *Alternatif: MariaDB*
- **Web Server:** Nginx  
  *Alternatif: Apache*
- **Code Editor:** Visual Studio Code dengan Database Client extension  
  *Alternatif: MySQL Workbench, phpMyAdmin, DBeaver*

## Cara Penggunaan

1. **Clone Repository:**

   ```bash
   git clone https://github.com/vathmos/database-pepustakaan-sekolah.git
   cd database-pepustakaan-sekolah
   ```

2. **Import Database:**

   - Pastikan MySQL (atau MariaDB) telah terinstall.
   - Import file `db_perpus.sql` untuk membuat database dan tabel:
     ```bash
     mysql -u username -p < db_perpus.sql
     ```
   - Selanjutnya, import file `query.sql` untuk memasukkan data awal dan membuat stored procedure:
     ```bash
     mysql -u username -p db_perpus < query.sql
     ```

3. **Jalankan Stored Procedures:**

   - Setelah proses import selesai, jalankan stored procedure yang telah dibuat untuk melakukan operasi INSERT, UPDATE, DELETE, dan SELECT sesuai kebutuhan.

## Author

**Ahmad Faris Widyawan**  
Kelas(pada saat repo ini dibuat): XI RPL 1 
