# ************************************************************
# Sequel Pro SQL dump
# Version 4135
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.20)
# Database: CrunchBase
# Generation Time: 2014-10-08 17:05:03 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Companies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Companies`;

CREATE TABLE `Companies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text,
  `path` text,
  `all_emails` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Errors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Errors`;

CREATE TABLE `Errors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Offices
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Offices`;

CREATE TABLE `Offices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text,
  `address` text,
  `region` text,
  `country` text,
  `permalink` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table People
# ------------------------------------------------------------

DROP TABLE IF EXISTS `People`;

CREATE TABLE `People` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text,
  `last_name` text,
  `domain` text,
  `title` text,
  `contact_information` text,
  `company` text,
  `permalink` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Updates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Updates`;

CREATE TABLE `Updates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_record_companies` int(20) DEFAULT NULL,
  `last_record_people` int(20) DEFAULT NULL,
  `last_record_info_contact` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
