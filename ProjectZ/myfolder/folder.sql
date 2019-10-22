-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 19, 2019 at 09:05 AM
-- Server version: 10.0.38-MariaDB-cll-lve
-- PHP Version: 7.2.7

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

CREATE TABLE `documents` (
  `document_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `location` varchar(400) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `department` enum('Personel','Head','All') NOT NULL DEFAULT 'Personel'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`document_id`, `name`, `location`, `size`, `date`, `department`) VALUES
(176, 'HR Policy 01102019_Draft .pdf', 'uploads/HR Policy 01102019_Draft .pdf', 626634, '2019-10-08', 'Head'),
(177, 'Employee Handbook.pdf', 'uploads/Employee Handbook.pdf', 662832, '2019-10-08', 'All');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `em_position` enum('Admin','Employee') NOT NULL,
  `department` enum('Personel','Head','All') NOT NULL DEFAULT 'Personel'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Indexes for dumped tables
--

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `fk_depart_idx` (`department`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `depart_idx` (`department`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

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
