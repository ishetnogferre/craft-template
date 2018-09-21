# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.23)
# Database: craft
# Generation Time: 2018-09-20 14:57:02 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table blitz_caches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blitz_caches`;

CREATE TABLE `blitz_caches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `blitz_caches_siteId_uri_unq_idx` (`siteId`,`uri`),
  CONSTRAINT `blitz_caches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table blitz_elementcaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blitz_elementcaches`;

CREATE TABLE `blitz_elementcaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `blitz_elementcaches_cacheId_fk` (`cacheId`),
  KEY `blitz_elementcaches_elementId_fk` (`elementId`),
  CONSTRAINT `blitz_elementcaches_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `blitz_caches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blitz_elementcaches_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table blitz_elementquerycaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blitz_elementquerycaches`;

CREATE TABLE `blitz_elementquerycaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `blitz_elementquerycaches_cacheId_fk` (`cacheId`),
  CONSTRAINT `blitz_elementquerycaches_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `blitz_caches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table contactform_submissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `contactform_submissions`;

CREATE TABLE `contactform_submissions` (
  `id` int(11) NOT NULL,
  `form` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `fromName` varchar(255) DEFAULT NULL,
  `fromEmail` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `contactform_submissions_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_teaserDescription` text,
  `field_sectionIndex` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_teaserDescription`, `field_sectionIndex`)
VALUES
	(1,1,1,NULL,'2018-02-19 20:35:16','2018-09-17 12:38:49','3b84c685-8207-422c-b63f-406b469b9f4a',NULL,NULL),
	(2,2,1,'Home','2018-02-19 20:39:37','2018-08-14 09:03:48','38269114-5ed0-4b84-8547-d774e3fa9abe','<p>Volutpat dignissim primis metus ultrices auctor molestie iaculis elit felis imperdiet tortor, semper tempor enim maecenas varius mattis augue phasellus at curabitur, platea nec donec class laoreet ultricies odio nisi inceptos scelerisque.</p>',NULL),
	(3,3,1,'404','2018-02-19 21:05:21','2018-02-19 21:06:01','683fb4b5-c74b-4592-bf47-6cd2b57493ea',NULL,NULL),
	(4,4,1,'503','2018-02-19 21:06:26','2018-02-19 21:06:40','8f083f27-b38d-49b4-9619-602611bdcb34',NULL,NULL);

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;

INSERT INTO `elementindexsettings` (`id`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','{\"sources\":{\"section:1\":{\"tableAttributes\":{\"1\":\"type\",\"2\":\"slug\",\"3\":\"postDate\",\"4\":\"link\"}},\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"postDate\",\"3\":\"expiryDate\",\"4\":\"link\"}},\"section:5\":{\"tableAttributes\":{\"1\":\"type\",\"2\":\"field:21\",\"3\":\"field:20\",\"4\":\"field:22\",\"5\":\"field:19\",\"6\":\"field:18\"}}},\"sourceOrder\":[[\"key\",\"*\"],[\"key\",\"section:1\"],[\"key\",\"section:6\"],[\"heading\",\"Foutpagina‘s\"],[\"key\",\"single:2\"],[\"key\",\"single:3\"],[\"heading\",\"System\"],[\"key\",\"section:5\"]]}','2018-04-23 07:41:10','2018-04-23 07:41:10','198d8b9b-60ce-43ff-863a-3e8fc857a5f3');

/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2018-02-19 20:35:16','2018-09-17 12:38:49','bff80ccc-ca57-412a-b2a4-492b80338d3b'),
	(2,1,'craft\\elements\\Entry',1,0,'2018-02-19 20:39:37','2018-08-14 09:03:48','46759b9e-d091-4feb-a904-2ef5997ebbcb'),
	(3,7,'craft\\elements\\Entry',1,0,'2018-02-19 21:05:21','2018-02-19 21:06:01','91f89820-046b-436b-ab41-77ff769c95f4'),
	(4,8,'craft\\elements\\Entry',1,0,'2018-02-19 21:06:26','2018-02-19 21:06:40','3d3688cf-1c26-4a58-a0e2-f81cd4017771'),
	(10,3,'craft\\elements\\MatrixBlock',1,0,'2018-02-19 21:21:57','2018-08-14 09:03:48','aad30f9b-b978-4dbb-912b-66ba372d3cd7'),
	(11,3,'craft\\elements\\MatrixBlock',1,0,'2018-02-19 21:21:57','2018-08-14 09:03:48','2e3e921e-2640-40bf-897e-ba1a9059950a');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2018-02-19 20:35:16','2018-09-17 12:38:49','a866092d-7a13-4ba5-be91-e8641bf51e8f'),
	(2,2,1,'__home__','__home__',1,'2018-02-19 20:39:37','2018-08-14 09:03:48','e2693d91-deda-452d-87be-0ef6521e2ebd'),
	(3,3,1,'404','404',1,'2018-02-19 21:05:21','2018-02-19 21:06:01','21b75d32-4fd3-4441-9d83-747e8907c3ce'),
	(4,4,1,'503','503',1,'2018-02-19 21:06:26','2018-02-19 21:06:40','32dff806-4646-4a83-90f7-26694b4f452b'),
	(10,10,1,NULL,NULL,1,'2018-02-19 21:21:57','2018-08-14 09:03:48','2aeca8b7-c448-4947-8f6d-067bc2c15604'),
	(11,11,1,NULL,NULL,1,'2018-02-19 21:21:57','2018-08-14 09:03:48','9c3240ba-e0f0-46de-b86d-0a397cf29303');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,1,1,'2018-02-19 20:39:00',NULL,'2018-02-19 20:39:37','2018-08-14 09:03:48','5b49caf1-7db2-4a48-a5e8-667ed9336cde'),
	(3,2,2,NULL,'2018-02-19 21:05:21',NULL,'2018-02-19 21:05:21','2018-02-19 21:06:01','2535114a-8af4-4c5e-a749-7aeab8f4c83d'),
	(4,3,3,NULL,'2018-02-19 21:06:26',NULL,'2018-02-19 21:06:26','2018-02-19 21:06:40','c94211a9-2c8e-451d-aa43-affd63ee8d59');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafts`;

CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Content Page','contentPage',1,'Title',NULL,1,'2018-02-19 20:39:21','2018-02-19 21:04:11','61f1fb8a-a31e-424a-a094-0bb848c53bf9'),
	(2,2,7,'404','notFound',1,'Title',NULL,1,'2018-02-19 21:05:21','2018-02-19 21:06:00','e21494a3-47f6-4ec6-b09b-0e7438ec3900'),
	(3,3,8,'503','serviceUnavailable',1,'Title',NULL,1,'2018-02-19 21:06:26','2018-02-19 21:06:40','e15b0eea-1d26-4fd9-ac19-e5e047b53f84'),
	(9,1,14,'Overview Page','overviewPage',1,'Title',NULL,2,'2018-03-17 15:32:13','2018-03-17 15:35:35','ab702c4a-4782-4e2d-9751-4a9db6388581');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversions`;

CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;

INSERT INTO `entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Home\",\"slug\":\"__home__\",\"postDate\":1519072777,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2018-02-19 20:39:37','2018-02-19 20:39:37','3e7399ed-f292-43d8-9765-327f9dc90d2e'),
	(2,2,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Home\",\"slug\":\"__home__\",\"postDate\":1519072740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"2\":{\"10\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Himenaeos bibendum ad quis malesuada sem sagittis non at, lobortis id sed elementum erat aenean dictum, integer iaculis curabitur vivamus consectetur proin facilisis. A at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent, semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus, potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non. Fusce maecenas tortor justo eu erat nam adipiscing leo quam, ultricies sociosqu orci felis platea et at aenean lorem, inceptos velit nostra torquent phasellus vulputate sem tincidunt. Elit ante tortor justo eros quam, facilisis blandit ac phasellus erat nibh, orci curae est rhoncus. Et a potenti nam sociis natoque tortor taciti netus, cursus quis nostra fusce molestie ullamcorper aptent, odio torquent mollis etiam aliquet massa suscipit.</p>\",\"position\":\"left\",\"width\":\"1/2\"}},\"11\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Himenaeos bibendum ad quis malesuada sem sagittis non at, lobortis id sed elementum erat aenean dictum, integer iaculis curabitur vivamus consectetur proin facilisis. A at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent, semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus, potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non. Fusce maecenas tortor justo eu erat nam adipiscing leo quam, ultricies sociosqu orci felis platea et at aenean lorem, inceptos velit nostra torquent phasellus vulputate sem tincidunt. Elit ante tortor justo eros quam, facilisis blandit ac phasellus erat nibh, orci curae est rhoncus. Et a potenti nam sociis natoque tortor taciti netus, cursus quis nostra fusce molestie ullamcorper aptent, odio torquent mollis etiam aliquet massa suscipit.</p>\",\"position\":\"right\",\"width\":\"1/2\"}},\"12\":{\"type\":\"image\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"asset\":[\"6\"],\"caption\":\"\",\"lightbox\":false,\"position\":\"left\",\"width\":\"1/3\"}},\"13\":{\"type\":\"image\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"asset\":[\"6\"],\"caption\":\"With lightbox & caption\",\"lightbox\":true,\"position\":\"right\",\"width\":\"2/3\"}},\"14\":{\"type\":\"image\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"asset\":[\"6\"],\"caption\":\"Full\",\"lightbox\":false,\"position\":\"full\",\"width\":\"full\"}},\"15\":{\"type\":\"quote\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"quote\":\"An awesome quote\",\"author\":\"me\",\"position\":\"center\",\"width\":\"full\"}},\"16\":{\"type\":\"gallery\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"assets\":[\"6\",\"7\",\"8\",\"9\"]}}},\"16\":\"<p>Volutpat dignissim primis metus ultrices auctor molestie iaculis elit felis imperdiet tortor, semper tempor enim maecenas varius mattis augue phasellus at curabitur, platea nec donec class laoreet ultricies odio nisi inceptos scelerisque.</p>\",\"17\":[\"6\"]}}','2018-02-19 21:21:57','2018-02-19 21:21:57','1e197b15-2eff-4c7f-8e54-30219152c893'),
	(4,2,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Home\",\"slug\":\"__home__\",\"postDate\":1519072740,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"2\":{\"10\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Himenaeos bibendum ad quis malesuada sem sagittis non at, lobortis id sed elementum erat aenean dictum, integer iaculis curabitur vivamus consectetur proin facilisis. A at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent, semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus, potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non. Fusce maecenas tortor justo eu erat nam adipiscing leo quam, ultricies sociosqu orci felis platea et at aenean lorem, inceptos velit nostra torquent phasellus vulputate sem tincidunt. Elit ante tortor justo eros quam, facilisis blandit ac phasellus erat nibh, orci curae est rhoncus. Et a potenti nam sociis natoque tortor taciti netus, cursus quis nostra fusce molestie ullamcorper aptent, odio torquent mollis etiam aliquet massa suscipit.</p>\",\"width\":\"1/2\",\"positionType\":\"column\"}},\"11\":{\"type\":\"text\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Himenaeos bibendum ad quis malesuada sem sagittis non at, lobortis id sed elementum erat aenean dictum, integer iaculis curabitur vivamus consectetur proin facilisis. A at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent, semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus, potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non. Fusce maecenas tortor justo eu erat nam adipiscing leo quam, ultricies sociosqu orci felis platea et at aenean lorem, inceptos velit nostra torquent phasellus vulputate sem tincidunt. Elit ante tortor justo eros quam, facilisis blandit ac phasellus erat nibh, orci curae est rhoncus. Et a potenti nam sociis natoque tortor taciti netus, cursus quis nostra fusce molestie ullamcorper aptent, odio torquent mollis etiam aliquet massa suscipit.</p>\",\"width\":\"1/2\",\"positionType\":\"column\"}}},\"16\":\"<p>Volutpat dignissim primis metus ultrices auctor molestie iaculis elit felis imperdiet tortor, semper tempor enim maecenas varius mattis augue phasellus at curabitur, platea nec donec class laoreet ultricies odio nisi inceptos scelerisque.</p>\",\"17\":[\"19\"]}}','2018-08-14 09:03:48','2018-08-14 09:03:48','dbc700d5-2929-4e5a-87ab-892d3bbdda42');

/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,'Page','2018-02-19 20:40:09','2018-02-19 20:40:09','a5394e36-c5da-4690-813f-bbb839bdbb0e'),
	(3,'Common','2018-02-19 20:48:19','2018-02-19 20:48:19','2339f388-7cbe-4547-ba61-c4a0bfcd16dc'),
	(4,'Teaser','2018-02-19 20:57:04','2018-02-19 20:57:04','3e8e6e1e-d8a8-4001-9310-ddd73a81cb80');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(22,1,10,2,0,1,'2018-02-19 21:04:11','2018-02-19 21:04:11','1bf4f107-7e52-45ef-a8a5-b06139cfff43'),
	(23,1,11,17,1,1,'2018-02-19 21:04:11','2018-02-19 21:04:11','38379a0a-1f11-4905-98dc-3ce12e29310f'),
	(24,1,11,16,1,2,'2018-02-19 21:04:11','2018-02-19 21:04:11','e7415c67-e178-49cd-a7dd-353f4cd09734'),
	(25,7,12,2,0,1,'2018-02-19 21:06:00','2018-02-19 21:06:00','9a8bcb75-240c-406b-8bb6-a423473ec807'),
	(26,8,13,2,0,1,'2018-02-19 21:06:40','2018-02-19 21:06:40','342e865b-de0b-434a-a151-2cfc077b8d10'),
	(37,14,20,23,1,1,'2018-03-17 15:35:35','2018-03-17 15:35:35','9fdc32f3-90f0-4eb1-8873-9a33f8701316'),
	(38,14,20,2,0,2,'2018-03-17 15:35:35','2018-03-17 15:35:35','2c428cb9-6f40-49df-8cf4-f5203fc6bdef'),
	(39,14,21,16,1,1,'2018-03-17 15:35:35','2018-03-17 15:35:35','6be9da89-92c0-4612-85b2-2c11e114c4d4'),
	(40,14,21,17,1,2,'2018-03-17 15:35:35','2018-03-17 15:35:35','61a57b73-99fe-41c4-a667-a8e0152b7692'),
	(44,3,24,3,1,1,'2018-08-14 09:03:03','2018-08-14 09:03:03','b6550647-aad9-46d1-a641-d5952a6a09d5'),
	(45,3,24,5,1,2,'2018-08-14 09:03:03','2018-08-14 09:03:03','92336873-e48d-453f-baf4-b06d6168b361'),
	(46,3,24,24,1,3,'2018-08-14 09:03:03','2018-08-14 09:03:03','5daf0cce-2a0c-4247-8918-6236501a2323'),
	(47,4,25,6,1,1,'2018-08-14 09:03:03','2018-08-14 09:03:03','0a6cc6a5-8c0b-40fe-9d0a-c2edb72d1843'),
	(48,4,25,7,0,2,'2018-08-14 09:03:03','2018-08-14 09:03:03','76eb19a6-636f-45dd-8571-9b31307f9433'),
	(49,4,25,9,1,3,'2018-08-14 09:03:03','2018-08-14 09:03:03','8923b033-d8dc-4af6-84b7-6ced27911ff4'),
	(50,4,25,10,1,4,'2018-08-14 09:03:03','2018-08-14 09:03:03','72d48958-d26c-4377-b2dd-0c1f9be872d1');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2018-02-19 20:39:21','2018-02-19 21:04:11','287b486d-5e0f-4da3-ad71-b0e6e4f5bb6e'),
	(2,'craft\\elements\\Asset','2018-02-19 20:47:40','2018-02-19 20:49:20','d5ea0bab-9c7b-456b-8561-204055d0f005'),
	(3,'craft\\elements\\MatrixBlock','2018-02-19 20:49:31','2018-08-14 09:03:03','b4e95136-129b-44b0-806f-4179e32cca7d'),
	(4,'craft\\elements\\MatrixBlock','2018-02-19 20:49:31','2018-08-14 09:03:03','11f56c1a-4166-4b03-915e-bae305a5d987'),
	(7,'craft\\elements\\Entry','2018-02-19 21:05:21','2018-02-19 21:06:00','e1017557-2915-4a3b-b582-a890f41e20da'),
	(8,'craft\\elements\\Entry','2018-02-19 21:06:26','2018-02-19 21:06:40','9bae5357-2666-46d6-8b1f-c6b0c89683ea'),
	(14,'craft\\elements\\Entry','2018-03-17 15:32:13','2018-03-17 15:35:35','b207d8c2-eece-4a03-b20e-10f35187b37b');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Inhoud',1,'2018-02-19 20:49:20','2018-02-19 20:49:20','4a8998d4-3a95-426e-b24a-6d0c565ea4f3'),
	(10,1,'Content',1,'2018-02-19 21:04:11','2018-02-19 21:04:11','a914be87-50a7-4a7a-8f29-ddd28ea66169'),
	(11,1,'Teaser',2,'2018-02-19 21:04:11','2018-02-19 21:04:11','b5b5ea41-2a97-4006-8d1b-b14e7028682d'),
	(12,7,'Content',1,'2018-02-19 21:06:00','2018-02-19 21:06:00','37d45c75-d464-4b31-9dee-dddc8ece4481'),
	(13,8,'Content',1,'2018-02-19 21:06:40','2018-02-19 21:06:40','5a6dacb4-433a-4208-ba7b-ff9305ed3f0f'),
	(20,14,'Content',1,'2018-03-17 15:35:35','2018-03-17 15:35:35','e4a596ea-372e-405f-a2d4-2e6072d83c1a'),
	(21,14,'Teaser',2,'2018-03-17 15:35:35','2018-03-17 15:35:35','78d48619-5b5d-4f72-883b-6196cf8557f8'),
	(24,3,'Content',1,'2018-08-14 09:03:03','2018-08-14 09:03:03','d8757f7a-a24d-4b09-b933-ac0c419accaf'),
	(25,4,'Content',1,'2018-08-14 09:03:03','2018-08-14 09:03:03','cbab3bda-8808-465e-9e56-0b2fec4d2c9c');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,2,'Builder','builder','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false,\"contentTable\":\"{{%matrixcontent_builder}}\"}','2018-02-19 20:49:31','2018-08-14 09:03:02','b494bf2c-eafd-4194-99a9-559a9549d81e'),
	(3,NULL,'Body','body','matrixBlockType:1','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2018-02-19 20:49:31','2018-08-14 09:03:03','0edea4a0-2b09-4a26-a09e-7487817ecc20'),
	(5,NULL,'Width','width','matrixBlockType:1','','none',NULL,'rias\\widthfieldtype\\fields\\Width','{\"options\":{\"1/6\":\"1\",\"1/5\":\"1\",\"1/4\":\"1\",\"1/3\":\"1\",\"2/5\":\"1\",\"1/2\":\"1\",\"3/5\":\"1\",\"2/3\":\"1\",\"3/4\":\"1\",\"4/5\":\"1\",\"5/6\":\"1\",\"full\":\"1\"},\"default\":\"full\"}','2018-02-19 20:49:31','2018-08-14 09:03:03','89e35dd6-b38e-45e6-8eaa-6c06f01563ca'),
	(6,NULL,'Asset','asset','matrixBlockType:2','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:3\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:3\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:3\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-02-19 20:49:31','2018-08-14 09:03:03','04e62582-3faa-426a-8f14-1b623ee9c767'),
	(7,NULL,'Caption','caption','matrixBlockType:2','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-02-19 20:55:37','2018-08-14 09:03:03','2e68dbcd-def6-4d07-afb6-ed54ed934083'),
	(9,NULL,'Type blok','positionType','matrixBlockType:2','Is dit blok een kolom, een alleenstaand blok of een blok dat buiten de container valt.','none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Kolom\",\"value\":\"column\",\"default\":\"1\"},{\"label\":\"Aleenstaand\",\"value\":\"single\",\"default\":\"\"},{\"label\":\"Buiten container\",\"value\":\"container\",\"default\":\"\"}]}','2018-02-19 20:55:37','2018-08-14 09:03:03','e3f47e81-e327-4ce4-a456-5943ba3df7a6'),
	(10,NULL,'Width','width','matrixBlockType:2','','none',NULL,'rias\\widthfieldtype\\fields\\Width','{\"options\":{\"1/6\":\"1\",\"1/5\":\"1\",\"1/4\":\"1\",\"1/3\":\"1\",\"2/5\":\"1\",\"1/2\":\"1\",\"3/5\":\"1\",\"2/3\":\"1\",\"3/4\":\"1\",\"4/5\":\"1\",\"5/6\":\"1\",\"full\":\"1\"},\"default\":\"full\"}','2018-02-19 20:55:37','2018-08-14 09:03:03','46d41182-8de5-4fe6-b1f8-ac9b37040f31'),
	(16,4,'Description','teaserDescription','global','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Simple.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-02-19 20:57:32','2018-02-19 20:57:32','98cb59e0-b890-4c98-a5cc-a740202371ac'),
	(17,4,'Image','teaserImage','global','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:3\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:3\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:3\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-02-19 20:57:52','2018-02-19 20:57:52','012cc720-8595-4594-828d-06e3e4b4d6da'),
	(23,2,'Section','sectionIndex','global','','none',NULL,'charliedev\\sectionfield\\fields\\SectionField','{\"allowMultiple\":\"\",\"whitelistedSections\":[\"6\"]}','2018-03-17 15:32:41','2018-03-17 15:37:25','d798cc01-22d7-4b3d-86d0-b11914a2e18b'),
	(24,NULL,'Type blok','positionType','matrixBlockType:1','Is dit blok een kolom, een alleenstaand blok of een blok dat buiten de container valt.','none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Kolom\",\"value\":\"column\",\"default\":\"1\"},{\"label\":\"Aleenstaand\",\"value\":\"single\",\"default\":\"\"},{\"label\":\"Buiten container\",\"value\":\"container\",\"default\":\"\"}]}','2018-08-14 09:03:03','2018-08-14 09:03:03','3423b3bd-9504-4533-b534-a0d8b1a67c66');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `edition`, `timezone`, `name`, `on`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.0.25','3.0.93',0,'Europe/Brussels','craft',1,0,'0JwAux6p1TeA','2018-02-19 20:35:16','2018-09-20 14:55:34','15a1bfa3-0de9-405e-9aca-6190f554c2fb');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;

INSERT INTO `matrixblocks` (`id`, `ownerId`, `ownerSiteId`, `fieldId`, `typeId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(10,2,NULL,2,1,1,'2018-02-19 21:21:57','2018-08-14 09:03:48','6d9974cf-948a-4472-ae13-2e3a6534110c'),
	(11,2,NULL,2,1,2,'2018-02-19 21:21:57','2018-08-14 09:03:48','b85702f7-2263-4a34-9020-5fc43e3ffbad');

/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;

INSERT INTO `matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,3,'Text','text',1,'2018-02-19 20:49:31','2018-08-14 09:03:03','8a344f4b-be5d-44bf-9318-3fe86affe1e6'),
	(2,2,4,'Image','image',2,'2018-02-19 20:49:31','2018-08-14 09:03:03','bfcf13f7-9c84-4a4c-b1b7-8a6b79bdbc41');

/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixcontent_builder
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixcontent_builder`;

CREATE TABLE `matrixcontent_builder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_text_body` text,
  `field_text_width` varchar(255) DEFAULT NULL,
  `field_image_caption` text,
  `field_image_positionType` varchar(255) DEFAULT NULL,
  `field_image_width` varchar(255) DEFAULT NULL,
  `field_text_positionType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_builder_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_builder_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_builder_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_builder_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixcontent_builder` WRITE;
/*!40000 ALTER TABLE `matrixcontent_builder` DISABLE KEYS */;

INSERT INTO `matrixcontent_builder` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_text_body`, `field_text_width`, `field_image_caption`, `field_image_positionType`, `field_image_width`, `field_text_positionType`)
VALUES
	(1,10,1,'2018-02-19 21:21:57','2018-08-14 09:03:48','e09a9154-93fc-4467-8e58-c10fd838c55a','<p>Himenaeos bibendum ad quis malesuada sem sagittis non at, lobortis id sed elementum erat aenean dictum, integer iaculis curabitur vivamus consectetur proin facilisis. A at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent, semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus, potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non. Fusce maecenas tortor justo eu erat nam adipiscing leo quam, ultricies sociosqu orci felis platea et at aenean lorem, inceptos velit nostra torquent phasellus vulputate sem tincidunt. Elit ante tortor justo eros quam, facilisis blandit ac phasellus erat nibh, orci curae est rhoncus. Et a potenti nam sociis natoque tortor taciti netus, cursus quis nostra fusce molestie ullamcorper aptent, odio torquent mollis etiam aliquet massa suscipit.</p>','1/2',NULL,NULL,NULL,'column'),
	(2,11,1,'2018-02-19 21:21:57','2018-08-14 09:03:48','c3837d68-394b-4301-8b11-d947708c8328','<p>Himenaeos bibendum ad quis malesuada sem sagittis non at, lobortis id sed elementum erat aenean dictum, integer iaculis curabitur vivamus consectetur proin facilisis. A at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent, semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus, potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non. Fusce maecenas tortor justo eu erat nam adipiscing leo quam, ultricies sociosqu orci felis platea et at aenean lorem, inceptos velit nostra torquent phasellus vulputate sem tincidunt. Elit ante tortor justo eros quam, facilisis blandit ac phasellus erat nibh, orci curae est rhoncus. Et a potenti nam sociis natoque tortor taciti netus, cursus quis nostra fusce molestie ullamcorper aptent, odio torquent mollis etiam aliquet massa suscipit.</p>','1/2',NULL,NULL,NULL,'column');

