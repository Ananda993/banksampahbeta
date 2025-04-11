-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 11, 2025 at 10:06 AM
-- Server version: 8.0.30
-- PHP Version: 8.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bagiantara_atk`
--
CREATE DATABASE IF NOT EXISTS `bagiantara_atk` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `bagiantara_atk`;

-- --------------------------------------------------------

--
-- Table structure for table `kasir`
--

CREATE TABLE `kasir` (
  `id_kasir` varchar(10) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `shift` varchar(20) NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_keluar` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kasir`
--

INSERT INTO `kasir` (`id_kasir`, `nama`, `shift`, `jam_masuk`, `jam_keluar`) VALUES
('K001', 'Kadek Bagiantara', 'Pagi-Siang', '08:00:00', '14:00:00'),
('K002', 'Gusnan', 'Siang-Malam', '14:00:00', '22:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `laporan_keuangan`
--

CREATE TABLE `laporan_keuangan` (
  `id_laporan` varchar(20) NOT NULL,
  `bulan` varchar(20) NOT NULL,
  `tahun` int NOT NULL,
  `total_pendapatan` decimal(15,2) NOT NULL,
  `total_pengeluaran` decimal(15,2) NOT NULL,
  `keuntungan_rugi` decimal(15,2) GENERATED ALWAYS AS ((`total_pendapatan` - `total_pengeluaran`)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` varchar(10) NOT NULL,
  `nama_produk` varchar(100) NOT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `harga_satuan` decimal(10,2) NOT NULL,
  `stok` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `nama_produk`, `kategori`, `harga_satuan`, `stok`) VALUES
('P001', 'Pensil Mekanik', 'Alat Tulis', '5000.00', 100),
('P002', 'Pulpen Gel', 'Alat Tulis', '7000.00', 150),
('P003', 'Penghapus Karet', 'Alat Tulis', '3000.00', 200),
('P004', 'Buku Tulis 40 Lembar', 'Buku', '10000.00', 120),
('P005', 'Kertas HVS A4 80gsm', 'Kertas', '50000.00', 50),
('P006', 'Gunting Kertas', 'Peralatan', '15000.00', 30),
('P007', 'Lem UHU Stick', 'Peralatan', '12000.00', 40),
('P008', 'Spidol Boardmarker', 'Peralatan', '20000.00', 60),
('P009', 'Tip-Ex Cair', 'Alat Tulis', '9000.00', 70),
('P010', 'Sticky Notes', 'Peralatan', '13000.00', 50);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` varchar(10) NOT NULL,
  `id_kasir` varchar(10) DEFAULT NULL,
  `tanggal` date NOT NULL,
  `id_produk` varchar(10) DEFAULT NULL,
  `jumlah` int NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `metode_pembayaran` enum('QRIS','Cash') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_kasir`, `tanggal`, `id_produk`, `jumlah`, `total_harga`, `metode_pembayaran`) VALUES
('T001', 'K001', '2025-03-25', 'P001', 2, '10000.00', 'QRIS'),
('T002', 'K001', '2025-03-25', 'P004', 1, '10000.00', 'Cash'),
('T003', 'K002', '2025-03-25', 'P006', 3, '45000.00', 'QRIS');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kasir`
--
ALTER TABLE `kasir`
  ADD PRIMARY KEY (`id_kasir`);

--
-- Indexes for table `laporan_keuangan`
--
ALTER TABLE `laporan_keuangan`
  ADD PRIMARY KEY (`id_laporan`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_kasir` (`id_kasir`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_kasir`) REFERENCES `kasir` (`id_kasir`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);
--
-- Database: `bank_sampah`
--
CREATE DATABASE IF NOT EXISTS `bank_sampah` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `bank_sampah`;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `jenis_sampah` varchar(50) NOT NULL,
  `berat_kg` float NOT NULL,
  `saldo` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id`, `user_id`, `jenis_sampah`, `berat_kg`, `saldo`, `created_at`) VALUES
