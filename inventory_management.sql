-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 25, 2025 at 01:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(1000) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL,
  `id_pemasok` int(11) DEFAULT NULL,
  `total_harga` decimal(10,2) GENERATED ALWAYS AS (`harga` * `stok`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `harga`, `stok`, `id_pemasok`) VALUES
(1, 'Monitor', 2500000.00, 13, NULL),
(2, 'Printer', 1200000.00, 15, NULL),
(3, 'Headset', 450000.00, 35, NULL),
(4, 'Webcam', 800000.00, 10, NULL),
(5, 'Harddisk Eksternal', 1000000.00, 12, NULL),
(6, 'Flashdisk', 120000.00, 100, NULL),
(7, 'Router WiFi', 500000.00, 18, NULL),
(8, 'Kabel HDMI', 100000.00, 40, NULL),
(9, 'Powerbank', 300000.00, 35, NULL),
(10, 'Smartphone', 3500000.00, 8, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kota`
--

CREATE TABLE `kota` (
  `id_kota` int(11) NOT NULL,
  `nama_kota` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `laporanbarangpemasok`
-- (See below for the actual view)
--
CREATE TABLE `laporanbarangpemasok` (
`nama_barang` varchar(1000)
,`harga` decimal(10,2)
,`stok` int(11)
,`nama_pemasok` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL,
  `alamat` text DEFAULT NULL,
  `kategori` enum('VIP','Reguler','Baru') DEFAULT 'Baru'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`, `alamat`, `kategori`) VALUES
(1, 'Michael Tan', 'Depok', 'Baru'),
(2, 'Sarah Lim', 'Bekasi', 'Baru'),
(3, 'Kevin Hartono', 'Bogor', 'Baru'),
(4, 'Linda Ang', 'Tangerang Selatan', 'Baru'),
(5, 'James Wijaya', 'Bandung', 'Baru'),
(6, 'Melissa Wong', 'Serang', 'Baru'),
(7, 'Andrew Sutanto', 'Semarang', 'Baru'),
(8, 'Christine Halim', 'Surabaya', 'Baru'),
(9, 'Steven Chandra', 'Medan', 'Baru'),
(10, 'Emily Huang', 'Yogyakarta', 'Baru');

-- --------------------------------------------------------

--
-- Table structure for table `pemasok`
--

CREATE TABLE `pemasok` (
  `id_pemasok` int(11) NOT NULL,
  `nama_pemasok` varchar(100) NOT NULL,
  `kontak` varchar(50) DEFAULT NULL,
  `id_kota` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemasok`
--

INSERT INTO `pemasok` (`id_pemasok`, `nama_pemasok`, `kontak`, `id_kota`) VALUES
(1, 'CV. Komputer Solusi', '021-11223344', NULL),
(2, 'PT. Digital Aksesoris', '021-33445566', NULL),
(3, 'UD. Jaringan Prima', '021-77889900', NULL),
(4, 'Toko Grosir Elektronik', '021-44556677', NULL),
(5, 'PT. Techno Supplies', '021-55667788', NULL),
(6, 'CV. Media Hardware', '021-66778899', NULL),
(7, 'PT. Peralatan Digital', '021-22334455', NULL),
(8, 'Toko Online Aksesoris', '021-88997766', NULL),
(9, 'CV. Komponen Utama', '021-33446688', NULL),
(10, 'PT. Elektronik Canggih', '021-77889955', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure for view `laporanbarangpemasok`
--
DROP TABLE IF EXISTS `laporanbarangpemasok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `laporanbarangpemasok`  AS SELECT `b`.`nama_barang` AS `nama_barang`, `b`.`harga` AS `harga`, `b`.`stok` AS `stok`, `p`.`nama_pemasok` AS `nama_pemasok` FROM (`barang` `b` join `pemasok` `p` on(`b`.`id_pemasok` = `p`.`id_pemasok`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `idx_nama_barang` (`nama_barang`(768)),
  ADD KEY `idx_harga_barang` (`harga`),
  ADD KEY `idx_id_pemasok` (`id_pemasok`),
  ADD KEY `idx_barang_id_pemasok` (`id_pemasok`);

--
-- Indexes for table `kota`
--
ALTER TABLE `kota`
  ADD PRIMARY KEY (`id_kota`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`),
  ADD KEY `idx_nama_pelanggan` (`nama_pelanggan`);

--
-- Indexes for table `pemasok`
--
ALTER TABLE `pemasok`
  ADD PRIMARY KEY (`id_pemasok`),
  ADD KEY `idx_kontak_pemasok` (`kontak`),
  ADD KEY `id_kota` (`id_kota`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_pelanggan` (`id_pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `kota`
--
ALTER TABLE `kota`
  MODIFY `id_kota` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pemasok`
--
ALTER TABLE `pemasok`
  MODIFY `id_pemasok` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `fk_pemasok` FOREIGN KEY (`id_pemasok`) REFERENCES `pemasok` (`id_pemasok`);

--
-- Constraints for table `pemasok`
--
ALTER TABLE `pemasok`
  ADD CONSTRAINT `pemasok_ibfk_1` FOREIGN KEY (`id_kota`) REFERENCES `kota` (`id_kota`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