/*!40000 ALTER TABLE `matrixcontent_builder` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','7e639f3f-aa8d-4817-9b81-00583f441fa4'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','fcc9de96-5dd2-4b0d-ae6e-3b151789e484'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','0928f756-349a-4544-9982-25b695ee498a'),
	(4,NULL,'app','m150403_184533_field_version','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','5be2f743-c838-4704-8d92-8a098fe5070d'),
	(5,NULL,'app','m150403_184729_type_columns','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','00436b2f-c29f-4849-b022-80b345fdd0d1'),
	(6,NULL,'app','m150403_185142_volumes','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','7fc0faea-f613-4f19-b900-f1e322505dc6'),
	(7,NULL,'app','m150428_231346_userpreferences','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','08003ae8-348e-4e58-a5ae-f345a876d6b5'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','1001b25e-7f8e-48e8-bf60-3b089d91c26e'),
	(9,NULL,'app','m150617_213829_update_email_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','0ea38110-4e45-4ad1-831c-b9bb3cc11769'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','e144873f-0c49-46cb-bb3a-c3cdf75fd60f'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','53031068-0c1d-44b6-901e-28c575e32565'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','3a24360e-4bc2-4693-8170-56a89a2b61cb'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','cf1d28f2-2c0f-42c3-a24d-95dfac6e72b0'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','194844b6-9c5d-4b79-9006-0e7335ec98c9'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','9a89a706-98b2-43f1-9c82-50ba4b51c24b'),
	(16,NULL,'app','m151209_000000_move_logo','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','3261f1a9-6cc5-4ad7-990b-f15c46cbcc12'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','4045b646-8107-445f-aae7-2545537ff17c'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','217968ea-58ab-4e0c-bed4-a6f044f409c5'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','f65f71c1-8e14-4f1e-894d-797b1b7330f3'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','a84df436-8d0e-4466-80ff-c4d860b496c8'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','ea18da34-b51b-4ff0-879d-d334c83fb63d'),
	(22,NULL,'app','m160727_194637_column_cleanup','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','317b8fc7-8a1f-431b-9c49-47e153cbc17b'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','5f3b2c67-b54f-42fd-a614-cca838dee1e9'),
	(24,NULL,'app','m160807_144858_sites','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','7d0ee66a-801f-4d19-91bf-dc7789c27963'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','455d16f4-210d-47e5-95b2-1a359b36291a'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','7b4bf193-8670-4300-a601-d146a380d0dd'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','c2f7991f-193c-4ce0-a8a8-344a51ec1072'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','6a9d19bd-ec45-4e0c-94e8-4f9c276199f7'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','dfe0fcb3-f51f-4675-bffd-814fe487481e'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','1bdc0ee8-5a4c-4794-a52e-7e6235901503'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','7ca015e9-00f3-45a5-94ef-6f6cc7ba3277'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','ba85a830-83f0-481a-abd9-b60d9aa0ee53'),
	(33,NULL,'app','m161007_130653_update_email_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','c15b5f73-1ef2-434b-8c76-ffcd1ff2b060'),
	(34,NULL,'app','m161013_175052_newParentId','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','67266109-31c4-4113-9aa5-d4b15fed8f7b'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','bfcba74f-2113-43c7-be63-1132ac69161b'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','abe1aea5-039f-434e-89c1-2581ac823a1a'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','27cea8ca-e331-47f6-9399-a92eacc752af'),
	(38,NULL,'app','m161029_124145_email_message_languages','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','3cfbde62-b7e0-4a2e-afd5-a79bbb8e0023'),
	(39,NULL,'app','m161108_000000_new_version_format','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','d021a406-e8e2-40af-9a05-e2cc96fc84ce'),
	(40,NULL,'app','m161109_000000_index_shuffle','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','66d38693-1d43-4400-94b2-0db3efc61416'),
	(41,NULL,'app','m161122_185500_no_craft_app','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','558f87bf-eb58-4229-9897-a45de58c962d'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','7da2d407-98dd-4787-b3c9-6413f0da52bd'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','0515afdc-993f-4108-b1c5-23174ad436e6'),
	(44,NULL,'app','m170114_161144_udates_permission','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','42edf190-50a3-4ad7-9535-8d5d7e37eadf'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','c5f7c7c5-ed55-4ca8-b874-e747710763df'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','a11ce612-299b-4b41-88d8-30424636438b'),
	(47,NULL,'app','m170206_142126_system_name','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','401e1209-589a-44f5-a9d2-4641baf7ac27'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','e2247aca-eea7-474d-be95-2434bbf59d49'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','2508e14a-3a22-4fe9-8979-6c959521b79c'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','49265557-2ca5-42ae-8e38-321459d41ff4'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','cc00b372-8d34-4b4b-8287-520c97caca8d'),
	(52,NULL,'app','m170228_171113_system_messages','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','db8d1017-b635-43ff-92b7-e760241e007e'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','4111ed9b-af5f-4d4f-a899-76c59de138f3'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','d8437416-26df-4bef-88f2-cfc27843965d'),
	(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','8b2360d1-6cef-4c8e-89fb-52be0583187b'),
	(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','c9741cfa-7bf2-43b8-8f4f-40c87ec853bd'),
	(57,NULL,'app','m170612_000000_route_index_shuffle','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','2c8afd35-53e3-4812-9323-1f229c54050d'),
	(58,NULL,'app','m170621_195237_format_plugin_handles','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','3029e041-5574-42fa-a785-f74adffe688d'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','5adb9392-8539-48f9-91b7-1c9d24ae776a'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','0da12687-80bc-4b5f-bac7-38f9760699ad'),
	(61,NULL,'app','m170704_134916_sites_tables','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','b1926b87-202f-4ec7-8d0d-36d8370664d2'),
	(62,NULL,'app','m170706_183216_rename_sequences','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','b71d2a14-4815-49ba-9d21-7f980b12db7e'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','ff6336be-0a60-4e9c-832b-9f9750733f03'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','b1e093b1-cad9-47f8-8b4a-41922c709894'),
	(65,NULL,'app','m170810_201318_create_queue_table','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','6459870b-2146-419b-8f12-e65e2ac2a612'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','831ebd71-d578-457f-b28b-4689d7ad89d1'),
	(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','dd5955a6-7fdc-4e12-beb1-f2ae4b32ee6e'),
	(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','f35ff3b8-67d7-4b84-90fd-6fdc1611f814'),
	(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','3b130a3b-afbc-44b9-8ab9-5a4cb2663c55'),
	(70,NULL,'app','m171011_214115_site_groups','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','25bb0a74-68c0-4298-b5e0-2ed25996abe7'),
	(71,NULL,'app','m171012_151440_primary_site','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','6b4bc867-99e3-4d7c-8267-c34c7c1c371e'),
	(72,NULL,'app','m171013_142500_transform_interlace','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','f458912f-51e0-4d3e-9bbe-4cc66665852d'),
	(73,NULL,'app','m171016_092553_drop_position_select','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','89a39621-e149-4670-a8be-ca6eeb95f0d3'),
	(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','b2013d66-8c30-4a39-aebd-91f46bdfebf7'),
	(75,NULL,'app','m171107_000000_assign_group_permissions','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','df82357f-e1e8-4e04-8269-a617c0bdeb9d'),
	(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','c966a357-a70c-41e1-b261-f643e006686a'),
	(77,NULL,'app','m171126_105927_disabled_plugins','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','e3a25f9b-a620-465b-a844-7e2a8a1106c0'),
	(78,NULL,'app','m171130_214407_craftidtokens_table','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','f4bbb802-a9ba-47b8-a3b0-9fc9a195274f'),
	(79,NULL,'app','m171202_004225_update_email_settings','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','c26cd28e-a66d-4588-ba48-5c65973b5822'),
	(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','ab7fb9bf-2983-48c1-ae72-81b54ee45454'),
	(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','8c2506a4-4317-4bf1-a76a-4fe33f55c75a'),
	(82,NULL,'app','m171210_142046_fix_db_routes','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','c3950089-2b46-4107-a7ee-2f144cb75c14'),
	(83,NULL,'app','m171218_143135_longtext_query_column','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','23c88452-15de-405e-bb6f-a24582800ae8'),
	(84,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','02df5969-2892-426c-abf7-fc4f0ac3a046'),
	(85,NULL,'app','m180113_153740_drop_users_archived_column','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','00b5d459-5d43-42db-840f-28b39202941b'),
	(86,NULL,'app','m180122_213433_propagate_entries_setting','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','dabf1af0-2445-4563-a12f-62b204edeb9b'),
	(87,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','04673290-8425-4a9c-9a2e-2fa3e49cb119'),
	(88,NULL,'app','m180128_235202_set_tag_slugs','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','2a519969-3b26-491c-b011-41ff2b4d0d5c'),
	(89,NULL,'app','m180202_185551_fix_focal_points','2018-02-19 20:35:16','2018-02-19 20:35:16','2018-02-19 20:35:16','73ba617a-a1e7-484f-b0a4-b5ab6fc648b1'),
	(90,12,'plugin','Install','2018-02-19 20:37:36','2018-02-19 20:37:36','2018-02-19 20:37:36','e1bd0e85-3ed1-4026-941b-389b1e43686d'),
	(91,NULL,'app','m180217_172123_tiny_ints','2018-02-24 22:12:23','2018-02-24 22:12:23','2018-02-24 22:12:23','3f0fe266-72fa-4da5-b1b6-f40b243b9415'),
	(92,16,'plugin','Install','2018-03-17 15:29:27','2018-03-17 15:29:27','2018-03-17 15:29:27','09d93985-619f-45e4-a68c-f0ddf6f2a87b'),
	(93,16,'plugin','m180314_002756_base_install','2018-03-17 15:29:27','2018-03-17 15:29:27','2018-03-17 15:29:27','58e51d16-51eb-47ff-b132-ab60e550bd60'),
	(94,NULL,'app','m180321_233505_small_ints','2018-04-23 07:31:29','2018-04-23 07:31:29','2018-04-23 07:31:29','b69b54ba-45fe-487b-8e46-ea434ea266bd'),
	(95,NULL,'app','m180328_115523_new_license_key_statuses','2018-04-23 07:31:29','2018-04-23 07:31:29','2018-04-23 07:31:29','dde4609f-a199-4276-a401-ef4ee40da2ab'),
	(96,NULL,'app','m180404_182320_edition_changes','2018-04-23 07:31:29','2018-04-23 07:31:29','2018-04-23 07:31:29','3c0b481f-c767-4c02-825a-f21c56c571aa'),
	(97,NULL,'app','m180411_102218_fix_db_routes','2018-04-23 07:31:29','2018-04-23 07:31:29','2018-04-23 07:31:29','757f44b8-5035-49b8-94f5-eff5369ee70b'),
	(98,NULL,'app','m180416_205628_resourcepaths_table','2018-04-23 07:31:29','2018-04-23 07:31:29','2018-04-23 07:31:29','fc68133e-a0d1-43a8-876c-233216842820'),
	(99,16,'plugin','m180403_002756_field_type','2018-04-23 07:31:29','2018-04-23 07:31:29','2018-04-23 07:31:29','62703fee-98c3-4ad8-92a9-10e2279a8163'),
	(100,18,'plugin','Install','2018-04-23 07:34:02','2018-04-23 07:34:02','2018-04-23 07:34:02','140b1085-432a-4bfd-a6fe-f280202e2c83'),
	(101,18,'plugin','m180210_000000_migrate_content_tables','2018-04-23 07:34:02','2018-04-23 07:34:02','2018-04-23 07:34:02','51857bdc-bbf8-4701-aeff-dcb69480063f'),
	(102,18,'plugin','m180211_000000_type_columns','2018-04-23 07:34:02','2018-04-23 07:34:02','2018-04-23 07:34:02','fa08963a-9092-48bc-9a95-88359ce8b396'),
	(103,18,'plugin','m180219_000000_sites','2018-04-23 07:34:02','2018-04-23 07:34:02','2018-04-23 07:34:02','0816e0a0-cffa-47db-84c3-bfad79285705'),
	(104,18,'plugin','m180220_000000_fix_context','2018-04-23 07:34:02','2018-04-23 07:34:02','2018-04-23 07:34:02','6439bef4-01a8-4610-8213-f7345fb69675'),
	(105,NULL,'app','m180418_205713_widget_cleanup','2018-05-11 07:49:48','2018-05-11 07:49:48','2018-05-11 07:49:48','5f970f86-9945-44e6-b6b9-973139013a5d'),
	(106,12,'plugin','m180430_204710_remove_old_plugins','2018-05-11 07:49:48','2018-05-11 07:49:48','2018-05-11 07:49:48','7e181ad9-ca6e-4ff1-b99d-b1b303bd19c5'),
	(107,16,'plugin','m180502_202319_remove_field_metabundles','2018-05-11 07:49:48','2018-05-11 07:49:48','2018-05-11 07:49:48','b62b61fb-2d26-4088-ae66-995c07a5e52c'),
	(108,21,'plugin','Install','2018-05-11 07:51:34','2018-05-11 07:51:34','2018-05-11 07:51:34','385b4f36-b0ef-4038-be87-3a46c72ea17b'),
	(109,16,'plugin','m180711_024947_commerce_products','2018-08-14 08:33:35','2018-08-14 08:33:35','2018-08-14 08:33:35','397cf89e-f188-40a8-ba69-cb89c7448567'),
	(110,NULL,'content','m180814_083930_initial_setup','2018-08-14 08:45:10','2018-08-14 08:45:10','2018-08-14 08:45:10','9dc0e022-fc78-4b50-aa80-84d7eddcfc78'),
	(111,NULL,'content','m180814_014735_migration_initial_setup','2018-08-14 08:47:35','2018-08-14 08:47:35','2018-08-14 08:47:35','aab495da-6ee6-4ba7-94fd-83d38862eb70'),
	(112,26,'plugin','Install','2018-08-14 08:49:26','2018-08-14 08:49:26','2018-08-14 08:49:26','70eb5c50-e8b0-4a27-b72a-718f10417d38'),
	(113,27,'plugin','Install','2018-08-14 09:14:22','2018-08-14 09:14:22','2018-08-14 09:14:22','0d0e3718-860d-43c7-aaca-fb82941a8946'),
	(114,27,'plugin','m180628_120000_add_elementcaches_table','2018-08-14 09:14:22','2018-08-14 09:14:22','2018-08-14 09:14:22','60d6152a-ebcf-4271-a458-d97d69003549'),
	(115,27,'plugin','m180703_120000_add_siteid_column','2018-08-14 09:14:22','2018-08-14 09:14:22','2018-08-14 09:14:22','6d57c31d-4812-469f-bd7d-d272ee520c56'),
	(116,27,'plugin','m180704_120000_add_caches_elementquerycaches_tables','2018-08-14 09:14:22','2018-08-14 09:14:22','2018-08-14 09:14:22','1e9f725a-4ef3-4139-9288-f6982ce4117a'),
	(117,NULL,'app','m180824_193422_case_sensitivity_fixes','2018-09-17 12:39:26','2018-09-17 12:39:26','2018-09-17 12:39:26','1352b46d-0243-411e-8fe6-3dd01c3bbedd'),
	(118,NULL,'app','m180901_151639_fix_matrixcontent_tables','2018-09-17 12:39:26','2018-09-17 12:39:26','2018-09-17 12:39:26','f064f26f-f7f6-4006-ba8c-1703f4c93946'),
	(119,26,'plugin','m180826_000000_propagate_nav_setting','2018-09-17 12:39:26','2018-09-17 12:39:26','2018-09-17 12:39:26','666fdb93-a799-4827-9a2d-bff7ccaccc33'),
	(120,26,'plugin','m180827_000000_propagate_nav_setting_additional','2018-09-17 12:39:26','2018-09-17 12:39:26','2018-09-17 12:39:26','9deaa342-d134-4612-87a3-521d20291f19'),
	(121,16,'plugin','m180314_002755_field_type','2018-09-17 12:39:26','2018-09-17 12:39:26','2018-09-17 12:39:26','a5c76b4d-c7d2-4430-a3d6-f7e7e081ba30');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table navigation_navs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navigation_navs`;

CREATE TABLE `navigation_navs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `propagateNodes` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `navigation_navs_handle_unq_idx` (`handle`),
  KEY `navigation_navs_structureId_idx` (`structureId`),
  CONSTRAINT `navigation_navs_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `navigation_navs` WRITE;
/*!40000 ALTER TABLE `navigation_navs` DISABLE KEYS */;

