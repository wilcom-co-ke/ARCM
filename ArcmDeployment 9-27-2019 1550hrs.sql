-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.37-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for arcm
DROP DATABASE IF EXISTS `arcm`;
CREATE DATABASE IF NOT EXISTS `arcm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `arcm`;

-- Dumping structure for procedure arcm.Activation
DROP PROCEDURE IF EXISTS `Activation`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Activation`(IN `_IsEmailverified` BOOLEAN, IN `_Email` VARCHAR(100), IN `_ActivationCode` VARCHAR(100))
    NO SQL
BEGIN

UPDATE `users`set `IsEmailverified`=_IsEmailverified 
WHERE `Username`=_username and`Email`=_Email;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.AddPanelMember
DROP PROCEDURE IF EXISTS `AddPanelMember`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPanelMember`(IN _ApplicationNo VARCHAR(50), IN _Role VARCHAR(100), IN _UserName VARCHAR(50), IN _UserID varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Added new PanelMember for Application '+_ApplicationNo+': ', _UserName); 
  insert into panels (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By)
  Values (_ApplicationNo,_UserName,'Approved',_Role,0,now(),_UserID);

    insert into panelsapprovalworkflow (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By,  Approver , Approved_At)
  Values (_ApplicationNo,_UserName,'Approved',_Role,0,now(),_UserID,_UserID,now()); 
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for table arcm.adjournment
DROP TABLE IF EXISTS `adjournment`;
CREATE TABLE IF NOT EXISTS `adjournment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime NOT NULL,
  `Applicant` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `DecisionDate` date DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created_At` date NOT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApprovalRemarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.adjournment: ~0 rows (approximately)
/*!40000 ALTER TABLE `adjournment` DISABLE KEYS */;
/*!40000 ALTER TABLE `adjournment` ENABLE KEYS */;

-- Dumping structure for table arcm.adjournmentdocuments
DROP TABLE IF EXISTS `adjournmentdocuments`;
CREATE TABLE IF NOT EXISTS `adjournmentdocuments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Path` varchar(105) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Filename` varchar(105) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.adjournmentdocuments: ~0 rows (approximately)
/*!40000 ALTER TABLE `adjournmentdocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `adjournmentdocuments` ENABLE KEYS */;

-- Dumping structure for table arcm.applicants
DROP TABLE IF EXISTS `applicants`;
CREATE TABLE IF NOT EXISTS `applicants` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicantCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PEType` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `County` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `POBox` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostalCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Telephone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Logo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Website` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `RegistrationDate` datetime DEFAULT NULL,
  `PIN` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RegistrationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicantCode`) USING BTREE,
  KEY `financialyear_ibfk_1` (`Created_By`),
  KEY `financialyear_ibfk_2` (`Updated_By`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicants: ~2 rows (approximately)
/*!40000 ALTER TABLE `applicants` DISABLE KEYS */;
INSERT INTO `applicants` (`ID`, `ApplicantCode`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`, `RegistrationDate`, `PIN`, `RegistrationNo`) VALUES
	(1, 'AP-10', 'kapsadmin', '', '002', 'Kakamega', '1902', '30106', 'TURBO  ', '07055555287', '07055555287', 'elviskcheruiyot@gmail.com', '1566286580096-admin.png', 'https://www.google.com', 'kapsadmin', '2019-08-20 10:36:26', '2019-08-27 14:17:21', 'Admin', 0, NULL, NULL, '2019-08-01 00:00:00', '07055555287', '07055555287'),
	(2, 'AP-11', 'Wilcom Systems ', '', '047', 'Kakamega', '190', '30106', 'TURBO  ', '0705555285', '0705555285', 'admin@admin.com', '1566311200791-WilcomLogo.jpg', 'https://www.google.com', 'Applicant', '2019-08-20 16:31:33', '2019-08-29 11:47:29', 'Applicant', 0, NULL, NULL, '2010-08-01 00:00:00', 'A123456789X', '0705555285');
/*!40000 ALTER TABLE `applicants` ENABLE KEYS */;

