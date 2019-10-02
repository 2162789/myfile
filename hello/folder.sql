-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 02, 2019 at 09:11 AM
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
  `document_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `location` varchar(400) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `department` enum('Personel','Head','All') NOT NULL DEFAULT 'Personel',
  PRIMARY KEY (`document_id`),
  KEY `fk_depart_idx` (`department`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`document_id`, `name`, `location`, `size`, `date`, `department`) VALUES
(161, 'Employee Handbook.pdf', 'uploads/Employee Handbook.pdf', 369884, '2019-10-02', 'All'),
(162, 'HR Policy - GL.pdf', 'uploads/HR Policy - GL.pdf', 729882, '2019-10-02', 'Head'),
(163, 'HR Policy  SBWS_FBHCC.pdf', 'uploads/HR Policy  SBWS_FBHCC.pdf', 751701, '2019-10-02', 'Head'),
(169, 'Policy and Procedure on Email Usage _ 01102019.pdf', 'uploads/Policy and Procedure on Email Usage _ 01102019.pdf', 343004, '2019-10-02', 'Head'),
(170, 'Policy and Procedure on Employee Personal Data Protection _ 01102019.pdf', 'uploads/Policy and Procedure on Employee Personal Data Protection _ 01102019.pdf', 433640, '2019-10-02', 'Head'),
(171, 'Policy and Procedure on Identification Badge cum Access Time Card _ 01102019.pdf', 'uploads/Policy and Procedure on Identification Badge cum Access Time Card _ 01102019.pdf', 352663, '2019-10-02', 'Head'),
(172, 'Policy and Procedure on Manpower Utilisation _ 01102019.pdf', 'uploads/Policy and Procedure on Manpower Utilisation _ 01102019.pdf', 349000, '2019-10-02', 'Head');

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
(6, 'nicolas_dohr', 'nicolas_dohr', 'Employee', 'Head'),
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
