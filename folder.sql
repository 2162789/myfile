-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 25, 2019 at 01:12 AM
-- Server version: 5.7.26
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `folder`
--

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `location` varchar(400) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `name`, `location`, `size`, `date`) VALUES
(97, 'Hot Fuzz (2007) [BluRay] [720p] [YTS.LT].torrent', 'uploads/Hot Fuzz (2007) [BluRay] [720p] [YTS.LT].torrent', 17662, '2019-09-24'),
(93, 'edited (1).pdf', 'uploads/edited (1).pdf', 358152, '2019-09-24'),
(100, 'IPA-Risa-converted.pdf', 'uploads/IPA-Risa-converted.pdf', 223744, '2019-09-24'),
(98, 'IPA-Risa.pdf', 'uploads/IPA-Risa.pdf', 354347, '2019-09-24'),
(99, 'IPA-Risa-converted.docx', 'uploads/IPA-Risa-converted.docx', 202393, '2019-09-24'),
(91, 'Captain Marvel (2019) [WEBRip] [720p] [YTS.LT].torrent', 'uploads/Captain Marvel (2019) [WEBRip] [720p] [YTS.LT].torrent', 43041, '2019-09-24'),
(92, 'Descendants (2015) [WEBRip] [720p] [YTS.LT].torrent', 'uploads/Descendants (2015) [WEBRip] [720p] [YTS.LT].torrent', 38572, '2019-09-24'),
(101, 'IMG_2019-08-03-19312790.jpg', 'uploads/IMG_2019-08-03-19312790.jpg', 46020, '2019-09-25');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `em_position` enum('Admin','Employee') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `em_position`) VALUES
(1, 'admin', 'admin', 'Admin');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