INSERT INTO `navigation_navs` (`id`, `structureId`, `name`, `handle`, `sortOrder`, `propagateNodes`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,3,'Main','navMain',NULL,0,'2018-08-14 08:51:16','2018-08-14 08:51:16','478fc6c6-f33e-4d7d-8de2-970ac4cebedd');

/*!40000 ALTER TABLE `navigation_navs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table navigation_nodes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navigation_nodes`;

CREATE TABLE `navigation_nodes` (
  `id` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `navId` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `classes` varchar(255) DEFAULT NULL,
  `newWindow` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `navigation_nodes_navId_idx` (`navId`),
  KEY `navigation_nodes_elementId_fk` (`elementId`),
  CONSTRAINT `navigation_nodes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `navigation_nodes_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `navigation_nodes_navId_fk` FOREIGN KEY (`navId`) REFERENCES `navigation_navs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKey`, `licenseKeyStatus`, `enabled`, `settings`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'architect','2.2.0','2.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:24','2018-02-19 20:37:24','2018-02-19 20:56:20','cc986a1c-784e-4266-bfbf-0404c36c9eff'),
	(4,'minify','1.2.9','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:35','2018-02-19 20:37:35','2018-09-20 14:55:37','5316ced6-9a20-4ebb-b5c2-f4bfb0041f26'),
	(5,'typogrify','1.1.11','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:35','2018-02-19 20:37:35','2018-09-20 14:55:37','55bdd6c3-ea0b-4ed1-b667-0ad91ea590e6'),
	(6,'mix','1.5.2','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:35','2018-02-19 20:37:35','2018-09-20 14:55:37','bc4c8648-1d03-4fcb-9118-877d82bf15e4'),
	(7,'position-fieldtype','1.0.13','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:35','2018-02-19 20:37:35','2018-09-20 14:55:37','2ba89699-c08b-486d-9d1d-01e9d640fa2b'),
	(9,'colour-swatches','1.1.4','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:36','2018-02-19 20:37:36','2018-09-20 14:55:37','ef0a812f-4889-4a78-a653-0dd331467365'),
	(11,'expanded-singles','1.0.4','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:36','2018-02-19 20:37:36','2018-09-20 14:55:37','793b39fd-2f59-4ad1-9c83-f06d900fd117'),
	(12,'redactor','2.1.6','2.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:36','2018-02-19 20:37:36','2018-09-20 14:55:37','7a44b5b9-bab7-4c87-b6e2-18ef7ab7a694'),
	(13,'typedlinkfield','1.0.13','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:37','2018-02-19 20:37:37','2018-09-20 14:55:37','eb26f007-f8d1-4f00-b0ae-8bca0ea0daa2'),
	(14,'contact-form','2.2.2','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:37','2018-02-19 20:37:37','2018-09-20 14:55:37','da563b78-01f1-40e5-9934-c8c1e4685878'),
	(15,'async-queue','1.3.3','1.0.0',NULL,'unknown',1,NULL,'2018-02-19 20:37:37','2018-02-19 20:37:37','2018-09-20 14:55:37','177bf137-4ba9-42d1-b69c-61f9a7988f2c'),
	(16,'seomatic','3.1.21','3.0.6',NULL,'invalid',1,'{\"pluginName\":\"SEO\",\"renderEnabled\":\"1\",\"environment\":\"local\",\"displayPreviewSidebar\":\"1\",\"displayAnalysisSidebar\":\"1\",\"devModeTitlePrefix\":\"[devMode] \",\"separatorChar\":\"|\",\"maxTitleLength\":\"120\",\"maxDescriptionLength\":\"300\"}','2018-03-17 15:29:27','2018-03-17 15:29:27','2018-09-20 14:55:37','d46b237c-55bd-4437-b8de-0c526188c34c'),
	(18,'super-table','2.0.9','2.0.4',NULL,'unknown',1,NULL,'2018-04-23 07:34:02','2018-04-23 07:34:02','2018-09-20 14:55:37','83bbd3c0-94c1-4242-b429-d5e63950c681'),
	(19,'imager','v2.1.0','2.0.0',NULL,'unknown',1,NULL,'2018-04-23 07:36:24','2018-04-23 07:36:24','2018-09-20 14:55:37','1fd6043a-2f9b-4d68-99ac-4569135a9a08'),
	(20,'password-policy','1.0.3','1.0.0',NULL,'unknown',1,NULL,'2018-04-23 07:38:05','2018-04-23 07:38:05','2018-09-20 14:55:37','928fecbc-e098-47aa-866b-5f1baa763d76'),
	(21,'contact-form-extensions','1.0.10','1.0.0',NULL,'unknown',1,NULL,'2018-05-11 07:51:33','2018-05-11 07:51:33','2018-09-20 14:55:37','0ecac966-06ae-49a9-8b5e-9617ca9250b6'),
	(22,'width-fieldtype','1.0.6','1.0.0',NULL,'unknown',1,NULL,'2018-08-14 08:35:35','2018-08-14 08:35:35','2018-09-20 14:55:37','83e316db-9ed9-4186-8b8f-bcc8fe99a0bf'),
	(23,'section-field','1.1.0','0.0.1',NULL,'unknown',1,NULL,'2018-08-14 08:36:29','2018-08-14 08:36:29','2018-09-20 14:55:37','32229e5d-ae7e-4db3-91ff-7e9e32962ca1'),
	(24,'craftremote','1.0.0','1.0.0',NULL,'unknown',1,NULL,'2018-08-14 08:38:22','2018-08-14 08:38:22','2018-09-20 14:55:37','c371a736-3e81-40da-aa70-a5b0a738dee1'),
	(26,'navigation','1.0.10','1.0.2',NULL,'invalid',1,NULL,'2018-08-14 08:49:26','2018-08-14 08:49:26','2018-09-20 14:55:37','e4fab77a-a899-4d1a-a0f1-160b9026416f'),
	(27,'blitz','1.5.3','1.4.0',NULL,'invalid',1,'{\"cachingEnabled\":\"\",\"queryStringCachingEnabled\":\"\",\"cacheFolderPath\":\"cache/blitz\",\"includedUriPatterns\":[[\".*\"]],\"excludedUriPatterns\":[[\"contact\"],[\"^/blog/?$\"]]}','2018-08-14 09:14:22','2018-08-14 09:14:22','2018-09-20 14:55:37','59b79eb6-8d3b-4596-bff9-8224e6d65af2');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('102baa71','@lib/fabric'),
	('113b0471','@lib/picturefill'),
	('117e77ea','@craft/web/assets/updater/dist'),
	('12b0b571','@craft/web/assets/plugins/dist'),
	('13c7d84a','@lib/jquery.payment'),
	('146c9a00','@craft/web/assets/updater/dist'),
	('15c7c2c8','@lib/datepicker-i18n'),
	('169f38b3','@lib/jquery-touch-events'),
	('16be3095','@typedlinkfield/resources'),
	('18000961','@lib/element-resize-detector'),
	('189f08a9','@app/web/assets/utilities/dist'),
	('1b9781df','@rias/passwordpolicy/assetbundles/PasswordPolicy/dist'),
	('1d2efbd1','@rias/widthfieldtype/assetbundles/widthfieldtype/dist'),
	('1d400322','@runtime/assets/thumbs/6'),
	('1dafdc5f','@craft/web/assets/recententries/dist'),
	('1e6f80df','@bower/jquery/dist'),
	('1f9e2420','@lib/d3'),
	('1fe5e4bd','@craft/web/assets/recententries/dist'),
	('20716f41','@rias/widthfieldtype/assetbundles/widthfieldtype/dist/img'),
	('209d4866','@lib/fileupload'),
	('215fa6d3','@craft/web/assets/updateswidget/dist'),
	('23159e31','@craft/web/assets/updateswidget/dist'),
	('24adfd17','@lib/datepicker-i18n'),
	('25ea732c','@app/web/assets/updates/dist'),
	('26163385','@verbb/supertable/resources/dist'),
	('261f55e9','@lib/velocity'),
	('2722eb9a','@putyourlightson/blitz/resources'),
	('2870f288','@craft/web/assets/generalsettings/dist'),
	('2c2333a6','@lib/garnishjs'),
	('2ddba52','@app/web/assets/plugins/dist'),
	('300173ca','@craft/web/assets/craftsupport/dist'),
	('301077dd','@craft/web/assets/pluginstore/dist'),
	('307e693d','@nystudio107/seomatic/assetbundles/seomatic/dist'),
	('30d6799f','@craft/web/assets/utilities/dist'),
	('316f348e','@app/web/assets/cp/dist'),
	('31ff2b2a','@lib/element-resize-detector'),
	('34fb2b51','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('35029a37','@craft/web/assets/pluginstore/dist'),
	('36cde5bb','@craft/web/assets/craftsupport/dist'),
	('36d069c9','@lib/d3'),
	('37621e81','@lib/xregexp'),
	('3790a294','@bower/jquery/dist'),
	('3807c407','@craft/web/assets/login/dist'),
	('38754998','@lib/picturefill'),
	('3965e798','@lib/fabric'),
	('39f7792b','@lib/timepicker'),
	('3a38fa01','@lib/jquery.payment'),
	('3a3cee17','@lib/jquery-ui'),
	('3c79aa4a','@craft/web/assets/cp/dist'),
	('3d0e5a0b','@lib/selectize'),
	('3ecb5276','@craft/web/assets/login/dist'),
	('3fd1755a','@lib/jquery-touch-events'),
	('3ff0186','@app/web/assets/feed/dist'),
	('40f249ae','@lib/fileupload'),
	('412e9466','@lib/fabric'),
	('4149ec07','@lib/jquery-ui'),
	('4322dba8','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),
	('43a16569','@craft/web/assets/fields/dist'),
	('446b0914','@lib/velocity'),
	('454529f5','@lib/selectize'),
	('47239cf5','@craft/web/assets/updater/dist'),
	('481a6119','@runtime/assets/thumbs/7'),
	('49467de4','@app/web/assets/updater/dist'),
	('494aa162','@craft/web/assets/updates/dist'),
	('49d486b9','@craft/web/assets/deprecationerrors/dist'),
	('4a8a293a','@lib/element-resize-detector'),
	('4ee0daaa','@craft/web/assets/recententries/dist'),
	('4f296d7f','@lib/xregexp'),
	('4f863713','@craft/web/assets/updates/dist'),
	('50251445','@app/icons'),
	('51f22c33','@firstborn/migrationmanager/assetbundles/cp/dist'),
	('531b6873','@app/web/assets/cp/dist'),
	('54684058','@lib/garnishjs'),
	('55029ff1','@rias/passwordpolicy/assetbundles/passwordpolicy/dist'),
	('55e4fe69','@bower/jquery/dist'),
	('56bf6801','@lib/d3'),
	('56d7e4f','@lib/garnishjs'),
	('56f1aa45','@craft/web/assets/editentry/dist'),
	('5781831a','@app/web/assets/craftsupport/dist'),
	('581a4850','@lib/picturefill'),
	('584ca6fc','@lib/jquery.payment'),
	('59132fdb','@app/web/assets/updateswidget/dist'),
	('591e7463','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),
	('5c247a29','@craft/icons'),
	('5ce68ee9','@lib/datepicker-i18n'),
	('5d304337','@lib'),
	('5d387e1b','@lib/prismjs'),
	('5fbe7492','@lib/jquery-touch-events'),
	('603b3400','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('608215e','@lib/xregexp'),
	('61d34788','@craft/web/assets/utilities/dist'),
	('63997f6a','@craft/web/assets/utilities/dist'),
	('65027f87','@lib/garnishjs'),
	('651a82cf','@bower/jquery/dist'),
	('66672096','@lib/xregexp'),
	('668b9280','@craft/web/assets/utilities/dist'),
	('67a96db5','@app/web/assets/recententries/dist'),
	('67d557de','@lib/d3'),
	('68b2da5a','@lib/jquery.payment'),
	('68b6ce4c','@lib/jquery-ui'),
	('6970778f','@lib/picturefill'),
	('6a244155','@craft/web/assets/cp/dist'),
	('6b42ab13','@craft/web/assets/matrix/dist'),
	('6bb3d71c','@craft/web/assets/tablesettings/dist'),
	('6c0b641c','@lib/selectize'),
	('6d506b36','@craft/web/assets/edituser/dist'),
	('6e4b8e85','@vendor/craftcms/redactor/lib/redactor-plugins/video'),
	('6ed44b4d','@lib/jquery-touch-events'),
	('6f6ab42c','@runtime/assets/thumbs/8'),
	('7044abb9','@lib/fabric'),
	('705a98c4','@craft/web/assets/updateswidget/dist'),
	('709bfe34','@craft/web/assets/dashboard/dist'),
	('71987671','@lib/fileupload'),
	('7477214e','@vendor/craftcms/redactor/lib/redactor-plugins/video'),
	('749575b2','@lib/velocity'),
	('75a8c300','@lib/datepicker-i18n'),
	('76576845','@craft/web/assets/dashboard/dist'),
	('7a74559c','@lib/element-resize-detector'),
	('7ae44a38','@app/web/assets/cp/dist'),
	('7eda5f46','@app/web/assets/login/dist'),
	('815181ef','@app/web/assets/cp/dist'),
	('83a8fb58','@craft/redactor/assets/field/dist'),
	('84a86c2f','@craft/web/assets/pluginstore/dist'),
	('84b96838','@craft/web/assets/craftsupport/dist'),
	('8622a9c4','@lib/garnishjs'),
	('86f350da','@craft/web/assets/craftsupport/dist'),
	('875cabe0','@lib/xregexp'),
	('8a2dbda6','@lib/fileupload'),
	('8b96180f','@lib/jquery-ui'),
	('8c1ecf8b','@lib/velocity'),
	('8cbfdff5','@craft/web/assets/login/dist'),
	('8d30ef6a','@lib/selectize'),
	('8dd35c52','@craft/web/assets/cp/dist'),
	('8e6e93b5','@craft/icons'),
	('90396063','@lib/jquery.payment'),
	('916113b2','@craft/web/assets/updateswidget/dist'),
	('91a07542','@craft/web/assets/dashboard/dist'),
	('92c5bc58','@lib/picturefill'),
	('93647dfa','@lib/fabric'),
	('94934876','@lib/datepicker-i18n'),
	('9561809a','@lib/jquery-touch-events'),
	('97ad85c3','@craft/web/assets/updateswidget/dist'),
	('9823f426','@app/web/assets/pluginstore/dist'),
	('99945493','@craft/redactor/assets/field/dist'),
	('99d13e6a','@runtime/assets/thumbs/9'),
	('9b4fdeea','@lib/element-resize-detector'),
	('9b61b080','@app/web/assets/utilities/dist'),
	('9c292093','@verbb/navigation/resources/dist'),
	('9c609c09','@lib/d3'),
	('9d3058f','@lib/fileupload'),
	('9d8d8ff','@craft/web/assets/feed/dist'),
	('9d9138f6','@bower/jquery/dist'),
	('a0d481f2','@craft/web/assets/updater/dist'),
	('a31a4369','@craft/web/assets/plugins/dist'),
	('a3d29fed','@lib/fileupload'),
	('a3f91bc6','@rias/passwordpolicy/assetbundles/passwordpolicy/dist'),
	('a4429661','@craft/web/assets/plugins/dist'),
	('a46d34d0','@lib/datepicker-i18n'),
	('a5508262','@lib/velocity'),
	('a5a8141e','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),
	('a608ae83','@craft/web/assets/plugins/dist'),
	('a614cb05','@app/web/assets/updates/dist'),
	('a8712a14','@craft/web/assets/updates/dist'),
	('a917c7ad','@craft/web/assets/recententries/dist'),
	('ac292b1','@lib/jquery-ui'),
	('afdb51dc','@craft/web/assets/recententries/dist'),
	('afdd8b8f','@lib/garnishjs'),
	('b0b98ed1','@app/web/assets/updater/dist'),
	('b2019303','@lib/element-resize-detector'),
	('b4df751f','@bower/jquery/dist'),
	('b59fbe42','@lib/d3'),
	('b7a2d746','@lib/xregexp'),
	('b9772d8a','@lib/jquery.payment'),
	('b9e66d9e','@craft/web/assets/feed/dist'),
	('b9e90474','@app/web/assets/dashboard/dist'),
	('ba9b5fb1','@lib/fabric'),
	('bafc27d0','@lib/jquery-ui'),
	('bb3a9e13','@lib/picturefill'),
	('bbac557c','@craft/web/assets/feed/dist'),
	('bc9ea2d1','@lib/jquery-touch-events'),
	('bdce93cc','@lib/selectize'),
	('be18a858','@lib/prismjs'),
	('c051df1','@rias/widthfieldtype/assetbundles/widthfieldtype/dist/img'),
	('c0a54b55','@craft/web/assets/dashboard/dist'),
	('c1a6c310','@lib/fileupload'),
	('c1ee5da1','@lib/fabric'),
	('c2ad8982','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('c2b7542e','@lib/jquery-ui'),
	('c2ef73b7','@craft/web/assets/dashboard/dist'),
	('c341a22c','@verbb/navigation/resources/dist'),
	('c53f83aa','@lib/velocity'),
	('c5910e87','@rias/passwordpolicy/assetbundles/PasswordPolicy/dist'),
	('c6465d4','@lib/selectize'),
	('c6bb91dc','@lib/selectize'),
	('c732f26e','@rias/widthfieldtype/assetbundles/widthfieldtype/dist'),
	('ca4ae0fd','@lib/element-resize-detector'),
	('cab8c5cd','@app/web/assets/updater/dist'),
	('ccd7d556','@lib/xregexp'),
	('d16f444b','@nystudio107/seomatic/assetbundles/seomatic/dist'),
	('d1edf2e9','@craft/web/assets/utilities/dist'),
	('d4a8899f','@lib/garnishjs'),
	('d4b074d7','@bower/jquery/dist'),
	('d619144e','@rias/widthfieldtype/assetbundles/widthfieldtype/dist/img'),
	('d7216498','@craft/web/assets/utilities/dist'),
	('d7ebe2bf','@lib/d3'),
	('d7f66ecd','@craft/web/assets/craftsupport/dist'),
	('d9182c42','@lib/jquery.payment'),
	('d94ec2ee','@lib/picturefill'),
	('d9e870c4','@craft/web/assets/edituser/dist'),
	('dad7af68','@lib/timepicker'),
	('dc6cf4a5','@lib/prismjs'),
	('dd2590db','@craft/web/assets/matrixsettings/dist'),
	('deeafe2c','@lib/jquery-touch-events'),
	('df1836c0','@lib/datepicker-i18n'),
	('dfb9b962','@nystudio107/seomatic/assetbundles/seomatic/dist'),
	('dffab0e1','@craft/web/assets/matrix/dist'),
	('e08b0925','@vendor/craftcms/redactor/lib/redactor-plugins/source'),
	('e249b1b7','@craft/web/assets/editentry/dist'),
	('e456f539','@lib/garnishjs'),
	('e4cec913','@vendor/craftcms/redactor/lib/redactor'),
	('e528f71d','@lib/xregexp'),
	('e54e793e','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('e5da4b08','@bower/jquery/dist'),
	('e7159e19','@lib/d3'),
	('e83291','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),
	('e872139d','@lib/jquery.payment'),
	('e8e35389','@craft/web/assets/feed/dist'),
	('e96b96de','@craft/web/assets/cp/dist'),
	('e9b0be48','@lib/picturefill'),
	('eb4680de','@rias/widthfieldtype/assetbundles/widthfieldtype/dist'),
	('ebf919c7','@lib/jquery-ui'),
	('ec9ab52f','@lib'),
	('ee14828a','@lib/jquery-touch-events'),
	('ef44b397','@lib/selectize'),
	('f1102107','@lib/fabric'),
	('f144e8e','@craft/web/assets/feed/dist'),
	('f158bfb6','@lib/fileupload'),
	('f455bc75','@lib/velocity'),
	('f6e7148b','@lib/datepicker-i18n'),
	('f8d27cc2','@vendor/craftcms/redactor/lib/redactor-plugins/widget'),
	('f91af211','@app/web/assets/cp/dist'),
	('f9741403','@craft/web/assets/updates/dist'),
	('fb20df22','@lib/element-resize-detector'),
	('fb3e2ce1','@craft/web/assets/updates/dist'),
	('fba636c','@lib'),
	('fd6c9d4b','@craft/web/assets/deprecationerrors/dist'),
	('fe077a2','@lib/velocity'),
	('fe2cc10b','@craft/web/assets/updates/dist'),
	('fef266d8','@vendor/craftcms/redactor/lib/redactor');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' marbles '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' rias marbles be '),
	(1,'slug',0,1,''),
	(2,'slug',0,1,' __home__ '),
	(2,'title',0,1,' home '),
	(2,'field',2,1,' himenaeos bibendum ad quis malesuada sem sagittis non at lobortis id sed elementum erat aenean dictum integer iaculis curabitur vivamus consectetur proin facilisis a at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non fusce maecenas tortor justo eu erat nam adipiscing leo quam ultricies sociosqu orci felis platea et at aenean lorem inceptos velit nostra torquent phasellus vulputate sem tincidunt elit ante tortor justo eros quam facilisis blandit ac phasellus erat nibh orci curae est rhoncus et a potenti nam sociis natoque tortor taciti netus cursus quis nostra fusce molestie ullamcorper aptent odio torquent mollis etiam aliquet massa suscipit column 1 2 himenaeos bibendum ad quis malesuada sem sagittis non at lobortis id sed elementum erat aenean dictum integer iaculis curabitur vivamus consectetur proin facilisis a at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non fusce maecenas tortor justo eu erat nam adipiscing leo quam ultricies sociosqu orci felis platea et at aenean lorem inceptos velit nostra torquent phasellus vulputate sem tincidunt elit ante tortor justo eros quam facilisis blandit ac phasellus erat nibh orci curae est rhoncus et a potenti nam sociis natoque tortor taciti netus cursus quis nostra fusce molestie ullamcorper aptent odio torquent mollis etiam aliquet massa suscipit column 1 2 '),
	(10,'field',24,1,' column '),
	(11,'field',24,1,' column '),
	(2,'field',17,1,' craftremote '),
	(2,'field',16,1,' volutpat dignissim primis metus ultrices auctor molestie iaculis elit felis imperdiet tortor semper tempor enim maecenas varius mattis augue phasellus at curabitur platea nec donec class laoreet ultricies odio nisi inceptos scelerisque '),
	(3,'slug',0,1,' 404 '),
	(3,'title',0,1,' 404 '),
	(3,'field',2,1,''),
	(4,'slug',0,1,' 503 '),
	(4,'title',0,1,' 503 '),
	(4,'field',2,1,''),
	(10,'field',3,1,' himenaeos bibendum ad quis malesuada sem sagittis non at lobortis id sed elementum erat aenean dictum integer iaculis curabitur vivamus consectetur proin facilisis a at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non fusce maecenas tortor justo eu erat nam adipiscing leo quam ultricies sociosqu orci felis platea et at aenean lorem inceptos velit nostra torquent phasellus vulputate sem tincidunt elit ante tortor justo eros quam facilisis blandit ac phasellus erat nibh orci curae est rhoncus et a potenti nam sociis natoque tortor taciti netus cursus quis nostra fusce molestie ullamcorper aptent odio torquent mollis etiam aliquet massa suscipit '),
	(10,'field',4,1,' left '),
	(10,'field',5,1,' 1 2 '),
	(10,'slug',0,1,''),
	(11,'field',3,1,' himenaeos bibendum ad quis malesuada sem sagittis non at lobortis id sed elementum erat aenean dictum integer iaculis curabitur vivamus consectetur proin facilisis a at massa est risus integer mauris aliquam ante fringilla placerat ridiculus aptent semper rhoncus habitasse vulputate fermentum euismod sem sociis inceptos imperdiet phasellus potenti vehicula eu neque egestas eros suspendisse praesent faucibus torquent non fusce maecenas tortor justo eu erat nam adipiscing leo quam ultricies sociosqu orci felis platea et at aenean lorem inceptos velit nostra torquent phasellus vulputate sem tincidunt elit ante tortor justo eros quam facilisis blandit ac phasellus erat nibh orci curae est rhoncus et a potenti nam sociis natoque tortor taciti netus cursus quis nostra fusce molestie ullamcorper aptent odio torquent mollis etiam aliquet massa suscipit '),
	(11,'field',4,1,' right '),
	(11,'field',5,1,' 1 2 '),
	(11,'slug',0,1,'');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagateEntries`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Pages','pages','structure',1,1,'2018-02-19 20:39:21','2018-02-19 20:39:21','fe154a59-9561-4bf1-ba7b-f2e632f45aaf'),
	(2,NULL,'404','notFound','single',0,1,'2018-02-19 21:05:21','2018-02-19 21:05:21','2692068f-5212-4ade-91df-f5b3ed74fd3a'),
	(3,NULL,'503','serviceUnavailable','single',1,1,'2018-02-19 21:06:26','2018-02-19 21:06:26','5d164903-fa95-4b19-bb53-3ccb8eccdc10');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,'{slug}','page',1,'2018-02-19 20:39:21','2018-02-19 20:39:21','ac5514ee-9ccc-4e86-8d08-8d79e7743311'),
	(2,2,1,1,'404','404',1,'2018-02-19 21:05:21','2018-02-19 21:05:21','dabf6a1d-1e49-49fc-b872-9e6d65856ba5'),
	(3,3,1,1,'503','503',1,'2018-02-19 21:06:26','2018-02-19 21:06:26','94cf64b3-25eb-4c35-a363-51ba2d3be698');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table seomatic_metabundles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `seomatic_metabundles`;

CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(64) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text,
  `metaSiteVars` text,
  `metaSitemapVars` text,
  `metaContainers` text,
  `redirectsContainer` text,
  `frontendTemplatesContainer` text,
  `metaBundleSettings` text,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;

INSERT INTO `seomatic_metabundles` (`id`, `dateCreated`, `dateUpdated`, `uid`, `bundleVersion`, `sourceBundleType`, `sourceId`, `sourceName`, `sourceHandle`, `sourceType`, `sourceTemplate`, `sourceSiteId`, `sourceAltSiteSettings`, `sourceDateUpdated`, `metaGlobalVars`, `metaSiteVars`, `metaSitemapVars`, `metaContainers`, `redirectsContainer`, `frontendTemplatesContainer`, `metaBundleSettings`)
VALUES
	(1,'2018-03-17 15:29:27','2018-09-17 12:39:27','e38c08c1-11f4-464a-86ad-07678564cb2c','1.0.38','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','',1,'[]','2018-09-17 12:39:27','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"\",\"siteNamePosition\":\"after\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":null,\"seoImageHeight\":null,\"seoImageDescription\":\"\",\"canonicalUrl\":\"http://craft.wip/\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":null,\"ogImageHeight\":null,\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":null,\"twitterImageHeight\":null,\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"craft\",\"identity\":{\"siteType\":null,\"siteSubType\":null,\"siteSpecificType\":null,\"computedType\":\"Organization\",\"genericName\":null,\"genericAlternateName\":null,\"genericDescription\":null,\"genericUrl\":null,\"genericImage\":null,\"genericImageWidth\":null,\"genericImageHeight\":null,\"genericImageIds\":null,\"genericTelephone\":null,\"genericEmail\":null,\"genericStreetAddress\":null,\"genericAddressLocality\":null,\"genericAddressRegion\":null,\"genericPostalCode\":null,\"genericAddressCountry\":null,\"genericGeoLatitude\":null,\"genericGeoLongitude\":null,\"personGender\":null,\"personBirthPlace\":null,\"organizationDuns\":null,\"organizationFounder\":null,\"organizationFoundingDate\":null,\"organizationFoundingLocation\":null,\"organizationContactPoints\":null,\"corporationTickerSymbol\":null,\"localBusinessPriceRange\":null,\"localBusinessOpeningHours\":null,\"restaurantServesCuisine\":null,\"restaurantMenuUrl\":null,\"restaurantReservationsUrl\":null},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":null,\"computedType\":\"Organization\",\"genericName\":\"Marbles\",\"genericAlternateName\":\"\",\"genericDescription\":\"Marbles Digital Agency is een Antwerps communicatiebureau met ‘goesting’. Goesting om samen met jou te evolueren en resultaten te boeken met digitale strategieën.\",\"genericUrl\":\"https://www.marbles.be\",\"genericImage\":null,\"genericImageWidth\":null,\"genericImageHeight\":null,\"genericImageIds\":\"\",\"genericTelephone\":\"+32 3 620 26 79\",\"genericEmail\":\"hallo@marbles.be\",\"genericStreetAddress\":\"IJzerenpoortkaai 3\",\"genericAddressLocality\":\"Antwerpen\",\"genericAddressRegion\":\"Antwerpen\",\"genericPostalCode\":\"2000\",\"genericAddressCountry\":\"België\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"Male\",\"personBirthPlace\":\"\",\"organizationDuns\":\"BE0474336334\",\"organizationFounder\":\"Tom Herrijgers\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":null,\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"$$$\",\"localBusinessOpeningHours\":[{\"open\":null,\"close\":null},{\"open\":null,\"close\":null},{\"open\":null,\"close\":null},{\"open\":null,\"close\":null},{\"open\":null,\"close\":null},{\"open\":null,\"close\":null},{\"open\":null,\"close\":null}],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\"},{\"property\":\"geo_location\"},{\"property\":\"license\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\"},{\"property\":\"thumbnailLoc\"},{\"property\":\"duration\"},{\"property\":\"category\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"no-referrer-when-downgrade\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ siteUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ url(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% if sendPageView.value %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{sendPageView.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{sendPageView.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{sendPageView.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"//www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dl\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% if sendPageView.value %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"isicV4\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraftCMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":null,\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":null,\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":null,\"seoImageIds\":\"\",\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":\"1\",\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":null,\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":null,\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":null,\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":null,\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":null,\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":null,\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":null,\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":null}'),
	(3,'2018-03-17 15:29:27','2018-08-14 08:51:19','19749feb-ebeb-4001-9224-70455c868340','1.0.26','section',1,'Pages','pages','structure','page',1,'{\"1\":{\"id\":\"1\",\"sectionId\":\"1\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"{slug}\",\"template\":\"page\",\"language\":\"nl-be\"}}','2018-03-17 15:37:52','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{seomatic.helper.extractTextFromField(object.entry.title)}\",\"siteNamePosition\":\"\",\"seoDescription\":\"{seomatic.helper.extractTextFromField(object.entry.teaserDescription)}\",\"seoKeywords\":\"{seomatic.helper.extractKeywords(seomatic.helper.extractTextFromField(object.entry.builder))}\",\"seoImage\":\"{seomatic.helper.socialTransform(object.entry.teaserImage.one(), \\\"base\\\", 1)}\",\"seoImageWidth\":null,\"seoImageHeight\":null,\"seoImageDescription\":\"{seomatic.helper.extractSummary(seomatic.helper.extractTextFromField(object.entry.builder))}\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":null,\"ogImageHeight\":null,\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":null,\"twitterImageHeight\":null,\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\"},{\"property\":\"geo_location\"},{\"property\":\"license\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\"},{\"property\":\"thumbnailLoc\"},{\"property\":\"duration\"},{\"property\":\"category\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[]},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[]},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[]},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate |atom}\",\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"exampleOfWork\":null,\"expires\":null,\"fileFormat\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"material\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sourceOrganization\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.site.siteLinksQueryInput}\"},\"sameAs\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[]}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromField\",\"seoDescriptionField\":\"teaserDescription\",\"seoKeywordsSource\":\"keywordsFromField\",\"seoKeywordsField\":\"builder\",\"seoImageIds\":\"\",\"seoImageSource\":\"fromField\",\"seoImageField\":\"teaserImage\",\"seoImageTransform\":\"1\",\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"summaryFromField\",\"seoImageDescriptionField\":\"builder\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":null,\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":null,\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":null,\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":null,\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":null,\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":null,\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":null}');

/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(9,1,'2JdySZqIOyXZm5xaFzRDPkYXUr83c3hnVq_XdJbuROYu3dCj3-SMttnHV5F7oT8ncf27GppqOBIFpdMTaOk4tzK6OpNAyAhZsuJH','2018-09-17 12:38:25','2018-09-17 12:41:11','c58d041a-4826-4d8a-ad7f-8980f2040757'),
	(10,1,'V8qG1HgEwGNxa_CRrM1i2dudV-MvckdIcRpDrAi53qq_3P3dOGiBuOrSLk4Pvq1BSWCf6bseNnRmZlYZPRHpaTP5jyoRivzAQk3k','2018-09-20 14:54:24','2018-09-20 14:56:35','dadb1179-b9b7-4161-8110-eaa11e792f93');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft','2018-02-19 20:35:16','2018-02-19 20:35:16','621953cd-07f9-4cb7-b4b8-ce528d22656b');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'craft','default','nl-BE',1,'http://craft.wip/',1,'2018-02-19 20:35:16','2018-02-19 20:35:16','9d6f768b-e1c6-4802-9e7d-06ef35121847');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;

INSERT INTO `structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,NULL,1,1,4,0,'2018-02-19 20:39:37','2018-08-14 08:53:38','9f655e24-120a-4b29-a5f1-ead7175ae8b8'),
	(2,1,2,1,2,3,1,'2018-02-19 20:39:37','2018-02-19 20:39:37','3514c6ef-5a9b-49f9-bba8-366d0122c499');

/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;

INSERT INTO `structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'2018-02-19 20:39:21','2018-02-19 20:39:21','a7be0409-cc51-42d0-b87b-69b4e0a5f994'),
	(3,NULL,'2018-08-14 08:51:16','2018-08-14 08:51:16','2fa2ec1e-a92a-4850-bf36-fca2a6a6ebc5');

/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table supertableblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `supertableblocks`;

CREATE TABLE `supertableblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocks_ownerId_idx` (`ownerId`),
  KEY `supertableblocks_fieldId_idx` (`fieldId`),
  KEY `supertableblocks_typeId_idx` (`typeId`),
  KEY `supertableblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `supertableblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `supertableblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `supertableblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table supertableblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `supertableblocktypes`;

CREATE TABLE `supertableblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocktypes_fieldId_idx` (`fieldId`),
  KEY `supertableblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `supertableblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemsettings`;

CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;

INSERT INTO `systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"rias@marbles.be\",\"fromName\":\"craft\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"}','2018-02-19 20:35:16','2018-02-19 20:35:16','85b6eea2-7778-487c-9b88-4bf09a57a7cf');

/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"nl\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Marbles',NULL,'','','rias@marbles.be','$2y$13$52sWHiSYS486.cu2JhwGGue18.ja879mz4UO5LoMi2GE.RUT.2UP.',1,0,0,0,'2018-09-20 14:54:24','127.0.0.1',NULL,NULL,'2018-09-20 14:06:57',NULL,1,NULL,NULL,NULL,0,'2018-02-19 20:35:16','2018-02-19 20:35:16','2018-09-20 14:54:24','6aebbe27-3535-4912-a70d-5c180c8337db');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,NULL,'Tijdelijke bron',NULL,'2018-02-19 20:40:12','2018-02-19 20:40:12','a8e9a440-1c1b-416a-a72b-91cf3efb2435'),
	(2,1,NULL,'user_1','user_1/','2018-02-19 20:40:12','2018-02-19 20:40:12','5cf719e3-aa73-4302-90ff-02ec1851fa82'),
	(3,NULL,1,'Images','','2018-02-19 20:47:40','2018-02-19 20:47:40','d0f09da2-3dbc-4180-af77-fdfe80c5e475');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Images','images','craft\\volumes\\Local',1,'@baseUrl/assets/images/','{\"path\":\"@basePath/storage/assets/images/\"}',1,'2018-02-19 20:47:40','2018-02-19 20:49:20','56927c8a-e051-4381-aa6c-4100a9fa4991');

/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}','2018-02-19 20:35:35','2018-02-19 20:35:35','3b635e6a-6e5c-4e19-872a-a002bb1b130c'),
	(2,1,'craft\\widgets\\CraftSupport',2,0,'[]','2018-02-19 20:35:35','2018-02-19 20:35:35','085b3141-288b-4001-afa2-c43a70b6cdec'),
	(3,1,'craft\\widgets\\Updates',3,0,'[]','2018-02-19 20:35:35','2018-02-19 20:35:35','bd367fc3-df9b-4bd6-8cda-fe9ffb2e0e6f'),
	(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}','2018-02-19 20:35:35','2018-02-19 20:35:35','b94ff7ca-3b66-44d6-a799-42a3f0d6a0ba');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