(1, 4, 'plastik', 1, 1000, '2025-02-09 13:16:45'),
(2, 4, 'kaca', 10, 10000, '2025-02-09 13:17:25'),
(3, 4, 'botol kaca', 12, 12000, '2025-02-09 13:34:05'),
(4, 10, 'koran', 10, 10000, '2025-02-09 13:40:16'),
(5, 11, 'laptop bekas', 3, 3000, '2025-03-14 03:25:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `no_whatsapp` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `saldo` float DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `alamat`, `no_whatsapp`, `email`, `password`, `role`, `saldo`) VALUES
(4, 'gusnan', 'tabanan,kediri', '08199856321', 'eka20065@gmail.com', '$2y$10$bYNk0vwet7vWxSwuLF/46.rpOnq6MFozAoHh7E0AdvlwGA4G8OhZy', 'user', 23000),
(9, 'agus ananda', 'br.baleran 82121', '1234512345', 'gusnan555@gmail.com', '$2y$10$h0HywZS3GVK5/4m8PrVMBevQFkxvEu8ygTVVCVbfcppGp7vgS7T42', 'admin', 0),
(10, 'buk guna', 'br.baleran', '664377211322', 'bukguna@gmail.com', '$2y$10$UMAao2hdk9rAFKieaqOTB.5aiztBmlcQZ90X9E98zmtK20MBvKmxO', 'user', 10000),
(11, 'gede adi', 'denpasar', '081123456', 'gede@gede.v1', '$2y$12$Mo8BwQKqtOjuq3hFapbOVOAL64/lxQ/nfWVy8VbsirArhuhKZw6SC', 'user', 3000),
(12, 'xyz', 'hsjjwkhdkjdwgjkds', '67766636337', 'Tatsuya098@gmail.com', '$2y$12$MXPuK9NsecUM5qg7/wyMR.h8NvPG0h68LO5dx70wFsExIKUgGAtC.', 'user', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
--
-- Database: `db_lomba_mewarnai`
--
CREATE DATABASE IF NOT EXISTS `db_lomba_mewarnai` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `db_lomba_mewarnai`;

-- --------------------------------------------------------

--
-- Table structure for table `hadiah`
--

CREATE TABLE `hadiah` (
  `id_hadiah` int NOT NULL,
  `peringkat` int NOT NULL,
  `deskripsi` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hadiah`
--

INSERT INTO `hadiah` (`id_hadiah`, `peringkat`, `deskripsi`) VALUES
(1, 1, 'Trophy + Uang Rp300.000'),
(2, 2, 'Medali + Uang Rp200.000'),
(3, 3, 'Piagam + Uang Rp150.000'),
(4, 4, 'Piagam Penghargaan');

-- --------------------------------------------------------

--
-- Table structure for table `lomba`
--

CREATE TABLE `lomba` (
  `id_lomba` int NOT NULL,
  `nama_lomba` varchar(50) NOT NULL,
  `kategori_usia` varchar(20) NOT NULL,
  `tanggal_pelaksanaan` date NOT NULL,
  `tempat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `lomba`
--

INSERT INTO `lomba` (`id_lomba`, `nama_lomba`, `kategori_usia`, `tanggal_pelaksanaan`, `tempat`) VALUES
(1, 'Lomba Mewarnai SD', '9-11 tahun', '2025-03-21', 'Aula SDN 1 Kerambitan');

-- --------------------------------------------------------

--
-- Table structure for table `nilai`
--

CREATE TABLE `nilai` (
  `id_nilai` int NOT NULL,
  `id_peserta` int NOT NULL,
  `id_lomba` int NOT NULL,
  `skor` int NOT NULL,
  `peringkat` int NOT NULL,
  `komentar_juri` text
) ;

--
-- Dumping data for table `nilai`
--

INSERT INTO `nilai` (`id_nilai`, `id_peserta`, `id_lomba`, `skor`, `peringkat`, `komentar_juri`) VALUES
(1, 1, 1, 88, 2, 'Warna bagus, sedikit lebih rapi bisa lebih baik.'),
(2, 2, 1, 92, 1, 'Komposisi warna kreatif dan menarik.'),
(3, 3, 1, 80, 3, 'Butuh sedikit perbaikan dalam gradasi warna.'),
(4, 4, 1, 78, 4, 'Detail gambar perlu lebih halus.'),
(5, 5, 1, 85, 3, 'Kombinasi warna cukup menarik.');

-- --------------------------------------------------------

--
-- Table structure for table `panitia`
--

CREATE TABLE `panitia` (
  `id_panitia` int NOT NULL,
  `nama_panitia` varchar(100) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `no_hp` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `panitia`
--

INSERT INTO `panitia` (`id_panitia`, `nama_panitia`, `jabatan`, `no_hp`) VALUES
(1, 'Ibu Ni Made Sri Rahayu', 'Ketua', '081999888777'),
(2, 'Bapak I Wayan Budiarsa', 'Bendahara', '081234999888'),
(3, 'I Nyoman Sudiarta', 'Sekretaris', '081278956432');

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran`
--

CREATE TABLE `pendaftaran` (
  `id_pendaftaran` int NOT NULL,
  `id_peserta` int NOT NULL,
  `id_lomba` int NOT NULL,
  `tanggal_daftar` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status_pembayaran` enum('Lunas','Belum Lunas') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pendaftaran`
--

INSERT INTO `pendaftaran` (`id_pendaftaran`, `id_peserta`, `id_lomba`, `tanggal_daftar`, `status_pembayaran`) VALUES
(1, 1, 1, '2025-03-21 03:32:14', 'Lunas'),
(2, 2, 1, '2025-03-21 03:32:14', 'Belum Lunas'),
(3, 3, 1, '2025-03-21 03:32:14', 'Lunas'),
(4, 4, 1, '2025-03-21 03:32:14', 'Lunas'),
(5, 5, 1, '2025-03-21 03:32:14', 'Belum Lunas');

-- --------------------------------------------------------

--
-- Table structure for table `peserta`
--

CREATE TABLE `peserta` (
  `id_peserta` int NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `kelas` varchar(10) NOT NULL,
  `usia` int NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `nama_wali` varchar(100) NOT NULL,
  `no_hp_wali` varchar(15) NOT NULL
) ;

--
-- Dumping data for table `peserta`
--

INSERT INTO `peserta` (`id_peserta`, `nama_lengkap`, `kelas`, `usia`, `jenis_kelamin`, `nama_wali`, `no_hp_wali`) VALUES
(1, 'I Putu Arya Wijaya', '4A', 10, 'Laki-laki', 'I Wayan Sudarma', '081234567890'),
(2, 'I Kadek Sari Dewi', '5B', 11, 'Perempuan', 'I Made Rahayu', '081298765432'),
(3, 'I Made Budi Santosa', '4C', 9, 'Laki-laki', 'I Nyoman Wijaya', '081345678901'),
(4, 'I Nyoman Citra Lestari', '5A', 10, 'Perempuan', 'I Ketut Sulastri', '081312345678'),
(5, 'I Ketut Bayu Pramana', '6B', 11, 'Laki-laki', 'I Wayan Aditya', '081356789012');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hadiah`
--
ALTER TABLE `hadiah`
  ADD PRIMARY KEY (`id_hadiah`);

--
-- Indexes for table `lomba`
--
ALTER TABLE `lomba`
  ADD PRIMARY KEY (`id_lomba`);

--
-- Indexes for table `nilai`
--
ALTER TABLE `nilai`
  ADD PRIMARY KEY (`id_nilai`),
  ADD KEY `id_peserta` (`id_peserta`),
  ADD KEY `id_lomba` (`id_lomba`);

--
-- Indexes for table `panitia`
--
ALTER TABLE `panitia`
  ADD PRIMARY KEY (`id_panitia`);

--
-- Indexes for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD PRIMARY KEY (`id_pendaftaran`),
  ADD KEY `id_peserta` (`id_peserta`),
  ADD KEY `id_lomba` (`id_lomba`);

--
-- Indexes for table `peserta`
--
ALTER TABLE `peserta`
  ADD PRIMARY KEY (`id_peserta`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hadiah`
--
ALTER TABLE `hadiah`
  MODIFY `id_hadiah` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lomba`
--
ALTER TABLE `lomba`
  MODIFY `id_lomba` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nilai`
--
ALTER TABLE `nilai`
  MODIFY `id_nilai` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `panitia`
--
ALTER TABLE `panitia`
  MODIFY `id_panitia` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  MODIFY `id_pendaftaran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `peserta`
--
ALTER TABLE `peserta`
  MODIFY `id_peserta` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `nilai`
--
ALTER TABLE `nilai`
  ADD CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`id_peserta`) REFERENCES `peserta` (`id_peserta`),
  ADD CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`id_lomba`) REFERENCES `lomba` (`id_lomba`);

--
-- Constraints for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD CONSTRAINT `pendaftaran_ibfk_1` FOREIGN KEY (`id_peserta`) REFERENCES `peserta` (`id_peserta`),
  ADD CONSTRAINT `pendaftaran_ibfk_2` FOREIGN KEY (`id_lomba`) REFERENCES `lomba` (`id_lomba`);
--
-- Database: `eabsensi_uhn`
--
CREATE DATABASE IF NOT EXISTS `eabsensi_uhn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `eabsensi_uhn`;

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `matkul_id` int DEFAULT NULL,
  `status` enum('hadir','sakit','izin','alfa') DEFAULT 'alfa',
  `tanggal` date DEFAULT NULL,
  `waktu_mulai` time DEFAULT NULL,
  `waktu_selesai` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `absensi`
--

INSERT INTO `absensi` (`id`, `user_id`, `matkul_id`, `status`, `tanggal`, `waktu_mulai`, `waktu_selesai`, `created_at`) VALUES
(41, 27, 6, 'hadir', '2025-01-22', '07:05:49', NULL, '2025-01-21 23:05:49'),
(42, 27, 6, 'hadir', '2025-01-22', '07:07:14', NULL, '2025-01-21 23:07:14'),
(43, 27, 7, 'hadir', '2025-01-22', '07:11:55', NULL, '2025-01-21 23:11:55'),
(44, 27, 7, 'hadir', '2025-01-22', '07:12:09', NULL, '2025-01-21 23:12:09'),
(45, 27, 8, 'hadir', '2025-01-22', '07:15:41', NULL, '2025-01-21 23:15:41'),
(46, 27, 7, 'hadir', '2025-01-22', '07:18:51', NULL, '2025-01-21 23:18:51'),
(47, 27, 7, 'hadir', '2025-01-22', '07:19:49', NULL, '2025-01-21 23:19:49');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_kuliah`
--

CREATE TABLE `jadwal_kuliah` (
  `id` int NOT NULL,
  `matkul_id` int NOT NULL,
  `hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu') NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `ruangan` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id` int NOT NULL,
  `nama_matkul` varchar(100) DEFAULT NULL,
  `jumlah_sks` int NOT NULL,
  `dosen` varchar(100) DEFAULT NULL,
  `jenis_pertemuan` enum('online','offline') DEFAULT NULL,
  `hari` enum('Senin','Selasa','Rabu','Kamis','Jumat') NOT NULL,
  `jam` time NOT NULL,
  `tanggal` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`id`, `nama_matkul`, `jumlah_sks`, `dosen`, `jenis_pertemuan`, `hari`, `jam`, `tanggal`, `created_at`) VALUES
(6, 'KALKULUS', 3, 'IBU RISKA', 'online', 'Jumat', '09:30:00', '2025-01-22', '2025-01-22 05:21:38'),
(7, 'JARINGAN KOMPUTER', 4, 'PAK WAHYU', 'offline', 'Rabu', '14:05:00', '2025-01-22', '2025-01-22 05:59:23'),
(8, 'COBA', 3, 'KOMANG', 'online', 'Rabu', '15:20:00', '2025-01-22', '2025-01-22 07:15:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `nim` varchar(20) DEFAULT NULL,
  `prodi` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `status_validasi` enum('pending','valid','invalid') DEFAULT 'pending',
  `role` enum('mahasiswa','superadmin') DEFAULT 'mahasiswa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `nim`, `prodi`, `email`, `password`, `foto`, `jenis_kelamin`, `status_validasi`, `role`, `created_at`) VALUES
(1, 'gusnan', '555', 'Informatika', 'gusnan.555@gmail.com', '123456789', NULL, NULL, 'valid', 'superadmin', '2025-01-10 12:45:37'),
(4, 'Super Admin', '0000', 'Admin', 'admin@gmail.com', 'admin', NULL, NULL, 'valid', 'superadmin', '2025-01-10 14:05:54'),
(15, 'admin2', '119', 'admin', 'admin2@admin.uhn', '$2y$10$WD6Uc3q/Jl3tTEmaHWZE7OE6ZeR/UPD24n5z91Vbro6wqdxbOswb2', NULL, NULL, 'valid', 'superadmin', '2025-01-11 01:19:50'),
(27, 'NI LUH PUTU EKA MULIANINGSIH', '2413231016', 'INFORMATIKA', 'eka2005@gmail.com', '$2y$10$HC6rkivxIXMb8wvmFisQrOvAnME54jmlqMSwdJaT1LpNMQqGKBkiK', NULL, NULL, 'valid', 'mahasiswa', '2025-01-22 05:17:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indexes for table `jadwal_kuliah`
--
ALTER TABLE `jadwal_kuliah`
  ADD PRIMARY KEY (`id`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nim` (`nim`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `jadwal_kuliah`
--
ALTER TABLE `jadwal_kuliah`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `absensi_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `mata_kuliah` (`id`);

--
-- Constraints for table `jadwal_kuliah`
--
ALTER TABLE `jadwal_kuliah`
  ADD CONSTRAINT `jadwal_kuliah_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `mata_kuliah` (`id`) ON DELETE CASCADE;
--
-- Database: `e_absensi`
--
CREATE DATABASE IF NOT EXISTS `e_absensi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `e_absensi`;

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `tanggal` date NOT NULL,
  `status` enum('hadir','izin','sakit','alfa') NOT NULL DEFAULT 'alfa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id` int NOT NULL,
  `mata_kuliah` varchar(100) NOT NULL,
  `dosen` varchar(100) NOT NULL,
  `waktu` time NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`id`, `mata_kuliah`, `dosen`, `waktu`, `created_at`) VALUES
(1, 'Matematika Diskrit', 'Dr. Andi', '08:00:00', '2025-01-10 09:31:48'),
(2, 'Pemrograman Web', 'Ms. Rina', '10:00:00', '2025-01-10 09:31:48'),
(3, 'Jaringan Komputer', 'Mr. Budi', '13:00:00', '2025-01-10 09:31:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `foto_profil` varchar(255) DEFAULT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `status` enum('pending','approved') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `nim`, `password`, `email`, `foto_profil`, `role`, `status`, `created_at`) VALUES
(1, 'Admin', '2413231017', '5559cce7c9fe2aa2d78362aed1eff4bd', NULL, NULL, 'admin', 'approved', '2025-01-10 09:31:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `e_absensi_uhn`
--
CREATE DATABASE IF NOT EXISTS `e_absensi_uhn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `e_absensi_uhn`;

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `matkul_id` int NOT NULL,
  `pertemuan_ke` int NOT NULL,
  `status` enum('hadir','sakit','izin','alfa') DEFAULT 'alfa',
  `tanggal` date NOT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_selesai` time NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id` int NOT NULL,
  `kode_matkul` varchar(20) NOT NULL,
  `nama_matkul` varchar(100) NOT NULL,
  `dosen` varchar(100) NOT NULL,
  `jenis_pertemuan` enum('online','offline') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nim` varchar(20) DEFAULT NULL,
  `prodi` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT 'default.jpg',
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `status_validasi` enum('pending','valid','invalid') DEFAULT 'pending',
  `role` enum('mahasiswa','superadmin') DEFAULT 'mahasiswa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_matkul` (`kode_matkul`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `absensi_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `mata_kuliah` (`id`) ON DELETE CASCADE;
--
-- Database: `kas_kelas`
--
CREATE DATABASE IF NOT EXISTS `kas_kelas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `kas_kelas`;

-- --------------------------------------------------------

--
-- Table structure for table `kas`
--

CREATE TABLE `kas` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(10,2) NOT NULL,
  `status` enum('lunas','belum lunas') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nim` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id`, `nama`, `email`, `nim`, `created_at`) VALUES
(1, 'John Doe', 'john@example.com', '12345', '2025-03-11 04:18:11'),
(2, 'Jane Smith', 'jane@example.com', '12346', '2025-03-11 04:18:11'),
(7, 'Bob Wilson', 'bob@example.com', '12347', '2025-03-11 04:20:10');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` int NOT NULL,
  `status` enum('Lunas','Belum Lunas') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `nama`, `tanggal`, `jumlah`, `status`) VALUES
(2, 'I PUTU AGUS ANANDA GUNA PRASETYA ', '2025-03-11', 5000, 'Lunas'),
(3, 'I PUTU AGUS ANANDA GUNA PRASETYA ', '2025-03-02', 1000000, 'Lunas');

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id` int NOT NULL,
  `jumlah` int NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('mahasiswa','bendahara') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'bendahara01', 'gekyaa@bendahara.id', '$2y$12$1kdP3LfMcwEJTl87h.HdG.vYRU0UdmIdvREPwVkWHqIFPUrA3NejK', 'bendahara', '2025-03-11 01:54:12'),
(2, 'Gusnanda', 'Tatsuya098@gmail.com', '$2y$12$e3B6uV.Dzy7F9lJXVdS1muYfDodnxbTas2w8PDWMigCQag5R2uw2m', 'mahasiswa', '2025-03-11 03:34:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kas`
--
ALTER TABLE `kas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kas`
--
ALTER TABLE `kas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kas`
--
ALTER TABLE `kas`
  ADD CONSTRAINT `kas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `laravel12v1`
--
CREATE DATABASE IF NOT EXISTS `laravel12v1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `laravel12v1`;
--
-- Database: `nebulavape_db`
--
CREATE DATABASE IF NOT EXISTS `nebulavape_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `nebulavape_db`;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `karyawan_id` int NOT NULL,
  `nama_karyawan` varchar(100) NOT NULL,
  `shift` enum('pagi','sore') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`karyawan_id`, `nama_karyawan`, `shift`) VALUES
(1, 'Made Romeo', 'pagi'),
(2, 'I Komang Bagus Januarta', 'sore'),
(3, 'I Nyoman Widiantara', 'pagi');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_produk`
--

CREATE TABLE `kategori_produk` (
  `kategori_id` int NOT NULL,
  `nama_kategori` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kategori_produk`
--

INSERT INTO `kategori_produk` (`kategori_id`, `nama_kategori`) VALUES
(1, 'Pods'),
(2, 'Liquid'),
(3, 'Cartridge'),
(4, 'Vape'),
(5, 'Accessories');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `detail_id` int NOT NULL,
  `transaksi_id` int DEFAULT NULL,
  `produk_id` int DEFAULT NULL,
  `jumlah` int NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`detail_id`, `transaksi_id`, `produk_id`, `jumlah`, `subtotal`) VALUES
(1, 1, 1, 1, '195000.00'),
(2, 2, 6, 1, '75000.00'),
(3, 3, 2, 1, '315000.00'),
(4, 4, 3, 1, '240000.00'),
(5, 5, 4, 1, '380000.00'),
(6, 6, 13, 1, '35000.00'),
(7, 7, 9, 1, '85000.00'),
(8, 8, 11, 1, '105000.00'),
(9, 9, 14, 1, '500000.00'),
(10, 10, 15, 1, '150000.00'),
(11, 11, 1, 1, '195000.00'),
(12, 12, 6, 1, '75000.00'),
(13, 13, 2, 1, '315000.00'),
(14, 14, 3, 1, '240000.00'),
(15, 15, 4, 1, '380000.00'),
(16, 16, 13, 1, '35000.00'),
(17, 17, 9, 1, '85000.00'),
(18, 18, 11, 1, '105000.00'),
(19, 19, 16, 1, '700000.00'),
(20, 20, 10, 1, '80000.00'),
(21, 21, 1, 1, '195000.00'),
(22, 22, 6, 1, '75000.00'),
(23, 23, 2, 1, '315000.00'),
(24, 24, 3, 1, '240000.00'),
(25, 25, 4, 1, '380000.00'),
(26, 26, 13, 1, '35000.00'),
(27, 27, 9, 1, '85000.00'),
(28, 28, 11, 1, '105000.00'),
(29, 29, 14, 1, '500000.00'),
(30, 30, 15, 1, '150000.00'),
(31, 31, 1, 1, '195000.00'),
(32, 32, 6, 1, '75000.00'),
(33, 33, 2, 1, '315000.00'),
(34, 34, 3, 1, '240000.00'),
(35, 35, 4, 1, '380000.00'),
(36, 36, 13, 1, '35000.00'),
(37, 37, 9, 1, '85000.00'),
(38, 38, 11, 1, '105000.00'),
(39, 39, 16, 1, '700000.00'),
(40, 40, 10, 1, '80000.00');

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE `owner` (
  `owner_id` int NOT NULL,
  `nama_owner` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`owner_id`, `nama_owner`) VALUES
(1, 'I Putu Agus Ananda Guna Prasetya');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `pembayaran_id` int NOT NULL,
  `metode` enum('BCA','Mandiri','BRI','SeaBank','QRIS','Cash') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`pembayaran_id`, `metode`) VALUES
(1, 'BCA'),
(2, 'Mandiri'),
(3, 'BRI'),
(4, 'SeaBank'),
(5, 'QRIS'),
(6, 'Cash');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `produk_id` int NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `kategori_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `stock` int DEFAULT '50'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`produk_id`, `nama_produk`, `harga`, `kategori_id`, `supplier_id`, `stock`) VALUES
(1, 'Xlim Go Pod Kit New Color Bundling Ox Passion 15ml', '195000.00', 1, 1, 50),
(2, 'Oxva Xlim Pro 2 1300mAh Authentic', '315000.00', 1, 1, 50),
(3, 'Oxva Xlim Classic Edition 30W 1000mAh Pod Kit', '240000.00', 1, 1, 50),
(4, 'Oxva Vprime 60W 2600mAh Pod Kit 100% Authentic', '380000.00', 1, 1, 50),
(5, 'Oxva Xlim SQ Pro Pod Kit', '310000.00', 1, 1, 50),
(6, 'Kutub Blackcurrant Salt Nic 30ML by RK Project', '75000.00', 2, 2, 50),
(7, 'Movi Liquid Saltnic 30ml 30mg', '115000.00', 2, 2, 50),
(8, 'LCV Wice Apple Salt Nic 30ML by LCV Juice', '75000.00', 2, 3, 50),
(9, 'Salt Nic Mango Dance 30ML by RV', '85000.00', 2, 1, 50),
(10, 'Ice Foria Peach Gum Salt Nic 30ML by Omnilab x 168', '80000.00', 2, 1, 50),
(11, 'Latt Ice Apple Spirit Salt Nic 30ML by Vape Truck x BED', '105000.00', 2, 4, 50),
(12, 'Cartridge Foom X Refillable Pod Replacement', '35000.00', 3, 1, 50),
(13, 'Cartridge oxva xlim go', '35000.00', 3, 1, 50),
(14, 'Panda Vape Starter Kit', '500000.00', 4, 1, 50),
(15, 'Hexom Pro Vape Kit', '650000.00', 4, 1, 50),
(16, 'Trml Ultra Vape Kit', '700000.00', 4, 1, 50),
(17, 'Vape Case Organizer', '150000.00', 5, 4, 50),
(18, 'Vape Cleaning Kit', '80000.00', 5, 4, 50);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL,
  `nama_supplier` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplier_id`, `nama_supplier`) VALUES
(1, 'Oxva'),
(2, 'RK Project'),
(3, 'LCV Juice'),
(4, 'Vape Truck x BED');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `transaksi_id` int NOT NULL,
  `karyawan_id` int DEFAULT NULL,
  `pembayaran_id` int DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `tanggal` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`transaksi_id`, `karyawan_id`, `pembayaran_id`, `total`, `tanggal`) VALUES
(1, 1, 1, '195000.00', '2025-03-25 00:15:00'),
(2, 1, 2, '75000.00', '2025-03-25 00:30:00'),
(3, 1, 3, '315000.00', '2025-03-25 00:45:00'),
(4, 1, 4, '240000.00', '2025-03-25 01:00:00'),
(5, 1, 5, '380000.00', '2025-03-25 01:15:00'),
(6, 1, 6, '35000.00', '2025-03-25 01:30:00'),
(7, 1, 1, '85000.00', '2025-03-25 01:45:00'),
(8, 1, 2, '105000.00', '2025-03-25 02:00:00'),
(9, 1, 3, '500000.00', '2025-03-25 02:15:00'),
(10, 1, 4, '150000.00', '2025-03-25 02:30:00'),
(11, 3, 5, '195000.00', '2025-03-25 03:00:00'),
(12, 3, 6, '75000.00', '2025-03-25 03:15:00'),
(13, 3, 1, '315000.00', '2025-03-25 03:30:00'),
(14, 3, 2, '240000.00', '2025-03-25 03:45:00'),
(15, 3, 3, '380000.00', '2025-03-25 04:00:00'),
(16, 3, 4, '35000.00', '2025-03-25 04:15:00'),
(17, 3, 5, '85000.00', '2025-03-25 04:30:00'),
(18, 3, 6, '105000.00', '2025-03-25 04:45:00'),
(19, 3, 1, '700000.00', '2025-03-25 05:00:00'),
(20, 3, 2, '80000.00', '2025-03-25 05:15:00'),
(21, 2, 3, '195000.00', '2025-03-25 06:00:00'),
(22, 2, 4, '75000.00', '2025-03-25 06:15:00'),
(23, 2, 5, '315000.00', '2025-03-25 06:30:00'),
(24, 2, 6, '240000.00', '2025-03-25 06:45:00'),
(25, 2, 1, '380000.00', '2025-03-25 07:00:00'),
(26, 2, 2, '35000.00', '2025-03-25 07:15:00'),
(27, 2, 3, '85000.00', '2025-03-25 07:30:00'),
(28, 2, 4, '105000.00', '2025-03-25 07:45:00'),
(29, 2, 5, '500000.00', '2025-03-25 08:00:00'),
(30, 2, 6, '150000.00', '2025-03-25 08:15:00'),
(31, 2, 1, '195000.00', '2025-03-25 08:30:00'),
(32, 2, 2, '75000.00', '2025-03-25 08:45:00'),
(33, 2, 3, '315000.00', '2025-03-25 09:00:00'),
(34, 2, 4, '240000.00', '2025-03-25 09:15:00'),
(35, 2, 5, '380000.00', '2025-03-25 09:30:00'),
(36, 2, 6, '35000.00', '2025-03-25 09:45:00'),
(37, 2, 1, '85000.00', '2025-03-25 10:00:00'),
(38, 2, 2, '105000.00', '2025-03-25 10:15:00'),
(39, 2, 3, '700000.00', '2025-03-25 10:30:00'),
(40, 2, 4, '80000.00', '2025-03-25 10:45:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`karyawan_id`);

--
-- Indexes for table `kategori_produk`
--
ALTER TABLE `kategori_produk`
  ADD PRIMARY KEY (`kategori_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `transaksi_id` (`transaksi_id`),
  ADD KEY `produk_id` (`produk_id`);

--
-- Indexes for table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`owner_id`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`pembayaran_id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`produk_id`),
  ADD KEY `kategori_id` (`kategori_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`transaksi_id`),
  ADD KEY `karyawan_id` (`karyawan_id`),
  ADD KEY `pembayaran_id` (`pembayaran_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `karyawan_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kategori_produk`
--
ALTER TABLE `kategori_produk`
  MODIFY `kategori_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `owner`
--
ALTER TABLE `owner`
  MODIFY `owner_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `pembayaran_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `produk_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplier_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `transaksi_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`transaksi_id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`produk_id`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategori_produk` (`kategori_id`),
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`karyawan_id`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`pembayaran_id`) REFERENCES `pembayaran` (`pembayaran_id`);
--
-- Database: `vapex555`
--
CREATE DATABASE IF NOT EXISTS `vapex555` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `vapex555`;

-- --------------------------------------------------------

--
-- Table structure for table `kasir`
--

CREATE TABLE `kasir` (
  `id_kasir` int NOT NULL,
  `nama_kasir` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kasir`
--

INSERT INTO `kasir` (`id_kasir`, `nama_kasir`) VALUES
(1, 'I PUTU AGUS ANANDA GUNA PRASETYA'),
(2, 'I GEDE ADI PRAMANA');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`) VALUES
(1, 'EKA'),
(2, 'DWI'),
(3, 'KAYLA');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `nama_produk`, `kategori`, `harga`, `stok`) VALUES
(1, 'FOOM Pod X', 'Pod', '300000.00', 50),
(2, 'Lost Vape Ursa Nano Pods Kit', 'Pod', '450000.00', 30),
(3, 'Vuse GO Creamy Tobacco 3%', 'Disposable', '150000.00', 100),
(4, 'Voopoo Vinci', 'Pod', '400000.00', 25),
(5, 'Caliburn GK2 by Uwell', 'Pod', '350000.00', 40),
(6, 'SMOK Novo', 'Pod', '320000.00', 35),
(7, 'Relx Infinity', 'Pod', '380000.00', 20),
(8, 'Wasp Nano x Pod by Oumier', 'Pod', '100000.00', 60),
(9, 'Thelema Elite 40 by Lost Vape', 'Pod', '290000.00', 15),
(10, 'Vaporesso XROS 4 Nano', 'Pod', '299000.00', 22);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int NOT NULL,
  `id_produk` int DEFAULT NULL,
  `id_kasir` int DEFAULT NULL,
  `id_pelanggan` int DEFAULT NULL,
  `tanggal_transaksi` date NOT NULL,
  `jumlah` int NOT NULL,
  `total_harga` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_produk`, `id_kasir`, `id_pelanggan`, `tanggal_transaksi`, `jumlah`, `total_harga`) VALUES
(1, 2, 1, 1, '2025-03-20', 1, '450000.00'),
(2, 5, 2, 2, '2025-03-20', 2, '700000.00'),
(3, 8, 1, 3, '2025-03-20', 1, '100000.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kasir`
--
ALTER TABLE `kasir`
  ADD PRIMARY KEY (`id_kasir`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_produk` (`id_produk`),
  ADD KEY `id_kasir` (`id_kasir`),
  ADD KEY `id_pelanggan` (`id_pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kasir`
--
ALTER TABLE `kasir`
  MODIFY `id_kasir` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_kasir`) REFERENCES `kasir` (`id_kasir`),
  ADD CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`);
--
-- Database: `xyz_vape_shop`
--
CREATE DATABASE IF NOT EXISTS `xyz_vape_shop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `xyz_vape_shop`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Pods'),
(2, 'Vape'),
(3, 'Liquid'),
(4, 'Coil'),
(5, 'Cartridge'),
(6, 'Battery'),
(7, 'Aksesori Vape');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `shift` enum('Pagi','Sore') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `shift`) VALUES
(1, 'I PUTU AGUS ANANDA GUNA PRASETYA', 'Pagi'),
(2, 'I GEDE ADI PRAMANA', 'Sore'),
(3, 'NI LUH PUTU EKA MULIANINGSIH', 'Pagi'),
(4, 'PUTRI AYU NABILA', 'Sore'),
(5, 'NI KADEK DWI PUSPITASARI', 'Pagi');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category_id`, `price`, `stock`) VALUES
(1, 'Voopoo Drag X', 1, '450000.00', 20),
(2, 'SMOK Nord 4', 1, '550000.00', 15),
(3, 'GeekVape Wenax K1', 1, '400000.00', 18),
(4, 'Uwell Caliburn G2', 1, '490000.00', 17),
(5, 'Aspire Flexus Q', 1, '430000.00', 12),
(6, 'Lost Vape Orion', 1, '600000.00', 14),
(7, 'Oxva Xlim', 1, '420000.00', 16),
(8, 'Vaporesso Luxe Q2', 1, '470000.00', 19),
(9, 'Smoant Pasito II', 1, '520000.00', 20),
(10, 'Eleaf iStick P100', 1, '650000.00', 10),
(11, 'GeekVape Aegis X', 2, '850000.00', 10),
(12, 'SMOK Mag P3', 2, '900000.00', 15),
(13, 'Voopoo Argus GT2', 2, '880000.00', 12),
(14, 'Vaporesso Luxe PM40', 2, '750000.00', 18),
(15, 'Lost Vape Centaurus', 2, '990000.00', 16),
(16, 'Wotofo MDura Pro', 2, '870000.00', 11),
(17, 'Vgod Lush Ice', 3, '120000.00', 30),
(18, 'Nasty Juice Bad Blood', 3, '115000.00', 25),
(19, 'Ripe Vapes VCT', 3, '125000.00', 28),
(20, 'Tokyo Banana', 3, '110000.00', 20),
(21, 'Blvk Unicorn Lychee', 3, '130000.00', 22),
(22, 'Voopoo PnP VM1 0.3ohm', 4, '75000.00', 25),
(23, 'SMOK RPM 0.4ohm', 4, '70000.00', 30),
(24, 'GeekVape Super Mesh', 4, '80000.00', 22),
(25, 'Uwell Caliburn A2 Cartridge 0.9ohm', 5, '60000.00', 18),
(26, 'Voopoo PnP Pod', 5, '65000.00', 15),
(27, 'Sony VTC6 18650 3000mAh', 6, '130000.00', 40),
(28, 'Samsung 30Q 18650 3000mAh', 6, '125000.00', 35),
(29, 'Cotton Bacon Prime', 7, '50000.00', 50),
(30, 'Vape Band Silicone', 7, '20000.00', 60);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `transaction_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `employee_id`, `total_price`, `transaction_date`) VALUES
(1, 1, '650000.00', '2025-03-21 02:04:20'),
(2, 1, '780000.00', '2025-03-21 02:04:20'),
(3, 1, '450000.00', '2025-03-21 02:04:20'),
(4, 3, '850000.00', '2025-03-21 02:04:20'),
(5, 5, '920000.00', '2025-03-21 02:04:20'),
(6, 2, '730000.00', '2025-03-21 02:04:20'),
(7, 2, '560000.00', '2025-03-21 02:04:20'),
(8, 2, '990000.00', '2025-03-21 02:04:20'),
(9, 4, '880000.00', '2025-03-21 02:04:20'),
(10, 4, '1100000.00', '2025-03-21 02:04:20');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` int NOT NULL,
  `transaction_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `transaction_id`, `product_id`, `quantity`, `subtotal`) VALUES
(1, 1, 1, 1, '450000.00'),
(2, 1, 3, 2, '800000.00'),
(3, 2, 7, 1, '420000.00'),
(4, 2, 10, 1, '650000.00'),
(5, 3, 4, 1, '490000.00'),
(6, 3, 5, 1, '430000.00'),
(7, 4, 2, 2, '1100000.00'),
(8, 4, 8, 1, '470000.00'),
(9, 5, 11, 1, '850000.00'),
(10, 5, 14, 1, '750000.00'),
(11, 6, 19, 2, '230000.00'),
(12, 6, 21, 1, '125000.00'),
(13, 7, 22, 2, '160000.00'),
(14, 7, 23, 1, '65000.00'),
(15, 8, 25, 1, '125000.00'),
(16, 8, 26, 1, '50000.00'),
(17, 9, 27, 1, '20000.00'),
(18, 9, 6, 1, '600000.00'),
(19, 10, 9, 1, '520000.00'),
(20, 10, 16, 1, '870000.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD CONSTRAINT `transaction_details_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
