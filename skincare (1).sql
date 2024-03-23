-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Des 2023 pada 18.56
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `skincare`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `consultation_history`
--

CREATE TABLE `consultation_history` (
  `id` int(15) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `tanggal_konsultasi` date DEFAULT NULL,
  `hasil_diagnosa` decimal(3,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Trigger `consultation_history`
--
DELIMITER $$
CREATE TRIGGER `before_insert_consultation_history` BEFORE INSERT ON `consultation_history` FOR EACH ROW SET NEW.tanggal_konsultasi = CURDATE()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL,
  `ingredient_name` varchar(255) DEFAULT NULL,
  `recommendation_score` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ingredients`
--

INSERT INTO `ingredients` (`id`, `ingredient_name`, `recommendation_score`) VALUES
(1, 'Cleanser lembut dengan pH rendah', 0.8),
(2, 'Hydrating toner', 0.7),
(3, 'Pelembab khusus untuk kulit kering', 0.9),
(4, 'Sunscreen SPF di atas 45', 0.8),
(5, 'Exfoliator lembut', 0.7),
(6, 'Skincare Pyunkang Yul Essence Toner', 0.9),
(7, 'COSRX Advanced Snail', 0.8),
(8, 'Cleanser dengan pH rendah', 0.8),
(9, 'Hydrating toner', 0.7),
(10, 'Serum dengan Antioksiden', 0.8),
(11, 'Sunscreen SPF tinggi', 0.9),
(12, 'Exfoliator mengandung BHA', 0.7),
(13, 'Cleanser lembut dengan pH rendah', 0.8),
(14, 'Hydrating AHA/BHA', 0.7),
(15, 'Pelembab ringan atau Gel', 0.8),
(16, 'Serum dengan Niacinamide', 0.9),
(17, 'Sunscreen dengan SPF 50+', 0.9),
(18, 'Exfoliator lembut yang mengandung Salicylic Acid 2% dan BHA', 0.7),
(19, 'Cleanser dengan pH netral', 0.8),
(20, 'Hydrating Toner', 0.7),
(21, 'Pelembab intensif', 0.9),
(22, 'Serum dengan Hyaluronic Acid 2%+B5', 0.8),
(23, 'Sunscreen dengan SPF tinggi', 0.9),
(24, 'Exfoliator yang lembut ordinary lactic Acid 5%+HA', 0.7),
(25, 'Cleanser pH netral', 0.8),
(26, 'Toner PH-balanced', 0.7),
(27, 'Pelembab ringan moisturizing lation', 0.9),
(28, 'Serum ringan atau essence mengandung moisturizing factors + HA', 0.8),
(29, 'Sunscreen', 0.9),
(30, 'Niacinamide (Vitamin B3)', 0.8),
(31, 'Hyaluronic Acid', 0.7),
(32, 'Salicylic Acid (BHA)', 0.8),
(33, 'Witch Hazel', 0.9),
(34, 'Alpha Hydroxy Acids (AHAs)', 0.7),
(35, 'Pantenol (Provitamin B5)', 0.8),
(36, 'Oil-free Moisturizer', 0.9),
(37, 'Matte Finish Sunscreen dengan SPF tinggi', 0.9),
(38, 'Hyaluronic Acid', 0.8),
(39, 'Glycerin', 0.7),
(40, 'Vitamin C', 0.8),
(41, 'Niacinamide (Vitamin B3)', 0.9),
(42, 'Aloe Vera', 0.8),
(43, 'Peptida', 0.7),
(44, 'Ceramide', 0.9),
(45, 'Ekstrak Teh Hijau', 0.8),
(46, 'Alpha Hydroxy Acids (AHAs)', 0.7),
(47, 'Asam Salisilat (Salicylic Acid)', 0.8),
(48, 'Niacinamide (Vitamin B3)', 0.8),
(49, 'Hyaluronic Acid', 0.7),
(50, 'Glycerin', 0.8),
(51, 'Alpha Hydroxy Acids (AHAs)', 0.9),
(52, 'Bentonite Clay', 0.8),
(53, 'Zinc PCA', 0.7),
(54, 'Mattifying Agents', 0.9),
(55, 'Green Tea Extract', 0.8),
(56, 'Oil-free Moisturizer', 0.9);

-- --------------------------------------------------------

--
-- Struktur dari tabel `skincare_recommendations`
--

CREATE TABLE `skincare_recommendations` (
  `id` int(11) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `ingredient_name` varchar(100) DEFAULT NULL,
  `recommendation_score` decimal(3,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `skincare_recommendations`
--

INSERT INTO `skincare_recommendations` (`id`, `category`, `ingredient_name`, `recommendation_score`) VALUES
(1, 'pH Rendah dan Kulit Kering', 'Cleanser lembut dengan pH rendah', 0.1),
(2, 'pH Rendah dan Kulit Kering', 'Hydrating toner', 0.1),
(3, 'pH Rendah dan Kulit Kering', 'Pelembab khusus untuk kulit kering', 0.1),
(4, 'pH Rendah dan Kulit Kering', 'Sunscreen SPF di atas 45', 0.1),
(5, 'pH Rendah dan Kulit Kering', 'Exfoliator lembut', 0.1),
(6, 'pH Rendah dan Kulit Kering', 'Skincare Pyunkang Yul Essence Toner', 0.1),
(7, 'pH Rendah dan Kulit Kering', 'COSRX Advanced Snail', 0.1),
(8, 'pH Rendah dan Kulit Normal', 'Cleanser dengan pH rendah', 0.2),
(9, 'pH Rendah dan Kulit Normal', 'Hydrating toner', 0.2),
(10, 'pH Rendah dan Kulit Normal', 'Serum dengan Antioksiden', 0.2),
(11, 'pH Rendah dan Kulit Normal', 'Sunscreen SPF tinggi', 0.2),
(12, 'pH Rendah dan Kulit Normal', 'Exifolator mengandung BHA', 0.2),
(13, 'pH Tinggi dan Kulit Berminyak', 'Niacinamide (Vitamin B3)', 0.3),
(14, 'pH Tinggi dan Kulit Berminyak', 'Hyaluronic Acid', 0.3),
(15, 'pH Tinggi dan Kulit Berminyak', 'Salicylic Acid (BHA)', 0.3),
(16, 'pH Tinggi dan Kulit Berminyak', 'Witch Hazel', 0.3),
(17, 'pH Tinggi dan Kulit Berminyak', 'Alpha Hydroxy Acids (AHAs)', 0.3),
(18, 'pH Tinggi dan Kulit Berminyak', 'Pantenol (Provitamin B5)', 0.3),
(19, 'pH Tinggi dan Kulit Berminyak', 'Oil-free Moisturizer', 0.3),
(20, 'pH Tinggi dan Kulit Berminyak', 'Matte Finish Sunscreen dengan SPF tinggi', 0.3),
(21, 'pH Netral dan Kulit Kering', 'Cleanser dengan pH netral', 0.4),
(22, 'pH Netral dan Kulit Kering', 'Hydrating Toner', 0.4),
(23, 'pH Netral dan Kulit Kering', 'Pelembab intensif', 0.4),
(24, 'pH Netral dan Kulit Kering', 'Serum dengan Hyaluronic Acid 2%+B5', 0.4),
(25, 'pH Netral dan Kulit Kering', 'Sunscreen dengan SPF tinggi', 0.4),
(26, 'pH Netral dan Kulit Kering', 'Exfoliator yang lembut ordinary lactic Acid 5%+HA', 0.4),
(27, 'pH Netral dan Kulit Normal', 'Cleanser pH netral', 0.5),
(28, 'pH Netral dan Kulit Normal', 'Toner PH-balanced', 0.5),
(29, 'pH Netral dan Kulit Normal', 'Pelembab ringan moisturizing lation', 0.5),
(30, 'pH Netral dan Kulit Normal', 'Serum ringan atau essence mengandung moisturizing factors + HA', 0.5),
(31, 'pH Netral dan Kulit Normal', 'Sunscreen', 0.5),
(32, 'pH Netral dan Kulit Berminyak', 'Niacinamide (Vitamin B3)', 0.6),
(33, 'pH Netral dan Kulit Berminyak', 'Hyaluronic Acid', 0.6),
(34, 'pH Netral dan Kulit Berminyak', 'Salicylic Acid (BHA)', 0.6),
(35, 'pH Netral dan Kulit Berminyak', 'Witch Hazel', 0.6),
(36, 'pH Netral dan Kulit Berminyak', 'Alpha Hydroxy Acids (AHAs)', 0.6),
(37, 'pH Netral dan Kulit Berminyak', 'Pantenol (Provitamin B5)', 0.6),
(38, 'pH Netral dan Kulit Berminyak', 'Oil-free Moisturizer', 0.6),
(39, 'pH Netral dan Kulit Berminyak', 'Matte Finish Sunscreen dengan SPF tinggi', 0.6),
(40, 'pH Tinggi dan Kulit Kering', 'Hyaluronic Acid', 0.7),
(41, 'pH Tinggi dan Kulit Kering', 'Glycerin', 0.7),
(42, 'pH Tinggi dan Kulit Kering', 'Ceramide', 0.7),
(43, 'pH Tinggi dan Kulit Kering', 'Shea Butter', 0.7),
(44, 'pH Tinggi dan Kulit Kering', 'Beta-Glucans', 0.7),
(45, 'pH Tinggi dan Kulit Kering', 'Dimethicone (Silicone)', 0.7),
(46, 'pH Tinggi dan Kulit Kering', 'Cream-based Cleanser', 0.7),
(47, 'pH Tinggi dan Kulit Kering', 'Colloidal Oatmeal', 0.7),
(48, 'pH Tinggi dan Kulit Normal', 'Hyaluronic Acid', 0.8),
(49, 'pH Tinggi dan Kulit Normal', 'Glycerin', 0.8),
(50, 'pH Tinggi dan Kulit Normal', 'Vitamin C', 0.8),
(51, 'pH Tinggi dan Kulit Normal', 'Niacinamide (Vitamin B3)', 0.8),
(52, 'pH Tinggi dan Kulit Normal', 'Aloe Vera', 0.8),
(53, 'pH Tinggi dan Kulit Normal', 'Peptida', 0.8),
(54, 'pH Tinggi dan Kulit Normal', 'Ceramide', 0.8),
(55, 'pH Tinggi dan Kulit Normal', 'Ekstrak Teh Hijau', 0.8),
(56, 'pH Tinggi dan Kulit Normal', 'Alpha Hydroxy Acids (AHAs)', 0.8),
(57, 'pH Tinggi dan Kulit Berminyak', 'Asam Salisilat (Salicylic Acid)', 0.9),
(58, 'pH Tinggi dan Kulit Berminyak', 'Niacinamide (Vitamin B3)', 0.9),
(59, 'pH Tinggi dan Kulit Berminyak', 'Hyaluronic Acid', 0.9),
(60, 'pH Tinggi dan Kulit Berminyak', 'Glycerin', 0.9),
(61, 'pH Tinggi dan Kulit Berminyak', 'Alpha Hydroxy Acids (AHAs)', 0.9),
(62, 'pH Tinggi dan Kulit Berminyak', 'Bentonite Clay', 0.9),
(63, 'pH Tinggi dan Kulit Berminyak', 'Zinc PCA', 0.9),
(64, 'pH Tinggi dan Kulit Berminyak', 'Mattifying Agents', 0.9),
(65, 'pH Tinggi dan Kulit Berminyak', 'Green Tea Extract', 0.9),
(66, 'pH Tinggi dan Kulit Berminyak', 'Oil-free Moisturizer', 0.9);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `consultation_history`
--
ALTER TABLE `consultation_history`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `skincare_recommendations`
--
ALTER TABLE `skincare_recommendations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `consultation_history`
--
ALTER TABLE `consultation_history`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT untuk tabel `skincare_recommendations`
--
ALTER TABLE `skincare_recommendations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
