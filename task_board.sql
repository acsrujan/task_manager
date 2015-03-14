-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 03, 2014 at 10:25 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `task_board`
--

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('bed2461b50c00e6dedd18d4e7d7a2ac6', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:30.0) Gec', 1409658632, 'a:2:{s:6:"logged";b:1;s:4:"user";s:1:"1";}');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE IF NOT EXISTS `project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `user`, `name`, `description`, `date_created`) VALUES
(1, 1, 'hs', 'dj', '2014-09-02 11:52:34');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `setting_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(50) DEFAULT NULL,
  `setting_value` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`setting_id`),
  UNIQUE KEY `setting_name` (`setting_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_id`, `setting_name`, `setting_value`) VALUES
(1, 'database_version', '1.2'),
(2, 'stb_install_date', '2014-09-02');

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `task_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `code` int(10) unsigned NOT NULL,
  `status` tinyint(4) unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `priority` tinyint(4) unsigned NOT NULL,
  `description` text NOT NULL,
  `files` text NOT NULL,
  `database` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`),
  KEY `status` (`project_id`,`status`),
  KEY `parent` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`task_id`, `project_id`, `parent_id`, `user_id`, `code`, `status`, `title`, `priority`, `description`, `files`, `database`, `date_created`) VALUES
(1, 1, NULL, 1, 1, 0, 'zhj', 2, '', '', '', '2014-09-02 11:52:42'),
(2, 1, NULL, 1, 2, 0, 'sdyu', 2, '', '', '', '2014-09-02 11:52:52');

-- --------------------------------------------------------

--
-- Table structure for table `task_history`
--

CREATE TABLE IF NOT EXISTS `task_history` (
  `task_history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` tinyint(4) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `date_finished` datetime DEFAULT NULL,
  `duration` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`task_history_id`),
  KEY `task` (`task_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(40) NOT NULL,
  `level` tinyint(4) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `level`, `date_created`) VALUES
(1, 'abc', '420318eaceb78cf5d4de7cfe958310eb2dd15245', 0, '2014-09-02 11:52:17');

-- --------------------------------------------------------

--
-- Table structure for table `user_project`
--

CREATE TABLE IF NOT EXISTS `user_project` (
  `user` int(10) unsigned NOT NULL,
  `project` int(10) unsigned NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user`,`project`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_project`
--

INSERT INTO `user_project` (`user`, `project`, `date_created`) VALUES
(1, 1, '2014-09-02 11:52:34');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `task_stbfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `task_stbfk_2` FOREIGN KEY (`parent_id`) REFERENCES `task` (`task_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `task_history`
--
ALTER TABLE `task_history`
  ADD CONSTRAINT `task_history_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
