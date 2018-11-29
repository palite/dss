-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 29, 2018 at 04:00 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dss`
--

-- --------------------------------------------------------

--
-- Table structure for table `hak_akses`
--

CREATE TABLE `hak_akses` (
  `Id_Hak_Akses` varchar(10) NOT NULL,
  `Nama_Hak_Akses` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hasil_seleksi`
--

CREATE TABLE `hasil_seleksi` (
  `Id_Lokasi` varchar(10) NOT NULL,
  `Id_Pemilih` varchar(10) NOT NULL,
  `Hasil` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kriteria`
--

CREATE TABLE `kriteria` (
  `Id_Kriteria` varchar(10) NOT NULL,
  `Nama_Kriteria` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lokasi`
--

CREATE TABLE `lokasi` (
  `Id_Lokasi` varchar(10) NOT NULL,
  `Nama_Daerah` text NOT NULL,
  `Alamat` varchar(100) NOT NULL,
  `Kota` text NOT NULL,
  `Harga` float DEFAULT NULL,
  `Lantai_Ruko` float DEFAULT NULL,
  `Luas_Ruko` float DEFAULT NULL,
  `Persaingan_Sekitar` float DEFAULT NULL,
  `Luas_Lahan_Parkir` float DEFAULT NULL,
  `Akses_Transport` float DEFAULT NULL,
  `Bit` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pembobotan_alternatif`
--

CREATE TABLE `pembobotan_alternatif` (
  `Id_Lokasi` varchar(10) NOT NULL,
  `Id_Pemilihan` varchar(10) NOT NULL,
  `Id_Kriteria` varchar(10) NOT NULL,
  `Id_Subkriteria` varchar(10) NOT NULL,
  `Penilaian` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pembobotan_kriteria`
--

CREATE TABLE `pembobotan_kriteria` (
  `Id_Kriteria` varchar(10) NOT NULL,
  `Id_User` varchar(10) NOT NULL,
  `Bobot_Kriteria` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pembobotan_subkriteria`
--

CREATE TABLE `pembobotan_subkriteria` (
  `Id_Kriteria` varchar(10) NOT NULL,
  `Id_Pemilihan` varchar(10) NOT NULL,
  `Id_Subkriteria` varchar(10) NOT NULL,
  `Bobot_Subkriteria` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pemilihan`
--

CREATE TABLE `pemilihan` (
  `Id_Pemilihan` varchar(10) NOT NULL,
  `Id_User` varchar(10) NOT NULL,
  `Tanggal` date NOT NULL,
  `Bit_Pem` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `perbandingan_kriteria`
--

CREATE TABLE `perbandingan_kriteria` (
  `Per_Id_Kriteria` varchar(10) NOT NULL,
  `Id_Pemilihan` varchar(10) NOT NULL,
  `Id_Kriteria` varchar(10) NOT NULL,
  `Nilai_Kriteria` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `perbandingan_subkriteria`
--

CREATE TABLE `perbandingan_subkriteria` (
  `Id_Subkriteria` varchar(10) NOT NULL,
  `Id_Kriteria` varchar(10) NOT NULL,
  `Id_Pemilihan` varchar(10) NOT NULL,
  `Per_Id_Subkriteria` varchar(10) NOT NULL,
  `Nilai_Subkriteria` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `subkriteria`
--

CREATE TABLE `subkriteria` (
  `Id_Subkriteria` varchar(10) NOT NULL,
  `Id_Kriteria` varchar(10) NOT NULL,
  `Nama_Subkriteria` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Id_User` varchar(10) NOT NULL,
  `Id_Hak_Akses` varchar(10) NOT NULL,
  `Nama_User` text NOT NULL,
  `No_Tlp` decimal(15,0) DEFAULT NULL,
  `Email` text NOT NULL,
  `Username` text NOT NULL,
  `Password` text NOT NULL,
  `Bit2` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hak_akses`
--
ALTER TABLE `hak_akses`
  ADD PRIMARY KEY (`Id_Hak_Akses`),
  ADD UNIQUE KEY `Id_Hak_Akses` (`Id_Hak_Akses`);

--
-- Indexes for table `hasil_seleksi`
--
ALTER TABLE `hasil_seleksi`
  ADD PRIMARY KEY (`Id_Lokasi`,`Id_Pemilih`),
  ADD KEY `Id_Pemilihan` (`Id_Pemilih`);

--
-- Indexes for table `kriteria`
--
ALTER TABLE `kriteria`
  ADD PRIMARY KEY (`Id_Kriteria`),
  ADD UNIQUE KEY `Id_Kriteria` (`Id_Kriteria`);

--
-- Indexes for table `lokasi`
--
ALTER TABLE `lokasi`
  ADD PRIMARY KEY (`Id_Lokasi`),
  ADD UNIQUE KEY `Id_Lokasi` (`Id_Lokasi`);

--
-- Indexes for table `pembobotan_alternatif`
--
ALTER TABLE `pembobotan_alternatif`
  ADD PRIMARY KEY (`Id_Lokasi`,`Id_Pemilihan`,`Id_Kriteria`,`Id_Subkriteria`),
  ADD KEY `r` (`Id_Kriteria`),
  ADD KEY `zvh` (`Id_Pemilihan`),
  ADD KEY `zvha` (`Id_Subkriteria`);

--
-- Indexes for table `pembobotan_kriteria`
--
ALTER TABLE `pembobotan_kriteria`
  ADD PRIMARY KEY (`Id_Kriteria`,`Id_User`),
  ADD UNIQUE KEY `Id_Kriteria` (`Id_Kriteria`,`Id_User`),
  ADD UNIQUE KEY `Id_User` (`Id_User`) USING BTREE;

--
-- Indexes for table `pembobotan_subkriteria`
--
ALTER TABLE `pembobotan_subkriteria`
  ADD PRIMARY KEY (`Id_Kriteria`,`Id_Pemilihan`,`Id_Subkriteria`),
  ADD KEY `aaaas` (`Id_Subkriteria`),
  ADD KEY `aaaass` (`Id_Pemilihan`);

--
-- Indexes for table `pemilihan`
--
ALTER TABLE `pemilihan`
  ADD PRIMARY KEY (`Id_Pemilihan`),
  ADD UNIQUE KEY `Id_User` (`Id_User`),
  ADD UNIQUE KEY `Id_Pemilihan` (`Id_Pemilihan`);

--
-- Indexes for table `perbandingan_kriteria`
--
ALTER TABLE `perbandingan_kriteria`
  ADD PRIMARY KEY (`Per_Id_Kriteria`,`Id_Pemilihan`,`Id_Kriteria`),
  ADD KEY `1234` (`Id_Kriteria`),
  ADD KEY `12345` (`Id_Pemilihan`);

--
-- Indexes for table `perbandingan_subkriteria`
--
ALTER TABLE `perbandingan_subkriteria`
  ADD PRIMARY KEY (`Id_Subkriteria`,`Id_Kriteria`,`Id_Pemilihan`,`Per_Id_Subkriteria`),
  ADD KEY `vavavavav` (`Id_Kriteria`),
  ADD KEY `vavav3avav1` (`Id_Pemilihan`);

--
-- Indexes for table `subkriteria`
--
ALTER TABLE `subkriteria`
  ADD PRIMARY KEY (`Id_Subkriteria`),
  ADD UNIQUE KEY `Id_Kriteria` (`Id_Kriteria`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Id_User`),
  ADD UNIQUE KEY `Id_Hak_Akses` (`Id_Hak_Akses`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hasil_seleksi`
--
ALTER TABLE `hasil_seleksi`
  ADD CONSTRAINT `Id_Lokasi` FOREIGN KEY (`Id_Lokasi`) REFERENCES `lokasi` (`Id_Lokasi`),
  ADD CONSTRAINT `Id_Pemilihan` FOREIGN KEY (`Id_Pemilih`) REFERENCES `pemilihan` (`Id_Pemilihan`);

--
-- Constraints for table `pembobotan_alternatif`
--
ALTER TABLE `pembobotan_alternatif`
  ADD CONSTRAINT `r` FOREIGN KEY (`Id_Kriteria`) REFERENCES `kriteria` (`Id_Kriteria`),
  ADD CONSTRAINT `z` FOREIGN KEY (`Id_Lokasi`) REFERENCES `lokasi` (`Id_Lokasi`),
  ADD CONSTRAINT `zvh` FOREIGN KEY (`Id_Pemilihan`) REFERENCES `pemilihan` (`Id_Pemilihan`),
  ADD CONSTRAINT `zvha` FOREIGN KEY (`Id_Subkriteria`) REFERENCES `subkriteria` (`Id_Subkriteria`);

--
-- Constraints for table `pembobotan_kriteria`
--
ALTER TABLE `pembobotan_kriteria`
  ADD CONSTRAINT `Id_Kriteria` FOREIGN KEY (`Id_Kriteria`) REFERENCES `kriteria` (`Id_Kriteria`),
  ADD CONSTRAINT `user` FOREIGN KEY (`Id_User`) REFERENCES `user` (`Id_User`);

--
-- Constraints for table `pembobotan_subkriteria`
--
ALTER TABLE `pembobotan_subkriteria`
  ADD CONSTRAINT `aaaas` FOREIGN KEY (`Id_Subkriteria`) REFERENCES `subkriteria` (`Id_Subkriteria`),
  ADD CONSTRAINT `aaaass` FOREIGN KEY (`Id_Pemilihan`) REFERENCES `pemilihan` (`Id_Pemilihan`),
  ADD CONSTRAINT `aaaassf` FOREIGN KEY (`Id_Kriteria`) REFERENCES `kriteria` (`Id_Kriteria`);

--
-- Constraints for table `pemilihan`
--
ALTER TABLE `pemilihan`
  ADD CONSTRAINT `Id_User` FOREIGN KEY (`Id_User`) REFERENCES `user` (`Id_User`);

--
-- Constraints for table `perbandingan_kriteria`
--
ALTER TABLE `perbandingan_kriteria`
  ADD CONSTRAINT `1234` FOREIGN KEY (`Id_Kriteria`) REFERENCES `kriteria` (`Id_Kriteria`),
  ADD CONSTRAINT `12345` FOREIGN KEY (`Id_Pemilihan`) REFERENCES `pemilihan` (`Id_Pemilihan`);

--
-- Constraints for table `perbandingan_subkriteria`
--
ALTER TABLE `perbandingan_subkriteria`
  ADD CONSTRAINT `vavav3avav1` FOREIGN KEY (`Id_Pemilihan`) REFERENCES `pemilihan` (`Id_Pemilihan`),
  ADD CONSTRAINT `vavavavav` FOREIGN KEY (`Id_Kriteria`) REFERENCES `kriteria` (`Id_Kriteria`),
  ADD CONSTRAINT `vavavavav1` FOREIGN KEY (`Id_Subkriteria`) REFERENCES `subkriteria` (`Id_Subkriteria`);

--
-- Constraints for table `subkriteria`
--
ALTER TABLE `subkriteria`
  ADD CONSTRAINT `kriteria1` FOREIGN KEY (`Id_Kriteria`) REFERENCES `kriteria` (`Id_Kriteria`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `Id_Hak_Akses` FOREIGN KEY (`Id_Hak_Akses`) REFERENCES `hak_akses` (`Id_Hak_Akses`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
