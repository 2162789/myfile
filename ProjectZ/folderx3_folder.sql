-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 22, 2019 at 02:52 AM
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
-- Database: `folderx3_folder`
--

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `document_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `location` varchar(400) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `department` enum('Personel','Head','All') NOT NULL DEFAULT 'Personel',
  PRIMARY KEY (`document_id`),
  KEY `fk_depart_idx` (`department`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `department` enum('Personel','Head','All') NOT NULL DEFAULT 'Personel',
  PRIMARY KEY (`id`),
  KEY `depart_idx` (`department`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `em_position`, `department`) VALUES
(1, 'admin', 'admin', 'Admin', 'Personel'),
(4, 'hr_department', 'hr_department', 'Employee', 'All'),
(6, 'nicolas_dohr', 'nicolas_dohr', 'Employee', 'Personel'),
(7, 'erika_hr', 'erika_hr', 'Employee', 'Head'),
(117, 'soon_fhgcc', 'soon_fhgcc', 'Employee', 'Head'),
(119, 'cindy_doam', 'cindy_doam', 'Employee', 'Head'),
(120, 'ranjit_don', 'ranjit_don', 'Employee', 'Head'),
(121, 'cecelia_ddon', 'cecelia_ddon', 'Employee', 'Head'),
(123, 'alvin_ddgh', 'alvin_ddgh', 'Employee', 'Head'),
(124, 'win_dof', 'win_dof', 'Employee', 'Head'),
(125, 'ching_hoo', 'ching_hoo', 'Employee', 'Head'),
(126, 'bin_cmhcc', 'bin_cmhcc', 'Employee', 'Head'),
(127, 'norwaty_cmgcdc', 'norwaty_cmgcdc', 'Employee', 'Head'),
(128, 'venerable', 'venerable', 'Employee', 'Head'),
(129, 'boey_hoit', 'boey_hoit', 'Employee', 'Head');

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE IF NOT EXISTS `vouchers` (
  `vouchers_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `destination` varchar(400) DEFAULT NULL,
  `curdate` date DEFAULT NULL,
  PRIMARY KEY (`vouchers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vouchers`
--

INSERT INTO `vouchers` (`vouchers_id`, `name`, `destination`, `curdate`) VALUES
(2, 'oreinz', 'voucher/20180309150741884.pdf', '2019-10-22'),
(3, 'oreinz', 'voucher/WIN_20180302_18_04_53_Pro.jpg', '2019-10-22');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `fk_depart` FOREIGN KEY (`department`) REFERENCES `users` (`department`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
