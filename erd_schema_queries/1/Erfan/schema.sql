-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 16, 2018 at 06:25 AM
-- Server version: 5.7.21-0ubuntu0.17.10.1
-- PHP Version: 7.1.11-0ubuntu0.17.10.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `1_1`
--

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `id` int(11) NOT NULL,
  `host_point` int(11) NOT NULL,
  `guest_point` int(11) NOT NULL,
  `date` varchar(90) NOT NULL,
  `guest_team` int(11) NOT NULL,
  `host_team` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `most_score`
-- (See below for the actual view)
--
CREATE TABLE `most_score` (
`guest_team` int(11)
,`host_team` int(11)
,`points` decimal(33,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `post` varchar(90) NOT NULL,
  `in_national_team` tinyint(1) NOT NULL,
  `injury` tinyint(1) NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  `captian_team_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `saipa`
-- (See below for the actual view)
--
CREATE TABLE `saipa` (
`id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `coach` varchar(90) NOT NULL,
  `name` varchar(90) NOT NULL,
  `city` varchar(90) NOT NULL,
  `score` int(11) NOT NULL,
  `in_Asia_league` tinyint(1) NOT NULL,
  `captain_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure for view `most_score`
--
DROP TABLE IF EXISTS `most_score`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `most_score`  AS  (select `game`.`guest_team` AS `guest_team`,`game`.`host_team` AS `host_team`,sum((`game`.`host_point` + `game`.`guest_point`)) AS `points` from `game` group by `game`.`id` order by `points` desc limit 1) ;

-- --------------------------------------------------------

--
-- Structure for view `saipa`
--
DROP TABLE IF EXISTS `saipa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `saipa`  AS  select `team`.`id` AS `id` from `team` where (`team`.`name` = 'saipa') ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `player`
--
ALTER TABLE `player`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