-- Dumping structure for table arcm.applicantshistory
DROP TABLE IF EXISTS `applicantshistory`;
CREATE TABLE IF NOT EXISTS `applicantshistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicantCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PEType` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `County` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `POBox` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostalCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Telephone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Logo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Website` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicantCode`) USING BTREE,
  KEY `financialyear_ibfk_1` (`Created_By`),
  KEY `financialyear_ibfk_2` (`Updated_By`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicantshistory: ~0 rows (approximately)
/*!40000 ALTER TABLE `applicantshistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `applicantshistory` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationdocuments
DROP TABLE IF EXISTS `applicationdocuments`;
CREATE TABLE IF NOT EXISTS `applicationdocuments` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(100) NOT NULL,
  `Description` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateUploaded` datetime NOT NULL,
  `Path` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Path`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationdocuments: ~0 rows (approximately)
/*!40000 ALTER TABLE `applicationdocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `applicationdocuments` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationdocumentshistory
DROP TABLE IF EXISTS `applicationdocumentshistory`;
CREATE TABLE IF NOT EXISTS `applicationdocumentshistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(100) NOT NULL,
  `DocType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateUploaded` datetime NOT NULL,
  `Path` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Path`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationdocumentshistory: ~0 rows (approximately)
/*!40000 ALTER TABLE `applicationdocumentshistory` DISABLE KEYS */;
INSERT INTO `applicationdocumentshistory` (`ID`, `ApplicationID`, `DocType`, `Description`, `FileName`, `DateUploaded`, `Path`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`) VALUES
	(1, 1, NULL, 'Tender document', '1569826539882-Invoice1.pdf', '2019-09-30 09:55:40', 'http://74.208.157.60:3001/Documents', 'Applicant', '2019-09-30 09:55:40', NULL, NULL, 0, NULL, NULL);
/*!40000 ALTER TABLE `applicationdocumentshistory` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationfees
DROP TABLE IF EXISTS `applicationfees`;
CREATE TABLE IF NOT EXISTS `applicationfees` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` bigint(20) NOT NULL,
  `EntryType` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AmountDue` float DEFAULT NULL,
  `RefNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillDate` datetime NOT NULL,
  `AmountPaid` float DEFAULT NULL,
  `PaidDate` datetime DEFAULT NULL,
  `PaymentRef` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PaymentMode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationfees: ~8 rows (approximately)
/*!40000 ALTER TABLE `applicationfees` DISABLE KEYS */;
INSERT INTO `applicationfees` (`ID`, `ApplicationID`, `EntryType`, `AmountDue`, `RefNo`, `BillDate`, `AmountPaid`, `PaidDate`, `PaymentRef`, `PaymentMode`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`) VALUES
	(1, 1, 'Application fee', 5000, 'ENDER NO. CBK/14/2019-2020', '2019-10-01 11:07:05', 0, NULL, NULL, NULL, 'Applicant', '2019-10-01 11:07:05', NULL, NULL, 0, NULL, NULL),
	(2, 1, '10% On Tender Value', 10000, 'ENDER NO. CBK/14/2019-2020', '2019-10-01 11:07:05', 0, NULL, NULL, NULL, 'Applicant', '2019-10-01 11:07:05', NULL, NULL, 0, NULL, NULL),
	(3, 2, 'Application fee', 5000, 'ENDER NO. CBK/14/2019-2020', '2019-10-02 15:05:22', 0, NULL, NULL, NULL, 'Applicant', '2019-10-02 15:05:22', NULL, NULL, 0, NULL, NULL),
	(4, 2, '10% On Tender Value', 12345.6, 'ENDER NO. CBK/14/2019-2020', '2019-10-02 15:05:22', 0, NULL, NULL, NULL, 'Applicant', '2019-10-02 15:05:22', NULL, NULL, 0, NULL, NULL),
	(5, 3, 'Application fee', 5000, 'ENDER NO. CBK/14/2019-2020', '2019-10-02 15:17:25', 0, NULL, NULL, NULL, 'Applicant', '2019-10-02 15:17:25', NULL, NULL, 0, NULL, NULL),
	(6, 3, '10% On Tender Value', 123457, 'ENDER NO. CBK/14/2019-2020', '2019-10-02 15:17:25', 0, NULL, NULL, NULL, 'Applicant', '2019-10-02 15:17:25', NULL, NULL, 0, NULL, NULL),
	(7, 4, 'Application fee', 5000, 'ENDER NO. CBK/14/2019-2020', '2019-10-02 15:31:34', 0, NULL, NULL, NULL, 'Applicant', '2019-10-02 15:31:34', NULL, NULL, 0, NULL, NULL),
	(8, 4, '10% On Tender Value', 12345.6, 'ENDER NO. CBK/14/2019-2020', '2019-10-02 15:31:34', 0, NULL, NULL, NULL, 'Applicant', '2019-10-02 15:31:34', NULL, NULL, 0, NULL, NULL);
/*!40000 ALTER TABLE `applicationfees` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationfeeshistory
DROP TABLE IF EXISTS `applicationfeeshistory`;
CREATE TABLE IF NOT EXISTS `applicationfeeshistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicantID` bigint(20) NOT NULL,
  `EntryType` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AmountDue` float DEFAULT NULL,
  `RefNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillDate` datetime NOT NULL,
  `AmountPaid` float DEFAULT NULL,
  `PaidDate` datetime DEFAULT NULL,
  `PaymentRef` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PaymentMode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicantID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationfeeshistory: ~0 rows (approximately)
/*!40000 ALTER TABLE `applicationfeeshistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `applicationfeeshistory` ENABLE KEYS */;

-- Dumping structure for table arcm.applications
DROP TABLE IF EXISTS `applications`;
CREATE TABLE IF NOT EXISTS `applications` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenderID` bigint(20) NOT NULL,
  `ApplicantID` bigint(20) NOT NULL,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FilingDate` datetime DEFAULT NULL,
  `ApplicationREf` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`) USING BTREE,
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applications: ~4 rows (approximately)
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` (`ID`, `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`) VALUES
	(1, 1, 2, 'PE-2', '2019-10-01 11:07:05', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-50', 'HEARING IN PROGRESS', 'Applicant', '2019-10-01 11:07:05', NULL, NULL, 0, NULL, NULL),
	(2, 2, 2, 'PE-2', '2019-10-02 15:05:22', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-51', 'APPROVED', 'Applicant', '2019-10-02 15:05:22', NULL, NULL, 0, NULL, NULL),
	(3, 3, 2, 'PE-2', '2019-10-02 15:17:24', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-52', 'APPROVED', 'Applicant', '2019-10-02 15:17:24', NULL, NULL, 0, NULL, NULL),
	(4, 4, 2, 'PE-2', '2019-10-02 15:31:34', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-53', 'APPROVED', 'Applicant', '2019-10-02 15:31:34', NULL, NULL, 0, NULL, NULL);
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationshistory
DROP TABLE IF EXISTS `applicationshistory`;
CREATE TABLE IF NOT EXISTS `applicationshistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenderID` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApplicantID` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FilingDate` datetime DEFAULT NULL,
  `ApplicationREf` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationshistory: ~0 rows (approximately)
/*!40000 ALTER TABLE `applicationshistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `applicationshistory` ENABLE KEYS */;

-- Dumping structure for table arcm.applications_approval_workflow
DROP TABLE IF EXISTS `applications_approval_workflow`;
CREATE TABLE IF NOT EXISTS `applications_approval_workflow` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenderID` bigint(20) NOT NULL,
  `ApplicantID` bigint(20) NOT NULL,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FilingDate` datetime DEFAULT NULL,
  `ApplicationREf` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Approved_At` datetime DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`) USING BTREE,
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applications_approval_workflow: ~8 rows (approximately)
/*!40000 ALTER TABLE `applications_approval_workflow` DISABLE KEYS */;
INSERT INTO `applications_approval_workflow` (`ID`, `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, `Approver`, `Remarks`, `Created_By`, `Approved_At`, `Created_At`) VALUES
	(1, 1, 2, 'PE-2', '2019-10-01 11:07:05', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-50', 'Approved', 'Admin', '851864', 'Applicant', '2019-10-01 11:07:58', '2019-10-01 11:07:05'),
	(2, 1, 2, 'PE-2', '2019-10-01 11:07:05', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-50', 'Pending Approval', 'Admin2', NULL, 'Admin', NULL, '2019-10-01 11:07:58'),
	(3, 2, 2, 'PE-2', '2019-10-02 15:05:22', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-51', 'Approved', 'Admin', '180418', 'Applicant', '2019-10-02 15:06:50', '2019-10-02 15:05:22'),
	(4, 2, 2, 'PE-2', '2019-10-02 15:05:22', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-51', 'Pending Approval', 'Admin2', NULL, 'Admin', NULL, '2019-10-02 15:06:50'),
	(5, 3, 2, 'PE-2', '2019-10-02 15:17:24', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-52', 'Approved', 'Admin', '697976', 'Applicant', '2019-10-02 15:19:09', '2019-10-02 15:17:24'),
	(6, 3, 2, 'PE-2', '2019-10-02 15:17:24', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-52', 'Pending Approval', 'Admin2', NULL, 'Admin', NULL, '2019-10-02 15:19:09'),
	(7, 4, 2, 'PE-2', '2019-10-02 15:31:34', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-53', 'Approved', 'Admin', '703939', 'Applicant', '2019-10-02 15:32:59', '2019-10-02 15:31:34'),
	(8, 4, 2, 'PE-2', '2019-10-02 15:31:34', 'ENDER NO. CBK/14/2019-2020', 'ARCM-AP-53', 'Pending Approval', 'Admin2', NULL, 'Admin', NULL, '2019-10-02 15:32:59');
/*!40000 ALTER TABLE `applications_approval_workflow` ENABLE KEYS */;

-- Dumping structure for table arcm.approvalmodules
DROP TABLE IF EXISTS `approvalmodules`;
CREATE TABLE IF NOT EXISTS `approvalmodules` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `ModuleCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ModuleCode`) USING BTREE,
  KEY `ModuleCode` (`ModuleCode`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.approvalmodules: ~8 rows (approximately)
/*!40000 ALTER TABLE `approvalmodules` DISABLE KEYS */;
INSERT INTO `approvalmodules` (`ID`, `ModuleCode`, `Name`, `Create_at`, `Update_at`, `Deleted`, `CreatedBy`, `UpdatedBy`) VALUES
	(1, 'APFRE', 'Application For Review', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(2, 'PAYMT', 'Fees Approval', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(3, 'REXED', 'Request For Extension of Deadline', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(4, 'PAREQ', 'Panellist Appointment', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(5, 'CAANR', 'Case Analysis Report', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(6, 'WIOAP', 'Withdrawal of Appeal', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(7, 'REODE', 'Refund of Deposit', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(8, 'ADJRE', 'Adjournment Request', '2019-08-21 17:58:50', NULL, 0, '', NULL),
	(9, 'CREFE', 'Case Referral', '2019-08-21 17:58:50', NULL, 0, '', NULL);
/*!40000 ALTER TABLE `approvalmodules` ENABLE KEYS */;

-- Dumping structure for procedure arcm.ApproveApplication
DROP PROCEDURE IF EXISTS `ApproveApplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `ApproveApplication`(IN _Approver VARCHAR(50),IN _ApplicationNo varchar(50),IN _Remarks varchar(255))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT(_Approver +' Approved Application: ',_ApplicationNo); 
UPDATE applications_approval_workflow
SET Status='Approved',Approved_At=now(),Remarks=_Remarks
WHERE Approver=_Approver and ApplicationNo=_ApplicationNo;

select Level from approvers  where ModuleCode ='APFRE' and Deleted=0 and Active=1 and Username=_Approver LIMIT 1 INTO @CurentLevel;

if(SELECT count(*)  from approvers where ModuleCode ='APFRE' and Deleted=0 and Active=1 and  Level=@CurentLevel + 1)>0 THEN
BEGIN
select Username from approvers  where ModuleCode ='APFRE' and Level=@CurentLevel+1 and Deleted=0 and Active=1 LIMIT 1 INTO @Approver2 ; 
	INSERT INTO `applications_approval_workflow`( `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, 	`Approver`, `Created_By`, `Created_At`) 
	SELECT
	`TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`,'Pending Approval', @Approver2, _Approver, now() from  applications_approval_workflow where ApplicationNo=_ApplicationNo and Approver=_Approver;
 
  call SaveNotification(@Approver2,'Applications Approval','Applications pending approval',DATE_ADD(NOW(), INTERVAL 3 DAY));

END;
ELSE
	Begin
		UPDATE applications_approval_workflow SET Status='Fully Approved',Approved_At=now(),Remarks=_Remarks
		WHERE Approver=_Approver and ApplicationNo=_ApplicationNo; 
    update applications set Status='APPROVED' where ApplicationNo=_ApplicationNo;
	END;
END IF;

if(@CurentLevel=1) THEN
Begin
update applications set Status='APPROVED' where ApplicationNo=_ApplicationNo;
select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
call SavePETimerResponse(@PEID,_ApplicationNo,NOW() + INTERVAL 14 DAY);
call AssignCaseOfficer(_ApplicationNo, @PEID, _Approver);
select Email,Name,Mobile,'Notify PE' as msg from procuremententity where PEID=@PEID;
END;
else
Begin
select 'Level 2' as msg;
End;
End IF;
call ResolveMyNotification(_Approver,'Applications Approval');
call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApprovecaseAdjournment
DROP PROCEDURE IF EXISTS `ApprovecaseAdjournment`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApprovecaseAdjournment`(IN _ApplicationNo VARCHAR(50), IN _ApprovalRemarks VARCHAR(255), IN _userID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Approved Case Adjournment for Application : ', _ApplicationNo); 
Update adjournment set  DecisionDate= now(), Status='Approved', ApprovalRemarks =_ApprovalRemarks where ApplicationNo=_ApplicationNo;
update applications set Status='ADJOURNED' where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
call ResolveMyNotification(_userID,'Case Adjournment Approval');

 DROP TABLE IF EXISTS caseWithdrawalContacts;
  create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Role varchar(50));
  insert into caseWithdrawalContacts select Name,Email,Phone,'Panel' from users where Username in (select UserName from panels where ApplicationNo=_ApplicationNo and Status='Approved' ) ;
  insert into caseWithdrawalContacts select Name,Email,Phone,'Case officer' from users where Username in (select UserName from casedetails where  ApplicationNo=_ApplicationNo and Deleted=0);

  select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
  insert into caseWithdrawalContacts select Name,Email,Phone,'PE' from users where Username in (select UserName from peusers where PEID=@PEID);
  insert into caseWithdrawalContacts select Name,Email,Mobile,'PE' from procuremententity where PEID=@PEID;
  select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
  insert into caseWithdrawalContacts select Name,Email,Phone,'Applicant' from users where Username =@Applicant;
  select ApplicantID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
  insert into caseWithdrawalContacts select Name,Email,Mobile,'Applicant' from applicants where  ID=@ApplicantID;
  select * from caseWithdrawalContacts;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApprovecaseWithdrawal
DROP PROCEDURE IF EXISTS `ApprovecaseWithdrawal`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApprovecaseWithdrawal`(IN _ApplicationNo varchar(50), IN _RejectionReason VARCHAR(255), IN _userID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Approved Case Withdrawal for Application : ', _ApplicationNo); 
Update casewithdrawal set  DecisionDate= now(), Status='Approved', RejectionReason =_RejectionReason,Frivolous =0 where ApplicationNo=_ApplicationNo;
update applications set Status='WITHDRAWN' where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
  call ResolveMyNotification(_userID,'Case withdrawal Approval');

  DROP TABLE IF EXISTS caseWithdrawalContacts;
  create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50));
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from panels where ApplicationNo=_ApplicationNo and Status='Approved' ) ;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from casedetails where  ApplicationNo=_ApplicationNo and Deleted=0);
  select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from peusers where PEID=@PEID);
  insert into caseWithdrawalContacts select Name,Email,Mobile from procuremententity where PEID=@PEID;
  select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username =@Applicant;
  select ApplicantID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
  insert into caseWithdrawalContacts select Name,Email,Mobile from applicants where  ID=@ApplicantID;
  select * from caseWithdrawalContacts;


END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApproveDeadlineRequestExtension
DROP PROCEDURE IF EXISTS `ApproveDeadlineRequestExtension`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApproveDeadlineRequestExtension`(IN _Approver VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _Remarks VARCHAR(255), IN _Newdate DATETIME)
BEGIN
DECLARE lSaleDesc varchar(200);


set lSaleDesc= CONCAT(_Approver +' Approved Deadline Extension Request for Application:',_ApplicationNo); 
UPDATE deadlineapprovalworkflow
SET Status='Approved',Approved_At=now(),Remarks=_Remarks
WHERE Approver=_Approver and ApplicationNo=_ApplicationNo;

select Level from approvers  where ModuleCode ='REXED' and Username=_Approver LIMIT 1 INTO @CurentLevel;

if(SELECT count(*)  from approvers where ModuleCode ='REXED'  and  Level=@CurentLevel + 1)>0 THEN
BEGIN

  select Username from approvers  where ModuleCode ='REXED' and Level=@CurentLevel+1 and Deleted=0 and Active=1 LIMIT 1 INTO @Approver2 ; 
  insert into deadlineapprovalworkflow ( PEID , ApplicationNo , Reason , RequestedDate,Created_At ,Created_By ,  Status , Approver )
  Select PEID , ApplicationNo , Reason , _Newdate,now() ,_Approver ,  'Pending Approval' , @Approver2 from deadlineapprovalworkflow 
  WHERE Approver=_Approver and ApplicationNo=_ApplicationNo ;
    CALL SaveNotification(@Approver2 ,'Deadline Approval','Deadline Approval Request', NOW() + INTERVAL 3 DAY);
  select Name,Email,Phone, 'Partially Approved' as msg from users where Username=@Approver2;

END;
ELSE
	Begin
		UPDATE deadlineapprovalworkflow SET Status='Fully Approved',Approved_At=now(),Remarks=_Remarks
		WHERE Approver=_Approver and ApplicationNo=_ApplicationNo ; 
    update pedeadlineextensionsrequests SET Status='Fully Approved'
		WHERE ApplicationNo=_ApplicationNo ;
    
    update peresponsetimer set DueOn=_Newdate where ApplicationNo=_ApplicationNo;
    
    select PEID from deadlineapprovalworkflow WHERE Approver=_Approver and ApplicationNo=_ApplicationNo LIMIT 1 INTO @PEID;
    select Name,Email,Mobile,@requestedDeadline as NewDeadline, 'Fully Approved' as msg from procuremententity where PEID=@PEID;

	END;
END IF;
call ResolveMyNotification(_Approver,'Deadline Approval');
call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApprovePanelMember
DROP PROCEDURE IF EXISTS `ApprovePanelMember`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApprovePanelMember`(IN _ApplicationNo VARCHAR(50),  IN _UserName VARCHAR(50), IN _UserID varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Approved  PanelMember for Application '+_ApplicationNo+': ', _UserName); 
  update Panels set Status='Approved' where ApplicationNo=_ApplicationNo and UserName=_UserName; 
  update panelsapprovalworkflow  set Status='Approved', Approved_At=now() where ApplicationNo=_ApplicationNo and UserName=_UserName and Approver=_userID;
  call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
END//
DELIMITER ;

-- Dumping structure for table arcm.approvers
DROP TABLE IF EXISTS `approvers`;
CREATE TABLE IF NOT EXISTS `approvers` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ModuleCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Level` int(5) NOT NULL,
  `Active` tinyint(1) DEFAULT NULL,
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `DeletedBY` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `Module` (`ModuleCode`),
  CONSTRAINT `Module` FOREIGN KEY (`ModuleCode`) REFERENCES `approvalmodules` (`ModuleCode`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.approvers: ~8 rows (approximately)
/*!40000 ALTER TABLE `approvers` DISABLE KEYS */;
INSERT INTO `approvers` (`ID`, `Username`, `ModuleCode`, `Level`, `Active`, `Create_at`, `Update_at`, `CreatedBy`, `UpdatedBy`, `Deleted`, `DeletedBY`, `Deleted_At`) VALUES
	(1, 'Admin', 'APFRE', 1, 1, '2019-08-22 09:56:37', '2019-08-27 17:47:20', 'Admin', 'Admin', 0, NULL, NULL),
	(2, 'Admin2', 'APFRE', 2, 1, '2019-08-27 12:13:46', NULL, 'Admin', NULL, 1, 'Admin', '2019-08-27 16:46:27.000000'),
	(3, 'Admin2', 'APFRE', 2, 1, '2019-08-27 16:46:17', '2019-09-13 15:20:51', 'Admin', 'Admin', 0, NULL, NULL),
	(4, 'Admin2', 'REXED', 1, 1, '2019-09-06 13:11:16', NULL, 'Admin', NULL, 0, NULL, NULL),
	(6, 'Admin', 'REXED', 2, 1, '2019-09-06 17:07:49', '2019-09-06 17:08:01', 'Admin', 'Admin', 0, NULL, NULL),
	(7, 'Admin', 'PAREQ', 1, 1, '2019-09-12 10:16:34', NULL, 'Admin', NULL, 0, NULL, NULL),
	(8, 'Admin2', 'PAREQ', 2, 1, '2019-09-12 12:21:54', NULL, 'Admin', NULL, 0, NULL, NULL),
	(9, 'Admin2', 'REODE', 2, 1, '2019-09-13 17:06:33', NULL, 'Admin', NULL, 0, NULL, NULL),
	(10, 'Admin', 'WIOAP', 1, 1, '2019-09-23 12:01:41', '2019-09-23 12:03:30', 'Admin', 'Admin', 0, NULL, NULL),
	(11, 'Admin2', 'ADJRE', 1, 1, '2019-09-24 11:13:53', NULL, 'Admin', NULL, 0, NULL, NULL);
/*!40000 ALTER TABLE `approvers` ENABLE KEYS */;

-- Dumping structure for procedure arcm.AssignCaseOfficer
DROP PROCEDURE IF EXISTS `AssignCaseOfficer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AssignCaseOfficer`(IN _Applicationno VARCHAR(50), IN _PEID VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN

select TenderID from applications WHERE ApplicationNo=_Applicationno  LIMIT  1 into @TenderID ;
select TenderValue from tenders where ID= @TenderID  LIMIT  1 into @TenderValue ;
DROP TABLE IF EXISTS TempUsers;
CREATE  TABLE TempUsers (
Name VARCHAR(50) NOT NULL
, OngoingCases int NOT NULL 
, CumulativeCases int NOT NULL 
);
insert into TempUsers (Name,OngoingCases,CumulativeCases)
  Select Username,OngoingCases,CumulativeCases from caseofficers where (MinValue<=@TenderValue and  MaximumValue>=@TenderValue) and  (NOW() NOT  BETWEEN NotAvailableFrom and NotAvailableTo);
 
select Name from TempUsers where OngoingCases in  (SELECT MIN(OngoingCases) FROM TempUsers ) OR CumulativeCases in( SELECT MIN(CumulativeCases) FROM TempUsers )  LIMIT 1 into @USER;

INSERT INTO `casedetails`( `UserName`, `ApplicationNo`, `DateAsigned`, `Status`, `PrimaryOfficer`,  `Created_At`, `Created_By`, `Deleted`) 
  VALUES (@USER,_Applicationno,now(),'Open',1,now(),_UserID,0);

  select OngoingCases from caseofficers where Username=@USER into @CurrentOngoingCases;
  select CumulativeCases from caseofficers where Username=@USER into @CurrentCumulativeCases;
  update caseofficers set OngoingCases=@CurrentOngoingCases+1,CumulativeCases=@CurrentCumulativeCases+1 where Username=@USER  ;

END//
DELIMITER ;

-- Dumping structure for table arcm.attendanceregister
DROP TABLE IF EXISTS `attendanceregister`;
CREATE TABLE IF NOT EXISTS `attendanceregister` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RegisterID` int(11) DEFAULT NULL,
  `IDNO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MobileNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Category` varchar(55) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.attendanceregister: ~2 rows (approximately)
/*!40000 ALTER TABLE `attendanceregister` DISABLE KEYS */;
INSERT INTO `attendanceregister` (`ID`, `RegisterID`, `IDNO`, `MobileNo`, `Name`, `Email`, `Category`, `Created_At`, `Created_By`) VALUES
	(1, 1, '1234555', '070555555', 'kimutai', 'elviskcheruiyot@gmail.com', 'PE', '2019-10-03 15:18:42', 'Admin'),
	(2, 1, '12345565', '0700002222', 'Margaret Mutinda', 'mutinda@gmail.com', 'PE', '2019-10-03 16:15:10', 'Admin');
/*!40000 ALTER TABLE `attendanceregister` ENABLE KEYS */;

-- Dumping structure for table arcm.audittrails
DROP TABLE IF EXISTS `audittrails`;
CREATE TABLE IF NOT EXISTS `audittrails` (
  `AuditID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Date` datetime NOT NULL,
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IpAddress` bigint(20) NOT NULL,
  PRIMARY KEY (`AuditID`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.audittrails: ~130 rows (approximately)
/*!40000 ALTER TABLE `audittrails` DISABLE KEYS */;
INSERT INTO `audittrails` (`AuditID`, `Date`, `Username`, `Description`, `Category`, `IpAddress`) VALUES
	(1, '2019-10-01 11:03:32', 'Admin', '591', 'Create', 0),
	(2, '2019-10-01 11:03:33', 'Admin', '591', 'Update', 0),
	(3, '2019-10-01 11:03:35', 'Admin', '591', 'Update', 0),
	(4, '2019-10-01 11:03:35', 'Admin', '591', 'Update', 0),
	(5, '2019-10-01 11:03:36', 'Admin', '591', 'Update', 0),
	(6, '2019-10-01 11:03:50', 'Admin', 'Updated  user access of role for user: Admin', 'Create', 0),
	(7, '2019-10-01 11:03:52', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(8, '2019-10-01 11:03:54', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(9, '2019-10-01 11:03:56', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(10, '2019-10-01 11:03:58', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(11, '2019-10-01 11:07:04', 'Applicant', 'Added new Tender with TenderNo:CGS/SCM/WENR/OT/18-19/081', 'Add', 0),
	(12, '2019-10-01 11:07:05', 'Applicant', 'Added new Application with ApplicationNo:ARCM-AP-50', 'Add', 0),
	(13, '2019-10-01 11:07:05', 'Applicant', '1', 'Add', 0),
	(14, '2019-10-01 11:07:05', 'Applicant', '1', 'Add', 0),
	(15, '2019-10-01 11:07:12', 'Applicant', 'Added new Ground/Request for Application:1', 'Add', 0),
	(16, '2019-10-01 11:07:21', 'Applicant', 'Added new Ground/Request for Application:1', 'Add', 0),
	(17, '2019-10-01 11:08:00', 'Admin', '0ARCM-AP-50', 'Approval', 0),
	(18, '2019-10-01 11:10:04', 'Testuser', 'PE-20', 'Add', 0),
	(19, '2019-10-01 11:10:05', 'Testuser', 'Updated PE Response for Response ID: 1', 'Add', 0),
	(20, '2019-10-01 11:12:53', 'Admin', '0Admin', 'Add', 0),
	(21, '2019-10-01 11:12:57', 'Admin', '0Admin2', 'Add', 0),
	(22, '2019-10-01 11:12:59', 'Admin', 'Submited PanelList  for Application: ARCM-AP-50', 'Add', 0),
	(23, '2019-10-01 11:13:07', 'Admin', '0Admin2', 'Approval', 0),
	(24, '2019-10-01 11:13:11', 'Admin', '0Admin', 'Approval', 0),
	(25, '2019-10-01 11:14:01', 'Admin', 'Booked Venue:5', 'Add', 0),
	(26, '2019-10-01 11:14:07', 'Admin', 'Generated hearing Notice for Application: ARCM-AP-50', 'Add', 0),
	(27, '2019-10-01 12:53:19', 'Admin', 'Uploaded hearing attachment for application:ARCM-AP-50', 'Add', 0),
	(28, '2019-10-01 13:16:28', 'Admin', 'Booked Venue:5', 'Add', 0),
	(29, '2019-10-01 13:16:33', 'Admin', 'Generated hearing Notice for Application: ARCM-AP-50', 'Add', 0),
	(30, '2019-10-01 13:16:50', 'Admin', 'Generated hearing Notice for Application: ARCM-AP-50', 'Add', 0),
	(31, '2019-10-01 13:19:46', 'Admin', 'Deleted hearing attachment:1569923599024-ELVIS KIMUTAI CV.pdf', 'Delete', 0),
	(32, '2019-10-01 13:20:05', 'Admin', 'Uploaded hearing attachment for application:ARCM-AP-50', 'Add', 0),
	(33, '2019-10-01 13:43:10', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(34, '2019-10-01 13:43:13', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(35, '2019-10-01 13:43:38', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(36, '2019-10-01 13:43:56', 'Admin', 'Updated  user access of role for user: Admin', 'Update', 0),
	(37, '2019-10-01 15:44:59', 'Admin', 'Uploaded hearing attachment for application:ARCM-AP-50', 'Add', 0),
	(38, '2019-10-02 11:05:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(39, '2019-10-02 11:05:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(40, '2019-10-02 11:05:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(41, '2019-10-02 11:05:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(42, '2019-10-02 11:05:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(43, '2019-10-02 11:05:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(44, '2019-10-02 11:05:36', 'Admin', 'Booked Venue:5', 'Add', 0),
	(45, '2019-10-02 11:05:36', 'Admin', 'Booked Venue:5', 'Add', 0),
	(46, '2019-10-02 11:05:36', 'Admin', 'Booked Venue:5', 'Add', 0),
	(47, '2019-10-02 11:05:36', 'Admin', 'Booked Venue:5', 'Add', 0),
	(48, '2019-10-02 11:17:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(49, '2019-10-02 11:17:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(50, '2019-10-02 11:17:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(51, '2019-10-02 11:17:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(52, '2019-10-02 11:17:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(53, '2019-10-02 11:17:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(54, '2019-10-02 11:17:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(55, '2019-10-02 11:17:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(56, '2019-10-02 11:17:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(57, '2019-10-02 11:17:35', 'Admin', 'Booked Venue:5', 'Add', 0),
	(58, '2019-10-02 12:08:55', 'Admin', 'Booked Venue:6', 'Add', 0),
	(59, '2019-10-02 12:09:32', 'Admin', 'Booked Venue:5', 'Add', 0),
	(60, '2019-10-02 12:09:37', 'Admin', 'Booked Venue:5', 'Add', 0),
	(61, '2019-10-02 12:09:42', 'Admin', 'Booked Venue:5', 'Add', 0),
	(62, '2019-10-02 12:09:42', 'Admin', 'Booked Venue:5', 'Add', 0),
	(63, '2019-10-02 12:09:42', 'Admin', 'Booked Venue:5', 'Add', 0),
	(64, '2019-10-02 12:09:42', 'Admin', 'Booked Venue:5', 'Add', 0),
	(65, '2019-10-02 12:09:42', 'Admin', 'Booked Venue:5', 'Add', 0),
	(66, '2019-10-02 15:05:21', 'Applicant', 'Added new Tender with TenderNo:CGS/SCM/WENR/OT/18-19/081', 'Add', 0),
	(67, '2019-10-02 15:05:22', 'Applicant', 'Added new Application with ApplicationNo:ARCM-AP-51', 'Add', 0),
	(68, '2019-10-02 15:05:22', 'Applicant', '2', 'Add', 0),
	(69, '2019-10-02 15:05:22', 'Applicant', '2', 'Add', 0),
	(70, '2019-10-02 15:05:36', 'Applicant', 'Added new Ground/Request for Application:2', 'Add', 0),
	(71, '2019-10-02 15:05:42', 'Applicant', 'Added new Ground/Request for Application:2', 'Add', 0),
	(72, '2019-10-02 15:06:52', 'Admin', '0ARCM-AP-51', 'Approval', 0),
	(73, '2019-10-02 15:10:01', 'TestUser', 'PE-20', 'Add', 0),
	(74, '2019-10-02 15:10:02', 'TestUser', 'Updated PE Response for Response ID: 2', 'Add', 0),
	(75, '2019-10-02 15:17:24', 'Applicant', 'Added new Tender with TenderNo:CGS/SCM/WENR/OT/18-19/081', 'Add', 0),
	(76, '2019-10-02 15:17:25', 'Applicant', 'Added new Application with ApplicationNo:ARCM-AP-52', 'Add', 0),
	(77, '2019-10-02 15:17:25', 'Applicant', '3', 'Add', 0),
	(78, '2019-10-02 15:17:25', 'Applicant', '3', 'Add', 0),
	(79, '2019-10-02 15:17:32', 'Applicant', 'Added new Ground/Request for Application:3', 'Add', 0),
	(80, '2019-10-02 15:18:42', 'Admin', '0Admin', 'Add', 0),
	(81, '2019-10-02 15:18:46', 'Admin', 'Submited PanelList  for Application: ARCM-AP-51', 'Add', 0),
	(82, '2019-10-02 15:19:10', 'Admin', '0ARCM-AP-52', 'Approval', 0),
	(83, '2019-10-02 15:23:28', 'TestUser', 'PE-20', 'Add', 0),
	(84, '2019-10-02 15:23:28', 'TestUser', 'Updated PE Response for Response ID: 3', 'Add', 0),
	(85, '2019-10-02 15:31:33', 'Applicant', 'Added new Tender with TenderNo:CGS/SCM/WENR/OT/18-19/081', 'Add', 0),
	(86, '2019-10-02 15:31:34', 'Applicant', 'Added new Application with ApplicationNo:ARCM-AP-53', 'Add', 0),
	(87, '2019-10-02 15:31:34', 'Applicant', '4', 'Add', 0),
	(88, '2019-10-02 15:31:34', 'Applicant', '4', 'Add', 0),
	(89, '2019-10-02 15:31:43', 'Applicant', 'Added new Ground/Request for Application:4', 'Add', 0),
	(90, '2019-10-02 15:33:00', 'Admin', '0ARCM-AP-53', 'Approval', 0),
	(91, '2019-10-02 15:34:16', 'TestUser', 'PE-20', 'Add', 0),
	(92, '2019-10-02 15:34:17', 'TestUser', 'Updated PE Response for Response ID: 4', 'Add', 0),
	(93, '2019-10-02 15:38:03', 'Admin', '0Admin', 'Add', 0),
	(94, '2019-10-02 15:38:10', 'Admin', 'Submited PanelList  for Application: ARCM-AP-52', 'Add', 0),
	(95, '2019-10-02 15:47:19', 'Admin', '0Admin', 'Add', 0),
	(96, '2019-10-02 15:47:22', 'Admin', 'Submited PanelList  for Application: ARCM-AP-53', 'Add', 0),
	(97, '2019-10-02 15:56:04', 'Admin', 'Booked Venue:5', 'Add', 0),
	(98, '2019-10-02 15:56:11', 'Admin', 'Generated hearing Notice for Application: ARCM-AP-50', 'Add', 0),
	(99, '2019-10-02 15:57:04', 'Admin', 'Generated hearing Notice for Application: ARCM-AP-50', 'Add', 0),
	(100, '2019-10-02 15:58:04', 'Admin', 'Booked Venue:5', 'Add', 0),
	(101, '2019-10-02 15:58:37', 'Admin', 'Booked Venue:4', 'Add', 0),
	(102, '2019-10-02 16:27:55', '1', 'Booked Venue:1', 'Add', 0),
	(103, '2019-10-02 16:35:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(104, '2019-10-02 16:35:54', 'Admin', 'Booked Venue:5', 'Add', 0),
	(105, '2019-10-02 16:44:27', 'Admin', 'Booked Venue:5', 'Add', 0),
	(106, '2019-10-02 16:44:36', 'Admin', 'Booked Venue:5', 'Add', 0),
	(107, '2019-10-02 16:44:42', 'Admin', 'Unbooked Booked Venue:5', 'Update', 0),
	(108, '2019-10-02 16:44:46', 'Admin', 'Booked Venue:5', 'Add', 0),
	(109, '2019-10-02 16:44:50', 'Admin', 'Booked Venue:5', 'Add', 0),
	(110, '2019-10-02 16:46:34', 'Admin', 'Unbooked Booked Venue:5', 'Update', 0),
	(111, '2019-10-02 16:46:47', 'Admin', 'Unbooked Booked Venue:5', 'Update', 0),
	(112, '2019-10-02 16:49:39', 'Admin', 'Booked Venue:6', 'Add', 0),
	(113, '2019-10-02 16:51:26', 'Admin', 'Booked Venue:6', 'Add', 0),
	(114, '2019-10-02 16:51:30', 'Admin', 'Booked Venue:6', 'Add', 0),
	(115, '2019-10-02 16:51:33', 'Admin', 'Booked Venue:6', 'Add', 0),
	(116, '2019-10-02 16:51:36', 'Admin', 'Booked Venue:6', 'Add', 0),
	(117, '2019-10-02 16:51:39', 'Admin', 'Booked Venue:6', 'Add', 0),
	(118, '2019-10-02 16:51:39', 'Admin', 'Booked Venue:6', 'Add', 0),
	(119, '2019-10-02 16:51:40', 'Admin', 'Booked Venue:6', 'Add', 0),
	(120, '2019-10-02 16:51:40', 'Admin', 'Booked Venue:6', 'Add', 0),
	(121, '2019-10-02 16:51:40', 'Admin', 'Booked Venue:6', 'Add', 0),
	(122, '2019-10-02 16:53:09', 'Admin', 'Booked Venue:4', 'Add', 0),
	(123, '2019-10-03 14:32:02', 'Admin', 'Registered hearing for Application:ARCM-AP-50', 'Add', 0),
	(124, '2019-10-03 15:18:42', 'Admin', 'Attended hearing for Application:ARCM-AP-50', 'Add', 0),
	(125, '2019-10-03 16:15:10', 'Admin', 'Attended hearing for Application:ARCM-AP-50', 'Add', 0),
	(126, '2019-10-04 09:45:06', 'Admin', 'Updated  PEType: PET-4', 'Update', 0),
	(127, '2019-10-04 09:47:39', 'Admin', 'Updated procurementmethod: PROGM-4', 'Update', 0),
	(128, '2019-10-04 09:49:43', 'Admin', 'Updated stdtenderdoc: STDOC-1', 'Update', 0),
	(129, '2019-10-04 09:51:37', 'Admin', 'Updated  committeetypes: COMT-2', 'Update', 0),
	(130, '2019-10-04 10:00:03', 'Admin', 'Updated  FeeStructure: CH-1', 'Update', 0),
	(131, '2019-10-04 10:03:39', 'Admin', 'Updated  tendertype: TTYP-2', 'Update', 0),
	(132, '2019-10-04 10:07:32', 'Admin', 'Updated  county: 002', 'Update', 0),
	(133, '2019-10-04 10:13:26', 'Admin', 'Updated  Venue with ID: 4', 'Update', 0),
	(134, '2019-10-04 10:27:44', 'Admin', 'Updated Role with iD: 17and name:System Users', 'Update', 0);
/*!40000 ALTER TABLE `audittrails` ENABLE KEYS */;

-- Dumping structure for procedure arcm.BookVenue
DROP PROCEDURE IF EXISTS `BookVenue`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookVenue`(IN _VenueID INT(11),IN _Date DATETIME,IN _Slot VARCHAR(50),IN _UserID varchar(50),IN _Content VARCHAR(255))
BEGIN
  DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Booked Venue:',_VenueID); 
 
      INSERT INTO venuebookings( VenueID ,Date ,Slot , Booked_By,Content, Booked_On,Deleted)
    VALUES(_VenueID,_Date,_Slot,_UserID,_Content,now(),0);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
  update applications set Status='HEARING IN PROGRESS' where ApplicationNo=_Content;

END//
DELIMITER ;

-- Dumping structure for table arcm.branches
DROP TABLE IF EXISTS `branches`;
CREATE TABLE IF NOT EXISTS `branches` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2730;

-- Dumping data for table arcm.branches: ~3 rows (approximately)
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` (`ID`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(12, 'Mombasa', '2019-09-18 10:25:17', 'Admin', '2019-09-18 10:25:17', 'Admin', 0, NULL),
	(13, 'Head office,National bank Building', '2019-09-18 10:25:26', 'Admin', '2019-09-18 10:25:44', 'Admin', 1, 'Admin'),
	(14, 'Kisumu', '2019-09-18 10:29:11', 'Admin', '2019-09-18 10:29:11', 'Admin', 0, NULL),
	(15, 'Head office', '2019-09-18 10:29:21', 'Admin', '2019-09-18 10:29:21', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;

-- Dumping structure for table arcm.casedetails
DROP TABLE IF EXISTS `casedetails`;
CREATE TABLE IF NOT EXISTS `casedetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateAsigned` datetime NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PrimaryOfficer` tinyint(1) NOT NULL,
  `ReassignedTo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateReasigned` datetime DEFAULT NULL,
  `Reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casedetails: ~3 rows (approximately)
/*!40000 ALTER TABLE `casedetails` DISABLE KEYS */;
INSERT INTO `casedetails` (`ID`, `UserName`, `ApplicationNo`, `DateAsigned`, `Status`, `PrimaryOfficer`, `ReassignedTo`, `DateReasigned`, `Reason`, `Created_At`, `Created_By`, `Updated_By`, `Deleted_At`, `Deleted`) VALUES
	(1, 'Admin2', 'ARCM-AP-50', '2019-10-01 11:08:00', 'Open', 1, NULL, NULL, NULL, '2019-10-01 11:08:00', 'Admin', NULL, NULL, 0),
	(2, 'Admin', 'ARCM-AP-51', '2019-10-02 15:06:52', 'Open', 1, NULL, NULL, NULL, '2019-10-02 15:06:52', 'Admin', NULL, NULL, 0),
	(3, 'Admin2', 'ARCM-AP-52', '2019-10-02 15:19:10', 'Open', 1, NULL, NULL, NULL, '2019-10-02 15:19:10', 'Admin', NULL, NULL, 0),
	(4, 'Admin', 'ARCM-AP-53', '2019-10-02 15:33:00', 'Open', 1, NULL, NULL, NULL, '2019-10-02 15:33:00', 'Admin', NULL, NULL, 0);
/*!40000 ALTER TABLE `casedetails` ENABLE KEYS */;

-- Dumping structure for table arcm.caseofficers
DROP TABLE IF EXISTS `caseofficers`;
CREATE TABLE IF NOT EXISTS `caseofficers` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MinValue` float NOT NULL,
  `MaximumValue` float NOT NULL,
  `Active` tinyint(1) DEFAULT NULL,
  `NotAvailableFrom` datetime DEFAULT NULL,
  `NotAvailableTo` datetime DEFAULT NULL,
  `OngoingCases` int(11) DEFAULT NULL,
  `CumulativeCases` int(11) DEFAULT NULL,
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `DeletedBY` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.caseofficers: ~2 rows (approximately)
/*!40000 ALTER TABLE `caseofficers` DISABLE KEYS */;
INSERT INTO `caseofficers` (`ID`, `Username`, `MinValue`, `MaximumValue`, `Active`, `NotAvailableFrom`, `NotAvailableTo`, `OngoingCases`, `CumulativeCases`, `Create_at`, `Update_at`, `CreatedBy`, `UpdatedBy`, `Deleted`, `DeletedBY`, `Deleted_At`) VALUES
	(1, 'Admin', 1, 100000000, 1, '2019-09-06 00:00:00', '2019-09-06 00:00:00', 29, 19, '2019-09-13 17:05:06', '2019-09-13 17:05:12', 'Admin', 'Admin', 0, NULL, NULL),
	(3, 'Admin2', 1, 10000000000, 1, '2019-09-14 00:00:00', '2019-09-21 00:00:00', 28, 6, '2019-09-14 14:03:14', NULL, 'Admin', NULL, 0, NULL, NULL);
/*!40000 ALTER TABLE `caseofficers` ENABLE KEYS */;

-- Dumping structure for table arcm.casesittingsregister
DROP TABLE IF EXISTS `casesittingsregister`;
CREATE TABLE IF NOT EXISTS `casesittingsregister` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VenueID` int(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `SittingNo` int(11) DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casesittingsregister: ~0 rows (approximately)
/*!40000 ALTER TABLE `casesittingsregister` DISABLE KEYS */;
INSERT INTO `casesittingsregister` (`ID`, `ApplicationNo`, `VenueID`, `Date`, `SittingNo`, `Created_At`, `Created_By`) VALUES
	(1, 'ARCM-AP-50', 5, '2019-10-03', 1, '2019-10-03 14:32:02', 'Admin');
/*!40000 ALTER TABLE `casesittingsregister` ENABLE KEYS */;

-- Dumping structure for table arcm.casewithdrawal
DROP TABLE IF EXISTS `casewithdrawal`;
CREATE TABLE IF NOT EXISTS `casewithdrawal` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime NOT NULL,
  `Applicant` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DecisionDate` date DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `RejectionReason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Frivolous` tinyint(1) DEFAULT NULL,
  `Created_At` date NOT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawal: ~0 rows (approximately)
/*!40000 ALTER TABLE `casewithdrawal` DISABLE KEYS */;
/*!40000 ALTER TABLE `casewithdrawal` ENABLE KEYS */;

-- Dumping structure for table arcm.casewithdrawalcontacts
DROP TABLE IF EXISTS `casewithdrawalcontacts`;
CREATE TABLE IF NOT EXISTS `casewithdrawalcontacts` (
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawalcontacts: ~5 rows (approximately)
/*!40000 ALTER TABLE `casewithdrawalcontacts` DISABLE KEYS */;
INSERT INTO `casewithdrawalcontacts` (`Name`, `Email`, `Mobile`) VALUES
	('Admin2', 'elviskimcheruiyot@gmail.com', '07221145671'),
	('Test User', 'ekimutai810@gmail.com', '07087654322456'),
	('MINISTRY OF EDUCATION', 'elviskimcheruiyot@gmail.com', '0705555285'),
	('Applicant', 'margaret.mutinda@gmail.com', '0722114567'),
	('Wilcom Systems ', 'admin@admin.com', '0705555285');
/*!40000 ALTER TABLE `casewithdrawalcontacts` ENABLE KEYS */;

-- Dumping structure for table arcm.committeetypes
DROP TABLE IF EXISTS `committeetypes`;
CREATE TABLE IF NOT EXISTS `committeetypes` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.committeetypes: ~6 rows (approximately)
/*!40000 ALTER TABLE `committeetypes` DISABLE KEYS */;
INSERT INTO `committeetypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(6, 'COMT-1', 'Tender Opening Committee Updated', '2019-08-01 10:23:03', 'Admin', '2019-08-01 10:23:42', 'Admin', 1, 'Admin'),
	(7, 'COMT-2', 'Disposal Committee', '2019-08-01 11:10:39', 'Admin', '2019-10-04 09:51:37', 'Admin', 0, NULL),
	(8, 'COMT-3', 'Disposal Committee', '2019-08-01 11:11:30', 'Admin', '2019-08-01 11:11:30', 'Admin', 1, 'Admin'),
	(9, 'COMT-4', 'Accounting Officer', '2019-08-01 11:11:47', 'Admin', '2019-08-27 17:40:15', 'Admin', 0, NULL),
	(10, 'COMT-5', 'Special committees', '2019-08-08 12:30:36', 'Admin', '2019-08-08 12:30:36', 'Admin', 0, NULL),
	(11, 'COMT-6', 'Test', '2019-08-27 17:35:10', 'Admin', '2019-08-27 17:40:18', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `committeetypes` ENABLE KEYS */;

-- Dumping structure for table arcm.configurations
DROP TABLE IF EXISTS `configurations`;
CREATE TABLE IF NOT EXISTS `configurations` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PhysicalAdress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PoBox` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostalCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Telephone1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Telephone2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fax` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Website` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PIN` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Logo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NextPE` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextComm` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextSupplier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1',
  `NextMember` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextProcMeth` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextStdDoc` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextApplication` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextRev` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Deleted` tinyint(4) NOT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NextPEType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextMemberType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextFeeCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `NextTenderType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  PRIMARY KEY (`ID`,`Code`),
  KEY `Configurations_Users` (`Deleted_By`),
  KEY `Configurations_Updateduser` (`Updated_By`),
  KEY `Configurations_createduser` (`Created_By`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.configurations: ~1 rows (approximately)
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` (`ID`, `Code`, `Name`, `PhysicalAdress`, `Street`, `PoBox`, `PostalCode`, `Town`, `Telephone1`, `Telephone2`, `Mobile`, `Fax`, `Email`, `Website`, `PIN`, `Logo`, `NextPE`, `NextComm`, `NextSupplier`, `NextMember`, `NextProcMeth`, `NextStdDoc`, `NextApplication`, `NextRev`, `Created_At`, `Updated_At`, `Created_By`, `Updated_By`, `Deleted`, `Deleted_By`, `NextPEType`, `NextMemberType`, `NextFeeCode`, `NextTenderType`) VALUES
	(3, 'PPARB', 'PUBLIC PROCUREMENT ADMINISTRATIVE REVIEW BOARD', 'National Bank Building', 'Harambee Avenue', '58535', '00200', 'Nairobi', '0203244241', '0203244241', '0724562264', 'fax', 'elviskcheruiyot@gmail.com', 'https://www.ppra.go.ke', '123456789098', '1566637813760-logo-site.png', '4', '7', '12', '1', '6', '4', '54', '1', '2019-07-29 14:14:38', '2019-08-27 17:43:55', 'Admin', 'Admin', 0, ' ', '7', '3', '3', '6');
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;

-- Dumping structure for table arcm.counties
DROP TABLE IF EXISTS `counties`;
CREATE TABLE IF NOT EXISTS `counties` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.counties: ~47 rows (approximately)
/*!40000 ALTER TABLE `counties` DISABLE KEYS */;
INSERT INTO `counties` (`ID`, `Code`, `Name`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(1, '001', 'MOMBASA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(2, '002', 'KWALE', '0000-00-00 00:00:00', 'Admin', '2019-10-04 10:07:32', 'Admin', 0, 'Admin'),
	(3, '003', 'KILIFI', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(4, '004', 'TANARIVER', '0000-00-00 00:00:00', 'Admin', '2019-08-27 17:17:05', 'Admin', 0, 'Admin'),
	(5, '005', 'LAMU', '0000-00-00 00:00:00', 'Admin', '2019-08-27 17:11:58', NULL, 0, 'Admin'),
	(6, '006', 'TAITA TAVETA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(7, '007', 'GARISSA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(8, '008', 'WAJIR', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(9, '009', 'MANDERA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(10, '010', 'MARSABIT', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(11, '011', 'ISIOLO', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(12, '012', 'MERU', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(13, '013', 'THARAKA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(14, '014', 'EMBU', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(15, '015', 'KITUI', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(16, '016', 'MACHAKOS', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(17, '017', 'MAKUENI', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(18, '018', 'NYANDARUA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(19, '019', 'NYERI', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(20, '020', 'KIRINYAGA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(21, '021', 'MURANGA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(22, '022', 'KIAMBU', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(23, '023', 'TURKANA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(24, '024', 'WEST POKOT', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(25, '025', 'SAMBURU', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(26, '026', 'TRANS-NZOIA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(27, '027', 'UASIN GISHU', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(28, '028', 'ELGEYO MARAKWET', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(29, '029', 'NANDI', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(30, '030', 'BARINGO', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(31, '031', 'LAIKIPIA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(32, '032', 'NAKURU', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(33, '033', 'NAROK', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(34, '034', 'KAJIADO', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(35, '035', 'BOMET', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(36, '036', 'KERICHO', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(37, '037', 'KAKAMEGA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(38, '038', 'VIHIGA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(39, '039', 'BUNGOMA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(40, '040', 'BUSIA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(41, '041', 'SIAYA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(42, '042', 'KISUMU', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(43, '043', 'HOMA BAY', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(44, '044', 'MIGORI', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(45, '045', 'KISII', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(46, '046', 'NYAMIRA', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin'),
	(47, '047', 'NAIROBI', '0000-00-00 00:00:00', 'Admin', '0000-00-00 00:00:00', 'Admin', 0, 'Admin');
/*!40000 ALTER TABLE `counties` ENABLE KEYS */;

-- Dumping structure for table arcm.deadlineapprovalworkflow
DROP TABLE IF EXISTS `deadlineapprovalworkflow`;
CREATE TABLE IF NOT EXISTS `deadlineapprovalworkflow` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reason` text COLLATE utf8mb4_unicode_ci,
  `RequestedDate` datetime DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Approved_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.deadlineapprovalworkflow: ~0 rows (approximately)
/*!40000 ALTER TABLE `deadlineapprovalworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `deadlineapprovalworkflow` ENABLE KEYS */;

-- Dumping structure for procedure arcm.DeclineApplication
DROP PROCEDURE IF EXISTS `DeclineApplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeclineApplication`(IN _Approver VARCHAR(50),IN _ApplicationNo varchar(50),IN _Remarks varchar(255))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT(_Approver +' Declined Application: ',_ApplicationNo); 
UPDATE applications_approval_workflow
SET Status='Declined',Approved_At=now(),Remarks=_Remarks
WHERE Approver=_Approver and ApplicationNo=_ApplicationNo;
update applications set Status='DECLINED' where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
  call ResolveMyNotification(_Approver,'Applications Approval');
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeclinecaseAdjournment
DROP PROCEDURE IF EXISTS `DeclinecaseAdjournment`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeclinecaseAdjournment`(IN _ApplicationNo VARCHAR(50), IN _ApprovalRemarks VARCHAR(255), IN _userID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Declined Case Adjournment for Application : ', _ApplicationNo); 
Update adjournment set  DecisionDate= now(), Status='Declined', ApprovalRemarks =_ApprovalRemarks where ApplicationNo=_ApplicationNo;

  call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
  call ResolveMyNotification(_userID,'Case Adjournment Approval');
  DROP TABLE IF EXISTS caseWithdrawalContacts;
  create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50));
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from panels where ApplicationNo=_ApplicationNo and Status='Approved' ) ;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from casedetails where  ApplicationNo=_ApplicationNo and Deleted=0);

  select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from peusers where PEID=@PEID);
  insert into caseWithdrawalContacts select Name,Email,Mobile from procuremententity where PEID=@PEID;
  select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username =@Applicant;
  select ApplicantID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
  insert into caseWithdrawalContacts select Name,Email,Mobile from applicants where  ID=@ApplicantID;
 select * from caseWithdrawalContacts;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeclinecaseWithdrawal
DROP PROCEDURE IF EXISTS `DeclinecaseWithdrawal`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeclinecaseWithdrawal`(IN _ApplicationNo varchar(50), IN _RejectionReason VARCHAR(255),IN _userID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Declined Case Withdrawal for Application : ', _ApplicationNo); 
Update casewithdrawal set  DecisionDate= now(), Status='Declined', RejectionReason =_RejectionReason,Frivolous =0 where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );

  DROP TABLE IF EXISTS caseWithdrawalContacts;
  create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50));
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from panels where ApplicationNo=_ApplicationNo and Status='Approved' ) ;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from casedetails where  ApplicationNo=_ApplicationNo and Deleted=0);

  select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
 insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from peusers where PEID=@PEID);
  insert into caseWithdrawalContacts select Name,Email,Mobile from procuremententity where PEID=@PEID;
  select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username =@Applicant;
  select ApplicantID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
  insert into caseWithdrawalContacts select Name,Email,Mobile from applicants where  ID=@ApplicantID;
  select Name,Email,Mobile,_RejectionReason as reason from caseWithdrawalContacts;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeclineDeadlineRequestExtension
DROP PROCEDURE IF EXISTS `DeclineDeadlineRequestExtension`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeclineDeadlineRequestExtension`(IN _Approver VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _Remarks VARCHAR(255))
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT(_Approver +' Declined Deadline Extension Request for Application:',_ApplicationNo); 
UPDATE deadlineapprovalworkflow
SET Status='DECLINED',Approved_At=now(),Remarks=_Remarks
WHERE Approver=_Approver and ApplicationNo=_ApplicationNo;

		UPDATE deadlineapprovalworkflow SET Status='DECLINED',Approved_At=now(),Remarks=_Remarks
		WHERE Approver=_Approver and ApplicationNo=_ApplicationNo ; 
    update pedeadlineextensionsrequests SET Status='DECLINED'
		WHERE ApplicationNo=_ApplicationNo ;
	call ResolveMyNotification(_Approver,'Deadline Approval');
 call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
  select PEID from deadlineapprovalworkflow WHERE Approver=_Approver and ApplicationNo=_ApplicationNo LIMIT 1 INTO @PEID;
  SELECT DueOn FROM  peresponsetimer  where ApplicationNo=_ApplicationNo AND PEID=@PEID LIMIT 1 into @requestedDeadline;
  select Name,Email,Mobile,@requestedDeadline as NewDeadline, 'DECLINED' as msg,_Remarks as Reason from procuremententity where PEID=@PEID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeletBranch
DROP PROCEDURE IF EXISTS `DeletBranch`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeletBranch`(IN _ID Int ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Branch with iD:',_ID); 
UPDATE branches SET Deleted=1,Deleted_By=_UserID  WHERE ID=_ID;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletcommitteetypes
DROP PROCEDURE IF EXISTS `Deletcommitteetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletcommitteetypes`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted committeetypes with iD:',_Code); 
UPDATE committeetypes SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteadjournmentDocuments
DROP PROCEDURE IF EXISTS `DeleteadjournmentDocuments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteadjournmentDocuments`(IN _File VARCHAR(50),IN _UserID varchar(50))
BEGIN

DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Removed adjournment document:',_File); 

Update adjournmentdocuments set Deleted=1 where Filename=_file;
 call SaveAuditTrail(_UserID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteApplicant
DROP PROCEDURE IF EXISTS `DeleteApplicant`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteApplicant`(IN _PEID VARCHAR(50),IN _UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Deleted Applicant with ID: ',_PEID); 
UPDATE  applicants SET Deleted=1 ,Deleted_At=now(),Deleted_By=_UserID
WHERE  applicants.ApplicantCode=_PEID;
call SaveAuditTrail(_UserID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteApplication
DROP PROCEDURE IF EXISTS `DeleteApplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteApplication`(IN  _ApplicationNo varchar(50),IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Application :',_ApplicationNo); 

Update applications SET Deleted=1,  Deleted_At=now(),Deleted_By=_userID
WHERE ApplicationNo=_ApplicationNo;

call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteApprover
DROP PROCEDURE IF EXISTS `DeleteApprover`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteApprover`(IN `_Username` VARCHAR(50),IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Approver: '+ _Username ); 
Update approvers set Deleted=1, Deleted_At=now(),DeletedBY=_UserID
where Username=_Username;
call SaveAuditTrail(_userID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteAttachments
DROP PROCEDURE IF EXISTS `DeleteAttachments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAttachments`(IN _Name VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
  DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted hearing attachment:',_Name); 
Update hearingattachments set Deleted=1,DeletedBy=_UserID where Name=_Name;
  call SaveAuditTrail(_UserID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteCaseOfficers
DROP PROCEDURE IF EXISTS `DeleteCaseOfficers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCaseOfficers`(IN _Username VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Case Officer: ',_Username); 
UPDATE `caseofficers` SET `Deleted`=1,DeletedBY=_UserID,Deleted_At=now() WHERE Username=_Username;
  call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteConfigurations
DROP PROCEDURE IF EXISTS `DeleteConfigurations`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteConfigurations`(IN _UserID varchar(50),IN _Code varchar(50))
BEGIN
UPDATE `configurations` SET `Deleted`=1,`Deleted_By`=_UserID WHERE Code=_Code;
	


END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletecounty
DROP PROCEDURE IF EXISTS `Deletecounty`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletecounty`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted county with CODE:',_Code); 
UPDATE counties SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteDocument
DROP PROCEDURE IF EXISTS `DeleteDocument`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteDocument`(IN _Name VARCHAR(100),IN _UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Deleted Document with name: ',_Name); 
UPDATE  applicationdocuments SET Deleted=1 ,Deleted_At=now(),Deleted_By=_UserID
WHERE  FileName=_Name;
call SaveAuditTrail(_UserID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletefinancialyear
DROP PROCEDURE IF EXISTS `Deletefinancialyear`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletefinancialyear`(IN `_Code` BIGINT,IN _UserID VARCHAR(50))
    NO SQL
BEGIN
Update financialyear set Deleted=1,Deleted_By=_UserID,Deleted_At=now()
WHERE Code=_Code;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletegroundsandrequestedorders
DROP PROCEDURE IF EXISTS `Deletegroundsandrequestedorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletegroundsandrequestedorders`(IN _ApplicationID BIGINT, IN _EntryType VARCHAR(200),IN _Description varchar(500), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Ground/Request for Application:',_ApplicationID); 
UPDATE groundsandrequestedorders SET
Deleted=1,Deleted_By=_userID, Deleted_At=now()
WHERE ApplicationID=_ApplicationID and Description=_Description and EntryType=_EntryType ;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.DeletePE
DROP PROCEDURE IF EXISTS `DeletePE`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeletePE`(IN _PEID VARCHAR(50),IN _UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Deleted Procurement Entity: ',_PEID); 
UPDATE  procuremententity SET Deleted=1 ,Deleted_At=now(),Deleted_By=_UserID
WHERE  procuremententity.PEID=_PEID;
call SaveAuditTrail(_UserID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeletePEResponseDocument
DROP PROCEDURE IF EXISTS `DeletePEResponseDocument`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePEResponseDocument`(IN _name VARCHAR(150), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Deleted PE Response Document : ',_name); 
update peresponsedocuments set Deleted=1 where Name=_name;
  call SaveAuditTrail(_UserID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteRole
DROP PROCEDURE IF EXISTS `DeleteRole`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteRole`(IN `_RoleID` BIGINT, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Role with iD: ', _RoleID); 
UPDATE roles set deleted=1 WHERE RoleID=_RoleID;

call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteTender
DROP PROCEDURE IF EXISTS `DeleteTender`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteTender`(IN _ID BIGINT,IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Tender with ID:',_ID); 
Update tenders
set Deleted=1, Deleted_At=now(),  Deleted_By=_userID
WHERE ID=_ID;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletetenderaddendums
DROP PROCEDURE IF EXISTS `Deletetenderaddendums`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletetenderaddendums`(IN _AdendumNo varchar(100),  IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Tender Addendum ID:',_AdendumNo); 
Update tenderaddendums SET
Deleted=1, Deleted_At=now(), Deleted_By=_userID
WHERE AdendumNo=_AdendumNo;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deleteuser
DROP PROCEDURE IF EXISTS `Deleteuser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Deleteuser`(IN `_UserName` VARCHAR(50), IN `_UserID` VARCHAR(20))
    NO SQL
BEGIN

DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted User with Username: ', _UserName); 

UPDATE users set deleted=1 WHERE Username=_Username;
call SaveAuditTrail(_UserID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteuserGroup
DROP PROCEDURE IF EXISTS `DeleteuserGroup`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteuserGroup`(IN `_UserGroupID` BIGINT, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted UserGroup with iD:',_UserGroupID); 
UPDATE usergroups set deleted=1 WHERE UserGroupID=_UserGroupID;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletevenues
DROP PROCEDURE IF EXISTS `Deletevenues`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Deletevenues`(IN _ID int,IN _UserID varchar(50))
BEGIN
  DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Deleted  Venue with ID: ', _ID); 
  Update venues set Deleted=1  where ID=_ID;
  
  call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletfeesstructure
DROP PROCEDURE IF EXISTS `Deletfeesstructure`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletfeesstructure`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted feesstructure with iD:',_Code); 
UPDATE feesstructure SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletmembertypes
DROP PROCEDURE IF EXISTS `Deletmembertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletmembertypes`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted membertype with iD:',_Code); 
UPDATE membertypes SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletpetypes
DROP PROCEDURE IF EXISTS `Deletpetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletpetypes`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted petypes with iD:',_Code); 
UPDATE petypes SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletprocurementmethod
DROP PROCEDURE IF EXISTS `Deletprocurementmethod`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletprocurementmethod`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted procurementmethod with ID:',_Code); 
UPDATE procurementmethods SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletstdtenderdocs
DROP PROCEDURE IF EXISTS `Deletstdtenderdocs`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletstdtenderdocs`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted stdtenderdocs with iD:',_Code); 
UPDATE stdtenderdocs SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Delettendertypes
DROP PROCEDURE IF EXISTS `Delettendertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Delettendertypes`(IN _Code VARCHAR(50) ,_UserID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted tendertype with iD:',_Code); 
UPDATE tendertypes SET Deleted=1,Deleted_By=_UserID  WHERE Code=_Code;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.EmailVerification
DROP PROCEDURE IF EXISTS `EmailVerification`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `EmailVerification`(IN _Code VARCHAR(100),IN _UserName VARCHAR(50))
    NO SQL
BEGIN
if(SELECT count(*)  FROM users WHERE Username = _UserName AND ActivationCode = _Code)>0 THEN

Begin
	UPDATE users set IsEmailverified=1,IsActive=1 WHERE Username = _UserName AND ActivationCode = _Code;
	Select 'Email Verified' as msg;
END;
ELSE 
BEGIN
 Select 'User does not exist or wrong activation code' as msg;
END;
END IF;

END//
DELIMITER ;

-- Dumping structure for table arcm.feesstructure
DROP TABLE IF EXISTS `feesstructure`;
CREATE TABLE IF NOT EXISTS `feesstructure` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MinAmount` float DEFAULT NULL,
  `MaxAmount` float DEFAULT NULL,
  `Rate1` float DEFAULT NULL,
  `Rate2` float DEFAULT NULL,
  `MinFee` float DEFAULT NULL,
  `MaxFee` float DEFAULT NULL,
  `FixedFee` tinyint(1) DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.feesstructure: ~3 rows (approximately)
/*!40000 ALTER TABLE `feesstructure` DISABLE KEYS */;
INSERT INTO `feesstructure` (`ID`, `Code`, `Description`, `MinAmount`, `MaxAmount`, `Rate1`, `Rate2`, `MinFee`, `MaxFee`, `FixedFee`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(10, '100.20', 'Desc', 100000, 100.2, 5, 100.2, 100.2, 100.2, 1, '2019-08-05 14:23:12', 'Admin', '2019-08-05 14:36:10', 'Admin', 1, 'Admin'),
	(11, 'CH-1', 'Administrative Fee', 0, 100000, 1, 12, 5000, 20000, 0, '2019-08-05 15:51:46', 'Admin', '2019-10-04 10:00:02', 'Admin', 0, NULL),
	(12, 'CH-2', 'Does Not Exceed 2M', 0, 2000000, 1.5, 0.5, 0, 20000, 0, '2019-08-05 15:58:56', 'Admin', '2019-08-05 15:59:11', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `feesstructure` ENABLE KEYS */;

-- Dumping structure for table arcm.financialyear
DROP TABLE IF EXISTS `financialyear`;
CREATE TABLE IF NOT EXISTS `financialyear` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` int(11) NOT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `IsCurrentYear` tinyint(1) DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(0) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`),
  KEY `financialyear_ibfk_1` (`Created_By`),
  KEY `financialyear_ibfk_2` (`Updated_By`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.financialyear: ~3 rows (approximately)
/*!40000 ALTER TABLE `financialyear` DISABLE KEYS */;
INSERT INTO `financialyear` (`ID`, `Code`, `StartDate`, `EndDate`, `IsCurrentYear`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`) VALUES
	(1, 2019, '2019-01-01 00:00:00', '2019-12-31 00:00:00', 0, 'Admin', '2019-08-06 12:11:28', '2019-10-04 09:54:28', '', 0, NULL, NULL),
	(2, 2020, '2019-08-01 00:00:00', '2020-07-31 00:00:00', 0, 'Admin', '2019-08-06 12:11:55', '2019-08-27 17:13:02', '', 0, NULL, NULL),
	(3, 2021, '2019-08-02 00:00:00', '2020-07-31 00:00:00', 1, 'Admin', '2019-08-06 12:12:10', '2019-08-06 12:18:23', '', 0, NULL, NULL);
/*!40000 ALTER TABLE `financialyear` ENABLE KEYS */;

-- Dumping structure for function arcm.FindCaseOfficer
DROP FUNCTION IF EXISTS `FindCaseOfficer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `FindCaseOfficer`(_ApplicationNo Varchar(50)) RETURNS varchar(50) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    DETERMINISTIC
BEGIN
DECLARE TenderID int;
DECLARE TenderValue FLOAT;
DECLARE USER varchar(50);

set TenderID=(select TenderID from applications WHERE ApplicationNo=_Applicationno LIMIT 1);
set TenderValue= (select TenderValue from tenders where ID=TenderID Limit 1);
set USER= (select Username from caseofficers where MinValue<=TenderValue and  `MaxValue`>=TenderValue and  NOW() NOT  BETWEEN NotAvailableFrom and NotAvailableTo LIMIT 1);

RETURN USER;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAdjournmentDocuments
DROP PROCEDURE IF EXISTS `GetAdjournmentDocuments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAdjournmentDocuments`(IN _ApplicationNo VARCHAR(50))
BEGIN
select  ApplicationNo, Description,Path ,Filename from adjournmentdocuments where Deleted=0 and ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetadjournmentPendingApproval
DROP PROCEDURE IF EXISTS `GetadjournmentPendingApproval`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetadjournmentPendingApproval`(IN _UserID VARCHAR(50))
BEGIN
select * from adjournment where Approver=_UserID and Status='Pending Approval';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllCaseDetails
DROP PROCEDURE IF EXISTS `GetAllCaseDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCaseDetails`()
BEGIN
SELECT DISTINCT casedetails.UserName,users.Name, casedetails.ApplicationNo, casedetails.DateAsigned, casedetails.Status, casedetails.PrimaryOfficer, casedetails.ReassignedTo,
  casedetails.DateReasigned, casedetails.Reason
  FROM casedetails inner join users on users.Username =casedetails.UserName WHERE casedetails.Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllCaseOfficers
DROP PROCEDURE IF EXISTS `GetAllCaseOfficers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCaseOfficers`()
BEGIN
SELECT caseofficers.ID, caseofficers.Username,users.Name, `MinValue`, MaximumValue , caseofficers.Active, `NotAvailableFrom`, `NotAvailableTo`, `OngoingCases`, `CumulativeCases`, caseofficers.Create_at FROM `caseofficers`
  inner join users on users.Username=caseofficers.Username WHERE  caseofficers.Deleted=0 order by caseofficers.OngoingCases ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllfeesstructures
DROP PROCEDURE IF EXISTS `GetAllfeesstructures`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetAllfeesstructures`()
    NO SQL
BEGIN


SELECT * from feesstructure WHERE  Deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllgroundsandrequestedorders
DROP PROCEDURE IF EXISTS `GetAllgroundsandrequestedorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetAllgroundsandrequestedorders`()
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
Select * FROM groundsandrequestedorders
WHERE Deleted=0 ;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllHearingInProgressApplications
DROP PROCEDURE IF EXISTS `GetAllHearingInProgressApplications`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllHearingInProgressApplications`()
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  WHERE applications.Deleted=0 and applications.Status='HEARING IN PROGRESS' ORDER by applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAllPEResponse
DROP PROCEDURE IF EXISTS `getAllPEResponse`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllPEResponse`()
BEGIN

select peresponse.ID as ResponseID, peresponse.ApplicationNo,peresponse.ResponseType,peresponse.ResponseDate,tenders.TenderNo,tenders.Name ,tenders.TenderValue as TenderValue
  ,applications.Created_By as Applicantusername from peresponse 
  
  inner join applications on applications.ApplicationNo=peresponse.ApplicationNo 
   inner join tenders on applications.TenderID=tenders.ID
  order by peresponse.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAlltenderaddendums
DROP PROCEDURE IF EXISTS `GetAlltenderaddendums`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetAlltenderaddendums`()
    NO SQL
BEGIN

SELECT * FROM tenderaddendums WHERE Deleted=0 ;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllTenders
DROP PROCEDURE IF EXISTS `GetAllTenders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetAllTenders`()
    NO SQL
BEGIN

SELECT * FROM tenders WHERE Deleted=0 ;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllVenueBookings
DROP PROCEDURE IF EXISTS `GetAllVenueBookings`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllVenueBookings`()
BEGIN
select ID,VenueID,DATE_FORMAT(Date, "%Y-%m-%d") as Date ,Slot,Booked_By,Content,Booked_On from venuebookings where Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllvenues
DROP PROCEDURE IF EXISTS `GetAllvenues`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllvenues`()
BEGIN
 
  Select Venues.ID,Branches.Description as Branch,  Venues.Name,Venues.Description from Venues inner join Branches on Branches.ID=Venues.Branch where Venues.deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicantPerApplicationno
DROP PROCEDURE IF EXISTS `GetApplicantPerApplicationno`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicantPerApplicationno`(IN _ApplicationNo VARCHAR(50))
BEGIN
select ApplicantID from applications where ApplicationNo=_ApplicationNo limit 1 into @ApplicantID;
  
  SELECT applicants.ID ,applicants.ApplicantCode, applicants.Name, applicants.Location, applicants.POBox, applicants.PostalCode, applicants.Town, applicants.Mobile, applicants.Telephone, applicants.Email, applicants.Logo, applicants.Website ,applicants.County as CountyCode,counties.`Name` as County,RegistrationDate,PIN,RegistrationNo FROM `applicants` 
inner join counties on counties.`Code`=applicants.County
WHERE applicants.Deleted=0 and applicants.ID=@ApplicantID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getApplicants
DROP PROCEDURE IF EXISTS `getApplicants`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getApplicants`()
    NO SQL
SELECT  applicants.ApplicantCode as PEID, applicants.Name, applicants.Location, applicants.POBox, applicants.PostalCode, applicants.Town, applicants.Mobile, applicants.Telephone, applicants.Email, applicants.Logo, applicants.Website ,RegistrationDate,PIN,RegistrationNo,applicants.County as CountyCode,counties.`Name` as County  FROM `applicants`
inner join counties on counties.`Code`=applicants.County 
WHERE applicants.Deleted=0//
DELIMITER ;

-- Dumping structure for procedure arcm.getapplicationdocuments
DROP PROCEDURE IF EXISTS `getapplicationdocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getapplicationdocuments`()
    NO SQL
BEGIN
SELECT `ID`, `ApplicationID`, `Description`, `FileName`, `DateUploaded`, `Path` FROM `applicationdocuments`  WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationFees
DROP PROCEDURE IF EXISTS `GetApplicationFees`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetApplicationFees`(IN _ApplicationID int)
    NO SQL
BEGIN
select sum(AmountDue)  from applicationfees where ApplicationID=_ApplicationID INTO @Totall;
select  `ID`, `ApplicationID`, `EntryType`, `AmountDue`, `RefNo`, `BillDate`, `AmountPaid`,@Totall as total, `PaidDate`, `PaymentRef`, `PaymentMode`
  from applicationfees where ApplicationID=_ApplicationID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationForHearing
DROP PROCEDURE IF EXISTS `GetApplicationForHearing`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationForHearing`()
BEGIN
select DISTINCT venues.Name as VenueName,venues.Description as venuesDescription,branches.Description as BranchName ,venuebookings.VenueID, 
  date(venuebookings.Date),applications.ApplicationNo 
  from applications
  inner join  venuebookings on venuebookings.Content=applications.ApplicationNo
  inner join venues on venuebookings.VenueID=venues.ID
  inner join branches on venues.Branch=branches.ID WHERE venuebookings.Deleted=0 and date(venuebookings.Date) = CURDATE();
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationgroundsandreques
DROP PROCEDURE IF EXISTS `GetApplicationgroundsandreques`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetApplicationgroundsandreques`(IN _ApplicationID BIGINT)
    NO SQL
BEGIN

Select * FROM groundsandrequestedorders
WHERE Deleted=0 and ApplicationID=_ApplicationID;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationGroundsOnly
DROP PROCEDURE IF EXISTS `GetApplicationGroundsOnly`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationGroundsOnly`(IN _ApplicationNo VARCHAR(50))
BEGIN
Select * FROM groundsandrequestedorders
WHERE Deleted=0 and ApplicationID in (select ID from applications where ApplicationNo=_ApplicationNo) and EntryType='Grounds for Appeal';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getapplications
DROP PROCEDURE IF EXISTS `getapplications`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getapplications`()
    NO SQL
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  WHERE applications.Deleted=0  ORDER by applications.Created_At DESC;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationsForEachPE
DROP PROCEDURE IF EXISTS `GetApplicationsForEachPE`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationsForEachPE`(IN _LoggedInuser VARCHAR(50))
BEGIN
Select PEID from peusers where UserName=_LoggedInuser LIMIT 1 into @PEID;
SELECT applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,
  procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,peresponsetimer.DueOn,
  
  FilingDate, `ApplicationREf`, applications.ApplicationNo, applications.Status ,peresponsetimer.Status as TimerStatus
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join peresponsetimer on peresponsetimer.ApplicationNo=applications.ApplicationNo
  WHERE applications.Deleted=0 and applications.PEID=@PEID ORDER by applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationsHeard
DROP PROCEDURE IF EXISTS `GetApplicationsHeard`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationsHeard`()
BEGIN
Select DISTINCT casesittingsregister.ApplicationNo,applications.PEID,procuremententity.Name from casesittingsregister inner JOIN applications on applications.ApplicationNo=casesittingsregister.ApplicationNo
  inner JOIN procuremententity on applications.PEID=procuremententity.PEID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getapplicationsPendingApprovals
DROP PROCEDURE IF EXISTS `getapplicationsPendingApprovals`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getapplicationsPendingApprovals`(IN _Approver varchar(50))
    NO SQL
BEGIN
SELECT applications.ID,applications_approval_workflow.ApplicationNo ,TenderNo,applications_approval_workflow.TenderID,tenders.Name as TenderName,TenderValue,
  tenders.StartDate,
  tenders.ClosingDate, applications_approval_workflow.ApplicantID, applications_approval_workflow.PEID,procuremententity.Name as PEName,
  applications_approval_workflow.FilingDate, applications.Created_By as Applicantusername,
  applications_approval_workflow.ApplicationREf,applications_approval_workflow.Status
  ,procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,
  procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail
  FROM `applications_approval_workflow`
  inner join applications on applications.ApplicationNo=applications_approval_workflow.ApplicationNo
  inner join procuremententity on procuremententity.PEID=applications_approval_workflow.PEID 
  inner join tenders on tenders.ID=applications_approval_workflow.TenderID 
  WHERE applications_approval_workflow.status='Pending Approval' and applications_approval_workflow.Approver=_Approver;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApprovalModules
DROP PROCEDURE IF EXISTS `GetApprovalModules`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApprovalModules`()
    NO SQL
BEGIN
SELECT * from approvalmodules;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApproverDetails
DROP PROCEDURE IF EXISTS `GetApproverDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApproverDetails`(IN _ApplicationNo VARCHAR(50))
BEGIN
select Phone as ApproversPhone,Email as ApproversMail from users 
  where Username IN(Select Approver from applications_approval_workflow where ApplicationNo=_ApplicationNo and Status='Pending Approval');
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getApprovers
DROP PROCEDURE IF EXISTS `getApprovers`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getApprovers`()
    NO SQL
BEGIN
SELECT approvers.ID, approvers.Username,users.Name, approvers.ModuleCode,approvalmodules.Name as ModuleName, approvers.Level,Active FROM `approvers`
inner join users on users.Username=approvers.Username inner join approvalmodules on approvalmodules.ModuleCode=approvers.ModuleCode
WHERE approvers.Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAttendanceRegister
DROP PROCEDURE IF EXISTS `GetAttendanceRegister`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceRegister`(IN _RegisterID int)
BEGIN
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID,RegisterID,IDNO,MobileNo,Name,Email,Category from attendanceregister where RegisterID=_RegisterID order BY Category DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAuditrails
DROP PROCEDURE IF EXISTS `getAuditrails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAuditrails`()
    NO SQL
SELECT `AuditID`, `Date`, `Username`, `Description`, `Category`, `IpAddress` FROM `audittrails`//
DELIMITER ;

-- Dumping structure for procedure arcm.getBranches
DROP PROCEDURE IF EXISTS `getBranches`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getBranches`()
    NO SQL
BEGIN
SELECT `ID`,  `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM branches WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetCaseProceedings
DROP PROCEDURE IF EXISTS `GetCaseProceedings`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCaseProceedings`()
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
 
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  WHERE applications.Deleted=0  ORDER by applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getCaseWithdrawalPendingApproval
DROP PROCEDURE IF EXISTS `getCaseWithdrawalPendingApproval`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCaseWithdrawalPendingApproval`(IN _UserID VARCHAR(50))
BEGIN
select * from CaseWithdrawal where Approver=_UserID and status='Pending Approval';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getcommitteetypes
DROP PROCEDURE IF EXISTS `getcommitteetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getcommitteetypes`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `committeetypes` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetCompanyDetails
DROP PROCEDURE IF EXISTS `GetCompanyDetails`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetCompanyDetails`(IN _Code varchar(50))
BEGIN
SELECT `ID`, `Code`, `Name`, `PhysicalAdress`, `Street`, `PoBox`, `PostalCode`, `Town`, `Telephone1`, `Telephone2`, `Mobile`, `Fax`, `Email`, `Website`, `PIN`, `Logo`, `NextPE`, `NextComm`, `NextSupplier`, `NextMember`, `NextProcMeth`, `NextStdDoc`, `NextApplication`, `NextRev`,NextPEType FROM `configurations` WHERE   Deleted=0;


END//
DELIMITER ;

-- Dumping structure for procedure arcm.getcounties
DROP PROCEDURE IF EXISTS `getcounties`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getcounties`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Name`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `counties` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getdeadLineRequestApprovals
DROP PROCEDURE IF EXISTS `getdeadLineRequestApprovals`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getdeadLineRequestApprovals`(IN _Approver VARCHAR(50))
BEGIN
select deadlineapprovalworkflow.PEID,deadlineapprovalworkflow.ApplicationNo,deadlineapprovalworkflow.Reason,deadlineapprovalworkflow.RequestedDate,
  procuremententity.Name,Status,deadlineapprovalworkflow.Created_At as FilingDate,procuremententity.Mobile,
  procuremententity.Location,procuremententity.POBox,procuremententity.Email,procuremententity.Website,procuremententity.PostalCode,procuremententity.Town
 
  from deadlineapprovalworkflow 
  inner join procuremententity on procuremententity.PEID=deadlineapprovalworkflow.PEID 
 
  where Approver=_Approver and Status='Pending Approval';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Getfinancialyear
DROP PROCEDURE IF EXISTS `Getfinancialyear`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Getfinancialyear`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, DATE(StartDate) as StartDate, DATE(EndDate) as EndDate, `IsCurrentYear`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By` FROM `financialyear` 
WHERE Deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetGenereatedPanels
DROP PROCEDURE IF EXISTS `GetGenereatedPanels`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetGenereatedPanels`()
BEGIN
select DISTINCT panels.ApplicationNo,applicants.Name as ApplicantName,procuremententity.Name as PEName from panels inner join applications on applications.ApplicationNo=panels.ApplicationNo
  inner join procuremententity on applications.PEID=procuremententity.PEID inner join applicants on applicants.ID=applications.ApplicantID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetGenereatedRB1Forms
DROP PROCEDURE IF EXISTS `GetGenereatedRB1Forms`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetGenereatedRB1Forms`()
BEGIN
select   ApplicationNo,Path , FileName, GeneratedOn,GeneratedBy from rb1forms;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetGroupRoles
DROP PROCEDURE IF EXISTS `GetGroupRoles`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetGroupRoles`(IN `_UserGroupID` BIGINT)
    NO SQL
SELECT roles.RoleID, RoleName,`Edit`, `Remove`, `AddNew`, `View`, `Export`,Category FROM roles LEFT JOIN groupaccess 
    ON groupaccess.RoleID = roles.RoleID AND groupaccess.UserGroupID=_UserGroupID//
DELIMITER ;

-- Dumping structure for procedure arcm.GetHearingAttachments
DROP PROCEDURE IF EXISTS `GetHearingAttachments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetHearingAttachments`(IN _ApplicationNo VARCHAR(50))
BEGIN
 
Select  ApplicationNo,Name ,Description ,Path ,Category from hearingattachments
 Where ApplicationNo=_ApplicationNo and Deleted=0;
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetHearingNotices
DROP PROCEDURE IF EXISTS `GetHearingNotices`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetHearingNotices`()
BEGIN
select DISTINCT ApplicationNo,Path,Filename  from hearingnotices order by DateGenerated desc;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetHearingNotificationContacts
DROP PROCEDURE IF EXISTS `GetHearingNotificationContacts`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetHearingNotificationContacts`(IN _ApplicationNo VARCHAR(50))
BEGIN
  DROP TABLE IF EXISTS caseWithdrawalContacts;
  create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50));
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from panels where ApplicationNo=_ApplicationNo and Status='Approved' ) ;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from casedetails where  ApplicationNo=_ApplicationNo and Deleted=0);
  select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username in (select UserName from peusers where PEID=@PEID);
  insert into caseWithdrawalContacts select Name,Email,Mobile from procuremententity where PEID=@PEID;
  select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
  insert into caseWithdrawalContacts select Name,Email,Phone from users where Username =@Applicant;
  select ApplicantID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
  insert into caseWithdrawalContacts select Name,Email,Mobile from applicants where  ID=@ApplicantID;
  select * from caseWithdrawalContacts;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.getmembertypes
DROP PROCEDURE IF EXISTS `getmembertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getmembertypes`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `membertypes` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getmyapplications
DROP PROCEDURE IF EXISTS `getmyapplications`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getmyapplications`(IN _ApplicantID BIGINT)
    NO SQL
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  WHERE applications.Deleted=0 and applications.ApplicantID=_ApplicantID ORDER by applications.Created_At DESC;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getMycases
DROP PROCEDURE IF EXISTS `getMycases`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getMycases`(IN _UserName VARCHAR(50))
    NO SQL
BEGIN
SELECT DISTINCT applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`, applications.Status
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join casedetails on casedetails.ApplicationNo=applications.ApplicationNo
  WHERE applications.Deleted=0 and casedetails.UserName=_UserName ORDER by applications.Created_At DESC;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetMyPendingNotification
DROP PROCEDURE IF EXISTS `GetMyPendingNotification`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMyPendingNotification`(IN `_UserName` VARCHAR(50))
    NO SQL
BEGIN
SELECT  Username,COUNT(*) As Total, Category, Description, Created_At, DueDate, Status  from  notifications where Username=_Username
and status='Not Resolved' group by Category;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetMyresolveedNotifications
DROP PROCEDURE IF EXISTS `GetMyresolveedNotifications`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMyresolveedNotifications`(IN `_Username` VARCHAR(50))
    NO SQL
BEGIN
Select * from  notifications where Username=_Username and status='Resolved';

END//
DELIMITER ;

-- Dumping structure for procedure arcm.getMyResponse
DROP PROCEDURE IF EXISTS `getMyResponse`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMyResponse`(IN _PEID VARCHAR(50))
BEGIN
select PEID from peusers where UserName=_PEID limit 1 into @PEID;
select peresponse.ID as ResponseID,peresponse.Status, peresponse.ApplicationNo,peresponse.ResponseType,peresponse.ResponseDate,tenders.TenderNo,tenders.Name ,tenders.TenderValue as TenderValue
  , applications.Created_By as Applicantusername from peresponse 
 
  inner join applications on applications.ApplicationNo=peresponse.ApplicationNo 
   inner join tenders on applications.TenderID=tenders.ID
  where peresponse.PEID=@PEID; 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getMySchedules
DROP PROCEDURE IF EXISTS `getMySchedules`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMySchedules`(IN _Username VARCHAR(50))
BEGIN
select start,end,title from schedules where UserName = _Username;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneapplicant
DROP PROCEDURE IF EXISTS `getOneapplicant`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOneapplicant`(IN _LoggedInuser VARCHAR(50))
    NO SQL
SELECT applicants.ID ,applicants.ApplicantCode, applicants.Name, applicants.Location, applicants.POBox, applicants.PostalCode, applicants.Town, applicants.Mobile, applicants.Telephone, applicants.Email, applicants.Logo, applicants.Website ,applicants.County as CountyCode,counties.`Name` as County,RegistrationDate,PIN,RegistrationNo FROM `applicants` 
inner join counties on counties.`Code`=applicants.County
WHERE applicants.Deleted=0 and applicants.Created_By=_LoggedInuser or applicants.ID=_LoggedInuser//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneapplication
DROP PROCEDURE IF EXISTS `getOneapplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOneapplication`(IN _ID BIGINT)
    NO SQL
BEGIN
SELECT `ID`, `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status` FROM `applications`  WHERE Deleted=0 and ID=_ID;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneapplicationdocuments
DROP PROCEDURE IF EXISTS `getOneapplicationdocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOneapplicationdocuments`(IN  _ApplicationID  INT)
    NO SQL
BEGIN
SELECT `ID`, `ApplicationID`,  `Description`, `FileName`, `DateUploaded`, `Path` FROM `applicationdocuments`  WHERE Deleted=0 and ApplicationID=_ApplicationID;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneBranch
DROP PROCEDURE IF EXISTS `getOneBranch`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOneBranch`(IN _ID INT)
    NO SQL
BEGIN
SELECT `ID`,  `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM branches WHERE   ID=_ID and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneCaseOfficer
DROP PROCEDURE IF EXISTS `getOneCaseOfficer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getOneCaseOfficer`(IN _Username VARCHAR(50))
BEGIN
SELECT `ID`, `Username`, `MinValue`, MaximumValue, `Active`, `NotAvailableFrom`, `NotAvailableTo`, `OngoingCases`, `CumulativeCases`, `Create_at`, 
  `Update_at`, `CreatedBy`, `UpdatedBy`, `Deleted`, `DeletedBY`, `Deleted_At` FROM `caseofficers` 
  WHERE `Username`=_Username and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneCommitteetypes
DROP PROCEDURE IF EXISTS `getOneCommitteetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOneCommitteetypes`(IN _Code varchar(50))
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `committeetypes` WHERE   Code=_Code and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getOnecounty
DROP PROCEDURE IF EXISTS `getOnecounty`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOnecounty`(IN _Code varchar(50))
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Name`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `counties` WHERE   Code=_Code and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetOnefeesstructure
DROP PROCEDURE IF EXISTS `GetOnefeesstructure`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetOnefeesstructure`(IN _Code varchar(50))
    NO SQL
BEGIN


SELECT * from feesstructure
Where Code=_Code AND  Deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetOnefinancialyear
DROP PROCEDURE IF EXISTS `GetOnefinancialyear`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetOnefinancialyear`(IN `_Code` BIGINT)
    NO SQL
BEGIN
SELECT `ID`, `Code`, `StartDate`, `EndDate`, `IsCurrentYear`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By` FROM `financialyear` 
WHERE Code=_Code and Deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetOnegroundsandrequestedorders
DROP PROCEDURE IF EXISTS `GetOnegroundsandrequestedorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetOnegroundsandrequestedorders`(IN _ID BIGINT)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
Select * FROM groundsandrequestedorders
WHERE Deleted=0 ;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.getOnemembertypes
DROP PROCEDURE IF EXISTS `getOnemembertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOnemembertypes`(IN _Code varchar(50))
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `membertypes` WHERE   Code=_Code and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getOnePE
DROP PROCEDURE IF EXISTS `getOnePE`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOnePE`(IN _PEID VARCHAR(50))
    NO SQL
SELECT  procuremententity.PEID, procuremententity.Name, procuremententity.PEType, procuremententity.Location, procuremententity.POBox, procuremententity.PostalCode, procuremententity.Town, procuremententity.Mobile, procuremententity.Telephone, procuremententity.Email, procuremententity.Logo, procuremententity.Website ,procuremententity.County as CountyCode,counties.`Name` as County,

pecontactdetails.Name  ContactName, pecontactdetails.Mobile ContactMobile, pecontactdetails.Telephone ContactTelephone, pecontactdetails.Email ContactEmail   FROM `procuremententity` inner join pecontactdetails on pecontactdetails.PEID=procuremententity.PEID 
inner join counties on counties.`Code`=procuremententity.County
WHERE procuremententity.Deleted=0 and procuremententity.PEID=_PEID//
DELIMITER ;

-- Dumping structure for procedure arcm.getOnepetypes
DROP PROCEDURE IF EXISTS `getOnepetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOnepetypes`(IN _Code varchar(50))
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `petypes` WHERE  Code=_Code and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneprocurementmethod
DROP PROCEDURE IF EXISTS `getOneprocurementmethod`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOneprocurementmethod`(IN _Code varchar(50))
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `procurementmethods` WHERE Code=_Code and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getonestdtenderdocs
DROP PROCEDURE IF EXISTS `getonestdtenderdocs`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getonestdtenderdocs`(IN _Code varchar(50))
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `stdtenderdocs` WHERE Code=_Code and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetOneTender
DROP PROCEDURE IF EXISTS `GetOneTender`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetOneTender`(IN _ID BIGINT)
    NO SQL
BEGIN

SELECT * FROM tenders
WHERE Deleted=0 and ID=_ID;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetOnetenderaddendums
DROP PROCEDURE IF EXISTS `GetOnetenderaddendums`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetOnetenderaddendums`(IN _ID VARCHAR(100))
    NO SQL
BEGIN

SELECT * FROM tenderaddendums WHERE Deleted=0 and TenderID =_ID;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.getonetendertype
DROP PROCEDURE IF EXISTS `getonetendertype`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getonetendertype`(IN _Code varchar(50))
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `tendertypes` WHERE Code=_Code and Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetOnevenue
DROP PROCEDURE IF EXISTS `GetOnevenue`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOnevenue`(IN _ID int)
BEGIN
 
  Select Venues.ID,  Venues.ID,Branches.Description as Branch,  Venues.Name,Venues.Description 
  from Venues inner join Branches on Branches.ID=Venues.Branch where Venues.deleted=0 and ID=_ID;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPanelMembers
DROP PROCEDURE IF EXISTS `GetPanelMembers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPanelMembers`(IN _ApplicationNo VARCHAR(50))
BEGIN
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID, panels.ApplicationNo,panels.UserName,users.Name,users.Email,users.Phone ,panels.Status,Role from panels
  inner join users on users.Username=panels.UserName where ApplicationNo=_ApplicationNo and panels.deleted=0 order by Role ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetpanelsApproval
DROP PROCEDURE IF EXISTS `GetpanelsApproval`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetpanelsApproval`(IN _UserID VARCHAR(50))
BEGIN
select DISTINCT peresponse.ApplicationNo,peresponse.PEID,peresponse.ResponseType,peresponse.ResponseDate,
  procuremententity.Name as PEName,procuremententity.POBox as PEPOBOX,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.Email as PEEmail,procuremententity.Telephone as PETeleponde,
  peresponse.PanelStatus 
  from peresponse inner join procuremententity on peresponse.PEID=procuremententity.PEID 
  inner join panelsapprovalworkflow on panelsapprovalworkflow.ApplicationNo=peresponse.ApplicationNo where peresponse.Status='Submited' and panelsapprovalworkflow.status='Pending Approval' and panelsapprovalworkflow.Approver=_UserID and peresponse.PanelStatus = 'Submited';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getPE
DROP PROCEDURE IF EXISTS `getPE`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getPE`()
    NO SQL
SELECT  procuremententity.PEID, procuremententity.Name, procuremententity.PEType,petypes.Description as PETypeName,
  procuremententity.Location, procuremententity.POBox, procuremententity.PostalCode, procuremententity.Town, 
  procuremententity.Mobile, procuremententity.Telephone, procuremententity.Email, procuremententity.Logo, procuremententity.Website 
  ,procuremententity.County as CountyCode,counties.Name as County,
  procuremententity.RegistrationDate ,
  procuremententity.PIN,
  procuremententity.RegistrationNo  from procuremententity 
inner join counties on counties.Code=procuremententity.County inner join petypes on petypes.Code=procuremententity.PEType
WHERE procuremententity.Deleted=0//
DELIMITER ;

-- Dumping structure for procedure arcm.getPEPerApplicationNo
DROP PROCEDURE IF EXISTS `getPEPerApplicationNo`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPEPerApplicationNo`(IN _ApplicationNo VARCHAR(50))
BEGIN
select PEID FROM  applications where ApplicationNo=_ApplicationNo into @PEID;
  select PEID,Name,PEType,County,Location,POBox,PostalCode,Town,Mobile,Telephone,Email,Website from procuremententity where PEID=@PEID;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDetails
DROP PROCEDURE IF EXISTS `GetPEResponseDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEResponseDetails`(IN _ResponseID INT)
BEGIN
Select * from peresponsedetails where PEResponseID=_ResponseID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDetailsPerApplication
DROP PROCEDURE IF EXISTS `GetPEResponseDetailsPerApplication`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEResponseDetailsPerApplication`(IN _Application varchar(50))
BEGIN
select ID from peresponse where ApplicationNo=_Application LIMIT 1 into @ResponseID; 
Select * from peresponsedetails where PEResponseID=@ResponseID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDocuments
DROP PROCEDURE IF EXISTS `GetPEResponseDocuments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEResponseDocuments`(IN _ResponseID INT)
BEGIN
Select * from peresponsedocuments where PEResponseID=_ResponseID and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getpetypes
DROP PROCEDURE IF EXISTS `getpetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getpetypes`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `petypes` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEUserdetails
DROP PROCEDURE IF EXISTS `GetPEUserdetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEUserdetails`(IN _User VARCHAR(50))
BEGIN
select PEID from peusers where UserName=_User limit 1 into @PEID ;
SELECT procuremententity.ID ,procuremententity.PEID as ApplicantCode, procuremententity.Name, procuremententity.Location, procuremententity.POBox,
  procuremententity.PostalCode, procuremententity.Town, procuremententity.Mobile, procuremententity.Telephone, procuremententity.Email,
  procuremententity.Logo, procuremententity.Website ,PEType,
  procuremententity.County as CountyCode,counties.`Name` as County,RegistrationDate,PIN,RegistrationNo FROM procuremententity 
inner join counties on counties.`Code`=procuremententity.County
WHERE procuremententity.Deleted=0 and procuremententity.PEID=@PEID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getPrimaryCaseOfficer
DROP PROCEDURE IF EXISTS `getPrimaryCaseOfficer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPrimaryCaseOfficer`(IN _ApplicationNo varchar(50))
BEGIN
select casedetails.UserName,ApplicationNo,Email,Phone,Name from casedetails inner join users on users.Username=casedetails.UserName 
  where casedetails.ApplicationNo=_ApplicationNo and casedetails.Status='Open' LIMIT 1;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getprocurementmethods
DROP PROCEDURE IF EXISTS `getprocurementmethods`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getprocurementmethods`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `procurementmethods` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetRespondedApplications
DROP PROCEDURE IF EXISTS `GetRespondedApplications`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRespondedApplications`()
BEGIN
select peresponse.ApplicationNo,peresponse.PEID,peresponse.ResponseType,peresponse.ResponseDate,
procuremententity.Name as PEName,procuremententity.POBox as PEPOBOX,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.Email as PEEmail,procuremententity.Telephone as PETeleponde,
  peresponse.PanelStatus 
  from peresponse inner join procuremententity on peresponse.PEID=procuremententity.PEID  where Status='Submited' and peresponse.PanelStatus <> 'Submited';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetRespondedApplicationsToBeScheduled
DROP PROCEDURE IF EXISTS `GetRespondedApplicationsToBeScheduled`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRespondedApplicationsToBeScheduled`()
BEGIN
select applications.FilingDate,peresponsetimer.RegisteredOn as PEServedOn, peresponse.ApplicationNo,peresponse.PEID,peresponse.ResponseType,peresponse.ResponseDate,
procuremententity.Name as PEName,procuremententity.POBox as PEPOBOX,procuremententity.PostalCode as PEPostalCode,
  procuremententity.Town as PETown,procuremententity.Email as PEEmail,procuremententity.Telephone as PETeleponde,
  peresponse.PanelStatus 
  from peresponse inner join procuremententity on peresponse.PEID=procuremententity.PEID  
 inner join casedetails on casedetails.ApplicationNo= peresponse.ApplicationNo 
  inner join applications on applications.ApplicationNo=peresponse.ApplicationNo
  inner join peresponsetimer on peresponsetimer.ApplicationNo=peresponse.ApplicationNo
  where peresponse.Status='Submited' and peresponse.PanelStatus = 'Submited';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetRole
DROP PROCEDURE IF EXISTS `GetRole`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRole`(IN `_RoleId` BIGINT)
    NO SQL
BEGIN
Select * from roles where RoleID=_RoleID ;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetRoles
DROP PROCEDURE IF EXISTS `GetRoles`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRoles`()
    NO SQL
BEGIN
Select RoleID,RoleName,RoleDescription from roles where Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetSittingsPerApplicationNo
DROP PROCEDURE IF EXISTS `GetSittingsPerApplicationNo`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSittingsPerApplicationNo`(IN _Applicationno varchar(50))
BEGIN
select casesittingsregister.ID as SittingID,casesittingsregister.VenueID,casesittingsregister.Date,casesittingsregister.SittingNo,venues.Name as VenueName,branches.Description as Branch from casesittingsregister
INNER JOIN venues on casesittingsregister.VenueID=venues.ID INNER JOIN branches on branches.ID=venues.Branch
WHERE ApplicationNo=_Applicationno;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getSMSSenderDetails
DROP PROCEDURE IF EXISTS `getSMSSenderDetails`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getSMSSenderDetails`()
    NO SQL
BEGIN
SELECT * from smsdetails;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getSMTPDetails
DROP PROCEDURE IF EXISTS `getSMTPDetails`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getSMTPDetails`()
    NO SQL
BEGIN
SELECT * from smtpdetails;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getstdtenderdocs
DROP PROCEDURE IF EXISTS `getstdtenderdocs`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getstdtenderdocs`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `stdtenderdocs` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetTenderDetailsPerApplicationNo
DROP PROCEDURE IF EXISTS `GetTenderDetailsPerApplicationNo`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTenderDetailsPerApplicationNo`(IN _ApplicationNo VARCHAR(50))
BEGIN
select TenderID from applications where ApplicationNo=_ApplicationNo limit 1 into @Tender;
select TenderNo,Name,TenderValue,StartDate,Created_At as FilingDate from tenders where ID=@Tender;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.gettendertypes
DROP PROCEDURE IF EXISTS `gettendertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `gettendertypes`()
    NO SQL
BEGIN
SELECT `ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`,  `Deleted_By` FROM `tendertypes` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getTowns
DROP PROCEDURE IF EXISTS `getTowns`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getTowns`(IN _PostalCode VARCHAR(50))
    NO SQL
BEGIN
Select * from towns where PostCode=_PostalCode;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getuser
DROP PROCEDURE IF EXISTS `getuser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getuser`(IN `_Username` VARCHAR(128))
    NO SQL
BEGIN
SELECT users.Name, users.Username, users.Email, users.Password, users.Phone, users.Create_at,ChangePassword, users.Update_at, users.Login_at, users.Deleted, users.IsActive, users.IsEmailverified, usergroups.Name as UserGroupID, users.Photo, users.Category, users.Signature, users.IDnumber, users.Gender, users.DOB,users.ActivationCode
from users inner join usergroups on usergroups.UserGroupID=users.UserGroupID where (UserName=_UserName or Email=_UserName);
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetuserAccess
DROP PROCEDURE IF EXISTS `GetuserAccess`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetuserAccess`(IN `_Username` VARCHAR(50))
    NO SQL
BEGIN

DROP TABLE IF EXISTS Rolesbuffer; 
CREATE TEMPORARY TABLE Rolesbuffer (
    Username varchar(50),
RoleID Bigint NOT NULL
,Edit boolean
,Remove boolean
,AddNew boolean
,View boolean
,Export boolean
)ENGINE=MEMORY;

insert into Rolesbuffer select _Username,RoleID,Edit,Remove,AddNew,View,Export from useraccess where Username=_Username  ;

insert into Rolesbuffer (Username,RoleID) select _Username,RoleID from groupaccess where UserGroupID in (Select UserGroupID from users where Username=_Username) and RoleID not IN(select RoleID from useraccess where Username=_Username);

SELECT Username,Rolesbuffer.RoleID,RoleName,Edit,Remove,AddNew,View,Export,Category from Rolesbuffer inner join Roles on Rolesbuffer.RoleID=Roles.RoleID  ;
DROP TABLE Rolesbuffer; 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getusergroup
DROP PROCEDURE IF EXISTS `getusergroup`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getusergroup`(IN `_UserGroupID` INT(128))
    NO SQL
BEGIN
Select * from usergroups where Deleted=0 and UserGroupID=_UserGroupID;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetUsergroups
DROP PROCEDURE IF EXISTS `GetUsergroups`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsergroups`()
    NO SQL
BEGIN
Select * from usergroups where Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetUserRoles
DROP PROCEDURE IF EXISTS `GetUserRoles`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserRoles`(IN `_Username` VARCHAR(100))
    NO SQL
BEGIN
SELECT `Username`, useraccess.RoleID,RoleName, useraccess.Edit, useraccess.Remove, useraccess.AddNew, useraccess.View, useraccess.Export FROM `useraccess`
inner join roles on roles.RoleID=useraccess.RoleID where 	Username= _Username;  

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetUsers
DROP PROCEDURE IF EXISTS `GetUsers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsers`()
    NO SQL
BEGIN
SELECT users.Name, Username, Email,Phone,IsActive,usergroups.Name as UserGroup,users.UserGroupID,Photo,Signature,IDnumber,DOB,Gender,Category from users
inner join usergroups on users.UserGroupID=usergroups.UserGroupID
where users.Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetvenuesPerBranch
DROP PROCEDURE IF EXISTS `GetvenuesPerBranch`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetvenuesPerBranch`(IN _Branch int)
BEGIN
 
  Select Venues.ID,  Venues.ID,Branches.Description as Branch,  Venues.Name,Venues.Description 
  from Venues inner join Branches on Branches.ID=Venues.Branch where Venues.deleted=0 and Venues.Branch=_Branch;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GiveUserAllRoles
DROP PROCEDURE IF EXISTS `GiveUserAllRoles`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GiveUserAllRoles`(IN `_Username` VARCHAR(50))
    NO SQL
BEGIN
UPDATE useraccess SET
`Edit`=1,
`Remove`=1,
`AddNew`=1,
`View`=1,
`Export`=1,
`UpdateBy`=_Username,UpdatedAt=now()
WHERE Username=_Username;

END//
DELIMITER ;

-- Dumping structure for table arcm.groundsandrequestedorders
DROP TABLE IF EXISTS `groundsandrequestedorders`;
CREATE TABLE IF NOT EXISTS `groundsandrequestedorders` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(100) NOT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `EntryType` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GroundNO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.groundsandrequestedorders: ~6 rows (approximately)
/*!40000 ALTER TABLE `groundsandrequestedorders` DISABLE KEYS */;
INSERT INTO `groundsandrequestedorders` (`ID`, `ApplicationID`, `Description`, `EntryType`, `Status`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `GroundNO`) VALUES
	(1, 1, '<p>755732</p>\n', 'Grounds for Appeal', 'Pending Review', 'Applicant', '2019-10-01 11:07:12', NULL, NULL, 0, NULL, NULL, '1'),
	(2, 1, '<p>755732</p>\n', 'Requested Orders', 'Pending Review', 'Applicant', '2019-10-01 11:07:21', NULL, NULL, 0, NULL, NULL, '1'),
	(3, 2, '<p>799796799796</p>\n', 'Grounds for Appeal', 'Pending Review', 'Applicant', '2019-10-02 15:05:36', NULL, NULL, 0, NULL, NULL, '1'),
	(4, 2, '<p>799796</p>\n', 'Requested Orders', 'Pending Review', 'Applicant', '2019-10-02 15:05:42', NULL, NULL, 0, NULL, NULL, '1'),
	(5, 3, '<p>514277</p>\n', 'Grounds for Appeal', 'Pending Review', 'Applicant', '2019-10-02 15:17:32', NULL, NULL, 0, NULL, NULL, '1'),
	(6, 4, '<p>455516</p>\n', 'Grounds for Appeal', 'Pending Review', 'Applicant', '2019-10-02 15:31:43', NULL, NULL, 0, NULL, NULL, '1');
/*!40000 ALTER TABLE `groundsandrequestedorders` ENABLE KEYS */;

-- Dumping structure for table arcm.groundsandrequestedordershistory
DROP TABLE IF EXISTS `groundsandrequestedordershistory`;
CREATE TABLE IF NOT EXISTS `groundsandrequestedordershistory` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(100) NOT NULL,
  `EntryType` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.groundsandrequestedordershistory: ~0 rows (approximately)
/*!40000 ALTER TABLE `groundsandrequestedordershistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `groundsandrequestedordershistory` ENABLE KEYS */;

-- Dumping structure for table arcm.groupaccess
DROP TABLE IF EXISTS `groupaccess`;
CREATE TABLE IF NOT EXISTS `groupaccess` (
  `UserGroupID` bigint(20) NOT NULL,
  `RoleID` bigint(20) NOT NULL,
  `Edit` tinyint(1) NOT NULL,
  `Remove` tinyint(1) NOT NULL,
  `AddNew` tinyint(1) NOT NULL,
  `View` tinyint(1) NOT NULL,
  `Export` tinyint(1) NOT NULL,
  `UpdateBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreateBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`UserGroupID`,`RoleID`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `groupaccess_ibfk_1` FOREIGN KEY (`UserGroupID`) REFERENCES `usergroups` (`UserGroupID`),
  CONSTRAINT `groupaccess_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`),
  CONSTRAINT `groupaccess_ibfk_3` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.groupaccess: ~53 rows (approximately)
/*!40000 ALTER TABLE `groupaccess` DISABLE KEYS */;
INSERT INTO `groupaccess` (`UserGroupID`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`) VALUES
	(1, 17, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-20 14:34:39', '2019-07-20 14:36:43', 0),
	(1, 18, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-20 14:36:13', '2019-07-20 14:36:44', 0),
	(1, 19, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-20 14:36:14', '2019-07-20 14:36:44', 0),
	(1, 20, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-20 14:36:17', '2019-07-20 14:36:45', 0),
	(1, 21, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-20 14:35:08', '2019-07-20 14:36:46', 0),
	(1, 22, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 12:05:11', '2019-09-06 16:41:10', 0),
	(1, 23, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-07-26 12:05:12', '2019-07-26 12:05:12', 0),
	(1, 24, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 12:05:13', '2019-09-11 11:12:56', 0),
	(1, 25, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 12:05:14', '2019-09-11 11:12:56', 0),
	(1, 26, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 12:05:14', '2019-09-11 11:12:57', 0),
	(1, 27, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 12:05:14', '2019-09-11 11:12:57', 0),
	(1, 28, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-07-26 12:05:15', '2019-07-26 12:05:15', 0),
	(1, 29, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-07-29 09:48:18', '2019-07-29 09:48:20', 0),
	(1, 30, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-09 11:42:39', '2019-09-06 16:41:08', 0),
	(1, 31, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-07-29 14:07:57', '2019-07-29 14:08:04', 0),
	(1, 32, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-31 16:59:31', '2019-09-06 16:41:14', 0),
	(1, 33, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 10:22:15', '2019-09-06 16:41:18', 0),
	(1, 34, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-08-01 10:25:32', '2019-09-06 16:41:30', 0),
	(1, 35, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-08-01 10:49:22', '2019-09-06 16:41:31', 0),
	(1, 36, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-08-01 11:41:41', '2019-09-06 16:41:31', 0),
	(1, 37, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-08-01 13:32:59', '2019-09-06 16:41:32', 0),
	(1, 38, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-08-05 14:07:05', '2019-09-06 16:41:33', 0),
	(1, 39, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-05 14:44:42', '2019-09-11 11:13:06', 0),
	(1, 40, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-06 14:20:38', '2019-09-11 11:13:06', 0),
	(1, 41, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-06 14:34:37', '2019-09-11 11:13:07', 0),
	(1, 42, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-09 11:42:39', '2019-09-11 11:13:13', 0),
	(1, 43, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-14 10:23:35', '2019-09-11 11:13:12', 0),
	(1, 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-14 15:57:42', '2019-09-11 11:13:11', 0),
	(1, 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-14 15:57:43', '2019-09-11 11:13:10', 0),
	(1, 46, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-21 18:01:27', '2019-09-06 16:41:08', 0),
	(1, 47, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-23 12:01:49', '2019-09-11 11:13:00', 0),
	(1, 48, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-23 12:01:50', '2019-09-11 11:12:51', 0),
	(1, 49, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-09 09:47:19', '2019-09-09 09:47:50', 0),
	(1, 50, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-11 10:46:42', '2019-09-11 10:46:45', 0),
	(1, 51, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-11 11:12:47', '2019-09-11 11:12:50', 0),
	(1, 52, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-12 09:47:41', '2019-09-12 09:47:44', 0),
	(1, 53, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-13 10:05:09', '2019-09-13 10:05:13', 0),
	(1, 54, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-17 09:41:39', '2019-09-17 09:41:43', 0),
	(1, 55, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-18 10:04:16', '2019-09-18 10:04:20', 0),
	(1, 56, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-23 14:28:51', '2019-09-23 14:28:57', 0),
	(1, 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-24 11:09:37', '2019-09-24 11:09:41', 0),
	(1, 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-27 12:21:03', '2019-09-27 12:21:06', 0),
	(1, 59, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-01 11:03:32', '2019-10-01 11:03:36', 0),
	(7, 20, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-07-26 15:20:23', '2019-07-26 15:20:23', 0),
	(7, 21, 0, 0, 0, 0, 0, 'Admin', 'Admin', '2019-07-20 14:35:36', '2019-07-26 15:20:21', 0),
	(7, 27, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-07-26 15:20:27', '2019-07-26 15:20:27', 0),
	(7, 29, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-07-26 15:20:25', '2019-07-26 15:20:25', 0),
	(7, 36, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:07', '2019-08-08 10:07:07', 0),
	(7, 37, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:08', '2019-08-08 10:07:08', 0),
	(7, 38, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:09', '2019-08-08 10:07:09', 0),
	(7, 39, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:10', '2019-08-08 10:07:10', 0),
	(7, 40, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:10', '2019-08-08 10:07:10', 0),
	(8, 32, 1, 1, 0, 1, 1, 'Admin', 'Admin', '2019-08-16 17:21:00', '2019-08-16 17:22:55', 0),
	(8, 36, 1, 1, 0, 1, 1, 'Admin', 'Admin', '2019-08-16 17:22:19', '2019-08-16 17:22:57', 0),
	(8, 38, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:31', '2019-08-16 17:22:34', 0),
	(8, 40, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:40', '2019-08-16 17:22:40', 0),
	(8, 41, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:42', '2019-08-16 17:22:42', 0),
	(8, 42, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:45', '2019-08-16 17:22:45', 0),
	(8, 43, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:49', '2019-08-16 17:22:49', 0),
	(8, 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-16 17:02:21', '2019-08-16 17:02:29', 0),
	(8, 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-16 17:02:20', '2019-08-16 17:02:29', 0),
	(8, 56, 1, 0, 1, 1, 1, 'Admin', 'Admin', '2019-09-23 11:59:42', '2019-09-23 11:59:48', 0),
	(8, 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-24 11:10:20', '2019-09-24 11:10:25', 0);
/*!40000 ALTER TABLE `groupaccess` ENABLE KEYS */;

-- Dumping structure for table arcm.hearingattachments
DROP TABLE IF EXISTS `hearingattachments`;
CREATE TABLE IF NOT EXISTS `hearingattachments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UploadedOn` datetime NOT NULL,
  `UploadedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `DeletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.hearingattachments: ~2 rows (approximately)
/*!40000 ALTER TABLE `hearingattachments` DISABLE KEYS */;
INSERT INTO `hearingattachments` (`ID`, `ApplicationNo`, `Name`, `Description`, `Path`, `Category`, `UploadedOn`, `UploadedBy`, `Deleted`, `DeletedBy`) VALUES
	(1, 'ARCM-AP-50', '1569923599024-ELVIS KIMUTAI CV.pdf', 'Document1', 'http://74.208.157.60:3001/HearingAttachments/Documents', 'Documents', '2019-10-01 12:53:19', 'Admin', 1, 'Admin'),
	(2, 'ARCM-AP-50', '1569925205253-Invoice1.pdf', 'Does Not Exceed 2M', 'http://74.208.157.60:3001/HearingAttachments/Documents', 'Documents', '2019-10-01 13:20:05', 'Admin', 0, NULL),
	(3, 'ARCM-AP-50', '1569933899692-kiambu.mp4', 'Vedio 1', 'http://74.208.157.60:3001/HearingAttachments/Vedios', 'Vedio', '2019-10-01 15:44:59', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `hearingattachments` ENABLE KEYS */;

-- Dumping structure for table arcm.hearingnotices
DROP TABLE IF EXISTS `hearingnotices`;
CREATE TABLE IF NOT EXISTS `hearingnotices` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateGenerated` datetime DEFAULT NULL,
  `DateSent` datetime DEFAULT NULL,
  `Path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Filename` varchar(105) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.hearingnotices: ~5 rows (approximately)
/*!40000 ALTER TABLE `hearingnotices` DISABLE KEYS */;
INSERT INTO `hearingnotices` (`ID`, `ApplicationNo`, `DateGenerated`, `DateSent`, `Path`, `Filename`, `Created_By`) VALUES
	(1, 'ARCM-AP-50', '2019-10-01 11:14:06', '2019-10-02 15:56:17', 'HearingNotices/', 'ARCM-AP-50.pdf', 'Admin'),
	(2, 'ARCM-AP-50', '2019-10-01 13:16:33', '2019-10-02 15:56:17', 'HearingNotices/', 'ARCM-AP-50.pdf', 'Admin'),
	(3, 'ARCM-AP-50', '2019-10-01 13:16:50', '2019-10-02 15:56:17', 'HearingNotices/', 'ARCM-AP-50.pdf', 'Admin'),
	(4, 'ARCM-AP-50', '2019-10-02 15:56:11', '2019-10-02 15:56:17', 'HearingNotices/', 'ARCM-AP-50.pdf', 'Admin'),
	(5, 'ARCM-AP-50', '2019-10-02 15:57:04', NULL, 'HearingNotices/', 'ARCM-AP-50.pdf', 'Admin');
/*!40000 ALTER TABLE `hearingnotices` ENABLE KEYS */;

-- Dumping structure for procedure arcm.MarkcaseWithdrawalasfrivolous
DROP PROCEDURE IF EXISTS `MarkcaseWithdrawalasfrivolous`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MarkcaseWithdrawalasfrivolous`(IN _ApplicationNo varchar(50), IN _userID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Declined Case Withdrawal for Application : ', _ApplicationNo); 
Update casewithdrawal set  DecisionDate= now(), Status='Declined',Frivolous =1 where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
END//
DELIMITER ;

-- Dumping structure for table arcm.membertypes
DROP TABLE IF EXISTS `membertypes`;
CREATE TABLE IF NOT EXISTS `membertypes` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.membertypes: ~0 rows (approximately)
/*!40000 ALTER TABLE `membertypes` DISABLE KEYS */;
INSERT INTO `membertypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(1, 'COMT-1', 'Default Member', '2019-08-05 16:11:21', 'Admin', '2019-08-05 16:11:21', 'Admin', 1, 'Admin'),
	(2, 'COMT-2', 'Default members', '2019-08-09 17:48:49', 'Admin', '2019-08-27 17:19:25', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `membertypes` ENABLE KEYS */;

-- Dumping structure for table arcm.mpesaconfigurations
DROP TABLE IF EXISTS `mpesaconfigurations`;
CREATE TABLE IF NOT EXISTS `mpesaconfigurations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consumer_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Registrationurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Outhurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShortCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ConfirmationURL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ValidationURL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.mpesaconfigurations: ~0 rows (approximately)
/*!40000 ALTER TABLE `mpesaconfigurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `mpesaconfigurations` ENABLE KEYS */;

-- Dumping structure for table arcm.notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created_At` datetime NOT NULL,
  `DueDate` datetime NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.notifications: ~13 rows (approximately)
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`ID`, `Username`, `Category`, `Description`, `Created_At`, `DueDate`, `Status`) VALUES
	(1, 'Admin', 'Applications Approval', 'Applications pending approval', '2019-10-01 11:07:05', '2019-10-04 11:07:05', 'Resolved'),
	(2, 'Admin2', 'Applications Approval', 'Applications pending approval', '2019-10-01 11:07:58', '2019-10-04 11:07:58', 'Not Resolved'),
	(3, 'Admin', 'Applications Approval', 'Applications pending approval', '2019-10-02 15:05:22', '2019-10-05 15:05:22', 'Resolved'),
	(4, 'Admin2', 'Applications Approval', 'Applications pending approval', '2019-10-02 15:06:50', '2019-10-05 15:06:50', 'Not Resolved'),
	(5, 'Admin', 'Panel Formation', 'Applications Awiting panel formation', '2019-10-02 15:10:11', '2019-10-05 15:10:11', 'Resolved'),
	(6, 'Admin', 'Panel Formation', 'Applications Awiting panel formation', '2019-10-02 15:10:21', '2019-10-05 15:10:21', 'Resolved'),
	(7, 'Admin2', 'Panel Formation', 'Applications Awiting panel formation', '2019-10-02 15:14:59', '2019-10-05 15:14:59', 'Not Resolved'),
	(8, 'Admin', 'Applications Approval', 'Applications pending approval', '2019-10-02 15:17:25', '2019-10-05 15:17:25', 'Resolved'),
	(9, 'Admin2', 'Applications Approval', 'Applications pending approval', '2019-10-02 15:19:09', '2019-10-05 15:19:09', 'Not Resolved'),
	(10, 'Admin2', 'Panel Formation', 'Applications Awiting panel formation', '2019-10-02 15:23:33', '2019-10-05 15:23:33', 'Not Resolved'),
	(11, 'Admin', 'Applications Approval', 'Applications pending approval', '2019-10-02 15:31:34', '2019-10-05 15:31:34', 'Resolved'),
	(12, 'Admin2', 'Applications Approval', 'Applications pending approval', '2019-10-02 15:32:59', '2019-10-05 15:32:59', 'Not Resolved'),
	(13, 'Admin', 'Panel Formation', 'Applications Awiting panel formation', '2019-10-02 15:34:21', '2019-10-05 15:34:21', 'Resolved'),
	(14, 'Admin', 'Panel Approval', 'Panel Lists Awiting Approval', '2019-10-02 15:47:22', '2019-10-05 15:47:22', 'Not Resolved');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table arcm.panellist
DROP TABLE IF EXISTS `panellist`;
CREATE TABLE IF NOT EXISTS `panellist` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileName` varchar(105) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GeneratedOn` datetime DEFAULT NULL,
  `GeneratedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.panellist: ~0 rows (approximately)
/*!40000 ALTER TABLE `panellist` DISABLE KEYS */;
INSERT INTO `panellist` (`ID`, `ApplicationNo`, `Path`, `FileName`, `GeneratedOn`, `GeneratedBy`) VALUES
	(1, 'ARCM-AP-50', 'PanelLists/', 'ARCM-AP-50.pdf', '2019-10-02 12:20:55', 'Admin');
/*!40000 ALTER TABLE `panellist` ENABLE KEYS */;

-- Dumping structure for table arcm.panels
DROP TABLE IF EXISTS `panels`;
CREATE TABLE IF NOT EXISTS `panels` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UserName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Role` varchar(100) COLLATE utf8mb4_unicode_ci,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.panels: ~4 rows (approximately)
/*!40000 ALTER TABLE `panels` DISABLE KEYS */;
INSERT INTO `panels` (`ID`, `ApplicationNo`, `UserName`, `Status`, `Role`, `Deleted`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`) VALUES
	(1, 'ARCM-AP-50', 'Admin', 'Partialy Approved', 'Member', 0, '2019-10-01 11:12:52', 'Admin', NULL, NULL),
	(2, 'ARCM-AP-50', 'Admin2', 'Partialy Approved', 'Chairperson', 0, '2019-10-01 11:12:57', 'Admin', NULL, NULL),
	(3, 'ARCM-AP-51', 'Admin', 'Nominated', 'Member', 0, '2019-10-02 15:18:42', 'Admin', NULL, NULL),
	(4, 'ARCM-AP-52', 'Admin', 'Nominated', 'Member', 0, '2019-10-02 15:38:03', 'Admin', NULL, NULL),
	(5, 'ARCM-AP-53', 'Admin', 'Nominated', 'Member', 0, '2019-10-02 15:47:19', 'Admin', NULL, NULL);
/*!40000 ALTER TABLE `panels` ENABLE KEYS */;

-- Dumping structure for table arcm.panelsapprovalworkflow
DROP TABLE IF EXISTS `panelsapprovalworkflow`;
CREATE TABLE IF NOT EXISTS `panelsapprovalworkflow` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UserName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Role` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Approved_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=1638;

-- Dumping data for table arcm.panelsapprovalworkflow: ~6 rows (approximately)
/*!40000 ALTER TABLE `panelsapprovalworkflow` DISABLE KEYS */;
INSERT INTO `panelsapprovalworkflow` (`ID`, `ApplicationNo`, `UserName`, `Status`, `Role`, `Deleted`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Approver`, `Approved_At`) VALUES
	(1, 'ARCM-AP-50', 'Admin', 'Approved', 'Member', 0, '2019-10-01 11:12:52', 'Admin', NULL, NULL, 'Admin', '2019-10-01 11:13:11'),
	(2, 'ARCM-AP-50', 'Admin2', 'Approved', 'Chairperson', 0, '2019-10-01 11:12:57', 'Admin', NULL, NULL, 'Admin', '2019-10-01 11:13:07'),
	(4, 'ARCM-AP-50', 'Admin', 'Pending Approval', 'Member', 0, '2019-10-01 11:12:52', 'Admin', NULL, NULL, 'Admin2', NULL),
	(5, 'ARCM-AP-50', 'Admin2', 'Pending Approval', 'Chairperson', 0, '2019-10-01 11:12:57', 'Admin', NULL, NULL, 'Admin2', NULL),
	(6, 'ARCM-AP-51', 'Admin', 'Pending Approval', 'Member', 0, '2019-10-02 15:18:42', 'Admin', NULL, NULL, 'Admin', NULL),
	(7, 'ARCM-AP-52', 'Admin', 'Pending Approval', 'Member', 0, '2019-10-02 15:38:03', 'Admin', NULL, NULL, 'Admin', NULL),
	(8, 'ARCM-AP-53', 'Admin', 'Pending Approval', 'Member', 0, '2019-10-02 15:47:19', 'Admin', NULL, NULL, 'Admin', NULL);
/*!40000 ALTER TABLE `panelsapprovalworkflow` ENABLE KEYS */;

-- Dumping structure for table arcm.pedeadlineextensionsrequests
DROP TABLE IF EXISTS `pedeadlineextensionsrequests`;
CREATE TABLE IF NOT EXISTS `pedeadlineextensionsrequests` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reason` text COLLATE utf8mb4_unicode_ci,
  `RequestedDate` datetime DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.pedeadlineextensionsrequests: ~0 rows (approximately)
/*!40000 ALTER TABLE `pedeadlineextensionsrequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedeadlineextensionsrequests` ENABLE KEYS */;

-- Dumping structure for table arcm.peresponse
DROP TABLE IF EXISTS `peresponse`;
CREATE TABLE IF NOT EXISTS `peresponse` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ResponseType` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ResponseDate` datetime NOT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Created_At` datetime NOT NULL,
  `Status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PanelStatus` varchar(50) COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID`,`ApplicationNo`,`PEID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponse: ~4 rows (approximately)
/*!40000 ALTER TABLE `peresponse` DISABLE KEYS */;
INSERT INTO `peresponse` (`ID`, `ApplicationNo`, `PEID`, `ResponseType`, `ResponseDate`, `Created_By`, `Created_At`, `Status`, `PanelStatus`) VALUES
	(1, 'ARCM-AP-50', 'PE-2', 'No Objection', '2019-10-01 11:10:04', 'Testuser', '2019-10-01 11:10:04', 'Submited', 'Submited'),
	(2, 'ARCM-AP-51', 'PE-2', 'No Objection', '2019-10-02 15:10:01', 'TestUser', '2019-10-02 15:10:01', 'Submited', 'Submited'),
	(3, 'ARCM-AP-52', 'PE-2', 'No Objection', '2019-10-02 15:23:27', 'TestUser', '2019-10-02 15:23:27', 'Submited', 'Submited'),
	(4, 'ARCM-AP-53', 'PE-2', 'No Objection', '2019-10-02 15:34:16', 'TestUser', '2019-10-02 15:34:16', 'Submited', 'Submited');
/*!40000 ALTER TABLE `peresponse` ENABLE KEYS */;

-- Dumping structure for table arcm.peresponsedetails
DROP TABLE IF EXISTS `peresponsedetails`;
CREATE TABLE IF NOT EXISTS `peresponsedetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PEResponseID` int(11) DEFAULT NULL,
  `GroundNO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GroundType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Response` text COLLATE utf8mb4_unicode_ci,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsedetails: ~3 rows (approximately)
/*!40000 ALTER TABLE `peresponsedetails` DISABLE KEYS */;
INSERT INTO `peresponsedetails` (`ID`, `PEResponseID`, `GroundNO`, `GroundType`, `Response`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`) VALUES
	(1, 1, '1', 'Grounds for Appeal', '<p>v896891896891</p>\n', '2019-10-01 11:10:04', 'Testuser', NULL, NULL),
	(2, 2, '1', 'Grounds for Appeal', '<p>213205213205</p>\n', '2019-10-02 15:10:01', 'TestUser', NULL, NULL),
	(3, 3, '1', 'Grounds for Appeal', '<p>results[0]</p>\n', '2019-10-02 15:23:28', 'TestUser', NULL, NULL),
	(4, 4, '1', 'Grounds for Appeal', '<p>909608</p>\n', '2019-10-02 15:34:17', 'TestUser', NULL, NULL);
/*!40000 ALTER TABLE `peresponsedetails` ENABLE KEYS */;

-- Dumping structure for table arcm.peresponsedocuments
DROP TABLE IF EXISTS `peresponsedocuments`;
CREATE TABLE IF NOT EXISTS `peresponsedocuments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PEResponseID` int(11) DEFAULT NULL,
  `Name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Path` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsedocuments: ~0 rows (approximately)
/*!40000 ALTER TABLE `peresponsedocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `peresponsedocuments` ENABLE KEYS */;

-- Dumping structure for table arcm.peresponsetimer
DROP TABLE IF EXISTS `peresponsetimer`;
CREATE TABLE IF NOT EXISTS `peresponsetimer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `RegisteredOn` datetime NOT NULL,
  `DueOn` datetime NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`,`PEID`,`ApplicationNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsetimer: ~4 rows (approximately)
/*!40000 ALTER TABLE `peresponsetimer` DISABLE KEYS */;
INSERT INTO `peresponsetimer` (`ID`, `PEID`, `ApplicationNo`, `RegisteredOn`, `DueOn`, `Status`) VALUES
	(1, 'PE-2', 'ARCM-AP-50', '2019-10-01 11:07:58', '2019-10-15 11:07:58', 'Responded'),
	(2, 'PE-2', 'ARCM-AP-51', '2019-10-02 15:06:50', '2019-10-16 15:06:50', 'Responded'),
	(3, 'PE-2', 'ARCM-AP-52', '2019-10-02 15:19:09', '2019-10-16 15:19:09', 'Responded'),
	(4, 'PE-2', 'ARCM-AP-53', '2019-10-02 15:32:59', '2019-10-16 15:32:59', 'Responded');
/*!40000 ALTER TABLE `peresponsetimer` ENABLE KEYS */;

-- Dumping structure for table arcm.petypes
DROP TABLE IF EXISTS `petypes`;
CREATE TABLE IF NOT EXISTS `petypes` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.petypes: ~4 rows (approximately)
/*!40000 ALTER TABLE `petypes` DISABLE KEYS */;
INSERT INTO `petypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(2, 'PET-2', 'Ministry', '2019-07-31 15:54:08', 'Admin', '2019-08-27 17:40:02', 'Admin', 0, NULL),
	(4, 'PET-4', 'State Department', '2019-07-31 15:55:37', 'Admin', '2019-10-04 09:45:06', 'Admin', 0, NULL),
	(5, 'PET-5', 'Ministry Updated', '2019-07-31 17:05:28', 'Admin', '2019-07-31 17:06:30', 'Admin', 0, NULL),
	(6, 'PET-6', 'Universities', '2019-08-08 12:37:03', 'Admin', '2019-08-08 12:37:03', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `petypes` ENABLE KEYS */;

-- Dumping structure for table arcm.peusers
DROP TABLE IF EXISTS `peusers`;
CREATE TABLE IF NOT EXISTS `peusers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peusers: ~2 rows (approximately)
/*!40000 ALTER TABLE `peusers` DISABLE KEYS */;
INSERT INTO `peusers` (`ID`, `UserName`, `PEID`, `Created_At`, `Created_by`) VALUES
	(2, 'TestUser', 'PE-2', '2019-09-02 16:45:12', 'TestUser');
/*!40000 ALTER TABLE `peusers` ENABLE KEYS */;

-- Dumping structure for table arcm.procuremententity
DROP TABLE IF EXISTS `procuremententity`;
CREATE TABLE IF NOT EXISTS `procuremententity` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PEType` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `County` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `POBox` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostalCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Telephone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Logo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Website` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `RegistrationDate` datetime DEFAULT NULL,
  `PIN` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RegistrationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`PEID`) USING BTREE,
  KEY `financialyear_ibfk_1` (`Created_By`),
  KEY `financialyear_ibfk_2` (`Updated_By`),
  KEY `PEID` (`PEID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.procuremententity: ~3 rows (approximately)
/*!40000 ALTER TABLE `procuremententity` DISABLE KEYS */;
INSERT INTO `procuremententity` (`ID`, `PEID`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`, `RegistrationDate`, `PIN`, `RegistrationNo`) VALUES
	(1, 'PE-1', 'MMUST', 'PET-4', '027', 'Kakamega', '190', '10001', 'Kakamega', '0705555285', '07055555287', 'elviskimcheruiyot@gmail.com', 'signature.jpg', 'https://www.google.com', 'Admin', '2019-08-09 11:55:00', '2019-09-03 12:21:40', 'Admin', 0, 'Admin', '2019-08-09 12:58:17', '2019-09-04 00:00:00', 'A123456789X', 'TS2345678KS'),
	(2, 'PE-2', 'MINISTRY OF EDUCATION', 'PET-2', '027', 'Kakamega', '190', '10001', 'Nairobi', '0705555285', '07055555287', 'elviskimcheruiyot@gmail.com', '1567502200430-admin.png', 'https://www.google.com', 'Admin', '2019-08-09 12:11:23', '2019-09-03 12:24:42', 'TestUser', 0, NULL, NULL, '1970-01-01 00:00:00', 'A123456789X', 'TS2345678KS'),
	(3, 'PE-3', 'University of Nairobi', 'PET-6', '047', 'University of Nairobi', '190', '30106', 'TURBO  ', '0705555285', '1234567890', 'elviskimcheruiyot@gmail.com', '1567502559643-admin.png', 'https://www.google.com', 'Admin', '2019-09-03 12:22:41', NULL, NULL, 0, NULL, NULL, '2019-09-01 00:00:00', 'A123456789X', 'TS2345678KS');
/*!40000 ALTER TABLE `procuremententity` ENABLE KEYS */;

-- Dumping structure for table arcm.procurementmethods
DROP TABLE IF EXISTS `procurementmethods`;
CREATE TABLE IF NOT EXISTS `procurementmethods` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.procurementmethods: ~5 rows (approximately)
/*!40000 ALTER TABLE `procurementmethods` DISABLE KEYS */;
INSERT INTO `procurementmethods` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(6, 'PROGM-1', 'Direct Procurement Updated', '2019-08-01 10:26:17', 'Admin', '2019-08-01 10:26:55', 'Admin', 1, 'Admin'),
	(7, 'PROGM-2', 'Single-Source ', '2019-08-01 10:41:25', 'Admin', '2019-08-01 10:45:24', 'Admin', 1, 'Admin'),
	(8, 'PROGM-3', 'Request for Quotations', '2019-08-01 10:55:31', 'Admin', '2019-08-27 17:40:07', 'Admin', 0, NULL),
	(9, 'PROGM-4', 'Restricted Tendering', '2019-08-01 10:55:45', 'Admin', '2019-10-04 09:47:39', 'Admin', 0, NULL),
	(10, 'PROGM-5', 'Open Tendering', '2019-08-01 10:55:53', 'Admin', '2019-08-27 17:19:41', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `procurementmethods` ENABLE KEYS */;

-- Dumping structure for table arcm.rb1forms
DROP TABLE IF EXISTS `rb1forms`;
CREATE TABLE IF NOT EXISTS `rb1forms` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileName` varchar(105) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GeneratedOn` datetime DEFAULT NULL,
  `GeneratedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.rb1forms: ~3 rows (approximately)
/*!40000 ALTER TABLE `rb1forms` DISABLE KEYS */;
INSERT INTO `rb1forms` (`ID`, `ApplicationNo`, `Path`, `FileName`, `GeneratedOn`, `GeneratedBy`) VALUES
	(1, 'ARCM-AP-50', 'RB1FORMS/', 'ARCM-AP-50.pdf', '2019-10-01 11:08:07', 'Admin'),
	(2, 'ARCM-AP-51', 'RB1FORMS/', 'ARCM-AP-51.pdf', '2019-10-02 15:07:00', 'Admin'),
	(3, 'ARCM-AP-52', 'RB1FORMS/', 'ARCM-AP-52.pdf', '2019-10-02 15:19:11', 'Admin'),
	(4, 'ARCM-AP-53', 'RB1FORMS/', 'ARCM-AP-53.pdf', '2019-10-02 15:33:01', 'Admin');
/*!40000 ALTER TABLE `rb1forms` ENABLE KEYS */;

-- Dumping structure for procedure arcm.ReasignCaseOfficer
DROP PROCEDURE IF EXISTS `ReasignCaseOfficer`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReasignCaseOfficer`(IN _UserID VARCHAR(50), IN _Applicationno VARCHAR(50), IN _UserName VARCHAR(50), IN _Reason VARCHAR(255))
BEGIN
select UserName from casedetails where ApplicationNo=_Applicationno AND Status='Open' LIMIT 1 into @CurrentUser;
update casedetails set Status='Re-Assigned',PrimaryOfficer=0,ReassignedTo=_UserName,DateReasigned=now(),Reason=_Reason where ApplicationNo=_Applicationno and UserName=@CurrentUser;
INSERT INTO `casedetails`( `UserName`, `ApplicationNo`, `DateAsigned`, `Status`, `PrimaryOfficer`,  `Created_At`, `Created_By`, `Deleted`) 
  VALUES (_UserName,_Applicationno,now(),'Open',1,now(),_UserID,0);

  select OngoingCases from caseofficers where Username=_UserName into @CurrentOngoingCases;
  select CumulativeCases from caseofficers where Username=_UserName into @CurrentCumulativeCases;
  update caseofficers set OngoingCases=@CurrentOngoingCases+1,CumulativeCases=@CurrentCumulativeCases+1 where Username=_UserName;
  select Email,Phone,Name from users where Username=_UserName;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.registercasesittings
DROP PROCEDURE IF EXISTS `registercasesittings`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `registercasesittings`(IN _ApplicationNo VARCHAR(50),IN _VenueID INT,IN _Date Date,IN _UserID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Registered hearing for Application:',_ApplicationNo); 

if(SELECT count(*)  from casesittingsregister where ApplicationNo=_ApplicationNo and Date=_Date )=0 THEN
BEGIN
select IFNULL(MAX(SittingNo),0)+1 from casesittingsregister where ApplicationNo=_ApplicationNo  INTO @SittingNo; 
INSERT INTO casesittingsregister (ApplicationNo ,VenueID ,Date ,SittingNo , Created_At,Created_By)
  VALUES(_ApplicationNo,_VenueID,now(),@SittingNo,now(),_UserID);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');
  select max(ID) as RegisterID from casesittingsregister where ApplicationNo=_ApplicationNo and Date=_Date and SittingNo=@SittingNo;
END;
else

  Begin
 select max(ID) as RegisterID from casesittingsregister where ApplicationNo=_ApplicationNo  and Date=_Date;
  ENd;
  END if;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.RemoveAllUserroles
DROP PROCEDURE IF EXISTS `RemoveAllUserroles`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `RemoveAllUserroles`(IN `_Username` VARCHAR(50))
    NO SQL
BEGIN

UPDATE useraccess SET
`Edit`=0,
`Remove`=0,
`AddNew`=0,
`View`=0,
`Export`=0,
`UpdateBy`=_Username,UpdatedAt=now()
WHERE Username=_Username;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.RemovePanelMember
DROP PROCEDURE IF EXISTS `RemovePanelMember`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `RemovePanelMember`(IN _ApplicationNo VARCHAR(50), IN _UserName VARCHAR(50), IN _userID VARCHAR(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Removed  PanelMember:' +_UserName+ ' for Application: ', _ApplicationNo); 
  update Panels set deleted=1 where ApplicationNo=_ApplicationNo and UserName=_UserName;
  call SaveAuditTrail(_userID,lSaleDesc,'Delete','0');
  update panelsapprovalworkflow  set Status='Declined', Approved_At=now() where ApplicationNo=_ApplicationNo and UserName=_UserName and Approver=_userID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Resetpassword
DROP PROCEDURE IF EXISTS `Resetpassword`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Resetpassword`(IN `_Email` VARCHAR(128), IN `_Password` VARCHAR(128))
    NO SQL
BEGIN

if(SELECT count(*)  from users where Email=_Email)>0 THEN
BEGIN

Update users set `Password`=_Password,ChangePassword=1 Where Email=_Email;
Select 'Password changed' as msg;
END;
ELSE
BEGIN
select 'User Not Found' as msg;

END;
 END IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ResolveMyNotification
DROP PROCEDURE IF EXISTS `ResolveMyNotification`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ResolveMyNotification`(IN _UserName VARCHAR(50), IN _Category VARCHAR(50))
BEGIN
select ID from notifications where Username=_UserName and Category=_Category and Status='Not Resolved' LIMIT 1 into @UnresolvedID;
update notifications set Status='Resolved' where Username=_UserName and Category=_Category and ID=@UnresolvedID;
END//
DELIMITER ;

-- Dumping structure for table arcm.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `RoleID` bigint(20) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `RoleDescription` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdateBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreateBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `Category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`RoleID`,`RoleName`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.roles: ~31 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`RoleID`, `RoleName`, `RoleDescription`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`, `Category`) VALUES
	(17, 'System Users', 'System Users ', 'Admin', 'user', '2019-06-27 17:30:15', '2019-10-04 10:27:44', 0, 'Admin'),
	(18, 'Roles', 'Security roles', 'user', 'user', '2019-06-27 17:30:36', '2019-06-27 17:30:36', 0, 'Admin'),
	(19, 'Security Groups', 'Security groups', 'user', 'user', '2019-06-27 17:31:08', '2019-06-27 17:31:08', 0, 'Admin'),
	(20, 'Assign Group Access', 'Assign Group Access', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Admin'),
	(21, 'Audit Trails', 'Audit Trails', 'user', 'user', '2019-06-27 17:31:57', '2019-06-27 17:31:57', 0, 'Admin'),
	(22, 'System Administration', 'System Administration', 'Admin', 'Admin', '2019-07-26 12:02:56', '2019-07-26 12:02:56', 0, 'Admin'),
	(23, 'Fees Settings', 'Fees Settings', 'Admin', 'Admin', '2019-07-26 12:03:16', '2019-07-26 12:03:16', 0, NULL),
	(24, 'Case Management', 'Case Management', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(25, 'Case Hearing', 'Case Hearing', 'Admin', 'Admin', '2019-07-26 12:03:57', '2019-07-26 12:03:57', 0, 'CaseManagement'),
	(26, 'Decision', 'Decision', 'Admin', 'Admin', '2019-07-26 12:04:10', '2019-07-26 12:04:10', 0, 'CaseManagement'),
	(27, 'Board Management', 'Board Management', 'Admin', 'Admin', '2019-07-26 12:04:23', '2019-07-26 12:04:23', 0, 'CaseManagement'),
	(28, 'Reports', 'Reports', 'Admin', 'Admin', '2019-07-26 12:04:36', '2019-07-26 12:04:36', 0, NULL),
	(29, 'DashBoards', 'DashBoards', 'Admin', 'Admin', '2019-07-26 15:19:29', '2019-07-26 15:19:29', 0, NULL),
	(30, 'Assign User Access', 'Assign User Access', 'Admin', 'Admin', '2019-07-29 11:03:54', '2019-07-29 11:03:57', 0, 'Admin'),
	(31, 'System Configurations', 'System Configurations', 'Admin', 'Admin', '2019-07-29 14:07:47', '2019-07-29 14:07:47', 0, NULL),
	(32, 'PeTypes', 'PeTypes', 'Admin', 'Admin', '2019-07-31 16:59:11', '2019-07-31 16:59:11', 0, 'Systemparameteres'),
	(33, 'Committee Types', 'Committee Types', 'Admin', 'Admin', '2019-08-01 10:21:59', '2019-08-01 10:21:59', 0, 'Systemparameteres'),
	(34, 'Procurement Methods', 'Procurement Methods', 'Admin', 'Admin', '2019-08-01 10:25:18', '2019-08-01 10:25:18', 0, 'Systemparameteres'),
	(35, 'System parameteres', 'System parameteres', 'Admin', 'Admin', '2019-08-01 10:49:11', '2019-08-01 10:49:11', 0, 'Systemparameteres'),
	(36, 'Standard Tender Documents', 'Standard Tender Documents', 'Admin', 'Admin', '2019-08-01 11:41:30', '2019-08-01 11:41:30', 0, 'Systemparameteres'),
	(37, 'Financial Year', 'Financial Year', 'Admin', 'Admin', '2019-08-01 13:32:48', '2019-08-01 13:32:48', 0, 'Systemparameteres'),
	(38, 'Fees structure', 'Fees structure', 'Admin', 'Admin', '2019-08-05 14:06:38', '2019-08-05 14:06:38', 0, 'Systemparameteres'),
	(39, 'Member types', 'Member types', 'Admin', 'Admin', '2019-08-05 14:44:33', '2019-08-05 14:44:33', 0, 'Systemparameteres'),
	(40, 'Tender Types', 'Tender Types', 'Admin', 'Admin', '2019-08-06 14:20:29', '2019-08-06 14:20:29', 0, 'Systemparameteres'),
	(41, 'Counties', 'Counties', 'Admin', 'Admin', '2019-08-06 14:34:26', '2019-08-06 14:34:26', 0, 'Systemparameteres'),
	(42, 'Procurement Entities', 'Procurement Entities', 'Admin', 'Admin', '2019-08-06 14:34:26', '2019-08-06 14:34:26', 0, 'Systemparameteres'),
	(43, 'Applicants', 'Applicants', 'Admin', 'Admin', '2019-08-06 14:34:26', '2019-08-06 14:34:26', 0, 'Systemparameteres'),
	(44, 'Tenders', 'Tenders', 'Admin', 'Admin', '2019-08-06 14:34:26', '2019-08-06 14:34:26', 0, 'Systemparameteres'),
	(45, 'Applications', 'Applications', 'Admin', 'Admin', '2019-08-14 15:55:53', '2019-08-14 15:55:53', 0, 'Systemparameteres'),
	(46, 'Approvers', 'Approvers', 'user', 'user', '2019-06-27 17:31:57', '2019-06-27 17:31:57', 0, 'Admin'),
	(47, 'Applications', 'Applications', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(48, 'Applications Approval', 'Applications Approval', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(49, 'Deadline Extension Approval', 'Deadline Extension Approval', 'user', 'user', '2019-06-27 17:30:15', '2019-06-27 17:30:15', 0, 'Admin'),
	(50, 'Venues', 'Venues', 'Admin', 'Admin', '2019-07-31 16:59:11', '2019-07-31 16:59:11', 0, 'Systemparameteres'),
	(51, 'Panel', 'Panel', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(52, 'Panels Approval', 'Panels Approval', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(53, 'Case officers', 'Case officers', 'user', 'user', '2019-06-27 17:30:36', '2019-06-27 17:30:36', 0, 'Admin'),
	(54, 'Case Scheduling', 'Case Scheduling', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(55, 'Branches', 'Branches', 'Admin', 'Admin', '2019-08-06 14:20:29', '2019-08-06 14:20:29', 0, 'Systemparameteres'),
	(56, 'Case Withdrawal', 'Case Withdrawal', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(57, 'Case Adjournment', 'Case Adjournment', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(58, 'Hearing Notices', 'Hearing Notices', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(59, 'Hearing In Progress', 'Hearing In Progress', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for procedure arcm.Saveadjournment
DROP PROCEDURE IF EXISTS `Saveadjournment`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Saveadjournment`(IN _Applicant VARCHAR(50),IN _ApplicationNo VARCHAR(50),IN _Reason text,IN _UserID varchar(50))
BEGIN
if(SELECT count(*)  from adjournment where ApplicationNo=_ApplicationNo)>0 THEN
BEGIN
Select 'Already submited' as msg;
END;
else
Begin
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Submited request for case withdrawal for application:',_ApplicationNo); 
select Username from approvers where ModuleCode='ADJRE' and Active=1 and Deleted=0 LIMIT 1 into @Approver;
insert into adjournment(Date,Applicant,ApplicationNo, Reason,Status ,Created_At, Created_By,Approver ) 
  VALUES(now(),_Applicant,_ApplicationNo,_Reason,'Pending Approval',now(),_UserID,@Approver);
 call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
call SaveNotification(@Approver,'Case Adjournment Approval','Case Adjournment pending approval',DATE_ADD(NOW(), INTERVAL 3 DAY));
Select 'Success' as msg,Email,Name,Phone from users where Username=@Approver;
  End;
  End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveadjournmentDocuments
DROP PROCEDURE IF EXISTS `SaveadjournmentDocuments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveadjournmentDocuments`(IN _ApplicationNo VARCHAR(50),IN _Description VARCHAR(155)
  ,IN _Path varchar(105),IN _name varchar(105),IN _UserID varchar(50))
BEGIN

DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Uploaded adjournment document for application:',_ApplicationNo); 

INSERT INTO `adjournmentdocuments`( `ApplicationNo`, `Description`, `Path`, `Filename`, `Deleted`, `Created_By`, `Created_At`) 
  VALUES (_ApplicationNo,_Description,_Path,_name,0,_UserID,now());
 call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );



END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveApplicant
DROP PROCEDURE IF EXISTS `SaveApplicant`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApplicant`(IN `_Name` VARCHAR(128), IN _Location VARCHAR(50),IN _POBox VARCHAR(50),IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _Mobile VARCHAR(50), IN _Telephone VARCHAR(50),IN _Email VARCHAR(100), IN _Logo VARCHAR(100),IN _Website VARCHAR(100), IN `_UserID` VARCHAR(50),IN _County VARCHAR(50),IN _RegistrationDate DateTime, IN _PIN VARCHAR(50),IN _RegistrationNo VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
DECLARE NewCode varchar(50);
select IFNULL(NextSupplier,1) from configurations   INTO @NextPE; 
set NewCode=CONCAT('AP-',@NextPE);
set lSaleDesc= CONCAT('Added new applicant with Name: ', _Name); 
INSERT INTO `applicants`
(`ApplicantCode`, `Name`,County, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`,  `Deleted`,RegistrationDate,PIN,RegistrationNo)
VALUES 
(NewCode,_Name,_County,_Location,_POBox,_PostalCode,_Town,_Mobile,_Telephone,_Email,_Logo,_Website,_UserID,now(),0,_RegistrationDate,_PIN,_RegistrationNo);

update configurations set NextSupplier= @NextPE+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveApplication
DROP PROCEDURE IF EXISTS `SaveApplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApplication`(IN `_TenderID` BIGINT, IN `_ApplicantID` BIGINT, IN `_PEID` VARCHAR(50), IN `_ApplicationREf` VARCHAR(50), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
DECLARE _ApplicationNo varchar(50);
select IFNULL(NextApplication,1) from configurations   INTO @ApplicationNo; 
select Username from approvers  where ModuleCode ='APFRE' and Level=1 and Deleted=0 and Active=1 INTO @Approver ; 

set _ApplicationNo=CONCAT('ARCM-AP-',@ApplicationNo);
set lSaleDesc= CONCAT('Added new Application with ApplicationNo:',_ApplicationNo); 
INSERT INTO `applications`( `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, `Created_By`, `Created_At`,  `Deleted`) 
VALUES (_TenderID,_ApplicantID,_PEID,now(),_ApplicationREf,_ApplicationNo,'Unverified',_userID,now(),0);

INSERT INTO applications_approval_workflow( `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, `Created_By`, `Created_At`,Approver) 
VALUES (_TenderID,_ApplicantID,_PEID,now(),_ApplicationREf,_ApplicationNo,'Pending Approval',_userID,now(),@Approver);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
update configurations set NextApplication= @ApplicationNo+1;

call SaveNotification(@Approver,'Applications Approval','Applications pending approval',DATE_ADD(NOW(), INTERVAL 3 DAY));


select MAX(ID) as ApplicationID,_ApplicationNo as ApplicationNo FROM applications where TenderID=_TenderID and ApplicantID=_ApplicantID and PEID=_PEID and Created_By=_userID;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveApplicationFees
DROP PROCEDURE IF EXISTS `SaveApplicationFees`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApplicationFees`(IN `_ApplicationID` int,IN _EntryType varchar(150),_AmountDue float,_RefNo VARCHAR(50), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Added Fee for Application: '+_ApplicationID); 
INSERT INTO 
`applicationfees`( `ApplicationID`, `EntryType`, `AmountDue`, `RefNo`, `BillDate`, `AmountPaid`,  `Created_By`, `Created_At`, Deleted) 
VALUES 
(_ApplicationID,_EntryType,_AmountDue,_RefNo,now(),0,_UserID,now(),0);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveApprover
DROP PROCEDURE IF EXISTS `SaveApprover`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApprover`(IN `_Username` VARCHAR(50),IN _ModuleCode varchar(50),_Level int, IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
set lSaleDesc= CONCAT('Added new Approver: '+_Username+' for module: '+_ModuleCode); 
INSERT INTO `approvers`( `Username`,ModuleCode ,`Level`, `Create_at`,`CreatedBy`,Active,Deleted) 
VALUES (_Username,_ModuleCode,_Level,now(),_UserID,1,0);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveAuditTrail
DROP PROCEDURE IF EXISTS `SaveAuditTrail`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveAuditTrail`(IN `_Username` VARCHAR(50), IN `_Description` VARCHAR(128), IN `_Category` VARCHAR(50), IN `_IpAddress` VARCHAR(50))
    NO SQL
BEGIN
INSERT INTO `audittrails`(`Date`, `Username`, `Description`, `Category`, `IpAddress`) VALUES (now(),_Username,_Description,_Category,_IpAddress);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveBranch
DROP PROCEDURE IF EXISTS `SaveBranch`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveBranch`(IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Added new Branch with Name: ', _Description); 
INSERT INTO branches(  `Description`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (_Description,now(),_UserID,now(),_UserID,0);

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveCaseOfficers
DROP PROCEDURE IF EXISTS `SaveCaseOfficers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveCaseOfficers`(IN _Username VARCHAR(50),IN _MinValue float,IN _MaxValue Float,IN _Active BOOLEAN,IN _NotAvailableFrom DateTime,IN _NotAvailableTo DateTime, IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Case Officer: ',_Username); 
INSERT INTO caseofficers
  (`Username`, `MinValue`, MaximumValue, `Active`, `NotAvailableFrom`, `NotAvailableTo`, `OngoingCases`, `CumulativeCases`, `Create_at`,  `CreatedBy`,  `Deleted`) 
  VALUES (_Username,_MinValue,_MaxValue,_Active,_NotAvailableFrom,_NotAvailableTo,0,0,now(),_UserID,0);
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveCaseWithdrawal
DROP PROCEDURE IF EXISTS `SaveCaseWithdrawal`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveCaseWithdrawal`(IN _Applicant VARCHAR(50),IN _ApplicationNo VARCHAR(50),IN _Reason VARCHAR(255),IN _UserID varchar(50))
BEGIN
if(SELECT count(*)  from casewithdrawal where ApplicationNo=_ApplicationNo)>0 THEN
BEGIN
Select 'Already submited' as msg;
END;
else
Begin
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Submited request for case withdrawal for application:',_ApplicationNo); 
select Username from approvers where ModuleCode='WIOAP' and Active=1 and Deleted=0 LIMIT 1 into @Approver;
insert into casewithdrawal(Date,Applicant,ApplicationNo, Reason,Status ,Created_At, Created_By,Approver ) 
  VALUES(now(),_Applicant,_ApplicationNo,_Reason,'Pending Approval',now(),_UserID,@Approver);
 call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
call SaveNotification(@Approver,'Case withdrawal Approval','Case withdrawal pending approval',DATE_ADD(NOW(), INTERVAL 3 DAY));
Select 'Success' as msg,Email,Name,Phone from users where Username=@Approver;
  End;
  End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savecommitteetypes
DROP PROCEDURE IF EXISTS `Savecommitteetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savecommitteetypes`(IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
select IFNULL(NextComm,1) from configurations   INTO @NextComm; 

set NewCode=CONCAT('COMT-',@NextComm);

set lSaleDesc= CONCAT('Added new committeetype with Name: ', _Description); 
INSERT INTO `committeetypes`( `Code`, `Description`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (NewCode,_Description,now(),_UserID,now(),_UserID,0);
update configurations set NextComm= @NextComm+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveConfigurations
DROP PROCEDURE IF EXISTS `SaveConfigurations`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveConfigurations`(IN _Name varchar(255),IN  _PhysicalAdress varchar(255),IN  _Street varchar(255),IN  _PoBox varchar(255),IN _PostalCode varchar(50),IN _Town varchar(100),IN _Telephone1 varchar(100),IN _Telephone2 varchar(100),IN _Mobile varchar(100),IN _Fax varchar(100),IN _Email varchar(100),IN _Website varchar(100),IN _PIN varchar(50),IN _Logo varchar(100),IN _UserID varchar(50),IN _Code varchar(50))
BEGIN
if(SELECT count(*)  from configurations)>0 THEN

		BEGIN
			UPDATE `configurations` SET Code=_Code,`Name`=_Name,`PhysicalAdress`=_PhysicalAdress,`Street`=_Street,`PoBox`=_PoBox,`PostalCode`=_PostalCode,`Town`=			_Town,`Telephone1`=_Telephone1,`Telephone2`=_Telephone2,`Mobile`=_Mobile,`Fax`=_Fax,`Email`=_Email,`Website`=_Website,
			`PIN`=_PIN,`Logo`=_Logo,

	`Updated_At`=now(),`Updated_By`=_UserID  ;
		
		END;
		ELSE
			BEGIN
				INSERT INTO configurations
				(Code, Name, PhysicalAdress, Street, PoBox, PostalCode, Town, Telephone1, 
				Telephone2, Mobile, Fax, Email, Website, PIN, Logo,
				NextPE, NextComm, NextSupplier,NextMember, NextProcMeth, NextStdDoc, NextApplication, NextRev, NextPEType,
				Created_At, Updated_At,
				Created_By, Updated_By, Deleted, Deleted_By) 
				VALUES
				(_Code,_Name,_PhysicalAdress,_Street,_PoBox,_PostalCode,_Town,_Telephone1,
				_Telephone2,_Mobile,_Fax,_Email,_Website,_PIN,_Logo,
				'1','1','1','1','1','1','1','1','1',
				now(),now(),_UserID,' ',0,' ');
			END;
		END IF;
		


END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savecounties
DROP PROCEDURE IF EXISTS `Savecounties`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savecounties`(IN _Code varchar(50),IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Added new county with Name: ', _Description); 
INSERT INTO `counties`( `Code`, `Name`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (_Code,_Description,now(),_UserID,now(),_UserID,0);

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveDocument
DROP PROCEDURE IF EXISTS `SaveDocument`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveDocument`(IN _ApplicationID BIGINT, IN `_Description` VARCHAR(525), IN `_File` VARCHAR(100),IN _Path VARCHAR(100),IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Added new Document for application: ', _ApplicationID); 
INSERT INTO `applicationdocuments`( `ApplicationID`, `Description`, `FileName`, `DateUploaded`, `Path`, `Created_By`, `Created_At`, `Deleted`)
VALUES (_ApplicationID,_Description,_File,now(),_Path,_UserID,now(),0);
call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savefeesstructure
DROP PROCEDURE IF EXISTS `Savefeesstructure`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savefeesstructure`(IN `_Description` VARCHAR(525), IN _MinAmount FLOAT,IN _MaxAmount FLOAT,IN _Rate1 FLOAT,IN _Rate2 FLOAT,IN _MinFee FLOAT, IN _MaxFee Float, IN _FixedFee Boolean, IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
DECLARE NewCode varchar(50);
select IFNULL(NextFeeCode,1) from configurations INTO @NextNextFeeCode; 
set NewCode=CONCAT('CH-',@NextNextFeeCode);

set lSaleDesc= CONCAT('Added new FeeStructure with Name: ', _Description); 
INSERT INTO `feesstructure`( `Code`, `Description`, `MinAmount`, `MaxAmount`, `Rate1`, `Rate2`, `MinFee`, `MaxFee`, `FixedFee`, `Created_At`, `Created_By`, `Deleted` ) 
VALUES 
(NewCode,_Description,_MinAmount,_MaxAmount,_Rate1,_Rate2,_MinFee,_MaxFee,_FixedFee,now(),_UserID,0);


update configurations set NextFeeCode= @NextNextFeeCode+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savefinancialyear
DROP PROCEDURE IF EXISTS `Savefinancialyear`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savefinancialyear`(IN `_Code` BIGINT, IN `_StartDate` datetime,IN `_EndDate` datetime,IN _IsCurrentYear TINYINT,IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new financialyear: ', _Code); 
INSERT INTO 
`financialyear`
( `Code`, `StartDate`, `EndDate`, `IsCurrentYear`, `Created_By`, `Created_At`, `Deleted`) 
VALUES 
(_Code,_StartDate,_EndDate,_IsCurrentYear,_UserID,now(),0);

	if(_IsCurrentYear=1) THEN
		BEGIN
		
		UPDATE financialyear SET IsCurrentYear=0 where `Code` <> _Code;
		call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
		END;
		END IF;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savegroundsandrequestedorders
DROP PROCEDURE IF EXISTS `Savegroundsandrequestedorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savegroundsandrequestedorders`(IN _ApplicationID BIGINT, IN _EntryType VARCHAR(200), IN _Description TEXT, IN _userID VARCHAR(50), IN _GroundNO VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Ground/Request for Application:',_ApplicationID); 
INSERT INTO groundsandrequestedorders( `ApplicationID`, Description,`EntryType`, `Status`, `Created_By`, `Created_At`,`Deleted`,GroundNO) 
VALUES (_ApplicationID,_Description,_EntryType,'Pending Review',_userID,now(),0,_GroundNO);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveHearingAttachments
DROP PROCEDURE IF EXISTS `SaveHearingAttachments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveHearingAttachments`(IN _ApplicationNo VARCHAR(50),IN _Name VARCHAR(50),IN _Description VARCHAR(255),IN _Path VARCHAR(255),IN _Category VARCHAR(50),IN _UserID VARCHAR(50))
BEGIN
  DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Uploaded hearing attachment for application:',_ApplicationNo); 
insert into hearingattachments ( ApplicationNo,Name ,Description ,Path ,Category ,UploadedOn ,UploadedBy ,Deleted)
  VALUES(_ApplicationNo,_Name,_Description,_Path,_Category,now(),_UserID,0);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveHearingNotice
DROP PROCEDURE IF EXISTS `SaveHearingNotice`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveHearingNotice`(IN _ApplicationNo VARCHAR(50), IN _Path VARCHAR(100),IN _Attachementname VARCHAR(105), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Generated hearing Notice for Application: ', _ApplicationNo); 
Insert into hearingnotices (ApplicationNo , DateGenerated , Path ,Filename,Created_By)
Values(_ApplicationNo,now(),_Path,_Attachementname,_UserID);
call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savemembertypes
DROP PROCEDURE IF EXISTS `Savemembertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savemembertypes`(IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
select IFNULL(NextMemberType,1) from configurations   INTO @NextComm; 

set NewCode=CONCAT('COMT-',@NextComm);

set lSaleDesc= CONCAT('Added new membertypes with Name: ', _Description); 
INSERT INTO `membertypes`( `Code`, `Description`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (NewCode,_Description,now(),_UserID,now(),_UserID,0);
update configurations set NextMemberType= @NextComm+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveNotification
DROP PROCEDURE IF EXISTS `SaveNotification`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveNotification`(IN `_UserName` VARCHAR(50), IN `_Category` VARCHAR(50), IN `_Description` VARCHAR(255), IN `_DueDate` DATETIME)
    NO SQL
BEGIN
INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status)
  VALUES (_Username,_Category,_Description,NOW(),_DueDate,'Not Resolved');

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePanel
DROP PROCEDURE IF EXISTS `SavePanel`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePanel`(IN _ApplicationNo VARCHAR(50), IN _Role VARCHAR(100), IN _UserName VARCHAR(50), IN _UserID varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Added new PanelMember for Application '+_ApplicationNo+': ', _UserName); 
  insert into panels (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By)
  Values (_ApplicationNo,_UserName,'Nominated',_Role,0,now(),_UserID);

  

  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savepanellist
DROP PROCEDURE IF EXISTS `Savepanellist`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Savepanellist`(IN _ApplicationNo VARCHAR(50), IN _Path VARCHAR(255), IN _Name VARCHAR(105), IN _UserID VARCHAR(50))
BEGIN
if(select count(*) from panellist where ApplicationNo=_ApplicationNo) <1 THEN
Begin
insert into panellist (  ApplicationNo ,  Path ,  FileName ,  GeneratedOn,GeneratedBy)
  VALUES(_ApplicationNo,_Path,_Name,now(),_UserID);
End;
End IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savepe
DROP PROCEDURE IF EXISTS `Savepe`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savepe`(IN _Name VARCHAR(128), IN _PEType VARCHAR(50), IN _Location VARCHAR(50), IN _POBox VARCHAR(50), IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _Mobile VARCHAR(50), IN _Telephone VARCHAR(50), IN _Email VARCHAR(100), IN _Logo VARCHAR(100), IN _Website VARCHAR(100), IN _UserID VARCHAR(50), IN _County VARCHAR(50), IN _RegistrationDate DATETIME, IN _PIN VARCHAR(50), IN _RegistrationNo VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
DECLARE NewCode varchar(50);
select IFNULL(NextPE,1) from configurations   INTO @NextPE; 

set NewCode=CONCAT('PE-',@NextPE);
set lSaleDesc= CONCAT('Added new PE with Name: ', _Name); 
INSERT INTO `procuremententity`
(`PEID`, `Name`, `PEType`,County, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`,  `Deleted`,
    RegistrationDate ,PIN,RegistrationNo)
  VALUES 
(NewCode,_Name,_PEType,_County,_Location,_POBox,_PostalCode,_Town,_Mobile,_Telephone,_Email,_Logo,_Website,_UserID,now(),0,_RegistrationDate,_PIN,_RegistrationNo);

update configurations set NextPE= @NextPE+1;

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePEResponse
DROP PROCEDURE IF EXISTS `SavePEResponse`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePEResponse`(IN _ApplicationNo VARCHAR(50), IN _ResponseType VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);

select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
set lSaleDesc= CONCAT(@PEID,' Responded to application:'+_ApplicationNo); 

if(SELECT count(*)  from peresponse where ApplicationNo=_ApplicationNo)>0 THEN
BEGIN

select 'Already Responded' as msg;
END;
ELSE
Begin
insert into peresponse (ApplicationNo ,PEID ,ResponseType,ResponseDate,Created_By , Created_At,Status,PanelStatus)
VALUES(_ApplicationNo,@PEID,_ResponseType,now(),_UserID,now(),'Not Submited','Undefined');
call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
select max(ID) as ID,'Not Resonded' as msg from peresponse where ApplicationNo=_ApplicationNo and PEID=@PEID and ResponseType=_ResponseType and Created_By=_UserID;

END;
End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePEResponseDetails
DROP PROCEDURE IF EXISTS `SavePEResponseDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePEResponseDetails`(IN _PERsponseID INT, IN _GrounNo VARCHAR(50), IN _Groundtype VARCHAR(50), IN _Response TEXT, IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Updated PE Response for Response ID: ',_PERsponseID);
insert into peresponsedetails ( PEResponseID ,  GroundNO ,  GroundType,  Response,  Created_At ,  Created_By )
  Values(_PERsponseID,_GrounNo,_Groundtype,_Response,now(),_UserID);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePEresponseDocuments
DROP PROCEDURE IF EXISTS `SavePEresponseDocuments`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePEresponseDocuments`(IN _PEResponseID INT, IN _Name VARCHAR(100), IN _Description VARCHAR(255), IN _Path VARCHAR(155))
BEGIN
insert into peresponsedocuments (PEResponseID ,Name ,Description ,Path , Created_At,Deleted )
  VALUES(_PEResponseID,_Name,_Description,_Path,now(),0);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePETimerResponse
DROP PROCEDURE IF EXISTS `SavePETimerResponse`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePETimerResponse`(IN _PEID VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _DueOn DATETIME)
BEGIN
  insert into peresponsetimer( PEID ,  ApplicationNo,  RegisteredOn ,  DueOn, Status)
    VALUES(_PEID,_ApplicationNo,now(),_DueOn,'Pending Acknowledgement');
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePEType
DROP PROCEDURE IF EXISTS `SavePEType`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SavePEType`(IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
select IFNULL(NextPEType,1) from configurations   INTO @NextPEType; 

set NewCode=CONCAT('PET-',@NextPEType);

set lSaleDesc= CONCAT('Added new PEType with Name: ', _Description); 
INSERT INTO `petypes`( `Code`, `Description`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (NewCode,_Description,now(),_UserID,now(),_UserID,0);
update configurations set NextPEType= @NextPEType+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePeUsers
DROP PROCEDURE IF EXISTS `SavePeUsers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePeUsers`(IN _Username VARCHAR(50), IN _PE VARCHAR(50))
BEGIN
  insert into PEUsers (UserName,PEID,Created_At, Created_by)
    VALUES(_Username,_PE,now(),_Username);

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Saveprocurementmethods
DROP PROCEDURE IF EXISTS `Saveprocurementmethods`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Saveprocurementmethods`(IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
select IFNULL(NextProcMeth,1) from configurations   INTO @Nextprocurementmethod; 
set NewCode=CONCAT('PROGM-',@Nextprocurementmethod);

set lSaleDesc= CONCAT('Added new procurementmethods with Name: ', _Description); 
INSERT INTO `procurementmethods`( `Code`, `Description`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (NewCode,_Description,now(),_UserID,now(),_UserID,0);
update configurations set NextProcMeth= @Nextprocurementmethod+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveRB1Form
DROP PROCEDURE IF EXISTS `SaveRB1Form`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveRB1Form`(IN _ApplicationNo VARCHAR(50), IN _Path VARCHAR(255), IN _Name VARCHAR(105), IN _UserID VARCHAR(50))
BEGIN
if(select count(*) from rb1forms where ApplicationNo=_ApplicationNo) <1 THEN
Begin
insert into rb1forms (  ApplicationNo ,  Path ,  FileName ,  GeneratedOn,GeneratedBy)
  VALUES(_ApplicationNo,_Path,_Name,now(),_UserID);
End;
End IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveRequestforDeadlineExtension
DROP PROCEDURE IF EXISTS `SaveRequestforDeadlineExtension`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveRequestforDeadlineExtension`(IN _ApplicationNo VARCHAR(50), IN _Reason TEXT, IN _Newdate DATETIME, IN _UserID VARCHAR(50))
BEGIN
  if(SELECT count(*)  from pedeadlineextensionsrequests where ApplicationNo=_ApplicationNo)<1 THEN
BEGIN
  select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
  insert into pedeadlineextensionsrequests(PEID ,ApplicationNo ,Reason ,RequestedDate,Created_At,Created_By ,Status)
  VALUES(@PEID,_ApplicationNo,_Reason,_Newdate,now(),_UserID,'Pending Approval');
  select Username from approvers where ModuleCode='REXED' and Deleted=0 and Active=1 LIMIT 1 into @Approver;
  insert into deadlineapprovalworkflow(PEID ,ApplicationNo ,Reason ,RequestedDate,Created_At,Created_By ,Status,Approver)
  VALUES(@PEID,_ApplicationNo,_Reason,_Newdate,now(),_UserID,'Pending Approval',@Approver);
  select Name,Email,Phone from users where Username=@Approver;
  CALL SaveNotification(@Approver ,'Deadline Approval','Deadline Approval Request', NOW() + INTERVAL 3 DAY);
END;
ELSE

Begin
Update pedeadlineextensionsrequests set Reason=_Reason,RequestedDate=_Newdate where ApplicationNo=_ApplicationNo; 
Update deadlineapprovalworkflow set Reason=_Reason,RequestedDate=_Newdate where ApplicationNo=_ApplicationNo; 
  select Username from approvers where ModuleCode='REXED' and Deleted=0 and Active=1 LIMIT 1 into @Approver;
  select Name,Email,Phone from users where Username=@Approver;
END;

 END IF;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveRole
DROP PROCEDURE IF EXISTS `SaveRole`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveRole`(IN `_RoleName` VARCHAR(50), IN `_RoleDescription` VARCHAR(128), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Role with Name: ', _RoleName ,' and desc',_RoleDescription); 
INSERT INTO `roles`(`RoleName`, `RoleDescription`, `UpdateBy`, `CreateBy`, `CreatedAt`,`UpdatedAt`, `Deleted`) VALUES (_RoleName,_RoleDescription,_UserID,_UserID,Now(),Now(),0);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveSchedule
DROP PROCEDURE IF EXISTS `SaveSchedule`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveSchedule`(IN _Username VARCHAR(50), IN _start DATETIME, IN _end DATETIME, IN _title VARCHAR(255))
BEGIN
insert into schedules(UserName,start,end,title) VALUES (_Username,_start,_end,_title);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savesms
DROP PROCEDURE IF EXISTS `Savesms`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savesms`(IN `_Recepient` VARCHAR(100), IN `_SenderID` VARCHAR(100), IN `_Message` VARCHAR(255))
    NO SQL
BEGIN
INSERT INTO `sentsms`(`Recepient`, `SenderID`, `Message`, `SentTime`) VALUES (_Recepient,_SenderID,_Message,now());
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savestdtenderdocs
DROP PROCEDURE IF EXISTS `Savestdtenderdocs`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savestdtenderdocs`(IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
select IFNULL(NextStdDoc,1) from configurations INTO @Nextstdtenderdocs; 

set NewCode=CONCAT('STDOC-',@Nextstdtenderdocs);

set lSaleDesc= CONCAT('Added new stdtenderdoc with Name: ', _Description); 
INSERT INTO `stdtenderdocs`( `Code`, `Description`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (NewCode,_Description,now(),_UserID,now(),_UserID,0);
update configurations set NextStdDoc= @Nextstdtenderdocs+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveTender
DROP PROCEDURE IF EXISTS `SaveTender`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveTender`(IN `_TenderNo` VARCHAR(100), IN `_Name` VARCHAR(150), IN `_PEID` VARCHAR(50), IN `_StartDate` DateTime, IN `_ClosingDate` DateTime, IN `_userID` VARCHAR(50),IN _TenderValue FLOAT)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Tender with TenderNo:',_TenderNo); 

INSERT INTO `tenders`( `TenderNo`, `Name`, `PEID`,TenderValue, `StartDate`, `ClosingDate`, `Created_By`, `Created_At`, `Updated_At`,  `Deleted`) 
VALUES (_TenderNo,_Name,_PEID,_TenderValue,_StartDate,_ClosingDate,_userID,now(),now(),0);

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

select MAX(ID) as TenderID FROM tenders where TenderNo=_TenderNo and Name=_Name and PEID=_PEID and Created_By=_userID;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.Savetenderaddendums
DROP PROCEDURE IF EXISTS `Savetenderaddendums`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savetenderaddendums`(IN _TenderID VARCHAR(100), IN _Description VARCHAR(200), IN _StartDate DATETIME, IN _ClosingDate DATETIME, IN _userID VARCHAR(50), IN _AdendumNo VARCHAR(100))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Tender Addendum for TenderID:',_TenderID); 
INSERT INTO `tenderaddendums`( `TenderID`, `Description`, `StartDate`, `ClosingDate`, `Created_By`, `Created_At`, `Deleted`,AdendumNo)
VALUES (_TenderID,_Description,_StartDate,_ClosingDate,_userID,now(),0,_AdendumNo);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Savetendertypes
DROP PROCEDURE IF EXISTS `Savetendertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savetendertypes`(IN `_Description` VARCHAR(525), IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
select IFNULL(NextTenderType,1) from configurations   INTO @NextComm; 

set NewCode=CONCAT('TTYP-',@NextComm);

set lSaleDesc= CONCAT('Added new tendertype with Name: ', _Description); 
INSERT INTO `tendertypes`( `Code`, `Description`, `Created_At`,Created_By, `Updated_At`, `Updated_By`, `Deleted` ) 
VALUES (NewCode,_Description,now(),_UserID,now(),_UserID,0);
update configurations set NextTenderType= @NextComm+1;
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveUser
DROP PROCEDURE IF EXISTS `SaveUser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveUser`(IN `_Name` VARCHAR(120), IN `_Email` VARCHAR(128), IN `_Password` VARCHAR(128), IN `_UserGroupID` BIGINT, IN `_Username` VARCHAR(50), IN `_userID` VARCHAR(50), IN `_Phone` VARCHAR(20),IN _Signature VARCHAR(128),IN _IsActive Boolean,in _IDnumber INT,in _DOB DATETIME,in _Gender VARCHAR(50),_ActivationCode varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new User with username:',_Username); 

INSERT INTO `users`(`Name`, `Username`, `Email`, `Phone`,`Password`, `Create_at`,  `Deleted`, `IsActive`, `IsEmailverified`,ActivationCode, `UserGroupID`,CreatedBy,Category,Signature,Photo,IDnumber,Gender,DOB,ChangePassword) 

VALUES (_Name,_Username,_Email,_Phone,_Password,now(),0,_IsActive,0,_ActivationCode,_UserGroupID,_userID,'System_User',_Signature,'default.png',_IDnumber,_Gender,_DOB,1);

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

INSERT INTO `useraccess`(`Username`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`) SELECT _Username,RoleID,Edit,Remove,AddNew,View,Export,_userID,_userID,NOW(),NOW() FROM groupaccess WHERE UserGroupID=_UserGroupID;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveuserAcces
DROP PROCEDURE IF EXISTS `SaveuserAcces`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveuserAcces`(IN `_Username` VARCHAR(50), IN `_RoleID` BIGINT, IN `_Edit` BOOLEAN, IN `_Remove` BOOLEAN, IN `_AddNew` BOOLEAN, IN `_View` BOOLEAN, IN `_Export` BOOLEAN, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
if(SELECT count(*)  from useraccess where Username=_Username and  RoleID=_RoleID)>0 THEN
BEGIN

set lSaleDesc= CONCAT('Updated  useraccess of role for user: ', _Username ); 
Update useraccess set Edit=_Edit,Remove=_Remove,AddNew=_AddNew,View=_View,Export=_Export,UpdateBy=_userID,UpdatedAt=NOW() where Username=_Username and  RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
ELSE
BEGIN
set lSaleDesc= CONCAT('Added new useraccess for user: ', _Username ); 
INSERT INTO `useraccess`(`Username`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`) VALUES (_Username,_RoleID,_Edit,_Remove,_AddNew,_View,_Export,_userID,_userID,NOW(),NOW());

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END;
 END IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveUserGroup
DROP PROCEDURE IF EXISTS `SaveUserGroup`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveUserGroup`(IN `_Name` VARCHAR(128), IN `_Description` VARCHAR(128), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new UserGroup with name: ',_Name ,'and Decs: ',_Description); 



INSERT INTO `usergroups`(`Name`, `Description`, `CreatedAt`, `UpdatedAt`, `Deleted`,CreatedBy,UpdatedBy) 
VALUES (_Name,_Description,now(),now(),0,_userID,_userID);

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Savevenues
DROP PROCEDURE IF EXISTS `Savevenues`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Savevenues`(in _Name VARCHAR(100),IN _Description VARCHAR(150),IN _UserID varchar(50),IN _Branch INT)
BEGIN
  DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Added new Venue with Name: ', _Name); 
  Insert INTo venues (Name,Branch ,Description , Deleted , Created_At , Created_By)
  VALUES(_Name,_Branch,_Description,0,now(),_UserID);
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for table arcm.schedules
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE IF NOT EXISTS `schedules` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.schedules: ~0 rows (approximately)
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;

-- Dumping structure for procedure arcm.selfAttendanceregistration
DROP PROCEDURE IF EXISTS `selfAttendanceregistration`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `selfAttendanceregistration`(IN _RegisterID INT(11), IN _Name VARCHAR(100), IN _IDNO VARCHAR(50), IN _MobileNo VARCHAR(50), IN _Category VARCHAR(55), IN _UserID VARCHAR(50), IN _Email VARCHAR(100))
BEGIN
if(SELECT count(*)  from attendanceregister where IDNO=_IDNO and RegisterID=_RegisterID)=0 THEN
BEGIN

DECLARE lSaleDesc varchar(200);
select ApplicationNo from casesittingsregister where ID=_RegisterID LIMIT 1 into @ApplicationNo;
set lSaleDesc= CONCAT('Attended hearing for Application:',@ApplicationNo); 
INSERT INTO attendanceregister (RegisterID ,IDNO,MobileNo ,Name,Email ,Category ,Created_At,Created_By)
VALUES(_RegisterID,_IDNO,_MobileNo,_Name,_Email,_Category,now(),_UserID);
call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');
select 'Success' as msg;
END;

Else
Begin
select 'ALready Registered' as msg;
End;
End if;

END//
DELIMITER ;

-- Dumping structure for table arcm.sentsms
DROP TABLE IF EXISTS `sentsms`;
CREATE TABLE IF NOT EXISTS `sentsms` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Recepient` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SenderID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SentTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.sentsms: ~0 rows (approximately)
/*!40000 ALTER TABLE `sentsms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sentsms` ENABLE KEYS */;

-- Dumping structure for procedure arcm.SetSentHearingNotice
DROP PROCEDURE IF EXISTS `SetSentHearingNotice`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetSentHearingNotice`(IN _ApplicationNo VARCHAR(50))
BEGIN

Update hearingnotices set DateSent=now() where ApplicationNo=_ApplicationNo;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Signup
DROP PROCEDURE IF EXISTS `Signup`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Signup`(IN `_Name` VARCHAR(120), IN `_Username` VARCHAR(50), IN `_Email` VARCHAR(128), IN `_Phone` VARCHAR(20), IN `_Password` VARCHAR(128), IN `_Category` VARCHAR(50), IN `_ActivationCode` VARCHAR(100),IN _IDnumber int,IN _Gender varchar(50),IN _DOB DateTime)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
select UserGroupID from usergroups where name='Portal users'   INTO @userGroup; 
set lSaleDesc= CONCAT('New Sign up with username:',_Username); 
INSERT INTO `users`(`Name`, `Username`, `Email`, `Phone`,`Password`, `Create_at`,  `Deleted`, `IsActive`, `IsEmailverified`, `ActivationCode`, `UserGroupID`,CreatedBy,Category,Photo,IDnumber,Gender,DOB,ChangePassword) 
VALUES (_Name,_Username,_Email,_Phone,_Password,Now(),0,0,0,_ActivationCode,@userGroup,_Username,_Category,'default.png',_IDnumber,_Gender,_DOB,0);

INSERT INTO `useraccess`(`Username`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`,  `CreateBy`, `CreatedAt`) SELECT _Username,RoleID,Edit,Remove,AddNew,View,Export,_Username,NOW() FROM groupaccess WHERE UserGroupID=@userGroup;
End//
DELIMITER ;

-- Dumping structure for table arcm.smsdetails
DROP TABLE IF EXISTS `smsdetails`;
CREATE TABLE IF NOT EXISTS `smsdetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SenderID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UserName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `URL` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Key` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.smsdetails: ~0 rows (approximately)
/*!40000 ALTER TABLE `smsdetails` DISABLE KEYS */;
INSERT INTO `smsdetails` (`ID`, `SenderID`, `UserName`, `URL`, `Key`) VALUES
	(1, 'WILCOM-TVET', 'ARCM', 'http://api.mspace.co.ke/mspaceservice/wr/sms/sendtext/', '1234561');
/*!40000 ALTER TABLE `smsdetails` ENABLE KEYS */;

-- Dumping structure for table arcm.smtpdetails
DROP TABLE IF EXISTS `smtpdetails`;
CREATE TABLE IF NOT EXISTS `smtpdetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Host` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Port` int(255) DEFAULT NULL,
  `Sender` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.smtpdetails: ~0 rows (approximately)
/*!40000 ALTER TABLE `smtpdetails` DISABLE KEYS */;
INSERT INTO `smtpdetails` (`ID`, `Host`, `Port`, `Sender`, `Password`) VALUES
	(1, 'smtp.gmail.com', 465, 'arcmdevelopment@gmail.com\r\n', 'Arcm1234');
/*!40000 ALTER TABLE `smtpdetails` ENABLE KEYS */;

-- Dumping structure for procedure arcm.sp_ValidatePrivilege
DROP PROCEDURE IF EXISTS `sp_ValidatePrivilege`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidatePrivilege`(IN `_Username` VARCHAR(50), IN `_RoleName` VARCHAR(128))
    NO SQL
BEGIN
SELECT `Username`, useraccess.RoleID, `Edit`, `Remove`, `AddNew`, `View`, `Export` FROM `useraccess` 
inner join roles on useraccess.RoleID=roles.RoleID  where Username=_Username and Roles.RoleName=_RoleName;

END//
DELIMITER ;

-- Dumping structure for table arcm.stdtenderdocs
DROP TABLE IF EXISTS `stdtenderdocs`;
CREATE TABLE IF NOT EXISTS `stdtenderdocs` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.stdtenderdocs: ~2 rows (approximately)
/*!40000 ALTER TABLE `stdtenderdocs` DISABLE KEYS */;
INSERT INTO `stdtenderdocs` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(10, 'STDOC-1', 'Civil Engineering Works', '2019-08-01 11:42:28', 'Admin', '2019-10-04 09:49:43', 'Admin', 0, NULL),
	(11, 'STDOC-2', 'Works(Building and associated)', '2019-08-01 11:43:04', 'Admin', '2019-08-01 11:45:21', 'Admin', 0, NULL),
	(12, 'STDOC-3', 'Tender Register', '2019-08-01 11:43:32', 'Admin', '2019-08-01 11:44:02', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `stdtenderdocs` ENABLE KEYS */;

-- Dumping structure for procedure arcm.SubmitApprovedPanelList
DROP PROCEDURE IF EXISTS `SubmitApprovedPanelList`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitApprovedPanelList`(IN _UserID varchar(50),IN _ApplicationNo varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);

select Level from approvers  where ModuleCode ='PAREQ' and Username=_UserID LIMIT 1 INTO @CurentLevel;
call ResolveMyNotification(_UserID,'Panel Approval');
if(SELECT count(*)  from approvers where ModuleCode ='PAREQ'  and  Level=@CurentLevel + 1)>0 THEN
Begin

  select Username from approvers where ModuleCode='PAREQ' and Level=@CurentLevel+1 and Deleted=0 and Active=1  limit 1 into @Approver;
  insert into panelsapprovalworkflow (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By,Approver)
  select ApplicationNo , UserName ,'Pending Approval',Role , Deleted , Created_At,Created_By,@Approver from panels where panels.ApplicationNo=_ApplicationNo and Deleted=0;
   update Panels set Status='Partialy Approved' where ApplicationNo=_ApplicationNo and Status='Approved';   
  call SaveNotification(@Approver,'Panel Approval','Panel Lists Awiting Approval',DATE_ADD(NOW(), INTERVAL 3 DAY));
  select Name,Email,Phone, 'Partially Approved' as msg,_ApplicationNo as ApplicationNo from users where Username= @Approver;
 
  
  End;
  Else
  Begin
   
    select Name,Email,Phone,_ApplicationNo as ApplicationNo,'Approved' as msg from users inner join panels on panels.UserName=users.Username where panels.ApplicationNo=_ApplicationNo and panels.Deleted=0 and panels.Status='Approved';
 
  End;
  End IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SubmitPanelList
DROP PROCEDURE IF EXISTS `SubmitPanelList`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitPanelList`(IN _UserID varchar(50),IN _ApplicationNo varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Submited PanelList  for Application: ',_ApplicationNo); 
  Update peresponse set PanelStatus='Submited' where peresponse.ApplicationNo=_ApplicationNo;

  select Username from approvers where ModuleCode='PAREQ' and Level=1 and Deleted=0 and Active=1  limit 1 into @Approver;
  insert into panelsapprovalworkflow (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By,Approver)
  select ApplicationNo , UserName ,'Pending Approval',Role , Deleted , Created_At,Created_By,@Approver from panels where panels.ApplicationNo=_ApplicationNo and Deleted=0;
  select Name,Email,Phone, 'Partially Approved' as msg,_ApplicationNo as ApplicationNo from users where Username= @Approver;
  call SaveNotification(@Approver,'Panel Approval','Panel Lists Awiting Approval',DATE_ADD(NOW(), INTERVAL 3 DAY));
  
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
  call ResolveMyNotification(_UserID,'Panel Formation');
  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SubmitPeResponse
DROP PROCEDURE IF EXISTS `SubmitPeResponse`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitPeResponse`(IN _RespID INT, IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN

  select PEID from peresponse where ID=_RespID and ApplicationNo=_ApplicationNo LIMIT 1 INTO @PEID;    
  update peresponse set status='Submited' where ID=_RespID and ApplicationNo=_ApplicationNo;
 -- select Name,Email,Mobile from procuremententity where PEID=@PEID;
  update peresponsetimer set Status='Responded' where ApplicationNo=_ApplicationNo and PEID=@PEID;
  select UserName from casedetails where ApplicationNo=_ApplicationNo and PrimaryOfficer=1 and Status='Open' LIMIT 1 into @Approver;
  call SaveNotification(@Approver,'Panel Formation','Applications Awiting panel formation',DATE_ADD(NOW(), INTERVAL 3 DAY));
   
  DROP TABLE IF EXISTS caseWithdrawalContacts;
  create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Role varchar(50));
  insert into caseWithdrawalContacts select Name,Email,Phone,'Panel' from users where Username in (select UserName from panels where ApplicationNo=_ApplicationNo and Status='Approved') ;
  insert into caseWithdrawalContacts select Name,Email,Phone,'Case officer' from users where Username in (select UserName from casedetails where  ApplicationNo=_ApplicationNo and Deleted=0);
  -- select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
  insert into caseWithdrawalContacts select Name,Email,Phone,'PE' from users where Username in (select UserName from peusers where PEID=@PEID);
  insert into caseWithdrawalContacts select Name,Email,Mobile,'PE' from procuremententity where PEID=@PEID;
  select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
  insert into caseWithdrawalContacts select Name,Email,Phone,'Applicant' from users where Username =@Applicant;
  select ApplicantID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
  insert into caseWithdrawalContacts select Name,Email,Mobile,'Applicant' from applicants where  ID=@ApplicantID;
  select * from caseWithdrawalContacts;

END//
DELIMITER ;

-- Dumping structure for table arcm.tempusers
DROP TABLE IF EXISTS `tempusers`;
CREATE TABLE IF NOT EXISTS `tempusers` (
  `Name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `OngoingCases` int(11) NOT NULL,
  `CumulativeCases` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tempusers: ~2 rows (approximately)
/*!40000 ALTER TABLE `tempusers` DISABLE KEYS */;
INSERT INTO `tempusers` (`Name`, `OngoingCases`, `CumulativeCases`) VALUES
	('Admin', 28, 18),
	('Admin2', 28, 6);
/*!40000 ALTER TABLE `tempusers` ENABLE KEYS */;

-- Dumping structure for table arcm.tenderaddendums
DROP TABLE IF EXISTS `tenderaddendums`;
CREATE TABLE IF NOT EXISTS `tenderaddendums` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenderID` bigint(20) NOT NULL,
  `ApplicantID` bigint(20) NOT NULL,
  `Description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `ClosingDate` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AdendumNo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_TenderID` (`TenderID`),
  CONSTRAINT `FK_TenderID` FOREIGN KEY (`TenderID`) REFERENCES `tenders` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tenderaddendums: ~0 rows (approximately)
/*!40000 ALTER TABLE `tenderaddendums` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenderaddendums` ENABLE KEYS */;

-- Dumping structure for table arcm.tenders
DROP TABLE IF EXISTS `tenders`;
CREATE TABLE IF NOT EXISTS `tenders` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenderNo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TenderValue` float(255,0) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `ClosingDate` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`TenderNo`),
  UNIQUE KEY `UK_tenders_ID` (`ID`),
  KEY `FK_PEID` (`PEID`),
  KEY `ID` (`ID`),
  CONSTRAINT `FK_PEID` FOREIGN KEY (`PEID`) REFERENCES `procuremententity` (`PEID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tenders: ~3 rows (approximately)
/*!40000 ALTER TABLE `tenders` DISABLE KEYS */;
INSERT INTO `tenders` (`ID`, `TenderNo`, `Name`, `PEID`, `TenderValue`, `StartDate`, `ClosingDate`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`) VALUES
	(1, 'CGS/SCM/WENR/OT/18-19/081', 'PROPOSED ESTABLISHMENT OF TREE NURSERIES AND TREE SEEDLINGS IN UGUNJA', 'PE-2', 100000, '2019-09-30 00:00:00', '2019-10-29 00:00:00', 'Applicant', '2019-10-01 11:07:04', '2019-10-01 11:07:04', NULL, 0, NULL, NULL),
	(2, 'CGS/SCM/WENR/OT/18-19/081', 'PROPOSED ESTABLISHMENT OF TREE NURSERIES AND TREE SEEDLINGS IN UGUNJA', 'PE-2', 123456, '2019-10-02 00:00:00', '2019-10-27 00:00:00', 'Applicant', '2019-10-02 15:05:21', '2019-10-02 15:05:21', NULL, 0, NULL, NULL),
	(3, 'CGS/SCM/WENR/OT/18-19/081', 'PROPOSED ESTABLISHMENT OF TREE NURSERIES AND TREE SEEDLINGS IN UGUNJA', 'PE-2', 1234567, '2019-10-02 00:00:00', '2019-10-30 00:00:00', 'Applicant', '2019-10-02 15:17:24', '2019-10-02 15:17:24', NULL, 0, NULL, NULL),
	(4, 'CGS/SCM/WENR/OT/18-19/081', 'PROPOSED ESTABLISHMENT OF TREE NURSERIES AND TREE SEEDLINGS IN UGUNJA', 'PE-2', 123456, '2019-10-02 00:00:00', '2019-10-30 00:00:00', 'Applicant', '2019-10-02 15:31:33', '2019-10-02 15:31:33', NULL, 0, NULL, NULL);
/*!40000 ALTER TABLE `tenders` ENABLE KEYS */;

-- Dumping structure for table arcm.tendertypes
DROP TABLE IF EXISTS `tendertypes`;
CREATE TABLE IF NOT EXISTS `tendertypes` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tendertypes: ~4 rows (approximately)
/*!40000 ALTER TABLE `tendertypes` DISABLE KEYS */;
INSERT INTO `tendertypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(10, 'TTYP-1', 'Open tender', '2019-08-06 14:21:12', 'Admin', '2019-08-06 14:21:12', 'Admin', 1, 'Admin'),
	(11, 'TTYP-2', 'Open Tender', '2019-08-06 14:21:35', 'Admin', '2019-10-04 10:03:39', 'Admin', 0, NULL),
	(12, 'TTYP-3', 'Selective Tender', '2019-08-06 14:21:44', 'Admin', '2019-08-06 14:22:30', 'Admin', 0, NULL),
	(13, 'TTYP-4', 'Negotiated Tender', '2019-08-06 14:21:56', 'Admin', '2019-08-06 14:22:18', 'Admin', 0, NULL),
	(14, 'TTYP-5', 'Single-stage and two-stage tender', '2019-08-06 14:22:06', 'Admin', '2019-08-06 14:22:06', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `tendertypes` ENABLE KEYS */;

-- Dumping structure for table arcm.towns
DROP TABLE IF EXISTS `towns`;
CREATE TABLE IF NOT EXISTS `towns` (
  `PostCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Postoffice` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.towns: ~888 rows (approximately)
/*!40000 ALTER TABLE `towns` DISABLE KEYS */;
INSERT INTO `towns` (`PostCode`, `Postoffice`, `Town`) VALUES
	('20113', 'BAHATI', 'BAHATI'),
	('80101', 'BAMBURI', 'MOMBASA'),
	('50316', 'BANJA', 'BANJA'),
	('50411', 'BAR OBER', 'BAR OBER'),
	('20601', 'BARAGOI', 'BARAGOI'),
	('30306', 'BARATON', 'BARATON'),
	('10302', 'BARICHO', 'BARICHO'),
	('30412', 'BARTOLIMO', 'BARTOLIMO'),
	('30412', 'BARWESA', 'BARWESA'),
	('01101', 'BISSIL', 'BISSIL'),
	('50206', 'BOKOLI', 'BOKOLI'),
	('20400', 'BOMET', 'BOMET'),
	('20101', 'BONDENI', 'BONDENI'),
	('40601', 'BONDO', 'BONDO'),
	('50137', 'BOOKER', 'BOOKER'),
	('40620', 'BORO', 'BORO'),
	('50415', 'BUDALANGI', 'BUDALANGI'),
	('30702', 'BUGAR', 'BUGAR'),
	('50416', 'BUHUYI', 'BUHUYI'),
	('50233', 'BUKEMBE', 'BUKEMBE'),
	('50417', 'BUKIRI', 'BUKIRI'),
	('50105', 'BUKURA', 'BUKURA'),
	('50109', 'BULIMBO', 'BULIMBO'),
	('50404', 'BUMALA', 'BUMALA'),
	('05041', 'BUMUTIRU', 'BUMUTIRU'),
	('50200', 'BUNGOMA', 'BUNGOMA'),
	('50301', 'BUNYORE', 'BUNYORE'),
	('70104', 'BURATANA', 'BURATANA'),
	('30102', 'BURNT FOREST', 'BURNT FOREST'),
	('00515', 'BURU BURU', 'NAIROBI'),
	('50400', 'BUSIA', 'BUSIA'),
	('50101', 'BUTERE', 'BUTERE'),
	('50405', 'BUTULA', 'BUTULA'),
	('50210', 'BUYOFU', 'BUYOFU'),
	('50302', 'CHAMAKANGA', 'CHAMAKANGA'),
	('80102', 'CHANGAMWE', 'MOMBASA'),
	('50317', 'CHAVAKALI', 'CHAVAKALI'),
	('30706', 'CHEBIEMIT', 'CHEBIEMIT'),
	('20215', 'CHEBORGE', 'CHEBORGE'),
	('30125', 'CHEBORORWA', 'CHEBORORWA'),
	('20401', 'CHEBUNYO', 'CHEBUNYO'),
	('20222', 'CHEMAMUL', 'CHEMAMUL'),
	('20407', 'CHEMANER', 'CHEMANER'),
	('40143', 'CHEMASE', 'CHEMASE'),
	('40116', 'CHEMELIL', 'CHEMELIL'),
	('30206', 'CHEMIRON', 'CHEMIRON'),
	('30605', 'CHEPARERIA', 'CHEPARERIA'),
	('30129', 'CHEPKORIO', 'CHEPKORIO'),
	('30309', 'CHEPSONOI', 'CHEPSONOI'),
	('50201', 'CHEPTAIS', 'CHEPTAIS'),
	('20410', 'CHEPTALAL', 'CHEPTALAL'),
	('30121', 'CHEPTERWAI', 'CHEPTERWAI'),
	('30709', 'CHEPTONGEI', 'CHEPTONGEI'),
	('20217', 'CHEPSINENDET', 'CHEPSINENDET'),
	('30712', 'CHESOI', 'CHESOI'),
	('60410', 'CHIAKANYINGA', 'CHIAKANYINGA'),
	('60409', 'CHAIKARIGA', 'CHAIKARIGA'),
	('60401', 'CHOGORIA', 'CHOGORIA'),
	('60400', 'CHUKA', 'CHUKA'),
	('90219', 'CHUVULI', 'CHUVULI'),
	('90147', 'CHUMVI', 'CHUMVI'),
	('80314', 'CHUMVINI', 'CHUMVINI'),
	('50202', 'CHWELE', 'CHWELE'),
	('00200', 'CITY SQUARE', 'NAIROBI'),
	('80103', 'COAST GEN HSP', 'MOMBASA'),
	('70103', 'DADAAB', 'DADAAB'),
	('40112', 'DAGO', 'DAGO'),
	('00516', 'DANDORA', 'NAIROBI'),
	('40117', 'DARAJAMBILI', 'DARAJAMBILI'),
	('90145', 'DAYSTAR UNIVERSITY', 'DAYSTAR UNIVERSITY'),
	('40331', 'DEDE', 'DEDE'),
	('80401', 'DIANI BEACH', 'DIANI BEACH'),
	('80104', 'DOCKS', 'DOCKS'),
	('10401', 'DOLDOL', 'DOLDOL'),
	('50213', 'DOROFU', 'DOROFU'),
	('40621', 'DUDI', 'DUDI'),
	('20118', 'DUNDORI', 'DUNDORI'),
	('00610', 'EASTLEIGH', 'NAIROBI'),
	('20115', 'EGERTON UNIVERSITY', 'EGERTON UNIVERSITY'),
	('90139', 'EKALAKALA', 'EKALAKALA'),
	('70301', 'EL WAK', 'EL WAK'),
	('20102', 'ELBURGON', 'ELBURGON'),
	('20103', 'ELDAMA RAVINE  ', 'ELDAMA RAVINE  '),
	('30124', 'ELDORET AIRPORT', 'ELDORET'),
	('30100', 'ELDORET GPO', 'ELDORET'),
	('20119', 'ELEMENTATITA', 'ELEMENTATITA'),
	('50429', 'ELUGULU', 'ELUGULU'),
	('90121', 'EMALI', 'EMALI'),
	('00501', 'EMBAKASI', 'NAIROBI'),
	('60100', 'EMBU', 'EMBU'),
	('20140', 'EMINING', 'EMINING'),
	('50314', 'EMUHAYA', 'EMUHAYA'),
	('10107', 'ENDARASHA', 'ENDARASHA'),
	('90206', 'ENDAU', 'ENDAU'),
	('30201', 'ENDEBESS', 'ENDEBESS'),
	('40703', 'ENOSAEN', 'ENOSAEN'),
	('00500', 'ENTERPRISE ROAD', 'NAIROBI'),
	('50303', 'EREGI', 'EREGI'),
	('40208', 'ETAGO', 'ETAGO'),
	('00242', 'EWASOKEDONG', 'EWASOKEDONG'),
	('80501', 'FAZA', 'FAZA'),
	('20209', 'FORT TERNAN', 'FORT TERNAN'),
	('50406', 'FUNYULA', 'FUNYULA'),
	('10210', 'GACHARAGE-INI', 'GACHARAGE-INI'),
	('60119', 'GACHOKA', 'GACHOKA'),
	('60209', 'GAITU', 'GAITU'),
	('10109', 'GAKERE ROAD', 'GAKERE ROAD'),
	('10111', 'GAKINDU', 'GAKINDU'),
	('50318', 'GAMBOGI', 'GAMBOGI'),
	('80205', 'GANZE', 'GANZE'),
	('60301', 'GARBATULLA', 'GARBATULLA'),
	('70100', 'GARISSA', 'GARISSA'),
	('80201', 'GARSEN', 'GARSEN'),
	('10212', 'GATARA', 'GATARA'),
	('00239', 'GATHIRUINI', 'GATHIRUINI'),
	('00240', 'GATHUGU', 'GATHUGU'),
	('60217', 'GATIMBI', 'GATIMBI'),
	('10114', 'GATITU', 'GATITU'),
	('10115', 'GATONDO', 'GATONDO'),
	('10305', 'GATUGURA', 'GATUGURA'),
	('01028', 'GATUKUYU', 'GATUKUYU'),
	('01030', 'GATUNDU', 'GATUNDU'),
	('60404', 'GATUNGA', 'GATUNGA'),
	('01013', 'GATURA', 'GATURA'),
	('80208', 'GEDE', 'GEDE'),
	('40312', 'GEMBE', 'GEMBE'),
	('40503', 'GESIMA', 'GESIMA'),
	('40201', 'GESUSU', 'GESUSU'),
	('10108', 'GIAKANJA  ', 'GIAKANJA  '),
	('00601', 'GIGIRI  ', 'NAIROBI'),
	('10213', 'GIKOE', 'GIKOE'),
	('20116', 'GILGIL', 'GILGIL'),
	('40407', 'GIRIBE', 'GIRIBE'),
	('50304', 'GISAMBAI', 'GISAMBAI'),
	('00903', 'GITHIGA', 'GITHIGA'),
	('60205', 'GITHOGO', 'GITHOGO'),
	('01032', 'GITHUMU', 'GITHUMU'),
	('00216', 'GITHUNGURI', 'GITHUNGURI'),
	('60212', 'GITIMENE', 'GITIMENE'),
	('01003', 'GITUAMBA', 'GITUAMBA'),
	('10209', 'GITUGI', 'GITUGI'),
	('80206', 'GONGINI', 'GONGINI'),
	('20411', 'GORGOR', 'GORGOR'),
	('70202', 'GRIFTU', 'GRIFTU'),
	('70201', 'HABASWEIN  ', 'HABASWEIN  '),
	('50407', 'HAKATI  ', 'HAKATI  '),
	('50312', 'HAMISI  ', 'HAMISI  '),
	('40640', 'HAWINGA  ', 'HAWINGA  '),
	('00612', 'HIGHRIDGE  ', 'NAIROBI'),
	('70101', 'HOLA  ', 'HOLA  '),
	('40300', 'HOMA BAY  ', 'HOMA BAY  '),
	('30109', 'HURUMA  ', 'NAIROBI'),
	('10227', 'ICHICHI  ', 'ICHICHI  '),
	('40209', 'IGARE  ', 'IGARE  '),
	('60402', 'IGOJI  ', 'IGOJI  '),
	('20307', 'IGWAMITI  ', 'IGWAMITI  '),
	('90120', 'IIANI  ', 'IIANI  '),
	('90135', 'IKALAASA  ', 'IKALAASA  '),
	('40415', 'IKEREGE  ', 'IKEREGE  '),
	('00904', 'IKINU  ', 'IKINU  '),
	('40501', 'IKONGE  ', 'IKONGE  '),
	('90207', 'IKUTHA  ', 'IKUTHA  '),
	('60405', 'IKUU  ', 'IKUU  '),
	('00214', 'ILASIT  ', 'ILASIT  '),
	('50111', 'ILEHO  ', 'ILEHO  '),
	('50112', 'IMANGA  ', 'IMANGA  '),
	('60102', 'ISHIARA  ', 'ISHIARA  '),
	('40414', 'ISIBANIA  ', 'ISIBANIA  '),
	('01102', 'ISINYA  ', 'ISINYA  '),
	('60300', 'ISIOLO  ', 'ISIOLO  '),
	('50114', 'ISULU  ', 'ISULU  '),
	('30700', 'ITEN  ', 'ITEN  '),
	('01015', 'ITHANGA  ', 'ITHANGA  '),
	('40504', 'ITIBO  ', 'ITIBO  '),
	('40210', 'ITUMBE  ', 'ITUMBE  '),
	('50319', 'JEBROK  ', 'JEBROK  '),
	('00622', 'JUJA ROAD  ', 'NAIROBI'),
	('60411', 'KAANWA', 'KAANWA'),
	('20157', 'KABARAK UNIVERSITY', 'KABARAK UNIVERSITY'),
	('30400', 'KABARNET', 'KABARNET'),
	('30401', 'KABARTONJO', 'KABARTONJO'),
	('90205', 'KABATI', 'KABATI'),
	('20114', 'KABAZI', 'KABAZI'),
	('20201', 'KABIANGA', 'KABIANGA'),
	('30130', 'KABIEMIT', 'KABIEMIT'),
	('30303', 'KABIYET', 'KABIYET'),
	('30305', 'KABUJOI', 'KABUJOI'),
	('50214', 'KABULA', 'KABULA'),
	('30601', 'KACHELIBA', 'KACHELIBA'),
	('40314', 'KADEL', 'KADEL'),
	('40223', 'KADONGO', 'KADONGO'),
	('90150', 'KAEWA', 'KAEWA'),
	('10306', 'KAGIO', 'KAGIO'),
	('10307', 'KAGUMO', 'KAGUMO'),
	('01033', 'KAGUNDUINI', 'KAGUNDUINI'),
	('00223', 'KAGWE', 'KAGWE'),
	('20304', 'KAHEHO', 'KAHEHO'),
	('10206', 'KAHUHIA', 'KAHUHIA'),
	('10201', 'KAHURO', 'KAHURO'),
	('10214', 'KAHUTI', 'KAHUTI'),
	('50305', 'KAIMOSI', 'KAIMOSI'),
	('30604', 'KAINUK', 'KAINUK'),
	('10215', 'KAIRO', 'KAIRO'),
	('01100', 'KAJIADO', 'KAJIADO'),
	('50100', 'KAKAMEGA', 'KAKAMEGA'),
	('50419', 'KAKEMER', 'KAKEMER'),
	('30216', 'KAKIBORA', 'KAKIBORA'),
	('80209', 'KAKONENI', 'KAKONENI'),
	('30501', 'KAKUMA', 'KAKUMA'),
	('50115', 'KAKUNGA', 'KAKUNGA'),
	('01014', 'KAKUZI', 'KAKUZI'),
	('90122', 'KALAMBA', 'KALAMBA'),
	('90126', 'KALAWA', 'KALAWA'),
	('01001', 'KALIMONI', 'KALIMONI'),
	('30502', 'KALOKOL', 'KALOKOL'),
	('80105', 'KALOLENI', 'KALOLENI'),
	('20218', 'KAMAGET', 'KAMAGET'),
	('10217', 'KAMAHUHA', 'KAMAHUHA'),
	('20134', 'KAMARA', 'KAMARA'),
	('50116', 'KAMBIRI', 'KAMBIRI'),
	('10226', 'KAMBITI', 'KAMBITI'),
	('00607', 'KAMITI', 'KAMITI'),
	('30406', 'KAMPI YA SAMAKI', 'KAMPI YA SAMAKI'),
	('50408', 'KAMURIAI', 'KAMURIAI'),
	('90403', 'KAMUWONGO', 'KAMUWONGO'),
	('20132', 'KAMWAURA', 'KAMWAURA'),
	('30113', 'KAMWOSOR', 'KAMWOSOR'),
	('01034', 'KANDARA', 'KANDARA'),
	('40304', 'KANDIEGE', 'KANDIEGE'),
	('10218', 'KANGARI', 'KANGARI'),
	('10202', 'KANGEMA', 'KANGEMA'),
	('00625', 'KANGEMI', 'NAIROBI'),
	('90115', 'KANGUNDO', 'KANGUNDO'),
	('60118', 'KANJA', 'KANJA'),
	('01004', 'KANJUKU', 'KANJUKU'),
	('60206', 'KANYAKINE', 'KANYAKINE'),
	('10220', 'KANYENYAINI', 'KANYENYAINI'),
	('60106', 'KANYUAMBORA', 'KANYUAMBORA'),
	('30304', 'KAPCHENO', 'KAPCHENO'),
	('30204', 'KAPCHEROP', 'KAPCHEROP'),
	('30311', 'KAPCHORWA', 'KAPCHORWA'),
	('30410', 'KAPEDO', 'KAPEDO'),
	('30600', 'KAPENGURIA', 'KAPENGURIA'),
	('20214', 'KAPKATET', 'KAPKATET'),
	('20219', 'KAPKELET', 'KAPKELET'),
	('30119', 'KAPKENDA', 'KAPKENDA'),
	('20206', 'KAPKUGERWET', 'KAPKUGERWET'),
	('30111', 'KAPNGETUNY', 'KAPNGETUNY'),
	('30300', 'KAPSABET', 'KAPSABET'),
	('03020', 'KAPSARA', 'KAPSARA'),
	('20211', 'KAPSOIT', 'KAPSOIT'),
	('50203', 'KAPSOKWONY', 'KAPSOKWONY'),
	('30705', 'KAPSOWAR', 'KAPSOWAR'),
	('30313', 'KAPSUMBEIWA', 'KAPSUMBEIWA'),
	('20207', 'KAPSUSER', 'KAPSUSER'),
	('30114', 'KAPTAGAT', 'KAPTAGAT'),
	('30710', 'KAPTALAMWA', 'KAPTALAMWA'),
	('50234', 'KAPTAMA', 'KAPTAMA'),
	('30701', 'KAPTARAKWA', 'KAPTARAKWA'),
	('20221', 'KAPTEBENGWET', 'KAPTEBENGWET'),
	('30312', 'KAPTEL', 'KAPTEL'),
	('30711', 'KAPTEREN', 'KAPTEREN'),
	('60105', 'KARABA', 'KARABA'),
	('20328', 'KARANDI', 'KARANDI'),
	('10101', 'KARATINA', 'KARATINA'),
	('00233', 'KARATU', 'KARATU'),
	('00502', 'KAREN', 'KAREN'),
	('60107', 'KARINGARI', 'KARINGARI'),
	('00615', 'KARIOBANGI', 'NAIROBI'),
	('10231', 'KARIUA', 'KARIUA'),
	('40505', 'KAROTA', 'KAROTA'),
	('40401', 'KARUNGU', 'KARUNGU'),
	('00219', 'KARURI', 'KARURI'),
	('60117', 'KARURUMO', 'KARURUMO'),
	('00608', 'KASARANI', 'NAIROBI'),
	('80307', 'KASIGAU', 'KASIGAU'),
	('90123', 'KASIKEU', 'KASIKEU'),
	('90106', 'KATANGI', 'KATANGI'),
	('90105', 'KATHIANI', 'KATHIANI'),
	('90302', 'KATHONZWENI', 'KATHONZWENI'),
	('60406', 'KATHWANA', 'KATHWANA'),
	('40118', 'KATITO', 'KATITO'),
	('90404', 'KATSE', 'KATSE'),
	('90217', 'KATUTU', 'KATUTU'),
	('90107', 'KAVIANI', 'KAVIANI'),
	('90405', 'KAVUTI  ', 'KAVUTI  '),
	('00518', 'KAYOLE', 'KAYOLE'),
	('40506', 'KEBIRIGO', 'KEBIRIGO'),
	('20220', 'KEDOWA', 'KEDOWA'),
	('20501', 'KEEKOROK', 'KEEKOROK'),
	('40515', 'KEGOGI', 'KEGOGI'),
	('40416', 'KEGONGA', 'KEGONGA'),
	('40413', 'KEHANCHA', 'KEHANCHA'),
	('40301', 'KENDU BAY', 'KENDU BAY'),
	('01020', 'KENOL (MAKUYU)', 'KENOL (MAKUYU)'),
	('00202', 'KENYATTA NATIONAL HOSPITAL', 'NAIROBI'),
	('00609', 'KENYATTA UNIVERSITY', 'NAIROBI'),
	('40211', 'KENYENYA', 'KENYENYA'),
	('20200', 'KERICHO', 'KERICHO'),
	('40202', 'KEROKA', 'KEROKA'),
	('10300', 'KERUGOYA', 'KERUGOYA'),
	('00906', 'KERWA', 'KERWA'),
	('30215', 'KESOGON', 'KESOGON'),
	('30132', 'KESSES', 'KESSES'),
	('40212', 'KEUMBU', 'KEUMBU'),
	('60108', 'KEVOTE', 'KEVOTE'),
	('50104', 'KHAYEGA', 'KHAYEGA'),
	('50306', 'KHUMUSALABA', 'KHUMUSALABA'),
	('50135', 'KHWISERO', 'KHWISERO'),
	('10122', 'KIAMARIGA', 'KIAMARIGA'),
	('60109', 'KIAMBERE', 'KIAMBERE'),
	('00900', 'KIAMBU', 'KIAMBU'),
	('40213', 'KIAMOKAMA', 'KIAMOKAMA'),
	('10309', 'KIAMUTUGU', 'KIAMUTUGU'),
	('00236', 'KIAMWANGI', 'KIAMWANGI'),
	('10123', 'KIANDU', 'KIANDU'),
	('60602', 'KIANJAI', 'KIANJAI'),
	('60122', 'KIANJOKOMA', 'KIANJOKOMA'),
	('10301', 'KIANYAGA', 'KIANYAGA'),
	('40119', 'KIBIGORI', 'KIBIGORI'),
	('10311', 'KIBINGOTI', 'KIBINGOTI'),
	('60201', 'KIBIRICHIA', 'KIBIRICHIA'),
	('60112', 'KIBUGU', 'KIBUGU'),
	('90137', 'KIBWEZI', 'KIBWEZI'),
	('10102', 'KIGANJO', 'KIGANJO'),
	('10203', 'KIGUMO', 'KIGUMO'),
	('10207', 'KIHOYA', 'KIHOYA'),
	('30110', 'KIHUGA SQUARE', 'KIHUGA SQUARE'),
	('60207', 'KIIRUA', 'KIIRUA'),
	('00220', 'KIJABE', 'KIJABE'),
	('90125', 'KIKIMA', 'KIKIMA'),
	('00902', 'KIKUYU', 'KIKUYU'),
	('90305', 'KILALA', 'KILALA'),
	('40700', 'KILGORIS', 'KILGORIS'),
	('30315', 'KILIBWONI', 'KILIBWONI'),
	('08010', 'KILIFI', 'KILIFI'),
	('80107', 'KILINDINI', 'KILINDINI'),
	('50315', 'KILINGILI', 'KILINGILI'),
	('10125', 'KIMAHURI', 'KIMAHURI'),
	('00215', 'KIMANA', 'KIMANA'),
	('10140', 'KIMATHI WAY', 'KIMATHI WAY'),
	('10310', 'KIMBIMBI', 'KIMBIMBI'),
	('50204', 'KIMILILI', 'KIMILILI'),
	('30209', 'KIMININI', 'KIMININI'),
	('30120', 'KIMONING', 'KIMONING'),
	('20225', 'KIMULOT', 'KIMULOT'),
	('10312', 'KIMUNYE', 'KIMUNYE'),
	('30128', 'KIMWARER', 'KIMWARER'),
	('20320', 'KINAMBA', 'KINAMBA'),
	('80405', 'KINANGO', 'KINANGO'),
	('00227', 'KINARI', 'KINARI'),
	('01031', 'KINDARUMA', 'KINDARUMA'),
	('60216', 'KINORU', 'KINORU'),
	('60211', 'KIONYO', 'KIONYO'),
	('80116', 'KIPEVU', 'KIPEVU'),
	('30103', 'KIPKABUS', 'KIPKABUS'),
	('50241', 'KIPKARREN RIVER', 'KIPKARREN RIVER'),
	('20202', 'KIPKELION', 'KIPKELION'),
	('30117', 'KIPLEGETET', 'KIPLEGETET'),
	('30203', 'KIPSAINA', 'KIPSAINA'),
	('30411', 'KIPSARAMAN', 'KIPSARAMAN'),
	('30118', 'KIPTABACH', 'KIPTABACH'),
	('30402', 'KIPTAGICH', 'KIPTAGICH'),
	('20133', 'KIPTANGWANYI', 'KIPTANGWANYI'),
	('20213', 'KIPTERE', 'KIPTERE'),
	('20208', 'KIPTUGUMO', 'KIPTUGUMO'),
	('20131', 'KIRENGETI', 'KIRENGETI'),
	('10204', 'KIRIANI', 'KIRIANI'),
	('60113', 'KIRITIRI', 'KIRITIRI'),
	('50313', 'KIRITU', 'KIRITU'),
	('01017', 'KIRIUA', 'KIRIUA'),
	('01018', 'KIRUARA', 'KIRUARA'),
	('20144', 'KISANANA', 'KISANANA'),
	('90204', 'KISASI', 'KISASI'),
	('00206', 'KISERIAN', 'KISERIAN'),
	('40200', 'KISII', 'KISII'),
	('40100', 'KISUMU', 'KISUMU'),
	('30200', 'KITALE', 'KITALE'),
	('00241', 'KITENGELA', 'KITENGELA'),
	('90124', 'KITHIMANI', 'KITHIMANI'),
	('60114', 'KITHIMU', 'KITHIMU'),
	('90144', 'KITHYOKO', 'KITHYOKO'),
	('90303', 'KITISE', 'KITISE'),
	('80316', 'KITIVO', 'KITIVO'),
	('90200', 'KITUI', 'KITUI'),
	('90148', 'KIUNDUANI', 'KIUNDUANI'),
	('90218', 'KIUSYANI', 'KIUSYANI'),
	('90116', 'KIVAANI', 'KIVAANI'),
	('90111', 'KIVUNGA', 'KIVUNGA'),
	('50420', 'KOCHOLYA', 'KOCHOLYA'),
	('30314', 'KOILOT', 'KOILOT'),
	('40317', 'KOJWANG', 'KOJWANG'),
	('90108', 'KOLA', 'KOLA'),
	('40102', 'KOMBEWA', 'KOMBEWA'),
	('40103', 'KONDELE', 'KONDELE'),
	('40121', 'KONDIK', 'KONDIK'),
	('40639', 'KORACHA', 'KORACHA'),
	('40104', 'KORU', 'KORU'),
	('40332', 'KOSELE', 'KOSELE'),
	('50117', 'KOYONZO', 'KOYONZO'),
	('20154', 'KURESOI', 'KURESOI'),
	('10304', 'KUTUS', 'KUTUS'),
	('80403', 'KWALE', 'KWALE'),
	('30210', 'KWANZA', 'KWANZA'),
	('90215', 'KWAVONZA', 'KWAVONZA'),
	('90220', 'KYATUNE', 'KYATUNE'),
	('90209', 'KYENI', 'KYENI'),
	('90401', 'KYUSO', 'KYUSO'),
	('60601', 'LAARE  ', 'LAARE  '),
	('40122', 'LADHRIAWASI  ', 'LADHRIAWASI  '),
	('20330', 'LAIKIPIA CAMPUS  ', 'LAIKIPIA  '),
	('60502', 'LAISAMIS  ', 'LAISAMIS  '),
	('80500', 'LAMU  ', 'LAMU  '),
	('20112', 'LANET  ', 'LANET  '),
	('30112', 'LANGAS  ', 'ELDORET'),
	('00509', 'LANGATA  ', 'NAIROBI'),
	('00603', 'LAVINGTON  ', 'NAIROBI'),
	('20310', 'LESHAU  ', 'LESHAU  '),
	('30302', 'LESSOS  ', 'LESSOS  '),
	('80110', 'LIKONI  ', 'LIKONI  '),
	('00217', 'LIMURU  ', 'LIMURU  '),
	('90109', 'LITA  ', 'LITA  '),
	('20210', 'LITEIN  ', 'LITEIN  '),
	('30500', 'LODWAR  ', 'LODWAR  '),
	('00209', 'LOITOKTOK  ', 'LOITOKTOK  '),
	('60501', 'LOIYANGALANI  ', 'LOIYANGALANI  '),
	('30503', 'LOKICHOGGIO  ', 'LOKICHOGGIO  '),
	('30504', 'LOKITAUNG  ', 'LOKITAUNG  '),
	('30506', 'LOKORI  ', 'LOKORI  '),
	('40701', 'LOLGORIAN  ', 'LOLGORIAN  '),
	('20203', 'LONDIANI', 'LONDIANI'),
	('20402', 'LONGISA  ', 'LONGISA  '),
	('00604', 'LOWER KABETE  ', 'NAIROBI'),
	('50307', 'LUANDA  ', 'LUANDA  '),
	('50219', 'LUANDANYI  ', 'LUANDANYI  '),
	('50240', 'LUANDETI  ', 'LUANDETI  '),
	('50118', 'LUBAO  ', 'LUBAO  '),
	('50108', 'LUGARI  ', 'LUGARI  '),
	('40622', 'LUGINGO  ', 'LUGINGO  '),
	('40623', 'LUHANO  ', 'LUHANO  '),
	('50421', 'LUKOLIS  ', 'LUKOLIS  '),
	('80408', 'LUKORE  ', 'LUKORE  '),
	('50132', 'LUKUME  ', 'LUKUME  '),
	('50242', 'LUMAKANDA  ', 'LUMAKANDA  '),
	('80402', 'LUNGALUNGA  ', 'NAIROBI'),
	('50119', 'LUNZA  ', 'LUNZA  '),
	('00905', 'LUSINGETI  ', 'LUSINGETI  '),
	('50320', 'LUSIOLA  ', 'LUSIOLA  '),
	('50121', 'LUTASO  ', 'LUTASO  '),
	('50220', 'LWAKHAKHA  ', 'LWAKHAKHA  '),
	('20147', 'MAAIMAHIU  ', 'MAAIMAHIU  '),
	('50235', 'MABUSI  ', 'MABUSI  '),
	('90100', 'MACHAKOS  ', 'MACHAKOS  '),
	('01002', 'MADARAKA  ', 'NAIROBI'),
	('40613', 'MADIANY  ', 'MADIANY  '),
	('80207', 'MADINA  ', 'MADINA  '),
	('50321', 'MAGADA  ', 'MAGADA  '),
	('00205', 'MAGADI  ', 'MAGADI  '),
	('40516', 'MAGENA  ', 'MAGENA  '),
	('50325', 'MAGO  ', 'MAGO  '),
	('40507', 'MAGOMBO  ', 'MAGOMBO  '),
	('60403', 'MAGUMONI  ', 'MAGUMONI  '),
	('40307', 'MAGUNGA  ', 'MAGUNGA  '),
	('06040', 'MAGUTUNI  ', 'MAGUTUNI  '),
	('40508', 'MAGWAGWA  ', 'MAGWAGWA  '),
	('50322', 'MAHANGA  ', 'MAHANGA  '),
	('20314', 'MAIROINYA  ', 'MAIROINYA  '),
	('20145', 'MAJIMAZURI  ', 'MAJIMAZURI  '),
	('20418', 'MAKIMENY  ', 'MAKIMENY  '),
	('90138', 'MAKINDU  ', 'MAKINDU  '),
	('00510', 'MAKONGENI  ', 'MAKONGENI  '),
	('80315', 'MAKTAU  ', 'MAKTAU  '),
	('90300', 'MAKUENI  ', 'MAKUENI  '),
	('20149', 'MAKUMBI  ', 'MAKUMBI  '),
	('50133', 'MAKUNGA  ', 'MAKUNGA  '),
	('80112', 'MAKUPA  ', 'MAKUPA  '),
	('20141', 'MAKUTANO  ', 'MAKUTANO  '),
	('01020', 'MAKUYU  ', 'MAKUYU  '),
	('50122', 'MALAHA  ', 'MALAHA  '),
	('50209', 'MALAKISI  ', 'MALAKISI  '),
	('50103', 'MALAVA  ', 'MALAVA  '),
	('80200', 'MALINDI  ', 'MALINDI  '),
	('50123', 'MALINYA  ', 'MALINYA  '),
	('70300', 'MANDERA  ', 'MANDERA  '),
	('40509', 'MANGA  ', 'MANGA  '),
	('80301', 'MANYANI  ', 'MANYANI  '),
	('60101', 'MANYATTA  ', 'MANYATTA  '),
	('40625', 'MANYUANDA  ', 'MANYUANDA  '),
	('50126', 'MANYULIA  ', 'MANYULIA  '),
	('50300', 'MARAGOLI  ', 'MARAGOLI  '),
	('10205', 'MARAGUA  ', 'MARAGUA  '),
	('20600', 'MARALAL  ', 'MARALAL  '),
	('40214', 'MARANI  ', 'MARANI  '),
	('80113', 'MARIAKANI  ', 'MOMBASA  '),
	('30403', 'MARIGAT  ', 'MARIGAT  '),
	('60408', 'MARIMA  ', 'MARIMA  '),
	('60215', 'MARIMANTI  ', 'MARIMANTI  '),
	('40408', 'MARIWA  ', 'MARIWA  '),
	('20322', 'MARMANET  ', 'MARMANET  '),
	('60500', 'MARSABIT  ', 'MARSABIT  '),
	('50324', 'MASANA  ', 'MASANA  '),
	('40105', 'MASENO  ', 'MASENO  '),
	('80312', 'MASHINI  ', 'MASHINI  '),
	('01103', 'MASHURU  ', 'MASHURU  '),
	('90101', 'MASII  ', 'MASII  '),
	('40215', 'MASIMBA  ', 'MASIMBA  '),
	('50139', 'MASINDE MULIRO UNIVERSITY  ', 'MASINDE MULIRO UNIVERSITY  '),
	('90141', 'MASINGA  ', 'MASINGA  '),
	('50422', 'MATAYOS  ', 'MATAYOS  '),
	('50136', 'MATETE  ', 'MATETE  '),
	('00611', 'MATHARE VALLEY  ', 'NAIROBI'),
	('90406', 'MATHUKI  ', 'MATHUKI  '),
	('90140', 'MATILIKU  ', 'MATILIKU  '),
	('90210', 'MATINYANI  ', 'MATINYANI  '),
	('80406', 'MATUGA  ', 'MATUGA  '),
	('30205', 'MATUNDA  ', 'MATUNDA  '),
	('90119', 'MATUU  ', 'MATUU  '),
	('20111', 'MAU NAROK  ', 'MAU NAROK  '),
	('20122', 'MAU SUMMIT  ', 'MAU SUMMIT  '),
	('60600', 'MAUA  ', 'MAUA  '),
	('80317', 'MAUNGU  ', 'MAUNGU  '),
	('90304', 'MAVINDINI  ', 'MAVINDINI  '),
	('40310', 'MAWEGO  ', 'MAWEGO  '),
	('80114', 'MAZERAS  ', 'MAZERAS  '),
	('00503', 'MBAGATHI  ', 'MBAGATHI  '),
	('50236', 'MBAKALO  ', 'MBAKALO  '),
	('00231', 'MBARIYANJIKU  ', 'MBARIYANJIKU  '),
	('10233', 'MBIRI  ', 'MBIRI  '),
	('40305', 'MBITA  ', 'MBITA  '),
	('90214', 'MBITINI  ', 'MBITINI  '),
	('90110', 'MBIUNI  ', 'MBIUNI  '),
	('00127', 'MBUMBUNI  ', 'MBUMBUNI  '),
	('00504', 'MCHUMBI ROAD  ', 'MCHUMBI ROAD  '),
	('20104', 'MENENGAI  ', 'NAKURU  '),
	('20419', 'MERIGI  ', 'MERIGI  '),
	('60303', 'MERTI  ', 'MERTI  '),
	('60200', 'MERU  ', 'MERU  '),
	('40319', 'MFANGANO  ', 'MFANGANO  '),
	('80313', 'MGAMBONYI  ', 'MGAMBONYI  '),
	('80306', 'MGANGE  ', 'MGANGE  '),
	('60604', 'MIATHENE  ', 'MIATHENE  '),
	('01029', 'MIGIOINI  ', 'MIGIOINI  '),
	('90402', 'MIGWANI  ', 'MIGWANI  '),
	('20301', 'MIHARATI  ', 'MIHARATI  '),
	('40225', 'MIKAYI  ', 'MIKAYI  '),
	('60607', 'MIKINDURI  ', 'MIKINDURI  '),
	('50138', 'MILIMANI  ', 'MILIMANI  '),
	('20123', 'MILTON SIDING  ', 'MILTON SIDING  '),
	('20124', 'MIRANGINE  ', 'MIRANGINE  '),
	('40320', 'MIROGI  ', 'MIROGI  '),
	('50207', 'MISIKHU  ', 'MISIKHU  '),
	('40626', 'MISORI  ', 'MISORI  '),
	('90104', 'MITABONI  ', 'MITABONI  '),
	('60204', 'MITUNGUU  ', 'MITUNGUU  '),
	('90112', 'MIU  ', 'MIU  '),
	('40106', 'MIWANI  ', 'MIWANI  '),
	('80106', 'MKOMANI  ', 'MKOMANI  '),
	('00620', 'MOBI PLAZA  ', 'MOBI PLAZA  '),
	('20312', 'MOCHONGOI  ', 'MOCHONGOI  '),
	('20403', 'MOGOGOSIEK  ', 'MOGOGOSIEK  '),
	('20105', 'MOGOTIO  ', 'MOGOTIO  '),
	('80115', 'MOI AIRPORT  ', 'MOMBASA  '),
	('30107', 'MOI UNIVERSITY  ', 'MOI UNIVERSITY  '),
	('30104', 'MOIBEN  ', 'MOIBEN  '),
	('30202', 'MOI`S BRIDGE  ', 'MOI`S BRIDGE  '),
	('40510', 'MOKOMONI  ', 'MOKOMONI  '),
	('80502', 'MOKOWE  ', 'MOKOWE  '),
	('20106', 'MOLO  ', 'MOLO  '),
	('80100', 'MOMBASA  ', 'MOMBASA  '),
	('30307', 'MOSORIOT  ', 'MOSORIOT  '),
	('60700', 'MOYALE  ', 'MOYALE  '),
	('80503', 'MPEKETONI  ', 'MPEKETONI  '),
	('80404', 'MSAMBWENI  ', 'MSAMBWENI  '),
	('90128', 'MTITOANDEI  ', 'MTITOANDEI  '),
	('80111', 'MTONGWE  ', 'MTONGWE  '),
	('80117', 'MTOPANGA  ', 'MTOPANGA  '),
	('80109', 'MTWAPA  ', 'MTWAPA  '),
	('50423', 'MUBWAYO  ', 'MUBWAYO  '),
	('70102', 'MUDDOGASHE  ', 'MUDDOGASHE  '),
	('40627', 'MUDHIERO  ', 'MUDHIERO  '),
	('00228', 'MUGUGA  ', 'MUGUGA  '),
	('10129', 'MUGUNDA  ', 'MUGUNDA  '),
	('40107', 'MUHORONI  ', 'MUHORONI  '),
	('20323', 'MUHOTETU  ', 'MUHOTETU  '),
	('40409', 'MUHURU BAY  ', 'MUHURU BAY  '),
	('01023', 'MUKERENJU  ', 'MUKERENJU  '),
	('20315', 'MUKEU  ', 'MUKEU  '),
	('40410', 'MUKURO  ', 'MUKURO  '),
	('10103', 'MUKURWEINI  ', 'MUKURWEINI  '),
	('90216', 'MULANGO  ', 'MULANGO  '),
	('50428', 'MULUANDA  ', 'MULUANDA  '),
	('50102', 'MUMIAS  ', 'MUMIAS  '),
	('00235', 'MUNDORO  ', 'MUNDORO  '),
	('50425', 'MUNGATSI  ', 'MUNGATSI  '),
	('10200', 'MURANGA  ', 'MURANGA  '),
	('01024', 'MURUKA  ', 'MURUKA  '),
	('50426', 'MURUMBA  ', 'MURUMBA  '),
	('20316', 'MURUNGARU  ', 'MURUNGARU  '),
	('60120', 'MURURI  ', 'MURURI  '),
	('50125', 'MUSANDA  ', 'MUSANDA  '),
	('90211', 'MUTHA  ', 'MUTHA  '),
	('00619', 'MUTHAIGA  ', 'MUTHAIGA  '),
	('90113', 'MUTHETHENI  ', 'MUTHETHENI  '),
	('90117', 'MUTITUNI  ', 'MUTITUNI  '),
	('90201', 'MUTOMO  ', 'MUTOMO  '),
	('40628', 'MUTUMBU  ', 'MUTUMBU  '),
	('90114', 'MUUMANDU  ', 'MUUMANDU  '),
	('90102', 'MWALA  ', 'MWALA  '),
	('80305', 'MWATATE  ', 'MWATATE  '),
	('10104', 'MWEIGA  ', 'MWEIGA  '),
	('90400', 'MWINGI  ', 'MWINGI  '),
	('20504', 'NAIRAGEENKARE  ', 'NAIRAGEENKARE  '),
	('00100', 'NAIROBI GPO  ', 'NAIROBI'),
	('20142', 'NAISHI  ', 'NAISHI  '),
	('50211', 'NAITIRI  ', 'NAITIRI  '),
	('20117', 'NAIVASHA  ', 'NAIVASHA  '),
	('20100', 'NAKURU  ', 'NAKURU  '),
	('00207', 'NAMANGA  ', 'NAMANGA  '),
	('50127', 'NAMBACHA  ', 'NAMBACHA  '),
	('50409', 'NAMBALE  ', 'NAMBALE  '),
	('30301', 'NANDI HILLS  ', 'NANDI HILLS  '),
	('50239', 'NANGILI  ', 'NANGILI  '),
	('40615', 'NANGO  ', 'NANGO  '),
	('10400', 'NANYUKI  ', 'NANYUKI  '),
	('10105', 'NAROMORU  ', 'NAROMORU  '),
	('20500', 'NAROK  ', 'NAROK  '),
	('90118', 'NDALANI  ', 'NDALANI  '),
	('30123', 'NDALAT  ', 'NDALAT  '),
	('50212', 'NDALU  ', 'NDALU  '),
	('20404', 'NDANAI  ', 'NDANAI  '),
	('20306', 'NDARAGWA  ', 'NDARAGWA  '),
	('00230', 'NDENDERU  ', 'NDENDERU  '),
	('40629', 'NDERE  ', 'NDERE  '),
	('00229', 'NDERU  ', 'NDERU  '),
	('40302', 'NDHIWA  ', 'NDHIWA  '),
	('40630', 'NDIGWA  ', 'NDIGWA  '),
	('01016', 'NDITHINI  ', 'NDITHINI  '),
	('90202', 'NDOOA  ', 'NDOOA  '),
	('40602', 'NDORI  ', 'NDORI  '),
	('20317', 'NDUNYUNJERU  ', 'NDUNYUNJERU  '),
	('80311', 'NGAMBWA  ', 'NGAMBWA  '),
	('60115', 'NGANDURI  ', 'NGANDURI  '),
	('00600', 'NGARA ROAD  ', 'NGARA ROAD  '),
	('00218', 'NGECHA  ', 'NGECHA  '),
	('00901', 'NGEWA  ', 'NGEWA  '),
	('30404', 'NGINYANG  ', 'NGINYANG  '),
	('40603', 'NGIYA  ', 'NGIYA  '),
	('00208', 'NGONG HILLS  ', 'NGONG HILLS  '),
	('00505', 'NGONG ROAD  ', 'NAIROBI'),
	('20126', 'NGORIKA  ', 'NGORIKA  '),
	('90407', 'NGUNI  ', 'NGUNI  '),
	('10224', 'NGUYOINI  ', 'NGUYOINI  '),
	('90129', 'NGWATA  ', 'NGWATA  '),
	('40702', 'NJIPISHIP  ', 'NJIPISHIP  '),
	('20107', 'NJORO  ', 'NJORO  '),
	('60214', 'NKONDI  ', 'NKONDI  '),
	('60202', 'NKUBU  ', 'NKUBU  '),
	('20318', 'NORTH KINANGOP  ', 'NORTH KINANGOP  '),
	('90149', 'NTHONGOINI  ', 'NTHONGOINI  '),
	('40417', 'NTIMARU  ', 'NTIMARU  '),
	('90130', 'NUNGUNI  ', 'NUNGUNI  '),
	('90408', 'NUU  ', 'NUU  '),
	('40124', 'NYABONDO  ', 'NYABONDO  '),
	('40631', 'NYANDORERA  ', 'NYANDORERA  '),
	('20300', 'NYAHURURU  ', 'NYAHURURU  '),
	('80118', 'NYALI  ', 'MOMBASA  '),
	('40203', 'NYAMACHE  ', 'NYAMACHE  '),
	('40206', 'NYAMARAMBE  ', 'NYAMARAMBE  '),
	('40205', 'NYAMBUNWA  ', 'NYAMBUNWA  '),
	('40500', 'NYAMIRA  ', 'NYAMIRA  '),
	('40632', 'NYAMONYE  ', 'NYAMONYE  '),
	('40333', 'NYADHIWA  ', 'NYADHIWA  '),
	('40126', 'NYANGANDE  ', 'NYANGANDE  '),
	('40127', 'NYANGORI  ', 'NYANGORI  '),
	('40218', 'NYANGUSU  ', 'NYANGUSU  '),
	('40311', 'NYANGWESO  ', 'NYANGWESO  '),
	('40502', 'NYANSIONGO  ', 'NYANSIONGO  '),
	('40514', 'NYARAMBA  ', 'NYARAMBA  '),
	('30131', 'NYARU  ', 'NYARU  '),
	('40402', 'NYATIKE  ', 'NYATIKE  '),
	('40633', 'NYAWARA  ', 'NYAWARA  '),
	('00506', 'NYAYO STADIUM  ', 'NAIROBI'),
	('10100', 'NYERI  ', 'NYERI  '),
	('40611', 'NYILIMA  ', 'NYILIMA  '),
	('90136', 'NZEEKA  ', 'NZEEKA  '),
	('90143', 'NZIU  ', 'NZIU  '),
	('50237', 'NZOIA  ', 'NZOIA  '),
	('50427', 'OBEKAI  ', 'OBEKAI  '),
	('40129', 'OBOCH  ', 'OBOCH  '),
	('40204', 'OGEMBO  ', 'OGEMBO  '),
	('40130', 'OGEN  ', 'OGEN  '),
	('40323', 'OGONGO  ', 'OGONGO  '),
	('90301', 'OKIA  ', 'OKIA  '),
	('20302', 'OLJOROOROK  ', 'OLJOROOROK  '),
	('20303', 'OLKALOU  ', 'OLKALOU  '),
	('20421', 'OLBUTYO  ', 'OLBUTYO  '),
	('20152', 'OLENGURUONE  ', 'OLENGURUONE  '),
	('20502', 'OLKURTO  ', 'OLKURTO  '),
	('20503', 'OLOLOLUNGA  ', 'OLOLOLUNGA  '),
	('20424', 'OLOOMIRANI  ', 'OLOOMIRANI  '),
	('00213', 'OLTEPESI  ', 'OLTEPESI  '),
	('40306', 'OMBOGA  ', 'OMBOGA  '),
	('40221', 'OMOGONCHORO  ', 'OMOGONCHORO  '),
	('00511', 'ONGATARONGAI  ', 'ONGATARONGAI  '),
	('40227', 'ORIANG  ', 'ORIANG  '),
	('30602', 'ORTUM  ', 'ORTUM  '),
	('40324', 'OTARO  ', 'OTARO  '),
	('10106', 'OTHAYA  ', 'OTHAYA  '),
	('40411', 'OTHOCH RAKUOM  ', 'OTHOCH RAKUOM  '),
	('40224', 'OTHORO  ', 'OTHORO  '),
	('40108', 'OTONGLO  ', 'OTONGLO  '),
	('40334', 'OYANI-MASII  ', 'OYANI-MASII  '),
	('40222', 'OYUGIS  ', 'OYUGIS  '),
	('40329', 'PALA  ', 'PALA  '),
	('40111', 'PAP ONDITI  ', 'PAP ONDITI  '),
	('00623', 'PARKLANDS  ', 'PARKLANDS  '),
	('20311', 'PASSENGA  ', 'PASSENGA  '),
	('40131', 'PAW AKUCHE  ', 'PAW AKUCHE  '),
	('40113', 'PEMBETATU  ', 'PEMBETATU  '),
	('30116', 'PLATEAU  ', 'PLATEAU  '),
	('50410', 'PORT VICTORIA  ', 'PORT VICTORIA  '),
	('00624', 'QUARRY ROAD  ', 'QUARRY ROAD  '),
	('40132', 'RABUOR  ', 'RABUOR  '),
	('00617', 'RACECOURSE ROAD  ', 'NAIROBI'),
	('40604', 'RAGENGNI  ', 'RAGENGNI  '),
	('40325', 'RAKWARO  ', 'RAKWARO  '),
	('40330', 'RAMBA  ', 'RAMBA  '),
	('40142', 'RAMULA  ', 'RAMULA  '),
	('40412', 'RANEN  ', 'RANEN  '),
	('40634', 'RANGALA  ', 'RANGALA  '),
	('40303', 'RANGWE  ', 'RANGWE  '),
	('40403', 'RAPOGI  ', 'RAPOGI  '),
	('40137', 'RATTA  ', 'RATTA  '),
	('40133', 'RERU  ', 'RERU  '),
	('70302', 'RHAMU  ', 'RHAMU  '),
	('40511', 'RIGOMA  ', 'RIGOMA  '),
	('40226', 'RINGA  ', 'RINGA  '),
	('40512', 'RIOCHANDA  ', 'RIOCHANDA  '),
	('40220', 'RIOSIRI  ', 'RIOSIRI  '),
	('00512', 'RIRUTA  ', 'RIRUTA  '),
	('40326', 'RODIKOPANY  ', 'RODIKOPANY  '),
	('00300', 'RONALD NGALA STREET  ', 'NAIROBI'),
	('20127', 'RONDA  ', 'RONDA  '),
	('20108', 'RONGAI  ', 'RONGAI  '),
	('40404', 'RONGO  ', 'RONGO  '),
	('20204', 'RORET  ', 'RORET  '),
	('00618', 'RUARAKA  ', 'RUARAKA  '),
	('00232', 'RUIRU  ', 'RUIRU  '),
	('20321', 'RUMURUTI  ', 'RUMURUTI  '),
	('60103', 'RUNYENJES  ', 'RUNYENJES  '),
	('20313', 'RURI  ', 'RURI  '),
	('10133', 'RURINGU  ', 'RURINGU  '),
	('40327', 'RUSINGA  ', 'RUSINGA  '),
	('10134', 'RUTHANGATI  ', 'RUTHANGATI  '),
	('20143', 'SABATIA', 'SABATIA'),
	('30211', 'SABOTI', 'SABOTI'),
	('80308', 'SAGALLA', 'SAGALLA'),
	('10230', 'SAGANA', 'SAGANA'),
	('80120', 'SAMBURU', 'SAMBURU'),
	('50128', 'SAMITSI', 'SAMITSI'),
	('40405', 'SARE', 'SARE'),
	('00606', 'SARIT CENTRE', 'NAIROBI'),
	('00513', 'SASUMUA ROAD', 'SASUMUA ROAD'),
	('40612', 'SAWAGONGO', 'SAWAGONGO'),
	('40614', 'SEGA', 'SEGA'),
	('50308', 'SEREM', 'SEREM'),
	('30407', 'SERETUNIN', 'SERETUNIN'),
	('20150', 'SHABAAB', 'SHABAAB'),
	('50106', 'SHIANDA', 'SHIANDA'),
	('50129', 'SHIATSALA', 'SHIATSALA'),
	('50130', 'SHIBULI', 'SHIBULI'),
	('50131', 'SHIMANYIRO', 'SHIMANYIRO'),
	('80407', 'SHIMBA HILLS  ', 'SHIMBA HILLS  '),
	('50107', 'SHINYALU', 'SHINYALU'),
	('60104', 'SIAKAGO', 'SIAKAGO'),
	('40600', 'SIAYA', 'SIAYA'),
	('40605', 'SIDINDI', 'SIDINDI'),
	('40643', 'SIFUYO  ', 'SIFUYO  '),
	('40635', 'SIGOMRE', 'SIGOMRE'),
	('20405', 'SIGOR', 'SIGOR'),
	('40135', 'SIGOTI', 'SIGOTI'),
	('20212', 'SIGOWET', 'SIGOWET'),
	('30217', 'SIKINWA', 'SIKINWA'),
	('20422', 'SILIBWET', 'SILIBWET'),
	('30127', 'SIMAT', 'SIMAT'),
	('40308', 'SINDO', 'SINDO'),
	('30703', 'SINGORE', 'SINGORE'),
	('50401', 'SIO PORT', 'SIO PORT'),
	('20326', 'SIPILI', 'SIPILI'),
	('40636', 'SIREMBE', 'SIREMBE'),
	('30213', 'SIRENDE', 'SIRENDE'),
	('50208', 'SIRISIA', 'SIRISIA'),
	('40642', 'SIRONGO', 'SIRONGO'),
	('20128', 'SOLAI', 'SOLAI'),
	('60701', 'SOLOLO', 'SOLOLO'),
	('40109', 'SONDU', 'SONDU'),
	('40110', 'SONGHOR', 'SONGHOR'),
	('20223', 'SORGET', 'SORGET'),
	('20205', 'SOSIOT', 'SOSIOT'),
	('20406', 'SOTIK', 'SOTIK'),
	('20604', 'SOUTH HORR', 'SOUTH HORR'),
	('20155', 'SOUTH KINANGOP', 'SOUTH KINANGOP'),
	('20319', 'SOUTH KINANGOP', 'SOUTH KINANGOP'),
	('30105', 'SOY', 'SOY'),
	('40418', 'SUBAKURIA', 'SUBAKURIA'),
	('20109', 'SUBUKIA', 'SUBUKIA'),
	('20602', 'SUGUTA MAR MAR', 'SUGUTA MAR MAR'),
	('20151', 'SULMAC', 'SULMAC'),
	('90132', 'SULTAN HAMUD', 'SULTAN HAMUD'),
	('40400', 'SUNA', 'SUNA'),
	('30212', 'SUWERWA', 'SUWERWA'),
	('30220', 'TABANI  ', 'TABANI  '),
	('50238', 'TABANI  ', 'TABANI  '),
	('90131', 'TALA  ', 'TALA  '),
	('30704', 'TAMBACH  ', 'TAMBACH  '),
	('80203', 'TARASAA  ', 'TARASAA  '),
	('80309', 'TAUSA  ', 'TAUSA  '),
	('80302', 'TAVETA  ', 'TAVETA  '),
	('90133', 'TAWA  ', 'TAWA  '),
	('30405', 'TENGES  ', 'TENGES  '),
	('10110', 'THAARA  ', 'THAARA  '),
	('10135', 'THANGATHI  ', 'THANGATHI  '),
	('01026', 'THARE  ', 'THARE  '),
	('00210', 'THIGIO  ', 'THIGIO  '),
	('01000', 'THIKA  ', 'THIKA  '),
	('60210', 'TIGIJI  ', 'TIGIJI  '),
	('10406', 'TIMAU  ', 'TIMAU  '),
	('20110', 'TIMBER MILL ROAD  ', 'TIMBER MILL ROAD  '),
	('30108', 'TIMBOROA  ', 'TIMBOROA  '),
	('50309', 'TIRIKI  ', 'TIRIKI  '),
	('00400', 'TOM MBOYA  ', 'NAIROBI'),
	('40513', 'TOMBE  ', 'TOMBE  '),
	('30218', 'TONGAREN  ', 'TONGAREN  '),
	('20153', 'TORONGO  ', 'TORONGO  '),
	('30707', 'TOT  ', 'TOT  '),
	('90409', 'TSEIKURU  ', 'TSEIKURU  '),
	('90203', 'TULIA  ', 'TULIA  '),
	('10136', 'TUMUTUMU  ', 'TUMUTUMU  '),
	('60213', 'TUNYAI  ', 'TUNYAI  '),
	('30106', 'TURBO  ', 'TURBO  '),
	('20129', 'TURI  ', 'TURI  '),
	('10137', 'UASONYIRO  ', 'UASONYIRO  '),
	('40606', 'UGUNJA  ', 'UGUNJA  '),
	('00517', 'UHURU GARDENS  ', 'NAIROBI'),
	('80400', 'UKUNDA  ', 'UKUNDA  '),
	('40607', 'UKWALA  ', 'UKWALA  '),
	('00222', 'UPLANDS  ', 'UPLANDS  '),
	('40608', 'URANGA  ', 'URANGA  '),
	('40228', 'URIRI  ', 'URIRI  '),
	('40609', 'USENGE  ', 'USENGE  '),
	('40637', 'USIGU  ', 'USIGU  '),
	('00605', 'UTHIRU  ', 'UTHIRU  '),
	('00514', 'VALLEY ARCADE  ', 'NAIROBI'),
	('50310', 'VIHIGA  ', 'VIHIGA  '),
	('00621', 'VILLAGE MARKET  ', 'NAIROBI'),
	('80119', 'VIPINGO  ', 'VIPINGO  '),
	('80211', 'VITENGENI  ', 'VITENGENI  '),
	('00507', 'VIWANDANI  ', 'VIWANDANI  '),
	('80300', 'VOI  ', 'VOI  '),
	('90212', 'VOO  ', 'VOO  '),
	('40638', 'WAGUSU  ', 'WAGUSU  '),
	('00613', 'WAITHAKA  ', 'WAITHAKA  '),
	('70200', 'WAJIR  ', 'WAJIR  '),
	('10138', 'WAMAGANA  ', 'WAMAGANA  '),
	('20603', 'WAMBA  ', 'WAMBA  '),
	('90103', 'WAMUNYU  ', 'WAMUNYU  '),
	('01010', 'WAMWANGI  ', 'WAMWANGI  '),
	('00614', 'WANGIGE  ', 'WANGIGE  '),
	('10303', 'WANGURU  ', 'WANGURU  '),
	('10225', 'WANJENGI  ', 'WANJENGI  '),
	('20305', 'WANJOHI  ', 'WANJOHI  '),
	('80204', 'WATALII ROAD  ', 'WATALII ROAD  '),
	('80202', 'WATAMU  ', 'WATAMU  '),
	('50205', 'WEBUYE  ', 'WEBUYE  '),
	('30603', 'WEIWEI  ', 'WEIWEI  '),
	('80303', 'WERUGHA  ', 'WERUGHA  '),
	('00800', 'WESTLANDS  ', 'NAIROBI'),
	('40141', 'WINAM  ', 'WINAM  '),
	('80504', 'WITU  ', 'WITU  '),
	('20329', 'WIYUMIRIRIE  ', 'WIYUMIRIRIE  '),
	('50311', 'WODANGA  ', 'WODANGA  '),
	('80304', 'WUNDANYI  ', 'WUNDANYI  '),
	('40610', 'YALA  ', 'YALA  '),
	('00508', 'YAYA TOWERS  ', 'NAIROBI'),
	('90134', 'YOANI  ', 'YOANI  '),
	('30214', 'ZIWA  ', 'ZIWA  '),
	('90213', 'ZOMBE  ', 'ZOMBE  ');
/*!40000 ALTER TABLE `towns` ENABLE KEYS */;

-- Dumping structure for procedure arcm.UnBookVenue
DROP PROCEDURE IF EXISTS `UnBookVenue`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UnBookVenue`(IN _VenueID INT(11),IN _Date DATETIME,IN _Slot VARCHAR(50),IN _UserID varchar(50),IN _Content VARCHAR(255))
BEGIN
  DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Unbooked Booked Venue:',_VenueID); 
  Update venuebookings set Deleted=1 where VenueID=_VenueID and Date=_Date and Slot=_Slot and Content=_Content;
    
  call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updateapplicant
DROP PROCEDURE IF EXISTS `Updateapplicant`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updateapplicant`(IN _PEID VARCHAR(50) ,IN `_Name` VARCHAR(128), IN _Location VARCHAR(50),IN _POBox VARCHAR(50),IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _Mobile VARCHAR(50), IN _Telephone VARCHAR(50),IN _Email VARCHAR(100), IN _Logo VARCHAR(100),IN _Website VARCHAR(100), IN `_UserID` VARCHAR(50),IN _County VARCHAR(50),IN _RegistrationDate Datetime, IN _PIN VARCHAR(50),IN _RegistrationNo VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Updated applicant Code: ',_PEID); 
UPDATE applicants
SET Name=_Name, County=_County, Location=_Location, POBox=_POBox, PostalCode=_PostalCode, Town=_Town, Mobile=_Mobile, Telephone=_Telephone, Email=_Email, Logo=_Logo, Website=_Website,Updated_At=now(),Updated_By=_UserID,RegistrationDate=_RegistrationDate ,PIN=_PIN,RegistrationNo=_RegistrationNo
WHERE ApplicantCode=_PEID;
call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateApplication
DROP PROCEDURE IF EXISTS `UpdateApplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateApplication`(IN  _ApplicationNo varchar(50),IN `_TenderID` BIGINT, IN `_ApplicantID` BIGINT, IN _PEID VARCHAR(50),  IN `_ApplicationREf` VARCHAR(50), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Application :',_ApplicationNo); 

Update applications SET TenderID=_TenderID, ApplicantID=_ApplicantID, PEID=_PEID, ApplicationREf=_ApplicationREf, Updated_At=now(),Updated_By=_userID
WHERE ApplicationNo=_ApplicationNo;

call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateApplicationFees
DROP PROCEDURE IF EXISTS `UpdateApplicationFees`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateApplicationFees`(IN `_ApplicationID` int,IN _EntryType varchar(150),_AmountDue float, IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Updated Fee for Application: '+_ApplicationID); 
UPDATE
applicationfees set  AmountDue=_AmountDue
WHERE ApplicationID=_ApplicationID and EntryType=_EntryType;
call SaveAuditTrail(_userID,lSaleDesc,'UPDATE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateApprover
DROP PROCEDURE IF EXISTS `UpdateApprover`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateApprover`(IN _ID INT,IN `_Username` VARCHAR(50),IN _ModuleCode varchar(50),_Level int,IN _Active Boolean, IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Approver: '+ _Username +' for module: '+ _ModuleCode); 
Update approvers set Username=_Username,ModuleCode=_ModuleCode ,Level=_Level, Update_at=now(),UpdatedBy=_UserID,Active=_Active
where ID=_ID;
call SaveAuditTrail(_userID,lSaleDesc,'UPDATE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateBranch
DROP PROCEDURE IF EXISTS `UpdateBranch`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateBranch`(IN _ID INT,IN _Description VARCHAR(100),  IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  Branch: ',_ID); 
UPDATE Branches SET
Description =_Description, Updated_At=now(), Updated_By=_UserID
Where ID=_ID;
call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateCaseOfficers
DROP PROCEDURE IF EXISTS `UpdateCaseOfficers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCaseOfficers`(IN _Username VARCHAR(50),IN _MinValue float,IN _MaxValue Float,IN _Active BOOLEAN,IN _NotAvailableFrom DateTime,IN _NotAvailableTo DateTime, IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Case Officer: ',_Username); 
UPDATE `caseofficers` SET `MinValue`=_MinValue,MaximumValue=_MaxValue,`Active`=_Active,`NotAvailableFrom`=_NotAvailableFrom,`NotAvailableTo`=_NotAvailableTo,
  `Update_at`=now(),`UpdatedBy`=_UserID WHERE Username=_Username;
  call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatecommitteetypes
DROP PROCEDURE IF EXISTS `Updatecommitteetypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatecommitteetypes`(IN _Code VARCHAR(50),IN _Description VARCHAR(100),  IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  committeetypes: ',_Code); 
UPDATE committeetypes SET
Code=_Code, Description =_Description, Updated_At=now(), Updated_By=_UserID
Where Code=_Code;
call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateConfigurations
DROP PROCEDURE IF EXISTS `UpdateConfigurations`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateConfigurations`(IN _Name varchar(255),IN  _PhysicalAdress varchar(255),IN  _Street varchar(255),IN  _PoBox varchar(255),IN _PostalCode varchar(50),IN _Town varchar(100),IN _Telephone1 varchar(100),IN _Telephone2 varchar(100),IN _Mobile varchar(100),IN _Fax varchar(100),IN _Email varchar(100),IN _Website varchar(100),IN _PIN varchar(50),IN _Logo varchar(100),IN _UserID varchar(50),IN _Code varchar(50))
BEGIN
UPDATE `configurations` SET `Name`=_Name,`PhysicalAdress`=_PhysicalAdress,`Street`=_Street,`PoBox`=_PoBox,`PostalCode`=_PostalCode,`Town`=_Town,`Telephone1`=_Telephone1,`Telephone2`=_Telephone2,`Mobile`=_Mobile,`Fax`=_Fax,`Email`=_Email,`Website`=_Website,`PIN`=_PIN,`Logo`=_Logo,

`Updated_At`=now(),`Updated_By`=_UserID WHERE Code=_Code;

	


END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatecounty
DROP PROCEDURE IF EXISTS `Updatecounty`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatecounty`(IN _Code VARCHAR(50),IN _Description VARCHAR(100),  IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  county: ',_Code); 
UPDATE counties SET
Name =_Description, Updated_At=now(), Updated_By=_UserID
Where Code=_Code;
call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatefeesstructure
DROP PROCEDURE IF EXISTS `Updatefeesstructure`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatefeesstructure`(IN _Code varchar(50),IN `_Description` VARCHAR(525), IN _MinAmount FLOAT,IN _MaxAmount FLOAT,IN _Rate1 FLOAT,IN _Rate2 FLOAT,IN _MinFee FLOAT, IN _MaxFee Float, IN _FixedFee Boolean, IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Updated  FeeStructure: ', _Code); 
UPDATE feesstructure
SET Description=_Description, MinAmount=_MinAmount, MaxAmount=_MaxAmount, Rate1=_Rate1, Rate2=_Rate2, MinFee=_MinFee, MaxFee=_MaxFee, FixedFee=_FixedFee,Updated_At=now(), Updated_By=_UserID
Where Code=_Code;
call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatefinancialyear
DROP PROCEDURE IF EXISTS `Updatefinancialyear`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatefinancialyear`(IN `_Code` BIGINT, IN `_StartDate` datetime,IN `_EndDate` datetime,IN _IsCurrentYear TINYINT,IN `_UserID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated financialyear: ', _Code); 
UPDATE
`financialyear`
SET Code=_Code, StartDate= _StartDate, EndDate=_EndDate, IsCurrentYear= _IsCurrentYear,Updated_By=_UserID,Updated_At=now()
WHERE Code=_Code;
	if(_IsCurrentYear=1) THEN
		BEGIN		
		UPDATE financialyear SET IsCurrentYear=0 where `Code` <> _Code;
		call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
		END;
		END IF;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updategroundsandrequestedorders
DROP PROCEDURE IF EXISTS `Updategroundsandrequestedorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updategroundsandrequestedorders`(IN _ID BIGINT,IN `_EntryType` VARCHAR(200),IN _Description VARCHAR(500) ,IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Ground/Request with ID:',_ID); 
UPDATE groundsandrequestedorders SET
EntryType=_EntryType, Description= _Description,Updated_By=_userID, Updated_At=now()
WHERE ID=_ID ;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateGroupRoles
DROP PROCEDURE IF EXISTS `UpdateGroupRoles`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGroupRoles`(IN `_UserGroupID` BIGINT, IN `_RoleID` BIGINT, IN `_Status` BOOLEAN, IN `_Desc` VARCHAR(50), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
if(SELECT count(*)  from groupaccess where UserGroupID=_UserGroupID and  RoleID=_RoleID)>0 THEN
set lSaleDesc= CONCAT('Updated groupaccess  role'+_RoleID+' for userGroup: ', _UserGroupID ); 

BEGIN
if(_Desc ='Create')THEN
Begin
Update groupaccess set 
AddNew=_Status,
UpdateBy=_userID,
UpdatedAt=NOW()
where UserGroupID=_UserGroupID and  RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );

END;
END IF;
if(_Desc='View')THEN
Begin
Update groupaccess set
View=_Status,
UpdateBy=_userID,
UpdatedAt=NOW()
where UserGroupID=_UserGroupID and  RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
END IF;
if(_Desc='Delete')THEN
Begin
Update groupaccess set 
Remove=_Status,
UpdateBy=_userID,
UpdatedAt=NOW()
where  UserGroupID=_UserGroupID and  RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
END IF;
if(_Desc='Update')THEN
Begin
Update groupaccess set 
Edit=_Status,
UpdateBy=_userID,
UpdatedAt=NOW()
where UserGroupID=_UserGroupID and  RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
END IF;
if(_Desc='Export')THEN
Begin
Update groupaccess set 
Export=_Status,
UpdateBy=_userID,
UpdatedAt=NOW()
where UserGroupID=_UserGroupID and  RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
END IF;

END;

ELSE
BEGIN
set lSaleDesc= CONCAT('created groupaccess  role'+_RoleID+' for userGroup: ', _UserGroupID ); 
if(_Desc ='Create')THEN
Begin


INSERT INTO `groupaccess`( `UserGroupID`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, 
`CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`) VALUES 
(_UserGroupID,_RoleID,false,false,_Status,false,false,_userID,_userID,now(),now(),0);
call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );

END;
END IF;
if(_Desc='View')THEN
Begin
INSERT INTO `groupaccess`( `UserGroupID`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, 
`CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`) VALUES 
(_UserGroupID,_RoleID,false,false,false,_Status,false,_userID,_userID,now(),now(),0);
call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );

END;
END IF;
if(_Desc='Delete')THEN
Begin
INSERT INTO `groupaccess`( `UserGroupID`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, 
`CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`) VALUES 
(_UserGroupID,_RoleID,false,_Status,false,false,false,_userID,_userID,now(),now(),0);
call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
END;
END IF;
if(_Desc='Update')THEN
Begin
INSERT INTO `groupaccess`( `UserGroupID`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, 
`CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`) VALUES 
(_UserGroupID,_RoleID,_Status,false,false,false,false,_userID,_userID,now(),now(),0);
call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
END;
END IF;
if(_Desc='Export')THEN
Begin
INSERT INTO `groupaccess`( `UserGroupID`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, 
`CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`) VALUES 
(_UserGroupID,_RoleID,false,false,false,false,_Status,_userID,_userID,now(),now(),0);
call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
END;
END IF;
END;
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatemembertypes
DROP PROCEDURE IF EXISTS `Updatemembertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatemembertypes`(IN _Code VARCHAR(50),IN _Description VARCHAR(100),  IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  membertype: ',_Code); 
UPDATE membertypes SET
Code=_Code, Description =_Description, Updated_At=now(), Updated_By=_UserID
Where Code=_Code;
call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatepassword
DROP PROCEDURE IF EXISTS `Updatepassword`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Updatepassword`(IN _Password VARCHAR(128), IN _Username VARCHAR(50))
BEGIN
Update users set `Password`=_Password Where Username=_Username;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdatePE
DROP PROCEDURE IF EXISTS `UpdatePE`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdatePE`(IN _PEID VARCHAR(50), IN _Name VARCHAR(128), IN _Location VARCHAR(50), IN _POBox VARCHAR(50), IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _Mobile VARCHAR(50), IN _Telephone VARCHAR(50), IN _Email VARCHAR(100), IN _Logo VARCHAR(100), IN _Website VARCHAR(100), IN _UserID VARCHAR(50), IN _County VARCHAR(50), IN _RegistrationDate DATETIME, IN _PIN VARCHAR(50), IN _RegistrationNo VARCHAR(50), IN _PEType VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Updated Procurement Entity: ',_PEID); 
UPDATE procuremententity
SET Name=_Name, County=_County, Location=_Location, POBox=_POBox, PostalCode=_PostalCode, Town=_Town, Mobile=_Mobile, Telephone=_Telephone,
  Email=_Email, Logo=_Logo, Website=_Website,Updated_At=now(),Updated_By=_UserID ,RegistrationDate =_RegistrationDate,
  PIN =_PIN, RegistrationNo=_RegistrationNo,PEType=_PEType
WHERE PEID=_PEID;

call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdatePEResponseDetails
DROP PROCEDURE IF EXISTS `UpdatePEResponseDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePEResponseDetails`(IN _GroundNo VARCHAR(50), IN _GroundType VARCHAR(50), IN _Response TEXT, IN _UserID VARCHAR(50), IN _PEResponseID INT)
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Updated PE Response for Response ID: ',_PEResponseID);
if(select count(*) from peresponsedetails where  PEResponseID=_PEResponseID and GroundNO=_GroundNo)>0 THEN
BEGIN
Update peresponsedetails 
  set GroundNO=_GroundNo ,  GroundType=_GroundType,  Response=_Response,Updated_At=now(),Updated_By=_UserID where PEResponseID=_PEResponseID and GroundNO=_GroundNo;
  
END;
 Else
  BEGIN
    insert into peresponsedetails ( PEResponseID ,  GroundNO ,  GroundType,  Response,  Created_At ,  Created_By )
    Values(_PEResponseID,_GroundNo,_GroundType,_Response,now(),_UserID);
   End;
    End if;
    call SaveAuditTrail(_UserID,lSaleDesc,'Update','0');
  End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdatePEResponseStatus
DROP PROCEDURE IF EXISTS `UpdatePEResponseStatus`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePEResponseStatus`(IN _ApplicationNo VARCHAR(50))
BEGIN
  
Update peresponsetimer set Status='Awaiting Response' where ApplicationNo=_ApplicationNo;

Select Created_By from applicants where ID in (select ApplicantID from applications where ApplicationNo=_ApplicationNo) LIMIT 1 into @Applicant;

Select Email from users where Username=@Applicant into @ApplicantEmail;
Select Phone from users where Username=@Applicant into @ApplicantMobile;
Select Name from users where Username=@Applicant into @ApplicantName;

Select Email from configurations limit 1 into @PPRAEmail;
Select Mobile  from configurations  limit 1 into @PPRAMobile;

select @ApplicantEmail as ApplicantEmail,@ApplicantMobile as Applicantmobile,@ApplicantName as Applicantname,@PPRAEmail as PPRAEmail,@PPRAMobile as PPRAMobile;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdatePEType
DROP PROCEDURE IF EXISTS `UpdatePEType`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdatePEType`(IN _Code VARCHAR(525),IN _Description VARCHAR(525), IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  PEType: ',_Code); 
UPDATE petypes SET
Code=_Code, Description =_Description, Updated_At=now(), Updated_By=_UserID
Where Code=_Code;

call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updateprocurementmethod
DROP PROCEDURE IF EXISTS `Updateprocurementmethod`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updateprocurementmethod`(IN _Code VARCHAR(525),IN _Description VARCHAR(525), IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated procurementmethod: ',_Code); 
UPDATE procurementmethods SET
Code=_Code, Description =_Description, Updated_At=now(), Updated_By=_UserID
Where Code=_Code;

call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateProfile
DROP PROCEDURE IF EXISTS `UpdateProfile`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProfile`(IN _Name VARCHAR(120), IN _Email VARCHAR(128), IN _phone VARCHAR(20), IN _Photo VARCHAR(100), IN _username VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  User with username: ',_username ); 

UPDATE `users`set `Name`=_Name , `Email`=_Email,`Phone`=_Phone, `Update_at`=Now(),UpdatedBy=_username,Photo=_Photo
WHERE `Username`=_username;
call SaveAuditTrail(_username,lSaleDesc,'Update','0' );

End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateProfilePhoto
DROP PROCEDURE IF EXISTS `UpdateProfilePhoto`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateProfilePhoto`(IN `_Photo` VARCHAR(100), IN `_username` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Cahnged User Photo for user: ',_username ); 

UPDATE `users`set Photo=_Photo
WHERE `Username`=_username;
call SaveAuditTrail(_username,lSaleDesc,'Update','0' );

End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateRoles
DROP PROCEDURE IF EXISTS `UpdateRoles`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateRoles`(IN `_RoleName` VARCHAR(128), IN `__RoleDescription` VARCHAR(128), IN `_RoleID` BIGINT, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Role with iD: ', _RoleID ,'and name:' ,_RoleName); 
UPDATE roles set RoleName=_RoleName, RoleDescription=__RoleDescription, UpdatedAt=now() ,UpdateBy=_userID
Where RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatestdtenderdocs
DROP PROCEDURE IF EXISTS `Updatestdtenderdocs`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatestdtenderdocs`(IN _Code VARCHAR(50),IN _Description VARCHAR(100),  IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated stdtenderdoc: ',_Code); 
UPDATE stdtenderdocs SET
Code=_Code, Description =_Description, Updated_At=now(), Updated_By=_UserID
Where Code=_Code;
call SaveAuditTrail(_UserID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateTender
DROP PROCEDURE IF EXISTS `UpdateTender`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateTender`(IN _ID BIGINT,IN `_TenderNo` VARCHAR(100), IN `_Name` VARCHAR(150), IN `_PEID` VARCHAR(50), IN `_StartDate` DateTime, IN `_ClosingDate` DateTime, IN `_userID` VARCHAR(50),IN _TenderValue float)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Tender with TenderNo:',_TenderNo); 

Update tenders
set TenderNo=_TenderNo, Name=_Name, PEID=_PEID, StartDate=_StartDate, ClosingDate=_ClosingDate, Updated_At=now(),  Updated_By=_userID,TenderValue=_TenderValue
WHERE ID=_ID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );



End//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatetenderaddendums
DROP PROCEDURE IF EXISTS `Updatetenderaddendums`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatetenderaddendums`(IN _ID BIGINT, IN `_Description` VARCHAR(200), IN `_StartDate` DateTime, IN `_ClosingDate` DateTime,  IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Tender Addendum  TenderID:',_ID); 
Update tenderaddendums SET
Description=_Description, StartDate=_StartDate, ClosingDate=_ClosingDate, Updated_At=now(), Updated_By=_userID
WHERE ID=_ID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatetendertypes
DROP PROCEDURE IF EXISTS `Updatetendertypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatetendertypes`(IN _Code VARCHAR(525),IN _Description VARCHAR(525), IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  tendertype: ',_Code); 
UPDATE tendertypes SET
Code=_Code, Description =_Description, Updated_At=now(), Updated_By=_UserID
Where Code=_Code;

call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateUser
DROP PROCEDURE IF EXISTS `UpdateUser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser`(IN `_Name` VARCHAR(128), IN `_Email` VARCHAR(128), IN `_UserGroup` BIGINT, IN `_username` VARCHAR(50), IN `_IsActive` BOOLEAN, IN `_userID` VARCHAR(50), IN `_Phone` VARCHAR(20),IN _Signature VARCHAR(128),in _IDnumber INT,in _DOB DATETIME,in _Gender VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  User with username: ',_username ); 

UPDATE `users`set `Name`=_Name , `Email`=_Email,`Phone`=_Phone, `Update_at`=Now(),`IsActive`=_IsActive,`UserGroupID`=_UserGroup,UpdatedBy=_userID, Signature=_Signature,IDnumber=_IDnumber,Gender=_Gender,DOB=_DOB
WHERE `Username`=_username;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );

End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateUserAccess
DROP PROCEDURE IF EXISTS `UpdateUserAccess`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUserAccess`(IN `_Username` VARCHAR(50), IN `_RoleID` BIGINT, IN `_Desc` VARCHAR(50), IN `_Status` BOOLEAN, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
		DECLARE lSaleDesc varchar(200);
		if(SELECT count(*)  from useraccess where Username=_Username and  RoleID=_RoleID)>0 THEN

		BEGIN
			set lSaleDesc= CONCAT('Updated  user access of role for user: ', _Username ); 

			if(_Desc ='Create')THEN
			Begin
			Update useraccess set 
			AddNew=_Status,
			UpdateBy=_userID,
			UpdatedAt=NOW()
			where Username=_Username and  RoleID=_RoleID;
			call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );

			END;
			END IF;
			if(_Desc='View')THEN
			Begin
			Update useraccess set
			View=_Status,
			UpdateBy=_userID,
			UpdatedAt=NOW()
			where Username=_Username and  RoleID=_RoleID;
			call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
			END;
			END IF;
			if(_Desc='Delete')THEN
			Begin
			Update useraccess set 
			Remove=_Status,
			UpdateBy=_userID,
			UpdatedAt=NOW()
			where Username=_Username and  RoleID=_RoleID;
			call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
			END;
			END IF;
			if(_Desc='Update')THEN
			Begin
			Update useraccess set 
			Edit=_Status,
			UpdateBy=_userID,
			UpdatedAt=NOW()
			where Username=_Username and  RoleID=_RoleID;
			call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
			END;
			END IF;
			if(_Desc='Export')THEN
			Begin
			Update useraccess set 
			Export=_Status,
			UpdateBy=_userID,
			UpdatedAt=NOW()
			where Username=_Username and  RoleID=_RoleID;
			call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
			END;
			END IF;
		END;
		ELSE
		BEGIN
			set lSaleDesc= CONCAT('Updated  user access of role for user: ', _Username ); 

			if(_Desc ='Create')THEN
			Begin
				INSERT INTO useraccess
				(Username,RoleID, Edit, Remove, AddNew, View, Export, UpdateBy, CreateBy, CreatedAt, UpdatedAt) 
				VALUES 
				(_Username,_RoleID,false,false,_Status,false,false,_userID,_userID,now(),now());
			
				call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
			

			END;
			END IF;
			if(_Desc='View')THEN
				Begin
				INSERT INTO useraccess
				(Username,RoleID, Edit, Remove, AddNew, View, Export, UpdateBy, CreateBy, CreatedAt, UpdatedAt) 
				VALUES 
				(_Username,_RoleID,false,false,false,_Status,false,_userID,_userID,now(),now());
			
				call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
				END;
			END IF;
			if(_Desc='Delete')THEN
			Begin
			INSERT INTO useraccess
				(Username,RoleID, Edit, Remove, AddNew, View, Export, UpdateBy, CreateBy, CreatedAt, UpdatedAt) 
				VALUES 
				(_Username,_RoleID,false,_Status,false,false,false,_userID,_userID,now(),now());
			
				call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
			END;
			END IF;
			if(_Desc='Update')THEN
			Begin
			INSERT INTO useraccess
				(Username,RoleID, Edit, Remove, AddNew, View, Export, UpdateBy, CreateBy, CreatedAt, UpdatedAt) 
				VALUES 
				(_Username,_RoleID,_Status,false,false,false,false,_userID,_userID,now(),now());
			
				call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
			END;
			END IF;
			if(_Desc='Export')THEN
			Begin
			INSERT INTO useraccess
				(Username,RoleID, Edit, Remove, AddNew, View, Export, UpdateBy, CreateBy, CreatedAt, UpdatedAt) 
				VALUES 
				(_Username,_RoleID,false,false,false,false,_Status,_userID,_userID,now(),now());
			
				call SaveAuditTrail(_userID,lSaleDesc,'Create','0' );
	END;
END IF;
END;
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateUserGroup
DROP PROCEDURE IF EXISTS `UpdateUserGroup`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUserGroup`(IN `_Name` VARCHAR(128), IN `_Description` VARCHAR(128), IN `_UserGroupID` BIGINT, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated UserGroup with iD: ',_UserGroupID); 

UPDATE usergroups set Name=_Name, Description=_Description, UpdatedAt=now() ,UpdatedBy=_userID
Where UserGroupID=_UserGroupID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatevenues
DROP PROCEDURE IF EXISTS `Updatevenues`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Updatevenues`(IN _ID int,in _Name VARCHAR(100),IN _Description VARCHAR(150),IN _UserID varchar(50),IN _Branch INT)
BEGIN
  DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Updated  Venue with ID: ', _ID); 
  Update venues set Name=_Name,Branch=_Branch ,Description=_Description,Updated_By=_UserID,Updated_At=now() where ID=_ID;
  
  call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for table arcm.useraccess
DROP TABLE IF EXISTS `useraccess`;
CREATE TABLE IF NOT EXISTS `useraccess` (
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `RoleID` bigint(20) NOT NULL,
  `Edit` tinyint(1) NOT NULL,
  `Remove` tinyint(1) NOT NULL,
  `AddNew` tinyint(1) NOT NULL,
  `View` tinyint(1) NOT NULL,
  `Export` tinyint(1) NOT NULL,
  `UpdateBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Username`,`RoleID`),
  KEY `CreateBy` (`CreateBy`),
  KEY `UpdateBy` (`UpdateBy`),
  CONSTRAINT `useraccess_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`),
  CONSTRAINT `useraccess_ibfk_2` FOREIGN KEY (`CreateBy`) REFERENCES `users` (`Username`),
  CONSTRAINT `useraccess_ibfk_3` FOREIGN KEY (`UpdateBy`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.useraccess: ~108 rows (approximately)
/*!40000 ALTER TABLE `useraccess` DISABLE KEYS */;
INSERT INTO `useraccess` (`Username`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`) VALUES
	('Admin', 17, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:25', '2019-08-09 16:01:32'),
	('Admin', 18, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:24', '2019-08-09 15:38:47'),
	('Admin', 19, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:23', '2019-08-09 18:09:49'),
	('Admin', 20, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:24', '2019-07-29 11:28:25'),
	('Admin', 21, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-19 11:22:29', '2019-08-09 16:38:25'),
	('Admin', 22, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:17', '2019-08-02 13:09:00'),
	('Admin', 23, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:19', '2019-07-31 10:58:56'),
	('Admin', 24, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:05:31', '2019-07-29 11:28:22'),
	('Admin', 25, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:20', '2019-07-29 11:28:22'),
	('Admin', 26, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:04:53', '2019-07-29 11:28:21'),
	('Admin', 27, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:21', '2019-07-29 11:28:21'),
	('Admin', 28, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 15:18:22', '2019-07-29 11:28:20'),
	('Admin', 29, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-29 09:48:29', '2019-07-29 11:28:19'),
	('Admin', 30, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-29 09:48:29', '2019-07-29 11:28:18'),
	('Admin', 31, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-29 14:08:14', '2019-07-29 14:08:19'),
	('Admin', 32, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-31 16:59:50', '2019-08-09 18:09:44'),
	('Admin', 33, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 10:22:26', '2019-08-09 17:45:49'),
	('Admin', 34, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 10:25:44', '2019-08-09 18:09:43'),
	('Admin', 35, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 10:49:28', '2019-08-09 18:09:44'),
	('Admin', 36, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 11:41:52', '2019-08-09 18:09:43'),
	('Admin', 37, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 13:33:23', '2019-08-09 18:09:38'),
	('Admin', 38, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-05 14:07:10', '2019-08-09 18:09:39'),
	('Admin', 39, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-05 14:44:54', '2019-08-09 17:49:19'),
	('Admin', 40, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-06 14:20:47', '2019-08-09 18:09:46'),
	('Admin', 41, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-06 14:34:44', '2019-08-09 17:01:47'),
	('Admin', 42, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-09 11:42:49', '2019-08-09 18:09:40'),
	('Admin', 43, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-11 10:47:35', '2019-08-11 10:47:40'),
	('Admin', 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-14 10:24:07', '2019-08-14 10:24:11'),
	('Admin', 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-14 15:57:52', '2019-08-14 15:57:55'),
	('Admin', 46, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-21 18:01:37', '2019-08-21 18:01:41'),
	('Admin', 47, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-23 12:02:06', '2019-08-23 12:02:09'),
	('Admin', 48, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-23 12:02:10', '2019-08-23 12:02:16'),
	('Admin', 49, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-09 09:48:24', '2019-09-09 09:48:35'),
	('Admin', 50, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-11 10:47:01', '2019-09-11 14:47:21'),
	('Admin', 51, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-11 11:13:28', '2019-09-11 11:13:36'),
	('Admin', 52, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-12 09:48:01', '2019-09-12 09:48:09'),
	('Admin', 53, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-13 10:05:26', '2019-09-13 10:05:33'),
	('Admin', 54, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-17 09:41:59', '2019-09-17 09:42:09'),
	('Admin', 55, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-18 10:04:33', '2019-09-18 10:04:41'),
	('Admin', 56, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-23 14:29:07', '2019-09-23 14:29:16'),
	('Admin', 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-24 15:03:48', '2019-09-24 15:03:56'),
	('Admin', 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-27 12:21:38', '2019-09-27 12:21:47'),
	('Admin', 59, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-01 11:03:50', '2019-10-01 13:43:56'),
	('Admin2', 17, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 18, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 19, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 20, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 21, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 22, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 23, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 24, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 25, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 26, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 27, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 28, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 29, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 30, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 31, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 32, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 33, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 34, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 35, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 36, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 37, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 38, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 39, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 40, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 41, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 42, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 43, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 44, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 45, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 46, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 47, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 48, 1, 1, 1, 1, 1, 'Admin2', 'Admin', '2019-09-06 13:10:43', '2019-09-06 16:40:40'),
	('Admin2', 49, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-09 10:10:04', '2019-09-09 10:10:13'),
	('Admin2', 50, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-12 12:24:41', '2019-09-12 12:24:47'),
	('Admin2', 51, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-12 12:24:51', '2019-09-12 12:25:04'),
	('Admin2', 52, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-12 12:24:54', '2019-09-12 12:25:07'),
	('Admin2', 53, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-25 09:57:03', '2019-09-25 09:57:13'),
	('Admin2', 54, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-24 15:20:31', '2019-09-24 15:20:50'),
	('Admin2', 55, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-25 09:56:48', '2019-09-25 09:56:57'),
	('Admin2', 56, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-24 15:20:28', '2019-09-24 15:20:53'),
	('Admin2', 57, 1, 1, 1, 1, 1, 'Admin2', 'Admin2', '2019-09-24 15:20:32', '2019-09-24 15:20:55'),
	('Applicant', 32, 1, 1, 0, 1, 1, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 36, 1, 1, 0, 1, 1, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 38, 0, 0, 0, 1, 0, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 40, 0, 0, 0, 1, 0, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 41, 0, 0, 0, 1, 0, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 42, 0, 0, 0, 1, 0, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 43, 0, 0, 0, 1, 0, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 44, 1, 1, 1, 1, 1, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 45, 1, 1, 1, 1, 1, NULL, 'Applicant', '2019-08-20 16:30:46', NULL),
	('Applicant', 56, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-23 12:00:00', '2019-09-23 12:00:07'),
	('Applicant', 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-24 11:10:37', '2019-09-24 11:10:46'),
	('kapsadmin', 32, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 36, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 38, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 40, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 41, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 42, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 43, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 44, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('kapsadmin', 45, 1, 1, 1, 1, 1, 'kapsadmin', 'kapsadmin', '2019-08-20 10:35:51', '2019-08-27 15:30:41'),
	('TestUser', 32, 1, 1, 0, 1, 1, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 36, 1, 1, 0, 1, 1, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 38, 0, 0, 0, 1, 0, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 40, 0, 0, 0, 1, 0, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 41, 0, 0, 0, 1, 0, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 42, 0, 0, 0, 1, 0, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 43, 0, 0, 0, 1, 0, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 44, 1, 1, 1, 1, 1, NULL, 'TestUser', '2019-09-02 16:45:08', NULL),
	('TestUser', 45, 1, 1, 1, 1, 1, NULL, 'TestUser', '2019-09-02 16:45:08', NULL);
/*!40000 ALTER TABLE `useraccess` ENABLE KEYS */;

-- Dumping structure for table arcm.usergroups
DROP TABLE IF EXISTS `usergroups`;
CREATE TABLE IF NOT EXISTS `usergroups` (
  `UserGroupID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`UserGroupID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.usergroups: ~5 rows (approximately)
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
INSERT INTO `usergroups` (`UserGroupID`, `Name`, `Description`, `CreatedAt`, `UpdatedAt`, `Deleted`, `CreatedBy`, `UpdatedBy`) VALUES
	(1, 'Admin', 'Administrators updated', '2019-06-13 14:54:49', '2019-08-27 17:46:10', 0, '', 'Admin'),
	(6, 'Clercks', 'Clercks up[dated', '2019-06-25 10:10:12', '2019-06-25 10:10:20', 1, 'admin', 'admin'),
	(7, 'others', 'tenders,', '2019-07-11 16:19:24', '2019-07-11 16:19:24', 0, 'admin', 'admin'),
	(8, 'Portal users', 'Portal users', '2019-08-16 16:47:04', '2019-08-16 16:47:04', 0, 'Admin', 'Admin'),
	(9, 'Test', 'Test', '2019-08-27 17:47:15', '2019-08-27 17:47:15', 0, 'Admin', 'Admin'),
	(10, 'BOARD ROOM !', 'BOARD ROOM !', '2019-09-11 10:47:44', '2019-09-11 10:47:44', 0, 'Admin', 'Admin');
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;

-- Dumping structure for table arcm.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `Name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `Login_at` datetime DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `IsActive` tinyint(1) DEFAULT NULL,
  `IsEmailverified` tinyint(1) DEFAULT NULL,
  `ActivationCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ResetPassword` char(38) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UserGroupID` bigint(20) NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Photo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Signature` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IDnumber` int(50) DEFAULT NULL,
  `Gender` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DOB` datetime DEFAULT NULL,
  `ChangePassword` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Username`,`UserGroupID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `MobileNo` (`Phone`),
  UNIQUE KEY `IDNo` (`IDnumber`),
  KEY `users_ibfk_1` (`UserGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.users: ~5 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`Name`, `Username`, `Email`, `Password`, `Phone`, `Create_at`, `Update_at`, `Login_at`, `Deleted`, `IsActive`, `IsEmailverified`, `ActivationCode`, `ResetPassword`, `UserGroupID`, `CreatedBy`, `UpdatedBy`, `Photo`, `Category`, `Signature`, `IDnumber`, `Gender`, `DOB`, `ChangePassword`) VALUES
	('Elvis kimutai', 'Admin', 'elviskcheruiyot@gmail.com', '$2b$10$W5YQ2FfNM3pc7poT7Blpz.Rws/nb6zHPo88EU0C1O0BEIWbrssWH6', '0705555285', '2019-07-12 15:50:56', '2019-08-28 11:17:21', '2019-07-12 15:50:56', 0, 1, 1, 'QDrts', '', 1, 'kim', 'Admin', '1566637510102-IMG_20190705_162423_7.jpg', 'System_User', '1565251011001-signature.jpg', 31547833, 'Male', '1994-12-31 00:00:00', NULL),
	('Admin2', 'Admin2', 'elviskimcheruiyot@gmail.com', '$2b$10$w8yiOtBSx1JlzUVW8svvo.oSVdm99GKXHbGQDBovT3SYJt.U54VpS', '07221145671', '2019-09-06 13:10:43', NULL, NULL, 0, 1, 1, 'hGL8L', NULL, 1, 'Admin', NULL, 'default.png', 'System_User', '', 123456789, 'Male', '2019-09-20 00:00:00', 1),
	('Applicant', 'Applicant', 'margaret.mutinda@gmail.com', '$2b$10$dKaYWiTbspksxMvFIyDni.4HYrzBCvtt5zyJKET/c.xMGZWXhqcmG', '0722114567', '2019-08-20 16:30:46', '2019-08-27 17:08:06', NULL, 0, 1, 1, 'dRyrk', NULL, 8, 'Applicant', 'Admin', '1566636812197-download.jpg', 'Applicant', NULL, 1234567890, 'Male', '2019-08-01 00:00:00', 1),
	('kapsadmin', 'kapsadmin', 'arcmdevelopment@gmail.com', '$2b$10$emR1Yo9znD.MkX9uxkJa.ed92hGEiOb.zNfjUbsrEHdhbdQXEaK1i', '070110292', '2019-08-20 10:35:51', '2019-08-27 16:42:49', NULL, 1, 1, 1, 'eiKcI', NULL, 8, 'kapsadmin', 'Admin', 'default.png', 'Applicant', NULL, 123986754, 'Male', '2019-08-01 00:00:00', NULL),
	('Test User', 'TestUser', 'ekimutai810@gmail.com', '$2b$10$XdYvoQsmAFYAY.583bJaKer43vAdNhhnwys2KEuORsxKpmmaQ.H0m', '07087654322456', '2019-09-02 16:45:08', '2019-09-04 09:28:34', NULL, 0, 1, 1, 'BFrv4', NULL, 8, 'TestUser', 'TestUser', 'default.png', 'PE', NULL, 2147483647, 'Female', '2019-09-01 00:00:00', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table arcm.venuebookings
DROP TABLE IF EXISTS `venuebookings`;
CREATE TABLE IF NOT EXISTS `venuebookings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VenueID` int(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Slot` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Booked_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Booked_On` datetime DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.venuebookings: ~16 rows (approximately)
/*!40000 ALTER TABLE `venuebookings` DISABLE KEYS */;
INSERT INTO `venuebookings` (`ID`, `VenueID`, `Date`, `Slot`, `Booked_By`, `Content`, `Booked_On`, `Deleted`) VALUES
	(35, 5, '2019-10-02', '8.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:35:34', 1),
	(36, 5, '2019-10-02', '9.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:35:53', 1),
	(37, 5, '2019-10-02', '11.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:44:27', 0),
	(38, 5, '2019-10-03', '8.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:44:36', 0),
	(39, 5, '2019-10-02', '8.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:44:46', 1),
	(40, 5, '2019-10-02', '12.00PM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:44:50', 0),
	(41, 6, '2019-10-03', '11.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:49:39', 0),
	(42, 6, '2019-10-02', '8.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:26', 0),
	(43, 6, '2019-10-02', '12.00PM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:30', 0),
	(44, 6, '2019-10-02', '11.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:33', 0),
	(45, 6, '2019-10-03', '9.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:36', 0),
	(46, 6, '2019-10-03', '4.00PM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:39', 0),
	(47, 6, '2019-10-03', '5.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:39', 0),
	(48, 6, '2019-10-03', '6.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:39', 0),
	(49, 6, '2019-10-03', '7.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:39', 0),
	(50, 6, '2019-10-03', '8.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:51:39', 0),
	(51, 4, '2019-10-02', '8.00AM', 'Admin', 'ARCM-AP-50', '2019-10-02 16:53:09', 0);
/*!40000 ALTER TABLE `venuebookings` ENABLE KEYS */;

-- Dumping structure for table arcm.venues
DROP TABLE IF EXISTS `venues`;
CREATE TABLE IF NOT EXISTS `venues` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Branch` int(11) NOT NULL,
  `Description` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.venues: ~6 rows (approximately)
/*!40000 ALTER TABLE `venues` DISABLE KEYS */;
INSERT INTO `venues` (`ID`, `Name`, `Branch`, `Description`, `Deleted`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`) VALUES
	(1, 'Board room 1', 0, 'Board room 1 Updated', 1, '2019-09-11 10:49:34', 'Admin', '2019-09-11 10:58:15', 'Admin'),
	(2, 'Board Room1', 0, '10th Floor', 0, '2019-09-11 14:47:48', 'Admin', NULL, NULL),
	(3, 'Board Room 1', 15, 'Room 1', 1, '2019-09-18 10:51:37', 'Admin', NULL, NULL),
	(4, 'Room 1', 14, 'Main Board room', 0, '2019-09-18 10:52:47', 'Admin', '2019-10-04 10:13:26', 'Admin'),
	(5, 'Room 1', 12, 'Room 1', 0, '2019-09-18 14:34:26', 'Admin', NULL, NULL),
	(6, 'Room 1', 15, 'Room 1', 0, '2019-09-18 14:34:33', 'Admin', NULL, NULL),
	(7, 'Room2', 14, 'Room2', 0, '2019-09-18 16:53:06', 'Admin', NULL, NULL);
/*!40000 ALTER TABLE `venues` ENABLE KEYS */;

-- Dumping structure for trigger arcm.OnSave
DROP TRIGGER IF EXISTS `OnSave`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `OnSave` AFTER INSERT ON `applicationdocuments` FOR EACH ROW INSERT INTO `applicationdocumentshistory`( `ApplicationID`,  `Description`, `FileName`, `DateUploaded`, `Path`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`) 
VALUES (new.ApplicationID,new.Description,new.FileName,new.DateUploaded,new.Path,new.Created_By,new.Created_At,new.Updated_At,new.Updated_By,new.Deleted,new.Deleted_At,new.Deleted_By)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger arcm.OnUpdate
DROP TRIGGER IF EXISTS `OnUpdate`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `OnUpdate` AFTER UPDATE ON `applicationdocuments` FOR EACH ROW INSERT INTO `applicationdocumentshistory`( `ApplicationID`, `Description`, `FileName`, `DateUploaded`, `Path`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`) 
VALUES (old.ApplicationID,old.Description,old.FileName,old.DateUploaded,new.Path,old.Created_By,old.Created_At,old.Updated_At,old.Updated_By,old.Deleted,old.Deleted_At,old.Deleted_By)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger arcm.SaveCopy
DROP TRIGGER IF EXISTS `SaveCopy`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `SaveCopy` AFTER INSERT ON `applicants` FOR EACH ROW INSERT INTO `applicantshistory`( `ApplicantCode`, `Name`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`) 
VALUES (new.ApplicantCode,new.Name,new.County,new.Location,new.POBox,new.PostalCode,new.Town,new.Mobile,new.Telephone,new.Email,new.Logo,new.Website,new.Created_By,new.Created_At)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger arcm.UpdateRecord
DROP TRIGGER IF EXISTS `UpdateRecord`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `UpdateRecord` AFTER UPDATE ON `applicants` FOR EACH ROW INSERT INTO `applicantshistory`( `ApplicantCode`, `Name`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`) 
VALUES (old.ApplicantCode,old.Name,old.County,old.Location,old.POBox,old.PostalCode,old.Town,old.Mobile,old.Telephone,old.Email,old.Logo,old.Website,old.Created_By,old.Created_At)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
