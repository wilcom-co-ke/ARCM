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
CREATE  PROCEDURE `Activation`(IN `_IsEmailverified` BOOLEAN, IN `_Email` VARCHAR(100), IN `_ActivationCode` VARCHAR(100))
    NO SQL
BEGIN

UPDATE `users`set `IsEmailverified`=_IsEmailverified 
WHERE `Username`=_username and`Email`=_Email;
End//
DELIMITER ;

-- Dumping structure for table arcm.additionalsubmissiondocuments
DROP TABLE IF EXISTS `additionalsubmissiondocuments`;
CREATE TABLE IF NOT EXISTS `additionalsubmissiondocuments` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(11) DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `FileName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FilePath` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `Create_at` datetime NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `DeletedBY` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime(6) DEFAULT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Confidential` tinyint(1) DEFAULT NULL,
  `SubmitedBy` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.additionalsubmissiondocuments: ~0 rows (approximately)
DELETE FROM `additionalsubmissiondocuments`;
/*!40000 ALTER TABLE `additionalsubmissiondocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `additionalsubmissiondocuments` ENABLE KEYS */;

-- Dumping structure for table arcm.additionalsubmissions
DROP TABLE IF EXISTS `additionalsubmissions`;
CREATE TABLE IF NOT EXISTS `additionalsubmissions` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(11) DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `FileName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FilePath` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `DeletedBY` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime(6) DEFAULT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SubmitedBy` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.additionalsubmissions: ~0 rows (approximately)
DELETE FROM `additionalsubmissions`;
/*!40000 ALTER TABLE `additionalsubmissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `additionalsubmissions` ENABLE KEYS */;

-- Dumping structure for procedure arcm.AddPanelMember
DROP PROCEDURE IF EXISTS `AddPanelMember`;
DELIMITER //
CREATE  PROCEDURE `AddPanelMember`(IN _ApplicationNo VARCHAR(50), IN _Role VARCHAR(100), IN _UserName VARCHAR(50), IN _UserID varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Added new PanelMember for Application: ', _UserName); 
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
DELETE FROM `adjournment`;
/*!40000 ALTER TABLE `adjournment` DISABLE KEYS */;
/*!40000 ALTER TABLE `adjournment` ENABLE KEYS */;

-- Dumping structure for table arcm.adjournmentapprovalworkflow
DROP TABLE IF EXISTS `adjournmentapprovalworkflow`;
CREATE TABLE IF NOT EXISTS `adjournmentapprovalworkflow` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=16384;

-- Dumping data for table arcm.adjournmentapprovalworkflow: ~0 rows (approximately)
DELETE FROM `adjournmentapprovalworkflow`;
/*!40000 ALTER TABLE `adjournmentapprovalworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `adjournmentapprovalworkflow` ENABLE KEYS */;

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
DELETE FROM `adjournmentdocuments`;
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

-- Dumping data for table arcm.applicants: ~1 rows (approximately)
DELETE FROM `applicants`;
/*!40000 ALTER TABLE `applicants` DISABLE KEYS */;
INSERT INTO `applicants` (`ID`, `ApplicantCode`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`, `RegistrationDate`, `PIN`, `RegistrationNo`) VALUES
	(2, 'AP-21', 'WILSON B. KEREBEI', '', '001', 'Nairobi', '123', '01000', 'THIKA  ', '0701102928', '0701102928', 'cmkikungu@gmail.com', '', 'N/A', '0701102928', '2019-12-05 13:42:08', NULL, NULL, 0, NULL, NULL, '2019-12-05 00:00:00', '0701102928', '0701102928');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicantshistory: ~2 rows (approximately)
DELETE FROM `applicantshistory`;
/*!40000 ALTER TABLE `applicantshistory` DISABLE KEYS */;
INSERT INTO `applicantshistory` (`ID`, `ApplicantCode`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`) VALUES
	(1, 'AP-20', 'WILSON B. KEREBEI', '', '001', 'Nairobi', '123', '01000', 'THIKA  ', '0701102928', '0701102928', 'cmkikungu@gmail.com', '', '', '0701102928', '2019-12-05 13:15:59', NULL, NULL, NULL, NULL, NULL),
	(2, 'AP-21', 'WILSON B. KEREBEI', '', '001', 'Nairobi', '123', '01000', 'THIKA  ', '0701102928', '0701102928', 'cmkikungu@gmail.com', '', 'N/A', '0701102928', '2019-12-05 13:42:08', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `applicantshistory` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationapprovalcontacts
DROP TABLE IF EXISTS `applicationapprovalcontacts`;
CREATE TABLE IF NOT EXISTS `applicationapprovalcontacts` (
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Msg` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationapprovalcontacts: ~0 rows (approximately)
DELETE FROM `applicationapprovalcontacts`;
/*!40000 ALTER TABLE `applicationapprovalcontacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `applicationapprovalcontacts` ENABLE KEYS */;

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
  `Confidential` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`Path`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationdocuments: ~0 rows (approximately)
DELETE FROM `applicationdocuments`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationdocumentshistory: ~0 rows (approximately)
DELETE FROM `applicationdocumentshistory`;
/*!40000 ALTER TABLE `applicationdocumentshistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `applicationdocumentshistory` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationfees
DROP TABLE IF EXISTS `applicationfees`;
CREATE TABLE IF NOT EXISTS `applicationfees` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` bigint(20) NOT NULL,
  `EntryType` int(11) DEFAULT NULL,
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
  `CalculatedAmount` float DEFAULT NULL,
  `FeesStatus` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApprovedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateApproved` datetime DEFAULT NULL,
  `Narration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationfees: ~0 rows (approximately)
DELETE FROM `applicationfees`;
/*!40000 ALTER TABLE `applicationfees` DISABLE KEYS */;
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
DELETE FROM `applicationfeeshistory`;
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
  `ClosingDate` date DEFAULT NULL,
  `PaymentStatus` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DecisionDate` date DEFAULT NULL,
  `Followup` tinyint(1) DEFAULT NULL,
  `Referral` tinyint(1) DEFAULT NULL,
  `WithdrawalDate` date DEFAULT NULL,
  `FileNumber` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Closed` tinyint(1) DEFAULT NULL,
  `ApplicationSuccessful` tinyint(1) DEFAULT NULL,
  `Annulled` tinyint(1) DEFAULT NULL,
  `GiveDirection` tinyint(1) DEFAULT NULL,
  `ISTerminated` tinyint(1) DEFAULT NULL,
  `ReTender` tinyint(1) DEFAULT NULL,
  `CostsApplicant` tinyint(1) DEFAULT NULL,
  `CostsPE` tinyint(1) DEFAULT NULL,
  `CostsEachParty` tinyint(1) DEFAULT NULL,
  `Substitution` tinyint(1) DEFAULT NULL,
  `HearingNoticeGenerated` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  PRIMARY KEY (`ID`,`ApplicationNo`) USING BTREE,
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applications: ~0 rows (approximately)
DELETE FROM `applications`;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;

-- Dumping structure for table arcm.applicationsequence
DROP TABLE IF EXISTS `applicationsequence`;
CREATE TABLE IF NOT EXISTS `applicationsequence` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Action` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ExpectedAction` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `User` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationsequence: ~0 rows (approximately)
DELETE FROM `applicationsequence`;
/*!40000 ALTER TABLE `applicationsequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `applicationsequence` ENABLE KEYS */;

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
DELETE FROM `applicationshistory`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applications_approval_workflow: ~0 rows (approximately)
DELETE FROM `applications_approval_workflow`;
/*!40000 ALTER TABLE `applications_approval_workflow` DISABLE KEYS */;
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
  `Category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MaxApprovals` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`,`ModuleCode`) USING BTREE,
  UNIQUE KEY `UK_approvalmodules_ModuleCode` (`ModuleCode`),
  KEY `ModuleCode` (`ModuleCode`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.approvalmodules: ~7 rows (approximately)
DELETE FROM `approvalmodules`;
/*!40000 ALTER TABLE `approvalmodules` DISABLE KEYS */;
INSERT INTO `approvalmodules` (`ID`, `ModuleCode`, `Name`, `Create_at`, `Update_at`, `Deleted`, `CreatedBy`, `UpdatedBy`, `Category`, `MaxApprovals`) VALUES
	(1, 'APFRE', 'Applications Approval', '2019-08-21 17:58:50', NULL, 0, '', NULL, 'Application', 1),
	(2, 'PAYMT', 'Payment Confirmation', '2019-08-21 17:58:50', NULL, 0, '', NULL, 'Fees', 1),
	(3, 'REXED', 'Request For Extension of Deadline', '2019-08-21 17:58:50', NULL, 0, '', NULL, 'Application', 1),
	(4, 'PAREQ', 'Panellist Appointment', '2019-08-21 17:58:50', NULL, 0, '', NULL, 'Case Management', 1),
	(6, 'WIOAP', 'Withdrawal of Appeal', '2019-08-21 17:58:50', NULL, 0, '', NULL, 'Case Management', 1),
	(8, 'ADJRE', 'Adjournment Request', '2019-08-21 17:58:50', NULL, 0, '', NULL, 'Case Management', 1),
	(9, 'DCAPR', 'Decision Approval', '2019-11-18 00:00:00', NULL, 0, '', NULL, 'Case Management', 1);
/*!40000 ALTER TABLE `approvalmodules` ENABLE KEYS */;

-- Dumping structure for procedure arcm.ApproveApplication
DROP PROCEDURE IF EXISTS `ApproveApplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `ApproveApplication`(IN _Approver VARCHAR(50),IN _ApplicationNo varchar(50),IN _Remarks varchar(255))
    NO SQL
BEGIN


DECLARE lSaleDesc varchar(200);
DECLARE _NewApplicationNo varchar(50);
DECLARE _Year varchar(50);
 DROP TABLE IF EXISTS ApplicationApprovalContacts;
 create table ApplicationApprovalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Msg varchar(50),ApplicationNo varchar(50));
set lSaleDesc= CONCAT(' Approved Application: ',_ApplicationNo); 
 select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
INSERT INTO `applications_approval_workflow`( `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, 
    `Created_By`, `Created_At`,Approved_At,Remarks,Approver) 
	SELECT
	`TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`,'Approved', _Approver, now(),now() ,_Remarks,_Approver
  from  applications where ApplicationNo=_ApplicationNo;

select ID from applications WHERE ApplicationNo=_ApplicationNo Limit 1 into @AppID;
select IFNULL( PeResponseDays,5) from configurations LIMIT 1 into @PEResponseTimeOut;
select IFNULL( CaseClosingDate,21) from configurations LIMIT 1 into @CaseClosingDate;

select IFNULL(count(*),0) from approvers WHERE Mandatory=1 and ModuleCode='APFRE' and Deleted=0 into @CountMandatory;
select IFNULL(count(*),0) from `applications_approval_workflow`  WHERE  `ApplicationNo`=_ApplicationNo and Status='Approved' and 
  Approver in (select Username from approvers WHERE Mandatory=1 and ModuleCode='APFRE' and Deleted=0) into @CountMandatoryApproved;

select IFNULL(MaxApprovals,0) from approvalmodules where  ModuleCode ='APFRE' LIMIT 1 into @MaxApprovals;
select IFNULL(count(*),0) from `applications_approval_workflow`  WHERE   `ApplicationNo`=_ApplicationNo and Status='Approved' and 
   Approver in (select Username from approvers WHERE Mandatory=0 and Deleted=0 and ModuleCode='APFRE')
  into @CountApproved;

  if @CountMandatoryApproved >= @CountMandatory  THEN
    BEGIN
          if @CountApproved >= @MaxApprovals  THEN
          BEGIN
                update applications set Status='Approved',ClosingDate=NOW() + INTERVAL @CaseClosingDate DAY where ApplicationNo=_ApplicationNo;
                update notifications set Status='Resolved' where Category='Applications Approval' and  ApplicationNo=_ApplicationNo;                  
                call Saveapplicationsequence(_ApplicationNo,'Application Approved','Awaiting PE Response',_Approver);
                select IFNULL(Year,Year(now())) from configurations   INTO @Currentyear; 
                if(@Currentyear <> Year(now())) then
                Begin
                  select Year(now()) into @curryr;
                  update configurations set NextApplication=2,Year=@curryr;
                  select IFNULL(NextApplication,1) from configurations   INTO @ApplicationNo; 
                  set _NewApplicationNo=CONCAT('1 OF ',Year(now()));
                

                  update applications set ApplicationNo=_NewApplicationNo where ApplicationNo=_ApplicationNo;
                  update applicationsequence set ApplicationNo=_NewApplicationNo where ApplicationNo=_ApplicationNo;                 
                  call SavePETimerResponse(@PEID,_NewApplicationNo,NOW() + INTERVAL @PEResponseTimeOut DAY);
                  call AssignCaseOfficer(_NewApplicationNo, @PEID, _Approver);
                  
                 
                    select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
                    insert into ApplicationApprovalContacts select Name,Email,Phone,'Applicant',_NewApplicationNo from users where Username =@Applicant;
                    select ApplicantID from applications where  ApplicationNo=_NewApplicationNo LIMIT 1 into @ApplicantID;
                    insert into ApplicationApprovalContacts select Name,Email,Mobile,'Applicant',_NewApplicationNo from applicants where  ID=@ApplicantID; 
                    insert into ApplicationApprovalContacts select Name,Email,Mobile,'PE',_NewApplicationNo from  procuremententity where PEID=@PEID; 
                    insert into ApplicationApprovalContacts select  Name,Email,Mobile,'Interested Party',_NewApplicationNo from  interestedparties where ApplicationID= @AppID; 
                                      
                
                End;
                else
                Begin
                  select IFNULL(NextApplication,1) from configurations   INTO @ApplicationNo; 
                  set _Year=CONCAT(' OF ',Year(now()));
                  set _NewApplicationNo=CONCAT(@ApplicationNo,_Year);
                  update applications set ApplicationNo=_NewApplicationNo where ApplicationNo=_ApplicationNo;
                  update applicationsequence set ApplicationNo=_NewApplicationNo where ApplicationNo=_ApplicationNo;
                 
                             
                  call SavePETimerResponse(@PEID,_NewApplicationNo,NOW() + INTERVAL @PEResponseTimeOut DAY);
                  call AssignCaseOfficer(_NewApplicationNo, @PEID, _Approver);
                  update configurations set NextApplication=@ApplicationNo+1,Year=Year(now());

                     select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
                    insert into ApplicationApprovalContacts select Name,Email,Phone,'Applicant',_NewApplicationNo from users where Username =@Applicant;
                    select ApplicantID from applications where  ApplicationNo=_NewApplicationNo LIMIT 1 into @ApplicantID;
                    insert into ApplicationApprovalContacts select Name,Email,Mobile,'Applicant',_NewApplicationNo from applicants where  ID=@ApplicantID; 
                    insert into ApplicationApprovalContacts select Name,Email,Mobile,'PE',_NewApplicationNo from  procuremententity where PEID=@PEID; 
                      
                    insert into ApplicationApprovalContacts select  Name,Email,Mobile,'Interested Party',_NewApplicationNo from  interestedparties where ApplicationID= @AppID; 
                End;
                End if;
          END;
          ELSE
            Begin
              insert into ApplicationApprovalContacts select Name,Email,Phone,'Incomplete',_ApplicationNo from users
              inner join approvers on approvers.Username=users.Username
              where approvers.ModuleCode='APFRE' and approvers.Deleted=0 and users.Username not in (select Approver from applications_approval_workflow  
              WHERE ApplicationNo=_ApplicationNo and Status='Approved' ); 
            End;
          End IF;
    END;
    else
      Begin
       insert into ApplicationApprovalContacts select Name,Email,Phone,'Incomplete',_ApplicationNo from users
              inner join approvers on approvers.Username=users.Username
              where approvers.ModuleCode='APFRE' and approvers.Deleted=0 and users.Username not in (select Approver from applications_approval_workflow  
              WHERE ApplicationNo=_ApplicationNo and Status='Approved' ); 
      End;
    End IF;

call ResolveMyNotification(_Approver,'Application Approval',_ApplicationNo);

call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
select Name ,Email ,Mobile ,Msg ,ApplicationNo,NOW() + INTERVAL @PEResponseTimeOut DAY as ResponseTimeout from ApplicationApprovalContacts;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApproveApplicationFees
DROP PROCEDURE IF EXISTS `ApproveApplicationFees`;
DELIMITER //
CREATE  PROCEDURE `ApproveApplicationFees`(IN _Approver VARCHAR(50), IN _ApplicationID INT, IN _Amount FLOAT, IN _Reff VARCHAR(100), IN _Category VARCHAR(50))
BEGIN
-- new
 DROP TABLE IF EXISTS caseWithdrawalContacts;
 create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Msg varchar(50));
 insert into feesapprovalworkflow (ApplicationID ,Amount , RefNo ,Status,ApprovedBy,  DateApproved, Category)
 VALUES(_ApplicationID,_Amount,_Reff,'Approved',_Approver,now(),_Category);
select IFNULL(MaxApprovals,0) from approvalmodules where  ModuleCode ='PAYMT' LIMIT 1 into @MaxApprovals;
select IFNULL(count(*),0) from feesapprovalworkflow  WHERE  ApplicationID=_ApplicationID and Category=_Category  and Status='Approved' and 
   ApprovedBy in (select Username from approvers WHERE Mandatory=0 and Deleted=0 and ModuleCode='PAYMT')
  into @CountApproved;
  -- check mandatory approvers
select IFNULL(count(*),0) from approvers WHERE Mandatory=1 and ModuleCode='PAYMT' and Deleted=0 into @CountMandatory;
select IFNULL(count(*),0) from feesapprovalworkflow  WHERE  ApplicationID=_ApplicationID and Category=_Category and Status='Approved' and 
  ApprovedBy in (select Username from approvers WHERE Mandatory=1 and ModuleCode='PAYMT' and Deleted=0) into @CountMandatoryApproved;

if @CountMandatoryApproved >= @CountMandatory  THEN
BEGIN
    if @CountApproved >= @MaxApprovals  THEN
    BEGIN
     
        if(_Category='PreliminaryObjectionFees')Then
          Begin
             select ApplicationNo from applications where ID=_ApplicationID LIMIT 1 into @RespondedApplicationNo;
             update peresponse set status='Submited' where ApplicationNo=@RespondedApplicationNo;
               update notifications set Status='Resolved' where Category='Preliminary Objecions Fees Approval' and  ApplicationNo=@RespondedApplicationNo;

              select PEID from applications where ID=_ApplicationID LIMIT 1 into @PEID;
              select UserName from peusers where PEID=@PEID LIMIT 1 into @Applicant;
              insert into caseWithdrawalContacts select Name,Email,Phone,'Complete' from users where Username =@Applicant;
              update notifications set Status='Resolved' where Category='Preliminary Objecions Fees Approval' and ApplicationNo=_ApplicationID; 
               if(select count(*) from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0)>0 THEN
                Begin
                  select ApplicationNo from applications where ID=_ApplicationID LIMIT 1 into @appNo;
                     INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
                     select Username,'Panel Formation','Applications Awating Panel Formation',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',@appNo
                     from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0;
               End;
             End if;

          End;
          End if;
          if(_Category='ApplicationFees')Then
          Begin
             update applications set PaymentStatus='Approved',Status='Pending Approval' where ID=_ApplicationID;
             Update applicationfees set  FeesStatus='Approved', Narration=_Reff ,ApprovedBy=_Approver,
             DateApproved=NOW() where ApplicationID=_ApplicationID;
              update notifications set Status='Resolved' where Category='Applications Fees Approval' and  ApplicationNo=_ApplicationID; 
              select Created_By from applications where ID=_ApplicationID LIMIT 1 into @Applicant;
              insert into caseWithdrawalContacts select Name,Email,Phone,'Complete' from users where Username =@Applicant;
              select ApplicantID from applications where ID=_ApplicationID LIMIT 1 into @ApplicantID;
              insert into caseWithdrawalContacts select Name,Email,Mobile,'Complete' from applicants where  ID=@ApplicantID;
               insert into caseWithdrawalContacts select Name,Email,Phone,'Approver' from users
              inner join approvers on approvers.Username=users.Username
              where approvers.ModuleCode='APFRE' and approvers.Deleted=0 and Active=1;           
             
              if(select count(*) from approvers where ModuleCode ='APFRE' and Active=1 and Deleted=0)>0 THEN
              Begin
                  INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
                  select Username,'Applications Approval','Applications pending approval',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationID
                  from approvers where ModuleCode ='APFRE' and Active=1 and Deleted=0;
              End;
              End if;                    
          End;
          End if;

                    


    END;
    ELSE
    Begin
        insert into caseWithdrawalContacts select Name,Email,Phone,'Incomplete' from users
        inner join approvers on approvers.Username=users.Username
        where approvers.ModuleCode='PAYMT' and approvers.Deleted=0 and users.Username not in (select ApprovedBy from feesapprovalworkflow  
        WHERE ApplicationID=_ApplicationID and Status='Approved' and Category=_Category );    
    END;
    END if;


END;
 ELSE
    Begin
        insert into caseWithdrawalContacts select Name,Email,Phone,'Incomplete' from users
        inner join approvers on approvers.Username=users.Username
        where approvers.ModuleCode='PAYMT' and approvers.Deleted=0 and users.Username not in (select ApprovedBy from feesapprovalworkflow  
        WHERE ApplicationID=_ApplicationID and Status='Approved' and Category=_Category  );    
  END;
  END if;

    SELECT ApplicationNo from applications where ID=_ApplicationID LIMIT 1 into @App;
    if(_Category='PreliminaryObjectionFees')Then
    Begin
      call Saveapplicationsequence(@App,'Preliminary Objection Fees Payment Confirmed','Awaiting Panel Formation',_Approver);
    End;
    Else
    Begin
     call Saveapplicationsequence(@App,'Application Fees Payment Confirmed','Awaiting Application Approval',_Approver);
    End;
    End if;
  call ResolveMyNotification(_Approver,'Applications Fees Approval',_ApplicationID);
  select * from caseWithdrawalContacts;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApprovecaseAdjournment
DROP PROCEDURE IF EXISTS `ApprovecaseAdjournment`;
DELIMITER //
CREATE  PROCEDURE `ApprovecaseAdjournment`(IN _ApplicationNo VARCHAR(50), IN _ApprovalRemarks VARCHAR(255), IN _userID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Approved Case Adjournment for Application : ', _ApplicationNo); 

Update adjournmentApprovalWorkFlow set  DecisionDate= now(), Status='Approved', ApprovalRemarks =_ApprovalRemarks 
where ApplicationNo=_ApplicationNo and Approver=_userID and Status='Pending Approval';

select IFNULL(MaxApprovals,0) from approvalmodules where  ModuleCode ='ADJRE' LIMIT 1 into @MaxApprovals;
select IFNULL(count(*),0) from adjournmentApprovalWorkFlow  WHERE ApplicationNo=_ApplicationNo  and (Status='Approved' or Status='Fully Approved') and 
   Approver in (select Username from approvers WHERE Mandatory=0 and Deleted=0 and ModuleCode='ADJRE')
  into @CountApproved;
  -- check mandatory approvers
select IFNULL(count(*),0) from approvers WHERE Mandatory=1 and ModuleCode='ADJRE' and Deleted=0 into @CountMandatory;
select IFNULL(count(*),0) from adjournmentApprovalWorkFlow  WHERE  ApplicationNo=_ApplicationNo and (Status='Approved' or Status='Fully Approved') and 
  Approver in (select Username from approvers WHERE Mandatory=1 and ModuleCode='ADJRE' and Deleted=0) into @CountMandatoryApproved;

  if @CountMandatoryApproved >= @CountMandatory  THEN
BEGIN
    if @CountApproved >= @MaxApprovals  THEN
    BEGIN
      Update adjournment set  DecisionDate= now(), Status='Approved', ApprovalRemarks =_ApprovalRemarks where ApplicationNo=_ApplicationNo;
     -- update applications set Status='ADJOURNED' where ApplicationNo=_ApplicationNo;
      update notifications set Status='Resolved' where   Category='Case Adjournment Approval' and ApplicationNo=_ApplicationNo;
      Update adjournmentApprovalWorkFlow set  DecisionDate= now(), Status='Approved', ApprovalRemarks =_ApprovalRemarks 
      where ApplicationNo=_ApplicationNo  and Status='Pending Approval';

      call Saveapplicationsequence(_ApplicationNo,'Approved Request for Adjournment','Awaiting Approval',_userID);
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

    END;
    ELSE
    Begin
     

   END;
   END if;
END;
ELSE
Begin
    
END;
END if;

-- end of my new aproval


call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
call ResolveMyNotification(_userID,'Case Adjournment Approval',_ApplicationNo);



END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApprovecaseWithdrawal
DROP PROCEDURE IF EXISTS `ApprovecaseWithdrawal`;
DELIMITER //
CREATE  PROCEDURE `ApprovecaseWithdrawal`(IN _ApplicationNo varchar(50), IN _RejectionReason VARCHAR(255), IN _userID varchar(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Approved Case Withdrawal for Application : ', _ApplicationNo); 
insert into casewithdrawalapprovalworkflow (Date,Applicant,ApplicationNo,Reason,DecisionDate,Status,Frivolous,Created_At,Created_By,Approver)
select now(),Applicant,_ApplicationNo,_RejectionReason,now(),'Approved',0,now(),_userID,_userID from casewithdrawal where ApplicationNo=_ApplicationNo;

 DROP TABLE IF EXISTS caseWithdrawalContacts;
 create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Msg varchar(50));

select IFNULL(count(*),0) from approvers WHERE Mandatory=1 and ModuleCode='WIOAP' and Deleted=0 into @CountMandatory;
select IFNULL(count(*),0) from casewithdrawalapprovalworkflow  WHERE  ApplicationNo=_ApplicationNo and Status='Approved' and 
  Approver in (select Username from approvers WHERE Mandatory=1 and ModuleCode='WIOAP' and Deleted=0) into @CountMandatoryApproved;

select IFNULL(MaxApprovals,0) from approvalmodules where  ModuleCode ='WIOAP' LIMIT 1 into @MaxApprovals;
select IFNULL(count(*),0) from casewithdrawalapprovalworkflow  WHERE   ApplicationNo=_ApplicationNo and Status='Approved' and 
   Approver in (select Username from approvers WHERE Mandatory=0 and Deleted=0 and ModuleCode='WIOAP')
  into @CountApproved;

  if @CountMandatoryApproved >= @CountMandatory  THEN
    BEGIN
          if @CountApproved >= @MaxApprovals  THEN
          BEGIN
              Update casewithdrawal set  DecisionDate= now(), Status='Approved', RejectionReason =_RejectionReason,Frivolous =0 where ApplicationNo=_ApplicationNo;
              update applications set Status='WITHDRAWN' where ApplicationNo=_ApplicationNo;
              call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
          update notifications set Status='Resolved' where Category='Case withdrawal Approval' and  ApplicationNo=_ApplicationNo; 
              call Saveapplicationsequence(_ApplicationNo,'WITHDRAWN','  ',_userID);
            
              insert into caseWithdrawalContacts select Name,Email,Phone,'Complete' from users where Username in (select UserName from panels where ApplicationNo=_ApplicationNo and Status='Approved' );
              insert into caseWithdrawalContacts select Name,Email,Phone,'Complete' from users where Username in (select UserName from casedetails where  ApplicationNo=_ApplicationNo and Deleted=0);
              select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
              insert into caseWithdrawalContacts select Name,Email,Phone,'Complete' from users where Username in (select UserName from peusers where PEID=@PEID);
              insert into caseWithdrawalContacts select Name,Email,Mobile,'Complete' from procuremententity where PEID=@PEID;
              select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
              insert into caseWithdrawalContacts select Name,Email,Phone,'Complete' from users where Username =@Applicant;
              select ApplicantID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
              insert into caseWithdrawalContacts select Name,Email,Mobile,'Complete' from applicants where  ID=@ApplicantID;
              select ID from applications where ApplicationNo=_ApplicationNo limit 1 into @ApplicationID;
              insert into caseWithdrawalContacts select Name,Email,Mobile,'Complete' from interestedparties where  ApplicationID=@ApplicationID;
              
          END;
          ELSE
            Begin
              insert into caseWithdrawalContacts select Name,Email,Phone,'Incomplete' from users
                inner join approvers on approvers.Username=users.Username
              where approvers.ModuleCode='WIOAP' and approvers.Deleted=0 and users.Username not in (select Approver from casewithdrawalapprovalworkflow  
              WHERE   ApplicationNo=_ApplicationNo and Status='Approved' );
          End;
          End IF;
    END;
    else
      Begin
        insert into caseWithdrawalContacts select Name,Email,Phone,'Incomplete' from users
                inner join approvers on approvers.Username=users.Username
              where approvers.ModuleCode='WIOAP' and approvers.Deleted=0 and users.Username not in (select Approver from casewithdrawalapprovalworkflow  
              WHERE   ApplicationNo=_ApplicationNo and Status='Approved' );
      End;
    End IF;

 
  select * from caseWithdrawalContacts;


END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApproveDeadlineRequestExtension
DROP PROCEDURE IF EXISTS `ApproveDeadlineRequestExtension`;
DELIMITER //
CREATE  PROCEDURE `ApproveDeadlineRequestExtension`(IN _Approver VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _Remarks VARCHAR(255), IN _Newdate DATETIME)
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Approved Deadline Extension Request for Application:',_ApplicationNo); 
UPDATE deadlineapprovalworkflow
SET Status='Approved',Approved_At=now(),Remarks=_Remarks
WHERE Approver=_Approver and ApplicationNo=_ApplicationNo;
-- select Level from approvers  where ModuleCode ='REXED' and Username=_Approver LIMIT 1 INTO @CurentLevel;

select IFNULL(MaxApprovals,0) from approvalmodules where  ModuleCode ='REXED' LIMIT 1 into @MaxApprovals;
select IFNULL(count(*),0) from deadlineapprovalworkflow  WHERE ApplicationNo=_ApplicationNo  and (Status='Approved' or Status='Fully Approved') and 
   Approver in (select Username from approvers WHERE Mandatory=0 and Deleted=0 and ModuleCode='REXED')
  into @CountApproved;
  -- check mandatory approvers
select IFNULL(count(*),0) from approvers WHERE Mandatory=1 and ModuleCode='REXED' and Deleted=0 into @CountMandatory;
select IFNULL(count(*),0) from deadlineapprovalworkflow  WHERE  ApplicationNo=_ApplicationNo and (Status='Approved' or Status='Fully Approved') and 
  Approver in (select Username from approvers WHERE Mandatory=1 and ModuleCode='REXED' and Deleted=0) into @CountMandatoryApproved;

if @CountMandatoryApproved >= @CountMandatory  THEN
BEGIN
    if @CountApproved >= @MaxApprovals  THEN
    BEGIN
      update notifications set Status='Resolved' where Category='Deadline Approval' and ApplicationNo=_ApplicationNo; 

      UPDATE deadlineapprovalworkflow SET Status='Fully Approved',Approved_At=now(),Remarks=_Remarks
      WHERE Approver=_Approver and ApplicationNo=_ApplicationNo ; 
      update pedeadlineextensionsrequests SET Status='Fully Approved'
      WHERE ApplicationNo=_ApplicationNo ;    
      update peresponsetimer set DueOn=_Newdate where ApplicationNo=_ApplicationNo;    
      select PEID from deadlineapprovalworkflow WHERE Approver=_Approver and ApplicationNo=_ApplicationNo LIMIT 1 INTO @PEID;
      select Name,Email,Mobile,_Newdate as NewDeadline, 'Fully Approved' as msg from procuremententity where PEID=@PEID;

    END;
    ELSE
    Begin
      select Username from approvers  where ModuleCode ='REXED' and  Deleted=0 and Active=1 and Username
      NOT IN (Select Approver deadlineapprovalworkflow where Status='Approved' and ApplicationNo=_ApplicationNo )
      LIMIT 1 INTO @Approver2;   
     
      select Name,Email,Phone, 'Partially Approved' as msg from users where Username=@Approver2;

   END;
   END if;
END;
ELSE
Begin
      select Username from approvers  where ModuleCode ='REXED' and  Deleted=0 and Active=1 and Username
      NOT IN (Select Approver deadlineapprovalworkflow where Status='Approved' and ApplicationNo=_ApplicationNo )
      LIMIT 1 INTO @Approver2;    
     
      select Name,Email,Phone, 'Partially Approved' as msg from users where Username=@Approver2;
END;
END if;
call ResolveMyNotification(_Approver,'Deadline Approval',_ApplicationNo);
call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Approvedecisiondocuments
DROP PROCEDURE IF EXISTS `Approvedecisiondocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Approvedecisiondocuments`(IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50), IN _DecisionDate DATE, IN _Followup BOOLEAN, IN _Referral BOOLEAN, IN _Closed BOOLEAN, IN _ApplicationSuccessful BOOLEAN, IN _Annulled BOOLEAN, IN _GiveDirection BOOLEAN, IN _Terminated BOOLEAN, IN _ReTender BOOLEAN, IN _CostsPE BOOLEAN, IN _CostsApplicant BOOLEAN, IN _CostsEachParty BOOLEAN, IN _Substitution BOOLEAN)
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Approved decision for application: ', _ApplicationNo); 
UPDATE applications set  DecisionDate =_DecisionDate,
  Followup =_Followup,
  Referral =_Referral, 
  Status='Closed',  
  Closed=1,
  Annulled=_Annulled,
  GiveDirection=_GiveDirection,
  ISTerminated=_Terminated,
  ReTender=_ReTender,
  CostsPE=_CostsPE,
  CostsEachParty=_CostsEachParty,
  CostsApplicant=_CostsApplicant,
  Substitution=_Substitution,
  ApplicationSuccessful=_ApplicationSuccessful where ApplicationNo=_ApplicationNo;
  update decisions set Status='Approved',ApprovalRemarks='Approved' where ApplicationNo=_ApplicationNo;
  call SaveAuditTrail(_UserID,lSaleDesc,'Approve','0' );
   update notifications set Status='Resolved' where Category='Decision Approval';
   Update decisiondocuments set Status='Approved' where ApplicationNo=_ApplicationNo;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.ApprovePanelMember
DROP PROCEDURE IF EXISTS `ApprovePanelMember`;
DELIMITER //
CREATE  PROCEDURE `ApprovePanelMember`(IN _ApplicationNo VARCHAR(50),  IN _UserName VARCHAR(50), IN _UserID varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Approved  PanelMember:', _UserName); 
  update Panels set Status='Approved' where ApplicationNo=_ApplicationNo and UserName=_UserName; 
  update panelsapprovalworkflow  set Status='Approved',Approver=_UserID, Approved_At=now() where ApplicationNo=_ApplicationNo and UserName=_UserName and Status='Pending Approval';
  call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
END//
DELIMITER ;

-- Dumping structure for table arcm.approvers
DROP TABLE IF EXISTS `approvers`;
CREATE TABLE IF NOT EXISTS `approvers` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ModuleCode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Mandatory` tinyint(1) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.approvers: ~0 rows (approximately)
DELETE FROM `approvers`;
/*!40000 ALTER TABLE `approvers` DISABLE KEYS */;
/*!40000 ALTER TABLE `approvers` ENABLE KEYS */;

-- Dumping structure for procedure arcm.AssignCaseOfficer
DROP PROCEDURE IF EXISTS `AssignCaseOfficer`;
DELIMITER //
CREATE  PROCEDURE `AssignCaseOfficer`(IN _Applicationno VARCHAR(50), IN _PEID VARCHAR(50), IN _UserID VARCHAR(50))
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
  Select Username,OngoingCases,CumulativeCases from caseofficers where (NOW() NOT  BETWEEN NotAvailableFrom and NotAvailableTo); 
select Name from TempUsers where OngoingCases in  (SELECT MIN(OngoingCases) FROM TempUsers ) OR CumulativeCases in( SELECT MIN(CumulativeCases) FROM TempUsers )  LIMIT 1 into @USER;

INSERT INTO `casedetails`( `UserName`, `ApplicationNo`, `DateAsigned`, `Status`, `PrimaryOfficer`,  `Created_At`, `Created_By`, `Deleted`) 
  VALUES (@USER,_Applicationno,now(),'Open',1,now(),_UserID,0);

  select OngoingCases from caseofficers where Username=@USER into @CurrentOngoingCases;
  select CumulativeCases from caseofficers where Username=@USER into @CurrentCumulativeCases;
  update caseofficers set OngoingCases=@CurrentOngoingCases+1,CumulativeCases=@CurrentCumulativeCases+1 where Username=@USER  ;
delete from TempUsers;
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
  `Designation` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FirmFrom` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.attendanceregister: ~0 rows (approximately)
DELETE FROM `attendanceregister`;
/*!40000 ALTER TABLE `attendanceregister` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.audittrails: ~0 rows (approximately)
DELETE FROM `audittrails`;
/*!40000 ALTER TABLE `audittrails` DISABLE KEYS */;
/*!40000 ALTER TABLE `audittrails` ENABLE KEYS */;

-- Dumping structure for table arcm.banks
DROP TABLE IF EXISTS `banks`;
CREATE TABLE IF NOT EXISTS `banks` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Branch` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AcountNo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PayBill` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Update_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Delete_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.banks: ~2 rows (approximately)
DELETE FROM `banks`;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` (`ID`, `Name`, `Branch`, `AcountNo`, `PayBill`, `Created_By`, `Created_At`, `Update_By`, `Updated_At`, `Deleted`, `Delete_By`, `Deleted_At`) VALUES
	(2, 'National Bank', 'Harambee Avenue', '0789876544321', '7575', 'Admin', '2019-11-21 16:30:20', 'Admin', '2019-11-28 12:06:26', 0, NULL, NULL),
	(3, 'KCB Bank', 'KenCom', '0789876544321', '7575', 'Admin', '2019-11-28 12:07:11', NULL, NULL, 1, 'Admin', '2019-11-28 12:07:14');
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;

-- Dumping structure for table arcm.bankslips
DROP TABLE IF EXISTS `bankslips`;
CREATE TABLE IF NOT EXISTS `bankslips` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` bigint(20) NOT NULL,
  `Name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=5461;

-- Dumping data for table arcm.bankslips: ~0 rows (approximately)
DELETE FROM `bankslips`;
/*!40000 ALTER TABLE `bankslips` DISABLE KEYS */;
/*!40000 ALTER TABLE `bankslips` ENABLE KEYS */;

-- Dumping structure for procedure arcm.BookVenue
DROP PROCEDURE IF EXISTS `BookVenue`;
DELIMITER //
CREATE  PROCEDURE `BookVenue`(IN _VenueID INT(11),IN _Date DATETIME,IN _Slot VARCHAR(50),IN _UserID varchar(50),IN _Content VARCHAR(255))
BEGIN
  DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Booked Venue:',_VenueID); 
 
   INSERT INTO venuebookings( VenueID ,Date ,Slot , Booked_By,Content, Booked_On,Deleted)
    VALUES(_VenueID,_Date,_Slot,_UserID,_Content,now(),0);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
  update applications set Status='HEARING IN PROGRESS' where ApplicationNo=_Content;
    update notifications set Status='Resolved' where Category='Case Scheduling'; 


  if(select Count(*) from applicationsequence where ApplicationNo=_Content and Action='Scheduled Hearing Date and Venue')<1 THEN
  Begin
     call Saveapplicationsequence(_Content,'Scheduled Hearing Date and Venue','HEARING IN PROGRESS',_UserID);
   
  End;
    end if;
 

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2730;

-- Dumping data for table arcm.branches: ~0 rows (approximately)
DELETE FROM `branches`;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;

-- Dumping structure for table arcm.caseanalysis
DROP TABLE IF EXISTS `caseanalysis`;
CREATE TABLE IF NOT EXISTS `caseanalysis` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `ApplicationNO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `Title` text COLLATE utf8mb4_unicode_ci,
  `Create_at` datetime NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `DeletedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.caseanalysis: ~0 rows (approximately)
DELETE FROM `caseanalysis`;
/*!40000 ALTER TABLE `caseanalysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `caseanalysis` ENABLE KEYS */;

-- Dumping structure for table arcm.caseanalysisdocuments
DROP TABLE IF EXISTS `caseanalysisdocuments`;
CREATE TABLE IF NOT EXISTS `caseanalysisdocuments` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `FileName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FilePath` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `Create_at` datetime NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `DeletedBY` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime(6) DEFAULT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Confidential` tinyint(1) DEFAULT NULL,
  `SubmitedBy` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.caseanalysisdocuments: ~0 rows (approximately)
DELETE FROM `caseanalysisdocuments`;
/*!40000 ALTER TABLE `caseanalysisdocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `caseanalysisdocuments` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casedetails: ~0 rows (approximately)
DELETE FROM `casedetails`;
/*!40000 ALTER TABLE `casedetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `casedetails` ENABLE KEYS */;

-- Dumping structure for table arcm.caseofficers
DROP TABLE IF EXISTS `caseofficers`;
CREATE TABLE IF NOT EXISTS `caseofficers` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MinValue` float DEFAULT NULL,
  `MaximumValue` float DEFAULT NULL,
  `Active` tinyint(1) DEFAULT NULL,
  `NotAvailableFrom` datetime DEFAULT NULL,
  `NotAvailableTo` datetime DEFAULT NULL,
  `OngoingCases` int(11) DEFAULT '0',
  `CumulativeCases` int(11) DEFAULT '0',
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `DeletedBY` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.caseofficers: ~0 rows (approximately)
DELETE FROM `caseofficers`;
/*!40000 ALTER TABLE `caseofficers` DISABLE KEYS */;
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
  `Open` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casesittingsregister: ~0 rows (approximately)
DELETE FROM `casesittingsregister`;
/*!40000 ALTER TABLE `casesittingsregister` DISABLE KEYS */;
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
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawal: ~0 rows (approximately)
DELETE FROM `casewithdrawal`;
/*!40000 ALTER TABLE `casewithdrawal` DISABLE KEYS */;
/*!40000 ALTER TABLE `casewithdrawal` ENABLE KEYS */;

-- Dumping structure for table arcm.casewithdrawalapprovalworkflow
DROP TABLE IF EXISTS `casewithdrawalapprovalworkflow`;
CREATE TABLE IF NOT EXISTS `casewithdrawalapprovalworkflow` (
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
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawalapprovalworkflow: ~0 rows (approximately)
DELETE FROM `casewithdrawalapprovalworkflow`;
/*!40000 ALTER TABLE `casewithdrawalapprovalworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `casewithdrawalapprovalworkflow` ENABLE KEYS */;

-- Dumping structure for table arcm.casewithdrawalcontacts
DROP TABLE IF EXISTS `casewithdrawalcontacts`;
CREATE TABLE IF NOT EXISTS `casewithdrawalcontacts` (
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Msg` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawalcontacts: ~0 rows (approximately)
DELETE FROM `casewithdrawalcontacts`;
/*!40000 ALTER TABLE `casewithdrawalcontacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `casewithdrawalcontacts` ENABLE KEYS */;

-- Dumping structure for procedure arcm.CheckifregistrationIsOpen
DROP PROCEDURE IF EXISTS `CheckifregistrationIsOpen`;
DELIMITER //
CREATE  PROCEDURE `CheckifregistrationIsOpen`(IN _Applicationno VARCHAR(50))
BEGIN
if(select count(*) from  casesittingsregister    where ApplicationNo=_Applicationno)>0 THEN
BEGIN
select * from  casesittingsregister    where ApplicationNo=_Applicationno and Open=1;
End;
else
Begin
  select 'Its new registration';
End;
  End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.CloseRegistrations
DROP PROCEDURE IF EXISTS `CloseRegistrations`;
DELIMITER //
CREATE  PROCEDURE `CloseRegistrations`(IN _Applicationno VARCHAR(50))
BEGIN
update casesittingsregister set  Open=0 where ApplicationNo=_Applicationno;
END//
DELIMITER ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.committeetypes: ~0 rows (approximately)
DELETE FROM `committeetypes`;
/*!40000 ALTER TABLE `committeetypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `committeetypes` ENABLE KEYS */;

-- Dumping structure for procedure arcm.CompleteApplication
DROP PROCEDURE IF EXISTS `CompleteApplication`;
DELIMITER //
CREATE  PROCEDURE `CompleteApplication`(IN _ApplicationID INT, IN _userID VARCHAR(50))
BEGIN
Update applications set Status='Submited' where ID=_ApplicationID;
 select ApplicationNo from applications where ID=_ApplicationID LIMIT 1 into @App; 
call Saveapplicationsequence(@App,'Submited Application','Awaiting fees confirmation',_userID); 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ComprehensiveAttendanceRegister
DROP PROCEDURE IF EXISTS `ComprehensiveAttendanceRegister`;
DELIMITER //
CREATE  PROCEDURE `ComprehensiveAttendanceRegister`(IN _ApplicationNo varchar(50))
BEGIN
 
select CONCAT(branches.Description,' ' ,venues.Name , ' - ', venues.Description)as venue, DATE_FORMAT(casesittingsregister.Date, '%d-%m-%Y') as Date, casesittingsregister.VenueID,
  attendanceregister.RegisterID,attendanceregister.IDNO,
  attendanceregister.MobileNo,attendanceregister.Name,attendanceregister.Email,attendanceregister.Category,FirmFrom from attendanceregister 
    inner join casesittingsregister on casesittingsregister.ID=attendanceregister.RegisterID
  inner join venues on venues.ID=casesittingsregister.VenueID
  inner join branches on branches.ID=venues.Branch
    where casesittingsregister.ApplicationNo=_ApplicationNo  ORDER by Date DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Computefeestest
DROP PROCEDURE IF EXISTS `Computefeestest`;
DELIMITER //
CREATE  PROCEDURE `Computefeestest`(IN _ApplicationID Int, IN _UserID varchar(50))
BEGIN
   select TenderID from applications where ID=_ApplicationID LIMIT 1 INTO @TenderID;
    select TenderType from tenders where ID=@TenderID limit 1 into @TenderType;
    select ApplicationREf from applications where ID=_ApplicationID Limit 1 into @ApplicationREf;
   Update applicationfees set Deleted=1,Deleted_At=now(),Deleted_By=_UserID where ApplicationID=_ApplicationID;
 
select MaxFee from feesstructure where  Name='Administrative Fee' LIMIT 1 into @Fee;
select ID   from feesstructure where Name='Administrative Fee' LIMIT 1 into @DescriptionID;
call SaveApplicationFees(_ApplicationID,@DescriptionID,@Fee,@ApplicationREf, _UserID);

if (@TenderType = 'A') Then
Begin

  drop TEMPORARY TABLE IF EXISTS FeesCalc ; 
   SET @row_number = 0;    
        CREATE TEMPORARY TABLE FeesCalc
         select (@row_number:=@row_number + 1) as ID,ID as Description,MinAmount,MaxAmount,Rate1,MinFee,MaxFee 
        from feesstructure where TenderType='A' order by MinAmount ASC;
        SET @counter = 1; 
        select TenderValue from tenders where ID=@TenderID limit 1 into @Tendervalue;
        select count(*) from FeesCalc into @maxCount;
          myloop: WHILE (@counter <= @maxCount) DO
          select  MinAmount from FeesCalc where ID=@counter into @MinAmount;
          select  MaxAmount from FeesCalc where ID=@counter into @MaxAmount;
          select Rate1/100 from FeesCalc where ID=@counter into @Rate;
          select MinFee from FeesCalc where ID=@counter into @MinFee;
          select MaxFee from FeesCalc where ID=@counter into @MaxFee;
          select Description from FeesCalc where ID=@counter into @Description;
 
          if(@Tendervalue <= 1) THEN
            Begin
            LEAVE myloop;
              End;
            END If;

           if(@MaxAmount = 0) Then
              Begin
                set @SlabDiff=@Tendervalue;
              End;
              Else
              Begin
                 set @SlabDiff=@MaxAmount-@MinAmount;
                End;
              End if;
         
          if(@Tendervalue >= @SlabDiff) THEN
            Begin
             
               if(@counter = 1)THEN
                Begin
                  select @Rate * @SlabDiff into @Value1;
                  SET @Tendervalue = @Tendervalue - @SlabDiff; 
                         if(@Value1 < @MinFee)THEN
                            Begin                            
                               call SaveApplicationFees(_ApplicationID,@Description,@MinFee,@ApplicationREf, _UserID);
                            End;
                         Else
                            Begin
                              select @Rate * @SlabDiff into @Value1;
                              call SaveApplicationFees(_ApplicationID,@Description,@Value1,@ApplicationREf, _UserID);
                            End;
                      End if;
                 End;
                Else
                Begin
                   select @Rate * @SlabDiff into @Value1;
                  
                    if(@Value1 > @MaxFee)THEN
                            Begin                            
                               call SaveApplicationFees(_ApplicationID,@Description,@MaxFee,@ApplicationREf, _UserID);
                            End;
                         Else
                            Begin
                              select @Rate * @SlabDiff into @Value1;
                              call SaveApplicationFees(_ApplicationID,@Description,@Value1,@ApplicationREf, _UserID);
                            End;
                      End if;
                  --
                   SET @Tendervalue = @Tendervalue - @SlabDiff; 
                  -- call SaveApplicationFees(_ApplicationID,@Description,@Value1,@ApplicationREf, _UserID);
                End;
                End if;
                  
            End;
            ELSE
            Begin
                if(@counter = 1)THEN
                Begin
                   select @Rate * @Tendervalue into @Value1;
                   SET @Tendervalue = @Tendervalue - @Tendervalue; 
                         if(@Value1 < @MinFee)THEN
                            Begin                                                         
                             call SaveApplicationFees(_ApplicationID,@Description,@MinFee,@ApplicationREf, _UserID);          
                            End;
                         Else
                            Begin
                              call SaveApplicationFees(_ApplicationID,@Description,@Value1,@ApplicationREf, _UserID);          
                            End;
                      End if;
                 End;
                Else
                Begin
                  select @Rate * @Tendervalue into @Value1;
                       if(@Value1 > @MaxFee)THEN
                            Begin                            
                               call SaveApplicationFees(_ApplicationID,@Description,@MaxFee,@ApplicationREf, _UserID);
                            End;
                         Else
                            Begin
                              select @Rate * @Tendervalue into @Value1;
                              call SaveApplicationFees(_ApplicationID,@Description,@Value1,@ApplicationREf, _UserID);
                            End;
                      End if;

                  SET @Tendervalue = @Tendervalue - @Tendervalue; 
                         
                End;
  
                End if;
             
            End;
          END IF;

        SET @counter = @counter + 1;        
        END WHILE myloop;
End;
End if;
-- type B tenders
if (@TenderType = 'B') Then
Begin
select TenderCategory  from tenders where ID=@TenderID Limit 1 into @TenderCategory;
select TenderSubCategory  from tenders where ID=@TenderID Limit 1 into @TenderSubCategory;
if(@TenderCategory='Pre-qualification')THEN
Begin
select MaxFee from feesstructure where TenderType='B' and Name=@TenderSubCategory LIMIT 1 into @Fee;
select ID   from feesstructure where TenderType='B' and Name=@TenderSubCategory LIMIT 1 into @DescriptionID;
call SaveApplicationFees(_ApplicationID,@DescriptionID,@Fee,@ApplicationREf, _UserID);
End;
End if;
if(@TenderCategory='Unquantified Tenders')THEN
Begin
select MaxFee from feesstructure where TenderType='C' and Name=@TenderSubCategory LIMIT 1 into @Fee;
select ID   from feesstructure where TenderType='C' and Name=@TenderSubCategory LIMIT 1 into @DescriptionID;
call SaveApplicationFees(_ApplicationID,@DescriptionID,@Fee,@ApplicationREf, _UserID);
End;
End if;
if(@TenderCategory='Other Tenders')THEN
Begin
select MaxFee from feesstructure where TenderType='D'  LIMIT 1 into @Fee;
select ID   from feesstructure where TenderType='D'  LIMIT 1 into @DescriptionID;
call SaveApplicationFees(_ApplicationID,@DescriptionID,@Fee,@ApplicationREf, _UserID);
End;
End if;
End;
End if;
END//
DELIMITER ;

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
  `Year` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PeResponseDays` int(11) DEFAULT '5',
  `CaseClosingDate` int(11) DEFAULT '21',
  PRIMARY KEY (`ID`,`Code`),
  KEY `Configurations_Users` (`Deleted_By`),
  KEY `Configurations_Updateduser` (`Updated_By`),
  KEY `Configurations_createduser` (`Created_By`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.configurations: ~0 rows (approximately)
DELETE FROM `configurations`;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` (`ID`, `Code`, `Name`, `PhysicalAdress`, `Street`, `PoBox`, `PostalCode`, `Town`, `Telephone1`, `Telephone2`, `Mobile`, `Fax`, `Email`, `Website`, `PIN`, `Logo`, `NextPE`, `NextComm`, `NextSupplier`, `NextMember`, `NextProcMeth`, `NextStdDoc`, `NextApplication`, `NextRev`, `Created_At`, `Updated_At`, `Created_By`, `Updated_By`, `Deleted`, `Deleted_By`, `NextPEType`, `NextMemberType`, `NextFeeCode`, `NextTenderType`, `Year`, `PeResponseDays`, `CaseClosingDate`) VALUES
	(3, 'PPARB', 'PUBLIC PROCUREMENT ADMINISTRATIVE REVIEW BOARD', 'National Bank Building', 'Harambee Avenue', '58535', '00200', 'Nairobi', '0203244214', '0203244241', '0724562264', 'fax', 'pparb@ppra.go.ke1', 'https://www.ppra.go.ke', '123456789098', '1574933357639-PPRALogo.png', '413', '7', '22', '1', '1', '1', '33', '1', '2019-07-29 14:14:38', '2019-12-02 14:25:09', 'Admin', 'Admin', 0, ' ', '19', '1', '1', '5', '2019', 5, 21);
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
DELETE FROM `counties`;
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
DELETE FROM `deadlineapprovalworkflow`;
/*!40000 ALTER TABLE `deadlineapprovalworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `deadlineapprovalworkflow` ENABLE KEYS */;

-- Dumping structure for table arcm.decisiondocuments
DROP TABLE IF EXISTS `decisiondocuments`;
CREATE TABLE IF NOT EXISTS `decisiondocuments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Path` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Confidential` tinyint(1) DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.decisiondocuments: ~0 rows (approximately)
DELETE FROM `decisiondocuments`;
/*!40000 ALTER TABLE `decisiondocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `decisiondocuments` ENABLE KEYS */;

-- Dumping structure for table arcm.decisionorders
DROP TABLE IF EXISTS `decisionorders`;
CREATE TABLE IF NOT EXISTS `decisionorders` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NO` int(11) DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `Created_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.decisionorders: ~0 rows (approximately)
DELETE FROM `decisionorders`;
/*!40000 ALTER TABLE `decisionorders` DISABLE KEYS */;
/*!40000 ALTER TABLE `decisionorders` ENABLE KEYS */;

-- Dumping structure for table arcm.decisions
DROP TABLE IF EXISTS `decisions`;
CREATE TABLE IF NOT EXISTS `decisions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Backgroundinformation` text COLLATE utf8mb4_unicode_ci,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DecisionSummary` text COLLATE utf8mb4_unicode_ci,
  `RequestforReview` text COLLATE utf8mb4_unicode_ci,
  `ApprovalRemarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.decisions: ~0 rows (approximately)
DELETE FROM `decisions`;
/*!40000 ALTER TABLE `decisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `decisions` ENABLE KEYS */;

-- Dumping structure for procedure arcm.DeclineApplication
DROP PROCEDURE IF EXISTS `DeclineApplication`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeclineApplication`(IN _Approver VARCHAR(50),IN _ApplicationNo varchar(50),IN _Remarks varchar(255))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
 DROP TABLE IF EXISTS ApplicationApprovalContacts;
 create table ApplicationApprovalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Msg varchar(50),ApplicationNo varchar(50));

set lSaleDesc= CONCAT(' Declined Application: ',_ApplicationNo); 
UPDATE applications_approval_workflow
SET Status='Declined',Approved_At=now(),Remarks=_Remarks
WHERE Approver=_Approver and ApplicationNo=_ApplicationNo;
update applications set Status='DECLINED' where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
   update notifications set Status='Resolved' where Category='Applications Approval' and  ApplicationNo=_ApplicationNo;   

select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant;
insert into ApplicationApprovalContacts select Name,Email,Phone,'Applicant',_ApplicationNo from users where Username =@Applicant;
select ApplicantID from applications where  ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicantID;
insert into ApplicationApprovalContacts select Name,Email,Mobile,'Applicant',_ApplicationNo from applicants where  ID=@ApplicantID; 
  select * from ApplicationApprovalContacts;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeclinecaseAdjournment
DROP PROCEDURE IF EXISTS `DeclinecaseAdjournment`;
DELIMITER //
CREATE  PROCEDURE `DeclinecaseAdjournment`(IN _ApplicationNo VARCHAR(50), IN _ApprovalRemarks VARCHAR(255), IN _userID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Declined Case Adjournment for Application : ', _ApplicationNo); 
Update adjournment set  DecisionDate= now(), Status='Declined', ApprovalRemarks =_ApprovalRemarks where ApplicationNo=_ApplicationNo;
call Saveapplicationsequence(_ApplicationNo,'Declined Request for Adjournment','Awaiting Approval',_userID);
     Update adjournmentApprovalWorkFlow set  DecisionDate= now(), Status='Declined', ApprovalRemarks =_ApprovalRemarks 
      where ApplicationNo=_ApplicationNo  and Status='Pending Approval';

  call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
  
    update notifications set Status='Resolved' where   Category='Case Adjournment Approval' and ApplicationNo=_ApplicationNo;
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
CREATE  PROCEDURE `DeclinecaseWithdrawal`(IN _ApplicationNo varchar(50), IN _RejectionReason VARCHAR(255),IN _userID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Declined Case Withdrawal for Application : ', _ApplicationNo); 
Update casewithdrawal set  DecisionDate= now(), Status='Declined', RejectionReason =_RejectionReason,Frivolous =0 where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
call Saveapplicationsequence(_ApplicationNo,'Declined request for case withdrawal','  ',_userID);
  update notifications set Status='Resolved' where Category='Case withdrawal Approval' and  ApplicationNo=_ApplicationNo; 
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
  select ID from applications where ApplicationNo=_ApplicationNo limit 1 into @ApplicationID;
  insert into caseWithdrawalContacts select Name,Email,Mobile from interestedparties where  ApplicationID=@ApplicationID;
  select Name,Email,Mobile,_RejectionReason as reason from caseWithdrawalContacts;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeclineDeadlineRequestExtension
DROP PROCEDURE IF EXISTS `DeclineDeadlineRequestExtension`;
DELIMITER //
CREATE  PROCEDURE `DeclineDeadlineRequestExtension`(IN _Approver VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _Remarks VARCHAR(255))
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT(' Declined Deadline Extension Request for Application:',_ApplicationNo); 
UPDATE deadlineapprovalworkflow
SET Status='DECLINED',Approved_At=now(),Remarks=_Remarks
WHERE Approver=_Approver and ApplicationNo=_ApplicationNo;

		UPDATE deadlineapprovalworkflow SET Status='DECLINED',Approved_At=now(),Remarks=_Remarks
		WHERE Approver=_Approver and ApplicationNo=_ApplicationNo ; 
    update pedeadlineextensionsrequests SET Status='DECLINED'
		WHERE ApplicationNo=_ApplicationNo ;
 update notifications set Status='Resolved' where Category='Deadline Approval' and ApplicationNo=_ApplicationNo; 
 call SaveAuditTrail(_Approver,lSaleDesc,'Approval','0' );
  select PEID from deadlineapprovalworkflow WHERE Approver=_Approver and ApplicationNo=_ApplicationNo LIMIT 1 INTO @PEID;
  SELECT DueOn FROM  peresponsetimer  where ApplicationNo=_ApplicationNo AND PEID=@PEID LIMIT 1 into @requestedDeadline;
  select Name,Email,Mobile,@requestedDeadline as NewDeadline, 'DECLINED' as msg,_Remarks as Reason from procuremententity where PEID=@PEID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Declinedecisiondocuments
DROP PROCEDURE IF EXISTS `Declinedecisiondocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Declinedecisiondocuments`(IN _ApplicationNo VARCHAR(50),IN _Remarks VARCHAR(255), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Declined decision for application: ', _ApplicationNo); 
  update decisions set Status='Draft',ApprovalRemarks=_Remarks where ApplicationNo=_ApplicationNo;
  UPDATE applications set Status='HEARING IN PROGRESS'where ApplicationNo=_ApplicationNo;
  call SaveAuditTrail(_UserID,lSaleDesc,'Approve','0' );
   update notifications set Status='Resolved' where Category='Decision Approval';
  select UserName from casedetails where ApplicationNo=_ApplicationNo and PrimaryOfficer=1 and Deleted=0 LIMIT 1 into @CaseOff;
  select Name,Email,Phone,_ApplicationNo as ApplicationNo, _Remarks as Remarks from users where Username=@CaseOff;

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

-- Dumping structure for procedure arcm.Deleteadditionalsubmissions
DROP PROCEDURE IF EXISTS `Deleteadditionalsubmissions`;
DELIMITER //
CREATE  PROCEDURE `Deleteadditionalsubmissions`(IN `_ApplicationID` INT,IN _userID varchar(50) )
BEGIN

DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted additionalsubmissions for Application :',_ApplicationID); 
 Update additionalsubmissions set Deleted=1 where ApplicationID=_ApplicationID;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteadditionalsubmissionsDocument
DROP PROCEDURE IF EXISTS `DeleteadditionalsubmissionsDocument`;
DELIMITER //
CREATE  PROCEDURE `DeleteadditionalsubmissionsDocument`(IN _DocName VARCHAR(100),IN _userID varchar(50) )
BEGIN

DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted additionalsubmissions Document:',_DocName); 
 Update additionalsubmissionDocuments set Deleted=1 where FileName=_DocName;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteadjournmentDocuments
DROP PROCEDURE IF EXISTS `DeleteadjournmentDocuments`;
DELIMITER //
CREATE  PROCEDURE `DeleteadjournmentDocuments`(IN _File VARCHAR(50),IN _UserID varchar(50))
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
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteApprover`(IN _Username VARCHAR(50), IN _UserID VARCHAR(50), IN _Module VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Approver: '+ _Username ); 
Update approvers set Deleted=1, Deleted_At=now(),DeletedBY=_UserID
where Username=_Username and ModuleCode=_Module;
call SaveAuditTrail(_userID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteAttachments
DROP PROCEDURE IF EXISTS `DeleteAttachments`;
DELIMITER //
CREATE  PROCEDURE `DeleteAttachments`(IN _Name VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
  DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted hearing attachment:',_Name); 
Update hearingattachments set Deleted=1,DeletedBy=_UserID where Name=_Name;
  call SaveAuditTrail(_UserID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteBank
DROP PROCEDURE IF EXISTS `DeleteBank`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteBank`( IN _ID INT,  IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Bank: '+ _ID ); 
Update banks set Deleted=1,Delete_By=_userID,Deleted_At=NOW() WHERE ID=_ID;
call SaveAuditTrail(_userID,'Deleted bank Account','Add','0' );
  call SaveAuditTrail(_userID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteBankSlips
DROP PROCEDURE IF EXISTS `DeleteBankSlips`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteBankSlips`(IN _Name VARCHAR(150), IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted bank slip: ', _Name); 
 Update bankslips set Deleted=1 where Name=_Name;
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletecaseanalysisdocuments
DROP PROCEDURE IF EXISTS `Deletecaseanalysisdocuments`;
DELIMITER //
CREATE  PROCEDURE `Deletecaseanalysisdocuments`(IN _DocName VARCHAR(100),IN _userID varchar(50) )
BEGIN

DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted case analysis Document:',_DocName); 
 Update caseanalysisdocuments set Deleted=1 where FileName=_DocName;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeletecaseAnalysisSection
DROP PROCEDURE IF EXISTS `DeletecaseAnalysisSection`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeletecaseAnalysisSection`(IN _ApplicationNo VARCHAR(50),IN _Title text, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted case analysis section for Application: ', _ApplicationNo); 

  Update caseanalysis set Deleted=1,DeletedBy=_userID,Deleted_At=NOW() where ApplicationNO=_ApplicationNo and Title=_Title;

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteCaseOfficers
DROP PROCEDURE IF EXISTS `DeleteCaseOfficers`;
DELIMITER //
CREATE  PROCEDURE `DeleteCaseOfficers`(IN _Username VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted Case Officer: ',_Username); 
delete from caseofficers WHERE Username=_Username;
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

-- Dumping structure for procedure arcm.Deletedecisiondocuments
DROP PROCEDURE IF EXISTS `Deletedecisiondocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletedecisiondocuments`(IN _Name VARCHAR(150),IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Removed decision document: ', _Name); 
Update decisiondocuments set Deleted=1,Deleted_By=_userID,Deleted_At=now() where Name=_Name;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletedecisionorders
DROP PROCEDURE IF EXISTS `Deletedecisionorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletedecisionorders`(IN _ApplicationNo VARCHAR(50),IN _NO INT(11), IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted  decision order for Application: ', _ApplicationNo); 
Update decisionorders set  Deleted=1,Deleted_At=now() ,Deleted_By=_userID 
 where NO=_NO and ApplicationNo=_ApplicationNo;
 
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );

  
END//
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

-- Dumping structure for procedure arcm.Deletefindingsonissues
DROP PROCEDURE IF EXISTS `Deletefindingsonissues`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletefindingsonissues`(IN _ApplicationNo varchar(50),IN _NO INT(11), IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted findings on issues: ', _NO); 
Update findingsonissues set Deleted=1 where NO=_NO and ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );

  
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

-- Dumping structure for procedure arcm.DeleteInterestedParty
DROP PROCEDURE IF EXISTS `DeleteInterestedParty`;
DELIMITER //
CREATE  PROCEDURE `DeleteInterestedParty`(IN _ID INT, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Removed Interested party with iD:',_ID); 
UPDATE interestedparties set Deleted=1 WHERE ID=_ID;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteIssuesforDetermination
DROP PROCEDURE IF EXISTS `DeleteIssuesforDetermination`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeleteIssuesforDetermination`(IN _ApplicationNo varchar(50),IN _NO INT(11), IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted issue for dertermination: ', _NO); 
Update issuesfordetermination set  Deleted=1 where NO=_NO and ApplicationNo=_ApplicationNo; 
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletejrcontactusers
DROP PROCEDURE IF EXISTS `Deletejrcontactusers`;
DELIMITER //
CREATE  PROCEDURE `Deletejrcontactusers`(IN _UserName varchar(50),_ApplicationNO VARCHAR(50),IN _UserID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted jruser:',_UserName); 
  Update jrcontactusers set Deleted=1 where ApplicationNO=_ApplicationNO and jrcontactusers.UserName=_UserName;
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeletejrInterestedparty
DROP PROCEDURE IF EXISTS `DeletejrInterestedparty`;
DELIMITER //
CREATE  PROCEDURE `DeletejrInterestedparty`(IN _UserName varchar(50),_ApplicationNO VARCHAR(50),IN _UserID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted jrInterested Party:',_UserName); 
  Update jrinterestedparties set Deleted=1 where ApplicationNO=_ApplicationNO and jrinterestedparties.Name=_UserName;
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeleteJudicialDocument
DROP PROCEDURE IF EXISTS `DeleteJudicialDocument`;
DELIMITER //
CREATE  PROCEDURE `DeleteJudicialDocument`(IN _name VARCHAR(150), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Deleted Judicial Document : ',_name); 
update judicialreviewdocuments set Deleted=1 where Name=_name;
  call SaveAuditTrail(_UserID,lSaleDesc,'DELETE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletepartysubmision
DROP PROCEDURE IF EXISTS `Deletepartysubmision`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletepartysubmision`(IN _NO INT(11), IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted party submision : ', _NO); 
Update partysubmision set Deleted=1 where ID=_NO;
call SaveAuditTrail(_userID,lSaleDesc,'Delete','0' );

  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Deletepaymenttypes
DROP PROCEDURE IF EXISTS `Deletepaymenttypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Deletepaymenttypes`( IN _ID INT,  IN _userID VARCHAR(50))
    NO SQL
BEGIN

Update paymenttypes set 
  Deleted=1, Delete_By=_userID ,Deleted_At=now where ID=_ID;
call SaveAuditTrail(_userID,'Deleted Payment type','Add','0' );
END//
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

-- Dumping structure for procedure arcm.DeletePEResponsedetails
DROP PROCEDURE IF EXISTS `DeletePEResponsedetails`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `DeletePEResponsedetails`(IN _ID INT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Deleted PE Response detail: ', _ID); 
 Update peresponsedetails set Deleted=1 where  ID=_ID;
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.DeletePEResponseDocument
DROP PROCEDURE IF EXISTS `DeletePEResponseDocument`;
DELIMITER //
CREATE  PROCEDURE `DeletePEResponseDocument`(IN _name VARCHAR(150), IN _UserID VARCHAR(50))
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
CREATE  PROCEDURE `DeleteRole`(IN `_RoleID` BIGINT, IN `_userID` VARCHAR(50))
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
CREATE  PROCEDURE `Deleteuser`(IN `_UserName` VARCHAR(50), IN `_UserID` VARCHAR(20))
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
CREATE  PROCEDURE `DeleteuserGroup`(IN `_UserGroupID` BIGINT, IN `_userID` VARCHAR(50))
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
CREATE  PROCEDURE `Deletevenues`(IN _ID int,IN _UserID varchar(50))
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

-- Dumping structure for table arcm.feesapprovalworkflow
DROP TABLE IF EXISTS `feesapprovalworkflow`;
CREATE TABLE IF NOT EXISTS `feesapprovalworkflow` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` bigint(20) NOT NULL,
  `Amount` float NOT NULL,
  `RefNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApprovedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DateApproved` datetime NOT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=910;

-- Dumping data for table arcm.feesapprovalworkflow: ~0 rows (approximately)
DELETE FROM `feesapprovalworkflow`;
/*!40000 ALTER TABLE `feesapprovalworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `feesapprovalworkflow` ENABLE KEYS */;

-- Dumping structure for table arcm.feescomputations
DROP TABLE IF EXISTS `feescomputations`;
CREATE TABLE IF NOT EXISTS `feescomputations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(11) DEFAULT NULL,
  `EntryDecsription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AmountComputed` float DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Computed_At` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.feescomputations: ~0 rows (approximately)
DELETE FROM `feescomputations`;
/*!40000 ALTER TABLE `feescomputations` DISABLE KEYS */;
/*!40000 ALTER TABLE `feescomputations` ENABLE KEYS */;

-- Dumping structure for table arcm.feesstructure
DROP TABLE IF EXISTS `feesstructure`;
CREATE TABLE IF NOT EXISTS `feesstructure` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenderType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MinAmount` float NOT NULL DEFAULT '0',
  `MaxAmount` float NOT NULL DEFAULT '0',
  `Rate1` float NOT NULL DEFAULT '1',
  `MinFee` float NOT NULL DEFAULT '0',
  `MaxFee` float NOT NULL DEFAULT '0',
  `Refundable` tinyint(1) DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=5461;

-- Dumping data for table arcm.feesstructure: ~14 rows (approximately)
DELETE FROM `feesstructure`;
/*!40000 ALTER TABLE `feesstructure` DISABLE KEYS */;
INSERT INTO `feesstructure` (`ID`, `TenderType`, `Name`, `Description`, `MinAmount`, `MaxAmount`, `Rate1`, `MinFee`, `MaxFee`, `Refundable`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(1, 'A', 'Does Not Exceed 2M', 'Tender Amount Does Not Exceed 2M\r\n', 0, 2000000, 1, 10000, 0, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(2, 'A', 'Exceeds 2M but not over 50M', 'Exceeds 2M but not over 50M\r\n', 2000000, 50000000, 0.25, 0, 120000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(3, 'A', 'Exceeds 50M', 'Exceeds 50M\r\n', 50000000, 0, 0.025, 0, 60000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(4, 'B', 'Simple', 'Prequalification/EOI - Simple Tender\r\n', 0, 0, 0, 10000, 10000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(5, 'B', 'Medium', 'Prequalification/EOI - Medium Tender\r\n', 0, 0, 0, 20000, 20000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(6, 'B', 'Complex', 'Prequalification/EOI -  Complex Tender\r\n', 0, 0, 0, 40000, 40000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(7, 'C', 'Complex', 'Unquantified Tender-  Complex Tender\r\n', 0, 0, 0, 40000, 40000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(8, 'C', 'Medium', 'Unquantified Tender - Medium Tender\r\n', 0, 0, 0, 20000, 20000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(9, 'C', 'Simple', 'Unquantified Tender - Simple Tender\r\n', 0, 0, 0, 10000, 10000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(10, 'D', 'Others', 'Any Other Tender\r\n', 0, 0, 0, 10000, 20000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(11, '', 'Adjournment Fee', 'Upon Request of an adjournment\r\n', 0, 0, 1, 0, 5000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(12, '', 'Filling Preliminary Objections', 'Filling Preliminary Objections\r\n', 0, 0, 1, 0, 5000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(13, '', 'Fees to Accompany Review of DG Order', 'Fees to Accompany Review of DG Order\r\n', 0, 0, 1, 0, 40000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL),
	(14, '', 'Administrative Fee', 'Administrative Fee\r\n', 0, 0, 1, 0, 5000, 0, '2019-10-23 00:00:00', 'Admin', '2019-10-23 00:00:00', 'Admin', 0, NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.financialyear: ~0 rows (approximately)
DELETE FROM `financialyear`;
/*!40000 ALTER TABLE `financialyear` DISABLE KEYS */;
/*!40000 ALTER TABLE `financialyear` ENABLE KEYS */;

-- Dumping structure for function arcm.FindCaseOfficer
DROP FUNCTION IF EXISTS `FindCaseOfficer`;
DELIMITER //
CREATE  FUNCTION `FindCaseOfficer`(_ApplicationNo Varchar(50)) RETURNS varchar(50) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
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

-- Dumping structure for table arcm.findingsonissues
DROP TABLE IF EXISTS `findingsonissues`;
CREATE TABLE IF NOT EXISTS `findingsonissues` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NO` int(11) DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `Actions` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.findingsonissues: ~0 rows (approximately)
DELETE FROM `findingsonissues`;
/*!40000 ALTER TABLE `findingsonissues` DISABLE KEYS */;
/*!40000 ALTER TABLE `findingsonissues` ENABLE KEYS */;

-- Dumping structure for procedure arcm.GenerateApplicationFeesReport
DROP PROCEDURE IF EXISTS `GenerateApplicationFeesReport`;
DELIMITER //
CREATE  PROCEDURE `GenerateApplicationFeesReport`(IN _FromDate Date,IN _ToDate date,IN _All Boolean)
BEGIN
if(_All=1) THEn
Begin
select SUM(AmountDue)   from applicationfees where FeesStatus='Approved' and applicationfees.Deleted=0 into @Total;
select SUM(AmountDue) as Ampount, @Total as Total,applications.ApplicationNo,applicants.Name as Applicant,
  DATE_FORMAT(applicationfees.BillDate,'%d-%m-%Y') as BillDate,DATE_FORMAT(applicationfees.DateApproved,'%d-%m-%Y')as DateApproved ,
  users.Name as ApprovedBy
  from applicationfees 
  inner join applications on ApplicationID=applications.ID 
  inner join applicants on applicants.ID=applications.ApplicantID
  inner join users on users.Username=applicationfees.ApprovedBy
  where FeesStatus='Approved' and applicationfees.Deleted =0 GROUP BY applications.ApplicationNo;
  ENd;
Else
Begin
select SUM(AmountDue)   from applicationfees where FeesStatus='Approved' and applicationfees.Deleted=0 and
CAST(applicationfees.BillDate AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE) into @Total;
select SUM(AmountDue) as Ampount,@Total as Total,applications.ApplicationNo,applicants.Name as Applicant,
   DATE_FORMAT(applicationfees.BillDate,'%d-%m-%Y') as BillDate,DATE_FORMAT(applicationfees.DateApproved,'%d-%m-%Y')as DateApproved ,
  users.Name as ApprovedBy
  from applicationfees 
  inner join applications on ApplicationID=applications.ID 
  inner join applicants on applicants.ID=applications.ApplicantID
  inner join users on users.Username=applicationfees.ApprovedBy
  where FeesStatus='Approved' and applicationfees.Deleted=0 and
CAST(applicationfees.BillDate AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)  
 GROUP BY applications.ApplicationNo;

   End;
End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GeneratePreliminaryFeesReport
DROP PROCEDURE IF EXISTS `GeneratePreliminaryFeesReport`;
DELIMITER //
CREATE  PROCEDURE `GeneratePreliminaryFeesReport`(IN _FromDate Date,IN _ToDate date,IN _All Boolean)
BEGIN
if(_All=1) THEn
Begin
select sum(AmountPaid) from  paymentdetails where paymentdetails.Category='PreliminaryObjectionsFees' and paymentdetails.ApplicationID in 
  (select ApplicationID from feesapprovalworkflow where Category='PreliminaryObjectionFees' and Status='Approved' ) into @Total;
select SUM(AmountPaid) as Amount,@Total as Total, applications.ApplicationNo,paymentdetails.Paidby,
  DATE_FORMAT(paymentdetails.DateOfpayment,'%d-%m-%Y') as DateOfpayment
  from paymentdetails 
  inner join applications on applications.ID=paymentdetails.ApplicationID
  where paymentdetails.Category='PreliminaryObjectionsFees' and paymentdetails.ApplicationID in 
  (select ApplicationID from feesapprovalworkflow where Category='PreliminaryObjectionFees' and Status='Approved' )
  GROUP BY paymentdetails.ApplicationID;

  ENd;
Else
Begin
select sum(AmountPaid) from  paymentdetails where paymentdetails.Category='PreliminaryObjectionsFees' and paymentdetails.ApplicationID in 
  (select ApplicationID from feesapprovalworkflow where Category='PreliminaryObjectionFees' and Status='Approved' )  
and 
  CAST(paymentdetails.DateOfpayment AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)
    into @Total;

select SUM(AmountPaid) as Amount ,@Total as Total, applications.ApplicationNo,paymentdetails.Paidby,
  DATE_FORMAT(paymentdetails.DateOfpayment,'%d-%m-%Y') as DateOfpayment
  from paymentdetails 
  inner join applications on applications.ID=paymentdetails.ApplicationID
  where paymentdetails.Category='PreliminaryObjectionsFees'and 
  CAST(paymentdetails.DateOfpayment AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)  
  and paymentdetails.ApplicationID in 
  (select ApplicationID from feesapprovalworkflow where Category='PreliminaryObjectionFees' and Status='Approved' )
  GROUP BY paymentdetails.ApplicationID;
   End;
End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Generaterequesthandled
DROP PROCEDURE IF EXISTS `Generaterequesthandled`;
DELIMITER //
CREATE  PROCEDURE `Generaterequesthandled`(IN _FromDate DATE, IN _ToDate DATE, IN _All BOOLEAN)
BEGIN
  if(_All=1) Then
    Begin
DROP TABLE IF EXISTS requesthandledBuffer;
  create table requesthandledBuffer(Applicationno varchar(100),ApplicationDate Date,Status varchar(50));
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Successful' from applications where ApplicationSuccessful=1 ;
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Unsuccessful' from applications where ApplicationSuccessful=0 ;
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Withdrawn' from applications where  Status='WITHDRAWN' ;
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Pending Determination' from applications where  Status <> 'WITHDRAWN' and Status <> 'Closed';
SELECT count(Applicationno) as Count,Status from requesthandledBuffer GROUP BY(Status) ;
    End;
else
      Begin
DROP TABLE IF EXISTS requesthandledBuffer;
  create table requesthandledBuffer(Applicationno varchar(100),ApplicationDate Date,Status varchar(50));
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Successful' from applications where ApplicationSuccessful=1 and FilingDate BETWEEN _FromDate and DATE_ADD(_ToDate, INTERVAL 1 DAY);
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Unsuccessful' from applications where ApplicationSuccessful=0 and FilingDate BETWEEN _FromDate and DATE_ADD(_ToDate, INTERVAL 1 DAY);
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Withdrawn' from applications where  Status='WITHDRAWN' and FilingDate BETWEEN _FromDate and  DATE_ADD(_ToDate, INTERVAL 1 DAY);
  insert into requesthandledBuffer select ApplicationNo,FilingDate,'Pending Determination' from applications where  Status <> 'WITHDRAWN' and Status <> 'Closed' and FilingDate BETWEEN _FromDate and DATE_ADD(_ToDate, INTERVAL 1 DAY);
SELECT count(Applicationno) as Count,Status from requesthandledBuffer GROUP BY(Status) ;
      End ;
      End if;
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Getadditionalsubmissions
DROP PROCEDURE IF EXISTS `Getadditionalsubmissions`;
DELIMITER //
CREATE  PROCEDURE `Getadditionalsubmissions`(IN _ApplicationID INT)
BEGIN

Select ApplicationID,  Description, FileName, FilePath as Path, Create_at, CreatedBy, Deleted,
   Category,
  SubmitedBy 
  from
  additionalsubmissions where Deleted=0 and ApplicationID=_ApplicationID ;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetadditionalsubmissionsDocuments
DROP PROCEDURE IF EXISTS `GetadditionalsubmissionsDocuments`;
DELIMITER //
CREATE  PROCEDURE `GetadditionalsubmissionsDocuments`(IN _ApplicationID INT)
BEGIN

Select ApplicationID,  Description, FileName, FilePath as Path, Create_at, CreatedBy, Deleted,
   Category,
  Confidential ,
  SubmitedBy 
  from
  additionalsubmissionDocuments where Deleted=0 and ApplicationID=_ApplicationID ;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetadditionalsubmissionsPerApplicationNo
DROP PROCEDURE IF EXISTS `GetadditionalsubmissionsPerApplicationNo`;
DELIMITER //
CREATE  PROCEDURE `GetadditionalsubmissionsPerApplicationNo`(IN `_ApplicationID` varchar(50))
BEGIN
select ID from applications where ApplicationNo=_ApplicationID LIMIT 1 into @Application;
Select ApplicationID,  Description, FileName, FilePath as Path, Create_at, CreatedBy, Deleted,  Category,
  SubmitedBy  from
  additionalsubmissions where Deleted=0 and ApplicationID=@Application ;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAdjournmentDocuments
DROP PROCEDURE IF EXISTS `GetAdjournmentDocuments`;
DELIMITER //
CREATE  PROCEDURE `GetAdjournmentDocuments`(IN _ApplicationNo VARCHAR(50))
BEGIN
select  ApplicationNo, Description,Path ,Filename from adjournmentdocuments where Deleted=0 and ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetadjournmentPendingApproval
DROP PROCEDURE IF EXISTS `GetadjournmentPendingApproval`;
DELIMITER //
CREATE  PROCEDURE `GetadjournmentPendingApproval`(IN _UserID VARCHAR(50))
BEGIN
select * from adjournment where _UserID 
  in (Select Username from approvers where ModuleCode='ADJRE' and Active=1 and Deleted=0) and 
  ApplicationNo not in (Select ApplicationNo from adjournmentApprovalWorkFlow where Status='Approved'  and Approver=_UserID)  
  and Status='Pending Approval';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllCaseDetails
DROP PROCEDURE IF EXISTS `GetAllCaseDetails`;
DELIMITER //
CREATE  PROCEDURE `GetAllCaseDetails`()
BEGIN
SELECT DISTINCT casedetails.UserName,users.Name, casedetails.ApplicationNo, casedetails.DateAsigned, casedetails.Status, casedetails.PrimaryOfficer, casedetails.ReassignedTo,
  casedetails.DateReasigned, casedetails.Reason
  FROM casedetails inner join users on users.Username =casedetails.UserName WHERE casedetails.Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllCaseOfficers
DROP PROCEDURE IF EXISTS `GetAllCaseOfficers`;
DELIMITER //
CREATE  PROCEDURE `GetAllCaseOfficers`()
BEGIN
SELECT caseofficers.ID, caseofficers.Username,users.Name, `MinValue`, MaximumValue , caseofficers.Active, `NotAvailableFrom`, `NotAvailableTo`, `OngoingCases`, `CumulativeCases`, caseofficers.Create_at FROM `caseofficers`
  inner join users on users.Username=caseofficers.Username WHERE  caseofficers.Deleted=0 order by caseofficers.OngoingCases ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAllcasesittingsregister
DROP PROCEDURE IF EXISTS `getAllcasesittingsregister`;
DELIMITER //
CREATE  PROCEDURE `getAllcasesittingsregister`()
BEGIN
select * from attendanceregister;
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
CREATE  PROCEDURE `GetAllHearingInProgressApplications`()
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`,  `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
    applications.DecisionDate ,
  applications.Followup ,
  applications.Referral ,
 
  applications.Closed
   ,
  applications.Annulled,
  applications.GiveDirection,
  applications.ISTerminated,
  applications.ReTender,
  applications.CostsPE,
  applications.CostsEachParty,
  applications.CostsApplicant,
  applications.Substitution
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join tendertypes on tendertypes.Code=tenders.TenderType
  WHERE applications.Deleted=0 and applications.Status='HEARING IN PROGRESS' and applications.ApplicationNo not in
  (select ApplicationNo from decisions where Status='Submited') ORDER by applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAllinterestedparties
DROP PROCEDURE IF EXISTS `getAllinterestedparties`;
DELIMITER //
CREATE  PROCEDURE `getAllinterestedparties`()
BEGIN
 Select  ID,Name,ApplicationID,ContactName ,Email,TelePhone,Mobile,PhysicalAddress,PostalCode,Town,POBox,Designation
  from interestedparties where Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAllPEResponse
DROP PROCEDURE IF EXISTS `getAllPEResponse`;
DELIMITER //
CREATE  PROCEDURE `getAllPEResponse`()
BEGIN

select applications.ID, peresponse.ID as ResponseID, peresponse.ApplicationNo,peresponse.ResponseType,peresponse.ResponseDate,tenders.TenderNo,tenders.Name ,tenders.TenderValue as TenderValue
  ,applications.Created_By as Applicantusername from peresponse 
  
  inner join applications on applications.ApplicationNo=peresponse.ApplicationNo 
   inner join tenders on applications.TenderID=tenders.ID where peresponse.Status='Submited'
  order by peresponse.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllSubmitedDecisions
DROP PROCEDURE IF EXISTS `GetAllSubmitedDecisions`;
DELIMITER //
CREATE  PROCEDURE `GetAllSubmitedDecisions`()
BEGIN

  SELECT applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`,  decisions.Status,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
    applications.DecisionDate ,
  applications.Followup ,
  applications.Referral ,
 
  applications.Closed
   ,
  applications.Annulled,
  applications.GiveDirection,
  applications.ISTerminated,
  applications.ReTender,
  applications.CostsPE,
  applications.CostsEachParty,
  applications.CostsApplicant,
  applications.Substitution
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join tendertypes on tendertypes.Code=tenders.TenderType
    inner join decisions on decisions.ApplicationNo=applications.ApplicationNo
  WHERE applications.Deleted=0 and decisions.Status='Pending Approval' ORDER by applications.Created_At DESC;


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

-- Dumping structure for procedure arcm.getAllTowns
DROP PROCEDURE IF EXISTS `getAllTowns`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getAllTowns`()
    NO SQL
BEGIN
Select DISTINCT Town from towns ;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllVenueBookings
DROP PROCEDURE IF EXISTS `GetAllVenueBookings`;
DELIMITER //
CREATE  PROCEDURE `GetAllVenueBookings`()
BEGIN
select ID,VenueID,DATE_FORMAT(Date, "%Y-%m-%d") as Date ,Slot,Booked_By,Content,Booked_On from venuebookings where Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAllvenues
DROP PROCEDURE IF EXISTS `GetAllvenues`;
DELIMITER //
CREATE  PROCEDURE `GetAllvenues`()
BEGIN
 
  Select venues.ID,branches.Description as Branch,  venues.Name,venues.Description from venues  inner join branches on branches.ID=venues.Branch where venues.deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicantPerApplicationno
DROP PROCEDURE IF EXISTS `GetApplicantPerApplicationno`;
DELIMITER //
CREATE  PROCEDURE `GetApplicantPerApplicationno`(IN _ApplicationNo VARCHAR(50))
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

-- Dumping structure for procedure arcm.GetApplicationDecisionsBackgroundinformation
DROP PROCEDURE IF EXISTS `GetApplicationDecisionsBackgroundinformation`;
DELIMITER //
CREATE  PROCEDURE `GetApplicationDecisionsBackgroundinformation`(IN _ApplicationNo VARCHAR(50))
BEGIN
select * from decisions where ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getapplicationdocuments
DROP PROCEDURE IF EXISTS `getapplicationdocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getapplicationdocuments`()
    NO SQL
BEGIN
SELECT `ID`, `ApplicationID`, `Description`, `FileName`, `DateUploaded`, `Path`,Confidential,Created_By FROM `applicationdocuments`  WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationFees
DROP PROCEDURE IF EXISTS `GetApplicationFees`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetApplicationFees`(IN _ApplicationID int)
    NO SQL
BEGIN
select sum(AmountDue)  from applicationfees where ApplicationID=_ApplicationID and applicationfees.Deleted=0 INTO @Totall;
select  applicationfees.ID, applicationfees.ApplicationID,feesstructure.Description as EntryType, applicationfees.AmountDue, applicationfees.RefNo, applicationfees.BillDate, applicationfees.AmountPaid
  ,@Totall as total, applicationfees.PaidDate, applicationfees.PaymentRef, applicationfees.PaymentMode
  from applicationfees inner join feesstructure  on feesstructure.ID=applicationfees.EntryType 
  where applicationfees.ApplicationID=_ApplicationID and applicationfees.Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationForHearing
DROP PROCEDURE IF EXISTS `GetApplicationForHearing`;
DELIMITER //
CREATE  PROCEDURE `GetApplicationForHearing`()
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
CREATE  PROCEDURE `GetApplicationGroundsOnly`(IN _ApplicationNo VARCHAR(50))
BEGIN
Select * FROM groundsandrequestedorders
WHERE Deleted=0 and ApplicationID in (select ID from applications where ApplicationNo=_ApplicationNo) and EntryType='Grounds for Appeal';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationPaymentDetails
DROP PROCEDURE IF EXISTS `GetApplicationPaymentDetails`;
DELIMITER //
CREATE  PROCEDURE `GetApplicationPaymentDetails`(IN _ApplicationID INT)
BEGIN
select sum(AmountPaid) from paymentdetails WHERE ApplicationID=_ApplicationID and Category='Applicationfees' into @Total;
  select  @Total  as TotalPaid,paymentdetails.ApplicationID,paymentdetails.Paidby,paymentdetails.Refference,paymentdetails.DateOfpayment,paymentdetails.AmountPaid,
  paymenttypes.Description as PaymentType ,
  paymentdetails.ChequeDate ,
  paymentdetails.CHQNO 
  from paymentdetails inner JOIN paymenttypes on paymenttypes.ID=paymentdetails.PaymentType WHERE ApplicationID=_ApplicationID and Category='Applicationfees';
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationRequestsOnly
DROP PROCEDURE IF EXISTS `GetApplicationRequestsOnly`;
DELIMITER //
CREATE  PROCEDURE `GetApplicationRequestsOnly`(IN _ApplicationNo VARCHAR(50))
BEGIN
Select * FROM groundsandrequestedorders
WHERE Deleted=0 and ApplicationID in (select ID from applications where ApplicationNo=_ApplicationNo) and EntryType='Requested Orders';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getapplications
DROP PROCEDURE IF EXISTS `getapplications`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getapplications`()
    NO SQL
BEGIN
SELECT users.Name as caseOfficer, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
  tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, "%d-%m-%Y") as AwardDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
  procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
  
  `FilingDate`, `ApplicationREf`,  applications.Status,AwardDate,applications.ClosingDate
  FROM `applications`
  inner join procuremententity on applications.PEID=procuremententity.PEID
  inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
  inner join tenders on applications.TenderID=tenders.ID
  inner join tendertypes on tenders.TenderType=tendertypes.Code
  inner join users on users.Username=casedetails.UserName
  WHERE applications.Deleted=0 and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationsforDecision
DROP PROCEDURE IF EXISTS `GetApplicationsforDecision`;
DELIMITER //
CREATE  PROCEDURE `GetApplicationsforDecision`(IN _userName varchar(50))
BEGIN

  
select Category from users where Username=_userName Limit 1 INTO @Category;
select Email from users where Username=_userName Limit 1 INTO @Email;
if(@Category='Applicant') Then
Begin
    SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
    `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
    procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
    
    `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
    applications.DecisionDate ,
    applications.Followup ,
    applications.Referral ,
    applications.ApplicationSuccessful,
    applications.Closed ,
    applications.Annulled,
    applications.GiveDirection,
    applications.ISTerminated,
    applications.ReTender,
    applications.CostsPE,
    applications.CostsEachParty,
    applications.CostsApplicant,
    applications.Substitution
    FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
    inner join tendertypes on tendertypes.Code=tenders.TenderType
    WHERE  applications.ApplicationNo  in
    (select ApplicationNo from decisions where Status='Approved')
      and (applications.Created_By=_userName 
  or applications.ID in (select  ApplicationID from interestedparties where Email=@Email))     
    ORDER by applications.Created_At DESC;
  End;
  End if;
  if(@Category='PE') Then
  Begin
    select PEID from peusers where UserName=_userName Limit 1 INTO @PEID;
      SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
      `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
      procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
      
      `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
      applications.DecisionDate ,
      applications.Followup ,
      applications.Referral ,
      applications.ApplicationSuccessful,
      applications.Closed ,
      applications.Annulled,
      applications.GiveDirection,
      applications.ISTerminated,
      applications.ReTender,
      applications.CostsPE,
      applications.CostsEachParty,
      applications.CostsApplicant,
      applications.Substitution
      FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
      inner join tendertypes on tendertypes.Code=tenders.TenderType
      WHERE  applications.ApplicationNo  in
      (select ApplicationNo from decisions where Status='Approved') and applications.PEID=@PEID ORDER by applications.Created_At DESC;
  End;
  End if;

  if(@Category='System_User') Then
Begin
    SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
    `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
    procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
    
    `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
    applications.DecisionDate ,
    applications.Followup ,
    applications.Referral ,
    applications.ApplicationSuccessful,
    applications.Closed ,
    applications.Annulled,
    applications.GiveDirection,
    applications.ISTerminated,
    applications.ReTender,
    applications.CostsPE,
    applications.CostsEachParty,
    applications.CostsApplicant,
    applications.Substitution
    FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
    inner join tendertypes on tendertypes.Code=tenders.TenderType
    WHERE  applications.ApplicationNo  in
    (select ApplicationNo from decisions where Status='Approved') ORDER by applications.Created_At DESC;
  End;
  End if;



END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationsForEachPE
DROP PROCEDURE IF EXISTS `GetApplicationsForEachPE`;
DELIMITER //
CREATE  PROCEDURE `GetApplicationsForEachPE`(IN _LoggedInuser VARCHAR(50))
BEGIN
Select PEID from peusers where UserName=_LoggedInuser LIMIT 1 into @PEID;
SELECT applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,
  procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,peresponsetimer.DueOn,applications.ClosingDate as ApplicationClosingDate,
  
  FilingDate, `ApplicationREf`, applications.ApplicationNo, applications.Status ,peresponsetimer.Status as TimerStatus,
  applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,TenderType,TenderSubCategory,TenderCategory,Timer,AwardDate
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join peresponsetimer on peresponsetimer.ApplicationNo=applications.ApplicationNo
   inner join tendertypes on tendertypes.Code=tenders.TenderType
  WHERE applications.Deleted=0 and applications.PEID=@PEID ORDER by applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getapplicationsforFollowup
DROP PROCEDURE IF EXISTS `getapplicationsforFollowup`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getapplicationsforFollowup`()
    NO SQL
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
   applications.DecisionDate ,
  applications.Followup ,
  applications.Referral ,
 
  applications.Closed 
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join tendertypes on tendertypes.Code=tenders.TenderType
  WHERE  applications.Deleted=0 and applications.Followup=1;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getapplicationsforReferalls
DROP PROCEDURE IF EXISTS `getapplicationsforReferalls`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getapplicationsforReferalls`()
    NO SQL
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
   applications.DecisionDate ,
  applications.Followup ,
  applications.Referral ,
 
  applications.Closed 
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join tendertypes on tendertypes.Code=tenders.TenderType
  WHERE  applications.Deleted=0 and applications.Referral=1;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApplicationsHeard
DROP PROCEDURE IF EXISTS `GetApplicationsHeard`;
DELIMITER //
CREATE  PROCEDURE `GetApplicationsHeard`()
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
SELECT applications.ID,applications.ApplicationNo ,TenderNo,applications.TenderID,tenders.Name as TenderName,TenderValue,
  tenders.StartDate,tenders.AwardDate,
  tenders.ClosingDate, applications.ApplicantID, applications.PEID,procuremententity.Name as PEName,
  applications.FilingDate, applications.Created_By as Applicantusername,
  applications.ApplicationREf,applications.Status
  ,procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,
  procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail
  ,TenderType,TenderSubCategory,TenderCategory,Timer,tendertypes.Description as TenderTypeDesc,PaymentStatus
  FROM applications
  inner join procuremententity on procuremententity.PEID=applications.PEID 
  inner join tenders on tenders.ID=applications.TenderID 
    inner join tendertypes on tendertypes.Code=tenders.TenderType
  WHERE applications.Status='Pending Approval'
  and applications.ApplicationNo 
  not in (SELECT ApplicationNo from `applications_approval_workflow` where Approver=_Approver )
  and _Approver in( select Username from approvers where ModuleCode ='APFRE' and Active=1 and Deleted=0);
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApprovalModules
DROP PROCEDURE IF EXISTS `GetApprovalModules`;
DELIMITER //
CREATE  PROCEDURE `GetApprovalModules`()
    NO SQL
BEGIN
SELECT * from approvalmodules;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetApproverDetails
DROP PROCEDURE IF EXISTS `GetApproverDetails`;
DELIMITER //
CREATE  PROCEDURE `GetApproverDetails`(IN _ApplicationNo VARCHAR(50))
BEGIN
 -- SELECT Username from approvers where ModuleCode='PAYMT' and Deleted=0 and Active=1 and level=1 LIMIT 1 into @Approver;
  select Phone as ApproversPhone,Email as ApproversMail from users where Username in 
  ( SELECT Username from approvers where ModuleCode='PAYMT' and Deleted=0 and Active=1  );
-- select Phone as ApproversPhone,Email as ApproversMail from users 
-- where Username IN(Select Approver from applications_approval_workflow where ApplicationNo=_ApplicationNo and Status='Pending Approval');
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getApprovers
DROP PROCEDURE IF EXISTS `getApprovers`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getApprovers`()
    NO SQL
BEGIN
SELECT approvers.ID, approvers.Username,users.Name, approvers.ModuleCode,approvalmodules.Name as ModuleName, approvers.Mandatory,Active FROM `approvers`
inner join users on users.Username=approvers.Username inner join approvalmodules on approvalmodules.ModuleCode=approvers.ModuleCode
WHERE approvers.Deleted=0 and approvers.Active=1;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetAttendanceRegister
DROP PROCEDURE IF EXISTS `GetAttendanceRegister`;
DELIMITER //
CREATE  PROCEDURE `GetAttendanceRegister`(IN _RegisterID int)
BEGIN
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID,RegisterID,IDNO,MobileNo,Name,Email,Category,FirmFrom,Designation from attendanceregister where RegisterID=_RegisterID order BY ID ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAuditrails
DROP PROCEDURE IF EXISTS `getAuditrails`;
DELIMITER //
CREATE  PROCEDURE `getAuditrails`()
    NO SQL
SELECT `AuditID`, `Date`, `Username`, `Description`, `Category`, `IpAddress` FROM `audittrails`//
DELIMITER ;

-- Dumping structure for procedure arcm.Getbanks
DROP PROCEDURE IF EXISTS `Getbanks`;
DELIMITER //
CREATE  PROCEDURE `Getbanks`()
BEGIN
Select  
  ID,
  Name ,
  Branch ,
  AcountNo ,
  PayBill ,
  Created_By ,
  Created_At ,
  Update_By,
  Updated_At ,
  Deleted ,
  Delete_By ,
  Deleted_At 
From banks where Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetBankSlips
DROP PROCEDURE IF EXISTS `GetBankSlips`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetBankSlips`(IN _ApplicationID BIGINT(20))
    NO SQL
BEGIN
Select *
 from bankslips where ApplicationID=_ApplicationID and Deleted=0;
END//
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

-- Dumping structure for procedure arcm.GetcaseAnalysis
DROP PROCEDURE IF EXISTS `GetcaseAnalysis`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetcaseAnalysis`(IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN

Select ApplicationNO,Description,Title,Create_at ,Deleted,CreatedBy from caseanalysis where ApplicationNO=_ApplicationNo and Deleted=0;
 

  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getcaseanalysisdocuments
DROP PROCEDURE IF EXISTS `getcaseanalysisdocuments`;
DELIMITER //
CREATE  PROCEDURE `getcaseanalysisdocuments`(IN _ApplicationNo varchar(50))
BEGIN


  Select  ApplicationNo,  Description, FileName, FilePath as Path, Create_at, CreatedBy, Deleted,Category,Confidential,SubmitedBy 
  from caseanalysisdocuments where ApplicationNo= _ApplicationNo and Deleted=0;



END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetCaseProceedings
DROP PROCEDURE IF EXISTS `GetCaseProceedings`;
DELIMITER //
CREATE  PROCEDURE `GetCaseProceedings`()
BEGIN
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown
  ,procuremententity.PostalCode as PEPostalCode ,
  procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
 
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  WHERE applications.Deleted=0 and applications.ApplicationNo in (select ApplicationNo from hearingattachments) ORDER by applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getCaseWithdrawalPendingApproval
DROP PROCEDURE IF EXISTS `getCaseWithdrawalPendingApproval`;
DELIMITER //
CREATE  PROCEDURE `getCaseWithdrawalPendingApproval`(IN _UserID VARCHAR(50))
BEGIN
select * from caseWithdrawal where _UserID in (select Username from approvers WHERE ModuleCode='WIOAP' and Deleted=0 and Active=1)
  and caseWithdrawal.ApplicationNo not in (select ApplicationNo from casewithdrawalapprovalworkflow where Approver=_UserID )
  and status='Pending Approval';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetClosedApplicationsForDecisionUploads
DROP PROCEDURE IF EXISTS `GetClosedApplicationsForDecisionUploads`;
DELIMITER //
CREATE  PROCEDURE `GetClosedApplicationsForDecisionUploads`()
BEGIN
select * from applications where Closed=1 and applications.ApplicationNo Not in (select DISTINCT ApplicationNo from decisiondocuments where Status='Approved' and Deleted=0 );
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
SELECT `ID`, `Code`, `Name` FROM `counties` WHERE Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getCustomReport
DROP PROCEDURE IF EXISTS `getCustomReport`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getCustomReport`(IN _Status VARCHAR(50), IN _FromDate DATE, IN _ToDate DATE, IN _AllDates BOOLEAN)
    NO SQL
BEGIN

  if(_AllDates=1) THEN
  Begin
      if(_Status='Closed') THEN
      Begin
          SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(FilingDate, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate, `ApplicationREf`,  applications.Status,DATE_FORMAT(AwardDate, '%d-%m-%Y') as AwardDate ,DATE_FORMAT(applications.ClosingDate, '%d-%m-%Y') as ClosingDate 
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE applications.Deleted=0 and applications.Status='Closed' and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
      ENd;   
      End if;
      if(_Status='Withdrawn') THEN
      Begin
        SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(FilingDate, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate , `ApplicationREf`,  applications.Status,DATE_FORMAT(AwardDate, '%d-%m-%Y') as AwardDate,DATE_FORMAT(applications.ClosingDate, '%d-%m-%Y') as ClosingDate 
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE applications.Deleted=0 and applications.Status='WITHDRAWN' and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
     
      ENd  ;   
      End if;
       if(_Status='Pending Determination') THEN
      Begin
         SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(FilingDate, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate, `ApplicationREf`,  applications.Status,DATE_FORMAT(AwardDate, '%d-%m-%Y') as AwardDate,DATE_FORMAT(applications.ClosingDate, '%d-%m-%Y') as ClosingDate 
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE applications.Deleted=0  and applications.Status<>'WITHDRAWN' and applications.Status<>'Closed' and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
     
      
      ENd;      
      End if;
      
       if(_Status='All') THEN
      Begin
         SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(FilingDate, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate, `ApplicationREf`,  applications.Status,DATE_FORMAT(AwardDate, '%d-%m-%Y') as AwardDate,DATE_FORMAT(applications.ClosingDate, '%d-%m-%Y') as ClosingDate 
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE applications.Deleted=0 and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
     
      
      ENd;      
      End if;
  ENd;
  Else
  Begin
   if(_Status='Closed') THEN
      Begin
          SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(tenders.Created_At, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate, `ApplicationREf`,  applications.Status,DATE_FORMAT(AwardDate, '%d-%m-%Y') as AwardDate,DATE_FORMAT(applications.ClosingDate, '%d-%m-%Y') as ClosingDate 
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE CAST(applications.Created_At AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)  and applications.Deleted=0 and applications.Status='Closed' and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
      ENd;   
      End if;
      if(_Status='Withdrawn') THEN
      Begin
        SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(tenders.Created_At, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate, `ApplicationREf`,  applications.Status,DATE_FORMAT(AwardDate, '%d-%m-%Y') as AwardDate,DATE_FORMAT(applications.ClosingDate, '%d-%m-%Y') as ClosingDate 
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE CAST(applications.Created_At AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)  and applications.Deleted=0 and applications.Status='WITHDRAWN' and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
     
      ENd  ;   
      End if;
       if(_Status='Pending Determination') THEN
      Begin
         SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(tenders.Created_At, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate, `ApplicationREf`,  applications.Status,DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate, DATE_FORMAT(applications.ClosingDate, '%d-%m-%Y') as ClosingDate 
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE CAST(applications.Created_At AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)  and  applications.Deleted=0  and applications.Status<>'WITHDRAWN' and applications.Status<>'Closed' and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
     
      
      ENd;      
      End if;
      
       if(_Status='All') THEN
      Begin
         SELECT users.Name as Applicant, applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,
          tenders.ClosingDate, DATE_FORMAT(tenders.AwardDate, '%d-%m-%Y') as AwardDate,
          `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
          procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,
          procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
          TenderType,TenderSubCategory,TenderCategory,Timer,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,
          
          DATE_FORMAT(tenders.Created_At, '%d-%m-%Y') as FilingDate , DATE_FORMAT(applications.DecisionDate, '%d-%m-%Y') as DecisionDate, `ApplicationREf`,  applications.Status,AwardDate,applications.ClosingDate
          FROM `applications`
          inner join procuremententity on applications.PEID=procuremententity.PEID
          inner join casedetails on applications.ApplicationNo=casedetails.ApplicationNo
          inner join tenders on applications.TenderID=tenders.ID
          inner join tendertypes on tenders.TenderType=tendertypes.Code
          inner join users on users.Username=applications.Created_By
          WHERE CAST(applications.Created_At AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)  and  applications.Deleted=0 and casedetails.PrimaryOfficer=1 and casedetails.Deleted=0  ORDER by applications.Created_At DESC;
     
      
      ENd;      
      End if;

  End;
  End if;


End//
DELIMITER ;

-- Dumping structure for procedure arcm.getdeadLineRequestApprovals
DROP PROCEDURE IF EXISTS `getdeadLineRequestApprovals`;
DELIMITER //
CREATE  PROCEDURE `getdeadLineRequestApprovals`(IN _Approver VARCHAR(50))
BEGIN
select deadlineapprovalworkflow.PEID,deadlineapprovalworkflow.ApplicationNo,deadlineapprovalworkflow.Reason,deadlineapprovalworkflow.RequestedDate,
  procuremententity.Name,Status,deadlineapprovalworkflow.Created_At as FilingDate,procuremententity.Mobile,
  procuremententity.Location,procuremententity.POBox,procuremententity.Email,procuremententity.Website,procuremententity.PostalCode,procuremententity.Town
 
  from deadlineapprovalworkflow 
  inner join procuremententity on procuremententity.PEID=deadlineapprovalworkflow.PEID 
 
  where Approver=_Approver and Status='Pending Approval';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Getdecisiondocuments
DROP PROCEDURE IF EXISTS `Getdecisiondocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Getdecisiondocuments`(IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN

Select ApplicationNo,Name,Description,Path,Created_At,Confidential,Created_By,Status from decisiondocuments where ApplicationNo=_ApplicationNo and Deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Getdecisionorders
DROP PROCEDURE IF EXISTS `Getdecisionorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Getdecisionorders`(IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN
SELECT  
  NO,
  ApplicationNo ,
  Description 
 

From decisionorders where Deleted=0 and  ApplicationNo=_ApplicationNo;
  
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

-- Dumping structure for procedure arcm.Getfindingsonissues
DROP PROCEDURE IF EXISTS `Getfindingsonissues`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Getfindingsonissues`(IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN

Select NO, ApplicationNo ,Description,Created_At,Deleted,Created_By,Actions from findingsonissues WHERE Deleted=0 and ApplicationNo=_ApplicationNo;


  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetGenereatedPanels
DROP PROCEDURE IF EXISTS `GetGenereatedPanels`;
DELIMITER //
CREATE  PROCEDURE `GetGenereatedPanels`()
BEGIN
select DISTINCT panels.ApplicationNo,applicants.Name as ApplicantName,procuremententity.Name as PEName from panels inner join applications on applications.ApplicationNo=panels.ApplicationNo
  inner join procuremententity on applications.PEID=procuremententity.PEID inner join applicants on applicants.ID=applications.ApplicantID;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetGenereatedRB1Forms
DROP PROCEDURE IF EXISTS `GetGenereatedRB1Forms`;
DELIMITER //
CREATE  PROCEDURE `GetGenereatedRB1Forms`()
BEGIN
select   ApplicationNo,Path , FileName, GeneratedOn,GeneratedBy from rb1forms order by ApplicationNo DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetGroupRoles
DROP PROCEDURE IF EXISTS `GetGroupRoles`;
DELIMITER //
CREATE  PROCEDURE `GetGroupRoles`(IN `_UserGroupID` BIGINT)
    NO SQL
SELECT roles.RoleID, RoleName,`Edit`, `Remove`, `AddNew`, `View`, `Export`,Category FROM roles LEFT JOIN groupaccess 
    ON groupaccess.RoleID = roles.RoleID AND groupaccess.UserGroupID=_UserGroupID//
DELIMITER ;

-- Dumping structure for procedure arcm.GetHearingAttachments
DROP PROCEDURE IF EXISTS `GetHearingAttachments`;
DELIMITER //
CREATE  PROCEDURE `GetHearingAttachments`(IN _ApplicationNo VARCHAR(50))
BEGIN
 
Select  ApplicationNo,Name ,Description ,Path ,Category from hearingattachments
 Where ApplicationNo=_ApplicationNo and Deleted=0;
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetHearingNotices
DROP PROCEDURE IF EXISTS `GetHearingNotices`;
DELIMITER //
CREATE  PROCEDURE `GetHearingNotices`()
BEGIN
select DISTINCT ApplicationNo,Path,Filename  from hearingnotices order by DateGenerated desc;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetHearingNotificationContacts
DROP PROCEDURE IF EXISTS `GetHearingNotificationContacts`;
DELIMITER //
CREATE  PROCEDURE `GetHearingNotificationContacts`(IN _ApplicationNo VARCHAR(50))
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

-- Dumping structure for procedure arcm.getinterestedpartiesPerApplication
DROP PROCEDURE IF EXISTS `getinterestedpartiesPerApplication`;
DELIMITER //
CREATE  PROCEDURE `getinterestedpartiesPerApplication`(IN _ApplicationID VARCHAR(50))
BEGIN
  select ID from applications where ApplicationNo=_ApplicationID limit 1 into @Application;
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID,Name,ApplicationID,ContactName ,Email,TelePhone,Mobile,PhysicalAddress,PostalCode,Town,POBox,Designation
  from interestedparties where Deleted=0 and (ApplicationID=_ApplicationID or ApplicationID=@Application);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetIssuesforDetermination
DROP PROCEDURE IF EXISTS `GetIssuesforDetermination`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `GetIssuesforDetermination`(IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN

 Select NO, ApplicationNo ,Description,Created_At,Deleted,Created_By from issuesfordetermination where ApplicationNo=_ApplicationNo and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Getjrcontactusers
DROP PROCEDURE IF EXISTS `Getjrcontactusers`;
DELIMITER //
CREATE  PROCEDURE `Getjrcontactusers`(_ApplicationNO VARCHAR(50))
BEGIN
Select 
  
  jrcontactusers.UserName ,
  jrcontactusers.ApplicationNO ,
  jrcontactusers.Role ,
  users.Name,
users.Email,users.Phone
  from jrcontactusers
 inner join users on jrcontactusers.Username=users.Username where ApplicationNO=_ApplicationNO and jrcontactusers.Deleted=0;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.getJRinterestedpartiesPerApplication
DROP PROCEDURE IF EXISTS `getJRinterestedpartiesPerApplication`;
DELIMITER //
CREATE  PROCEDURE `getJRinterestedpartiesPerApplication`(IN _ApplicationNO VARCHAR(50))
BEGIN
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID,Name,ApplicationNO,ContactName ,Email,TelePhone,Mobile,PhysicalAddress,PostalCode,Town,POBox,Designation
  from jrinterestedparties where Deleted=0 and ApplicationNO=_ApplicationNO ;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetJudicialreviewApplications
DROP PROCEDURE IF EXISTS `GetJudicialreviewApplications`;
DELIMITER //
CREATE  PROCEDURE `GetJudicialreviewApplications`()
BEGIN
select DISTINCT applications.FilingDate, applications.ApplicationNo,applications.PEID,
procuremententity.Name as PEName,procuremententity.POBox as PEPOBOX,procuremententity.PostalCode as PEPostalCode,
  procuremententity.Town as PETown,procuremententity.Email as PEEmail,procuremententity.Telephone as PETeleponde,
  '' as PanelStatus 
  from judicialreview
  inner join applications on applications.ApplicationNo=judicialreview.ApplicationNo
  inner join procuremententity on applications.PEID=procuremententity.PEID  
  where judicialreview.Deleted=0 order by applications.Created_At DESC ;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getJudicialReviewDetails
DROP PROCEDURE IF EXISTS `getJudicialReviewDetails`;
DELIMITER //
CREATE  PROCEDURE `getJudicialReviewDetails`(IN _ApplicationNo VARCHAR(50))
BEGIN
Select  
  ApplicationNo ,
  DateFilled ,
  CaseNO ,
  Description ,
  Applicant ,
  Court,
  Town ,
  DateRecieved,
  DateofReplyingAffidavit ,
  DateofCourtRulling,
  Ruling ,
  Created_At ,
  Created_By ,
  Status,
  Deleted from judicialreview where Deleted=0 and ApplicationNo=_ApplicationNo;
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Getjudicialreviewdocuments
DROP PROCEDURE IF EXISTS `Getjudicialreviewdocuments`;
DELIMITER //
CREATE  PROCEDURE `Getjudicialreviewdocuments`(IN _ApplicationNo VARCHAR(50))
BEGIN

Select  ApplicationNo ,Name as FileName,Description ,Path , Created_At,Deleted ,DocumentDate ,ActionDate,ActionDescription,ActionSent
 From judicialreviewdocuments where ApplicationNo=_ApplicationNo and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetLoogedinCompany
DROP PROCEDURE IF EXISTS `GetLoogedinCompany`;
DELIMITER //
CREATE  PROCEDURE `GetLoogedinCompany`(IN _Username VARCHAR(50), IN _Category VARCHAR(50))
BEGIN
  if(_Category='Applicant') THEn
    Begin
    select Name from applicants  where PIN=_Username or Created_By=_Username  limit 1;
      End;
      End if;
   if(_Category='PE') THEn
    Begin
      select PEID from peusers  where UserName=_Username into @PEID;
    select Name from procuremententity where PEID =@PEID  limit 1; -- or Created_By=_Username;
      End;
      End if;

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

-- Dumping structure for procedure arcm.GetMonthlyCasesDistributions
DROP PROCEDURE IF EXISTS `GetMonthlyCasesDistributions`;
DELIMITER //
CREATE  PROCEDURE `GetMonthlyCasesDistributions`(IN _Year Date)
BEGIN
select count(*) as Count,FilingDate,ApplicationREf,Status,MONTHNAME(FilingDate) as Month from applications where YEAR(FilingDate)=YEAR(_Year)  GROUP by MONTH(FilingDate);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getmyapplications
DROP PROCEDURE IF EXISTS `getmyapplications`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getmyapplications`(IN _ApplicantID BIGINT)
    NO SQL
BEGIN

select Email from applicants where ID=_ApplicantID LIMIT 1 into @interestedpartyEmail;
SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,TenderType,TenderSubCategory,TenderCategory,Timer,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,
  procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,  
  `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,AwardDate,applications.Created_By
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID 
  inner join tenders on tenders.ID=applications.TenderID
  inner join tendertypes on tendertypes.Code=tenders.TenderType
  WHERE applications.Deleted=0 and (applications.ApplicantID=_ApplicantID 
  or applications.ID in (select  ApplicationID from interestedparties where Email=@interestedpartyEmail))
  ORDER by applications.Created_At DESC;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.getMycases
DROP PROCEDURE IF EXISTS `getMycases`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getMycases`(IN _UserName VARCHAR(50))
    NO SQL
BEGIN
SELECT DISTINCT users.Name as caseOfficer,applications.ID,applications.ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
  `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
  procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
  
  `FilingDate`, `ApplicationREf`, applications.Status,applications.PaymentStatus,tendertypes.Description as TenderTypeDesc,TenderType,TenderSubCategory,TenderCategory,Timer,AwardDate
  FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
  inner join casedetails on casedetails.ApplicationNo=applications.ApplicationNo
  inner join tendertypes on tendertypes.Code=tenders.TenderType
  inner join users on users.Username=casedetails.UserName
  WHERE applications.ApplicationNo in (select ApplicationNo from panels where UserName=_UserName and Status='Approved') or applications.Deleted=0 and casedetails.UserName=_UserName and casedetails.PrimaryOfficer=1 and casedetails.Status='Open' 
  
  ORDER by applications.Created_At DESC;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetMyDecision
DROP PROCEDURE IF EXISTS `GetMyDecision`;
DELIMITER //
CREATE  PROCEDURE `GetMyDecision`(IN _userName varchar(50))
BEGIN

  select Category from users where Username=_userName Limit 1 INTO @Category;
select Email from users where Username=_userName Limit 1 INTO @Email;
if(@Category='Applicant') Then
Begin
    SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
    `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
    procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
    
    `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
    applications.DecisionDate ,
    applications.Followup ,
    applications.Referral ,
    applications.ApplicationSuccessful,
    applications.Closed ,
    applications.Annulled,
    applications.GiveDirection,
    applications.ISTerminated,
    applications.ReTender,
    applications.CostsPE,
    applications.CostsEachParty,
    applications.CostsApplicant,
    applications.Substitution
    FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
    inner join tendertypes on tendertypes.Code=tenders.TenderType
    WHERE  applications.ApplicationNo  in
    (select ApplicationNo from decisions where Status='Submited')
      and (applications.Created_By=_userName 
  or applications.ID in (select  ApplicationID from interestedparties where Email=@Email))     
    ORDER by applications.Created_At DESC;
  End;
  End if;
  if(@Category='PE') Then
  Begin
    select PEID from peusers where UserName=_userName Limit 1 INTO @PEID;
      SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
      `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
      procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
      
      `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
      applications.DecisionDate ,
      applications.Followup ,
      applications.Referral ,
      applications.ApplicationSuccessful,
      applications.Closed ,
      applications.Annulled,
      applications.GiveDirection,
      applications.ISTerminated,
      applications.ReTender,
      applications.CostsPE,
      applications.CostsEachParty,
      applications.CostsApplicant,
      applications.Substitution
      FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
      inner join tendertypes on tendertypes.Code=tenders.TenderType
      WHERE  applications.ApplicationNo  in
      (select ApplicationNo from decisions where Status='Submited') and applications.PEID=@PEID ORDER by applications.Created_At DESC;
  End;
  End if;

  if(@Category='System_User') Then
Begin
    SELECT applications.ID,ApplicationNo ,TenderNo,`TenderID`,tenders.Name as TenderName,TenderValue,tenders.StartDate,tenders.ClosingDate,
    `ApplicantID`, applications.PEID,procuremententity.Name as PEName,applications.Created_By as Applicantusername,
    procuremententity.POBox as PEPOBox,procuremententity.Website as PEWebsite ,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,procuremententity.PostalCode as PEPostalCode ,procuremententity.Mobile as PEMobile,procuremententity.Email as PEEmail,
    
    `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`,AwardDate,TenderCategory,TenderSubCategory,tendertypes.Description as TenderType,
    applications.DecisionDate ,
    applications.Followup ,
    applications.Referral ,
    applications.ApplicationSuccessful,
    applications.Closed ,
    applications.Annulled,
    applications.GiveDirection,
    applications.ISTerminated,
    applications.ReTender,
    applications.CostsPE,
    applications.CostsEachParty,
    applications.CostsApplicant,
    applications.Substitution
    FROM `applications` inner join procuremententity on procuremententity.PEID=applications.PEID inner join tenders on tenders.ID=applications.TenderID
    inner join tendertypes on tendertypes.Code=tenders.TenderType
    WHERE  applications.ApplicationNo  in
    (select ApplicationNo from decisions where Status='Submited') ORDER by applications.Created_At DESC;
  End;
  End if;



END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetMyPendingNotification
DROP PROCEDURE IF EXISTS `GetMyPendingNotification`;
DELIMITER //
CREATE  PROCEDURE `GetMyPendingNotification`(IN `_UserName` VARCHAR(50))
    NO SQL
BEGIN
SELECT  Username,COUNT(*) As Total, Category, Description, Created_At, DueDate, Status  from  notifications where Username=_Username
and status='Not Resolved' group by Category;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetMyresolveedNotifications
DROP PROCEDURE IF EXISTS `GetMyresolveedNotifications`;
DELIMITER //
CREATE  PROCEDURE `GetMyresolveedNotifications`(IN `_Username` VARCHAR(50))
    NO SQL
BEGIN
Select * from  notifications where Username=_Username and status='Resolved';

END//
DELIMITER ;

-- Dumping structure for procedure arcm.getMyResponse
DROP PROCEDURE IF EXISTS `getMyResponse`;
DELIMITER //
CREATE  PROCEDURE `getMyResponse`(IN _PEID VARCHAR(50))
BEGIN
select PEID from peusers where UserName=_PEID limit 1 into @PEID;
select applications.ID as ApplicationID, peresponse.ID as ResponseID,peresponse.Status, peresponse.ApplicationNo,peresponse.ResponseType,peresponse.ResponseDate,tenders.TenderNo,tenders.Name ,
  tenders.TenderValue as TenderValue
  , applications.Created_By as Applicantusername from peresponse 
 
  inner join applications on applications.ApplicationNo=peresponse.ApplicationNo 
   inner join tenders on applications.TenderID=tenders.ID
  where peresponse.PEID=@PEID ORDER by applications.Created_At DESC; 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getMySchedules
DROP PROCEDURE IF EXISTS `getMySchedules`;
DELIMITER //
CREATE  PROCEDURE `getMySchedules`(IN _Username VARCHAR(50))
BEGIN
select start,end,title from schedules where UserName = _Username;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getOneapplicant
DROP PROCEDURE IF EXISTS `getOneapplicant`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getOneapplicant`(IN _LoggedInuser VARCHAR(100))
    NO SQL
SELECT applicants.ID ,applicants.ApplicantCode, applicants.Name, applicants.Location, applicants.POBox, applicants.PostalCode, applicants.Town, applicants.Mobile, applicants.Telephone, applicants.Email, applicants.Logo, applicants.Website ,applicants.County as CountyCode,counties.`Name` as County,RegistrationDate,PIN,RegistrationNo FROM `applicants` 
inner join counties on counties.`Code`=applicants.County
WHERE applicants.Deleted=0 and applicants.Created_By=_LoggedInuser or applicants.ID=_LoggedInuser or applicants.Email=_LoggedInuser//
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
SELECT `ID`, `ApplicationID`,  `Description`, `FileName`, `DateUploaded`, `Path`,Confidential,Created_By FROM `applicationdocuments`  WHERE Deleted=0 and ApplicationID=_ApplicationID;
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
CREATE  PROCEDURE `getOneCaseOfficer`(IN _Username VARCHAR(50))
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
CREATE  PROCEDURE `GetOnevenue`(IN _ID int)
BEGIN
 
  Select venues.ID,  venues.ID,branches.Description as Branch,  venues.Name,venues.Description 
  from venues inner join branches on branches.ID=venues.Branch where venues.deleted=0 and ID=_ID;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPanelMembers
DROP PROCEDURE IF EXISTS `GetPanelMembers`;
DELIMITER //
CREATE  PROCEDURE `GetPanelMembers`(IN _ApplicationNo VARCHAR(50))
BEGIN
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID, panels.ApplicationNo,panels.UserName,users.Name,users.Email,users.Phone ,panels.Status,Role from panels
  inner join users on users.Username=panels.UserName where ApplicationNo=_ApplicationNo and panels.deleted=0 order by ID ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetpanelsApproval
DROP PROCEDURE IF EXISTS `GetpanelsApproval`;
DELIMITER //
CREATE  PROCEDURE `GetpanelsApproval`(IN _UserID VARCHAR(50))
BEGIN
select DISTINCT applications.HearingNoticeGenerated, applications.ApplicationNo,applications.PEID,'' as ResponseType,'' as ResponseDate,
  procuremententity.Name as PEName,procuremententity.POBox as PEPOBOX,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,
  procuremententity.Email as PEEmail,procuremententity.Telephone as PETeleponde,
  panelsapprovalworkflow.status as PanelStatus 
  from applications inner join procuremententity on applications.PEID=procuremententity.PEID 
  inner join panelsapprovalworkflow on panelsapprovalworkflow.ApplicationNo=applications.ApplicationNo
  where applications.ClosingDate >= now() and
   panelsapprovalworkflow.status='Pending Approval' and applications.ApplicationNo
 -- not in (select ApplicationNo from panelsapprovalworkflow WHERE Approver=_UserID and Status='Approved')
  and _UserID in (select Username From approvers where Deleted=0 and ModuleCode='PAREQ' and Active=1) order by applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Getpartysubmision
DROP PROCEDURE IF EXISTS `Getpartysubmision`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Getpartysubmision`(IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN

Select ID,Party, ApplicationNo ,Description from partysubmision WHERE Deleted=0 and ApplicationNo=_ApplicationNo;


  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getpaymenttypes
DROP PROCEDURE IF EXISTS `getpaymenttypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getpaymenttypes`( )
    NO SQL
BEGIN

Select  
  ID,Description, Created_By ,Created_At ,Deleted From paymenttypes WHERE Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getPE
DROP PROCEDURE IF EXISTS `getPE`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `getPE`()
    NO SQL
SELECT DISTINCT procuremententity.PEID, procuremententity.Name, procuremententity.PEType,petypes.Description as PETypeName,
  procuremententity.Location, procuremententity.POBox, procuremententity.PostalCode, procuremententity.Town, 
  procuremententity.Mobile, procuremententity.Telephone, procuremententity.Email, procuremententity.Logo, procuremententity.Website 
  ,procuremententity.County as CountyCode,counties.Name as County,
  procuremententity.RegistrationDate ,
  procuremententity.PIN,
  procuremententity.RegistrationNo  from procuremententity 
inner join counties on counties.Code=procuremententity.County inner join petypes on petypes.Code=procuremententity.PEType
WHERE procuremententity.Deleted=0//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEAppearanceFrequency
DROP PROCEDURE IF EXISTS `GetPEAppearanceFrequency`;
DELIMITER //
CREATE  PROCEDURE `GetPEAppearanceFrequency`(IN _FromDate Date,IN _ToDate Date ,IN _ALl Boolean)
BEGIN
if(_ALl=1) THEn
Begin
select count(applications.ID) as Count,procuremententity.PEType,petypes.Description as PEDesc from applications 
  inner join procuremententity on procuremententity.PEID=applications.PEID 
  inner join petypes on procuremententity.PEType=petypes.Code   GROUP by (procuremententity.PEType);
  ENd;
Else
Begin
select count(applications.ID) as Count,procuremententity.PEType,petypes.Description as PEDesc from applications 
  inner join procuremententity on procuremententity.PEID=applications.PEID 
  inner join petypes on procuremententity.PEType=petypes.Code 
  where CAST(applications.Created_At AS DATE)  BETWEEN   CAST(_FromDate AS DATE)  AND   CAST(DATE_ADD(_ToDate, INTERVAL 1 DAY) AS DATE)  
GROUP by procuremententity.PEType;
  End;
End if;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEAppearanceFrequencyPercategory
DROP PROCEDURE IF EXISTS `GetPEAppearanceFrequencyPercategory`;
DELIMITER //
CREATE  PROCEDURE `GetPEAppearanceFrequencyPercategory`(IN _Category varchar(50))
BEGIN
select Code from petypes WHERE Description=_Category LIMIT 1 into @PEType;
select count(applications.ID) as Count,procuremententity.Name,applications.PEID from applications 
  inner join procuremententity on procuremententity.PEID=applications.PEID where procuremententity.PEType =@PEType
     GROUP by MONTH(procuremententity.Name);


END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEApplications
DROP PROCEDURE IF EXISTS `GetPEApplications`;
DELIMITER //
CREATE  PROCEDURE `GetPEApplications`(IN _PEID varchar(50))
BEGIN

select ApplicationNo,Status,tenders.TenderNo,tenders.Name,FilingDate,applicants.Name from applications 
  inner join tenders on tenders.ID=applications.TenderID
  inner join 
  applicants on applications.ApplicantID=applicants.ID
  WHERE applications.PEID=_PEID
     order by FilingDate ASC;


END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPendingApplicationFees
DROP PROCEDURE IF EXISTS `GetPendingApplicationFees`;
DELIMITER //
CREATE  PROCEDURE `GetPendingApplicationFees`(IN _UserName VARCHAR(50))
BEGIN
select DISTINCT applications.ID ,applications.ApplicantID,    
  procuremententity.Name,applications.PaymentStatus as FeesStatus,applications.Created_At  as FilingDate,procuremententity.Mobile,
  procuremententity.Location,procuremententity.POBox,procuremententity.Email,procuremententity.Website,procuremententity.PostalCode,procuremententity.Town 
  from applications inner join procuremententity on procuremententity.PEID =applications.PEID 
  where applications.PaymentStatus='Submited' and applications.Status='Submited'
    and applications.ID 
  in (SELECT ApplicationID from paymentdetails)
   and applications.ID 
  not in (SELECT ApplicationID from feesapprovalworkflow where ApprovedBy=_UserName and Category='ApplicationFees')  
  and _UserName 
  in ( SELECT Username from approvers where ModuleCode='PAYMT' and Deleted=0 and Active=1 );
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPendingFeesApprovals
DROP PROCEDURE IF EXISTS `GetPendingFeesApprovals`;
DELIMITER //
CREATE  PROCEDURE `GetPendingFeesApprovals`(IN _ApplicationID int)
BEGIN
select sum(AmountDue)  from applicationfees where ApplicationID=_ApplicationID and applicationfees.Deleted=0 INTO @Totall;
  select @Totall as Total, applicationfees.ID, applicationfees.ApplicationID,feesstructure.Description as EntryType, applicationfees.AmountDue, applicationfees.RefNo, applicationfees.BillDate, applicationfees.AmountPaid
  ,applicationfees.PaidDate, applicationfees.PaymentRef, applicationfees.PaymentMode
  from applicationfees inner join feesstructure  on feesstructure.ID=applicationfees.EntryType 
 where applicationfees.Deleted=0 and FeesStatus='Pending Approval' and applicationfees.ApplicationID=_ApplicationID ;


END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPendingPreliminaryObjectionFees
DROP PROCEDURE IF EXISTS `GetPendingPreliminaryObjectionFees`;
DELIMITER //
CREATE  PROCEDURE `GetPendingPreliminaryObjectionFees`(IN _UserName VARCHAR(50))
BEGIN
select DISTINCT applications.ID ,applications.ApplicantID,    
  procuremententity.Name,peresponse.Status as FeesStatus,applications.Created_At  as FilingDate,procuremententity.Mobile,
  procuremententity.Location,procuremententity.POBox,procuremententity.Email,procuremententity.Website,procuremententity.PostalCode,procuremententity.Town 
  from applications 
  inner join procuremententity on procuremententity.PEID =applications.PEID 
  inner join peresponse on peresponse.PEID=applications.PEID
  where peresponse.Status ='Fees Pending Confirmation' and  applications.ApplicationNo in (select ApplicationNo from peresponse where Status ='Fees Pending Confirmation')
   and applications.ID 
  not in (SELECT ApplicationID from feesapprovalworkflow where ApprovedBy=_UserName and Category='PreliminaryObjectionFees' )  
  and _UserName 
  in ( SELECT Username from approvers where ModuleCode='PAYMT' and Deleted=0 and Active=1 );
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getPEPerApplicationNo
DROP PROCEDURE IF EXISTS `getPEPerApplicationNo`;
DELIMITER //
CREATE  PROCEDURE `getPEPerApplicationNo`(IN _ApplicationNo VARCHAR(50))
BEGIN
select PEID FROM  applications where ApplicationNo=_ApplicationNo into @PEID;
  select PEID,Name,PEType,County,Location,POBox,PostalCode,Town,Mobile,Telephone,Email,Website from procuremententity where PEID=@PEID;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseBackgrounInformation
DROP PROCEDURE IF EXISTS `GetPEResponseBackgrounInformation`;
DELIMITER //
CREATE  PROCEDURE `GetPEResponseBackgrounInformation`(IN _ApplicationNo varchar(50))
BEGIN
select BackgroundInformation from peresponsebackgroundinformation where ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDetails
DROP PROCEDURE IF EXISTS `GetPEResponseDetails`;
DELIMITER //
CREATE  PROCEDURE `GetPEResponseDetails`(IN _ResponseID INT)
BEGIN
Select * from peresponsedetails where PEResponseID=_ResponseID and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDetailsPerApplication
DROP PROCEDURE IF EXISTS `GetPEResponseDetailsPerApplication`;
DELIMITER //
CREATE  PROCEDURE `GetPEResponseDetailsPerApplication`(IN _Application varchar(50))
BEGIN
select ID from peresponse where ApplicationNo=_Application LIMIT 1 into @ResponseID; 
Select peresponsedetails.ID,peresponsedetails.PEResponseID,peresponsedetails.GroundNO,peresponsedetails.GroundType,peresponsedetails.Response,peresponsedetails.Created_At,
  peresponsedetails.Created_By
  ,peresponsedetails.Updated_At,peresponsedetails.Updated_At from peresponsedetails 
 where PEResponseID=@ResponseID and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDocuments
DROP PROCEDURE IF EXISTS `GetPEResponseDocuments`;
DELIMITER //
CREATE  PROCEDURE `GetPEResponseDocuments`(IN _ResponseID VARCHAR(50))
BEGIN
select ID from peresponse where ApplicationNo=_ResponseID LIMIT 1 into @ResponseID; 
Select ID,PEResponseID,Name as FileName,Description,Path,Created_At,Deleted,Confidential from peresponsedocuments where (PEResponseID=_ResponseID or PEResponseID=@ResponseID ) and Deleted=0;
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
CREATE  PROCEDURE `GetPEUserdetails`(IN _User VARCHAR(50))
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

-- Dumping structure for procedure arcm.getPreliminaryObjections
DROP PROCEDURE IF EXISTS `getPreliminaryObjections`;
DELIMITER //
CREATE  PROCEDURE `getPreliminaryObjections`()
BEGIN
select ID,Name,Description,MaxFee,SUM(MaxFee) as Total from feesstructure where Name='Filling Preliminary Objections' and Deleted=0;
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPreliminaryObjectionsFeesPaymentDetails
DROP PROCEDURE IF EXISTS `GetPreliminaryObjectionsFeesPaymentDetails`;
DELIMITER //
CREATE  PROCEDURE `GetPreliminaryObjectionsFeesPaymentDetails`(IN _ApplicationID INT)
BEGIN
 select sum(AmountPaid) from paymentdetails WHERE ApplicationID=_ApplicationID and Category='PreliminaryObjectionsFees' into @Total;
  select  @Total  as TotalPaid,paymentdetails.ApplicationID,paymentdetails.Paidby,paymentdetails.Refference,paymentdetails.DateOfpayment,paymentdetails.AmountPaid,
  paymenttypes.Description as PaymentType ,
  paymentdetails.ChequeDate ,
  paymentdetails.CHQNO 
  from paymentdetails inner JOIN paymenttypes on paymenttypes.ID=paymentdetails.PaymentType WHERE ApplicationID=_ApplicationID and Category='PreliminaryObjectionsFees';
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getPrimaryCaseOfficer
DROP PROCEDURE IF EXISTS `getPrimaryCaseOfficer`;
DELIMITER //
CREATE  PROCEDURE `getPrimaryCaseOfficer`(IN _ApplicationNo varchar(50))
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
CREATE  PROCEDURE `GetRespondedApplications`()
BEGIN
select DISTINCT applications.ApplicationNo,applications.PEID,'' as ResponseType,'' as ResponseDate,
procuremententity.Name as PEName,procuremententity.POBox as PEPOBOX,procuremententity.PostalCode as PEPostalCode,procuremententity.Town as PETown,
  procuremententity.Email as PEEmail,procuremententity.Telephone as PETeleponde,
  'Awaiting panel Formation' as PanelStatus 
  from applications  

  inner join procuremententity on applications.PEID=procuremententity.PEID 
  where  applications.ClosingDate >= now() and 
   (applications.Status ='Approved' OR applications.Status='HEARING IN PROGRESS') ORDER BY applications.Created_At DESC;
   
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetRespondedApplicationsToBeScheduled
DROP PROCEDURE IF EXISTS `GetRespondedApplicationsToBeScheduled`;
DELIMITER //
CREATE  PROCEDURE `GetRespondedApplicationsToBeScheduled`()
BEGIN
select applications.FilingDate,peresponsetimer.RegisteredOn as PEServedOn, applications.ApplicationNo,applications.PEID,
procuremententity.Name as PEName,procuremententity.POBox as PEPOBOX,procuremententity.PostalCode as PEPostalCode,
  procuremententity.Town as PETown,procuremententity.Email as PEEmail,procuremententity.Telephone as PETeleponde,
  '' as PanelStatus 
  from applications inner join procuremententity on applications.PEID=procuremententity.PEID  

  inner join peresponsetimer on peresponsetimer.ApplicationNo=applications.ApplicationNo
  where applications.ClosingDate >= now() and applications.Status <>'WITHDRAWN' and (applications.Status='Approved' OR applications.Status='HEARING IN PROGRESS') ORDER BY applications.Created_At DESC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetRole
DROP PROCEDURE IF EXISTS `GetRole`;
DELIMITER //
CREATE  PROCEDURE `GetRole`(IN `_RoleId` BIGINT)
    NO SQL
BEGIN
Select * from roles where RoleID=_RoleID ;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetRoles
DROP PROCEDURE IF EXISTS `GetRoles`;
DELIMITER //
CREATE  PROCEDURE `GetRoles`()
    NO SQL
BEGIN
Select RoleID,RoleName,RoleDescription from roles where Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetSittingsPerApplicationNo
DROP PROCEDURE IF EXISTS `GetSittingsPerApplicationNo`;
DELIMITER //
CREATE  PROCEDURE `GetSittingsPerApplicationNo`(IN _Applicationno varchar(50))
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

-- Dumping structure for procedure arcm.GetsuccessfullApplications
DROP PROCEDURE IF EXISTS `GetsuccessfullApplications`;
DELIMITER //
CREATE  PROCEDURE `GetsuccessfullApplications`(IN _FromDate DATE, IN _ToDate DATE, IN _Category VARCHAR(50), IN _All BOOLEAN)
BEGIN
-- Successful Applications
if(_Category='Successful')then
  Begin
     if(_All=1) Then
    Begin
      select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
      inner join tenders on tenders.ID=applications.TenderID
      inner join applicants on applicants.ID=applications.ApplicantID
      inner join procuremententity on procuremententity.PEID=applications.PEID
      where ApplicationSuccessful=1;
     End;
    ELSE
      Begin
         select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
        inner join tenders on tenders.ID=applications.TenderID
        inner join applicants on applicants.ID=applications.ApplicantID
        inner join procuremententity on procuremententity.PEID=applications.PEID
        where ApplicationSuccessful=1 and FilingDate BETWEEN _FromDate and DATE_ADD(_ToDate, INTERVAL 1 DAY);
      END;
      END if;
  End;
  END if;
  
  -- UN Successful Applications
if(_Category='Unsuccessful')then
  Begin
     if(_All=1) Then
    Begin
      select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
      inner join tenders on tenders.ID=applications.TenderID
      inner join applicants on applicants.ID=applications.ApplicantID
      inner join procuremententity on procuremententity.PEID=applications.PEID
      where ApplicationSuccessful=0;
     End;
    ELSE
      Begin
         select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
        inner join tenders on tenders.ID=applications.TenderID
        inner join applicants on applicants.ID=applications.ApplicantID
        inner join procuremententity on procuremententity.PEID=applications.PEID
        where ApplicationSuccessful=0 and FilingDate BETWEEN _FromDate and DATE_ADD(_ToDate, INTERVAL 1 DAY);
      END;
      END if;
  End;
  END if;

   -- Withdrawn Applications
if(_Category='Withdrawn')then
  Begin
     if(_All=1) Then
    Begin
      select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
      inner join tenders on tenders.ID=applications.TenderID
      inner join applicants on applicants.ID=applications.ApplicantID
      inner join procuremententity on procuremententity.PEID=applications.PEID
      where Status='WITHDRAWN';
     End;
    ELSE
      Begin
         select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
        inner join tenders on tenders.ID=applications.TenderID
        inner join applicants on applicants.ID=applications.ApplicantID
        inner join procuremententity on procuremententity.PEID=applications.PEID
        where Status='WITHDRAWN' and FilingDate BETWEEN _FromDate and DATE_ADD(_ToDate, INTERVAL 1 DAY);
      END;
      END if;
  End;
  END if;
     -- Withdrawn Applications
if(_Category='Pending Determination')then
  Begin
     if(_All=1) Then
    Begin
      select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
      inner join tenders on tenders.ID=applications.TenderID
      inner join applicants on applicants.ID=applications.ApplicantID
      inner join procuremententity on procuremententity.PEID=applications.PEID
      where Status <> 'WITHDRAWN' and Status <> 'Closed';
     End;
    ELSE
      Begin
         select ApplicationNo,FilingDate,Status,tenders.TenderNo,tenders.TenderValue,applicants.Name as Applicant,procuremententity.Name as PE from applications 
        inner join tenders on tenders.ID=applications.TenderID
        inner join applicants on applicants.ID=applications.ApplicantID
        inner join procuremententity on procuremententity.PEID=applications.PEID
        where Status <> 'WITHDRAWN' and Status <> 'Closed' and FilingDate BETWEEN _FromDate and DATE_ADD(_ToDate, INTERVAL 1 DAY);
      END;
      END if;
  End;
  END if;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetTenderDetailsPerApplicationNo
DROP PROCEDURE IF EXISTS `GetTenderDetailsPerApplicationNo`;
DELIMITER //
CREATE  PROCEDURE `GetTenderDetailsPerApplicationNo`(IN _ApplicationNo VARCHAR(50))
BEGIN
select TenderID from applications where ApplicationNo=_ApplicationNo or ID=_ApplicationNo limit 1 into @Tender;
select TenderNo,Name,TenderValue,tendertypes.Description as TenderTypeDesc,StartDate,tenders.Created_At as FilingDate,  TenderType,
  TenderSubCategory,TenderCategory,Timer,AwardDate from tenders
  inner join tendertypes on tenders.TenderType=tendertypes.Code
  
  where tenders.ID=@Tender;
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
CREATE  PROCEDURE `getuser`(IN `_Username` VARCHAR(128))
    NO SQL
BEGIN
select COUNT(*) from casedetails where UserName=_Username  into @caseOfficer;
SELECT users.Name, users.Username, users.Email, users.Password, users.Phone, users.Create_at,ChangePassword,users.Board, users.Update_at, 
  users.Login_at, users.Deleted, @caseOfficer as CaseOfficerCount,
  users.IsActive, users.IsEmailverified, usergroups.Name as UserGroupID, users.Photo, users.Category, users.Signature, 
  users.IDnumber, users.Gender, users.DOB,users.ActivationCode
from users inner join usergroups on usergroups.UserGroupID=users.UserGroupID where (UserName=_UserName or Email=_UserName) and users.IsActive=1 and users.Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetuserAccess
DROP PROCEDURE IF EXISTS `GetuserAccess`;
DELIMITER //
CREATE  PROCEDURE `GetuserAccess`(IN `_Username` VARCHAR(50))
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

SELECT Username,Rolesbuffer.RoleID,RoleName,Edit,Remove,AddNew,View,Export,Category from Rolesbuffer inner join roles on Rolesbuffer.RoleID=roles.RoleID  ;
DROP TABLE Rolesbuffer; 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getusergroup
DROP PROCEDURE IF EXISTS `getusergroup`;
DELIMITER //
CREATE  PROCEDURE `getusergroup`(IN `_UserGroupID` INT(128))
    NO SQL
BEGIN
Select * from usergroups where Deleted=0 and UserGroupID=_UserGroupID;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetUsergroups
DROP PROCEDURE IF EXISTS `GetUsergroups`;
DELIMITER //
CREATE  PROCEDURE `GetUsergroups`()
    NO SQL
BEGIN
Select * from usergroups where Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetUserRoles
DROP PROCEDURE IF EXISTS `GetUserRoles`;
DELIMITER //
CREATE  PROCEDURE `GetUserRoles`(IN `_Username` VARCHAR(100))
    NO SQL
BEGIN
SELECT `Username`, useraccess.RoleID,RoleName, useraccess.Edit, useraccess.Remove, useraccess.AddNew, useraccess.View, useraccess.Export FROM `useraccess`
inner join roles on roles.RoleID=useraccess.RoleID where 	Username= _Username;  

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetUsers
DROP PROCEDURE IF EXISTS `GetUsers`;
DELIMITER //
CREATE  PROCEDURE `GetUsers`()
    NO SQL
BEGIN
SELECT users.Name, Username,users.Board, Email,Phone,IsActive,usergroups.Name as UserGroup,users.UserGroupID,Photo,Signature,IDnumber,DOB,Gender,Category from users
inner join usergroups on users.UserGroupID=usergroups.UserGroupID
where users.Deleted=0;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.GetvenuesPerBranch
DROP PROCEDURE IF EXISTS `GetvenuesPerBranch`;
DELIMITER //
CREATE  PROCEDURE `GetvenuesPerBranch`(IN _Branch int)
BEGIN
 
  Select venues.ID,  venues.ID,branches.Description as branch,  venues.Name,venues.Description 
  from venues inner join branches on branches.ID=venues.Branch where Venues.deleted=0 and venues.Branch=_Branch;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GiveUserAllRoles
DROP PROCEDURE IF EXISTS `GiveUserAllRoles`;
DELIMITER //
CREATE  PROCEDURE `GiveUserAllRoles`(IN `_Username` VARCHAR(50))
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.groundsandrequestedorders: ~0 rows (approximately)
DELETE FROM `groundsandrequestedorders`;
/*!40000 ALTER TABLE `groundsandrequestedorders` DISABLE KEYS */;
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
DELETE FROM `groundsandrequestedordershistory`;
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

-- Dumping data for table arcm.groupaccess: ~99 rows (approximately)
DELETE FROM `groupaccess`;
/*!40000 ALTER TABLE `groupaccess` DISABLE KEYS */;
INSERT INTO `groupaccess` (`UserGroupID`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`) VALUES
	(1, 17, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:50', '2019-12-05 11:30:53', 0),
	(1, 18, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:54', '2019-12-05 11:30:56', 0),
	(1, 19, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:57', '2019-12-05 11:31:00', 0),
	(1, 20, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:01', '2019-12-05 11:31:04', 0),
	(1, 21, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:05', '2019-12-05 11:31:08', 0),
	(1, 22, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:19', '2019-12-05 11:30:22', 0),
	(1, 24, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:23', '2019-12-05 11:30:28', 0),
	(1, 25, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:28', '2019-12-05 11:30:32', 0),
	(1, 26, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:21', '2019-12-05 11:34:38', 0),
	(1, 27, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:22', '2019-12-05 11:34:38', 0),
	(1, 28, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:33', '2019-12-05 11:30:36', 0),
	(1, 29, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:37', '2019-12-05 11:30:40', 0),
	(1, 30, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:10', '2019-12-05 11:31:13', 0),
	(1, 31, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:13', '2019-12-05 11:31:15', 0),
	(1, 32, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:32', '2019-12-05 11:31:35', 0),
	(1, 33, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:35', '2019-12-05 11:31:37', 0),
	(1, 34, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:38', '2019-12-05 11:31:42', 0),
	(1, 35, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:41', '2019-12-05 11:30:44', 0),
	(1, 36, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:43', '2019-12-05 11:31:47', 0),
	(1, 37, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:50', '2019-12-05 11:31:58', 0),
	(1, 38, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:51', '2019-12-05 11:31:59', 0),
	(1, 39, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:53', '2019-12-05 11:32:00', 0),
	(1, 40, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:50', '2019-12-05 11:34:14', 0),
	(1, 41, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:50', '2019-12-05 11:34:15', 0),
	(1, 42, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:51', '2019-12-05 11:34:11', 0),
	(1, 43, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:52', '2019-12-05 11:34:08', 0),
	(1, 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:53', '2019-12-05 11:34:06', 0),
	(1, 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:52', '2019-12-05 11:34:03', 0),
	(1, 46, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:16', '2019-12-05 11:31:18', 0),
	(1, 47, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:22', '2019-12-05 11:34:39', 0),
	(1, 48, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:25', '2019-12-05 11:34:39', 0),
	(1, 49, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:19', '2019-12-05 11:31:23', 0),
	(1, 50, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:55', '2019-12-05 11:33:58', 0),
	(1, 51, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:24', '2019-12-05 11:34:40', 0),
	(1, 52, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:26', '2019-12-05 11:34:41', 0),
	(1, 53, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:24', '2019-12-05 11:31:27', 0),
	(1, 54, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:43', '2019-12-05 11:33:46', 0),
	(1, 55, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:54', '2019-12-05 11:34:01', 0),
	(1, 56, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:39', '2019-12-05 11:33:43', 0),
	(1, 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:34', '2019-12-05 11:33:37', 0),
	(1, 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:52', '2019-12-05 11:32:56', 0),
	(1, 59, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:31', '2019-12-05 11:33:33', 0),
	(1, 60, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:31:28', '2019-12-05 11:31:30', 0),
	(1, 61, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:27', '2019-12-05 11:33:31', 0),
	(1, 62, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:19', '2019-12-05 11:33:25', 0),
	(1, 63, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:18', '2019-12-05 11:33:26', 0),
	(1, 64, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:14', '2019-12-05 11:33:17', 0),
	(1, 65, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:47', '2019-12-05 11:32:50', 0),
	(1, 66, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:42', '2019-12-05 11:32:46', 0),
	(1, 67, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:15', '2019-12-05 11:32:40', 0),
	(1, 68, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:15', '2019-12-05 11:32:39', 0),
	(1, 69, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:13', '2019-12-05 11:32:39', 0),
	(1, 70, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:12', '2019-12-05 11:32:38', 0),
	(1, 71, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:12', '2019-12-05 11:32:38', 0),
	(1, 72, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:09', '2019-12-05 11:32:37', 0),
	(1, 73, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:09', '2019-12-05 11:32:36', 0),
	(1, 74, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:10', '2019-12-05 11:33:14', 0),
	(1, 75, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:06', '2019-12-05 11:33:09', 0),
	(1, 76, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:33:02', '2019-12-05 11:33:05', 0),
	(1, 77, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:57', '2019-12-05 11:33:01', 0),
	(1, 78, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:30:44', '2019-12-05 11:30:47', 0),
	(1, 79, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:20', '2019-12-05 11:34:52', 0),
	(1, 80, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:34:21', '2019-12-05 11:34:53', 0),
	(1, 81, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:06', '2019-12-05 11:32:35', 0),
	(1, 82, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 11:32:06', '2019-12-05 11:32:35', 0),
	(1, 83, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 12:10:01', '2019-12-05 12:10:04', 0),
	(1, 84, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 12:23:26', '2019-12-05 12:23:28', 0),
	(8, 26, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:54', '2019-12-05 13:21:54', 0),
	(8, 27, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:56', '2019-12-05 13:21:59', 0),
	(8, 32, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:15', '2019-12-05 13:21:15', 0),
	(8, 33, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:18', '2019-12-05 13:21:18', 0),
	(8, 34, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:19', '2019-12-05 13:21:19', 0),
	(8, 36, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:21', '2019-12-05 13:21:21', 0),
	(8, 37, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:23', '2019-12-05 13:21:23', 0),
	(8, 38, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:24', '2019-12-05 13:21:24', 0),
	(8, 39, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:25', '2019-12-05 13:21:25', 0),
	(8, 40, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:31', '2019-12-05 13:21:31', 0),
	(8, 41, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:33', '2019-12-05 13:21:33', 0),
	(8, 42, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:35', '2019-12-05 13:21:35', 0),
	(8, 43, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:41', '2019-12-05 13:21:41', 0),
	(8, 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 13:21:45', '2019-12-05 13:24:37', 0),
	(8, 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 13:21:43', '2019-12-05 13:24:38', 0),
	(8, 47, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:22:00', '2019-12-05 13:22:00', 0),
	(8, 50, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:45', '2019-12-05 13:21:45', 0),
	(8, 54, 0, 0, 0, 0, 0, 'Admin', 'Admin', '2019-12-05 13:25:13', '2019-12-05 13:25:13', 0),
	(8, 55, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:46', '2019-12-05 13:21:46', 0),
	(8, 56, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 13:25:14', '2019-12-05 13:25:17', 0),
	(8, 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 13:22:05', '2019-12-05 13:22:08', 0),
	(8, 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 13:22:32', '2019-12-05 13:25:35', 0),
	(8, 59, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:22:12', '2019-12-05 13:22:12', 0),
	(8, 62, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 13:22:14', '2019-12-05 13:22:17', 0),
	(8, 69, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:22:38', '2019-12-05 13:22:38', 0),
	(8, 74, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:22:23', '2019-12-05 13:22:23', 0),
	(8, 75, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:22:26', '2019-12-05 13:22:26', 0),
	(8, 76, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:22:28', '2019-12-05 13:22:28', 0),
	(8, 79, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:47', '2019-12-05 13:21:47', 0),
	(8, 80, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:49', '2019-12-05 13:21:49', 0),
	(8, 83, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:50', '2019-12-05 13:21:50', 0),
	(8, 84, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-12-05 13:21:51', '2019-12-05 13:21:51', 0);
/*!40000 ALTER TABLE `groupaccess` ENABLE KEYS */;

-- Dumping structure for table arcm.hearingattachments
DROP TABLE IF EXISTS `hearingattachments`;
CREATE TABLE IF NOT EXISTS `hearingattachments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UploadedOn` datetime NOT NULL,
  `UploadedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `DeletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.hearingattachments: ~0 rows (approximately)
DELETE FROM `hearingattachments`;
/*!40000 ALTER TABLE `hearingattachments` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.hearingnotices: ~0 rows (approximately)
DELETE FROM `hearingnotices`;
/*!40000 ALTER TABLE `hearingnotices` DISABLE KEYS */;
/*!40000 ALTER TABLE `hearingnotices` ENABLE KEYS */;

-- Dumping structure for table arcm.interestedparties
DROP TABLE IF EXISTS `interestedparties`;
CREATE TABLE IF NOT EXISTS `interestedparties` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApplicationID` int(11) DEFAULT NULL,
  `ContactName` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TelePhone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PhysicalAddress` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostalCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `POBox` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Designation` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.interestedparties: ~0 rows (approximately)
DELETE FROM `interestedparties`;
/*!40000 ALTER TABLE `interestedparties` DISABLE KEYS */;
/*!40000 ALTER TABLE `interestedparties` ENABLE KEYS */;

-- Dumping structure for table arcm.issuesfordetermination
DROP TABLE IF EXISTS `issuesfordetermination`;
CREATE TABLE IF NOT EXISTS `issuesfordetermination` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NO` int(11) DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `Created_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.issuesfordetermination: ~0 rows (approximately)
DELETE FROM `issuesfordetermination`;
/*!40000 ALTER TABLE `issuesfordetermination` DISABLE KEYS */;
/*!40000 ALTER TABLE `issuesfordetermination` ENABLE KEYS */;

-- Dumping structure for table arcm.jrcontactusers
DROP TABLE IF EXISTS `jrcontactusers`;
CREATE TABLE IF NOT EXISTS `jrcontactusers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApplicationNO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Role` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.jrcontactusers: ~0 rows (approximately)
DELETE FROM `jrcontactusers`;
/*!40000 ALTER TABLE `jrcontactusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `jrcontactusers` ENABLE KEYS */;

-- Dumping structure for table arcm.jrinterestedparties
DROP TABLE IF EXISTS `jrinterestedparties`;
CREATE TABLE IF NOT EXISTS `jrinterestedparties` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ApplicationNO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ContactName` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TelePhone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PhysicalAddress` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostalCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `POBox` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime NOT NULL,
  `Update_at` datetime DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Designation` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.jrinterestedparties: ~0 rows (approximately)
DELETE FROM `jrinterestedparties`;
/*!40000 ALTER TABLE `jrinterestedparties` DISABLE KEYS */;
/*!40000 ALTER TABLE `jrinterestedparties` ENABLE KEYS */;

-- Dumping structure for table arcm.judicialreview
DROP TABLE IF EXISTS `judicialreview`;
CREATE TABLE IF NOT EXISTS `judicialreview` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateFilled` date DEFAULT NULL,
  `CaseNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Applicant` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Court` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateRecieved` datetime DEFAULT NULL,
  `DateofReplyingAffidavit` date DEFAULT NULL,
  `DateofCourtRulling` date DEFAULT NULL,
  `Ruling` text COLLATE utf8mb4_unicode_ci,
  `Created_At` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'In Progress',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.judicialreview: ~0 rows (approximately)
DELETE FROM `judicialreview`;
/*!40000 ALTER TABLE `judicialreview` DISABLE KEYS */;
/*!40000 ALTER TABLE `judicialreview` ENABLE KEYS */;

-- Dumping structure for table arcm.judicialreviewdocuments
DROP TABLE IF EXISTS `judicialreviewdocuments`;
CREATE TABLE IF NOT EXISTS `judicialreviewdocuments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Path` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `DocumentDate` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ActionDate` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ActionDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ActionSent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2048;

-- Dumping data for table arcm.judicialreviewdocuments: ~0 rows (approximately)
DELETE FROM `judicialreviewdocuments`;
/*!40000 ALTER TABLE `judicialreviewdocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `judicialreviewdocuments` ENABLE KEYS */;

-- Dumping structure for procedure arcm.MarkcaseWithdrawalasfrivolous
DROP PROCEDURE IF EXISTS `MarkcaseWithdrawalasfrivolous`;
DELIMITER //
CREATE  PROCEDURE `MarkcaseWithdrawalasfrivolous`(IN _ApplicationNo varchar(50), IN _userID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Declined Case Withdrawal for Application : ', _ApplicationNo); 
Update casewithdrawal set  DecisionDate= now(), Status='Declined',Frivolous =1 where ApplicationNo=_ApplicationNo;
call SaveAuditTrail(_userID,lSaleDesc,'Approval','0' );
  update notifications set Status='Resolved' where Category='Case withdrawal Approval' and  ApplicationNo=_ApplicationNo; 
          
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.membertypes: ~0 rows (approximately)
DELETE FROM `membertypes`;
/*!40000 ALTER TABLE `membertypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `membertypes` ENABLE KEYS */;

-- Dumping structure for table arcm.mpesatransactions
DROP TABLE IF EXISTS `mpesatransactions`;
CREATE TABLE IF NOT EXISTS `mpesatransactions` (
  `TransactionType` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TransID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TransTime` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TransAmount` float DEFAULT NULL,
  `BusinessShortCode` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillRefNumber` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `InvoiceNumber` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OrgAccountBalance` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ThirdPartyTransID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MSISDN` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FirstName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MiddleName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LastName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Confirmed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.mpesatransactions: ~0 rows (approximately)
DELETE FROM `mpesatransactions`;
/*!40000 ALTER TABLE `mpesatransactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mpesatransactions` ENABLE KEYS */;

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
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.notifications: ~0 rows (approximately)
DELETE FROM `notifications`;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table arcm.panelapprovalcontacts
DROP TABLE IF EXISTS `panelapprovalcontacts`;
CREATE TABLE IF NOT EXISTS `panelapprovalcontacts` (
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Msg` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.panelapprovalcontacts: ~0 rows (approximately)
DELETE FROM `panelapprovalcontacts`;
/*!40000 ALTER TABLE `panelapprovalcontacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `panelapprovalcontacts` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.panellist: ~0 rows (approximately)
DELETE FROM `panellist`;
/*!40000 ALTER TABLE `panellist` DISABLE KEYS */;
/*!40000 ALTER TABLE `panellist` ENABLE KEYS */;

-- Dumping structure for table arcm.panels
DROP TABLE IF EXISTS `panels`;
CREATE TABLE IF NOT EXISTS `panels` (
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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.panels: ~0 rows (approximately)
DELETE FROM `panels`;
/*!40000 ALTER TABLE `panels` DISABLE KEYS */;
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
  `Approver` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Approved_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=1638;

-- Dumping data for table arcm.panelsapprovalworkflow: ~0 rows (approximately)
DELETE FROM `panelsapprovalworkflow`;
/*!40000 ALTER TABLE `panelsapprovalworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `panelsapprovalworkflow` ENABLE KEYS */;

-- Dumping structure for table arcm.partysubmision
DROP TABLE IF EXISTS `partysubmision`;
CREATE TABLE IF NOT EXISTS `partysubmision` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Party` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `Created_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.partysubmision: ~0 rows (approximately)
DELETE FROM `partysubmision`;
/*!40000 ALTER TABLE `partysubmision` DISABLE KEYS */;
/*!40000 ALTER TABLE `partysubmision` ENABLE KEYS */;

-- Dumping structure for table arcm.paymentdetails
DROP TABLE IF EXISTS `paymentdetails`;
CREATE TABLE IF NOT EXISTS `paymentdetails` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ApplicationID` bigint(20) NOT NULL,
  `Paidby` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Refference` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateOfpayment` date DEFAULT NULL,
  `AmountPaid` float DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PaymentType` int(11) DEFAULT NULL,
  `ChequeDate` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CHQNO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=5461;

-- Dumping data for table arcm.paymentdetails: ~0 rows (approximately)
DELETE FROM `paymentdetails`;
/*!40000 ALTER TABLE `paymentdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymentdetails` ENABLE KEYS */;

-- Dumping structure for table arcm.paymenttypes
DROP TABLE IF EXISTS `paymenttypes`;
CREATE TABLE IF NOT EXISTS `paymenttypes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Update_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Deleted` tinyint(1) DEFAULT NULL,
  `Delete_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.paymenttypes: ~4 rows (approximately)
DELETE FROM `paymenttypes`;
/*!40000 ALTER TABLE `paymenttypes` DISABLE KEYS */;
INSERT INTO `paymenttypes` (`ID`, `Description`, `Created_By`, `Created_At`, `Update_By`, `Updated_At`, `Deleted`, `Delete_By`, `Deleted_At`) VALUES
	(1, 'MPESA', 'Admin', '2019-11-21 15:44:02', NULL, NULL, 0, NULL, NULL),
	(2, 'Cash Deposit', 'Admin', '2019-11-21 15:44:16', NULL, NULL, 0, NULL, NULL),
	(3, 'RTGS', 'Admin', '2019-11-21 15:44:31', NULL, NULL, 0, NULL, NULL),
	(4, 'Cheque', 'Admin', '2019-11-21 15:44:43', NULL, NULL, 0, NULL, NULL);
/*!40000 ALTER TABLE `paymenttypes` ENABLE KEYS */;

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
DELETE FROM `pedeadlineextensionsrequests`;
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
  `PanelStatus` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`ApplicationNo`,`PEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponse: ~0 rows (approximately)
DELETE FROM `peresponse`;
/*!40000 ALTER TABLE `peresponse` DISABLE KEYS */;
/*!40000 ALTER TABLE `peresponse` ENABLE KEYS */;

-- Dumping structure for table arcm.peresponsebackgroundinformation
DROP TABLE IF EXISTS `peresponsebackgroundinformation`;
CREATE TABLE IF NOT EXISTS `peresponsebackgroundinformation` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationNo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BackgroundInformation` text COLLATE utf8mb4_unicode_ci,
  `ResponseType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsebackgroundinformation: ~0 rows (approximately)
DELETE FROM `peresponsebackgroundinformation`;
/*!40000 ALTER TABLE `peresponsebackgroundinformation` DISABLE KEYS */;
/*!40000 ALTER TABLE `peresponsebackgroundinformation` ENABLE KEYS */;

-- Dumping structure for table arcm.peresponsecontacts
DROP TABLE IF EXISTS `peresponsecontacts`;
CREATE TABLE IF NOT EXISTS `peresponsecontacts` (
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Role` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsecontacts: ~0 rows (approximately)
DELETE FROM `peresponsecontacts`;
/*!40000 ALTER TABLE `peresponsecontacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `peresponsecontacts` ENABLE KEYS */;

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
  `BackgrounInformation` text COLLATE utf8mb4_unicode_ci,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsedetails: ~0 rows (approximately)
DELETE FROM `peresponsedetails`;
/*!40000 ALTER TABLE `peresponsedetails` DISABLE KEYS */;
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
  `Confidential` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsedocuments: ~0 rows (approximately)
DELETE FROM `peresponsedocuments`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsetimer: ~0 rows (approximately)
DELETE FROM `peresponsetimer`;
/*!40000 ALTER TABLE `peresponsetimer` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.petypes: ~16 rows (approximately)
DELETE FROM `petypes`;
/*!40000 ALTER TABLE `petypes` DISABLE KEYS */;
INSERT INTO `petypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(2, 'PET-2', 'Ministry', '2019-07-31 15:54:08', 'Admin', '2019-08-27 17:40:02', 'Admin', 0, NULL),
	(4, 'PET-4', 'State Department', '2019-07-31 15:55:37', 'Admin', '2019-10-04 09:45:06', 'Admin', 0, NULL),
	(5, 'PET-5', 'State Corporation', '2019-07-31 17:05:28', 'Admin', '2019-11-21 10:54:31', 'Admin', 0, NULL),
	(6, 'PET-6', 'Public Universities', '2019-08-08 12:37:03', 'Admin', '2019-11-21 10:54:13', 'Admin', 0, NULL),
	(7, 'PET-7', 'County Assemblies', '2019-11-21 10:54:59', 'Admin', '2019-11-21 10:54:59', 'Admin', 0, NULL),
	(8, 'PET-8', 'County Government', '2019-11-21 10:55:11', 'Admin', '2019-11-21 10:55:11', 'Admin', 0, NULL),
	(9, 'PET-9', 'Public School', '2019-11-21 10:59:38', 'Admin', '2019-11-21 10:59:38', 'Admin', 0, NULL),
	(10, 'PET-10', 'Commissions and Independent Offices', '2019-11-21 11:11:38', 'Admin', '2019-11-21 11:11:38', 'Admin', 0, NULL),
	(11, 'PET-11', 'Public Water Companies', '2019-11-21 11:12:00', 'Admin', '2019-11-21 11:12:00', 'Admin', 0, NULL),
	(12, 'PET-12', 'Semi-Autonomous Government Agencies', '2019-11-21 11:12:19', 'Admin', '2019-11-21 11:12:19', 'Admin', 0, NULL),
	(13, 'PET-13', 'Public Colleges', '2019-11-21 11:12:50', 'Admin', '2019-11-21 11:12:50', 'Admin', 0, NULL),
	(14, 'PET-14', 'The Presidency', '2019-12-05 11:05:21', 'Admin', '2019-12-05 11:05:21', 'Admin', 0, NULL),
	(15, 'PET-15', 'Other Entities owned by County Governments', '2019-12-05 11:05:39', 'Admin', '2019-12-05 11:05:39', 'Admin', 0, NULL),
	(16, 'PET-16', 'Pension Schemes', '2019-12-05 11:05:56', 'Admin', '2019-12-05 11:05:56', 'Admin', 0, NULL),
	(17, 'PET-17', 'NGCDF Committees', '2019-12-05 11:06:50', 'Admin', '2019-12-05 11:06:50', 'Admin', 0, NULL),
	(18, 'PET-18', 'NGAAF', '2019-12-05 11:10:48', 'Admin', '2019-12-05 11:10:48', 'Admin', 0, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peusers: ~0 rows (approximately)
DELETE FROM `peusers`;
/*!40000 ALTER TABLE `peusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `peusers` ENABLE KEYS */;

-- Dumping structure for table arcm.procuremententity
DROP TABLE IF EXISTS `procuremententity`;
CREATE TABLE IF NOT EXISTS `procuremententity` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PEType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `County` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `POBox` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PostalCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Telephone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  UNIQUE KEY `UK_procuremententity_PEID` (`PEID`)
) ENGINE=InnoDB AUTO_INCREMENT=925 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.procuremententity: ~412 rows (approximately)
DELETE FROM `procuremententity`;
/*!40000 ALTER TABLE `procuremententity` DISABLE KEYS */;
INSERT INTO `procuremententity` (`ID`, `PEID`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`, `RegistrationDate`, `PIN`, `RegistrationNo`) VALUES
	(413, 'PE-1', 'Public Procurement Regulatory Authority', 'PET-5', '047', 'National Bank Building', '58535', '200', 'nairobi', '', '', 'bgitonga@ppra.go.ke', NULL, 'ppra.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(414, 'PE-2', 'ICT Authority', 'PET-5', '047', ' Telposta Towers 12th Floor', '27150', '100', '', '', '', 'stephen.mwaura@ict.go.ke', NULL, 'www.icta.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(415, 'PE-3', 'Kenya National Qualification Authority', 'PET-5', '047', 'Nairobi', '123', '', '', '', '', 'sammuel.angulu@yauu.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(416, 'PE-4', 'Ewaso Ng\'iro North Development Authority ', 'PET-5', '047', 'Isiolo', '203', '60300', '', '', '', 'benard.omwoyo@yahoo.com', NULL, 'www.ennda.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(417, 'PE-5', 'Ministry of Interior and Coordination of National Governments', 'PET-2', '047', '720911263', '720911263', '', '', '', '', 'muirurikarii@yahoo.com', NULL, 'www.interior.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(418, 'PE-6', 'Kirinyaga University', 'PET-6', '047', ' Kutus', 'P.O Box 143-10300 ', '', 'Kerugoya', '', '', 'athiong\'o@kyu.ac.ke', NULL, 'www.kyu.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(419, 'PE-7', 'Kenya Copyright Board ', 'PET-5', '047', '5th Floor NHIF Building - Community Ragati Road/Ngong Road', '34670 - 00100 ', '', '', '', '', 'mokwaro@copyright.go.ke', NULL, 'www.copyright.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(420, 'PE-8', 'School Equipment Production Unit', 'PET-5', '047', 'Inside University of Nairobi,Kenya Science Campus,Ngong Road', 'P.O Box 25140-00603', '', '', '', '', 'info@sepu.co.ke', NULL, 'www.schoolequipment.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(421, 'PE-9', 'National Oil Corporation Of Kenya', 'PET-5', '047', 'Kawi House, South C.', '58576 -00200', '', '', '', '', 'modiwa@noilkenya.co.ke', NULL, 'www.nationaloil.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(422, 'PE-10', 'Kenya School Of Government', 'PET-5', '047', 'Lower Kabete', '23030', '604', '', '', '', 'director@ksg.ac.ke', NULL, 'www.ksg.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(423, 'PE-11', 'Kenya Industrial Property Institute', 'PET-5', '047', 'Weights and measures Premises, Popo Road-South c', '516648', '200', '', '', '', 'Info@kipi.go.ke', NULL, 'www.kipi.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(424, 'PE-12', 'Kenya School Of Law', 'PET-5', '047', 'Karen -Langata South Road', '30369', '100', '', '', '', 'eowuor@ksl.ac.ke', NULL, 'www.ksl.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(425, 'PE-13', 'The East African Portland Cement Company', 'PET-5', '047', 'Off Namanga Road', 'PO BOX 20 ', '204', 'Athi River', '', '', 'duncan.odhiambo@eapcc.co.ke', NULL, 'www.eastafricanportland.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(426, 'PE-14', 'Kenya Marine and fisheries Research Institute', 'PET-5', '047', '721743373', '721743373', '', '', '', '', 'jarnya6@gmail.com', NULL, 'www.kmfri.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(427, 'PE-15', 'Kenya Deposit Insurance Corporation', 'PET-5', '047', '1st floor-CBK Pension house', '45983-00100', '', '', '', '', 'sukantetr@depositinsurance.go.ke', NULL, 'www.depositinsurance.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(428, 'PE-16', 'Competition Authority of Kenya', 'PET-5', '047', ' Kenya Railways HQs Block ', '+254 20277900', '', '', '', '', 'lchesaina@cak.go.ke', NULL, 'www.cak.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(429, 'PE-17', 'Kenya Railways ', 'PET-5', '047', 'Workshop Road, Off Haile Selassie Avenue, Nairobi', 'P.O. Box 30121 - 00100, NAIROBI', '', '', '', '', 'jkairianja@krc.co.ke', NULL, 'www.krc.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(430, 'PE-18', 'National Museums of Kenya', 'PET-5', '047', '0', '40658-00100, Nairobi.', '', '', '', '', 'dkariuki@museums.or.ke', NULL, 'www.museums.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(431, 'PE-19', 'Rivatex East Africa limited ', 'PET-5', '047', ' ELDORET-OFF KISUMU ROAD-KIPKAREN ROAD', '4744-300 Eldoret', '', '', '', '', 'info@rivatex.co.ke', NULL, 'www.rivatex.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(432, 'PE-20', 'Kenya Roads Board', 'PET-5', '047', 'Kenya Re Building,Upperhill, 3rd Flr', 'PO Box 73718 00100 Nairobi', '', '', '', '', 'info@krb.go.ke', NULL, 'Www.krb.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(433, 'PE-21', 'Kenya Agricultural & Livestock Research Organization', 'PET-5', '047', 'KAPTAGAT ROAD', '57811-00200', '', '', '', '', 'george.ayogo@kalro.org', NULL, 'www.kalro.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(434, 'PE-22', 'Export Processing Zones Authority', 'PET-5', '047', 'Viwanda Road  off Nairobi-Namanga Highway', '50563-00200 Nairobi ', '', '', '', '', 'edgar.abayo@epzakenya.com', NULL, 'www.epzakenya.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(435, 'PE-23', 'Water Resources Authority', 'PET-5', '047', ' NHIF BUILDING RAGATI ROAD OFF NGONG ROAD, 9TH FLOOR WING B', '45250-00100', '', '', '', '', 'procurement.wrma@gmail.com', NULL, 'www.wra.go.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(436, 'PE-24', 'Kenya literature Bureau ', 'PET-5', '047', 'South C', '30022 - 00100', '', '', '', '', 'esawe@klb.co.ke', NULL, 'www.klb.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(437, 'PE-25', 'Moi Teaching and Referral Hostipal', 'PET-5', '047', '30100', '3', '', '', '', '', 'samsonkoiyet@mtrh.go.ke', NULL, 'www.mtrh.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(438, 'PE-26', 'Ewaso Ngiro South Development Authority', 'PET-5', '047', 'Off Narok Bomet Road', '213 Narok', '', '', '', '', 'md.ensda@gmail.com', NULL, 'www.ensda.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(439, 'PE-27', 'Public Service Commission', 'PET-10', '047', ' commission house-harambee avenue', '30095-00100 NAIROBI', '', '', '', '', 'psck@publicservice.go.ke', NULL, 'https://www.publicservice.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(440, 'PE-28', 'Kenya Rural Roads Authority ', 'PET-5', '047', ' Blue Shield Towers, Hospital Road, Upper Hill ', '48151-00100 NAIROBI', '', '', '', '', 'roy.makau@kerra.go.ke', NULL, 'www.kerra.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(441, 'PE-29', 'National Irrigation Board', 'PET-5', '047', 'purchasing@nib.or.ke', 'P.O Box 30372-00100,Nairobi,Kenya', '', '', '', '', 'enquries@nib.or.ke\\', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(442, 'PE-30', 'Kenya National Highway Authority', 'PET-5', '047', 'Blue Shield Towers, Hospital Road, Upper Hill', '49712-00100, NAIROBI', '', '', '', '', 'r.kilel@kenha.co.ke', NULL, 'www.kenha.co.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(443, 'PE-31', 'Insurance Regulatory Authority', 'PET-5', '047', 'Zep-Re Place Longonot Road, Upperhill Nairobi', '43505-00100', '', '', '', '', 'dcherono@ira.go.ke', NULL, 'www.ira.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(444, 'PE-32', 'Kenya Universities and Colleges central placement service ', 'PET-5', '047', 'ACK Garden House, 1st Ngong Avenue, community-Nairobi', '105166- 00101, Nairobi', '', '', '', '', 'bnyambura@kuccps.ac.ke', NULL, 'https://www.kuccps.net/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(445, 'PE-33', 'Kenya Medical Laboratory Technician & Technologist Board', 'PET-5', '047', '  1st ngong avenue ', '20889-00202', '', '', '', '', 'procurement@kmlttb.org', NULL, 'www.kmlttb.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(446, 'PE-34', 'National Drought Management Authority', 'PET-5', '047', 'LONRHO HOUSE', '53547-00200-NAIROBI', '', '', '', '', 'rahma.ahmed@ndma.go.ke', NULL, 'www.ndma.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(447, 'PE-35', 'Uwezo Fund Oversight Board', 'PET-4', '047', 'Lonhro House', '42009 - 00100', '', '', '', '', 'enjagi@uwezo.go.ke', NULL, 'www.uwezo.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(448, 'PE-36', 'Communications Authority of Kenya ', 'PET-5', '047', '703042001', '14448-00800', '', '', '', '', 'waweru@ca.go.ke', NULL, 'WWW.CA.GO.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(449, 'PE-37', 'Tana Water Service Board', 'PET-5', '047', 'MAJI HOUSE, ALONG BADEN POWELL ROAD P.O. BOX, 1292 ??? 10100. Nyeri, Kenya', '1292', '', '', '', '', 'jgithinji@tanawsb.or.ke', NULL, 'www.tanawsb.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(450, 'PE-38', 'Kenya Post Office Saving Bank', 'PET-5', '047', 'POSTBANK HOUSE , BANDA STREET NAIROBI', 'Box 30313-00100 Nairobi', '', '', '', '', 'kimosopjj@postbank.co.ke', NULL, 'www.postbank.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(451, 'PE-39', 'Kenya Airport Authority', 'PET-5', '047', 'JKIA NAIROBI', '19001 - 00501', '', '', '', '', 'alfred.baliach@kaa.go.ke', NULL, 'www.kaa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(452, 'PE-40', 'Kenya Ordnance factories corporation ', 'PET-5', '047', '725525803', '725525803', '', '', '', '', 'dnyakamoro@ymail.com', NULL, 'info@kofc.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(453, 'PE-41', 'National Construction Authority', 'PET-5', '047', '9TH FLOOR KCB Towers upper Hill, Kenya Road', '21046-00100 Nairobi', '', '', '', '', 'j.kolani@nca.go.ke', NULL, 'www.nca.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(454, 'PE-42', 'National Council for Persons with Disabilities', 'PET-5', '047', 'Kabete Orthopedic Compound,Waiyaki Way, Opposite ABC Place.', '66577-00800', '', '', '', '', 'daniel.njuguna@ncpwd.go.ke', NULL, 'www.ncpwd.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(455, 'PE-43', 'NATIONAL AIDS CONTROL COUNCIL', 'PET-5', '047', 'Landmark Plaza, 8th and 9th Floor Argwings Kodhek Road', '61307 00200 ', '', '', '', '', 'nchoge@nacc.or.ke', NULL, 'www.nacc.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(456, 'PE-44', 'National Employment Authority', 'PET-5', '047', 'KASARANI', '25780- 00100 NAIROBI', '', '', '', '', 'jandungu1001@gmail.com', NULL, 'www.nea.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(457, 'PE-45', 'The Kenya National Examination Council ', 'PET-5', '047', 'NHC HSE-AGA KHAN WALK', '721839290', '', '', '', '', 'cmurage@knec.ac.ke', NULL, 'https://www.knec.ac.ke/home/index.php', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(458, 'PE-46', 'Numerical Machining Complex Limited', 'PET-5', '047', 'Kenya railways Central workshop, Workshop road, Nairobi', '70660- 00400', '', '', '', '', 'joylenemwelu@mail.com', NULL, 'www.nmc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(459, 'PE-47', 'National Sports Fund ', 'PET-5', '047', 'Flamingo Towers, Mara Road, 7th floor, Upper Hill', '4644-00200', '', '', '', '', 'info@nationalsportsfund.org', NULL, 'www.nationalsportsfund.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(460, 'PE-48', 'Kenya Water Towers Agency', 'PET-5', '047', 'NHIF Building, Nairobi', 'P O Box 42903-00100 Nairobi', '', '', '', '', 'peterkabiru@gmail.com', NULL, 'http://www.kwta.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(461, 'PE-49', 'Kenya Trade Network Agency ', 'PET-5', '047', 'Head Office 1st Flr Embankment Plaza, Longonot Road, Upper Hill,', 'P.O. Box 36943 - 00200, Nairobi.', '', '', '', '', 'dkihia@kentrade.go.ke', NULL, 'https://www.kentrade.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(462, 'PE-50', 'Anti-counterfeit Agency', 'PET-5', '047', 'NATIONAL WATER CONSERVATION & PIPELINE CORPORATION BUILDING , 3RD FLOOR, NDUNGA ROAD', '47771 00100', '', '', '', '', 'jmuraguri@aca.go.ke', NULL, 'WWW.ACA.GO.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(463, 'PE-51', 'Kenya Industrial Research & Development Institute', 'PET-5', '047', 'SOUTH C', 'P.O. Box 30650 ??? 00100, Nairobi, Kenya', '', '', '', '', 'trizanjuguna12@gmail.com', NULL, 'https://www.kirdi.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(464, 'PE-52', 'Kenya National Trading Corporation Ltd.', 'PET-5', '047', 'Yarrow road off Nanyuki Rd ,Industrial Area', '30587-00100', '', '', '', '', 'kntcl@kntcl.com', NULL, 'www.kntcl.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(465, 'PE-53', 'Kenya National Commission for UNESCO', 'PET-5', '047', '0', '0', '', '', '', '', 'droduogi75@gmail.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(466, 'PE-54', 'Salaries & Remuneration Commission', 'PET-5', '047', 'Williamson House 6th Floor, 4th Ngong Avenue', 'Box 43126 - 00100', '', '', '', '', 'tlumati@src.go.ke', NULL, 'http://www.src.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(467, 'PE-55', 'National Council for Population and Development', 'PET-5', '047', 'CHANCERY BUILDING, 4th FLOOR, VALLEY ROAD', 'P.O.BOX 48994-00100, NAIROBI', '', '', '', '', 'pnzoi@ncpd.go.ke', NULL, 'www.ncpd-ke.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(468, 'PE-56', 'National Government Affirmative Action Fund', 'PET-18', '047', '723822165', '723822165', '', '', '', '', 'jmunguti74@gmail.com', NULL, 'WWW.NGAAF.GO.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(469, 'PE-57', 'Kenya Tourism Board', 'PET-5', '047', 'Kenya Re Towers, Off Ragati Road, Upper Hill', '30630 - 00100 Nairobi', '', '', '', '', 'mowino@ktb.go.ke', NULL, 'www.ktb.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(470, 'PE-58', 'Postal Corporation of Kenya', 'PET-5', '047', ' POSTA HOUSE AT POSTA ROAD  NEXT TO NYAYO HOUSE ', '34567-00100', '', '', '', '', 'info@posta.co.ke', NULL, 'WWW.POSTA.CO.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(471, 'PE-59', 'Agricultural Development Corporation', 'PET-5', '047', 'Moi Avenue, Development House, 9th and 10th Floor', '47101 - 00100', '', '', '', '', 'wambuikibue@gmail.com', NULL, 'www.adc.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(472, 'PE-60', 'Kenya Ferry Services', 'PET-5', '047', 'Likoni Peleza', '96242 -80110 Mombasa', '', '', '', '', 'procurement@kenyaferry.co.ke/ md@kenyaferry.co.ke', NULL, 'www.kenyaferry.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(473, 'PE-61', 'National Biosafety Authority', 'PET-5', '047', 'PEST CONTROL PRODUCTS BOARD (PCPB) BULIDING, LORESHO,OFF WAIYAKI WAY', '28251-00100 ', '', '', '', '', 'wamukota@biosafetykenya.go.ke', NULL, 'www.biosafetykenya.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(474, 'PE-62', 'Technical and Vocational Education and Training Authority', 'PET-5', '047', 'Telposta Towers,Kenyatta Avenue', 'P.O.BOX 35625-00100', '', '', '', '', 'henryobatsa@yahoo.com', NULL, 'www.tvetauthority.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(475, 'PE-63', 'National Hospital Insurance Fund', 'PET-5', '047', 'NHIF Building', '30443-00100', '', '', '', '', 'dchelagat@nhif.or.ke', NULL, 'www.nhif.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(476, 'PE-64', 'Kenya  Water Institute ', 'PET-5', '047', '722316304', '722316304', '', '', '', '', 'musya@kewi.or.ke', NULL, 'www.kewi.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(477, 'PE-65', 'The President\'s Award - Kenya', 'PET-4', '047', '15 Elgon Road Upperhill', '62185-00200', '', '', '', '', 'mprisca@presidentsaward.or.ke', NULL, 'www.presidentsaward.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(478, 'PE-66', 'Ministry of Agriculture, Livestock and Fisheries', 'PET-2', '047', '0', '0', '', '', '', '', 'baomondi@gmail.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(479, 'PE-67', 'Kenya Institute of Curriculum Development', 'PET-5', '047', '0', '0', '', '', '', '', 'brotich@kicd.ac.ke', NULL, 'www.kicd.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(480, 'PE-68', 'Agricultural Finance Corporation', 'PET-5', '047', '720921754', '720921754', '', '', '', '', 'jwachira@agrifinance.org', NULL, 'http://www.agrifinance.org/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(481, 'PE-69', 'Kenya Plant Health Inspectorate Service', 'PET-5', '047', ' Oloolua Ridge, Karen', 'P. O. Box 49592-00100', '', '', '', '', 'sesharanda@kephis.org', NULL, 'www.kephis.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(482, 'PE-70', 'Ministry of Sports, Culture and the Arts', 'PET-2', '047', 'KENCOM building', '49489-00100', '', '', '', '', 'gatere.jane@yahoo.com', NULL, 'www.sportsheritage.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(483, 'PE-71', 'Kenyatta National Hospital', 'PET-5', '047', '  Hospital Road', 'P. O. Box 20723-00202', '', '', '', '', 'simon.wagura@gmail.com', NULL, 'www.knh.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(484, 'PE-72', 'Water Sector Trust Fund', 'PET-5', '047', 'CIC Plaza, Upper Hill, Mara Road', 'P.O. Box 49699 - 00100', '', '', '', '', 'kennedy.lukhando@waterfund.go.ke', NULL, 'www.waterfund.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(485, 'PE-73', 'Pest Control Products Board', 'PET-5', '047', '  loresho,waiyaki way', '13794-00800 nairobi', '', '', '', '', 'ndirangurobert@pcpb.or.ke', NULL, 'www.pcpb.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(486, 'PE-74', 'Kenya Institute Of Mass Communication', 'PET-5', '047', ' SOUTH B MUHORO RD', '42422-0100 nairobi', '', '', '', '', 'mmarindich@kimc.ac.ke', NULL, 'PPIP', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(487, 'PE-75', 'Ministry of Public Service, Youth & Gender Affairs ', 'PET-2', '047', 'TELEPOSTA TOWERS', 'P.O BOX 29966-00100', '', '', '', '', 'andrewkimulu@yahoo.com', NULL, 'http://www.psyg.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(488, 'PE-76', 'The Sacco Societies Regulatory Authority', 'PET-5', '047', 'UAP/Old Mutual Tower, Hospital Road, Upperhill', '25089-00100', '', '', '', '', 'pahomo@sasra.go.ke', NULL, 'http://www.sasra.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(489, 'PE-77', 'Kenya Film Commission', 'PET-5', '047', ' JUMUIA PLACE 2ND FLOOR LENANA ROAD KILIMANI', '76417-00508 NAIROBI', '', '', '', '', 'kamanda@filmingkenya.com', NULL, 'www.kenyafilmcommission.com ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(490, 'PE-78', 'Kenya Institute for Public Policy and Research and Analysis', 'PET-5', '047', ' Bishops Road, Nairobi ', '056445-00200, nbi', '', '', '', '', 'vodongo@kippra.or.ke', NULL, 'www.kippra.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(491, 'PE-79', 'Ministry of Transport and Infrastructure', 'PET-4', '047', 'transcom house, ngong road', '52692-00200', '', '', '', '', 'psmaritimeshipping@gmail.com', NULL, 'www.transport.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(492, 'PE-80', 'Youth Enterprise Development Fund', 'PET-5', '047', 'Rennaissance Coporate Park, 4th Floor, Elgon Road, Upper-Hill, Nairobi', '48610-00100', '', '', '', '', 'aouma@youthfund.go.ke', NULL, 'www.youthfund.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(493, 'PE-81', 'Tourism Regulatory Authority', 'PET-5', '047', '100', '30027', '', '', '', '', 'sswaleh@tourismauthority.go.ke', NULL, 'https://www.tourismauthority.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(494, 'PE-82', 'Water Service Regulatory Board', 'PET-5', '047', '5th Floor NHIF Building Ngong Road', 'P. Box 41621-00100 Nairobi', '', '', '', '', 'jkimotho@wasreb.go.ke', NULL, 'www.wasreb.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(495, 'PE-83', 'KENYA ACCREDITATION SERVICE', 'PET-5', '047', 'Embankment Plaza, 2nd Floor, Longonot Road off Kenya Road, Upper Hill', 'P. O. Box 47400 - 00100 Nairobi', '', '', '', '', 'procurement@kenyaaccreditation.org', NULL, 'http://kenas.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(496, 'PE-84', 'National Housing Corporation', 'PET-5', '047', 'NHC House, Aga Khan Walk, Harambee Avenue', 'P.O BOX 30257-00100', '', '', '', '', 'info@nhckenya.co.ke, kmochire@nhckenya.co.ke', NULL, 'www.nhckenya.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(497, 'PE-85', 'Konza Technopolis Development Authority', 'PET-5', '047', 'NAIROBI', 'P.O BOX 30519-00200', '', '', '', '', 'vkiprop@konzacity.go.ke', NULL, 'www.konzacity.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(498, 'PE-86', 'ICDC', 'PET-5', '047', 'Uchumi House, Agakhan Walk, 17th Floor', '45519 00100', '', '', '', '', 'abarmao@icdc.co.ke', NULL, 'www.icdc.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(499, 'PE-87', 'Consolidated Bank', 'PET-5', '047', 'Consolidated Bank House, 23 koinange street', '51133-00200 Nairobi', '', '', '', '', 'jkikayaya@consolidated-bank.com', NULL, 'www.consolidated-bank.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(500, 'PE-88', 'Kenya Petroleum Refineries Limited', 'PET-5', '047', 'OLD REFINERY RD, CHANGAMWE', 'PO BOX 90401, 80100 MOMBASA', '', '', '', '', 'janette.mutimbia@kprl.co.ke', NULL, 'www.kprl.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(501, 'PE-89', 'Tana And Athi Rivers Development Authority', 'PET-5', '047', 'Queensway House, 7th floor Kaunda Street', '47309-00100', '', '', '', '', 'procurement@tarda.co.ke ', NULL, 'www.tarda.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(502, 'PE-90', 'Lake Victoria South Water Services Board', 'PET-5', '047', 'Lavictor\'s Hse, Off Ring Road, Milimani', '3325-40100, Kisumu, KENYA', '', '', '', '', 'joteng@lvswaterboard.go.ke', NULL, 'http://www.lvswaterboard.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(503, 'PE-91', 'Council Of Governors', 'PET-4', '047', 'Delta Corner, westlands', '40401-00100', '', '', '', '', 'hilda.were@cog.go.ke', NULL, 'www.cog.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(504, 'PE-92', 'Tourism Fund', 'PET-5', '047', 'NHIF BUILDING, CAR PARK TOWER 5TH FLOOR', '046987-00100', '', '', '', '', 'nmukuna@tourismfund.co.ke', NULL, 'www.tourismfund.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(505, 'PE-93', 'Kenya Post Office Savings Bank', 'PET-5', '047', '722435875', '722435875', '', '', '', '', 'osorogn@postbank.co.ke', NULL, 'www.postbank.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(506, 'PE-94', 'Kenya Ordance Factories Corporation', 'PET-5', '047', '0', '0', '', '', '', '', 'fwerus@gmail.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(507, 'PE-95', 'National Commission For Science,Technology Andinnovation', 'PET-5', '047', '727236113', '727236113', '', '', '', '', 'denisyegonn@gmail.com', NULL, 'www.nacosti.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(508, 'PE-96', 'Ministry of Defence', 'PET-2', '047', 'Ulinzi house, Lenana road', '40668-00100', '', '', '', '', 'mbuguajane12@gmail.com', NULL, 'www.mod.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(509, 'PE-97', 'Engineers Board of Kenya', 'PET-5', '047', 'Transcom House Annex, 1st Floor, Ngong Rd.', 'P.O. Box 30324-00100 Nairobi, Kenya', '', '', '', '', 'sabuya@ebk.or.ke', NULL, 'www.ebk.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(510, 'PE-98', 'University of Nairobi Enterprises and Services', 'PET-5', '047', '    ARBORETUM DRIVE OFF STATE HOUSE ROAD', 'P.O BOX 68241', '', '', '', '', 'fredrick.kanyangi@uonbi.ac.ke', NULL, 'WWW.UNES.CO.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(511, 'PE-99', 'Narok', 'PET-8', '047', 'NAROK-MAU ROAD', '898-20500', '', '', '', '', 'procurement@narok.go.ke', NULL, 'WWW.NAROK.GO.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(512, 'PE-100', 'The Co-operative University of Kenya', 'PET-6', '047', 'NAIROBI - KAREN', '24814-00502', '', '', '', '', 'bmahiga@cuk.ac.ke', NULL, 'www.cuk.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(513, 'PE-101', 'Kenyatta University (KU)', 'PET-6', '047', 'Along Thika super Highway', '43844', '', '', '', '', 'alati.benson@ku.ac.ke', NULL, 'http://www.ku.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(514, 'PE-102', 'University of Embu', 'PET-6', '047', 'Meru-Nairobi Highway/B6,Embu', '6-60100', '', '', '', '', 'kaaria.lindajoan@embuuni.ac.ke', NULL, 'www.embuni.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(515, 'PE-103', 'Garissa University', 'PET-6', '047', 'Gairissa Town', '1801-70100', '', '', '', '', 'kautharfaraj@gmail.com', NULL, 'www.gau.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(516, 'PE-104', 'Capital Markets Authority', 'PET-5', '047', '  Embankment Plaza, 3rd floor, Longonot Road, Upper Hill', 'P.O. Box 74800 - 00200, Nairobi', '', '', '', '', 'sorina@cma.or.ke', NULL, 'www.cma.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(517, 'PE-105', 'Athi Water Service Board', 'PET-5', '047', 'Africa Re Centre, Hospital Road. Nairobi', 'P. O. Box 45283-00100, Nairobi', '', '', '', '', 'cochieng@awsboard.go.ke', NULL, 'www.awsboard.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(518, 'PE-106', 'ICT and innovation', 'PET-4', '047', ' Teleposta  Towers', '30025-00100', '', '', '', '', 'munganiamukami@gmail.com', NULL, 'tenders.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(519, 'PE-107', 'Kenya Medical Supplies Authority', 'PET-5', '047', ' Commercial street, Industral Area', 'P.O Box 47715, 00100 GPO, Nairobi', '', '', '', '', 'john.kabuchi@kemsa.co.ke', NULL, 'www.kemsa.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(520, 'PE-108', 'University of Nairobi', 'PET-6', '047', '      Harry Thuku Road', '30197-00100', '', '', '', '', 'kanjejo@uonbi.ac.ke', NULL, 'www.uonbi.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(521, 'PE-109', 'Industrialization', 'PET-4', '047', 'Social Security House, Block A, 17th, Flr', 'P.O. Box 30418-00100', '', '', '', '', 'edith.wangari@gmail.com', NULL, 'www.industrialization.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(522, 'PE-110', 'Office of the Attorney General & Department of Justice ', 'PET-2', '047', ' SHERIA HOUSE, HARAMBEE AVENUE', 'P.O BOX 40112-00100, NAIROBI', '', '', '', '', 'jkirugumi@gmail.com', NULL, 'www.statelaw.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(523, 'PE-111', 'Ministry of Lands and Physical Planning', 'PET-2', '047', 'ARDHI HOUSE, 1ST NGONG AVENUE, NGONG ROAD  ', 'P.O BOX 30450 - 00100 NAIROBI', '', '', '', '', 'kennedyomari@gmail.com', NULL, 'www.lands.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(524, 'PE-112', 'Ministry of Tourism  and Wildlife', 'PET-4', '047', ' NSSF Building Block A', 'P. O. Box 30430 -00100', '', '', '', '', 'nyagamunene@yahoo.com', NULL, 'www.tourism.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(525, 'PE-113', 'petroleum and mining', 'PET-2', '047', '   nyayo house', 'p.o box 30582-00100', '', '', '', '', 'ingavojohn80@gmail.com', NULL, 'http://www.petroleumandmining.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(526, 'PE-114', 'State Department of Devolution', 'PET-4', '047', 'Kenyatta Avenue,Teleposta towers 1st & 6th Floors', '30004-00100', '', '', '', '', 'camonichep@yahoo.com', NULL, 'www.devolutionasals.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(527, 'PE-115', 'State Department of Planning', 'PET-4', '047', 'Treasury Building', 'P.O Box 30005-00100 Nairobi', '', '', '', '', 'ps@planning.statistics@gmail.com', NULL, 'www.planning.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(528, 'PE-116', 'National Youth Service', 'PET-4', '047', 'RUARAKA - THIKA Rd', 'P.O. BOX 30397-00100 NAIROBI', '', '', '', '', 'dg@nys.go.ke', NULL, 'supplier.treasury.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(529, 'PE-117', 'State Department of University Education & Research', 'PET-4', '047', ' JOGOO HOUSE "B"', 'P O Box 9583-00200 Nairobi', '', '', '', '', 'paulrono@yahoo.com', NULL, 'www..education.ge.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(530, 'PE-118', 'State Department of Irrigation', 'PET-4', '047', '   MAJI HOUSE', '49720-00100', '', '', '', '', 'matamagodfrey@yahoo.com', NULL, 'www.kilimo.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(531, 'PE-119', 'State Department of Trade', 'PET-4', '047', ' Teleposta Towers, GPO, Kenyatta Avenue', '30430 -00100', '', '', '', '', 'abagga.abner@gmail.com', NULL, 'www.trade.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(532, 'PE-120', 'State Department of Livestock', 'PET-4', '047', ' Kilimo House,  Cathedral Road', 'P. O. Box 34188-00100 Nairobi', '', '', '', '', 'kkbabz@gmail.com', NULL, 'http://www.kilimo.go.ke/management/state-department-of-livestock/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(533, 'PE-121', 'State Department of Mining', 'PET-4', '047', ' WORKS BUILDING  NGONG ROAD', 'P.O.BOX 30009-00100 NAIROBI', '', '', '', '', 'kiilu06@gmail.com', NULL, 'www,mining.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(534, 'PE-122', 'State Department of Housing, Urban Development and Public Works', 'PET-4', '047', ' ARDHI HOUSE', '30119-00100', '', '', '', '', 'sonkuta@gmail.com', NULL, 'www.housing and urban.go.ke   ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(535, 'PE-123', 'Unclaimed Financial Assests Authority', 'PET-5', '047', 'Westlands, Nairobi', '28235 - 00200, Nairobi', '', '', '', '', 'wilson.macharia@ufaa.go.ke', NULL, 'www.ufaa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(536, 'PE-124', 'Commission on Revenue Allocation', 'PET-10', '047', '2nd Floor, Grosvenor Suite???14 Riverside Drive  Riverside', 'P.O. Box 1310 ??? 00200, City Square  NAIROBI', '', '', '', '', 'geoffrey.ntooki@crakenya.org', NULL, 'www.crakenya.org ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(537, 'PE-125', 'KERIO VALLEY DEVELOPMENT AUTHORITY (KVDA)', 'PET-5', '047', 'ELDORET', '2660-30100', '', '', '', '', 'info@kvda.go.ke', NULL, 'www.kvda.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(538, 'PE-126', 'Kenya Veterinary Vaccines Production Institute', 'PET-5', '047', 'INDUSTRIAL AREA,OFF ENTERPRISE ROAD,ROAD A', '00200 53260', '', '', '', '', 'vaccines@kevevapi.org', NULL, 'www.kevevapi.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(539, 'PE-127', 'Kisii University', 'PET-6', '047', 'Along Kisii-Kilgoris Road', '408-40200', '', '', '', '', 'dbasweti@kisiiuniversity.ac.ke', NULL, 'www.kisiiuniversity.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(540, 'PE-128', 'Kenya Pipeline Company', 'PET-5', '047', '88', '9', '', '', '', '', 'Cathrine.Kituri@kpc.co.ke', NULL, 'WWW.KPC.CO.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(541, 'PE-129', 'Anti-Female Genital Mutilation Board', 'PET-5', '047', 'kenya Railways staff Retirement Benefit Scheme Building,Sourth Wing, Block "D" 2nd floor,Workshop Ro', 'P.O. BOX 54760-00200 -NAIROBI', '', '', '', '', 'fredowiti99@gmail.com', NULL, 'www.antifgmboard.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(542, 'PE-130', 'The Jomo Kenyatta Foundation', 'PET-5', '047', '51, Enterprise Road, Industrial Area, Nairobi.', 'P.O. Box 30533 - 00100 Nairobi.', '', '', '', '', 'fokubasu@jkf.co.ke', NULL, 'www.jkf.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(543, 'PE-131', 'State Department for ASALs', 'PET-4', '047', 'EXTELCOM HOUSE', '40213', '', '', '', '', 'nemac2006@yahoo.com', NULL, 'www.devolutionasals.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(544, 'PE-132', 'Retirement Benefits Authority', 'PET-5', '047', 'Rahimtulla Tower,13th Flr, Upper Hill Road', 'P.O.Box 57733 - 00200, Nairobi, Kenya', '', '', '', '', 'vmulwa@rba.go.ke', NULL, 'www.rba.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(545, 'PE-133', 'State department for Telecommunications and Broadcating', 'PET-4', '047', 'Kenyatta Avenue Teleposta Towers', '30025-00100', '', '', '', '', 'kanyara2010@yahoo.com', NULL, 'www.ict.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(546, 'PE-134', 'Ministry of Foreign Affairs', 'PET-2', '047', 'harambee avenue', '30551-00100', '', '', '', '', 'barasaruth1@gmail.com', NULL, 'www.mfa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(547, 'PE-135', 'Kenya Roadway', 'PET-4', '047', '556', '667', '', '', '', '', 'lkr@ppra.go.ke', NULL, 'rrt.lot', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(548, 'PE-136', 'Geothermal Development Company', 'PET-5', '047', 'bowuor@gdc.co.ke', 'Head Office: Kawi House, South C Bellevue |Off Mom', '', '', '', '', ' 020 2427516', NULL, '170_logo_image.png', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(549, 'PE-137', 'Commission for University Education', 'PET-5', '047', 'nokodo@cue.or.ke', 'Red-hill Road off Limuru Road ', '', '', '', '', '780656575', NULL, '171_logo_image.jpg', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(550, 'PE-138', 'State Department for Agricultural Research', 'PET-4', '047', 'Cathedral Road-Kilimo House', '30028-00100', '', '', '', '', 'jnyams.2014@gmail.com', NULL, 'https://www.kilimo.ko.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(551, 'PE-139', 'Egerton University', 'PET-6', '047', 'Egerton', '536-20115, Egerton', '', '', '', '', 'samson.chira@egerton.ac.ke', NULL, 'http://www.egerton.ac.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(552, 'PE-140', 'Machakos University', 'PET-6', '047', 'Machakos Town', '136-90100', '', '', '', '', 'petermaina2007@yahoo.com', NULL, 'www.mksu.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(553, 'PE-141', 'Kenya Medical Research Institute', 'PET-5', '047', 'Mbagathi way ', '54840-00200', '', '', '', '', 'fotieno@kemri.org', NULL, 'www.kemri.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(554, 'PE-142', 'Marsabit', 'PET-8', '047', 'Marsabit County', 'P.o. Box 384 - 60500', '', '', '', '', 'fkamendi@gmail.com', NULL, 'www.marsabit.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(555, 'PE-143', 'Energy Regulatory Commission', 'PET-5', '047', 'Upperhill, Nairobi', 'P.O.Box 42681-00100 Nairobi', '', '', '', '', 'info@erc.go.ke', NULL, 'https://www.erc.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(556, 'PE-144', 'Higher Education Loan Board', 'PET-5', '047', 'UNIVERSITY WAY ANNIVERSARY TOWERS', '69489-00400', '', '', '', '', 'psapiri@helb.co.ke', NULL, 'www.helb.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(557, 'PE-145', 'Kenya Power & Lighting Company', 'PET-5', '047', 'Stima Plaza Kolobot Road, Parklands', '30099-00100', '', '', '', '', 'jkorir@kplc.co.ke', NULL, 'www.kplc.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(558, 'PE-146', 'County Assembly Of Samburu', 'PET-7', '047', 'Assembly Building', 'P.0.Box 3 20600 Maralal Kenya', '', '', '', '', 'elempushuna@samburuassembly.go.ke', NULL, 'http://www.samburuassembly.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(559, 'PE-147', 'Kenya film Classification Board', 'PET-5', '047', 'Agha-Khan Walk Uchumi House 15th Floor', 'P.O BOX 44226 - 00100 NAIROBI', '', '', '', '', 'ondiekimaonga@gmail.com', NULL, 'www.kfcb.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(560, 'PE-148', 'Kirinyaga', 'PET-8', '047', '889', '990', '', '', '', '', 'otundomarrion12@gmail.com', NULL, 'www.kirinyaga.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(561, 'PE-149', 'Kenya Meat Commission', 'PET-5', '047', 'ATHI RIVER', '2-00204', '', '', '', '', 'charonyingambwa@gmail.com', NULL, 'www.kenyameat.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(562, 'PE-150', ' Infrastructure', 'PET-4', '047', 'community', '30260-00100', '', '', '', '', 'jobongo81@gmail.com', NULL, 'www.transport.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(563, 'PE-151', 'Kenya Wildlife Service', 'PET-5', '047', 'hps@kws.go.ke\\', 'kws@kws.go.ke', '', '', '', '', 'naisoi@kws.go.ke\\', NULL, 'kws@kws.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(564, 'PE-152', 'Kenya Ports Authority', 'PET-5', '047', 'KPA -Hqs', 'P. O. Box 95009 - 80104 Mombasa Kenya', '', '', '', '', 'SChepkangor@kpa.co.ke', NULL, 'www.kpa.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(565, 'PE-153', 'Nyayo Tea Zones Develop Corporation', 'PET-5', '047', '454', 'P. O. Box 48522-00100', '', '', '', '', 'CJepchumba@teazones.co.ke', NULL, 'www.teazones.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(566, 'PE-154', 'Kenya Seed Company', 'PET-5', '047', 'Mbegu Plaza, Kitale-Kenya.', 'P.O. Box 553-30200, ', '', '', '', '', 'sthinguri@kenyaseed.co.ke', NULL, 'www.kenyaseed.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(567, 'PE-155', 'National Transport and Safety Authority', 'PET-5', '047', 'Hillpark Building, Upper Hill Road', 'P. 0. Box 3602 - 00506', '', '', '', '', 'winnie.kibuchi@ntsa.go.ke', NULL, 'www.ntsa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(568, 'PE-156', 'COMMODITIES FUND', 'PET-5', '047', 'Kenya Railways |Block D| 2ND Floor | Workshop Rd ??? Off Haile Selassie Avenue', 'P.O Box 52714 ??? 00200 Nairobi, Kenya', '', '', '', '', 'james.singa@codf.co.ke', NULL, 'www.comfund.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(569, 'PE-157', 'Kenya Forest Service', 'PET-5', '047', 'Karura off Kiambu Road', 'Po box 30513-00100 Nairobi', '', '', '', '', 'mburujm@kenyaforestservice.org', NULL, 'www.kenyaforestservice.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(570, 'PE-158', 'Privatization Commission', 'PET-5', '047', 'Extelcoms House 11th Floor', 'P.O. Box 34542 00200 Nairobi', '', '', '', '', 'dmutua@pc.go.ke', NULL, 'www.pc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(571, 'PE-159', 'Ministry of Interior and Co-ordination of National Government', 'PET-4', '047', '254', '722902359', '', '', '', '', 'ngarigithu@yahoo.com', NULL, 'www.interior.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(572, 'PE-160', 'Ministry of Environment and Forestry', 'PET-2', '047', 'NHIF Building', '721498119', '', '', '', '', 'ndongupk@yahoo.com', NULL, 'www.environment.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(573, 'PE-161', 'Kenya Meteorological Department', 'PET-4', '047', 'Dagoretti Corner, Ngong Road', 'P. O. Box 30259 - 00100 Nairobi Kenya', '', '', '', '', 'director@meteo.go.ke', NULL, 'www.environment.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(574, 'PE-162', 'The National Treasury and Planning', 'PET-2', '047', 'Harambee Avenue Treasury Building ', 'P.O. Box 30007 00100 Nairobi', '', '', '', '', 'benoloo2002@gmail.com', NULL, 'http://www.treasury.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(575, 'PE-163', 'Kenya National Bureau of Statistics', 'PET-5', '047', '333', '3345', '', '', '', '', 'procurement@knbs.or.ke', NULL, 'www.knbs.or.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(576, 'PE-164', 'State Department of East Africa Community', 'PET-2', '047', ' Co-op Bank House Building', '8846-00200', '', '', '', '', 'albertgawo@gmail.com', NULL, 'www.meac.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(577, 'PE-165', 'Samburu', 'PET-8', '047', 'Maralal', 'P. O. Box 3 - 20600 Maralal', '', '', '', '', 'info@samburu.go.ke', NULL, 'www.samburu.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(578, 'PE-166', 'County Assembly of Nyandarua', 'PET-7', '047', 'OL KALOU NYAHURURU ROAD', '720-20303 OL KALOU', '', '', '', '', 'jlektari@yahoo.com', NULL, 'http://assembly.nyandarua.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(579, 'PE-167', 'Kakamega', 'PET-8', '047', 'kenyatt avenue', '36-50100', '', '', '', '', 'makubahossen@yahoo.com', NULL, 'www.kakamega.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(580, 'PE-168', 'Technical University of Kenya', 'PET-6', '047', '254', '254', '', '', '', '', 'gwarofm@gmail.com', NULL, 'www.tukenya.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(581, 'PE-169', 'South Nyanza Sugar Company Limited', 'PET-5', '047', 'Awendo,Migori', '107-40405', '', '', '', '', 'james.oluoch@sonysugar.co.ke', NULL, 'Www.sonysugar.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(582, 'PE-170', 'Jaramogi oginga Odinga University of Science and Technology', 'PET-6', '047', 'Bondo', 'P.O BOX 210-40601', '', '', '', '', 'wanguikinyanjui@gmail.com', NULL, 'https://www.jooust.ac.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(583, 'PE-171', 'New Kenya Co-operative Creameries Ltd', 'PET-5', '047', 'Creamery House, Dakar Rd', 'P.O. Box 30131-00100', '', '', '', '', 'daniel.mukunga@newkcc.co.ke', NULL, 'www.newkcc.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(584, 'PE-172', 'National Industrial Training Authority', 'PET-5', '047', 'Commercial street, Industral Area', 'P.O. Box 74494 - 00200', '', '', '', '', 'mmbithe@nita.go.ke', NULL, 'www.nita.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(585, 'PE-173', 'County Assembly of Embu', 'PET-7', '047', 'EMBU', '140-60100 EMBU', '', '', '', '', 'petwaithaka2016@gmail.com', NULL, 'www.embuassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(586, 'PE-174', 'Kenya Industrial Estates ', 'PET-5', '047', 'Likoni', 'P.O. Box 78029 - 00507', '', '', '', '', 'mwalandijijo@gmail.com', NULL, 'www.kie.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(587, 'PE-175', 'Kenya Revenue Authority', 'PET-5', '047', 'Times Tower, Haile Selasie Avenue , Nairobi, Kenya', 'Box 48240-00100', '', '', '', '', 'Nicholas.Njeru@kra.go.ke', NULL, 'www.kra.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(588, 'PE-176', 'Office of the Director of Public Prosecutions', 'PET-10', '047', 'NSSF Building, Block ???A??? 19th Floor', '30701-00100', '', '', '', '', 'eunicembithe87@gmail.com', NULL, 'www.odpp.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(589, 'PE-177', 'Isiolo', 'PET-8', '047', '  Isiolo', 'P.O. Box 36 - 60300', '', '', '', '', 'saritesalad114@gmail.com', NULL, 'www.isiolo.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(590, 'PE-178', 'Kenya Tsetse and Trypanosomiasis Eradication Council', 'PET-5', '047', 'Crescent Business Centre, Off Parklands Road', '66290-00800 Westlands', '', '', '', '', 'cyrusmuiru@yahoo.com', NULL, 'www.kenttec.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(591, 'PE-179', 'Coast Development Authority', 'PET-5', '047', 'Mombasa', 'P.O BOX 1322', '', '', '', '', 'cda@cda.go.ke', NULL, 'www.cda.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(592, 'PE-180', 'Kenya Yearbook Editorial Board', 'PET-5', '047', 'NHIF Buiding, 4th Floor. Upperhill, Nairobi', '34035-00100', '', '', '', '', 'johnouko22@gmail.com', NULL, 'http://kenyayearbook.co.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(593, 'PE-181', 'Dedan Kimathi University of Technology', 'PET-6', '047', '724838361', '254', '', '', '', '', 'procurement@dkut.ac.ke', NULL, 'www.dkut.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(594, 'PE-182', 'Brand Kenya Board', 'PET-5', '047', ' 4th floor, NHIF Building, Ragati road, Upper Hill', 'P.O Box 40500-00100,Nairobi.', '', '', '', '', 'g.gatwiri@brandkenya.go.ke', NULL, 'www.brandkenya.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(595, 'PE-183', 'Northern Water Services Board', 'PET-5', '047', ' Maji House, Garissa', '495 Garissa', '', '', '', '', 'info@nwsb.go.ke', NULL, 'www.nwsb.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(596, 'PE-184', 'Agriculture and Food Authority', 'PET-5', '047', '0', '0', '', '', '', '', 'mmkamburi@afa.go.ke', NULL, 'www.afa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(597, 'PE-185', 'Kenya Maritime Authority', 'PET-5', '047', 'WHITE HOUSE, MOI AVENUE, MOMBASA', 'P. O. Box 95076 - 80104, MOMBASA', '', '', '', '', 'soluoch@kma.go.ke', NULL, 'www.kma.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(598, 'PE-186', 'The Judiciary', 'PET-10', '047', 'City Hall Way-Supreme Court Building', '30041-00100', '', '', '', '', 'doreen.mwirigi@court.go.ke', NULL, 'www.judiciary.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(599, 'PE-187', 'Kenya Electricity  Generating Company', 'PET-5', '047', '  Stirna Plaza, Kolobot Road, Parklands, ', 'P.O. Box 47936, 00100 Nairobi, ', '', '', '', '', 'lgitau@kengen.co.ke', NULL, 'www.kengen.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(600, 'PE-188', 'New Partnership for Africa\'s Development', 'PET-5', '047', 'STATE HOUSE AVENUE LIASION HOUSE', '46270-00100', '', '', '', '', 'carolinendwiga@nepadkenya.org', NULL, 'www.nepadkenya.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(601, 'PE-189', 'Bomas of Kenya', 'PET-5', '047', ' Langata, Forest Edge Road', 'P.O. Box 40689 -00100 Nairobi', '', '', '', '', 'kipronimaritim1@gmail.com', NULL, 'www.bomasofkenya.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(602, 'PE-190', 'University of Eldoret', 'PET-6', '047', 'Eldoret-Ziwa road', 'P.O. Box 1125 - 30100, Eldoret', '', '', '', '', 'w.ngetich@physics.org', NULL, 'http://www.uoeld.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(603, 'PE-191', 'County Assembly of Machakos', 'PET-7', '047', 'Country Hall, Machakos', 'P.  O. Box 1168 - 90100', '', '', '', '', 'mulonziharrison@gmail.com', NULL, 'machakoscountyassembly.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(604, 'PE-192', 'KASNEB', 'PET-5', '047', 'KASNEB Towers, Upperhill Nairobi', 'P. o. Box 41362-00100', '', 'Nairobi', '', '', 'mark.mwangi@kasneb.or.ke', NULL, 'www.kasneb.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(605, 'PE-193', 'County Assembly of Narok', 'PET-7', '047', 'Narok county headquarters-Mau Narok Road', '19-20500', '', '', '', '', 'yiapanoilepore@gmail.com', NULL, 'www.narokassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(606, 'PE-194', 'Export Promotion Council', 'PET-5', '047', 'Anniversary Towers, Univesity way ', 'P.O. Box 40247 - 00100', '', 'Nairobi', '', '', 'RKipturgo@epc.or.ke', NULL, 'www.epckenya.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(607, 'PE-195', 'National Water Conservation & Pipeline Corporation', 'PET-5', '047', 'Dunga Road, Industrial Area', 'P. O. Box 30173, 00100', '', 'Nairobi', '', '', 'mwelelubrian@gmail.com', NULL, 'www.nwcpc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(608, 'PE-196', 'Kenya Forestry Research Institute', 'PET-5', '047', 'Muguga, Limuru', 'P.  O. Box 20412 - 00200', '', '', '', '', 'iodhiambo@kefri.org', NULL, 'www.kefri.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(609, 'PE-197', 'Moi University', 'PET-6', '047', '  Eldoret', 'P. O. Box 3900', '', '', '', '', 'veronibelio@gmail.com', NULL, 'https://www.mu.ac.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(610, 'PE-198', 'Kenya Animal Genetic Resources Centre', 'PET-5', '047', '      lower kabete', '23070-0604', '', '', '', '', 'njeptoo@kagrc.co.ke', NULL, 'www.kagrc.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(611, 'PE-199', 'Muhoroni Sugar Company', 'PET-5', '047', 'MUHORONI SUGAR CO.', '2 MUHORONI', '', '', '', '', 'john.odhiambo@musco.co.ke', NULL, 'www.musco.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(612, 'PE-200', 'Kenya Utalii College', 'PET-5', '047', 'THIKA ROAD', '31052-00600 NAIROBI', '', 'Nairobi', '', '', 'msndungu@utalii.ac.ke', NULL, 'www.utalii.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(613, 'PE-201', 'State Department of Immigration, Border Control and citizen Services', 'PET-4', '047', '  Nyayo House Nairobi', '30395-00100', '', '', '', '', 'kiptuic@gmail.com', NULL, 'www.immigration.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(614, 'PE-202', 'University of Kabianga', 'PET-6', '047', ' Kericho', '2030-20200', '', '', '', '', 'ckisato@kabianga.ac.ke', NULL, 'www.kabianga.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(615, 'PE-203', 'County Assembly of Laikipia', 'PET-7', '047', 'KENYATTA HIGHWAY', '487-10400', '', '', '', '', 'jngethe@laikipiaassembly.go.ke', NULL, 'http://laikipiaassembly.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(616, 'PE-204', 'Coast Water Services Board', 'PET-5', '047', 'Mikindani Street, Off Nkurumah Road, Mombasa', '090417-80100, Mombasa', '', '', '', '', 'salim@cwsb.go.ke', NULL, 'www.cwsb.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(617, 'PE-205', 'The Meru National Polytechnic', 'PET-13', '047', 'Meru', '111 - 60200', '', '', '', '', 'imutwiri54@gmail.com', NULL, 'WWW.MERUNATIONALPOLYTECHNIC.AC.KE', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(618, 'PE-206', 'Kenya Law Reform Commission', 'PET-5', '047', 'Reinsurance Plaza Nairobi', '34999 - 00100', '', '', '', '', 'jamesruteere@klrc.go.ke', NULL, 'www.klrc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(619, 'PE-207', 'Kenya Bureau of Standards', 'PET-5', '047', ' Popo Road, off Belle Vue South C', '54974 - 00200 Nairobi', '', 'Nairobi', '', '', 'mwakithij@kebs.org', NULL, 'www.kebs.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(620, 'PE-208', 'Office of the Auditor General', 'PET-10', '047', '334', '30084', '', '', '', '', 'isaac.ayoyi@oagkenya.go.ke', NULL, 'www.oagkenya.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(621, 'PE-209', 'Kenya Urban Roads Authority', 'PET-5', '047', 'IKM Place, 5th Ngong Avenue', '41727 - 00100 Nairobi', '', 'Nairobi', '', '', 'lmwiti@kura.go.ke', NULL, 'www.kura.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(622, 'PE-210', 'Kitui', 'PET-8', '047', 'Tanathi Water Service Board Building', 'P. 0. Box 33 - 90200, Kitui', '', '', '', '', 'smususya@yahoo.com', NULL, 'www.kitui.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(623, 'PE-211', 'Ministry of Water and Sanitation', 'PET-2', '047', '49720', '100', '', '', '', '', 'mutinvero@gmail.com', NULL, 'www.water.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(624, 'PE-212', 'Kibabii University', 'PET-6', '047', 'Bungoma', '1699-50200', '', '', '', '', 'jamesoo@kibu.ac.ke', NULL, 'www.kibu.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(625, 'PE-213', 'Kenya Dairy Board', 'PET-5', '047', 'Nairobi', '30406 - 00100', '', '', '', '', 'kebuka.joshua@kdb.co.ke', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(626, 'PE-214', 'Alupe University', 'PET-6', '047', ' Busia Malaba Road', '845-50400', '', '', '', '', 'kogola222@gmail.com', NULL, 'www.auc.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(627, 'PE-215', 'Nandi', 'PET-8', '047', ' Nandi County Government Building-Kapsabet', '802', '', '', '', '', 'isidore.koech@nandi.go.ke', NULL, 'www.nandi.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(628, 'PE-216', 'Independent Policing Oversight Authority', 'PET-5', '047', 'ACK Garden Annex 3rd Floor, 1st Ngong Avenue.', '23035 - 00100 Nairobi', '', 'Nairobi', '', '', 'info@ipoa.go.ke', NULL, 'www.ipoa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(629, 'PE-217', 'Nyandarua', 'PET-8', '047', 'Olkalou', '701 - 20303', '', '', '', '', 'info@nyandaruacounty.or.ke', NULL, 'www.nyandarua.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(630, 'PE-218', 'Commission of Administrative Justice - Office of the Ombudsman', 'PET-10', '047', 'WEST END TOWERS 2ND FLOOR ON WAIYAKI WAY ', '20414', '', '', '', '', 'info@ombudsman.go.ke', NULL, 'www.ombudsman.go.ke  ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(631, 'PE-219', 'Anti - Doping Agency of Kenya', 'PET-5', '047', '    6th Floor Parklands Plaza ,Muthithi/Chiromo Lane Junction', '2276', '', '', '', '', 'nemwelarama@gmail.com', NULL, 'www.adak.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(632, 'PE-220', 'Public Service', 'PET-4', '047', 'Nairobi-Teleposta Towers', 'P.O Box 30050-00100', '', 'Nairobi', '', '', 'info@psyg.go.ke', NULL, 'www.psyg.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(633, 'PE-221', 'County Assembly Of Muranga', 'PET-7', '047', 'opposite ihura stadium', '731-10200', '', '', '', '', 'murangacountyassembly@gmail.com', NULL, 'www.assembly.muranga.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(634, 'PE-222', 'Embu', 'PET-8', '047', 'EMBU TOWN', '36 - 60100', '', '', '', '', 'info@embu.go.ke, procurement@embu.go.ke', NULL, 'www.embu.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(635, 'PE-223', 'Huduma Kenya Secretariat', 'PET-4', '047', 'Lonrho House Standard ', '47716 - 00100', '', '', '', '', 'info@hudumakenya.go.ke', NULL, 'www.hudumakenya.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(636, 'PE-224', 'Masinde Muliro University of Science and Technology (MMUST)', 'PET-6', '047', 'KAKAMEGA WEBUYE ROAD', 'P.O Box 190 - 50100, KAKAMEGA', '', '', '', '', 'vc@mmust.ac.ke', NULL, 'www.mmust.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(637, 'PE-225', 'Energy', 'PET-4', '047', '0', '0', '', '', '', '', 'ps@energymin.go.ke', NULL, 'ps@energymin.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(638, 'PE-226', 'Health', 'PET-4', '047', 'AFYA HOUSE, CATHEDRAL ROAD', '30016-00100 Nairobi', '', '', '', '', 'pshealthke@gmail.com', NULL, 'www.health.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(639, 'PE-227', 'Nyamira', 'PET-8', '047', 'NYAMIRA COUNTY HEADQUARTERS', 'P.O BOX 434 - 40500, NYAMIRA', '', '', '', '', 'info@nyamira.go.ke', NULL, 'www.nyamira.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(640, 'PE-228', 'Meru University of Science and Technology', 'PET-6', '047', 'Meru', '972 - 60200 Meru', '', '', '', '', 'jkanake@must.ac.ke', NULL, 'www.must.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(641, 'PE-229', 'Labour', 'PET-4', '047', ' P.O Box', '40326 - 00100', '', '', '', '', 'engugi2002@gmail.com', NULL, 'www.laboursp.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(642, 'PE-230', 'Transport', 'PET-4', '047', '   TRANSCOM HOUSE', '52592 00100', '', '', '', '', 'crisauko@gmail.com', NULL, 'www.transport.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(643, 'PE-231', 'Kenya Broadcasting Corporation', 'PET-5', '047', 'BROADCASTING HOUSE,HARRY THUKU ROAD', '30456-00100', '', '', '', '', 'md@kbc.co.ke', NULL, 'www.website.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(644, 'PE-232', 'Turkana', 'PET-8', '047', ' Lodwar,Kenya', 'P O Box 11-30500 Lodwar ', '', '', '', '', 'supplychainoffice@turkana.go.ke', NULL, 'www.turkana.go.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(645, 'PE-233', 'Kenya Civil Aviation Authority', 'PET-5', '047', 'Jomo Kenyatta International Airport', '30163 - 00100 Nairobi', '', '', '', '', 'procurement@kcaa.or.ke, info@kcaa.or.ke', NULL, 'www.kcaa.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(646, 'PE-234', 'Bungoma', 'PET-8', '047', 'Former Municipal Building ', 'P.o Box 437-50200 Bungoma', '', '', '', '', 'info@bungoma.go.ke', NULL, 'www.bungoma.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(647, 'PE-235', 'Nyeri', 'PET-8', '047', 'Governor\'s Office, Kimathi Way, Nyeri', '1112', '', '', '', '', 'procurement@nyeri.go.ke', NULL, 'www.nyeri.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(648, 'PE-236', 'Uasin Gishu', 'PET-8', '047', 'Uasin Gishu County Hall', 'P. O. Box  40 - 30100 Eldoret', '', '', '', '', 'cecfinance@uasingishu.go.ke', NULL, 'www.uasingishu.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(649, 'PE-237', 'Machakos', 'PET-8', '047', 'Ngei Road', '1996 - 90100', '', '', '', '', 'jnzambu@gmail.com', NULL, 'www.machakosgovernment.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(650, 'PE-238', 'National Social Security Fund', 'PET-5', '047', ' Social Security Hse, Block C, Bishops Rd, Ground Flr ', 'P.O. Box 45969 ??? 00100, Nairobi', '', 'Nairobi', '', '', 'shair.u@nssfkenya.co.ke', NULL, 'www.nssf.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(651, 'PE-239', 'Early Learning & Basic Education', 'PET-4', '047', '   P.O Box 40530 - 00100 Nairobi ', 'P.O Box 40530 - 00100 Nairobi ', '', 'Nairobi', '', '', 'nyamburafrancesca@gmail.com', NULL, 'x', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(652, 'PE-240', 'National Assembly ', 'PET-10', '047', '  clerks Chambers', 'P.O Box 41842 -00100 Nairobi', '', 'Nairobi', '', '', 'Josephantonynjagi@gmail.com', NULL, 'www.parliament.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(653, 'PE-241', 'IDB Capital', 'PET-5', '047', '18th Floor, National Bank Building, Harambee Avenue', 'P. O. Box 44036, 00100', '', '', '', '', 'bizcare@idbkenya.com', NULL, 'www.idbkenya.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(654, 'PE-242', 'Kenya Law', 'PET-5', '047', '1ST NGONG, AVENUE.', 'P.O BOX 10443-00100, NAIROBI.', '', 'Nairobi', '', '', 'info@kenyalaw.org', NULL, 'www.kenyalaw.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(655, 'PE-243', 'County Assembly Of Kitui', 'PET-7', '047', 'Kitui County Assembly', 'P. O. Box 694 - 90200, Kitui', '', '', '', '', 'kutuiassembly@gmail.com', NULL, 'http://www.kituicountyassembly.org/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(656, 'PE-244', 'Kenya Institute of Special Education', 'PET-5', '047', 'Kasarani', 'P.O BOX 48413-00100', '', 'Nairobi', '', '', 'info@kise.ac.ke', NULL, 'www.kise.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(657, 'PE-245', 'State Department for Fisheries, Aquaculture and the Blue Economy', 'PET-4', '047', 'KILIMO HOUSE', '58187-00200 NAIROBI', '', 'Nairobi', '', '', 'psfisheries@kilimo.go.ke', NULL, 'www.kilimo.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(658, 'PE-246', 'Social Protection, Pensions & Senior Citizens Affairs', 'PET-4', '047', ' UPPER HILL, NSSF BUILDING, BLOCK A, EASTERN WING, 1ST, 2ND, 4TH, 5TH, 6TH,7TH,8TH,13TH, 14TH, AND W', '46205-00100, NAIROBI', '', 'Nairobi', '', '', 'James.Ngogu@socialprotection.go.ke/pssocialsecurity@labour.go.ke', NULL, 'www.laboursp.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(659, 'PE-247', 'Kilifi', 'PET-8', '047', 'Kilifi- Town', '519-80108', '', '', '', '', 'info@kilifi.go.ke', NULL, 'www.kilifi.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(660, 'PE-248', 'Mandera', 'PET-8', '047', 'Mandera Town', '13-70300', '', '', '', '', 'supplychain@mandera.go.ke', NULL, 'www.mandera.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(661, 'PE-249', 'County Assembly Of Isiolo', 'PET-7', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(662, 'PE-250', 'County Assembly Of Mandera', 'PET-7', '047', 'Mandera East', '0', '', '', '', '', 'info@manderaassembly.go.ke', NULL, 'www.manderaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(663, 'PE-251', 'County Assembly Of Garissa', 'PET-7', '047', 'Garissa Township', '57-70100, Garissa', '', '', '', '', 'iyussuf@garissaassembly.go.ke', NULL, 'www.garisaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(664, 'PE-252', 'Nairobi', 'PET-8', '047', 'City Hall', 'P.O Box 30075 - 00100', '', 'Nairobi', '', '', 'wambugubety7@gmail.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(665, 'PE-253', 'The Kenyatta International Convention Centre', 'PET-5', '047', 'Harambee Avenue Nairobi', '30746 - 00100 Nairobi', '', 'Nairobi', '', '', 'judith.nyaberi@kicc.co.ke', NULL, 'www.kicc.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(666, 'PE-254', 'Michuki Technical Training Institute', 'PET-13', '047', 'Kangema', 'P.O Box 4 - 10202', '', '', '', '', 'michukitech@yahoo.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(667, 'PE-255', 'Tharaka-Nithi', 'PET-8', '047', 'Kathwana', '10', '', '', '', '', 'info@tharakanithi.go.ke', NULL, 'https://tharakanithi.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(668, 'PE-256', 'Trans Nzoia', 'PET-8', '047', 'KITALE', 'P.O BOX 4211 - 30200 KITALE', '', '', '', '', 'info@transnzoia.go.ke', NULL, 'https://www.transnzoia.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(669, 'PE-257', 'West Pokot', 'PET-8', '047', 'Kapenguria.', '220-30600', '', '', '', '', 'info@westpokot.go.ke', NULL, 'www.westpokot.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(670, 'PE-258', 'National Environment Management Authority', 'PET-5', '047', 'Popo Road Nairobi', 'P. O. Box 67839 -00200', '', '', '', '', 'dgnema@nema.go.ke', NULL, 'www.nema.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(671, 'PE-259', 'State Department for Culture & Heritage', 'PET-4', '047', 'kencom house', '49849-90100', '', '', '', '', 'psoffice@minspoca.go.ke', NULL, 'www.minspoca.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(672, 'PE-260', 'Council of Legal Education', 'PET-5', '047', 'Karen office Park, Acacia Block 2 Floor', '829-00502, Karen', '', '', '', '', 'jkirande@cle.or.ke', NULL, 'cle.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(673, 'PE-261', 'Rongo University', 'PET-6', '047', 'Rongo-Migori road, Kitere hills off Kanga junction', '103-40404 RONGO', '', '', '', '', 'procurement@rongovarsity.ac.ke', NULL, 'www.rongovarsity.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(674, 'PE-262', 'County Assembly Of Lamu', 'PET-7', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(675, 'PE-263', 'Kitui East Constituency Development Fund', 'PET-17', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(676, 'PE-264', 'State Department for University Education', 'PET-4', '047', 'Jogoo House `B` , Harambee Avenue in Nairobi. ', ' P.O. Box 30040-00100, Nairobi ', '', 'Nairobi', '', '', 'petupazuri@yahoo.com', NULL, 'http://www.education.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(677, 'PE-265', 'Office of the Registrar of Political Parties', 'PET-10', '047', 'Lion Place 1st Floor, Sarit Centre Nairobi', '1131-00606', '', '', '', '', 'registrar@orpp.or.ke', NULL, 'orpp.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(678, 'PE-266', 'County Assembly Of Kakamega', 'PET-7', '047', 'Off Fitina Road behind Kakamega Law Courts', '1470 - 50100 KAKAMEGA', '', '', '', '', 'kakamegacountyassembly@gmail.com', NULL, 'www.kakamega-assembly.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(679, 'PE-267', 'Central Bank of Kenya', 'PET-5', '047', 'Haile Selassie Avenue', '6000-00200', '', '', '', '', 'Comms@centralbank.go.ke', NULL, 'www.centralbank.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(680, 'PE-268', 'Karatina University', 'PET-6', '047', 'Karatina', 'P. O Box 1957 -10101', '', '', '', '', 'awanjiru@karu.ac.ke', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(681, 'PE-269', 'Kenya Electricity Transmission Company LTD', 'PET-5', '047', 'KAWI HOUSE, BLOCK B', '34942 - 00100', '', '', '', '', 'info@ketraco.co.ke', NULL, 'https://www.ketraco.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(682, 'PE-270', 'Kiambu', 'PET-8', '047', 'KIAMBU', '2344,KIAMBU', '', '', '', '', 'info@kiambu.go.ke', NULL, 'http://kiambu.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(683, 'PE-271', 'Kaimosi Friends University College (MMUST)', 'PET-6', '047', 'KAIMOSI', 'P.o Box 385 - 50309', '', '', '', '', 'jrapando@kafuco.ac.ke', NULL, 'www.kafuco.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(684, 'PE-272', 'Kericho', 'PET-8', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(685, 'PE-273', 'Indepedent Electoral and Boundaries Commission', 'PET-10', '047', 'Anniversary Towers', '45371-00100', '', '', '', '', 'info@iebc.or.ke', NULL, 'www.iebc.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(686, 'PE-274', 'National Authority for the Campaign Against Alcohol and Drug Abuse', 'PET-5', '047', 'NSSFBuiding  Block "A",Eastern Wing  18th  Floor ', '10774-00100', '', '', '', '', 'info@nacada.go.ke ', NULL, 'www.nacada.go.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(687, 'PE-275', 'Vocational & Technical Training', 'PET-4', '047', 'Jogoo B, Harambee Avenue', 'P.O. Box 9583 - 00200', '', '', '', '', 'psvtt@education.go.ke', NULL, 'www.education.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(688, 'PE-276', 'Crop Development', 'PET-4', '047', 'cathedral road', 'P.O Box 34188-00100 Nairobi', '', 'Nairobi', '', '', 'psagriculture@kilimo.go.ke', NULL, 'www.kilimo.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(689, 'PE-277', 'Kenya Medical training College', 'PET-13', '047', 'Off Mbagathi Road', '30195-00100 NAIROBI', '', 'Nairobi', '', '', 'info@kmtc.ac.ke', NULL, 'www.kmtc.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(690, 'PE-278', 'Agro-Chemical and Food Company Limited', 'PET-5', '047', '   Muhoroni', 'P.O Box 18 - 40107', '', '', '', '', 'wkarani@acfc.co.ke', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(691, 'PE-279', 'Garissa', 'PET-8', '047', 'sherrif Apartment', '563-70100', '', '', '', '', 'enquiries@garissa.go.ke', NULL, 'www.garissa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(692, 'PE-280', 'State Department for Housing, Urban Development & Public Works', 'PET-4', '047', 'Works building ', '30743-00100 Nairobi', '', '', '', '', 'info@publicworks.go.ke', NULL, 'www.transport.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(693, 'PE-281', 'Kenya Nuclear Electricity Board', 'PET-5', '047', 'Kawi complex ', '26374', '', '', '', '', 'mmwangi@nuclear.co.ke', NULL, 'www.nuclear.co.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(694, 'PE-282', 'Tourism Research Institute', 'PET-5', '047', 'UTALII HOUSE 7TH FLOOR ROOM 732', 'P.O.BOX 42131-00100 NAIROBI', '', '', '', '', 'ceo@tri.go.ke', NULL, 'N/A', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(695, 'PE-283', 'Kitui NGAAF', 'PET-18', '047', 'Nzambaani Park Building, Kitui', 'P. O. Box 1-90200, Kitui, ', '', '', '', '', 'denniskitheka@gmail.com', NULL, 'http://www.ngaaf.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(696, 'PE-284', 'Chemelil Sugar Company Limited', 'PET-5', '047', 'csc@chemsugar.co.ke', 'Along Awasi/Nandi Hills Road, Kisumu County', '', '', '', '', '  GSM Lines: 0722 209798, 0710 766383, 0735 234733', NULL, '359_logo_image.jpg', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(697, 'PE-285', 'Lake Victoria North Water services Board', 'PET-5', '047', 'Kefinco Hse, off Kakamega-Kisumu Road', 'P.O Box 673 - 50100 Kakamega', '', '', '', '', 'info@lvnwsb.go.ke', NULL, 'http://www.lvnwsb.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(698, 'PE-286', 'Kajiado', 'PET-8', '047', 'Off Nairobi - Namanga Road', 'P O Box 11-001100 Kajiado', '', '', '', '', 'info@kajiado.go.ke', NULL, 'www.kajiado.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(699, 'PE-287', 'Netfund', 'PET-5', '047', 'National Water Plaza, 1st Floor, Dunga road, Industrial Area', '19324-00202', '', '', '', '', 'info@netfund.go.ke', NULL, 'www.netfund.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(700, 'PE-288', 'Kwale', 'PET-8', '047', 'KWALE', '4-80403', '', '', '', '', 'madonna@procurement.kwale.go.ke', NULL, 'http://www.kwalecountygov.com/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(701, 'PE-289', 'National Police Service Commission', 'PET-10', '047', 'westlands,Nairobi', '47363', '', '', '', '', 'info@npsc.go.ke', NULL, 'www.npsc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(702, 'PE-290', 'County Assembly Of Siaya', 'PET-7', '047', 'Siaya County Headquarters', 'P.O.BOX 7-40600 SIAYA', '', '', '', '', 'clerk@siayaassembly.go.ke', NULL, 'www.siayaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(703, 'PE-291', 'Kwale Water and Sewerage Company Ltd', 'PET-11', '047', '  Likoni Kwale road off-SIDA road,Kwale', 'Box 18-80403', '', '', '', '', 'info@kwalewater.co.ke', NULL, 'www.kwalewater.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(704, 'PE-292', 'Kengen Staff Retirement Benefits Scheme', 'PET-16', '047', 'KenGen Pension Plaza 2, 11th Floor, Kolobot Road, Nairobi', '47936 - 00100', '', '', '', '', 'info@kengensrbs.co.ke ', NULL, 'www.kengensrbs.co.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(705, 'PE-293', 'Kenya Leather Development Council', 'PET-5', '047', ' CPA Centre, 5th Floor, Thika Road, Nairobi', '14480-00800 NRB', '', '', '', '', 'info@leathercouncil.go.ke', NULL, 'www.leathercouncil.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(706, 'PE-294', 'Jomo Kenyatta University of Agriculture and Technology (JKUAT)', 'PET-6', '047', 'Juja Kiambu County', 'Box 62000-00200', '', '', '', '', 'rkiprop@jkuat.ac.ke', NULL, 'http://www.jkuat.ac.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(707, 'PE-295', 'Maasai Mara University', 'PET-6', '047', 'Narok - Bomet Road', 'Box 861, Narok', '', '', '', '', 'procurement@mmarau.ac.ke', NULL, 'www.mmarau.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(708, 'PE-296', 'Kenya National Library Service', 'PET-5', '047', 'Mumias Road/Ol Donyo Sabuk Road Junction, Buruburu', '30573-00100', '', '', '', '', 'edel.ratemo@knls.ac.ke', NULL, 'www.knls.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(709, 'PE-297', 'Ethics and Anti-Corruption Commission', 'PET-10', '047', '2100312/3 Mobile: 0729888881/2/3\\', ' 0736996600/33', '', '', '', '', '2720722\\', NULL, '+254 729888881', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(710, 'PE-298', 'Tom Mboya University College (Maseno)', 'PET-6', '047', 'HOMABAY COUNTY-NEXT TO THE GOVERNOR OFFICE ', '199-40300 HOMABAY', '', '', '', '', 'principal@tmuc.ac.ke', NULL, 'https://www.tmuc.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(711, 'PE-299', 'Taita-Taveta', 'PET-8', '047', 'wundanyi', '1066-80304', '', '', '', '', 'governortaitatavet@yahoo.com', NULL, 'www.taitataveta.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(712, 'PE-300', 'South Eastern Kenya University ', 'PET-6', '047', 'Machakos, Kitui rd, off Kwa Vonza', 'P.O. Box 170 - 90200, Kitui', '', '', '', '', 'vc@seku.ac.ke', NULL, 'www.seku.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(713, 'PE-301', 'Lake Basin Development Authority', 'PET-5', '047', 'Off Kisumu Kakamega Road', 'PO Box 1516 - 40100 Kisumu', '', '', '', '', 'info@lbda.co.ke', NULL, 'www.lbda.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(714, 'PE-302', 'Busia', 'PET-8', '047', '0', 'PRIVATE BAG', '', '', '', '', '', NULL, 'busiacounty.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(715, 'PE-303', 'Wajir', 'PET-8', '047', 'wajir', 'po.box 9-70200', '', '', '', '', 'info@wajir.go.ke', NULL, 'www.wajir.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(716, 'PE-304', 'Technical University of Mombasa', 'PET-6', '047', 'Mombasa', '90420-80100', '', '', '', '', 'supplies@tum.ac.ke', NULL, 'Web: www.tum.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(717, 'PE-305', 'Centre for Mathematics, Science and Technology Education in Africa', 'PET-5', '047', 'Karen Road - Bogani Road Junction', 'P. O. Box 24214, 00502', '', '', '', '', 'director@cemastea.ac.ke', NULL, 'www.cemastea.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(718, 'PE-306', 'Kenya Reinsurance Corporation Ltd', 'PET-5', '047', 'Reinsurance Plaza', 'P. O. Box 30271, 00100', '', '', '', '', 'kenyare@kenyare.co.ke', NULL, 'https://www.kenyare.co.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(719, 'PE-307', 'Tourism', 'PET-4', '047', 'Utalii House', 'P. O. Box 30027, 00100 Nairobi', '', 'Nairobi', '', '', 'ps@tourism.go.ke', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(720, 'PE-308', 'Thogoto Teachers Training College', 'PET-13', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(721, 'PE-309', 'Malindi Water & Sewerage Co. LTD', 'PET-15', '047', 'Malindi opposite Kilifi County Assembly', '410-80200 MALINDI', '', '', '', '', 'info@malindiwater.co.ke', NULL, 'www.malindiwater.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(722, 'PE-310', 'Kenya Investment Authority ', 'PET-5', '047', '0', '0', '', '', '', '', '', NULL, 'www.invest.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(723, 'PE-311', 'OFFICE OF THE CONTROLLER OF BUDGET', 'PET-10', '047', ' Bima House', '35616 -00100', '', '', '', '', 'lusulial@cob.go.ke', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(724, 'PE-312', 'Kenya Veterinary Board', 'PET-5', '047', 'Veterinary Research Laboratories, Upper Kabete', '513-00605 Uthiru', '', '', '', '', 'info@kenyavetboard.or.ke', NULL, 'http://kenyavetboard.or.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(725, 'PE-313', 'Makueni', 'PET-8', '047', 'Makueni', '78- 90300', '', '', '', '', 'mail@makueni.go.ke', NULL, 'www.makueni.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(726, 'PE-314', 'County Assembly of Kirinyaga', 'PET-7', '047', 'kerugoya', '55-10300', '', '', '', '', 'kirinyagacountyassembly@gmail.com', NULL, 'kirinyagaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(727, 'PE-315', 'Women Enterprise Fund', 'PET-5', '047', 'NSSF BUILDING, EASTERN WING , BLOCK A', '017126-00100', '', '', '', '', 'info@wef.co.ke', NULL, 'www.wef.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(728, 'PE-316', 'Ayora Mixed Secondary School', 'PET-9', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(729, 'PE-317', 'Nairobi City Water & Sewerage Company LTD', 'PET-11', '047', 'Nairobi', '30656-00100', '', '', '', '', 'tenders@nairobiwater.co.ke', NULL, 'www.nairobiwater.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(730, 'PE-318', 'Rift Valley Water Services Board', 'PET-5', '047', 'Maji Plaza, Prisons Road, Off Eldama Ravine Nakuru Road', '2451 Nakuru', '', '', '', '', 'wsakuda@rvwsb.go.ke', NULL, 'www.rvwsb.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(731, 'PE-319', 'Teachers Service Commission', 'PET-10', '047', 'TSC House, Upper Hill', 'TSC Private Bag, Nairobi, 00100', '', 'Nairobi', '', '', 'kabubii2030@gmail.com', NULL, 'www.tsc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(732, 'PE-320', 'National Gender and Equality Comission', 'PET-10', '047', 'SOLUTION TECH BUILDING', '27512-00506', '', '', '', '', 'info@ngeckenya.org', NULL, 'www.ngeckenya.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(733, 'PE-321', 'Rural Electrification Authority', 'PET-5', '047', 'kawi House South C', '34585-00100', '', '', '', '', 'info@rea.co.ke', NULL, 'www.rea.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(734, 'PE-322', 'Murang???a University of Technology', 'PET-6', '047', '10200', '75', '', '', '', '', 'procurement@mut.ac.ke', NULL, 'www.mut.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(735, 'PE-323', 'Kenya National Shipping Line Ltd.', 'PET-5', '047', 'New Cannon tower 1st floor, Moi Avenue  ', '88206 - 80100, Mombasa', '', '', '', '', 'admin@knsl.co.ke', NULL, 'www.knsl.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(736, 'PE-324', 'County Assembly Of Nyeri', 'PET-7', '047', 'RURINGU-NYERI', 'P.O BOX 162 -10100 NYERI', '', '', '', '', 'nyeriassembly.go.ke', NULL, 'www.nyeriassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(737, 'PE-325', 'Local Authorities Provident Fund (LAPFUND)', 'PET-5', '047', 'JKUAT Towers, Kenyatta Avenue', '79592-00200 Nairobi', '', 'Nairobi', '', '', 'ymutinda@lapfund.or.ke', NULL, 'www.lapfund.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(738, 'PE-326', 'Tanathi Water Services Board', 'PET-5', '047', '0', '0', '', '', '', '', '', NULL, 'www.tanathi.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(739, 'PE-327', 'Kilifi Mariakani Water and Sewerage Company Limited', 'PET-11', '047', 'Off Malindi Road at former KDDP Office - Kilifi town', '275-80108 Kilifi', '', '', '', '', 'info@kilifiwater.co.ke', NULL, 'www.kilifiwater.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(740, 'PE-328', 'NGOs Co-ordination Board', 'PET-5', '047', 'Co-operative Bank House 15th floor', '44617', '', '', '', '', 'info@ngobureau.or.ke', NULL, 'www.ngobureau.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(741, 'PE-329', 'National Land Commission', 'PET-10', '047', 'ARDHI HOUSE-1ST AVENUE,NGONG AVENUE', 'P.O BOX 44417-00100,NAIROBI', '', 'Nairobi', '', '', 'info@landcommission.go.ke', NULL, 'www.landcommission.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(742, 'PE-330', ' National Crime Research Centre', 'PET-5', '047', ' ACK Garden Annex- Ground Floor  1st Ngong Avenue, Off Bishop\'s Road  ', 'P .0. BOX 21180-00100 ', '', '', '', '', 'director@crimeresearch.qo.ke', NULL, 'www.crimeresearch.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(743, 'PE-331', 'County Assembly Of Homa Bay', 'PET-7', '047', 'Homabay Town', '20-40300', '', '', '', '', 'tokore@homabayassembly.go.ke', NULL, 'www.homabayassembly.go.ke  ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(744, 'PE-332', 'Kenya Institute of Supplies Mangement', 'PET-5', '047', 'Nation Centre', '30400-00100', '', '', '', '', 'admin@kism.or.ke ', NULL, 'www.kism.or.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(745, 'PE-333', 'Kenya National Commission on Human Rights', 'PET-10', '047', 'CVS PLAZA - LENANA RD/KASUKU LANE', '74359-00200', '', '', '', '', 'haki@knchr.org ', NULL, 'www.knchr.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(746, 'PE-334', 'Nyeri Water & Sewerage Company Limited', 'PET-15', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(747, 'PE-335', 'Nairobi Centre for International Arbitration', 'PET-5', '047', 'Haile Selassie Avenue', '548 - 00200', '', '', '', '', 'info@ncia.or.ke', NULL, 'www.ncia.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(748, 'PE-336', 'County Assembly Of Migori', 'PET-7', '047', 'Migori', 'Box 985-40400 Migori', '', '', '', '', 'stevedawns@gmail.com', NULL, 'www.migoriassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(749, 'PE-337', 'Taita Taveta University ', 'PET-6', '047', 'VOI', '635-80300', '', '', '', '', 'info@ttu.ac.ke', NULL, 'www.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(750, 'PE-338', 'County Assembly Of Uasin Gishu', 'PET-7', '047', 'Uasin Gishu County Assembly, Uganda Road', 'Box 100 - 30100', '', '', '', '', 'schangwony@gmail.com', NULL, 'www.ugcountyassembly.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(751, 'PE-339', 'County Assembly Of Kisii', 'PET-7', '047', 'Kisii Town Hall Building', 'Box 4552-40200 Kisii', '', '', '', '', 'info@kisiiassembly.go.ke', NULL, 'www.kisiiassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(752, 'PE-340', 'Business Registration Service', 'PET-5', '047', 'Sheria House, Harambee Avenue', 'P. O. Box 40112 - 00100', '', '', '', '', 'info.statelawoofice@kenya.go.ke', NULL, 'brs.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(753, 'PE-341', 'County Assembly Of Busia', 'PET-7', '047', 'County Assembly Headquaters Busia town-off Busia Kisumu Road', 'Box 1018-50400 Busia', '', '', '', '', 'yvonnelily89@gmail.com', NULL, 'www.busiaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(754, 'PE-342', 'Cabinet Affairs Office', 'PET-14', '047', 'Harambee House', '62345-00200 Nairobi', '', 'Nairobi', '', '', 'pas@cabinetoffice.go.ke', NULL, 'www.cabinetoffice.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(755, 'PE-343', 'State House', 'PET-14', '047', 'state house road', '40530-00100', '', '', '', '', 'supplychain@president.go.ke', NULL, 'www.president.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(756, 'PE-344', 'Nursing Council of Kenya', 'PET-5', '047', 'Kabarnet Lane, Off Ngong Road', 'Box 20056-00200 Nairobi', '', 'Nairobi', '', '', 'ewanjiku@nckenya.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(757, 'PE-345', 'Nzoia Sugar Company', 'PET-5', '047', 'Bungoma', 'Box 285-50200 BUNGOMA', '', 'Nairobi', '', '', 'amusonye@nzoiasugar.com', NULL, 'www.nzoiasugar.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(758, 'PE-346', 'Post Training & Skills Development', 'PET-4', '047', 'Jogoo House B', 'Box 30040-00200 Nairobi', '', 'Nairobi', '', '', 'bluyera@yahoo.com', NULL, 'www.education.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(759, 'PE-347', 'Office of the Deputy President', 'PET-14', '047', 'Harambee House Annexe', 'Box 74434-00200 Nairobi', '', 'Nairobi', '', '', 'dp@deputypresident.go.ke', NULL, 'www.dp@deputypresident.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(760, 'PE-348', 'County Assembly Of Nairobi', 'PET-7', '047', 'City Hall Buildings', 'Box 45844-00100 Nairobi', '', 'Nairobi', '', '', 'daisymuema@nairobiassembly.go.ke', NULL, 'www.nairobiassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(761, 'PE-349', 'Pwani University', 'PET-6', '047', 'Kilifi , Kenya', 'Box 195-80108 Kilifi, Kenya', '', '', '', '', 'l.mwacharo@pu.ac.ke', NULL, 'www.pu.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(762, 'PE-350', 'Bomet University College', 'PET-6', '047', 'Bomet', 'Box 701-20400', '', '', '', '', 'kipsaiya@buc.ac.ke', NULL, 'www.buc.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(763, 'PE-351', 'Chuka University', 'PET-6', '047', 'CHUKA', '109', '', '', '', '', '', NULL, 'www.chuka.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(764, 'PE-352', 'Pyrethrum Processing Company of Kenya Limited', 'PET-5', '047', 'General Mathenge Road,Industrial area Nakuru', '420-20100,Nakuru', '', '', '', '', 'md@pyrethrum.co.ke ', NULL, 'www.kenyapyrethrum.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(765, 'PE-353', 'Pharmacy and Poisons Board', 'PET-5', '047', 'Lenana Road, Nairobi', 'P.O. Box 27663-00506, Nairobi', '', 'Nairobi', '', '', 'procurement@pharmacyboardkenya.org', NULL, 'www.pharmacyboardkenya.org', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(766, 'PE-354', 'Kenya Medical Practitioners and Dentists Board', 'PET-5', '047', 'Woodlands Avenue of Lenana Road', 'P.O. BOX 44839 00100 NAIROBI', '', 'Nairobi', '', '', 'info@kenyamedicalboard.or.ge', NULL, 'www.medicalboard.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(767, 'PE-355', 'Financial Reporting Centre', 'PET-5', '047', 'CBK Pension Fund Building', 'Box Private Bag 00200, Nairobi', '', 'Nairobi', '', '', 'georgenjane65@gmail.com', NULL, 'www.frc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(768, 'PE-356', 'Maseno University', 'PET-6', '047', 'Kisumu-Busia Road', 'Private Bag Maseno', '', '', '', '', 'po@maseno.ac.ke /vc@maseno.ac.ke', NULL, 'www.maseno.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(769, 'PE-357', 'Judicial Service Commission', 'PET-10', '047', 'Reinsurance Plaza', 'Box 40048-00100 Nairobi', '', 'Nairobi', '', '', 'mirriam.musyimi@jsc.go.ke', NULL, 'www.jsc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(770, 'PE-358', 'Lamu', 'PET-8', '047', 'MOKOWE', '74-80500', '', '', '', '', 'info@lamu.go.ke', NULL, 'www.lamu.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(771, 'PE-359', 'National Cereals and Produce Board', 'PET-5', '047', 'Machakos/Enterprise Road', 'Box 30586-00100 Nairobi', '', '', '', '', 'nwaswa@ncpb.co.ke', NULL, 'www.ncpb.co.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(772, 'PE-360', 'Media Council of Kenya', 'PET-5', '047', 'Ground Floor, Britam Centre, Mara/Ragati Road Junction, Upperhill', '43132-00100', '', '', '', '', 'info@mediacouncil.or.ke', NULL, 'www.mediacouncil.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(773, 'PE-361', 'County Assembly Of Tharaka-Nithi', 'PET-7', '047', 'Chuka', 'Box 694 Chuka', '', '', '', '', 'enirichu@gmail.com', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(774, 'PE-362', 'Kisii', 'PET-8', '047', 'Treasury Building', 'P.O. Box 4550 - 40200 Kisii', '', '', '', '', 'procurement@kisii.go.ke', NULL, 'www.kisii.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(775, 'PE-363', 'Bukura Agricultural College', 'PET-13', '047', 'Sigalagala - Butere Road', 'Box 23-50105 Bukura', '', '', '', '', 'bcheptiony@bukuracollege.ac.ke', NULL, 'www.bukuracollege.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(776, 'PE-364', 'Laikipia', 'PET-8', '047', 'Nanyuki', '1271/10400', '', '', '', '', 'laikipia county government', NULL, 'www.laikipia.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(777, 'PE-365', 'Kenya Safari Lodges & Hotels LTD', 'PET-5', '047', 'Mombasa', '90414-80100', '', '', '', '', 'mombasabeachhotel@kenya-safari.co.ke', NULL, 'www.safari-hotels.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(778, 'PE-366', 'Kenya Coast National Polytechnic', 'PET-13', '047', 'KISAUNI ROAD,MOMBASA', '81220-80100', '', '', '', '', 'info@kenyacoastpoly.ac.ke', NULL, 'www.kenyacoastpoly.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(779, 'PE-367', 'Wote Technical Training Institute', 'PET-13', '047', 'Makueni', 'P. o. Box 377, 90300 Makueni', '', '', '', '', 'wotettimakueni@gmail.com', NULL, 'www.wotetti.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(780, 'PE-368', 'Rift Valley Technical Training Institute', 'PET-13', '047', 'Eldoret', 'P.O.Box 244 - 30100, Eldoret', '', '', '', '', 'info@rvti.ac.ke', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(781, 'PE-369', 'County Assembly Of Turkana', 'PET-7', '047', 'Lodwar Town', '25 - 30500 LODWAR', '', '', '', '', 'info@turkanaassembly.go.ke', NULL, 'www.turkanaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(782, 'PE-370', 'County Assembly Of Trans Nzoia', 'PET-7', '047', 'KITALE', 'P.O Box 4221', '', '', '', '', 'transnzoiacountyassembly@gmail.com', NULL, 'www.transnzoiaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(783, 'PE-371', 'Vihiga', 'PET-8', '047', 'The Treasury, Maragoli', 'P. O. Box 344 - 50300', '', '', '', '', 'vihigatreasury@yahoo.com', NULL, 'www.vihiga.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(784, 'PE-372', 'County Assembly Of Vihiga', 'PET-7', '047', 'Clerks Chambers, Assembly Headquarters, Maragoli', 'P.O. Box 90 - 50300, Maragoli', '', '', '', '', 'vihigaassembly@gmail.com', NULL, 'www.vihigacountyassembly.or.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(785, 'PE-373', 'Tourism Finance Corporation', 'PET-5', '047', 'nairobi', '42013-00100', '', '', '', '', 'md@tourismfinance.go.ke', NULL, 'www.tourismfinance.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(786, 'PE-374', 'County Assembly Of Bungoma', 'PET-7', '047', 'Bungoma Town opposite Shariffs Centre', '1886-50200', '', '', '', '', 'info@bungomaassembly.go.ke', NULL, 'www.bungomaassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(787, 'PE-375', 'County Assembly Of Makueni', 'PET-7', '047', 'wote makindu road', '0572-90300', '', '', '', '', 'info@makueniassembly.go.ke', NULL, 'www.makueniassebly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(788, 'PE-376', 'Nyandarua Institute of Science and Technology', 'PET-13', '047', 'Nyahururu', '2033-20300 Nyahururu', '', '', '', '', 'nyandaruainstitute2006@gmail.com', NULL, 'www.nyandaruainstitute.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(789, 'PE-377', 'Correctional Services', 'PET-4', '047', 'Telposta Towers', 'Box 30478-00100 NAIROBI', '', 'Nairobi', '', '', 'ps@coordination.go.ke', NULL, 'www.coordination.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(790, 'PE-378', 'National Communication Secretariat', 'PET-5', '047', 'Community Aresa', '10756', '', '', '', '', 'info@ncs.go.ke', NULL, 'ncs.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(791, 'PE-379', 'Nakuru', 'PET-8', '047', 'Nakuru', '2780-20100 Nakuru', '', '', '', '', 'supplychainnakuru@gmail.com', NULL, 'www.nakuru.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(792, 'PE-380', 'Lapsset Corridor Development Authority', 'PET-5', '047', 'Chester House, 2nd Floor', '45008-00100 Nairobi', '', 'Nairobi', '', '', 'dg@lapsset.go.ke', NULL, 'www.lapsset.go.ke ', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(793, 'PE-381', 'Thika Technical Training Institute', 'PET-13', '047', 'Thika, Geberal Kago Road', 'P.O. Box 91 - 0100', '', '', '', '', 'thikatech@gmail.com', NULL, 'www.thikatechnical.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(794, 'PE-382', 'Keroka Technical Training Institute', 'PET-13', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(795, 'PE-383', 'Youth', 'PET-4', '047', 'Kencom House, 3rd Floor', '30500-00100 Nairobi', '', '', '', '', '', NULL, 'www.psyg.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(796, 'PE-384', 'County Assembly Of Nakuru', 'PET-7', '047', 'George Morara road', '0', '', '', '', '', 'p.o box 907', NULL, 'www.assembly.nakuru.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(797, 'PE-385', 'Baringo', 'PET-8', '047', 'KABARNET', '53-30400 KABARNET', '', '', '', '', 'info@baringo.go.ke', NULL, 'WWW.baringo.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(798, 'PE-386', 'Siaya', 'PET-8', '047', 'Siaya', 'Box 803-40600 Siaya', '', '', '', '', 'cs@siaya.go.ke', NULL, 'www.siaya.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(799, 'PE-387', 'Migori', 'PET-8', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(800, 'PE-388', 'County Assembly Of Nyamira', 'PET-7', '047', 'Nyamira', '590-40500 Kisumu', '', '', '', '', 'info@nyamiraassembly.go.ke', NULL, 'www.nyamiraassembly.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(801, 'PE-389', 'Meru', 'PET-8', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(802, 'PE-390', 'Administration Police Service', 'PET-4', '047', '0', '0', '', '', '', '', '', NULL, 'www.interior.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(803, 'PE-391', 'General Service Unit', 'PET-4', '047', 'Ruaraka', '49506-00100', '', '', '', '', 'gsuheadquarters17@gmail.com', NULL, '', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(804, 'PE-392', 'Government Chemist', 'PET-4', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(805, 'PE-393', 'National Registration Bureau', 'PET-4', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(806, 'PE-394', 'Integrated Population Registration Services', 'PET-4', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(807, 'PE-395', 'NAtional Disaster Operation Centre', 'PET-4', '047', 'NYAYO HOUSE 3RD FLOOR', '37300-00100 ', '', '', '', '', 'nationaldisaterops@yahoo.co.uk', NULL, 'http://www.interior.go.ke/', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(808, 'PE-396', 'Civil Registration Service', 'PET-4', '047', 'Hass Plaza , Lower hill Road', '49179 - 00100', '', '', '', '', 'procurementcrs@gmail.com', NULL, 'www.interior.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(809, 'PE-397', 'Directorate of Criminal Investigation', 'PET-4', '047', 'Mazingira House, Kiambu Road', 'P.O Box 30036-00100  Nairobi', '', 'Nairobi', '', '', '', NULL, 'http://www.cid.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(810, 'PE-398', 'Government Press', 'PET-4', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(811, 'PE-399', 'National Police Service', 'PET-4', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(812, 'PE-400', 'Kenya Pipeline Company retirement Benefits Scheme', 'PET-16', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(813, 'PE-401', 'Intergovernmental Relations Technical Committee', 'PET-12', '047', 'Parklands Plaza ,4th Floor Chiromo Lane', '44880-00100', '', '', '', '', 'info@igrtc.go.ke', NULL, 'www.igrtc.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(814, 'PE-402', 'Tana River', 'PET-8', '047', 'Hola', 'P.O. BOX 29-70101', '', '', '', '', 'info@tanariver.go.ke', NULL, 'www.tanariver.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(815, 'PE-403', 'Kakamega County Water and Sanitation Company', 'PET-11', '047', 'Kenfico House, Off Kakamega - Kisumu Road', 'Box 1189-50100 ', '', 'Kakamega', '', '', 'kacwasco@gmail.com', NULL, 'www.w.com', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(816, 'PE-404', 'County Assembly Of Kajiado', 'PET-7', '047', 'Kajiado Town-County Headquarter', '94-01100', '', '', '', '', 'info@kajiadoassembly.go.ke', NULL, 'N/A', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(817, 'PE-405', 'Egerton University Investment Company', 'PET-5', '047', 'Njoro,Nakuru', '536-20115 ', '', 'EGERTON', '', '', 'euic@egerton.ac.ke', NULL, 'N/A', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(818, 'PE-406', 'County Assembly Of Nandi', 'PET-7', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(819, 'PE-407', 'National Government Constituencies Development Fund Board', 'PET-5', '047', 'Harambee Plaza, 5th Floor', '46682-', '100', '', '', '', 'info@ngcdf.go.ke', NULL, 'www.ngcdf.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(820, 'PE-408', 'Mombasa', 'PET-8', '047', 'County Treasury, Treasury square. Assembly building.', '90440', '80100', 'Nairobi', '', '', 'countyfinance@mombasa.go.ke', NULL, 'www.mombasa.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(821, 'PE-409', 'Kenya Police Service', 'PET-4', '047', 'Vigilance House', '30083', '', 'Nairobi', '', '', 'info@kenyapolice.go.ke', NULL, 'www.kenyapolice.go.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(822, 'PE-410', 'The Nyeri National Polytechnic', 'PET-13', '047', 'Mumbi Road, Nyeri', 'Box 456', '10100', 'Nyeri', '', '', 'info@thenyeripoly.ac.ke', NULL, 'www.thenyeripoly.ac.ke', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(823, 'PE-411', 'County Assembly Of Kilifi', 'PET-7', '047', '0', '0', '', '', '', '', '', NULL, '\\N', 'Admin', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
	(924, 'PE-412', 'test test', 'PET-4', '005', 'Nairobi', '123', '01000', 'THIKA  ', '0722719412', '0722719412', 'arcmdevelopment@gmail.com ', '', '', 'Admin', '2019-12-05 13:01:28', '2019-12-05 13:12:30', '12345611', 0, NULL, NULL, '2019-12-05 00:00:00', '12345611', '12345611');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.procurementmethods: ~0 rows (approximately)
DELETE FROM `procurementmethods`;
/*!40000 ALTER TABLE `procurementmethods` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.rb1forms: ~0 rows (approximately)
DELETE FROM `rb1forms`;
/*!40000 ALTER TABLE `rb1forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rb1forms` ENABLE KEYS */;

-- Dumping structure for procedure arcm.ReasignCaseOfficer
DROP PROCEDURE IF EXISTS `ReasignCaseOfficer`;
DELIMITER //
CREATE  PROCEDURE `ReasignCaseOfficer`(IN _UserID VARCHAR(50), IN _Applicationno VARCHAR(50), IN _UserName VARCHAR(50), IN _Reason VARCHAR(255))
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
CREATE  PROCEDURE `registercasesittings`(IN _ApplicationNo VARCHAR(50),IN _VenueID INT,IN _Date Date,IN _UserID varchar(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Registered hearing for Application:',_ApplicationNo); 

if(SELECT count(*)  from casesittingsregister where ApplicationNo=_ApplicationNo and Date=_Date )=0 THEN
BEGIN

select IFNULL(MAX(SittingNo),0)+1 from casesittingsregister where ApplicationNo=_ApplicationNo  INTO @SittingNo; 
INSERT INTO casesittingsregister (ApplicationNo ,VenueID ,Date ,SittingNo , Created_At,Created_By)
  VALUES(_ApplicationNo,_VenueID,now(),@SittingNo,now(),_UserID);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');
  call Saveapplicationsequence(_ApplicationNo,'Case hearing','Decision preparation',_UserID);  
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
CREATE  PROCEDURE `RemoveAllUserroles`(IN `_Username` VARCHAR(50))
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
CREATE  PROCEDURE `RemovePanelMember`(IN _ApplicationNo VARCHAR(50), IN _UserName VARCHAR(50), IN _userID VARCHAR(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Removed  PanelMember:' +_UserName+ ' for Application: ', _ApplicationNo); 
  update Panels set deleted=1 where ApplicationNo=_ApplicationNo and UserName=_UserName;
  call SaveAuditTrail(_userID,lSaleDesc,'Delete','0');
  update panelsapprovalworkflow  set Status='Declined', Approved_At=now() where ApplicationNo=_ApplicationNo and UserName=_UserName;
END//
DELIMITER ;

-- Dumping structure for table arcm.requesthandledbuffer
DROP TABLE IF EXISTS `requesthandledbuffer`;
CREATE TABLE IF NOT EXISTS `requesthandledbuffer` (
  `Applicationno` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplicationDate` date DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.requesthandledbuffer: ~0 rows (approximately)
DELETE FROM `requesthandledbuffer`;
/*!40000 ALTER TABLE `requesthandledbuffer` DISABLE KEYS */;
/*!40000 ALTER TABLE `requesthandledbuffer` ENABLE KEYS */;

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

-- Dumping structure for procedure arcm.Resolveapplicationsequence
DROP PROCEDURE IF EXISTS `Resolveapplicationsequence`;
DELIMITER //
CREATE  PROCEDURE `Resolveapplicationsequence`(IN _ApplicationNo VARCHAR(50),IN _Action VARCHAR(255))
BEGIN
  Update applicationsequence set Status='Done' where ApplicationNo=_ApplicationNo and  Action=_Action ;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ResolveMyNotification
DROP PROCEDURE IF EXISTS `ResolveMyNotification`;
DELIMITER //
CREATE  PROCEDURE `ResolveMyNotification`(IN _UserName VARCHAR(50), IN _Category VARCHAR(50),IN _ApplicationNo VARCHAR(50))
BEGIN
-- select ID from notifications where Username=_UserName and Category=_Category and Status='Not Resolved' LIMIT 1 into @UnresolvedID;
update notifications set Status='Resolved' where Username=_UserName and Category=_Category and ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ResubmitApplication
DROP PROCEDURE IF EXISTS `ResubmitApplication`;
DELIMITER //
CREATE  PROCEDURE `ResubmitApplication`(IN _ApplicationID INT, IN _userID VARCHAR(50))
BEGIN
Update applications set Status='Pending Approval' where ID=_ApplicationID;
 select ApplicationNo from applications where ID=_ApplicationID LIMIT 1 into @App; 
call Saveapplicationsequence(@App,'Resubmited Application','Awaiting fees confirmation',_userID); 

 DROP TABLE IF EXISTS caseWithdrawalContacts;
 create table caseWithdrawalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Msg varchar(50));

   select Created_By from applications where ID=_ApplicationID LIMIT 1 into @Applicant;
              insert into caseWithdrawalContacts select Name,Email,Phone,'Applicant' from users where Username =@Applicant;
              select ApplicantID from applications where ID=_ApplicationID LIMIT 1 into @ApplicantID;
              insert into caseWithdrawalContacts select Name,Email,Mobile,'Applicant' from applicants where  ID=@ApplicantID;
              insert into caseWithdrawalContacts select Name,Email,Phone,'Approver' from users
              inner join approvers on approvers.Username=users.Username
              where approvers.ModuleCode='APFRE' and approvers.Deleted=0 and Active=1;  
   if(select count(*) from approvers where ModuleCode ='APFRE' and Active=1 and Deleted=0)>0 THEN
              Begin
                  INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
                  select Username,'Applications Approval','Applications pending approval',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationID
                  from approvers where ModuleCode ='APFRE' and Active=1 and Deleted=0;
              End;
              End if;    

   select * from caseWithdrawalContacts;
END//
DELIMITER ;

-- Dumping structure for table arcm.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `RoleID` bigint(20) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `RoleDescription` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdateBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CreatedAt` datetime DEFAULT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL,
  `Category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`RoleID`,`RoleName`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.roles: ~66 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`RoleID`, `RoleName`, `RoleDescription`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`, `Deleted`, `Category`) VALUES
	(17, 'System Users', 'System Users ', 'Admin', 'user', '2019-06-27 17:30:15', '2019-10-04 10:27:44', 0, 'Admin'),
	(18, 'Roles', 'Security roles', 'user', 'user', '2019-06-27 17:30:36', '2019-06-27 17:30:36', 0, 'Admin'),
	(19, 'Security Groups', 'Security groups', 'user', 'user', '2019-06-27 17:31:08', '2019-06-27 17:31:08', 0, 'Admin'),
	(20, 'Assign Group Access', 'Assign Group Access', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Admin'),
	(21, 'Audit Trails', 'Audit Trails', 'user', 'user', '2019-06-27 17:31:57', '2019-06-27 17:31:57', 0, 'Admin'),
	(22, 'System Administration', 'System Administration', 'Admin', 'Admin', '2019-07-26 12:02:56', '2019-07-26 12:02:56', 0, 'Menus'),
	(23, 'Fees Settings', 'Fees Settings', 'Admin', 'Admin', '2019-07-26 12:03:16', '2019-07-26 12:03:16', 0, NULL),
	(24, 'Case Management', 'Case Management', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'Menus'),
	(25, 'Case Hearing', 'Case Hearing', 'Admin', 'Admin', '2019-07-26 12:03:57', '2019-07-26 12:03:57', 0, 'Menus'),
	(26, 'Decision', 'Decision', 'Admin', 'Admin', '2019-07-26 12:04:10', '2019-07-26 12:04:10', 0, 'CaseManagement'),
	(27, 'Board Management', 'Board Management', 'Admin', 'Admin', '2019-07-26 12:04:23', '2019-07-26 12:04:23', 0, 'CaseManagement'),
	(28, 'Reports', 'Reports', 'Admin', 'Admin', '2019-07-26 12:04:36', '2019-07-26 12:04:36', 0, 'Menus'),
	(29, 'DashBoards', 'DashBoards', 'Admin', 'Admin', '2019-07-26 15:19:29', '2019-07-26 15:19:29', 0, 'Menus'),
	(30, 'Assign User Access', 'Assign User Access', 'Admin', 'Admin', '2019-07-29 11:03:54', '2019-07-29 11:03:57', 0, 'Admin'),
	(31, 'System Configurations', 'System Configurations', 'Admin', 'Admin', '2019-07-29 14:07:47', '2019-07-29 14:07:47', 0, 'Admin'),
	(32, 'PeTypes', 'PeTypes', 'Admin', 'Admin', '2019-07-31 16:59:11', '2019-07-31 16:59:11', 0, 'Systemparameteres'),
	(33, 'Committee Types', 'Committee Types', 'Admin', 'Admin', '2019-08-01 10:21:59', '2019-08-01 10:21:59', 0, 'Systemparameteres'),
	(34, 'Procurement Methods', 'Procurement Methods', 'Admin', 'Admin', '2019-08-01 10:25:18', '2019-08-01 10:25:18', 0, 'Systemparameteres'),
	(35, 'System parameteres', 'System parameteres', 'Admin', 'Admin', '2019-08-01 10:49:11', '2019-08-01 10:49:11', 0, 'Menus'),
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
	(59, 'Hearing In Progress', 'Hearing In Progress', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(60, 'Close Registrations', 'Close Registrations', 'user', 'user', '2019-06-27 17:30:36', '2019-06-27 17:30:36', 0, 'Admin'),
	(61, 'Fees Approval', 'Fees Approval', 'Admin', 'Admin', '2019-07-26 12:04:23', '2019-07-26 12:04:23', 0, 'CaseManagement'),
	(62, 'Interested Parties', 'Interested Parties', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(63, 'Case FollowUp', 'Case FollowUp', 'Admin', 'Admin', '2019-07-26 12:03:16', '2019-07-26 12:03:16', 0, 'CaseManagement'),
	(64, 'Case Referrals', 'Case Referrals', 'Admin', 'Admin', '2019-07-26 12:03:33', '2019-07-26 12:03:33', 0, 'CaseManagement'),
	(65, 'Requests handled', 'Requests handled', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(66, 'Monthly Cases', 'Monthly Cases', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(67, 'PE Appearance Frequency', 'PE Appearance Frequency', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(68, 'Attendance', 'Attendance', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(69, 'RB1', 'RB1', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(70, 'Hearing Notices', 'Hearing Notices', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(71, 'Panel List', 'Panel List', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(72, 'Case Summary', 'Case Summary', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(73, 'Decisions', 'Decisions', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(74, 'Registration', 'Registration', 'Admin', 'Admin', '2019-07-26 12:04:23', '2019-07-26 12:04:23', 0, 'CaseManagement'),
	(75, 'Case Proceedings', 'Case Proceedings', 'Admin', 'Admin', '2019-07-26 12:04:23', '2019-07-26 12:04:23', 0, 'CaseManagement'),
	(76, 'Hearing In progress', 'Hearing In progress', 'Admin', 'Admin', '2019-07-26 12:04:23', '2019-07-26 12:04:23', 0, 'CaseManagement'),
	(77, 'Case Analysis', 'Case Analysis', 'Admin', 'Admin', '2019-07-26 12:04:10', '2019-07-26 12:04:10', 0, 'CaseManagement'),
	(78, 'Judicial Review', 'Judicial Review', 'Admin', 'Admin', '2019-07-26 12:04:23', '2019-07-26 12:04:23', 0, 'Menus'),
	(79, 'Banks', 'Banks', NULL, 'Admin', NULL, NULL, 0, 'Systemparameteres'),
	(80, 'Payment Types', 'Payment Types', NULL, 'Admin', NULL, NULL, 0, 'Systemparameteres'),
	(81, 'Fees Report', 'Fees Report', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(82, 'Applications Custom Report', 'Applications Custom Report', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports'),
	(83, 'SMS Details', 'SMS Details', 'Admin', 'Admin', '2019-08-01 13:32:48', '2019-08-01 13:32:48', 0, 'Systemparameteres'),
	(84, 'SMTP Details', 'SMTP Details', 'Admin', 'Admin', '2019-07-31 16:59:11', '2019-07-31 16:59:11', 0, 'Systemparameteres');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for procedure arcm.Saveadditionalsubmissions
DROP PROCEDURE IF EXISTS `Saveadditionalsubmissions`;
DELIMITER //
CREATE  PROCEDURE `Saveadditionalsubmissions`(IN _ApplicationID INT, IN _Description TEXT,  IN `_userID` VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new additionalsubmissions for ApplicationNo:',_ApplicationID); 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0');

  
select Category from users where Username=_userID Limit 1 INTO @Category;
select Email from users where Username=_userID Limit 1 INTO @Email;
select Name from users where Username=_userID Limit 1 INTO @Name;
select Created_By from applications where ID=_ApplicationID limit 1 into @CreatedBy;

if(@CreatedBy=_userID) Then
Begin
  INSERT INTO  additionalsubmissions (ApplicationID,  Description, Create_at, CreatedBy, Deleted,Category,SubmitedBy)
  VALUES(_ApplicationID,_Description,now(),_userID,0,'Applicant',@Name);


End;
ELSE
Begin

  if(@Category='Applicant') Then
  Begin
      INSERT INTO  additionalsubmissions (ApplicationID,  Description, Create_at, CreatedBy, Deleted,Category,SubmitedBy)
      VALUES(_ApplicationID,_Description,now(),_userID,0,'Interested party',@Name);  
  End;
  End if;

  if(@Category='PE') Then
  Begin
    INSERT INTO  additionalsubmissions (ApplicationID,  Description, Create_at, CreatedBy, Deleted,Category,SubmitedBy)
    VALUES(_ApplicationID,_Description,now(),_userID,0,'Procuring Entity',@Name);
  End;
  End if;

End;
End if;



END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveadditionalsubmissionsDocuments
DROP PROCEDURE IF EXISTS `SaveadditionalsubmissionsDocuments`;
DELIMITER //
CREATE  PROCEDURE `SaveadditionalsubmissionsDocuments`(IN _ApplicationID INT, IN _Description TEXT, IN _DocName VARCHAR(100), IN _FilePath VARCHAR(50), IN _userID VARCHAR(50), IN _Confidential BOOLEAN)
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new additionalsubmissions doument for ApplicationNo:',_ApplicationID); 

select Category from users where Username=_userID Limit 1 INTO @Category;
select Email from users where Username=_userID Limit 1 INTO @Email;
select Name from users where Username=_userID Limit 1 INTO @Name;
select Created_By from applications where ID=_ApplicationID limit 1 into @CreatedBy;

if(@CreatedBy=_userID) Then
Begin
  INSERT INTO  additionalsubmissionDocuments(ApplicationID,  Description, FileName, FilePath, Create_at, CreatedBy, Deleted,Category,Confidential,SubmitedBy)
  VALUES(_ApplicationID,_Description,_DocName,_FilePath,now(),_userID,0,'Applicant',_Confidential,@Name);
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
End;
ELSE
Begin

  if(@Category='Applicant') Then
  Begin
    INSERT INTO  additionalsubmissionDocuments(ApplicationID,  Description, FileName, FilePath, Create_at, CreatedBy, Deleted,Category,Confidential,SubmitedBy)
    VALUES(_ApplicationID,_Description,_DocName,_FilePath,now(),_userID,0,'Interested party',_Confidential,@Name);
    call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
  End;
  End if;
    if(@Category='PE') Then
  Begin
    INSERT INTO  additionalsubmissionDocuments(ApplicationID,  Description, FileName, FilePath, Create_at, CreatedBy, Deleted,Category,Confidential,SubmitedBy)
    VALUES(_ApplicationID,_Description,_DocName,_FilePath,now(),_userID,0,'Procuring Entity',_Confidential,@Name);
    call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
  End;
  End if;

End;
End if;




END//
DELIMITER ;

-- Dumping structure for procedure arcm.Saveadjournment
DROP PROCEDURE IF EXISTS `Saveadjournment`;
DELIMITER //
CREATE  PROCEDURE `Saveadjournment`(IN _Applicant VARCHAR(50),IN _ApplicationNo VARCHAR(50),IN _Reason text,IN _UserID varchar(50))
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
insert into adjournmentApprovalWorkFlow(Date,Applicant,ApplicationNo, Reason,Status ,Created_At, Created_By,Approver ) 
select now(),_Applicant,_ApplicationNo,_Reason,'Pending Approval',now(),_UserID,Username from approvers where ModuleCode='ADJRE' and Active=1 and Deleted=0 ;

call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
 
select Username,'Case Adjournment Approval','Case Adjournment pending approval',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationNo from approvers where ModuleCode='ADJRE' and Active=1 and Deleted=0 ;
call Saveapplicationsequence(_ApplicationNo,'Submited Request for Adjournment','Awaiting Approval',_UserID);

Select 'Success' as msg,Email,Name,Phone from users where Username in (Select Username from approvers where ModuleCode='ADJRE' and Active=1 and Deleted=0) ;
  End;
  End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveadjournmentDocuments
DROP PROCEDURE IF EXISTS `SaveadjournmentDocuments`;
DELIMITER //
CREATE  PROCEDURE `SaveadjournmentDocuments`(IN _ApplicationNo VARCHAR(50),IN _Description VARCHAR(155)
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
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApplicant`(IN _Name VARCHAR(128), IN _Location VARCHAR(50), IN _POBox VARCHAR(50), IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _Mobile VARCHAR(50), IN _Telephone VARCHAR(50), IN _Email VARCHAR(100), IN _Logo VARCHAR(100), IN _Website VARCHAR(100), IN _UserID VARCHAR(50), IN _County VARCHAR(50), IN _RegistrationDate DATETIME, IN _PIN VARCHAR(50), IN _RegistrationNo VARCHAR(50))
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
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApplication`(IN `_TenderID` BIGINT, IN `_ApplicantID` BIGINT, IN `_PEID` VARCHAR(50), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

select IFNULL(MAX(ID),0)+1 from applications   INTO @ApplicationNo; 
-- select Username from approvers  where ModuleCode ='APFRE' and Level=1 and Deleted=0 and Active=1 INTO @Approver ; 
set lSaleDesc= CONCAT('Added new Application with ApplicationNo:',@ApplicationNo); 
INSERT INTO `applications`( `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, `Created_By`, `Created_At`,  `Deleted`,PaymentStatus) 
VALUES (_TenderID,_ApplicantID,_PEID,now(),@ApplicationNo,@ApplicationNo,'Not Submited',_userID,now(),0,'Not Submited');

call Saveapplicationsequence(@ApplicationNo,'Created New Application','Not Submited Application',_userID); 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
-- call SaveNotification(@Approver,'Applications Approval','Applications pending approval',DATE_ADD(NOW(), INTERVAL 3 DAY));


select MAX(ID) as ApplicationID,@ApplicationNo as ApplicationNo,@ApplicationNo as ApplicationREf FROM applications where TenderID=_TenderID 
  and ApplicantID=_ApplicantID and PEID=_PEID and Created_By=_userID;


End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveApplicationFees
DROP PROCEDURE IF EXISTS `SaveApplicationFees`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApplicationFees`(IN _ApplicationID INT, IN _EntryType INT, IN _AmountDue FLOAT, IN _RefNo VARCHAR(50), IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added Fee for Application: ',_ApplicationID); 

if(select count(*) from applicationfees where ApplicationID=_ApplicationID and EntryType=_EntryType )>0 THEN
Begin
Update applicationfees set Deleted=1,Deleted_At=now(),Deleted_By=_UserID where ApplicationID=_ApplicationID and EntryType=_EntryType;
End;
End IF;

INSERT INTO 
`applicationfees`( `ApplicationID`, `EntryType`, `AmountDue`, `RefNo`, `BillDate`, `AmountPaid`,  `Created_By`, `Created_At`, Deleted,CalculatedAmount,FeesStatus) 
VALUES 
(_ApplicationID,_EntryType,_AmountDue,_RefNo,now(),0,_UserID,now(),0,_AmountDue,'Pending Approval');
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Saveapplicationsequence
DROP PROCEDURE IF EXISTS `Saveapplicationsequence`;
DELIMITER //
CREATE  PROCEDURE `Saveapplicationsequence`(IN _ApplicationNo VARCHAR(50),IN _Action VARCHAR(255),IN _ExpectedAction VARCHAR(150),IN _UserID varchar(50))
BEGIN
if(select count(*) from applicationsequence where Action=_Action and ApplicationNo=_ApplicationNo)>0 THEN
Begin
  End;
else
begin
  insert into applicationsequence (ApplicationNo, Date , Action ,Status ,ExpectedAction,User)
    VALUES(_ApplicationNo,now(),_Action,'Done',_ExpectedAction,_UserID);
  End;
  End if;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveApprover
DROP PROCEDURE IF EXISTS `SaveApprover`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveApprover`(IN _Username VARCHAR(50), IN _ModuleCode VARCHAR(50), IN _Mandatory BOOLEAN, 
  IN _UserID VARCHAR(50), IN _IsActive Boolean)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
set lSaleDesc= CONCAT('Added new Approver:  '+_Username); 
if(select count(*) from approvers where Username=_Username and ModuleCode=_ModuleCode )>0 THEN
Begin

Update approvers set Mandatory=_Mandatory, Active=_IsActive,UpdatedBy=_UserID 
  where Username=_Username and ModuleCode=_ModuleCode;

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

  End;
Else
Begin

INSERT INTO `approvers`( `Username`,ModuleCode ,Mandatory, `Create_at`,`CreatedBy`,Active,Deleted) 
VALUES (_Username,_ModuleCode,_Mandatory,now(),_UserID,_IsActive,0);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

  End;
End if;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveAuditTrail
DROP PROCEDURE IF EXISTS `SaveAuditTrail`;
DELIMITER //
CREATE  PROCEDURE `SaveAuditTrail`(IN `_Username` VARCHAR(50), IN `_Description` VARCHAR(128), IN `_Category` VARCHAR(50), IN `_IpAddress` VARCHAR(50))
    NO SQL
BEGIN
INSERT INTO `audittrails`(`Date`, `Username`, `Description`, `Category`, `IpAddress`) VALUES (now(),_Username,_Description,_Category,_IpAddress);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveBank
DROP PROCEDURE IF EXISTS `SaveBank`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveBank`( IN _Name VARCHAR(100), IN _Branch VARCHAR(50), IN _AcountNo VARCHAR(100), IN _PayBill VARCHAR(50),  IN _userID VARCHAR(50))
    NO SQL
BEGIN

Insert into banks ( 
  Name , Branch , AcountNo ,PayBill ,Created_By ,Created_At ,Deleted )Values(_Name,_Branch,_AcountNo,_PayBill,_userID,now(),0);
call SaveAuditTrail(_userID,'Added new bank Account','Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveBankSlip
DROP PROCEDURE IF EXISTS `SaveBankSlip`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveBankSlip`(IN _ApplicationID BIGINT(20), IN _Name VARCHAR(150), IN _path VARCHAR(200), IN _userID VARCHAR(50), IN _Category VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new bank slip for application: ', _ApplicationID); 
Insert into bankslips (ApplicationID,Name,path,Created_By ,Created_At  ,Deleted,Category)
  VALUES(_ApplicationID,_Name,_path,_userID,now(),0,_Category);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
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

-- Dumping structure for procedure arcm.SavecaseAnalysis
DROP PROCEDURE IF EXISTS `SavecaseAnalysis`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SavecaseAnalysis`(IN _ApplicationNo VARCHAR(50),IN _Title text,IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new case analysis for Application: ', _ApplicationNo); 
if(select count(*) from caseanalysis where ApplicationNO=_ApplicationNo and Title=_Title and Deleted=0)>0 THEN
Begin
  Update caseanalysis set  ApplicationNO=_ApplicationNo,Description=_Description,Title=_Title where ApplicationNO=_ApplicationNo and Title=_Title;
End;
Else
begin
  insert into caseanalysis (ApplicationNO,Description,Title,Create_at ,Deleted,CreatedBy )
  VALUES( _ApplicationNo,_Description,_Title,now(),0,_userID);
End;
End if; 
 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savecaseanalysisdocuments
DROP PROCEDURE IF EXISTS `Savecaseanalysisdocuments`;
DELIMITER //
CREATE  PROCEDURE `Savecaseanalysisdocuments`(IN _ApplicationNo varchar(50), IN _Description TEXT, IN _DocName VARCHAR(100), IN _FilePath VARCHAR(50), IN _userID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new caseanalysis  doument for ApplicationNo:',_ApplicationNo); 

select Name from users where Username=_userID Limit 1 INTO @Name;

  INSERT INTO  caseanalysisdocuments(ApplicationNo,  Description, FileName, FilePath, Create_at, CreatedBy, Deleted,Category,Confidential,SubmitedBy)
  VALUES(_ApplicationNo,_Description,_DocName,_FilePath,now(),_userID,0,'case analysis documents',0,@Name);
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
call Saveapplicationsequence(_ApplicationNo,'Uploded case Analysis Report','Awaiting Hearing',_userID); 

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveCaseOfficers
DROP PROCEDURE IF EXISTS `SaveCaseOfficers`;
DELIMITER //
CREATE  PROCEDURE `SaveCaseOfficers`(IN _Username VARCHAR(50), IN _Active BOOLEAN, IN _NotAvailableFrom DATETIME, IN _NotAvailableTo DATETIME, IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Case Officer: ',_Username); 
INSERT INTO caseofficers
  (`Username`,`Active`, `NotAvailableFrom`, `NotAvailableTo`, `OngoingCases`, `CumulativeCases`, `Create_at`,  `CreatedBy`,  `Deleted`) 
  VALUES (_Username,_Active,_NotAvailableFrom,_NotAvailableTo,1,1,now(),_UserID,0);
  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveCaseWithdrawal
DROP PROCEDURE IF EXISTS `SaveCaseWithdrawal`;
DELIMITER //
CREATE  PROCEDURE `SaveCaseWithdrawal`(IN _Applicant VARCHAR(50),IN _ApplicationNo VARCHAR(50),IN _Reason VARCHAR(255),IN _UserID varchar(50))
BEGIN
if(SELECT count(*)  from casewithdrawal where ApplicationNo=_ApplicationNo and Status='Approved')>0 THEN
BEGIN
Select 'Already submited' as msg;
END;
else
Begin
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Submited request for case withdrawal for application:',_ApplicationNo); 
insert into casewithdrawal(Date,Applicant,ApplicationNo, Reason,Status ,Created_At, Created_By ) 
  VALUES(now(),_Applicant,_ApplicationNo,_Reason,'Pending Approval',now(),_UserID);
 call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
select Username,'Case withdrawal Approval','Case withdrawal pending approval',NOW(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationNo 
from approvers where Deleted=0 and Active=1 and ModuleCode='WIOAP';
call Saveapplicationsequence(_ApplicationNo,'Submited request for case withdrawal','Awaiting Approval',_UserID); 
Select 'Success' as msg,Email,Name,Phone from users where Username in (select Username from approvers where Deleted=0 and Active=1 and ModuleCode='WIOAP');
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
CREATE  PROCEDURE `SaveConfigurations`(IN _Name varchar(255),IN  _PhysicalAdress varchar(255),IN  _Street varchar(255),IN  _PoBox varchar(255),IN _PostalCode varchar(50),IN _Town varchar(100),IN _Telephone1 varchar(100),IN _Telephone2 varchar(100),IN _Mobile varchar(100),IN _Fax varchar(100),IN _Email varchar(100),IN _Website varchar(100),IN _PIN varchar(50),IN _Logo varchar(100),IN _UserID varchar(50),IN _Code varchar(50))
BEGIN
if(SELECT count(*)  from configurations)>0 THEN

		BEGIN
			UPDATE `configurations` SET Code=_Code,`Name`=_Name,`PhysicalAdress`=_PhysicalAdress,`Street`=_Street,`PoBox`=_PoBox,`PostalCode`=_PostalCode,`Town`=			_Town,`Telephone1`=_Telephone1,`Telephone2`=_Telephone2,`Mobile`=_Mobile,`Fax`=_Fax,`Email`=_Email,`Website`=_Website,
			`PIN`=_PIN,`Logo`=_Logo,

	`Updated_At`=now(),`Updated_By`=_UserID  ;
		
		END;
		ELSE
			BEGIN
        select Year(now()) into  @Year;
				INSERT INTO configurations
				(Code, Name, PhysicalAdress, Street, PoBox, PostalCode, Town, Telephone1, 
				Telephone2, Mobile, Fax, Email, Website, PIN, Logo,
				NextPE, NextComm, NextSupplier,NextMember, NextProcMeth, NextStdDoc, NextApplication, NextRev, NextPEType,
				Created_At, Updated_At,
				Created_By, Updated_By, Deleted, Deleted_By,Year) 
				VALUES
				(_Code,_Name,_PhysicalAdress,_Street,_PoBox,_PostalCode,_Town,_Telephone1,
				_Telephone2,_Mobile,_Fax,_Email,_Website,_PIN,_Logo,
				'1','1','1','1','1','1','1','1','1',
				now(),now(),_UserID,' ',0,' ',@Year);
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

-- Dumping structure for procedure arcm.Savedecisiondocuments
DROP PROCEDURE IF EXISTS `Savedecisiondocuments`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savedecisiondocuments`(IN _ApplicationNo VARCHAR(50), IN _Name VARCHAR(150),IN _Description VARCHAR(255), IN _path VARCHAR(200), IN _userID VARCHAR(50), IN _Confidential TINYINT(1))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new decision document application: ', _ApplicationNo); 
insert into decisiondocuments (ApplicationNo,Name,Description,Path,Created_At,Deleted,Confidential,Created_By)
VALUES (_ApplicationNo,_Name,_Description,_path,now(),0,_Confidential,_userID);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savedecisionorders
DROP PROCEDURE IF EXISTS `Savedecisionorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savedecisionorders`(IN _ApplicationNo VARCHAR(50),IN _NO INT(11),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new decision order for Application: ', _ApplicationNo); 
if(select count(*) from decisionorders where NO=_NO and ApplicationNo=_ApplicationNo)>0 THEN
Begin
  select max(NO)+1 from decisionorders where ApplicationNo=_ApplicationNo limit 1 into @MaxNo;

insert into arcm.decisionorders (NO ,ApplicationNo,Description,Created_At ,Deleted,Created_By )
  VALUES( @MaxNo,_ApplicationNo,_Description,now(),0,_userID);
  End;
Else
Begin
  insert into arcm.decisionorders (NO ,ApplicationNo,Description,Created_At ,Deleted,Created_By )
  VALUES(_NO,_ApplicationNo,_Description,now(),0,_userID);
  End ;
End if;
 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savedecisions
DROP PROCEDURE IF EXISTS `Savedecisions`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savedecisions`(IN _ApplicationNo VARCHAR(50),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Background Information for decision for Application: ', _ApplicationNo);
if(select count(*) from decisions where ApplicationNo=_ApplicationNo) >0 THEN
BEGIN
  update decisions set Backgroundinformation=_Description,Updated_At=now(),Updated_By=_userID WHERE ApplicationNo=_ApplicationNo;
  call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
Else
Begin
insert into decisions ( Status , ApplicationNo , Backgroundinformation, Created_At , Created_By )
  VALUES('Draft',_ApplicationNo,_Description,now(),_userID);
call Saveapplicationsequence(_ApplicationNo,'Decision preparation','Closed',_userID); 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
End;
end if;
 


  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveDecisionSummary
DROP PROCEDURE IF EXISTS `SaveDecisionSummary`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveDecisionSummary`(IN _ApplicationNo VARCHAR(50),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new DecisionSummary for Application: ', _ApplicationNo);
if(select count(*) from decisions where ApplicationNo=_ApplicationNo) >0 THEN
BEGIN
  update decisions set DecisionSummary=_Description,Updated_At=now(),Updated_By=_userID WHERE ApplicationNo=_ApplicationNo;
  call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
Else
Begin
insert into decisions ( Status , ApplicationNo , DecisionSummary, Created_At , Created_By )
  VALUES('Draft',_ApplicationNo,_Description,now(),_userID);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
End;
end if;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveDocument
DROP PROCEDURE IF EXISTS `SaveDocument`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveDocument`(IN _ApplicationID BIGINT, IN `_Description` VARCHAR(525), IN `_File` VARCHAR(100),IN _Path VARCHAR(100),IN _UserID VARCHAR(50),_Confidential BOOLEAN)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Added new Document for application: ', _ApplicationID); 
INSERT INTO `applicationdocuments`( `ApplicationID`, `Description`, `FileName`, `DateUploaded`, `Path`, `Created_By`, `Created_At`, `Deleted`,Confidential)
VALUES (_ApplicationID,_Description,_File,now(),_Path,_UserID,now(),0,_Confidential);
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

-- Dumping structure for procedure arcm.Savefindingsonissues
DROP PROCEDURE IF EXISTS `Savefindingsonissues`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savefindingsonissues`(IN _ApplicationNo VARCHAR(50),IN _NO INT(11),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new findings on issues for Application: ', _ApplicationNo); 
insert into findingsonissues (NO, ApplicationNo ,Description,Created_At,Deleted,Created_By )
  VALUES(_NO,_ApplicationNo,_Description,now(),0,_userID);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

  
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
if(select count(*) from groundsandrequestedorders where GroundNO=_GroundNO and ApplicationID=_ApplicationID and EntryType=_EntryType)>0 THEN
Begin
  select max(GroundNO)+1 from groundsandrequestedorders where ApplicationID=_ApplicationID and  EntryType=_EntryType limit 1 into @MaxNo;
  INSERT INTO groundsandrequestedorders( `ApplicationID`, Description,`EntryType`, `Status`, `Created_By`, `Created_At`,`Deleted`,GroundNO) 
VALUES (_ApplicationID,_Description,_EntryType,'Pending Review',_userID,now(),0,@MaxNo);
  End;
Else
Begin
INSERT INTO groundsandrequestedorders( `ApplicationID`, Description,`EntryType`, `Status`, `Created_By`, `Created_At`,`Deleted`,GroundNO) 
VALUES (_ApplicationID,_Description,_EntryType,'Pending Review',_userID,now(),0,_GroundNO);
  End ;
End if;



call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveHearingAttachments
DROP PROCEDURE IF EXISTS `SaveHearingAttachments`;
DELIMITER //
CREATE  PROCEDURE `SaveHearingAttachments`(IN _ApplicationNo VARCHAR(50),IN _Name LongText,IN _Description VARCHAR(255),IN _Path VARCHAR(255),IN _Category VARCHAR(50),IN _UserID VARCHAR(50))
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
CREATE  PROCEDURE `SaveHearingNotice`(IN _ApplicationNo VARCHAR(50), IN _Path VARCHAR(100),IN _Attachementname VARCHAR(105), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Generated hearing Notice for Application: ', _ApplicationNo); 
Insert into hearingnotices (ApplicationNo , DateGenerated , Path ,Filename,Created_By)
Values(_ApplicationNo,now(),_Path,_Attachementname,_UserID);
call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
    call Saveapplicationsequence(_ApplicationNo,'Case Scheduled and hearing notice generated','Hearing',_UserID);  
  update applications set HearingNoticeGenerated='Yes' WHERE ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveInterestedParty
DROP PROCEDURE IF EXISTS `SaveInterestedParty`;
DELIMITER //
CREATE  PROCEDURE `SaveInterestedParty`(IN _Name VARCHAR(120), IN _ApplicationID INT(11), IN _ContactName VARCHAR(150), IN _Email VARCHAR(128), IN _TelePhone VARCHAR(20), IN _Mobile VARCHAR(20),
  IN _PhysicalAddress VARCHAR(150), IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _POBox VARCHAR(255), IN _UserID VARCHAR(50), IN _Designation VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new interested party for application:',_ApplicationID); 
insert into interestedparties (Name,ApplicationID,ContactName ,Email,TelePhone,Mobile,PhysicalAddress,PostalCode,Town,POBox,Create_at,Deleted ,CreatedBy,Designation)
  Values (_Name,_ApplicationID,_ContactName ,_Email,_TelePhone,_Mobile,_PhysicalAddress,_PostalCode,_Town,_POBox,now(),0 ,_UserID,_Designation );
call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');


End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveIssuesforDetermination
DROP PROCEDURE IF EXISTS `SaveIssuesforDetermination`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveIssuesforDetermination`(IN _ApplicationNo VARCHAR(50),IN _NO INT(11),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new issue for dertermination application: ', _ApplicationNo); 
if(select count(*) from issuesfordetermination where NO=_NO and ApplicationNo=_ApplicationNo)>0 THEN
Begin
  select max(NO)+1 from issuesfordetermination where ApplicationNo=_ApplicationNo limit 1 into @MaxNo;
      insert into issuesfordetermination (NO, ApplicationNo ,Description,Created_At,Deleted,Created_By )
      VALUES( @MaxNo,_ApplicationNo,_Description,now(),0,_userID);
  End;
Else
Begin
      insert into issuesfordetermination (NO, ApplicationNo ,Description,Created_At,Deleted,Created_By )
      VALUES(_NO,_ApplicationNo,_Description,now(),0,_userID);
  End ;
End if;

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savejrcontactusers
DROP PROCEDURE IF EXISTS `Savejrcontactusers`;
DELIMITER //
CREATE  PROCEDURE `Savejrcontactusers`(IN _UserName VARCHAR(50),_ApplicationNO VARCHAR(50),IN _Role VARCHAR(100),IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new jruser for application:',_ApplicationNO); 
Insert Into jrcontactusers (
  
  UserName ,
  ApplicationNO ,
  Role ,
  Create_at ,
  CreatedBy,
  Deleted )VALUES(_UserName,_ApplicationNO,_Role,now(),_UserID,0);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savejrinterestedparties
DROP PROCEDURE IF EXISTS `Savejrinterestedparties`;
DELIMITER //
CREATE  PROCEDURE `Savejrinterestedparties`(IN _Name VARCHAR(120), IN _ApplicationNO varchar(50), IN _ContactName VARCHAR(150), IN _Email VARCHAR(128), IN _TelePhone VARCHAR(20), IN _Mobile VARCHAR(20),
  IN _PhysicalAddress VARCHAR(150), IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _POBox VARCHAR(255), IN _UserID VARCHAR(50), IN _Designation VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new jrinterested  party for application:',_ApplicationNO); 
insert into jrinterestedparties (Name,ApplicationNO,ContactName ,Email,TelePhone,Mobile,PhysicalAddress,PostalCode,Town,POBox,Create_at,Deleted ,CreatedBy,Designation)
  Values (_Name,_ApplicationNO,_ContactName ,_Email,_TelePhone,_Mobile,_PhysicalAddress,_PostalCode,_Town,_POBox,now(),0 ,_UserID,_Designation );
call SaveAuditTrail(_UserID,lSaleDesc,'Add','0');


End//
DELIMITER ;

-- Dumping structure for procedure arcm.Savejudicialreview
DROP PROCEDURE IF EXISTS `Savejudicialreview`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savejudicialreview`(IN _ApplicationNo VARCHAR(50), IN _DateFilled DATE, IN _CaseNO VARCHAR(100), IN _Description VARCHAR(255), IN _Applicant VARCHAR(150), IN _Court VARCHAR(100), IN _Town VARCHAR(50), IN _userID VARCHAR(50), IN _DateRecieved DATE)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added New Judicial Review  ApplicationNo:',_ApplicationNo); 
Insert Into judicialreview (
 
  ApplicationNo,DateFilled,CaseNO,Description,Applicant,Court,Town,DateRecieved,Created_At,Created_By,Deleted)
  VALUES(_ApplicationNo,_DateFilled,_CaseNO,_Description,_Applicant,_Court,_Town,_DateRecieved,now(),_userID,0);
Insert Into jrcontactusers (
  
  UserName ,
  ApplicationNO ,
  Role ,
  Create_at ,
  CreatedBy,
  Deleted )SELECT UserName,_ApplicationNo,'Case Officer',NOW(),_userID,0 from casedetails where ApplicationNo=_ApplicationNo and PrimaryOfficer=1 and Deleted=0;

call Saveapplicationsequence(_ApplicationNo,'Judicial Review','Judicial Review',_userID); 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
  if(_Court='HIGH COURT')THEN
    Begin
  update applications set Status='JR-HIGH COURT' where ApplicationNo=_ApplicationNo;
END;
  ENd if;

  if(_Court='COURT OF APPEAL')THEN
    Begin
  update applications set Status='JR-COURT OF APPEAL' where ApplicationNo=_ApplicationNo;
END;
  ENd if;  if(_Court='SUPREME COURT')THEN
    Begin
  update applications set Status='JR-SUPREME COURT' where ApplicationNo=_ApplicationNo;
END;
  ENd if;
End//
DELIMITER ;

-- Dumping structure for procedure arcm.Savejudicialreviewdocuments
DROP PROCEDURE IF EXISTS `Savejudicialreviewdocuments`;
DELIMITER //
CREATE  PROCEDURE `Savejudicialreviewdocuments`(IN _ApplicationNo VARCHAR(50), IN _Name VARCHAR(100), IN _Description VARCHAR(255), IN _Path VARCHAR(155), 
  IN _UserID VARCHAR(50),IN _DocumentDate varchar(50),IN _ActionDate varchar(50),IN _ActionDescription VARCHAR(255))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Submited Judicial Review Document for Application: ',_ApplicationNo);
insert into judicialreviewdocuments (ApplicationNo ,Name ,Description ,Path , Created_At,Deleted,DocumentDate ,ActionDate,ActionDescription)
  VALUES(_ApplicationNo,_Name,_Description,_Path,now(),0,_DocumentDate,_ActionDate,_ActionDescription);
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

-- Dumping structure for procedure arcm.SaveMpesaTransactions
DROP PROCEDURE IF EXISTS `SaveMpesaTransactions`;
DELIMITER //
CREATE  PROCEDURE `SaveMpesaTransactions`(IN `_TransactionType` VARCHAR(100), IN `_TransID` VARCHAR(100), IN `_TransTime` VARCHAR(100), 
  IN `_TransAmount` FLOAT, IN `_BusinessShortCode` VARCHAR(100), IN `_BillRefNumber` VARCHAR(100), IN `_InvoiceNumber` VARCHAR(100),
  IN `_OrgAccountBalance` VARCHAR(100), IN `_ThirdPartyTransID` VARCHAR(100), IN `_MSISDN` VARCHAR(100), IN `_FirstName` VARCHAR(100),
  IN `_MiddleName` VARCHAR(100), IN `_LastName` VARCHAR(100))
    NO SQL
insert into mpesatransactions (
  TransactionType,
  TransID ,
  TransTime ,
  TransAmount ,
  BusinessShortCode ,
  BillRefNumber ,
  InvoiceNumber ,
  OrgAccountBalance ,
  ThirdPartyTransID ,
  MSISDN ,
  FirstName ,
  MiddleName ,
  LastName,
  Confirmed
)Values
  (_TransactionType,
  _TransID ,
  _TransTime ,
  _TransAmount ,
  _BusinessShortCode ,
  _BillRefNumber ,
  _InvoiceNumber ,
  _OrgAccountBalance ,
  _ThirdPartyTransID ,
  _MSISDN ,
  _FirstName ,
  _MiddleName ,
  _LastName,
  0)//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveNotification
DROP PROCEDURE IF EXISTS `SaveNotification`;
DELIMITER //
CREATE  PROCEDURE `SaveNotification`(IN `_UserName` VARCHAR(50), IN `_Category` VARCHAR(50), IN `_Description` VARCHAR(255), IN `_DueDate` DATETIME,IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN
INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
  VALUES (_Username,_Category,_Description,NOW(),_DueDate,'Not Resolved',_ApplicationNo);

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePanel
DROP PROCEDURE IF EXISTS `SavePanel`;
DELIMITER //
CREATE  PROCEDURE `SavePanel`(IN _ApplicationNo VARCHAR(50), IN _Role VARCHAR(100), IN _UserName VARCHAR(50), IN _UserID varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Added new PanelMember for Application ',_ApplicationNo); 
  if(select count(*) FROM panels WHERE ApplicationNo=_ApplicationNo and UserName=_UserName AND Deleted=0)>0 THEN
  Begin
    select '';
  End;
    Else
  Begin
      insert into panels (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By)
      Values (_ApplicationNo,_UserName,'Nominated',_Role,0,now(),_UserID);
       call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
  End;
  End if;
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savepanellist
DROP PROCEDURE IF EXISTS `Savepanellist`;
DELIMITER //
CREATE  PROCEDURE `Savepanellist`(IN _ApplicationNo VARCHAR(50), IN _Path VARCHAR(255), IN _Name VARCHAR(105), IN _UserID VARCHAR(50))
BEGIN
if(select count(*) from panellist where ApplicationNo=_ApplicationNo) <1 THEN
Begin
insert into panellist (  ApplicationNo ,  Path ,  FileName ,  GeneratedOn,GeneratedBy)
  VALUES(_ApplicationNo,_Path,_Name,now(),_UserID);
End;
End IF;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savepartysubmision
DROP PROCEDURE IF EXISTS `Savepartysubmision`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savepartysubmision`(IN _ApplicationNo VARCHAR(50),IN _Description TEXT,IN _Party VARCHAR(50), IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new party submision for Application: ', _ApplicationNo); 
insert into partysubmision (Party, ApplicationNo ,Description,Created_At,Deleted,Created_By )
  VALUES(_Party,_ApplicationNo,_Description,now(),0,_userID);
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePaymentdetails
DROP PROCEDURE IF EXISTS `SavePaymentdetails`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SavePaymentdetails`(IN _ApplicationID BIGINT(20), IN _Paidby VARCHAR(150), IN _Refference VARCHAR(200), IN _DateOfpayment DATE, IN _AmountPaid FLOAT, IN _userID VARCHAR(50), IN _Category VARCHAR(50), IN _PaymentType INT, IN _CHQNO VARCHAR(50), IN _ChequeDate VARCHAR(30))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new payment details for application: ', _ApplicationID); 
  Insert into paymentdetails (ApplicationID,Paidby ,Refference ,DateOfpayment,AmountPaid ,Created_By,Created_At,Category,PaymentType,ChequeDate,CHQNO)
  VALUES(_ApplicationID,_Paidby,_Refference,_DateOfpayment,_AmountPaid,_userID,now(),_Category,_PaymentType,_ChequeDate,_CHQNO);

  call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

  if(_Category='PreliminaryObjectionsFees')THEN
    Begin
      select ApplicationNo from applications where ID=_ApplicationID LIMIT 1 into @AppNo;
      INSERT INTO notifications(Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
     select Username,'Preliminary Objecions Fees Approval','Preliminary objection fees pending confirmation',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',@AppNo
     from approvers where ModuleCode ='PAYMT' and Active=1 and Deleted=0;
  End;
    Else
      update applications set PaymentStatus='Submited' where ID=_ApplicationID;
     -- call CompleteApplication(_ApplicationID,_userID);
      INSERT INTO notifications(Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
      select Username,'Applications Fees Approval','Applications pending fees confirmaion',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationID
      from approvers where ModuleCode ='PAYMT' and Active=1 and Deleted=0;
  Begin
    End;
  End if;
  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Savepaymenttypes
DROP PROCEDURE IF EXISTS `Savepaymenttypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Savepaymenttypes`( IN _Description VARCHAR(100),  IN _userID VARCHAR(50))
    NO SQL
BEGIN

Insert into paymenttypes ( 
  Description, Created_By ,Created_At ,Deleted )Values(_Description,_userID,now(),0);
call SaveAuditTrail(_userID,'Added new Payment type','Add','0' );
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
CREATE  PROCEDURE `SavePEResponse`(IN _ApplicationNo VARCHAR(50), IN _ResponseType VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);

select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
set lSaleDesc= CONCAT(' Responded to application:' ,_ApplicationNo); 

if(SELECT count(*)  from peresponse where ApplicationNo=_ApplicationNo)>0 THEN
BEGIN
update   peresponse set ResponseType=_ResponseType where ApplicationNo=_ApplicationNo;
select 'Already Responded' as msg,ID from peresponse where ApplicationNo=_ApplicationNo;
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

-- Dumping structure for procedure arcm.Saveperesponsebackgroundinformation
DROP PROCEDURE IF EXISTS `Saveperesponsebackgroundinformation`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Saveperesponsebackgroundinformation`(IN _ApplicationNo varchar(50), IN _BackgroundInformation TEXT, IN _ResponseType VARCHAR(50), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Added new PE Response background Information for ApplicationNo:',_ApplicationNo); 
  if(select count(*) from peresponsebackgroundinformation where ApplicationNo=_ApplicationNo )>0 THEN
  begin
 Update peresponsebackgroundinformation set BackgroundInformation=_BackgroundInformation,ResponseType=_ResponseType,Updated_At=now(),Updated_By=_userID where ApplicationNo=_ApplicationNo;


  End;
  Else
  Begin
  Insert into peresponsebackgroundinformation ( ApplicationNo,  BackgroundInformation,  ResponseType ,  Created_At,Created_By)
    VALUES(_ApplicationNo,_BackgroundInformation,_ResponseType,now(),_userID);

  End ;
  End if;


call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
End//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePEResponseDetails
DROP PROCEDURE IF EXISTS `SavePEResponseDetails`;
DELIMITER //
CREATE  PROCEDURE `SavePEResponseDetails`(IN _PERsponseID INT, IN _GrounNo VARCHAR(50), IN _Groundtype VARCHAR(50), IN _Response TEXT, IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);

set lSaleDesc= CONCAT('Updated PE Response for Response ID: ',_PERsponseID);
insert into peresponsedetails ( PEResponseID ,  GroundNO ,  GroundType,  Response,  Created_At ,  Created_By, Deleted )
  Values(_PERsponseID,_GrounNo,_Groundtype,_Response,now(),_UserID,0);
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePEresponseDocuments
DROP PROCEDURE IF EXISTS `SavePEresponseDocuments`;
DELIMITER //
CREATE  PROCEDURE `SavePEresponseDocuments`(IN _PEResponseID INT, IN _Name VARCHAR(100), IN _Description VARCHAR(255), IN _Path VARCHAR(155), IN _Confidential Boolean)
BEGIN
insert into peresponsedocuments (PEResponseID ,Name ,Description ,Path , Created_At,Deleted,Confidential )
  VALUES(_PEResponseID,_Name,_Description,_Path,now(),0,_Confidential);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePETimerResponse
DROP PROCEDURE IF EXISTS `SavePETimerResponse`;
DELIMITER //
CREATE  PROCEDURE `SavePETimerResponse`(IN _PEID VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _DueOn DATETIME)
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
CREATE  PROCEDURE `SavePeUsers`(IN _Username VARCHAR(50), IN _PE VARCHAR(50),IN _Name VARCHAR(128), IN _Location VARCHAR(50),
  IN _POBox VARCHAR(50), IN _PostalCode VARCHAR(50), IN _Town VARCHAR(100), IN _Mobile VARCHAR(50), IN _Telephone VARCHAR(50), 
  IN _Email VARCHAR(100),
  IN _Logo VARCHAR(100), IN _Website VARCHAR(100), IN _County VARCHAR(50), 
  IN _RegistrationDate DATETIME, IN _PIN VARCHAR(50), IN _RegistrationNo VARCHAR(50))
BEGIN
  insert into peusers (UserName,PEID,Created_At, Created_by)
  VALUES(_Username,_PE,now(),_Username);
update procuremententity set
  County=_County,
  POBox=_POBox,
  PostalCode=_PostalCode,
  Town=_Town,
  Mobile=_Mobile,
  Telephone=_Telephone,
  Email=_Email,
  Logo=_Logo,
  Website=_Website,
  PIN=_PIN,
  RegistrationNo=_RegistrationNo,
  RegistrationDate=_RegistrationDate,
  Updated_By=_Username,
  Updated_At=now()
  where PEID=_PE;




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
CREATE  PROCEDURE `SaveRB1Form`(IN _ApplicationNo VARCHAR(50), IN _Path VARCHAR(255), IN _Name VARCHAR(105), IN _UserID VARCHAR(50))
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
CREATE  PROCEDURE `SaveRequestforDeadlineExtension`(IN _ApplicationNo VARCHAR(50), IN _Reason TEXT, IN _Newdate DATETIME, IN _UserID VARCHAR(50))
BEGIN
  if(SELECT count(*)  from pedeadlineextensionsrequests where ApplicationNo=_ApplicationNo)<1 THEN
BEGIN
  select PEID from applications where ApplicationNo=_ApplicationNo limit 1 into @PEID;
  insert into pedeadlineextensionsrequests(PEID ,ApplicationNo ,Reason ,RequestedDate,Created_At,Created_By ,Status)
  VALUES(@PEID,_ApplicationNo,_Reason,_Newdate,now(),_UserID,'Pending Approval');

  select Username from approvers where ModuleCode='REXED' and Deleted=0 and Active=1 LIMIT 1 into @Approver;
  insert into deadlineapprovalworkflow(PEID ,ApplicationNo ,Reason ,RequestedDate,Created_At,Created_By ,Status,Approver)
  Select @PEID,_ApplicationNo,_Reason,_Newdate,now(),_UserID,'Pending Approval',Username 
  from approvers where ModuleCode ='REXED' and Active=1 and Deleted=0;
 
  

    if(select count(*) from approvers where ModuleCode ='REXED' and Active=1 and Deleted=0)>0 THEN
    Begin
      INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
      select Username,'Deadline Approval','Deadline Approval Request',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationNo
      from approvers where ModuleCode ='REXED' and Active=1 and Deleted=0;
    End;
    End if; 
     select Name,Email,Phone from users where Username in (Select Username from approvers where ModuleCode ='REXED' and Active=1 and Deleted=0);


END;
ELSE

Begin
Update pedeadlineextensionsrequests set Reason=_Reason,RequestedDate=_Newdate where ApplicationNo=_ApplicationNo; 
Update deadlineapprovalworkflow set Reason=_Reason,RequestedDate=_Newdate,Status='Pending Approval' where ApplicationNo=_ApplicationNo; 
   select Name,Email,Phone from users where Username in (Select Username from approvers where ModuleCode ='REXED' and Active=1 and Deleted=0);

END;

 END IF;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveRequestforReview
DROP PROCEDURE IF EXISTS `SaveRequestforReview`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveRequestforReview`(IN _ApplicationNo VARCHAR(50),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Background Information for decision for Application: ', _ApplicationNo);
if(select count(*) from decisions where ApplicationNo=_ApplicationNo) >0 THEN
BEGIN
  update decisions set RequestforReview=_Description,Updated_At=now(),Updated_By=_userID WHERE ApplicationNo=_ApplicationNo;
  call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END;
Else
Begin
insert into decisions ( Status , ApplicationNo , RequestforReview, Created_At , Created_By )
  VALUES('Draft',_ApplicationNo,_Description,now(),_userID);
call Saveapplicationsequence(_ApplicationNo,'Decision preparation','Closed',_userID); 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );
End;
end if;
 


  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveRole
DROP PROCEDURE IF EXISTS `SaveRole`;
DELIMITER //
CREATE  PROCEDURE `SaveRole`(IN `_RoleName` VARCHAR(50), IN `_RoleDescription` VARCHAR(128), IN `_UserID` VARCHAR(50))
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
CREATE  PROCEDURE `SaveSchedule`(IN _Username VARCHAR(50), IN _start DATETIME, IN _end DATETIME, IN _title VARCHAR(255))
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
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SaveTender`(IN _TenderNo VARCHAR(100), IN _Name VARCHAR(150), IN _PEID VARCHAR(50), IN _StartDate DATETIME,
  IN _ClosingDate DATETIME, IN _userID VARCHAR(50), IN _TenderValue FLOAT, IN _TenderType VARCHAR(50),
  IN _TenderSubCategory VARCHAR(50), IN _TenderCategory VARCHAR(50), IN _Timer  VARCHAR(155))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new Tender with TenderNo:',_TenderNo); 

INSERT INTO `tenders`( `TenderNo`, `Name`, `PEID`,TenderValue, `StartDate`, `ClosingDate`,AwardDate, `Created_By`, `Created_At`, 
  `Updated_At`,  `Deleted`,TenderType,TenderSubCategory,TenderCategory,Timer) 
VALUES (_TenderNo,_Name,_PEID,_TenderValue,_StartDate,_StartDate,_ClosingDate,_userID,now(),now(),0,_TenderType,
  _TenderSubCategory,_TenderCategory,_Timer);

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
CREATE  PROCEDURE `SaveUser`(IN _Name VARCHAR(120), IN _Email VARCHAR(128), IN _Password VARCHAR(128), IN _UserGroupID BIGINT, IN _Username VARCHAR(50), IN _userID VARCHAR(50), IN _Phone VARCHAR(20), IN _Signature VARCHAR(128), IN _IsActive BOOLEAN, IN _IDnumber VARCHAR(50), IN _DOB DATETIME, IN _Gender VARCHAR(50), IN _ActivationCode VARCHAR(50), IN _Board BOOLEAN)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Added new User with username:',_Username); 

INSERT INTO `users`(`Name`, `Username`, `Email`, `Phone`,`Password`, `Create_at`,  `Deleted`, `IsActive`, `IsEmailverified`,ActivationCode, `UserGroupID`,CreatedBy,Category,Signature,Photo,IDnumber,Gender,DOB,ChangePassword,Board) 

VALUES (_Name,_Username,_Email,_Phone,_Password,now(),0,_IsActive,0,_ActivationCode,_UserGroupID,_userID,'System_User',_Signature,'default.png',_IDnumber,_Gender,_DOB,1,_Board);

call SaveAuditTrail(_userID,lSaleDesc,'Add','0' );

INSERT INTO `useraccess`(`Username`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`) SELECT _Username,RoleID,Edit,Remove,AddNew,View,Export,_userID,_userID,NOW(),NOW() FROM groupaccess WHERE UserGroupID=_UserGroupID;

End//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveuserAcces
DROP PROCEDURE IF EXISTS `SaveuserAcces`;
DELIMITER //
CREATE  PROCEDURE `SaveuserAcces`(IN `_Username` VARCHAR(50), IN `_RoleID` BIGINT, IN `_Edit` BOOLEAN, IN `_Remove` BOOLEAN, IN `_AddNew` BOOLEAN, IN `_View` BOOLEAN, IN `_Export` BOOLEAN, IN `_userID` VARCHAR(50))
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
CREATE  PROCEDURE `SaveUserGroup`(IN `_Name` VARCHAR(128), IN `_Description` VARCHAR(128), IN `_userID` VARCHAR(50))
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
CREATE  PROCEDURE `Savevenues`(in _Name VARCHAR(100),IN _Description VARCHAR(150),IN _UserID varchar(50),IN _Branch INT)
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
DELETE FROM `schedules`;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;

-- Dumping structure for procedure arcm.selfAttendanceregistration
DROP PROCEDURE IF EXISTS `selfAttendanceregistration`;
DELIMITER //
CREATE  PROCEDURE `selfAttendanceregistration`(IN _RegisterID INT(11), IN _Name VARCHAR(100), IN _IDNO VARCHAR(50), IN _MobileNo VARCHAR(50), IN _Category VARCHAR(55)
  , IN _UserID VARCHAR(50), IN _Email VARCHAR(100),IN _Designation VARCHAR(100),IN _FirmFrom VARCHAR(100))
BEGIN
if(SELECT count(*)  from attendanceregister where IDNO=_IDNO and RegisterID=_RegisterID)=0 THEN
BEGIN

DECLARE lSaleDesc varchar(200);
select ApplicationNo from casesittingsregister where ID=_RegisterID LIMIT 1 into @ApplicationNo;
set lSaleDesc= CONCAT('Attended hearing for Application:',@ApplicationNo); 
INSERT INTO attendanceregister (RegisterID ,IDNO,MobileNo ,Name,Email ,Category ,Created_At,Created_By,Designation,FirmFrom)
VALUES(_RegisterID,_IDNO,_MobileNo,_Name,_Email,_Category,now(),_UserID,_Designation,_FirmFrom);
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
DELETE FROM `sentsms`;
/*!40000 ALTER TABLE `sentsms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sentsms` ENABLE KEYS */;

-- Dumping structure for procedure arcm.SetMaxApproval
DROP PROCEDURE IF EXISTS `SetMaxApproval`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `SetMaxApproval`(IN _MaximumApprovers INT, IN _ModuleCode VARCHAR(50), IN _UserID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);

DECLARE NewCode varchar(50);
set lSaleDesc= CONCAT('Updated Maximum Approvals for Module' ,_ModuleCode); 

Update approvalmodules set MaxApprovals=_MaximumApprovers where  ModuleCode=_ModuleCode;

call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );

 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SetSentHearingNotice
DROP PROCEDURE IF EXISTS `SetSentHearingNotice`;
DELIMITER //
CREATE  PROCEDURE `SetSentHearingNotice`(IN _ApplicationNo VARCHAR(50))
BEGIN

Update hearingnotices set DateSent=now() where ApplicationNo=_ApplicationNo;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Signup
DROP PROCEDURE IF EXISTS `Signup`;
DELIMITER //
CREATE  PROCEDURE `Signup`(IN _Name VARCHAR(120), IN _Username VARCHAR(50), IN _Email VARCHAR(128), IN _Phone VARCHAR(20), IN _Password VARCHAR(128), IN _Category VARCHAR(50), IN _ActivationCode VARCHAR(100), IN _IDnumber VARCHAR(50), IN _DOB DATETIME)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
select UserGroupID from usergroups where name='Portal users'   INTO @userGroup; 
set lSaleDesc= CONCAT('New Sign up with username:',_Username); 
INSERT INTO `users`(`Name`, `Username`, `Email`, `Phone`,`Password`, `Create_at`,  `Deleted`, `IsActive`, `IsEmailverified`, `ActivationCode`, `UserGroupID`,CreatedBy,Category,Photo,IDnumber,DOB,ChangePassword) 
VALUES (_Name,_Username,_Email,_Phone,_Password,Now(),0,0,0,_ActivationCode,@userGroup,_Username,_Category,'default.png',_IDnumber,_DOB,0);

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
DELETE FROM `smsdetails`;
/*!40000 ALTER TABLE `smsdetails` DISABLE KEYS */;
INSERT INTO `smsdetails` (`ID`, `SenderID`, `UserName`, `URL`, `Key`) VALUES
	(1, 'WILCOM-TVET', 'ARCM', 'http://api.mspace.co.ke/mspaceservice/wr/sms/sendtext/', '123456');
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
DELETE FROM `smtpdetails`;
/*!40000 ALTER TABLE `smtpdetails` DISABLE KEYS */;
INSERT INTO `smtpdetails` (`ID`, `Host`, `Port`, `Sender`, `Password`) VALUES
	(1, 'smtp.gmail.com', 465, 'arcmdevelopment@gmail.com\r\n', 'Arcm1234');
/*!40000 ALTER TABLE `smtpdetails` ENABLE KEYS */;

-- Dumping structure for procedure arcm.sp_ValidatePrivilege
DROP PROCEDURE IF EXISTS `sp_ValidatePrivilege`;
DELIMITER //
CREATE  PROCEDURE `sp_ValidatePrivilege`(IN `_Username` VARCHAR(50), IN `_RoleName` VARCHAR(128))
    NO SQL
BEGIN
SELECT `Username`, useraccess.RoleID, `Edit`, `Remove`, `AddNew`, `View`, `Export` FROM `useraccess` 
inner join roles on useraccess.RoleID=roles.RoleID  where Username=_Username and roles.RoleName=_RoleName;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.stdtenderdocs: ~0 rows (approximately)
DELETE FROM `stdtenderdocs`;
/*!40000 ALTER TABLE `stdtenderdocs` DISABLE KEYS */;
/*!40000 ALTER TABLE `stdtenderdocs` ENABLE KEYS */;

-- Dumping structure for procedure arcm.SubmitApplicationdecision
DROP PROCEDURE IF EXISTS `SubmitApplicationdecision`;
DELIMITER //
CREATE  PROCEDURE `SubmitApplicationdecision`(IN _ApplicationNo varchar(50),IN _UserID varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Submited Decision for Application: ',_ApplicationNo); 

    INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status)
    select Username,'Decision Approval','Decision Report Awaiting Approval',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved'
    from approvers where ModuleCode ='DCAPR' and Active=1 and Deleted=0;

   call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );

   call Saveapplicationsequence(_ApplicationNo,'Decision Report','Awaiting Decision Report Approval',_UserID);
  select Name,Email,Phone, _ApplicationNo as ApplicationNo from users where Username in 
  (select Username from approvers where ModuleCode ='DCAPR' and Active=1 and Deleted=0);
  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SubmitApprovedPanelList
DROP PROCEDURE IF EXISTS `SubmitApprovedPanelList`;
DELIMITER //
CREATE  PROCEDURE `SubmitApprovedPanelList`(IN _UserID varchar(50),IN _ApplicationNo varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);

call ResolveMyNotification(_UserID,'Panel Approval',_ApplicationNo);
 DROP TABLE IF EXISTS PanelApprovalContacts;
 create table PanelApprovalContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Msg varchar(50),ApplicationNo varchar(50));

    
                 
                   
select IFNULL(count(*),0) from approvers WHERE Mandatory=1 and ModuleCode='PAREQ' and Deleted=0 into @CountMandatory;
select IFNULL(count(*),0) from panelsapprovalworkflow  WHERE  `ApplicationNo`=_ApplicationNo and Status='Approved' and 
  Approver in (select Username from approvers WHERE Mandatory=1 and ModuleCode='PAREQ' and Deleted=0) into @CountMandatoryApproved;

select IFNULL(MaxApprovals,0) from approvalmodules where  ModuleCode ='PAREQ' LIMIT 1 into @MaxApprovals;
select IFNULL(count(*),0) from panelsapprovalworkflow  WHERE   `ApplicationNo`=_ApplicationNo and Status='Approved' and 
Approver in (select Username from approvers WHERE Mandatory=0 and Deleted=0 and ModuleCode='PAREQ')
  into @CountApproved;

    if @CountMandatoryApproved >= @CountMandatory  THEN
    BEGIN
          if @CountApproved >= @MaxApprovals  THEN
            update panelsapprovalworkflow  set Status='Approved',Approver=_UserID, Approved_At=now() where ApplicationNo=_ApplicationNo  and Status='Pending Approval'; 
           BEGIN
            update notifications set Status='Resolved' where Category='Panel Approval' and  ApplicationNo=_ApplicationNo;  
              select ifnull(UserName,_UserID) from casedetails where ApplicationNo=_ApplicationNo and PrimaryOfficer=1 and Status='Open' LIMIT 1 into @Approver;
              call SaveNotification(@Approver,'Case Scheduling','Applications Hearing date scheduling',DATE_ADD(NOW(), INTERVAL 3 DAY),_ApplicationNo);                
              call Saveapplicationsequence(_ApplicationNo,'Approved PanelList','Awaiting Hearing Date scheduling',_UserID);           
              insert into PanelApprovalContacts select Name,Email,Phone,'Case Officer',_ApplicationNo from users where Username=@Approver;              
              insert into PanelApprovalContacts select Name,Email,Phone,'Panel',_ApplicationNo from users inner join panels on panels.UserName=users.Username 
              where panels.ApplicationNo=_ApplicationNo and panels.Deleted=0 and panels.Status='Approved';
              
           End;
           else
           Begin
            update Panels set Status='Partially Approved' where ApplicationNo=_ApplicationNo and Status='Approved'; 
            insert into panelsapprovalworkflow (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By)
            select ApplicationNo , UserName ,'Pending Approval',Role , Deleted , Created_At,Created_By from panels where panels.ApplicationNo=_ApplicationNo and Deleted=0;
            insert into PanelApprovalContacts
            select Name,Email,Phone, 'Approver',_ApplicationNo from users where Username in 
           (select Username from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0) 
            AND Username not in (select Approver from panelsapprovalworkflow WHERE ApplicationNo=_ApplicationNo and Status='Approved');
           End;
           End if;
     End;
     ELSE
          Begin
            update Panels set Status='Partially Approved' where ApplicationNo=_ApplicationNo and Status='Approved'; 
             insert into panelsapprovalworkflow (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By)
             select ApplicationNo , UserName ,'Pending Approval',Role , Deleted , Created_At,Created_By from panels where panels.ApplicationNo=_ApplicationNo and Deleted=0;
              insert into PanelApprovalContacts
          select Name,Email,Phone, 'Approver',_ApplicationNo from users where Username in 
           (select Username from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0) 
            AND Username not in (select Approver from panelsapprovalworkflow WHERE ApplicationNo=_ApplicationNo and Status='Approved');
          End;
          End if;
  select * FROM PanelApprovalContacts;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SubmitCaseDecision
DROP PROCEDURE IF EXISTS `SubmitCaseDecision`;
DELIMITER //
CREATE  PROCEDURE `SubmitCaseDecision`(IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50), IN _DecisionDate DATE, IN _Followup BOOLEAN, IN _Referral BOOLEAN, IN _Closed BOOLEAN, IN _ApplicationSuccessful BOOLEAN, IN _Annulled BOOLEAN, IN _GiveDirection BOOLEAN, IN _Terminated BOOLEAN, IN _ReTender BOOLEAN, IN _CostsPE BOOLEAN, IN _CostsApplicant BOOLEAN, IN _CostsEachParty BOOLEAN, IN _Substitution BOOLEAN)
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Submited Decision for Application: ',_ApplicationNo); 
UPDATE applications set  DecisionDate =_DecisionDate,
  Followup =_Followup,
  Referral =_Referral, 
  Status='Closed',  
  Closed=1,
  Annulled=_Annulled,
  GiveDirection=_GiveDirection,
  ISTerminated=_Terminated,
  ReTender=_ReTender,
  CostsPE=_CostsPE,
  CostsEachParty=_CostsEachParty,
  CostsApplicant=_CostsApplicant,
  Substitution=_Substitution,
  ApplicationSuccessful=_ApplicationSuccessful where ApplicationNo=_ApplicationNo;
  update decisions set Status='Pending Approval' where ApplicationNo=_ApplicationNo;
  call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
    select Name,Email,Phone, _ApplicationNo as ApplicationNo from users where Username in 
  (select Username from approvers where ModuleCode ='DCAPR' and Active=1 and Deleted=0);
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SubmitPanelList
DROP PROCEDURE IF EXISTS `SubmitPanelList`;
DELIMITER //
CREATE  PROCEDURE `SubmitPanelList`(IN _UserID varchar(50),IN _ApplicationNo varchar(50))
BEGIN
 DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Submited PanelList  for Application: ',_ApplicationNo); 
  Update peresponse set PanelStatus='Submited' where peresponse.ApplicationNo=_ApplicationNo;

 -- select Username from approvers where ModuleCode='PAREQ' and Level=1 and Deleted=0 and Active=1  limit 1 into @Approver;
  insert into panelsapprovalworkflow (ApplicationNo , UserName ,Status,Role , Deleted , Created_At,Created_By)
  select ApplicationNo , UserName ,'Pending Approval',Role , Deleted , Created_At,Created_By from panels where panels.ApplicationNo=_ApplicationNo and Deleted=0; 

  -- call SaveNotification(@Approver,'Panel Approval','Panel Lists Awiting Approval',DATE_ADD(NOW(), INTERVAL 3 DAY));  

    INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
    select Username,'Panel Approval','Panel Lists Awiting Approval',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationNo
    from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0;

   call SaveAuditTrail(_UserID,lSaleDesc,'Add','0' );
  -- call ResolveMyNotification(_UserID,'Panel Formation',_ApplicationNo);
update notifications set Status='Resolved' where Category='Panel Formation' and  ApplicationNo=_ApplicationNo; 
   call Saveapplicationsequence(_ApplicationNo,'Submited Hearing Panel','Awaiting Panel Approval',_UserID);
  select Name,Email,Phone, _ApplicationNo as ApplicationNo from users where Username in 
  (select Username from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0);
  
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SubmitPePreliminaryObjection
DROP PROCEDURE IF EXISTS `SubmitPePreliminaryObjection`;
DELIMITER //
CREATE  PROCEDURE `SubmitPePreliminaryObjection`(IN _RespID INT, IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
  
  update peresponse set status='Fees Pending Confirmation' where ID=_RespID and ApplicationNo=_ApplicationNo;
   update peresponsetimer set status='Submited' where  ApplicationNo=_ApplicationNo;
  call Saveapplicationsequence(_ApplicationNo,'Procuring Entity Submited her Response','Awaiting Pleriminary Fees Confirmation',_UserID);
 

  DROP TABLE IF EXISTS PEResponseContacts;
  create table PEResponseContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Role varchar(50));

  insert into PEResponseContacts select Name,Email,Phone,'Incomplete' from users
  inner join approvers on approvers.Username=users.Username
  where approvers.ModuleCode='PAYMT' and approvers.Deleted=0 and Active=1;   

   insert into PEResponseContacts select Name,Email,Mobile,'Interested Parties' from interestedparties where ApplicationID= @ApplicationID;
   insert into PEResponseContacts select Name,Email,Phone,'Case officer' from users where Username in 
   (select UserName from casedetails where ApplicationNo=_ApplicationNo);
   select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant1;
   insert into PEResponseContacts select Name,Email,Phone,'Applicant' from users where Username =@Applicant1;

  select * from PEResponseContacts;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SubmitPeResponse
DROP PROCEDURE IF EXISTS `SubmitPeResponse`;
DELIMITER //
CREATE  PROCEDURE `SubmitPeResponse`(IN _RespID INT, IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50))
BEGIN
  
  update peresponse set status='Submited' where ID=_RespID and ApplicationNo=_ApplicationNo;
     update peresponsetimer set status='Submited' where  ApplicationNo=_ApplicationNo;
  call Saveapplicationsequence(_ApplicationNo,'Procuring Entity Submited her Response','Awaiting Panel Formation',_UserID);


   if(select count(*) from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0)>0 THEN
              Begin
                    INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
                 select Username,'Panel Formation','Applications Awating Panel Formation',now(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Not Resolved',_ApplicationNo
                 from approvers where ModuleCode ='PAREQ' and Active=1 and Deleted=0;
   End;
   End if;



  DROP TABLE IF EXISTS PEResponseContacts;
   create table PEResponseContacts(Name varchar(100),Email varchar(150),Mobile varchar(50),Role varchar(50));
   select ID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @ApplicationID;
   select PEID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @PEID;
   select UserName from peusers where PEID=@PEID LIMIT 1 into @Applicant;

   insert into PEResponseContacts select Name,Email,Phone,'PE' from users where Username =@Applicant;
   insert into PEResponseContacts select Name,Email,Mobile,'Interested Parties' from interestedparties where ApplicationID= @ApplicationID;
   insert into PEResponseContacts select Name,Email,Phone,'Case officer' from users where Username in 
   (select UserName from casedetails where ApplicationNo=_ApplicationNo);
   select Created_By from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @Applicant1;
   insert into PEResponseContacts select Name,Email,Phone,'Applicant' from users where Username =@Applicant1;
   
  select * from PEResponseContacts;

END//
DELIMITER ;

-- Dumping structure for table arcm.table 94
DROP TABLE IF EXISTS `table 94`;
CREATE TABLE IF NOT EXISTS `table 94` (
  `PEID` varchar(6) DEFAULT NULL,
  `Name` varchar(68) DEFAULT NULL,
  `PEType` varchar(42) DEFAULT NULL,
  `County` varchar(10) DEFAULT NULL,
  `Location` varchar(128) DEFAULT NULL,
  `POBox` varchar(76) DEFAULT NULL,
  `PostalCode` varchar(5) DEFAULT NULL,
  `Town` varchar(10) DEFAULT NULL,
  `Mobile` varchar(41) DEFAULT NULL,
  `Telephone` varchar(65) DEFAULT NULL,
  `Email` varchar(64) DEFAULT NULL,
  `Logo` varchar(10) DEFAULT NULL,
  `Physical Address` varchar(128) DEFAULT NULL,
  `Website` varchar(65) DEFAULT NULL,
  `Created_By` varchar(5) DEFAULT NULL,
  `Created_At` varchar(10) DEFAULT NULL,
  `Updated_At` varchar(10) DEFAULT NULL,
  `Updated_By` varchar(10) DEFAULT NULL,
  `Deleted` int(1) DEFAULT NULL,
  `Deleted_By` varchar(10) DEFAULT NULL,
  `Deleted_At` varchar(10) DEFAULT NULL,
  `RegistrationDate` varchar(10) DEFAULT NULL,
  `PIN` varchar(10) DEFAULT NULL,
  `RegistrationNo` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table arcm.table 94: ~411 rows (approximately)
DELETE FROM `table 94`;
/*!40000 ALTER TABLE `table 94` DISABLE KEYS */;
INSERT INTO `table 94` (`PEID`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Physical Address`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`, `RegistrationDate`, `PIN`, `RegistrationNo`) VALUES
	('PE-1', 'Public Procurement Regulatory Authority', 'State Corporation', '', 'National Bank Building', '58535', '200', 'nairobi', '2.55E+11', '232.5341868', 'bgitonga@ppra.go.ke', '', 'National Bank Building', 'ppra.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-2', 'ICT Authority', 'State Corporation', '', ' Telposta Towers 12th Floor', '27150', '100', '', '2.55E+11', '2.54E+11', 'stephen.mwaura@ict.go.ke', '', ' Telposta Towers 12th Floor', 'www.icta.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-3', 'Kenya National Qualification Authority', 'State Corporation', '', 'Nairobi', '123', '', '', '2.55E+11', '2.55E+11', 'sammuel.angulu@yauu.com', '', 'Nairobi', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-4', 'Ewaso Ng\'iro North Development Authority ', 'State Corporation', '', 'Isiolo', '203', '60300', '', '2.55E+11', '2.55E+11', 'benard.omwoyo@yahoo.com', '', 'Isiolo', 'www.ennda.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-5', 'Ministry of Interior and Coordination of National Governments', 'Ministry', '', '720911263', '720911263', '', '', '2.55E+11', '2.55E+11', 'muirurikarii@yahoo.com', '', '720911263', 'www.interior.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-6', 'Kirinyaga University', 'Public Universities', '', ' Kutus', 'P.O Box 143-10300 ', '', 'Kerugoya', '2.55E+11', '-487291', 'athiong\'o@kyu.ac.ke', '', ' Kutus', 'www.kyu.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-7', 'Kenya Copyright Board ', 'State Corporation', '', '5th Floor NHIF Building - Community Ragati Road/Ngong Road', '34670 - 00100 ', '', '', '2.55E+11', '2.55E+11', 'mokwaro@copyright.go.ke', '', '5th Floor NHIF Building - Community Ragati Road/Ngong Road', 'www.copyright.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-8', 'School Equipment Production Unit', 'State Corporation', '', 'Inside University of Nairobi,Kenya Science Campus,Ngong Road', 'P.O Box 25140-00603', '', '', '725291217', '724256046', 'info@sepu.co.ke', '', 'Inside University of Nairobi,Kenya Science Campus,Ngong Road', 'www.schoolequipment.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-9', 'National Oil Corporation Of Kenya', 'State Corporation', '', 'Kawi House, South C.', '58576 -00200', '', '', '+254 20 6952000', '+254 20 6952000', 'modiwa@noilkenya.co.ke', '', 'Kawi House, South C.', 'www.nationaloil.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-10', 'Kenya School Of Government', 'State Corporation', '', 'Lower Kabete', '23030', '604', '', '020 401 5000/1-30', '727496698', 'director@ksg.ac.ke', '', 'Lower Kabete', 'www.ksg.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-11', 'Kenya Industrial Property Institute', 'State Corporation', '', 'Weights and measures Premises, Popo Road-South c', '516648', '200', '', '2.55E+11', '020-602210/0702002020', 'Info@kipi.go.ke', '', 'Weights and measures Premises, Popo Road-South c', 'www.kipi.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-12', 'Kenya School Of Law', 'State Corporation', '', 'Karen -Langata South Road', '30369', '100', '', '2.55E+11', '2.55E+11', 'eowuor@ksl.ac.ke', '', 'Karen -Langata South Road', 'www.ksl.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-13', 'The East African Portland Cement Company', 'State Corporation', '', 'Off Namanga Road', 'PO BOX 20 ', '204', 'Athi River', '2.55E+11', '2.55E+11', 'duncan.odhiambo@eapcc.co.ke', '', 'Off Namanga Road', 'www.eastafricanportland.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-14', 'Kenya Marine and fisheries Research Institute', 'State Corporation', '', '721743373', '721743373', '', '', '2.55E+11', '2.55E+11', 'jarnya6@gmail.com', '', '721743373', 'www.kmfri.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-15', 'Kenya Deposit Insurance Corporation', 'State Corporation', '', '1st floor-CBK Pension house', '45983-00100', '', '', '2.55E+11', '2.55E+11', 'sukantetr@depositinsurance.go.ke', '', '1st floor-CBK Pension house', 'www.depositinsurance.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-16', 'Competition Authority of Kenya', 'State Corporation', '', ' Kenya Railways HQs Block ', '+254 20277900', '', '', '+254 20277900', '2.55E+11', 'lchesaina@cak.go.ke', '', ' Kenya Railways HQs Block ', 'www.cak.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-17', 'Kenya Railways ', 'State Corporation', '', 'Workshop Road, Off Haile Selassie Avenue, Nairobi', 'P.O. Box 30121 - 00100, NAIROBI', '', '', '2.55E+11', '2.55E+11', 'jkairianja@krc.co.ke', '', 'Workshop Road, Off Haile Selassie Avenue, Nairobi', 'www.krc.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-18', 'National Museums of Kenya', 'State Corporation', '', '0', '40658-00100, Nairobi.', '', '', '2.55E+11', '2.55E+11', 'dkariuki@museums.or.ke', '', '0', 'www.museums.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-19', 'Rivatex East Africa limited ', 'State Corporation', '', ' ELDORET-OFF KISUMU ROAD-KIPKAREN ROAD', '4744-300 Eldoret', '', '', '053 2030903', '+053 2030903', 'info@rivatex.co.ke', '', ' ELDORET-OFF KISUMU ROAD-KIPKAREN ROAD', 'www.rivatex.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-20', 'Kenya Roads Board', 'State Corporation', '', 'Kenya Re Building,Upperhill, 3rd Flr', 'PO Box 73718 00100 Nairobi', '', '', '2.55E+11', '+254(020) 2722865', 'info@krb.go.ke', '', 'Kenya Re Building,Upperhill, 3rd Flr', 'Www.krb.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-21', 'Kenya Agricultural & Livestock Research Organization', 'State Corporation', '', 'KAPTAGAT ROAD', '57811-00200', '', '', '2.55E+11', '2.55E+11', 'george.ayogo@kalro.org', '', 'KAPTAGAT ROAD', 'www.kalro.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-22', 'Export Processing Zones Authority', 'State Corporation', '', 'Viwanda Road  off Nairobi-Namanga Highway', '50563-00200 Nairobi ', '', '', '2.55E+11', '2.55E+11', 'edgar.abayo@epzakenya.com', '', 'Viwanda Road  off Nairobi-Namanga Highway', 'www.epzakenya.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-23', 'Water Resources Authority', 'State Corporation', '', ' NHIF BUILDING RAGATI ROAD OFF NGONG ROAD, 9TH FLOOR WING B', '45250-00100', '', '', '2.55E+11', '2.55E+11', 'procurement.wrma@gmail.com', '', ' NHIF BUILDING RAGATI ROAD OFF NGONG ROAD, 9TH FLOOR WING B', 'www.wra.go.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-24', 'Kenya literature Bureau ', 'State Corporation', '', 'South C', '30022 - 00100', '', '', '2.55E+11', '0203541196/7', 'esawe@klb.co.ke', '', 'South C', 'www.klb.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-25', 'Moi Teaching and Referral Hostipal', 'State Corporation', '', '30100', '3', '', '', '2.55E+11', '2.55E+11', 'samsonkoiyet@mtrh.go.ke', '', '30100', 'www.mtrh.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-26', 'Ewaso Ngiro South Development Authority', 'State Corporation', '', 'Off Narok Bomet Road', '213 Narok', '', '', '2.55E+11', '020 4409775 (4)', 'md.ensda@gmail.com', '', 'Off Narok Bomet Road', 'www.ensda.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-27', 'Public Service Commission', 'Commissions and Independent Offices', '', ' commission house-harambee avenue', '30095-00100 NAIROBI', '', '', '2.55E+11', '020227471/5', 'psck@publicservice.go.ke', '', ' commission house-harambee avenue', 'https://www.publicservice.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-28', 'Kenya Rural Roads Authority ', 'State Corporation', '', ' Blue Shield Towers, Hospital Road, Upper Hill ', '48151-00100 NAIROBI', '', '', '020-8013846, 2710451, 2710464', '2.55E+11', 'roy.makau@kerra.go.ke', '', ' Blue Shield Towers, Hospital Road, Upper Hill ', 'www.kerra.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-29', 'National Irrigation Board', 'State Corporation', '', 'purchasing@nib.or.ke', 'P.O Box 30372-00100,Nairobi,Kenya', '', '', '\\N', '+254 (0) 711060000/722321653', 'enquries@nib.or.ke\\', '', 'purchasing@nib.or.ke', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-30', 'Kenya National Highway Authority', 'State Corporation', '', 'Blue Shield Towers, Hospital Road, Upper Hill', '49712-00100, NAIROBI', '', '', '+254722842781 / 020 4954003/2', '+254700423606 / 020 4954000', 'r.kilel@kenha.co.ke', '', 'Blue Shield Towers, Hospital Road, Upper Hill', 'www.kenha.co.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-31', 'Insurance Regulatory Authority', 'State Corporation', '', 'Zep-Re Place Longonot Road, Upperhill Nairobi', '43505-00100', '', '', '2.55E+11', '2.55E+11', 'dcherono@ira.go.ke', '', 'Zep-Re Place Longonot Road, Upperhill Nairobi', 'www.ira.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-32', 'Kenya Universities and Colleges central placement service ', 'State Corporation', '', 'ACK Garden House, 1st Ngong Avenue, community-Nairobi', '105166- 00101, Nairobi', '', '', '2.55E+11', '2.55E+11', 'bnyambura@kuccps.ac.ke', '', 'ACK Garden House, 1st Ngong Avenue, community-Nairobi', 'https://www.kuccps.net/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-33', 'Kenya Medical Laboratory Technician & Technologist Board', 'State Corporation', '', '  1st ngong avenue ', '20889-00202', '', '', '2.55E+11', '2.55E+11', 'procurement@kmlttb.org', '', '  1st ngong avenue ', 'www.kmlttb.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-34', 'National Drought Management Authority', 'State Corporation', '', 'LONRHO HOUSE', '53547-00200-NAIROBI', '', '', '2.55E+11', '2.55E+11', 'rahma.ahmed@ndma.go.ke', '', 'LONRHO HOUSE', 'www.ndma.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-35', 'Uwezo Fund Oversight Board', 'State Department', '', 'Lonhro House', '42009 - 00100', '', '', '2.55E+11', '2.55E+11', 'enjagi@uwezo.go.ke', '', 'Lonhro House', 'www.uwezo.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-36', 'Communications Authority of Kenya ', 'State Corporation', '', '703042001', '14448-00800', '', '', '2.55E+11', '2.55E+11', 'waweru@ca.go.ke', '', '703042001', 'WWW.CA.GO.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-37', 'Tana Water Service Board', 'State Corporation', '', 'MAJI HOUSE, ALONG BADEN POWELL ROAD P.O. BOX, 1292 ??? 10100. Nyeri, Kenya', '1292', '', '', '2.55E+11', '2.55E+11', 'jgithinji@tanawsb.or.ke', '', 'MAJI HOUSE, ALONG BADEN POWELL ROAD P.O. BOX, 1292 ??? 10100. Nyeri, Kenya', 'www.tanawsb.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-38', 'Kenya Post Office Saving Bank', 'State Corporation', '', 'POSTBANK HOUSE , BANDA STREET NAIROBI', 'Box 30313-00100 Nairobi', '', '', '2.55E+11', '2.55E+11', 'kimosopjj@postbank.co.ke', '', 'POSTBANK HOUSE , BANDA STREET NAIROBI', 'www.postbank.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-39', 'Kenya Airport Authority', 'State Corporation', '', 'JKIA NAIROBI', '19001 - 00501', '', '', '2.55E+11', '2.55E+11', 'alfred.baliach@kaa.go.ke', '', 'JKIA NAIROBI', 'www.kaa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-40', 'Kenya Ordnance factories corporation ', 'State Corporation', '', '725525803', '725525803', '', '', '725525803', '725525803', 'dnyakamoro@ymail.com', '', '725525803', 'info@kofc.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-41', 'National Construction Authority', 'State Corporation', '', '9TH FLOOR KCB Towers upper Hill, Kenya Road', '21046-00100 Nairobi', '', '', '2.55E+11', '2.55E+11', 'j.kolani@nca.go.ke', '', '9TH FLOOR KCB Towers upper Hill, Kenya Road', 'www.nca.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-42', 'National Council for Persons with Disabilities', 'State Corporation', '', 'Kabete Orthopedic Compound,Waiyaki Way, Opposite ABC Place.', '66577-00800', '', '', '2.55E+11', '2.54E+11', 'daniel.njuguna@ncpwd.go.ke', '', 'Kabete Orthopedic Compound,Waiyaki Way, Opposite ABC Place.', 'www.ncpwd.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-43', 'NATIONAL AIDS CONTROL COUNCIL', 'State Corporation', '', 'Landmark Plaza, 8th and 9th Floor Argwings Kodhek Road', '61307 00200 ', '', '', '2.55E+11', '020 2892000/ 2715144/ 2711261', 'nchoge@nacc.or.ke', '', 'Landmark Plaza, 8th and 9th Floor Argwings Kodhek Road', 'www.nacc.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-44', 'National Employment Authority', 'State Corporation', '', 'KASARANI', '25780- 00100 NAIROBI', '', '', '2.55E+11', '207855747', 'jandungu1001@gmail.com', '', 'KASARANI', 'www.nea.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-45', 'The Kenya National Examination Council ', 'State Corporation', '', 'NHC HSE-AGA KHAN WALK', '721839290', '', '', '2.55E+11', '2.55E+11', 'cmurage@knec.ac.ke', '', 'NHC HSE-AGA KHAN WALK', 'https://www.knec.ac.ke/home/index.php', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-46', 'Numerical Machining Complex Limited', 'State Corporation', '', 'Kenya railways Central workshop, Workshop road, Nairobi', '70660- 00400', '', '', '2.55E+11', '2.55E+11', 'joylenemwelu@mail.com', '', 'Kenya railways Central workshop, Workshop road, Nairobi', 'www.nmc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-47', 'National Sports Fund ', 'State Corporation', '', 'Flamingo Towers, Mara Road, 7th floor, Upper Hill', '4644-00200', '', '', '2.55E+11', '0791801225/0780801225', 'info@nationalsportsfund.org', '', 'Flamingo Towers, Mara Road, 7th floor, Upper Hill', 'www.nationalsportsfund.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-48', 'Kenya Water Towers Agency', 'State Corporation', '', 'NHIF Building, Nairobi', 'P O Box 42903-00100 Nairobi', '', '', '2.55E+11', '2.55E+11', 'peterkabiru@gmail.com', '', 'NHIF Building, Nairobi', 'http://www.kwta.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-49', 'Kenya Trade Network Agency ', 'State Corporation', '', 'Head Office 1st Flr Embankment Plaza, Longonot Road, Upper Hill,', 'P.O. Box 36943 - 00200, Nairobi.', '', '', '2.55E+11', '+254 (20) 4965000', 'dkihia@kentrade.go.ke', '', 'Head Office 1st Flr Embankment Plaza, Longonot Road, Upper Hill,', 'https://www.kentrade.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-50', 'Anti-counterfeit Agency', 'State Corporation', '', 'NATIONAL WATER CONSERVATION & PIPELINE CORPORATION BUILDING , 3RD FLOOR, NDUNGA ROAD', '47771 00100', '', '', '2.55E+11', '2.55E+11', 'jmuraguri@aca.go.ke', '', 'NATIONAL WATER CONSERVATION & PIPELINE CORPORATION BUILDING , 3RD FLOOR, NDUNGA ROAD', 'WWW.ACA.GO.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-51', 'Kenya Industrial Research & Development Institute', 'State Corporation', '', 'SOUTH C', 'P.O. Box 30650 ??? 00100, Nairobi, Kenya', '', '', '2.55E+11', ' +254-20-2388216/2393466 ', 'trizanjuguna12@gmail.com', '', 'SOUTH C', 'https://www.kirdi.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-52', 'Kenya National Trading Corporation Ltd.', 'State Corporation', '', 'Yarrow road off Nanyuki Rd ,Industrial Area', '30587-00100', '', '', '725045451', '020-2430861/824', 'kntcl@kntcl.com', '', 'Yarrow road off Nanyuki Rd ,Industrial Area', 'www.kntcl.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-53', 'Kenya National Commission for UNESCO', 'State Corporation', '', '0', '0', '', '', '2.55E+11', '2.55E+11', 'droduogi75@gmail.com', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-54', 'Salaries & Remuneration Commission', 'State Corporation', '', 'Williamson House 6th Floor, 4th Ngong Avenue', 'Box 43126 - 00100', '', '', '25472741237', '0(20) 2710065/81', 'tlumati@src.go.ke', '', 'Williamson House 6th Floor, 4th Ngong Avenue', 'http://www.src.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-55', 'National Council for Population and Development', 'State Corporation', '', 'CHANCERY BUILDING, 4th FLOOR, VALLEY ROAD', 'P.O.BOX 48994-00100, NAIROBI', '', '', '2.55E+11', '2.55E+11', 'pnzoi@ncpd.go.ke', '', 'CHANCERY BUILDING, 4th FLOOR, VALLEY ROAD', 'www.ncpd-ke.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-56', 'National Government Affirmative Action Fund', 'NGAAF', '', '723822165', '723822165', '', '', '2.55E+11', '2.55E+11', 'jmunguti74@gmail.com', '', '723822165', 'WWW.NGAAF.GO.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-57', 'Kenya Tourism Board', 'State Corporation', '', 'Kenya Re Towers, Off Ragati Road, Upper Hill', '30630 - 00100 Nairobi', '', '', '2.54E+11', '2.54E+11', 'mowino@ktb.go.ke', '', 'Kenya Re Towers, Off Ragati Road, Upper Hill', 'www.ktb.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-58', 'Postal Corporation of Kenya', 'State Corporation', '', ' POSTA HOUSE AT POSTA ROAD  NEXT TO NYAYO HOUSE ', '34567-00100', '', '', '0.999975997', '+254 20 324 2600/0719072600 / 0734108120 ', 'info@posta.co.ke', '', ' POSTA HOUSE AT POSTA ROAD  NEXT TO NYAYO HOUSE ', 'WWW.POSTA.CO.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-59', 'Agricultural Development Corporation', 'State Corporation', '', 'Moi Avenue, Development House, 9th and 10th Floor', '47101 - 00100', '', '', '2.55E+11', '2.54E+11', 'wambuikibue@gmail.com', '', 'Moi Avenue, Development House, 9th and 10th Floor', 'www.adc.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-60', 'Kenya Ferry Services', 'State Corporation', '', 'Likoni Peleza', '96242 -80110 Mombasa', '', '', '2.55E+11', '0.485438767', 'procurement@kenyaferry.co.ke/ md@kenyaferry.co.ke', '', 'Likoni Peleza', 'www.kenyaferry.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-61', 'National Biosafety Authority', 'State Corporation', '', 'PEST CONTROL PRODUCTS BOARD (PCPB) BULIDING, LORESHO,OFF WAIYAKI WAY', '28251-00100 ', '', '', '020 2642920', ' (1) 020 2642920     (2 )020 2678667', 'wamukota@biosafetykenya.go.ke', '', 'PEST CONTROL PRODUCTS BOARD (PCPB) BULIDING, LORESHO,OFF WAIYAKI WAY', 'www.biosafetykenya.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-62', 'Technical and Vocational Education and Training Authority', 'State Corporation', '', 'Telposta Towers,Kenyatta Avenue', 'P.O.BOX 35625-00100', '', '', '2.55E+11', '2.55E+11', 'henryobatsa@yahoo.com', '', 'Telposta Towers,Kenyatta Avenue', 'www.tvetauthority.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-63', 'National Hospital Insurance Fund', 'State Corporation', '', 'NHIF Building', '30443-00100', '', '', '2.55E+11', '2.55E+11', 'dchelagat@nhif.or.ke', '', 'NHIF Building', 'www.nhif.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-64', 'Kenya  Water Institute ', 'State Corporation', '', '722316304', '722316304', '', '', '2.55E+11', '2.55E+11', 'musya@kewi.or.ke', '', '722316304', 'www.kewi.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-65', 'The President\'s Award - Kenya', 'State Department', '', '15 Elgon Road Upperhill', '62185-00200', '', '', '2.55E+11', '2.55E+11', 'mprisca@presidentsaward.or.ke', '', '15 Elgon Road Upperhill', 'www.presidentsaward.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-66', 'Ministry of Agriculture, Livestock and Fisheries', 'Ministry', '', '0', '0', '', '', '2.55E+11', '2.55E+11', 'baomondi@gmail.com', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-67', 'Kenya Institute of Curriculum Development', 'State Corporation', '', '0', '0', '', '', '2.55E+11', '2.55E+11', 'brotich@kicd.ac.ke', '', '0', 'www.kicd.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-68', 'Agricultural Finance Corporation', 'State Corporation', '', '720921754', '720921754', '', '', '2.55E+11', '2.55E+11', 'jwachira@agrifinance.org', '', '720921754', 'http://www.agrifinance.org/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-69', 'Kenya Plant Health Inspectorate Service', 'State Corporation', '', ' Oloolua Ridge, Karen', 'P. O. Box 49592-00100', '', '', '2.55E+11', '020-6618000/0709-891000', 'sesharanda@kephis.org', '', ' Oloolua Ridge, Karen', 'www.kephis.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-70', 'Ministry of Sports, Culture and the Arts', 'Ministry', '', 'KENCOM building', '49489-00100', '', '', '2.55E+11', '2.55E+11', 'gatere.jane@yahoo.com', '', 'KENCOM building', 'www.sportsheritage.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-71', 'Kenyatta National Hospital', 'State Corporation', '', '  Hospital Road', 'P. O. Box 20723-00202', '', '', '2.55E+11', '2.55E+11', 'simon.wagura@gmail.com', '', '  Hospital Road', 'www.knh.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-72', 'Water Sector Trust Fund', 'State Corporation', '', 'CIC Plaza, Upper Hill, Mara Road', 'P.O. Box 49699 - 00100', '', '', '2.55E+11', '2.55E+11', 'kennedy.lukhando@waterfund.go.ke', '', 'CIC Plaza, Upper Hill, Mara Road', 'www.waterfund.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-73', 'Pest Control Products Board', 'State Corporation', '', '  loresho,waiyaki way', '13794-00800 nairobi', '', '', '2.55E+11', '2.55E+11', 'ndirangurobert@pcpb.or.ke', '', '  loresho,waiyaki way', 'www.pcpb.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-74', 'Kenya Institute Of Mass Communication', 'State Corporation', '', ' SOUTH B MUHORO RD', '42422-0100 nairobi', '', '', '725958973', '725958973', 'mmarindich@kimc.ac.ke', '', ' SOUTH B MUHORO RD', 'PPIP', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-75', 'Ministry of Public Service, Youth & Gender Affairs ', 'Ministry', '', 'TELEPOSTA TOWERS', 'P.O BOX 29966-00100', '', '', '2.55E+11', '2.55E+11', 'andrewkimulu@yahoo.com', '', 'TELEPOSTA TOWERS', 'http://www.psyg.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-76', 'The Sacco Societies Regulatory Authority', 'State Corporation', '', 'UAP/Old Mutual Tower, Hospital Road, Upperhill', '25089-00100', '', '', '2.55E+11', '2.55E+11', 'pahomo@sasra.go.ke', '', 'UAP/Old Mutual Tower, Hospital Road, Upperhill', 'http://www.sasra.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-77', 'Kenya Film Commission', 'State Corporation', '', ' JUMUIA PLACE 2ND FLOOR LENANA ROAD KILIMANI', '76417-00508 NAIROBI', '', '', '2.55E+11', '2.55E+11', 'kamanda@filmingkenya.com', '', ' JUMUIA PLACE 2ND FLOOR LENANA ROAD KILIMANI', 'www.kenyafilmcommission.com ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-78', 'Kenya Institute for Public Policy and Research and Analysis', 'State Corporation', '', ' Bishops Road, Nairobi ', '056445-00200, nbi', '', '', '+254 726 065 767', '2.55E+11', 'vodongo@kippra.or.ke', '', ' Bishops Road, Nairobi ', 'www.kippra.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-79', 'Ministry of Transport and Infrastructure', 'State Department', '', 'transcom house, ngong road', '52692-00200', '', '', '2.55E+11', '2.54E+11', 'psmaritimeshipping@gmail.com', '', 'transcom house, ngong road', 'www.transport.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-80', 'Youth Enterprise Development Fund', 'State Corporation', '', 'Rennaissance Coporate Park, 4th Floor, Elgon Road, Upper-Hill, Nairobi', '48610-00100', '', '', '2.55E+11', '202211672', 'aouma@youthfund.go.ke', '', 'Rennaissance Coporate Park, 4th Floor, Elgon Road, Upper-Hill, Nairobi', 'www.youthfund.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-81', 'Tourism Regulatory Authority', 'State Corporation', '', '100', '30027', '', '', '2.55E+11', '2.55E+11', 'sswaleh@tourismauthority.go.ke', '', '100', 'https://www.tourismauthority.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-82', 'Water Service Regulatory Board', 'State Corporation', '', '5th Floor NHIF Building Ngong Road', 'P. Box 41621-00100 Nairobi', '', '', '2.55E+11', '+254 (0) 202733561/+254 709 482000', 'jkimotho@wasreb.go.ke', '', '5th Floor NHIF Building Ngong Road', 'www.wasreb.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-83', 'KENYA ACCREDITATION SERVICE', 'State Corporation', '', 'Embankment Plaza, 2nd Floor, Longonot Road off Kenya Road, Upper Hill', 'P. O. Box 47400 - 00100 Nairobi', '', '', '+254 787 395 679', '+254 725 227 640 / +254 787 395 679', 'procurement@kenyaaccreditation.org', '', 'Embankment Plaza, 2nd Floor, Longonot Road off Kenya Road, Upper Hill', 'http://kenas.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-84', 'National Housing Corporation', 'State Corporation', '', 'NHC House, Aga Khan Walk, Harambee Avenue', 'P.O BOX 30257-00100', '', '', '+254721990868, 0722583925', '+254203312147/9, +254730749000, +254724256403', 'info@nhckenya.co.ke, kmochire@nhckenya.co.ke', '', 'NHC House, Aga Khan Walk, Harambee Avenue', 'www.nhckenya.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-85', 'Konza Technopolis Development Authority', 'State Corporation', '', 'NAIROBI', 'P.O BOX 30519-00200', '', '', '2.55E+11', '+254 20 4343014', 'vkiprop@konzacity.go.ke', '', 'NAIROBI', 'www.konzacity.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-86', 'ICDC', 'State Corporation', '', 'Uchumi House, Agakhan Walk, 17th Floor', '45519 00100', '', '', '2.55E+11', '+254 20 2229213', 'abarmao@icdc.co.ke', '', 'Uchumi House, Agakhan Walk, 17th Floor', 'www.icdc.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-87', 'Consolidated Bank', 'State Corporation', '', 'Consolidated Bank House, 23 koinange street', '51133-00200 Nairobi', '', '', '2.55E+11', '2.55E+11', 'jkikayaya@consolidated-bank.com', '', 'Consolidated Bank House, 23 koinange street', 'www.consolidated-bank.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-88', 'Kenya Petroleum Refineries Limited', 'State Corporation', '', 'OLD REFINERY RD, CHANGAMWE', 'PO BOX 90401, 80100 MOMBASA', '', '', '2.55E+11', '2.55E+11', 'janette.mutimbia@kprl.co.ke', '', 'OLD REFINERY RD, CHANGAMWE', 'www.kprl.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-89', 'Tana And Athi Rivers Development Authority', 'State Corporation', '', 'Queensway House, 7th floor Kaunda Street', '47309-00100', '', '', '2.55E+11', '2540203341782/4/7/8', 'procurement@tarda.co.ke ', '', 'Queensway House, 7th floor Kaunda Street', 'www.tarda.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-90', 'Lake Victoria South Water Services Board', 'State Corporation', '', 'Lavictor\'s Hse, Off Ring Road, Milimani', '3325-40100, Kisumu, KENYA', '', '', '2.55E+11', '2.55E+11', 'joteng@lvswaterboard.go.ke', '', 'Lavictor\'s Hse, Off Ring Road, Milimani', 'http://www.lvswaterboard.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-91', 'Council Of Governors', 'State Department', '', 'Delta Corner, westlands', '40401-00100', '', '', '2.55E+11', '2.55E+11', 'hilda.were@cog.go.ke', '', 'Delta Corner, westlands', 'www.cog.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-92', 'Tourism Fund', 'State Corporation', '', 'NHIF BUILDING, CAR PARK TOWER 5TH FLOOR', '046987-00100', '', '', '2.55E+11', '2.55E+11', 'nmukuna@tourismfund.co.ke', '', 'NHIF BUILDING, CAR PARK TOWER 5TH FLOOR', 'www.tourismfund.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-93', 'Kenya Post Office Savings Bank', 'State Corporation', '', '722435875', '722435875', '', '', '2.55E+11', '2.55E+11', 'osorogn@postbank.co.ke', '', '722435875', 'www.postbank.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-94', 'Kenya Ordance Factories Corporation', 'State Corporation', '', '0', '0', '', '', '2.55E+11', '2.55E+11', 'fwerus@gmail.com', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-95', 'National Commission For Science,Technology Andinnovation', 'State Corporation', '', '727236113', '727236113', '', '', '2.55E+11', '2.55E+11', 'denisyegonn@gmail.com', '', '727236113', 'www.nacosti.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-96', 'Ministry of Defence', 'Ministry', '', 'Ulinzi house, Lenana road', '40668-00100', '', '', '2.55E+11', '2.55E+11', 'mbuguajane12@gmail.com', '', 'Ulinzi house, Lenana road', 'www.mod.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-97', 'Engineers Board of Kenya', 'State Corporation', '', 'Transcom House Annex, 1st Floor, Ngong Rd.', 'P.O. Box 30324-00100 Nairobi, Kenya', '', '', '2.55E+11', '0', 'sabuya@ebk.or.ke', '', 'Transcom House Annex, 1st Floor, Ngong Rd.', 'www.ebk.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-98', 'University of Nairobi Enterprises and Services', 'State Corporation', '', '    ARBORETUM DRIVE OFF STATE HOUSE ROAD', 'P.O BOX 68241', '', '', '2.55E+11', '204913916', 'fredrick.kanyangi@uonbi.ac.ke', '', '    ARBORETUM DRIVE OFF STATE HOUSE ROAD', 'WWW.UNES.CO.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-99', 'Narok', 'County', '', 'NAROK-MAU ROAD', '898-20500', '', '', '2.55E+11', '724777457', 'procurement@narok.go.ke', '', 'NAROK-MAU ROAD', 'WWW.NAROK.GO.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-100', 'The Co-operative University of Kenya', 'Public Universities', '', 'NAIROBI - KAREN', '24814-00502', '', '', '725651516', '0724311606,+254 (0)20 2430127,020 2679456', 'bmahiga@cuk.ac.ke', '', 'NAIROBI - KAREN', 'www.cuk.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-101', 'Kenyatta University (KU)', 'Public Universities', '', 'Along Thika super Highway', '43844', '', '', '2.55E+11', '20 8703000', 'alati.benson@ku.ac.ke', '', 'Along Thika super Highway', 'http://www.ku.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-102', 'University of Embu', 'Public Universities', '', 'Meru-Nairobi Highway/B6,Embu', '6-60100', '', '', '2.55E+11', '714243682', 'kaaria.lindajoan@embuuni.ac.ke', '', 'Meru-Nairobi Highway/B6,Embu', 'www.embuni.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-103', 'Garissa University', 'Public Universities', '', 'Gairissa Town', '1801-70100', '', '', '2.55E+11', '2.55E+11', 'kautharfaraj@gmail.com', '', 'Gairissa Town', 'www.gau.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-104', 'Capital Markets Authority', 'State Corporation', '', '  Embankment Plaza, 3rd floor, Longonot Road, Upper Hill', 'P.O. Box 74800 - 00200, Nairobi', '', '', '2.55E+11', '0202264900 / 0202264308', 'sorina@cma.or.ke', '', '  Embankment Plaza, 3rd floor, Longonot Road, Upper Hill', 'www.cma.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-105', 'Athi Water Service Board', 'State Corporation', '', 'Africa Re Centre, Hospital Road. Nairobi', 'P. O. Box 45283-00100, Nairobi', '', '', '2.55E+11', '+254 715 688 272', 'cochieng@awsboard.go.ke', '', 'Africa Re Centre, Hospital Road. Nairobi', 'www.awsboard.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-106', 'ICT and innovation', 'State Department', '', ' Teleposta  Towers', '30025-00100', '', '', '2.55E+11', '4920000', 'munganiamukami@gmail.com', '', ' Teleposta  Towers', 'tenders.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-107', 'Kenya Medical Supplies Authority', 'State Corporation', '', ' Commercial street, Industral Area', 'P.O Box 47715, 00100 GPO, Nairobi', '', '', '2.55E+11', '2.55E+11', 'john.kabuchi@kemsa.co.ke', '', ' Commercial street, Industral Area', 'www.kemsa.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-108', 'University of Nairobi', 'Public Universities', '', '      Harry Thuku Road', '30197-00100', '', '', '2.55E+11', '020-3318262', 'kanjejo@uonbi.ac.ke', '', '      Harry Thuku Road', 'www.uonbi.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-109', 'Industrialization', 'State Department', '', 'Social Security House, Block A, 17th, Flr', 'P.O. Box 30418-00100', '', '', '2.55E+11', '+254 20-2731531', 'edith.wangari@gmail.com', '', 'Social Security House, Block A, 17th, Flr', 'www.industrialization.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-110', 'Office of the Attorney General & Department of Justice ', 'Ministry', '', ' SHERIA HOUSE, HARAMBEE AVENUE', 'P.O BOX 40112-00100, NAIROBI', '', '', '2.55E+11', '+254 20 2227461/2251355/0711944555/0732529995', 'jkirugumi@gmail.com', '', ' SHERIA HOUSE, HARAMBEE AVENUE', 'www.statelaw.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-111', 'Ministry of Lands and Physical Planning', 'Ministry', '', 'ARDHI HOUSE, 1ST NGONG AVENUE, NGONG ROAD  ', 'P.O BOX 30450 - 00100 NAIROBI', '', '', '2.55E+11', '2718050', 'kennedyomari@gmail.com', '', 'ARDHI HOUSE, 1ST NGONG AVENUE, NGONG ROAD  ', 'www.lands.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-112', 'Ministry of Tourism  and Wildlife', 'State Department', '', ' NSSF Building Block A', 'P. O. Box 30430 -00100', '', '', '2.55E+11', '0202724646/2724725', 'nyagamunene@yahoo.com', '', ' NSSF Building Block A', 'www.tourism.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-113', 'petroleum and mining', 'Ministry', '', '   nyayo house', 'p.o box 30582-00100', '', '', '2.55E+11', '2.55E+11', 'ingavojohn80@gmail.com', '', '   nyayo house', 'http://www.petroleumandmining.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-114', 'State Department of Devolution', 'State Department', '', 'Kenyatta Avenue,Teleposta towers 1st & 6th Floors', '30004-00100', '', '', '2.55E+11', '+254 20 2250645', 'camonichep@yahoo.com', '', 'Kenyatta Avenue,Teleposta towers 1st & 6th Floors', 'www.devolutionasals.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-115', 'State Department of Planning', 'State Department', '', 'Treasury Building', 'P.O Box 30005-00100 Nairobi', '', '', '2.55E+11', '2252299', 'ps@planning.statistics@gmail.com', '', 'Treasury Building', 'www.planning.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-116', 'National Youth Service', 'State Department', '', 'RUARAKA - THIKA Rd', 'P.O. BOX 30397-00100 NAIROBI', '', '', '2.55E+11', '-208563267', 'dg@nys.go.ke', '', 'RUARAKA - THIKA Rd', 'supplier.treasury.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-117', 'State Department of University Education & Research', 'State Department', '', ' JOGOO HOUSE "B"', 'P O Box 9583-00200 Nairobi', '', '', '2.55E+11', '020-3318581', 'paulrono@yahoo.com', '', ' JOGOO HOUSE "B"', 'www..education.ge.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-118', 'State Department of Irrigation', 'State Department', '', '   MAJI HOUSE', '49720-00100', '', '', '2.55E+11', '27,161,034,900,000', 'matamagodfrey@yahoo.com', '', '   MAJI HOUSE', 'www.kilimo.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-119', 'State Department of Trade', 'State Department', '', ' Teleposta Towers, GPO, Kenyatta Avenue', '30430 -00100', '', '', '2.55E+11', '3315001/4', 'abagga.abner@gmail.com', '', ' Teleposta Towers, GPO, Kenyatta Avenue', 'www.trade.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-120', 'State Department of Livestock', 'State Department', '', ' Kilimo House,  Cathedral Road', 'P. O. Box 34188-00100 Nairobi', '', '', '2.55E+11', '2718870/9', 'kkbabz@gmail.com', '', ' Kilimo House,  Cathedral Road', 'http://www.kilimo.go.ke/management/state-department-of-livestock/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-121', 'State Department of Mining', 'State Department', '', ' WORKS BUILDING  NGONG ROAD', 'P.O.BOX 30009-00100 NAIROBI', '', '', '2.55E+11', '254-20-2723101', 'kiilu06@gmail.com', '', ' WORKS BUILDING  NGONG ROAD', 'www,mining.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-122', 'State Department of Housing, Urban Development and Public Works', 'State Department', '', ' ARDHI HOUSE', '30119-00100', '', '', '2.55E+11', '-2713599', 'sonkuta@gmail.com', '', ' ARDHI HOUSE', 'www.housing and urban.go.ke   ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-123', 'Unclaimed Financial Assests Authority', 'State Corporation', '', 'Westlands, Nairobi', '28235 - 00200, Nairobi', '', '', '723546931', '723546931', 'wilson.macharia@ufaa.go.ke', '', 'Westlands, Nairobi', 'www.ufaa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-124', 'Commission on Revenue Allocation', 'Commissions and Independent Offices', '', '2nd Floor, Grosvenor Suite???14 Riverside Drive  Riverside', 'P.O. Box 1310 ??? 00200, City Square  NAIROBI', '', '', '2.55E+11', '2.55E+11', 'geoffrey.ntooki@crakenya.org', '', '2nd Floor, Grosvenor Suite???14 Riverside Drive  Riverside', 'www.crakenya.org ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-125', 'KERIO VALLEY DEVELOPMENT AUTHORITY (KVDA)', 'State Corporation', '', 'ELDORET', '2660-30100', '', '', '2.55E+11', '053-20-63361/4', 'info@kvda.go.ke', '', 'ELDORET', 'www.kvda.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-126', 'Kenya Veterinary Vaccines Production Institute', 'State Corporation', '', 'INDUSTRIAL AREA,OFF ENTERPRISE ROAD,ROAD A', '00200 53260', '', '', '722363588', '0203540071/0724651895', 'vaccines@kevevapi.org', '', 'INDUSTRIAL AREA,OFF ENTERPRISE ROAD,ROAD A', 'www.kevevapi.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-127', 'Kisii University', 'Public Universities', '', 'Along Kisii-Kilgoris Road', '408-40200', '', '', '2.55E+11', '2.55E+11', 'dbasweti@kisiiuniversity.ac.ke', '', 'Along Kisii-Kilgoris Road', 'www.kisiiuniversity.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-128', 'Kenya Pipeline Company', 'State Corporation', '', '88', '9', '', '', '2.55E+11', '2.55E+11', 'Cathrine.Kituri@kpc.co.ke', '', '88', 'WWW.KPC.CO.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-129', 'Anti-Female Genital Mutilation Board', 'State Corporation', '', 'kenya Railways staff Retirement Benefit Scheme Building,Sourth Wing, Block "D" 2nd floor,Workshop Road,off Haile selassie Avenue', 'P.O. BOX 54760-00200 -NAIROBI', '', '', '2.55E+11', '(+254) 020-2220106', 'fredowiti99@gmail.com', '', 'kenya Railways staff Retirement Benefit Scheme Building,Sourth Wing, Block "D" 2nd floor,Workshop Road,off Haile selassie Avenue', 'www.antifgmboard.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-130', 'The Jomo Kenyatta Foundation', 'State Corporation', '', '51, Enterprise Road, Industrial Area, Nairobi.', 'P.O. Box 30533 - 00100 Nairobi.', '', '', '2.55E+11', '+254 0203583925, 0202330002/3, 0723969793', 'fokubasu@jkf.co.ke', '', '51, Enterprise Road, Industrial Area, Nairobi.', 'www.jkf.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-131', 'State Department for ASALs', 'State Department', '', 'EXTELCOM HOUSE', '40213', '', '', '2.55E+11', '203317641', 'nemac2006@yahoo.com', '', 'EXTELCOM HOUSE', 'www.devolutionasals.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-132', 'Retirement Benefits Authority', 'State Corporation', '', 'Rahimtulla Tower,13th Flr, Upper Hill Road', 'P.O.Box 57733 - 00200, Nairobi, Kenya', '', '', '2.55E+11', '+254 20 2809000', 'vmulwa@rba.go.ke', '', 'Rahimtulla Tower,13th Flr, Upper Hill Road', 'www.rba.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-133', 'State department for Telecommunications and Broadcating', 'State Department', '', 'Kenyatta Avenue Teleposta Towers', '30025-00100', '', '', '2.55E+11', '020-4920000', 'kanyara2010@yahoo.com', '', 'Kenyatta Avenue Teleposta Towers', 'www.ict.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-134', 'Ministry of Foreign Affairs', 'Ministry', '', 'harambee avenue', '30551-00100', '', '', '2.55E+11', '-318654', 'barasaruth1@gmail.com', '', 'harambee avenue', 'www.mfa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-135', 'Kenya Roadway', 'State Department', '', '556', '667', '', '', '2.55E+11', '566', 'lkr@ppra.go.ke', '', '556', 'rrt.lot', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-136', 'Geothermal Development Company', 'State Corporation', '', 'bowuor@gdc.co.ke', 'Head Office: Kawi House, South C Bellevue |Off Mombasa Road| Red Cross Road.', '', '', '\\N', '+254 719 037000\\', ' 020 2427516', '', 'bowuor@gdc.co.ke', '170_logo_image.png', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-137', 'Commission for University Education', 'State Corporation', '', 'nokodo@cue.or.ke', 'Red-hill Road off Limuru Road ', '', '', '\\N', '0717445566\\', '780656575', '', 'nokodo@cue.or.ke', '171_logo_image.jpg', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-138', 'State Department for Agricultural Research', 'State Department', '', 'Cathedral Road-Kilimo House', '30028-00100', '', '', '2.55E+11', '2718870', 'jnyams.2014@gmail.com', '', 'Cathedral Road-Kilimo House', 'https://www.kilimo.ko.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-139', 'Egerton University', 'Public Universities', '', 'Egerton', '536-20115, Egerton', '', '', '2.55E+11', '0512217891/892', 'samson.chira@egerton.ac.ke', '', 'Egerton', 'http://www.egerton.ac.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-140', 'Machakos University', 'Public Universities', '', 'Machakos Town', '136-90100', '', '', '725287641', '735247939', 'petermaina2007@yahoo.com', '', 'Machakos Town', 'www.mksu.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-141', 'Kenya Medical Research Institute', 'State Corporation', '', 'Mbagathi way ', '54840-00200', '', '', '2.55E+11', '2.55E+11', 'fotieno@kemri.org', '', 'Mbagathi way ', 'www.kemri.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-142', 'Marsabit', 'County', '', 'Marsabit County', 'P.o. Box 384 - 60500', '', '', '2.55E+11', '0', 'fkamendi@gmail.com', '', 'Marsabit County', 'www.marsabit.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-143', 'Energy Regulatory Commission', 'State Corporation', '', 'Upperhill, Nairobi', 'P.O.Box 42681-00100 Nairobi', '', '', '2.55E+11', '722200947', 'info@erc.go.ke', '', 'Upperhill, Nairobi', 'https://www.erc.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-144', 'Higher Education Loan Board', 'State Corporation', '', 'UNIVERSITY WAY ANNIVERSARY TOWERS', '69489-00400', '', '', '2.55E+11', '2.55E+11', 'psapiri@helb.co.ke', '', 'UNIVERSITY WAY ANNIVERSARY TOWERS', 'www.helb.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-145', 'Kenya Power & Lighting Company', 'State Corporation', '', 'Stima Plaza Kolobot Road, Parklands', '30099-00100', '', '', '2.55E+11', '3201000', 'jkorir@kplc.co.ke', '', 'Stima Plaza Kolobot Road, Parklands', 'www.kplc.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-146', 'County Assembly Of Samburu', 'County Assemblies', '', 'Assembly Building', 'P.0.Box 3 20600 Maralal Kenya', '', '', '2.55E+12', '3', 'elempushuna@samburuassembly.go.ke', '', 'Assembly Building', 'http://www.samburuassembly.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-147', 'Kenya film Classification Board', 'State Corporation', '', 'Agha-Khan Walk Uchumi House 15th Floor', 'P.O BOX 44226 - 00100 NAIROBI', '', '', '2.55E+11', '020 225060/2251258/0202241804/0711222204/0777753355', 'ondiekimaonga@gmail.com', '', 'Agha-Khan Walk Uchumi House 15th Floor', 'www.kfcb.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-148', 'Kirinyaga', 'County', '', '889', '990', '', '', '2.55E+11', '2.55E+11', 'otundomarrion12@gmail.com', '', '889', 'www.kirinyaga.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-149', 'Kenya Meat Commission', 'State Corporation', '', 'ATHI RIVER', '2-00204', '', '', '2.55E+11', '020-2424051', 'charonyingambwa@gmail.com', '', 'ATHI RIVER', 'www.kenyameat.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-150', ' Infrastructure', 'State Department', '', 'community', '30260-00100', '', '', '2.55E+11', '2.55E+11', 'jobongo81@gmail.com', '', 'community', 'www.transport.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-151', 'Kenya Wildlife Service', '194444', '', 'hps@kws.go.ke\\', 'kws@kws.go.ke', '', '', '   Lanagata Road KWS Headquarter complex ', '2.55E+11', 'naisoi@kws.go.ke\\', '', 'hps@kws.go.ke\\', 'Leah Naisoi Lepore', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-152', 'Kenya Ports Authority', 'State Corporation', '', 'KPA -Hqs', 'P. O. Box 95009 - 80104 Mombasa Kenya', '', '', '2.55E+11', '2.55E+11', 'SChepkangor@kpa.co.ke', '', 'KPA -Hqs', 'www.kpa.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-153', 'Nyayo Tea Zones Develop Corporation', 'State Corporation', '', '454', 'P. O. Box 48522-00100', '', '', '2.55E+11', '2.55E+11', 'CJepchumba@teazones.co.ke', '', '454', 'www.teazones.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-154', 'Kenya Seed Company', 'State Corporation', '', 'Mbegu Plaza, Kitale-Kenya.', 'P.O. Box 553-30200, ', '', '', '+254 722 205 144 ', '+254 726 141 856', 'sthinguri@kenyaseed.co.ke', '', 'Mbegu Plaza, Kitale-Kenya.', 'www.kenyaseed.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-155', 'National Transport and Safety Authority', 'State Corporation', '', 'Hillpark Building, Upper Hill Road', 'P. 0. Box 3602 - 00506', '', '', '2.55E+11', '206632300', 'winnie.kibuchi@ntsa.go.ke', '', 'Hillpark Building, Upper Hill Road', 'www.ntsa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-156', 'COMMODITIES FUND', 'State Corporation', '', 'Kenya Railways |Block D| 2ND Floor | Workshop Rd ??? Off Haile Selassie Avenue', 'P.O Box 52714 ??? 00200 Nairobi, Kenya', '', '', '2.55E+11', '2.55E+11', 'james.singa@codf.co.ke', '', 'Kenya Railways |Block D| 2ND Floor | Workshop Rd ??? Off Haile Selassie Avenue', 'www.comfund.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-157', 'Kenya Forest Service', 'State Corporation', '', 'Karura off Kiambu Road', 'Po box 30513-00100 Nairobi', '', '', '2.55E+11', '202020285', 'mburujm@kenyaforestservice.org', '', 'Karura off Kiambu Road', 'www.kenyaforestservice.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-158', 'Privatization Commission', 'State Corporation', '', 'Extelcoms House 11th Floor', 'P.O. Box 34542 00200 Nairobi', '', '', '2.55E+11', '254-0700 033349', 'dmutua@pc.go.ke', '', 'Extelcoms House 11th Floor', 'www.pc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-159', 'Ministry of Interior and Co-ordination of National Government', 'State Department', '', '254', '722902359', '', '', '2.55E+11', '2.55E+11', 'ngarigithu@yahoo.com', '', '254', 'www.interior.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-160', 'Ministry of Environment and Forestry', 'Ministry', '', 'NHIF Building', '721498119', '', '', '2.55E+11', '2.55E+11', 'ndongupk@yahoo.com', '', 'NHIF Building', 'www.environment.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-161', 'Kenya Meteorological Department', 'State Department', '', 'Dagoretti Corner, Ngong Road', 'P. O. Box 30259 - 00100 Nairobi Kenya', '', '', '020 3867880/1/2/3/4/5', '020 3867880/1/2/3/4/5', 'director@meteo.go.ke', '', 'Dagoretti Corner, Ngong Road', 'www.environment.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-162', 'The National Treasury and Planning', 'Ministry', '', 'Harambee Avenue Treasury Building ', 'P.O. Box 30007 00100 Nairobi', '', '', '+254 020 2252299', '+254 020 2252299', 'benoloo2002@gmail.com', '', 'Harambee Avenue Treasury Building ', 'http://www.treasury.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-163', 'Kenya National Bureau of Statistics', 'State Corporation', '', '333', '3345', '', '', '2.55E+11', '2.55E+11', 'procurement@knbs.or.ke', '', '333', 'www.knbs.or.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-164', 'State Department of East Africa Community', 'Ministry', '', ' Co-op Bank House Building', '8846-00200', '', '', '2.55E+11', '233.9999995', 'albertgawo@gmail.com', '', ' Co-op Bank House Building', 'www.meac.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-165', 'Samburu', 'County', '', 'Maralal', 'P. O. Box 3 - 20600 Maralal', '', '', '2.55E+11', '2.55E+11', 'info@samburu.go.ke', '', 'Maralal', 'www.samburu.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-166', 'County Assembly of Nyandarua', 'County Assemblies', '', 'OL KALOU NYAHURURU ROAD', '720-20303 OL KALOU', '', '', '2.55E+11', '0743-079333', 'jlektari@yahoo.com', '', 'OL KALOU NYAHURURU ROAD', 'http://assembly.nyandarua.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-167', 'Kakamega', 'County', '', 'kenyatt avenue', '36-50100', '', '', '2.55E+11', '715022738', 'makubahossen@yahoo.com', '', 'kenyatt avenue', 'www.kakamega.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-168', 'Technical University of Kenya', 'Public Universities', '', '254', '254', '', '', '2.55E+11', '2.55E+11', 'gwarofm@gmail.com', '', '254', 'www.tukenya.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-169', 'South Nyanza Sugar Company Limited', 'State Corporation', '', 'Awendo,Migori', '107-40405', '', '', '2.55E+11', '722205345', 'james.oluoch@sonysugar.co.ke', '', 'Awendo,Migori', 'Www.sonysugar.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-170', 'Jaramogi oginga Odinga University of Science and Technology', 'Public Universities', '', 'Bondo', 'P.O BOX 210-40601', '', '', '2.55E+11', '572501804', 'wanguikinyanjui@gmail.com', '', 'Bondo', 'https://www.jooust.ac.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-171', 'New Kenya Co-operative Creameries Ltd', 'State Corporation', '', 'Creamery House, Dakar Rd', 'P.O. Box 30131-00100', '', '', '2.55E+11', '2.55E+11', 'daniel.mukunga@newkcc.co.ke', '', 'Creamery House, Dakar Rd', 'www.newkcc.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-172', 'National Industrial Training Authority', 'State Corporation', '', 'Commercial street, Industral Area', 'P.O. Box 74494 - 00200', '', '', '2.55E+11', '0202695586, 0202695589,072017897, 0736290676', 'mmbithe@nita.go.ke', '', 'Commercial street, Industral Area', 'www.nita.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-173', 'County Assembly of Embu', 'County Assemblies', '', 'EMBU', '140-60100 EMBU', '', '', '2.55E+11', '682231208', 'petwaithaka2016@gmail.com', '', 'EMBU', 'www.embuassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-174', 'Kenya Industrial Estates ', 'State Corporation', '', 'Likoni', 'P.O. Box 78029 - 00507', '', '', '2.55E+11', '2.55E+11', 'mwalandijijo@gmail.com', '', 'Likoni', 'www.kie.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-175', 'Kenya Revenue Authority', 'State Corporation', '', 'Times Tower, Haile Selasie Avenue , Nairobi, Kenya', 'Box 48240-00100', '', '', '2.55E+11', '2.55E+11', 'Nicholas.Njeru@kra.go.ke', '', 'Times Tower, Haile Selasie Avenue , Nairobi, Kenya', 'www.kra.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-176', 'Office of the Director of Public Prosecutions', 'Commissions and Independent Offices', '', 'NSSF Building, Block ???A??? 19th Floor', '30701-00100', '', '', '725577611', '+254 2732090/2732240', 'eunicembithe87@gmail.com', '', 'NSSF Building, Block ???A??? 19th Floor', 'www.odpp.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-177', 'Isiolo', 'County', '', '  Isiolo', 'P.O. Box 36 - 60300', '', '', '2.55E+11', '2.55E+11', 'saritesalad114@gmail.com', '', '  Isiolo', 'www.isiolo.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-178', 'Kenya Tsetse and Trypanosomiasis Eradication Council', 'State Corporation', '', 'Crescent Business Centre, Off Parklands Road', '66290-00800 Westlands', '', '', '2.55E+11', '2.54E+12', 'cyrusmuiru@yahoo.com', '', 'Crescent Business Centre, Off Parklands Road', 'www.kenttec.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-179', 'Coast Development Authority', 'State Corporation', '', 'Mombasa', 'P.O BOX 1322', '', '', '2.55E+11', '208009196', 'cda@cda.go.ke', '', 'Mombasa', 'www.cda.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-180', 'Kenya Yearbook Editorial Board', 'State Corporation', '', 'NHIF Buiding, 4th Floor. Upperhill, Nairobi', '34035-00100', '', '', '2.55E+11', '020 2715390', 'johnouko22@gmail.com', '', 'NHIF Buiding, 4th Floor. Upperhill, Nairobi', 'http://kenyayearbook.co.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-181', 'Dedan Kimathi University of Technology', 'Public Universities', '', '724838361', '254', '', '', '2.55E+11', '2.55E+11', 'procurement@dkut.ac.ke', '', '724838361', 'www.dkut.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-182', 'Brand Kenya Board', 'State Corporation', '', ' 4th floor, NHIF Building, Ragati road, Upper Hill', 'P.O Box 40500-00100,Nairobi.', '', '', '714870451', '+254 (0) 20 271 5236/7', 'g.gatwiri@brandkenya.go.ke', '', ' 4th floor, NHIF Building, Ragati road, Upper Hill', 'www.brandkenya.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-183', 'Northern Water Services Board', 'State Corporation', '', ' Maji House, Garissa', '495 Garissa', '', '', '2.55E+11', '2.54E+11', 'info@nwsb.go.ke', '', ' Maji House, Garissa', 'www.nwsb.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-184', 'Agriculture and Food Authority', 'State Corporation', '', '0', '0', '', '', '2.55E+11', '722894308', 'mmkamburi@afa.go.ke', '', '0', 'www.afa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-185', 'Kenya Maritime Authority', 'State Corporation', '', 'WHITE HOUSE, MOI AVENUE, MOMBASA', 'P. O. Box 95076 - 80104, MOMBASA', '', '', '2.55E+11', '724319344', 'soluoch@kma.go.ke', '', 'WHITE HOUSE, MOI AVENUE, MOMBASA', 'www.kma.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-186', 'The Judiciary', 'Commissions and Independent Offices', '', 'City Hall Way-Supreme Court Building', '30041-00100', '', '', '2.55E+11', '2221221', 'doreen.mwirigi@court.go.ke', '', 'City Hall Way-Supreme Court Building', 'www.judiciary.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-187', 'Kenya Electricity  Generating Company', 'State Corporation', '', '  Stirna Plaza, Kolobot Road, Parklands, ', 'P.O. Box 47936, 00100 Nairobi, ', '', '', '2.55E+11', '254-020-3666000', 'lgitau@kengen.co.ke', '', '  Stirna Plaza, Kolobot Road, Parklands, ', 'www.kengen.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-188', 'New Partnership for Africa\'s Development', 'State Corporation', '', 'STATE HOUSE AVENUE LIASION HOUSE', '46270-00100', '', '', '2.55E+11', '0202733735/38/42', 'carolinendwiga@nepadkenya.org', '', 'STATE HOUSE AVENUE LIASION HOUSE', 'www.nepadkenya.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-189', 'Bomas of Kenya', 'State Corporation', '', ' Langata, Forest Edge Road', 'P.O. Box 40689 -00100 Nairobi', '', '', '2.55E+11', '725978298', 'kipronimaritim1@gmail.com', '', ' Langata, Forest Edge Road', 'www.bomasofkenya.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-190', 'University of Eldoret', 'Public Universities', '', 'Eldoret-Ziwa road', 'P.O. Box 1125 - 30100, Eldoret', '', '', '2.55E+11', '2.55E+11', 'w.ngetich@physics.org', '', 'Eldoret-Ziwa road', 'http://www.uoeld.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-191', 'County Assembly of Machakos', 'County Assemblies', '', 'Country Hall, Machakos', 'P.  O. Box 1168 - 90100', '', '', '2.55E+11', '2.55E+11', 'mulonziharrison@gmail.com', '', 'Country Hall, Machakos', 'machakoscountyassembly.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-192', 'KASNEB', 'State Corporation', '', 'KASNEB Towers, Upperhill Nairobi', 'P. o. Box 41362-00100', '', 'Nairobi', '2.55E+11', '254(020)4923000', 'mark.mwangi@kasneb.or.ke', '', 'KASNEB Towers, Upperhill Nairobi', 'www.kasneb.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-193', 'County Assembly of Narok', 'County Assemblies', '', 'Narok county headquarters-Mau Narok Road', '19-20500', '', '', '2.55E+11', '2068889', 'yiapanoilepore@gmail.com', '', 'Narok county headquarters-Mau Narok Road', 'www.narokassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-194', 'Export Promotion Council', 'State Corporation', '', 'Anniversary Towers, Univesity way ', 'P.O. Box 40247 - 00100', '', 'Nairobi', '2.55E+11', '2.55E+11', 'RKipturgo@epc.or.ke', '', 'Anniversary Towers, Univesity way ', 'www.epckenya.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-195', 'National Water Conservation & Pipeline Corporation', 'State Corporation', '', 'Dunga Road, Industrial Area', 'P. O. Box 30173, 00100', '', 'Nairobi', '2.55E+11', '2.55E+11', 'mwelelubrian@gmail.com', '', 'Dunga Road, Industrial Area', 'www.nwcpc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-196', 'Kenya Forestry Research Institute', 'State Corporation', '', 'Muguga, Limuru', 'P.  O. Box 20412 - 00200', '', '', '2.55E+11', '2.55E+11', 'iodhiambo@kefri.org', '', 'Muguga, Limuru', 'www.kefri.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-197', 'Moi University', 'Public Universities', '', '  Eldoret', 'P. O. Box 3900', '', '', '2.55E+11', '2.55E+11', 'veronibelio@gmail.com', '', '  Eldoret', 'https://www.mu.ac.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-198', 'Kenya Animal Genetic Resources Centre', 'State Corporation', '', '      lower kabete', '23070-0604', '', '', '725017934', '725017934', 'njeptoo@kagrc.co.ke', '', '      lower kabete', 'www.kagrc.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-199', 'Muhoroni Sugar Company', 'State Corporation', '', 'MUHORONI SUGAR CO.', '2 MUHORONI', '', '', '2.55E+11', '202333575', 'john.odhiambo@musco.co.ke', '', 'MUHORONI SUGAR CO.', 'www.musco.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-200', 'Kenya Utalii College', 'State Corporation', '', 'THIKA ROAD', '31052-00600 NAIROBI', '', 'Nairobi', '2.55E+11', '722205891', 'msndungu@utalii.ac.ke', '', 'THIKA ROAD', 'www.utalii.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-201', 'State Department of Immigration, Border Control and citizen Services', 'State Department', '', '  Nyayo House Nairobi', '30395-00100', '', '', '2.55E+11', '20222202', 'kiptuic@gmail.com', '', '  Nyayo House Nairobi', 'www.immigration.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-202', 'University of Kabianga', 'Public Universities', '', ' Kericho', '2030-20200', '', '', '2.55E+11', '722986749', 'ckisato@kabianga.ac.ke', '', ' Kericho', 'www.kabianga.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-203', 'County Assembly of Laikipia', 'County Assemblies', '', 'KENYATTA HIGHWAY', '487-10400', '', '', '2.55E+11', '721397429', 'jngethe@laikipiaassembly.go.ke', '', 'KENYATTA HIGHWAY', 'http://laikipiaassembly.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-204', 'Coast Water Services Board', 'State Corporation', '', 'Mikindani Street, Off Nkurumah Road, Mombasa', '090417-80100, Mombasa', '', '', '2.55E+11', '041-2315230', 'salim@cwsb.go.ke', '', 'Mikindani Street, Off Nkurumah Road, Mombasa', 'www.cwsb.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-205', 'The Meru National Polytechnic', 'Public Colleges', '', 'Meru', '111 - 60200', '', '', '719347059', '719347059', 'imutwiri54@gmail.com', '', 'Meru', 'WWW.MERUNATIONALPOLYTECHNIC.AC.KE', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-206', 'Kenya Law Reform Commission', 'State Corporation', '', 'Reinsurance Plaza Nairobi', '34999 - 00100', '', '', '2.55E+11', '799030716', 'jamesruteere@klrc.go.ke', '', 'Reinsurance Plaza Nairobi', 'www.klrc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-207', 'Kenya Bureau of Standards', 'State Corporation', '', ' Popo Road, off Belle Vue South C', '54974 - 00200 Nairobi', '', 'Nairobi', '2.55E+11', '2.55E+11', 'mwakithij@kebs.org', '', ' Popo Road, off Belle Vue South C', 'www.kebs.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-208', 'Office of the Auditor General', 'Commissions and Independent Offices', '', '334', '30084', '', '', '2.55E+11', '726274255', 'isaac.ayoyi@oagkenya.go.ke', '', '334', 'www.oagkenya.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-209', 'Kenya Urban Roads Authority', 'State Corporation', '', 'IKM Place, 5th Ngong Avenue', '41727 - 00100 Nairobi', '', 'Nairobi', '2.55E+11', '2.55E+11', 'lmwiti@kura.go.ke', '', 'IKM Place, 5th Ngong Avenue', 'www.kura.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-210', 'Kitui', 'County', '', 'Tanathi Water Service Board Building', 'P. 0. Box 33 - 90200, Kitui', '', '', '2.55E+11', '2.55E+11', 'smususya@yahoo.com', '', 'Tanathi Water Service Board Building', 'www.kitui.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-211', 'Ministry of Water and Sanitation', 'Ministry', '', '49720', '100', '', '', '2.55E+11', '2.55E+11', 'mutinvero@gmail.com', '', '49720', 'www.water.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-212', 'Kibabii University', 'Public Universities', '', 'Bungoma', '1699-50200', '', '', '2.55E+11', '743761716', 'jamesoo@kibu.ac.ke', '', 'Bungoma', 'www.kibu.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-213', 'Kenya Dairy Board', 'State Corporation', '', 'Nairobi', '30406 - 00100', '', '', '2.55E+11', '2.55E+11', 'kebuka.joshua@kdb.co.ke', '', 'Nairobi', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-214', 'Alupe University', 'Public Universities', '', ' Busia Malaba Road', '845-50400', '', '', '2.55E+11', '741217185', 'kogola222@gmail.com', '', ' Busia Malaba Road', 'www.auc.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-215', 'Nandi', 'County', '', ' Nandi County Government Building-Kapsabet', '802', '', '', '2.55E+11', '535252355', 'isidore.koech@nandi.go.ke', '', ' Nandi County Government Building-Kapsabet', 'www.nandi.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-216', 'Independent Policing Oversight Authority', 'State Corporation', '', 'ACK Garden Annex 3rd Floor, 1st Ngong Avenue.', '23035 - 00100 Nairobi', '', 'Nairobi', '706317737', '-4905766', 'info@ipoa.go.ke', '', 'ACK Garden Annex 3rd Floor, 1st Ngong Avenue.', 'www.ipoa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-217', 'Nyandarua', 'County', '', 'Olkalou', '701 - 20303', '', '', '722334192', '2026660859', 'info@nyandaruacounty.or.ke', '', 'Olkalou', 'www.nyandarua.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-218', 'Commission of Administrative Justice - Office of the Ombudsman', 'Commissions and Independent Offices', '', 'WEST END TOWERS 2ND FLOOR ON WAIYAKI WAY ', '20414', '', '', '+254 722873801', '202270000', 'info@ombudsman.go.ke', '', 'WEST END TOWERS 2ND FLOOR ON WAIYAKI WAY ', 'www.ombudsman.go.ke  ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-219', 'Anti - Doping Agency of Kenya', 'State Corporation', '', '    6th Floor Parklands Plaza ,Muthithi/Chiromo Lane Junction', '2276', '', '', '2.55E+11', '0.999954589', 'nemwelarama@gmail.com', '', '    6th Floor Parklands Plaza ,Muthithi/Chiromo Lane Junction', 'www.adak.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-220', 'Public Service', 'State Department', '', 'Nairobi-Teleposta Towers', 'P.O Box 30050-00100', '', 'Nairobi', '+254 721 422320', '020-227411', 'info@psyg.go.ke', '', 'Nairobi-Teleposta Towers', 'www.psyg.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-221', 'County Assembly Of Muranga', 'County Assemblies', '', 'opposite ihura stadium', '731-10200', '', '', '+254 723200485', '2.55E+11', 'murangacountyassembly@gmail.com', '', 'opposite ihura stadium', 'www.assembly.muranga.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-222', 'Embu', 'County', '', 'EMBU TOWN', '36 - 60100', '', '', '+254 721723435', '+254 771 204 003 +254 703 192 924 +254 68 30686 +254 68 30656', 'info@embu.go.ke, procurement@embu.go.ke', '', 'EMBU TOWN', 'www.embu.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-223', 'Huduma Kenya Secretariat', 'State Department', '', 'Lonrho House Standard ', '47716 - 00100', '', '', '+254 731878393', '206900020', 'info@hudumakenya.go.ke', '', 'Lonrho House Standard ', 'www.hudumakenya.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-224', 'Masinde Muliro University of Science and Technology (MMUST)', 'Public Universities', '', 'KAKAMEGA WEBUYE ROAD', 'P.O Box 190 - 50100, KAKAMEGA', '', '', '+254 710247230', '0702-597360', 'vc@mmust.ac.ke', '', 'KAKAMEGA WEBUYE ROAD', 'www.mmust.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-225', 'Energy', 'State Department', '', '0', '0', '', '', '+254 722328256', '0', 'ps@energymin.go.ke', '', '0', 'ps@energymin.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-226', 'Health', 'State Department', '', 'AFYA HOUSE, CATHEDRAL ROAD', '30016-00100 Nairobi', '', '', '+254 721202182', '254-(020)-2717077', 'pshealthke@gmail.com', '', 'AFYA HOUSE, CATHEDRAL ROAD', 'www.health.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-227', 'Nyamira', 'County', '', 'NYAMIRA COUNTY HEADQUARTERS', 'P.O BOX 434 - 40500, NYAMIRA', '', '', '+254 726400203', '0738727272/ 0735232323', 'info@nyamira.go.ke', '', 'NYAMIRA COUNTY HEADQUARTERS', 'www.nyamira.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-228', 'Meru University of Science and Technology', 'Public Universities', '', 'Meru', '972 - 60200 Meru', '', '', '+254 723831305', '721524293', 'jkanake@must.ac.ke', '', 'Meru', 'www.must.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-229', 'Labour', 'State Department', '', ' P.O Box', '40326 - 00100', '', '', '+254 722438767', '+254 722438767', 'engugi2002@gmail.com', '', ' P.O Box', 'www.laboursp.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-230', 'Transport', 'State Department', '', '   TRANSCOM HOUSE', '52592 00100', '', '', '+254 721498664', '202726362', 'crisauko@gmail.com', '', '   TRANSCOM HOUSE', 'www.transport.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-231', 'Kenya Broadcasting Corporation', 'State Corporation', '', 'BROADCASTING HOUSE,HARRY THUKU ROAD', '30456-00100', '', '', '+254 770122883', '2223757', 'md@kbc.co.ke', '', 'BROADCASTING HOUSE,HARRY THUKU ROAD', 'www.website.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-232', 'Turkana', 'County', '', ' Lodwar,Kenya', 'P O Box 11-30500 Lodwar ', '', '', '+254 722499274', 'N/A', 'supplychainoffice@turkana.go.ke', '', ' Lodwar,Kenya', 'www.turkana.go.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-233', 'Kenya Civil Aviation Authority', 'State Corporation', '', 'Jomo Kenyatta International Airport', '30163 - 00100 Nairobi', '', '', '+254 721710169', '0709725000, ', 'procurement@kcaa.or.ke, info@kcaa.or.ke', '', 'Jomo Kenyatta International Airport', 'www.kcaa.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-234', 'Bungoma', 'County', '', 'Former Municipal Building ', 'P.o Box 437-50200 Bungoma', '', '', '+254 723528821', '055-2030144', 'info@bungoma.go.ke', '', 'Former Municipal Building ', 'www.bungoma.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-235', 'Nyeri', 'County', '', 'Governor\'s Office, Kimathi Way, Nyeri', '1112', '', '', '+254 720115468', '612030700', 'procurement@nyeri.go.ke', '', 'Governor\'s Office, Kimathi Way, Nyeri', 'www.nyeri.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-236', 'Uasin Gishu', 'County', '', 'Uasin Gishu County Hall', 'P. O. Box  40 - 30100 Eldoret', '', '', '721109025', '53203375', 'cecfinance@uasingishu.go.ke', '', 'Uasin Gishu County Hall', 'www.uasingishu.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-237', 'Machakos', 'County', '', 'Ngei Road', '1996 - 90100', '', '', '+254 724849990', '2.55E+11', 'jnzambu@gmail.com', '', 'Ngei Road', 'www.machakosgovernment.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-238', 'National Social Security Fund', 'State Corporation', '', ' Social Security Hse, Block C, Bishops Rd, Ground Flr ', 'P.O. Box 45969 ??? 00100, Nairobi', '', 'Nairobi', '2.55E+11', '2.55E+11', 'shair.u@nssfkenya.co.ke', '', ' Social Security Hse, Block C, Bishops Rd, Ground Flr ', 'www.nssf.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-239', 'Early Learning & Basic Education', 'State Department', '', '   P.O Box 40530 - 00100 Nairobi ', 'P.O Box 40530 - 00100 Nairobi ', '', 'Nairobi', '2.55E+11', '3318581', 'nyamburafrancesca@gmail.com', '', '   P.O Box 40530 - 00100 Nairobi ', 'x', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-240', 'National Assembly ', 'Commissions and Independent Offices', '', '  clerks Chambers', 'P.O Box 41842 -00100 Nairobi', '', 'Nairobi', '2.55E+11', '2221291', 'Josephantonynjagi@gmail.com', '', '  clerks Chambers', 'www.parliament.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-241', 'IDB Capital', 'State Corporation', '', '18th Floor, National Bank Building, Harambee Avenue', 'P. O. Box 44036, 00100', '', '', '+254 723494855', '202247142', 'bizcare@idbkenya.com', '', '18th Floor, National Bank Building, Harambee Avenue', 'www.idbkenya.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-242', 'Kenya Law', 'State Corporation', '', '1ST NGONG, AVENUE.', 'P.O BOX 10443-00100, NAIROBI.', '', 'Nairobi', '+254 722793990', '020-2712767', 'info@kenyalaw.org', '', '1ST NGONG, AVENUE.', 'www.kenyalaw.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-243', 'County Assembly Of Kitui', 'County Assemblies', '', 'Kitui County Assembly', 'P. O. Box 694 - 90200, Kitui', '', '', '722568459', '444422914', 'kutuiassembly@gmail.com', '', 'Kitui County Assembly', 'http://www.kituicountyassembly.org/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-244', 'Kenya Institute of Special Education', 'State Corporation', '', 'Kasarani', 'P.O BOX 48413-00100', '', 'Nairobi', '+254 722819784', '020-8007977/ 0724-269-505', 'info@kise.ac.ke', '', 'Kasarani', 'www.kise.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-245', 'State Department for Fisheries, Aquaculture and the Blue Economy', 'State Department', '', 'KILIMO HOUSE', '58187-00200 NAIROBI', '', 'Nairobi', '+254 725870484', '020 2718870', 'psfisheries@kilimo.go.ke', '', 'KILIMO HOUSE', 'www.kilimo.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-246', 'Social Protection, Pensions & Senior Citizens Affairs', 'State Department', '', ' UPPER HILL, NSSF BUILDING, BLOCK A, EASTERN WING, 1ST, 2ND, 4TH, 5TH, 6TH,7TH,8TH,13TH, 14TH, AND WESTERN WING 22ND FLOORS', '46205-00100, NAIROBI', '', 'Nairobi', '+254 721491487', '+254 (0) 2729800/2727980-4', 'James.Ngogu@socialprotection.go.ke/pssocialsecurity@labour.go.ke', '', ' UPPER HILL, NSSF BUILDING, BLOCK A, EASTERN WING, 1ST, 2ND, 4TH, 5TH, 6TH,7TH,8TH,13TH, 14TH, AND WESTERN WING 22ND FLOORS', 'www.laboursp.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-247', 'Kilifi', 'County', '', 'Kilifi- Town', '519-80108', '', '', '+254 739931871', '736001003', 'info@kilifi.go.ke', '', 'Kilifi- Town', 'www.kilifi.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-248', 'Mandera', 'County', '', 'Mandera Town', '13-70300', '', '', '+254 723970414', '2.55E+11', 'supplychain@mandera.go.ke', '', 'Mandera Town', 'www.mandera.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-249', 'County Assembly Of Isiolo', 'County Assemblies', '', '0', '0', '', '', '+254 724 950768', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-250', 'County Assembly Of Mandera', 'County Assemblies', '', 'Mandera East', '0', '', '', '+254 722410140', '0', 'info@manderaassembly.go.ke', '', 'Mandera East', 'www.manderaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-251', 'County Assembly Of Garissa', 'County Assemblies', '', 'Garissa Township', '57-70100, Garissa', '', '', '+254 722296647', '2.55E+11', 'iyussuf@garissaassembly.go.ke', '', 'Garissa Township', 'www.garisaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-252', 'Nairobi', 'County', '', 'City Hall', 'P.O Box 30075 - 00100', '', 'Nairobi', '722312515', '722312515', 'wambugubety7@gmail.com', '', 'City Hall', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-253', 'The Kenyatta International Convention Centre', 'State Corporation', '', 'Harambee Avenue Nairobi', '30746 - 00100 Nairobi', '', 'Nairobi', '726532612', '726532612', 'judith.nyaberi@kicc.co.ke', '', 'Harambee Avenue Nairobi', 'www.kicc.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-254', 'Michuki Technical Training Institute', 'Public Colleges', '', 'Kangema', 'P.O Box 4 - 10202', '', '', '726347973', '725912313', 'michukitech@yahoo.com', '', 'Kangema', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-255', 'Tharaka-Nithi', 'County', '', 'Kathwana', '10', '', '', '+254 714273724', '2.55E+11', 'info@tharakanithi.go.ke', '', 'Kathwana', 'https://tharakanithi.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-256', 'Trans Nzoia', 'County', '', 'KITALE', 'P.O BOX 4211 - 30200 KITALE', '', '', '+254 720865083', '(054)30301/2', 'info@transnzoia.go.ke', '', 'KITALE', 'https://www.transnzoia.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-257', 'West Pokot', 'County', '', 'Kapenguria.', '220-30600', '', '', '+254 708913337', '+254 053-201-4000', 'info@westpokot.go.ke', '', 'Kapenguria.', 'www.westpokot.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-258', 'National Environment Management Authority', 'State Corporation', '', 'Popo Road Nairobi', 'P. O. Box 67839 -00200', '', '', '2.55E+11', '724253398', 'dgnema@nema.go.ke', '', 'Popo Road Nairobi', 'www.nema.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-259', 'State Department for Culture & Heritage', 'State Department', '', 'kencom house', '49849-90100', '', '', '+254 727725650', 'Tel:+254-020-2251164,2251005,2250576    ', 'psoffice@minspoca.go.ke', '', 'kencom house', 'www.minspoca.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-260', 'Council of Legal Education', 'State Corporation', '', 'Karen office Park, Acacia Block 2 Floor', '829-00502, Karen', '', '', '+254 722498354', '2.55E+11', 'jkirande@cle.or.ke', '', 'Karen office Park, Acacia Block 2 Floor', 'cle.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-261', 'Rongo University', 'Public Universities', '', 'Rongo-Migori road, Kitere hills off Kanga junction', '103-40404 RONGO', '', '', '+254 722242008', '770308267', 'procurement@rongovarsity.ac.ke', '', 'Rongo-Migori road, Kitere hills off Kanga junction', 'www.rongovarsity.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-262', 'County Assembly Of Lamu', 'County Assemblies', '', '0', '0', '', '', '+254 705784395', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-263', 'Kitui East Constituency Development Fund', 'NGCDF Committees', '', '0', '0', '', '', '+254 723556349', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-264', 'State Department for University Education', 'State Department', '', 'Jogoo House `B` , Harambee Avenue in Nairobi. ', ' P.O. Box 30040-00100, Nairobi ', '', 'Nairobi', '+254 721281562', '208024828', 'petupazuri@yahoo.com', '', 'Jogoo House `B` , Harambee Avenue in Nairobi. ', 'http://www.education.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-265', 'Office of the Registrar of Political Parties', 'Commissions and Independent Offices', '', 'Lion Place 1st Floor, Sarit Centre Nairobi', '1131-00606', '', '', '+254 706171407', '020 4022000', 'registrar@orpp.or.ke', '', 'Lion Place 1st Floor, Sarit Centre Nairobi', 'orpp.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-266', 'County Assembly Of Kakamega', 'County Assemblies', '', 'Off Fitina Road behind Kakamega Law Courts', '1470 - 50100 KAKAMEGA', '', '', '+254 722387212', '715521221', 'kakamegacountyassembly@gmail.com', '', 'Off Fitina Road behind Kakamega Law Courts', 'www.kakamega-assembly.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-267', 'Central Bank of Kenya', 'State Corporation', '', 'Haile Selassie Avenue', '6000-00200', '', '', '+254 720348838', '202860000', 'Comms@centralbank.go.ke', '', 'Haile Selassie Avenue', 'www.centralbank.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-268', 'Karatina University', 'Public Universities', '', 'Karatina', 'P. O Box 1957 -10101', '', '', '723671698', '723671698', 'awanjiru@karu.ac.ke', '', 'Karatina', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-269', 'Kenya Electricity Transmission Company LTD', 'State Corporation', '', 'KAWI HOUSE, BLOCK B', '34942 - 00100', '', '', '719018801', '719018000', 'info@ketraco.co.ke', '', 'KAWI HOUSE, BLOCK B', 'https://www.ketraco.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-270', 'Kiambu', 'County', '', 'KIAMBU', '2344,KIAMBU', '', '', '+254 722867477', '+254 709 877 000', 'info@kiambu.go.ke', '', 'KIAMBU', 'http://kiambu.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-271', 'Kaimosi Friends University College (MMUST)', 'Public Universities', '', 'KAIMOSI', 'P.o Box 385 - 50309', '', '', '+254 723707242', '0', 'jrapando@kafuco.ac.ke', '', 'KAIMOSI', 'www.kafuco.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-272', 'Kericho', 'County', '', '0', '0', '', '', '+254 726364541', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-273', 'Indepedent Electoral and Boundaries Commission', 'Commissions and Independent Offices', '', 'Anniversary Towers', '45371-00100', '', '', '+254 722431428', '2.54E+12', 'info@iebc.or.ke', '', 'Anniversary Towers', 'www.iebc.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-274', 'National Authority for the Campaign Against Alcohol and Drug Abuse', 'State Corporation', '', 'NSSFBuiding  Block "A",Eastern Wing  18th  Floor ', '10774-00100', '', '', '+254 725311198', '2721997/2721993', 'info@nacada.go.ke ', '', 'NSSFBuiding  Block "A",Eastern Wing  18th  Floor ', 'www.nacada.go.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-275', 'Vocational & Technical Training', 'State Department', '', 'Jogoo B, Harambee Avenue', 'P.O. Box 9583 - 00200', '', '', '+254 722807057', '203318581', 'psvtt@education.go.ke', '', 'Jogoo B, Harambee Avenue', 'www.education.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-276', 'Crop Development', 'State Department', '', 'cathedral road', 'P.O Box 34188-00100 Nairobi', '', 'Nairobi', '+254 726038358', '2718870', 'psagriculture@kilimo.go.ke', '', 'cathedral road', 'www.kilimo.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-277', 'Kenya Medical training College', 'Public Colleges', '', 'Off Mbagathi Road', '30195-00100 NAIROBI', '', 'Nairobi', '+254 721352315', '0202725711/14', 'info@kmtc.ac.ke', '', 'Off Mbagathi Road', 'www.kmtc.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-278', 'Agro-Chemical and Food Company Limited', 'State Corporation', '', '   Muhoroni', 'P.O Box 18 - 40107', '', '', '2.55E+11', '2.55E+11', 'wkarani@acfc.co.ke', '', '   Muhoroni', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-279', 'Garissa', 'County', '', 'sherrif Apartment', '563-70100', '', '', '+254 728507373', '728507373', 'enquiries@garissa.go.ke', '', 'sherrif Apartment', 'www.garissa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-280', 'State Department for Housing, Urban Development & Public Works', 'State Department', '', 'Works building ', '30743-00100 Nairobi', '', '', '+254 726285210', '202723101', 'info@publicworks.go.ke', '', 'Works building ', 'www.transport.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-281', 'Kenya Nuclear Electricity Board', 'State Corporation', '', 'Kawi complex ', '26374', '', '', '+254 711392706', '254-20-5138300', 'mmwangi@nuclear.co.ke', '', 'Kawi complex ', 'www.nuclear.co.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-282', 'Tourism Research Institute', 'State Corporation', '', 'UTALII HOUSE 7TH FLOOR ROOM 732', 'P.O.BOX 42131-00100 NAIROBI', '', '', '+254 720656807', '020-3317850', 'ceo@tri.go.ke', '', 'UTALII HOUSE 7TH FLOOR ROOM 732', 'N/A', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-283', 'Kitui NGAAF', 'NGAAF', '', 'Nzambaani Park Building, Kitui', 'P. O. Box 1-90200, Kitui, ', '', '', '726216009', '726216009', 'denniskitheka@gmail.com', '', 'Nzambaani Park Building, Kitui', 'http://www.ngaaf.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-284', 'Chemelil Sugar Company Limited', '6138', '', 'csc@chemsugar.co.ke', 'Along Awasi/Nandi Hills Road, Kisumu County', '', '', '\\N', '020 2031883/4/5/7\\', '  GSM Lines: 0722 209798, 0710 766383, 0735 234733', '', 'csc@chemsugar.co.ke', '359_logo_image.jpg', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-285', 'Lake Victoria North Water services Board', 'State Corporation', '', 'Kefinco Hse, off Kakamega-Kisumu Road', 'P.O Box 673 - 50100 Kakamega', '', '', '+254 710510276', ' 020 7608130', 'info@lvnwsb.go.ke', '', 'Kefinco Hse, off Kakamega-Kisumu Road', 'http://www.lvnwsb.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-286', 'Kajiado', 'County', '', 'Off Nairobi - Namanga Road', 'P O Box 11-001100 Kajiado', '', '', '+254 723567814', '2.54E+11', 'info@kajiado.go.ke', '', 'Off Nairobi - Namanga Road', 'www.kajiado.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-287', 'Netfund', 'State Corporation', '', 'National Water Plaza, 1st Floor, Dunga road, Industrial Area', '19324-00202', '', '', '+254 714545498', '202369563', 'info@netfund.go.ke', '', 'National Water Plaza, 1st Floor, Dunga road, Industrial Area', 'www.netfund.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-288', 'Kwale', 'County', '', 'KWALE', '4-80403', '', '', '+254 725226916', '728348911', 'madonna@procurement.kwale.go.ke', '', 'KWALE', 'http://www.kwalecountygov.com/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-289', 'National Police Service Commission', 'Commissions and Independent Offices', '', 'westlands,Nairobi', '47363', '', '', '+254 793011404', '709099000', 'info@npsc.go.ke', '', 'westlands,Nairobi', 'www.npsc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-290', 'County Assembly Of Siaya', 'County Assemblies', '', 'Siaya County Headquarters', 'P.O.BOX 7-40600 SIAYA', '', '', '+254 722712225', '-708744894', 'clerk@siayaassembly.go.ke', '', 'Siaya County Headquarters', 'www.siayaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-291', 'Kwale Water and Sewerage Company Ltd', 'Public Water Companies', '', '  Likoni Kwale road off-SIDA road,Kwale', 'Box 18-80403', '', '', '2.55E+11', '412014155', 'info@kwalewater.co.ke', '', '  Likoni Kwale road off-SIDA road,Kwale', 'www.kwalewater.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-292', 'Kengen Staff Retirement Benefits Scheme', 'Pension Schemes', '', 'KenGen Pension Plaza 2, 11th Floor, Kolobot Road, Nairobi', '47936 - 00100', '', '', '+254 739251000', '+254 071 103 6000', 'info@kengensrbs.co.ke ', '', 'KenGen Pension Plaza 2, 11th Floor, Kolobot Road, Nairobi', 'www.kengensrbs.co.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-293', 'Kenya Leather Development Council', 'State Corporation', '', ' CPA Centre, 5th Floor, Thika Road, Nairobi', '14480-00800 NRB', '', '', '2.55E+11', '2.55E+11', 'info@leathercouncil.go.ke', '', ' CPA Centre, 5th Floor, Thika Road, Nairobi', 'www.leathercouncil.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-294', 'Jomo Kenyatta University of Agriculture and Technology (JKUAT)', 'Public Universities', '', 'Juja Kiambu County', 'Box 62000-00200', '', '', '724934928', '724934928', 'rkiprop@jkuat.ac.ke', '', 'Juja Kiambu County', 'http://www.jkuat.ac.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-295', 'Maasai Mara University', 'Public Universities', '', 'Narok - Bomet Road', 'Box 861, Narok', '', '', '722886440', '205131400', 'procurement@mmarau.ac.ke', '', 'Narok - Bomet Road', 'www.mmarau.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-296', 'Kenya National Library Service', 'State Corporation', '', 'Mumias Road/Ol Donyo Sabuk Road Junction, Buruburu', '30573-00100', '', '', '2.55E+11', '0207786710/2158352', 'edel.ratemo@knls.ac.ke', '', 'Mumias Road/Ol Donyo Sabuk Road Junction, Buruburu', 'www.knls.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-297', 'Ethics and Anti-Corruption Commission', 'http://www.eacc.go.ke', '', '2100312/3 Mobile: 0729888881/2/3\\', ' 0736996600/33', '', '', '\\N', 'Tel: (020) 2717318\\', '2720722\\', '', '2100312/3 Mobile: 0729888881/2/3\\', '+254 729888881', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-298', 'Tom Mboya University College (Maseno)', 'Public Universities', '', 'HOMABAY COUNTY-NEXT TO THE GOVERNOR OFFICE ', '199-40300 HOMABAY', '', '', '+254 724364181', '059-20090', 'principal@tmuc.ac.ke', '', 'HOMABAY COUNTY-NEXT TO THE GOVERNOR OFFICE ', 'https://www.tmuc.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-299', 'Taita-Taveta', 'County', '', 'wundanyi', '1066-80304', '', '', '+254 714748657', '788186436', 'governortaitatavet@yahoo.com', '', 'wundanyi', 'www.taitataveta.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-300', 'South Eastern Kenya University ', 'Public Universities', '', 'Machakos, Kitui rd, off Kwa Vonza', 'P.O. Box 170 - 90200, Kitui', '', '', '2.55E+11', '2.55E+11', 'vc@seku.ac.ke', '', 'Machakos, Kitui rd, off Kwa Vonza', 'www.seku.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-301', 'Lake Basin Development Authority', 'State Corporation', '', 'Off Kisumu Kakamega Road', 'PO Box 1516 - 40100 Kisumu', '', '', '+254 735606843', '202110593', 'info@lbda.co.ke', '', 'Off Kisumu Kakamega Road', 'www.lbda.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-302', 'Busia', 'County', '', '0', 'PRIVATE BAG', '', '', '+254 726147052', '0', '', '', '0', 'busiacounty.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-303', 'Wajir', 'County', '', 'wajir', 'po.box 9-70200', '', '', '+254 725887868', '0', 'info@wajir.go.ke', '', 'wajir', 'www.wajir.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-304', 'Technical University of Mombasa', 'Public Universities', '', 'Mombasa', '90420-80100', '', '', '+254 728654489', '+254 724 955377,733 955377', 'supplies@tum.ac.ke', '', 'Mombasa', 'Web: www.tum.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-305', 'Centre for Mathematics, Science and Technology Education in Africa', 'State Corporation', '', 'Karen Road - Bogani Road Junction', 'P. O. Box 24214, 00502', '', '', '2.55E+12', '020 2044406, 0706722697', 'director@cemastea.ac.ke', '', 'Karen Road - Bogani Road Junction', 'www.cemastea.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-306', 'Kenya Reinsurance Corporation Ltd', 'State Corporation', '', 'Reinsurance Plaza', 'P. O. Box 30271, 00100', '', '', '2.55E+12', '020220200, 0703083000', 'kenyare@kenyare.co.ke', '', 'Reinsurance Plaza', 'https://www.kenyare.co.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-307', 'Tourism', 'State Department', '', 'Utalii House', 'P. O. Box 30027, 00100 Nairobi', '', 'Nairobi', '2.55E+11', '020 315001', 'ps@tourism.go.ke', '', 'Utalii House', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-308', 'Thogoto Teachers Training College', 'Public Colleges', '', '0', '0', '', '', '+254 728280354', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-309', 'Malindi Water & Sewerage Co. LTD', 'Other Entities owned by County Governments', '', 'Malindi opposite Kilifi County Assembly', '410-80200 MALINDI', '', '', '+254 729897472', '422131037', 'info@malindiwater.co.ke', '', 'Malindi opposite Kilifi County Assembly', 'www.malindiwater.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-310', 'Kenya Investment Authority ', 'State Corporation', '', '0', '0', '', '', '+254 722328709', '0', '', '', '0', 'www.invest.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-311', 'OFFICE OF THE CONTROLLER OF BUDGET', 'Commissions and Independent Offices', '', ' Bima House', '35616 -00100', '', '', '2.55E+11', '202211068', 'lusulial@cob.go.ke', '', ' Bima House', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-312', 'Kenya Veterinary Board', 'State Corporation', '', 'Veterinary Research Laboratories, Upper Kabete', '513-00605 Uthiru', '', '', '722928429', '722305253', 'info@kenyavetboard.or.ke', '', 'Veterinary Research Laboratories, Upper Kabete', 'http://kenyavetboard.or.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-313', 'Makueni', 'County', '', 'Makueni', '78- 90300', '', '', '+254 724 773 931', '020-2034944', 'mail@makueni.go.ke', '', 'Makueni', 'www.makueni.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-314', 'County Assembly of Kirinyaga', 'County Assemblies', '', 'kerugoya', '55-10300', '', '', '+254 722497050', '790523397', 'kirinyagacountyassembly@gmail.com', '', 'kerugoya', 'kirinyagaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-315', 'Women Enterprise Fund', 'State Corporation', '', 'NSSF BUILDING, EASTERN WING , BLOCK A', '017126-00100', '', '', '+254 724501667', '714606845', 'info@wef.co.ke', '', 'NSSF BUILDING, EASTERN WING , BLOCK A', 'www.wef.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-316', 'Ayora Mixed Secondary School', 'Public Schools', '', '0', '0', '', '', '+254 729312786', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-317', 'Nairobi City Water & Sewerage Company LTD', 'Public Water Companies', '', 'Nairobi', '30656-00100', '', '', '+254 720621342', '703080000', 'tenders@nairobiwater.co.ke', '', 'Nairobi', 'www.nairobiwater.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-318', 'Rift Valley Water Services Board', 'State Corporation', '', 'Maji Plaza, Prisons Road, Off Eldama Ravine Nakuru Road', '2451 Nakuru', '', '', '723095945', '723095945', 'wsakuda@rvwsb.go.ke', '', 'Maji Plaza, Prisons Road, Off Eldama Ravine Nakuru Road', 'www.rvwsb.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-319', 'Teachers Service Commission', 'Commissions and Independent Offices', '', 'TSC House, Upper Hill', 'TSC Private Bag, Nairobi, 00100', '', 'Nairobi', '721445985', '721445985', 'kabubii2030@gmail.com', '', 'TSC House, Upper Hill', 'www.tsc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-320', 'National Gender and Equality Comission', 'Commissions and Independent Offices', '', 'SOLUTION TECH BUILDING', '27512-00506', '', '', '+254 728618850', '020321310/0709375100', 'info@ngeckenya.org', '', 'SOLUTION TECH BUILDING', 'www.ngeckenya.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-321', 'Rural Electrification Authority', 'State Corporation', '', 'kawi House South C', '34585-00100', '', '', '+254 726 595604', '709193645', 'info@rea.co.ke', '', 'kawi House South C', 'www.rea.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-322', 'Murang???a University of Technology', 'Public Universities', '', '10200', '75', '', '', '+254 706249039', '0706 249 039', 'procurement@mut.ac.ke', '', '10200', 'www.mut.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-323', 'Kenya National Shipping Line Ltd.', 'State Corporation', '', 'New Cannon tower 1st floor, Moi Avenue  ', '88206 - 80100, Mombasa', '', '', '+254 726249560', '0700510592 / 0412224506', 'admin@knsl.co.ke', '', 'New Cannon tower 1st floor, Moi Avenue  ', 'www.knsl.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-324', 'County Assembly Of Nyeri', 'County Assemblies', '', 'RURINGU-NYERI', 'P.O BOX 162 -10100 NYERI', '', '', '+254 726214205', '721397205', 'nyeriassembly.go.ke', '', 'RURINGU-NYERI', 'www.nyeriassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-325', 'Local Authorities Provident Fund (LAPFUND)', 'State Corporation', '', 'JKUAT Towers, Kenyatta Avenue', '79592-00200 Nairobi', '', 'Nairobi', '713768609', '709805000', 'ymutinda@lapfund.or.ke', '', 'JKUAT Towers, Kenyatta Avenue', 'www.lapfund.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-326', 'Tanathi Water Services Board', 'State Corporation', '', '0', '0', '', '', '+254 722150397', '0', '', '', '0', 'www.tanathi.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-327', 'Kilifi Mariakani Water and Sewerage Company Limited', 'Public Water Companies', '', 'Off Malindi Road at former KDDP Office - Kilifi town', '275-80108 Kilifi', '', '', '+254 726944943', '041-522278/522506/522507', 'info@kilifiwater.co.ke', '', 'Off Malindi Road at former KDDP Office - Kilifi town', 'www.kilifiwater.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-328', 'NGOs Co-ordination Board', 'State Corporation', '', 'Co-operative Bank House 15th floor', '44617', '', '', '+254 722387990', '2214044/2212938', 'info@ngobureau.or.ke', '', 'Co-operative Bank House 15th floor', 'www.ngobureau.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-329', 'National Land Commission', 'Commissions and Independent Offices', '', 'ARDHI HOUSE-1ST AVENUE,NGONG AVENUE', 'P.O BOX 44417-00100,NAIROBI', '', 'Nairobi', '+254 720846453', '+254 271 8050', 'info@landcommission.go.ke', '', 'ARDHI HOUSE-1ST AVENUE,NGONG AVENUE', 'www.landcommission.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-330', ' National Crime Research Centre', 'State Corporation', '', ' ACK Garden Annex- Ground Floor  1st Ngong Avenue, Off Bishop\'s Road  ', 'P .0. BOX 21180-00100 ', '', '', '2.55E+11', '202714735', 'director@crimeresearch.qo.ke', '', ' ACK Garden Annex- Ground Floor  1st Ngong Avenue, Off Bishop\'s Road  ', 'www.crimeresearch.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-331', 'County Assembly Of Homa Bay', 'County Assemblies', '', 'Homabay Town', '20-40300', '', '', '725101444', '725101444', 'tokore@homabayassembly.go.ke', '', 'Homabay Town', 'www.homabayassembly.go.ke  ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-332', 'Kenya Institute of Supplies Mangement', 'State Corporation', '', 'Nation Centre', '30400-00100', '', '', '+254 24088778', '2.55E+11', 'admin@kism.or.ke ', '', 'Nation Centre', 'www.kism.or.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-333', 'Kenya National Commission on Human Rights', 'Commissions and Independent Offices', '', 'CVS PLAZA - LENANA RD/KASUKU LANE', '74359-00200', '', '', '+254 724566702', '020-3969000', 'haki@knchr.org ', '', 'CVS PLAZA - LENANA RD/KASUKU LANE', 'www.knchr.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-334', 'Nyeri Water & Sewerage Company Limited', 'Other Entities owned by County Governments', '', '0', '0', '', '', '+254 721223455', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-335', 'Nairobi Centre for International Arbitration', 'State Corporation', '', 'Haile Selassie Avenue', '548 - 00200', '', '', '+254 722475631', '+254 771293055', 'info@ncia.or.ke', '', 'Haile Selassie Avenue', 'www.ncia.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-336', 'County Assembly Of Migori', 'County Assemblies', '', 'Migori', 'Box 985-40400 Migori', '', '', '711751329', '711751329', 'stevedawns@gmail.com', '', 'Migori', 'www.migoriassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-337', 'Taita Taveta University ', 'Public Universities', '', 'VOI', '635-80300', '', '', '+254 723678488', '020-2437266', 'info@ttu.ac.ke', '', 'VOI', 'www.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-338', 'County Assembly Of Uasin Gishu', 'County Assemblies', '', 'Uasin Gishu County Assembly, Uganda Road', 'Box 100 - 30100', '', '', '722896920', '722896920', 'schangwony@gmail.com', '', 'Uasin Gishu County Assembly, Uganda Road', 'www.ugcountyassembly.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-339', 'County Assembly Of Kisii', 'County Assemblies', '', 'Kisii Town Hall Building', 'Box 4552-40200 Kisii', '', '', '725272418', '725272418', 'info@kisiiassembly.go.ke', '', 'Kisii Town Hall Building', 'www.kisiiassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-340', 'Business Registration Service', 'State Corporation', '', 'Sheria House, Harambee Avenue', 'P. O. Box 40112 - 00100', '', '', '25471528854', '202227461', 'info.statelawoofice@kenya.go.ke', '', 'Sheria House, Harambee Avenue', 'brs.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-341', 'County Assembly Of Busia', 'County Assemblies', '', 'County Assembly Headquaters Busia town-off Busia Kisumu Road', 'Box 1018-50400 Busia', '', '', '720451673', '720451673', 'yvonnelily89@gmail.com', '', 'County Assembly Headquaters Busia town-off Busia Kisumu Road', 'www.busiaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-342', 'Cabinet Affairs Office', 'The Presidency', '', 'Harambee House', '62345-00200 Nairobi', '', 'Nairobi', '+254 720261512', '+254 20 2227436', 'pas@cabinetoffice.go.ke', '', 'Harambee House', 'www.cabinetoffice.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-343', 'State House', 'The Presidency', '', 'state house road', '40530-00100', '', '', '+254 720591527', '020 337460', 'supplychain@president.go.ke', '', 'state house road', 'www.president.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-344', 'Nursing Council of Kenya', 'State Corporation', '', 'Kabarnet Lane, Off Ngong Road', 'Box 20056-00200 Nairobi', '', 'Nairobi', '717649241', '717649241', 'ewanjiku@nckenya.com', '', 'Kabarnet Lane, Off Ngong Road', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-345', 'Nzoia Sugar Company', 'State Corporation', '', 'Bungoma', 'Box 285-50200 BUNGOMA', '', 'Nairobi', '721468867', '721468867', 'amusonye@nzoiasugar.com', '', 'Bungoma', 'www.nzoiasugar.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-346', 'Post Training & Skills Development', 'State Department', '', 'Jogoo House B', 'Box 30040-00200 Nairobi', '', 'Nairobi', '722838728', '722838728', 'bluyera@yahoo.com', '', 'Jogoo House B', 'www.education.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-347', 'Office of the Deputy President', 'The Presidency', '', 'Harambee House Annexe', 'Box 74434-00200 Nairobi', '', 'Nairobi', '711795200', '203247000', 'dp@deputypresident.go.ke', '', 'Harambee House Annexe', 'www.dp@deputypresident.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-348', 'County Assembly Of Nairobi', 'County Assemblies', '', 'City Hall Buildings', 'Box 45844-00100 Nairobi', '', 'Nairobi', '727307956', '020 2216151', 'daisymuema@nairobiassembly.go.ke', '', 'City Hall Buildings', 'www.nairobiassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-349', 'Pwani University', 'Public Universities', '', 'Kilifi , Kenya', 'Box 195-80108 Kilifi, Kenya', '', '', '041 7525106', '041 7525106', 'l.mwacharo@pu.ac.ke', '', 'Kilifi , Kenya', 'www.pu.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-350', 'Bomet University College', 'Public Universities', '', 'Bomet', 'Box 701-20400', '', '', '722272087', '722272087', 'kipsaiya@buc.ac.ke', '', 'Bomet', 'www.buc.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-351', 'Chuka University', 'Public Universities', '', 'CHUKA', '109', '', '', '+254 728655047', '20', '', '', 'CHUKA', 'www.chuka.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-352', 'Pyrethrum Processing Company of Kenya Limited', 'State Corporation', '', 'General Mathenge Road,Industrial area Nakuru', '420-20100,Nakuru', '', '', '+254 726015933', '2211567 or 2211568', 'md@pyrethrum.co.ke ', '', 'General Mathenge Road,Industrial area Nakuru', 'www.kenyapyrethrum.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-353', 'Pharmacy and Poisons Board', 'State Corporation', '', 'Lenana Road, Nairobi', 'P.O. Box 27663-00506, Nairobi', '', 'Nairobi', '+254 722711424', '+254 020 3562107, +254 720 608811, +254 733 884411', 'procurement@pharmacyboardkenya.org', '', 'Lenana Road, Nairobi', 'www.pharmacyboardkenya.org', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-354', 'Kenya Medical Practitioners and Dentists Board', 'State Corporation', '', 'Woodlands Avenue of Lenana Road', 'P.O. BOX 44839 00100 NAIROBI', '', 'Nairobi', '+254 723697180', '020 2728752, 0720771478, 020 272 4994, 0738 504 112, 020 271 1478', 'info@kenyamedicalboard.or.ge', '', 'Woodlands Avenue of Lenana Road', 'www.medicalboard.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-355', 'Financial Reporting Centre', 'State Corporation', '', 'CBK Pension Fund Building', 'Box Private Bag 00200, Nairobi', '', 'Nairobi', '723161376', '723161376', 'georgenjane65@gmail.com', '', 'CBK Pension Fund Building', 'www.frc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-356', 'Maseno University', 'Public Universities', '', 'Kisumu-Busia Road', 'Private Bag Maseno', '', '', '+254 734752679/ +254728338356', '2.55E+11', 'po@maseno.ac.ke /vc@maseno.ac.ke', '', 'Kisumu-Busia Road', 'www.maseno.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-357', 'Judicial Service Commission', 'Commissions and Independent Offices', '', 'Reinsurance Plaza', 'Box 40048-00100 Nairobi', '', 'Nairobi', '723376684', '202739180', 'mirriam.musyimi@jsc.go.ke', '', 'Reinsurance Plaza', 'www.jsc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-358', 'Lamu', 'County', '', 'MOKOWE', '74-80500', '', '', '+254 716034547', '715000555', 'info@lamu.go.ke', '', 'MOKOWE', 'www.lamu.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-359', 'National Cereals and Produce Board', 'State Corporation', '', 'Machakos/Enterprise Road', 'Box 30586-00100 Nairobi', '', '', '722579099', '722579099', 'nwaswa@ncpb.co.ke', '', 'Machakos/Enterprise Road', 'www.ncpb.co.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-360', 'Media Council of Kenya', 'State Corporation', '', 'Ground Floor, Britam Centre, Mara/Ragati Road Junction, Upperhill', '43132-00100', '', '', '+254 731354481', '0727735252/2737058/2716265', 'info@mediacouncil.or.ke', '', 'Ground Floor, Britam Centre, Mara/Ragati Road Junction, Upperhill', 'www.mediacouncil.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-361', 'County Assembly Of Tharaka-Nithi', 'County Assemblies', '', 'Chuka', 'Box 694 Chuka', '', '', '721168156', '721168156', 'enirichu@gmail.com', '', 'Chuka', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-362', 'Kisii', 'County', '', 'Treasury Building', 'P.O. Box 4550 - 40200 Kisii', '', '', '2.55E+11', '2.55E+11', 'procurement@kisii.go.ke', '', 'Treasury Building', 'www.kisii.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-363', 'Bukura Agricultural College', 'Public Colleges', '', 'Sigalagala - Butere Road', 'Box 23-50105 Bukura', '', '', '724889187', '724889187', 'bcheptiony@bukuracollege.ac.ke', '', 'Sigalagala - Butere Road', 'www.bukuracollege.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-364', 'Laikipia', 'County', '', 'Nanyuki', '1271/10400', '', '', '+254 723 871712', '740031031', 'laikipia county government', '', 'Nanyuki', 'www.laikipia.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-365', 'Kenya Safari Lodges & Hotels LTD', 'State Corporation', '', 'Mombasa', '90414-80100', '', '', '+254 715365306', '+254 41 471861-5,+254 722 203143/4', 'mombasabeachhotel@kenya-safari.co.ke', '', 'Mombasa', 'www.safari-hotels.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-366', 'Kenya Coast National Polytechnic', 'Public Colleges', '', 'KISAUNI ROAD,MOMBASA', '81220-80100', '', '', '+254 725307919', '712725554', 'info@kenyacoastpoly.ac.ke', '', 'KISAUNI ROAD,MOMBASA', 'www.kenyacoastpoly.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-367', 'Wote Technical Training Institute', 'Public Colleges', '', 'Makueni', 'P. o. Box 377, 90300 Makueni', '', '', '2.55E+11', '2.55E+11', 'wotettimakueni@gmail.com', '', 'Makueni', 'www.wotetti.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-368', 'Rift Valley Technical Training Institute', 'Public Colleges', '', 'Eldoret', 'P.O.Box 244 - 30100, Eldoret', '', '', '2.55E+11', '2.55E+11', 'info@rvti.ac.ke', '', 'Eldoret', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-369', 'County Assembly Of Turkana', 'County Assemblies', '', 'Lodwar Town', '25 - 30500 LODWAR', '', '', '+254 720442817', 'N/A', 'info@turkanaassembly.go.ke', '', 'Lodwar Town', 'www.turkanaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-370', 'County Assembly Of Trans Nzoia', 'County Assemblies', '', 'KITALE', 'P.O Box 4221', '', '', '+254 726223373', '0', 'transnzoiacountyassembly@gmail.com', '', 'KITALE', 'www.transnzoiaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-371', 'Vihiga', 'County', '', 'The Treasury, Maragoli', 'P. O. Box 344 - 50300', '', '', '2.55E+11', '0', 'vihigatreasury@yahoo.com', '', 'The Treasury, Maragoli', 'www.vihiga.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-372', 'County Assembly Of Vihiga', 'County Assemblies', '', 'Clerks Chambers, Assembly Headquarters, Maragoli', 'P.O. Box 90 - 50300, Maragoli', '', '', '723241613', '202094140', 'vihigaassembly@gmail.com', '', 'Clerks Chambers, Assembly Headquarters, Maragoli', 'www.vihigacountyassembly.or.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-373', 'Tourism Finance Corporation', 'State Corporation', '', 'nairobi', '42013-00100', '', '', '729688935', '203224107', 'md@tourismfinance.go.ke', '', 'nairobi', 'www.tourismfinance.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-374', 'County Assembly Of Bungoma', 'County Assemblies', '', 'Bungoma Town opposite Shariffs Centre', '1886-50200', '', '', '+254 725238974', '725238974', 'info@bungomaassembly.go.ke', '', 'Bungoma Town opposite Shariffs Centre', 'www.bungomaassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-375', 'County Assembly Of Makueni', 'County Assemblies', '', 'wote makindu road', '0572-90300', '', '', '+254 714299286', '714392799', 'info@makueniassembly.go.ke', '', 'wote makindu road', 'www.makueniassebly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-376', 'Nyandarua Institute of Science and Technology', 'Public Colleges', '', 'Nyahururu', '2033-20300 Nyahururu', '', '', '724390784', '727256001', 'nyandaruainstitute2006@gmail.com', '', 'Nyahururu', 'www.nyandaruainstitute.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-377', 'Correctional Services', 'State Department', '', 'Telposta Towers', 'Box 30478-00100 NAIROBI', '', 'Nairobi', '727833865', '202228411', 'ps@coordination.go.ke', '', 'Telposta Towers', 'www.coordination.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-378', 'National Communication Secretariat', 'State Corporation', '', 'Community Aresa', '10756', '', '', '+254 710485751', '-2719719', 'info@ncs.go.ke', '', 'Community Aresa', 'ncs.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-379', 'Nakuru', 'County', '', 'Nakuru', '2780-20100 Nakuru', '', '', '722458086', '512214142', 'supplychainnakuru@gmail.com', '', 'Nakuru', 'www.nakuru.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-380', 'Lapsset Corridor Development Authority', 'State Corporation', '', 'Chester House, 2nd Floor', '45008-00100 Nairobi', '', 'Nairobi', '723836389', '202219098', 'dg@lapsset.go.ke', '', 'Chester House, 2nd Floor', 'www.lapsset.go.ke ', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-381', 'Thika Technical Training Institute', 'Public Colleges', '', 'Thika, Geberal Kago Road', 'P.O. Box 91 - 0100', '', '', '2.55E+11', '020-2044965', 'thikatech@gmail.com', '', 'Thika, Geberal Kago Road', 'www.thikatechnical.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-382', 'Keroka Technical Training Institute', 'Public Colleges', '', '0', '0', '', '', '+254 726985175', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-383', 'Youth', 'State Department', '', 'Kencom House, 3rd Floor', '30500-00100 Nairobi', '', '', '+254 722647341', '2227411', '', '', 'Kencom House, 3rd Floor', 'www.psyg.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-384', 'County Assembly Of Nakuru', 'County Assemblies', '', 'George Morara road', '0', '', '', '+254 702039155', '0', 'p.o box 907', '', 'George Morara road', 'www.assembly.nakuru.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-385', 'Baringo', 'County', '', 'KABARNET', '53-30400 KABARNET', '', '', '+254 724683470', '5321077', 'info@baringo.go.ke', '', 'KABARNET', 'WWW.baringo.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-386', 'Siaya', 'County', '', 'Siaya', 'Box 803-40600 Siaya', '', '', '722810037', '0', 'cs@siaya.go.ke', '', 'Siaya', 'www.siaya.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-387', 'Migori', 'County', '', '0', '0', '', '', '+254 711760725', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-388', 'County Assembly Of Nyamira', 'County Assemblies', '', 'Nyamira', '590-40500 Kisumu', '', '', '724668693', '0', 'info@nyamiraassembly.go.ke', '', 'Nyamira', 'www.nyamiraassembly.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-389', 'Meru', 'County', '', '0', '0', '', '', '+254 722 874546', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-390', 'Administration Police Service', 'State Department', '', '0', '0', '', '', '+254 723535975', '0', '', '', '0', 'www.interior.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-391', 'General Service Unit', 'State Department', '', 'Ruaraka', '49506-00100', '', '', '+254 723845895', '208563733', 'gsuheadquarters17@gmail.com', '', 'Ruaraka', '', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-392', 'Government Chemist', 'State Department', '', '0', '0', '', '', '+254 720470132', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-393', 'National Registration Bureau', 'State Department', '', '0', '0', '', '', '+254 700616325', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-394', 'Integrated Population Registration Services', 'State Department', '', '0', '0', '', '', '+254 721264817', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-395', 'NAtional Disaster Operation Centre', 'State Department', '', 'NYAYO HOUSE 3RD FLOOR', '37300-00100 ', '', '', '+254 722632940', '202151053', 'nationaldisaterops@yahoo.co.uk', '', 'NYAYO HOUSE 3RD FLOOR', 'http://www.interior.go.ke/', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-396', 'Civil Registration Service', 'State Department', '', 'Hass Plaza , Lower hill Road', '49179 - 00100', '', '', '+254 725759009', '2691109', 'procurementcrs@gmail.com', '', 'Hass Plaza , Lower hill Road', 'www.interior.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-397', 'Directorate of Criminal Investigation', 'State Department', '', 'Mazingira House, Kiambu Road', 'P.O Box 30036-00100  Nairobi', '', 'Nairobi', '+254 723951082', '20343312', '', '', 'Mazingira House, Kiambu Road', 'http://www.cid.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-398', 'Government Press', 'State Department', '', '0', '0', '', '', '+254 721585873', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-399', 'National Police Service', 'State Department', '', '0', '0', '', '', '+254 722530386', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-400', 'Kenya Pipeline Company retirement Benefits Scheme', 'Pension Schemes', '', '0', '0', '', '', '+254 706221242', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-401', 'Intergovernmental Relations Technical Committee', 'Semi-Autonomous Government Agencies', '', 'Parklands Plaza ,4th Floor Chiromo Lane', '44880-00100', '', '', '+254 720230888', '+2547(0)202101489', 'info@igrtc.go.ke', '', 'Parklands Plaza ,4th Floor Chiromo Lane', 'www.igrtc.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-402', 'Tana River', 'County', '', 'Hola', 'P.O. BOX 29-70101', '', '', '+254 721113377', '2.55E+11', 'info@tanariver.go.ke', '', 'Hola', 'www.tanariver.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-403', 'Kakamega County Water and Sanitation Company', 'Public Water Companies', '', 'Kenfico House, Off Kakamega - Kisumu Road', 'Box 1189-50100 ', '', 'Kakamega', '718626725', '056-2030355', 'kacwasco@gmail.com', '', 'Kenfico House, Off Kakamega - Kisumu Road', 'www.w.com', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-404', 'County Assembly Of Kajiado', 'County Assemblies', '', 'Kajiado Town-County Headquarter', '94-01100', '', '', '+254 711118826', '711429746', 'info@kajiadoassembly.go.ke', '', 'Kajiado Town-County Headquarter', 'N/A', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-405', 'Egerton University Investment Company', 'State Corporation', '', 'Njoro,Nakuru', '536-20115 ', '', 'EGERTON', '+254 727370288', '+254 700870648', 'euic@egerton.ac.ke', '', 'Njoro,Nakuru', 'N/A', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-406', 'County Assembly Of Nandi', 'County Assemblies', '', '0', '0', '', '', '+254 723813282', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-407', 'National Government Constituencies Development Fund Board', 'State Corporation', '', 'Harambee Plaza, 5th Floor', '46682-', '100', '', '2.55E+11', '709894000', 'info@ngcdf.go.ke', '', 'Harambee Plaza, 5th Floor', 'www.ngcdf.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-408', 'Mombasa', 'County', '', 'County Treasury, Treasury square. Assembly building.', '90440', '80100', 'Nairobi', '+254 716000030', '719000000', 'countyfinance@mombasa.go.ke', '', 'County Treasury, Treasury square. Assembly building.', 'www.mombasa.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-409', 'Kenya Police Service', 'State Department', '', 'Vigilance House', '30083', '', 'Nairobi', '+254 720398710', '020341411/6/8', 'info@kenyapolice.go.ke', '', 'Vigilance House', 'www.kenyapolice.go.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-410', 'The Nyeri National Polytechnic', 'Public Colleges', '', 'Mumbi Road, Nyeri', 'Box 456', '10100', 'Nyeri', '728221831', '612032330', 'info@thenyeripoly.ac.ke', '', 'Mumbi Road, Nyeri', 'www.thenyeripoly.ac.ke', 'Admin', '', '', '', 0, '', '', '', '', ''),
	('PE-411', 'County Assembly Of Kilifi', 'County Assemblies', '', '0', '0', '', '', '+254 711 163 422', '0', '', '', '0', '\\N', 'Admin', '', '', '', 0, '', '', '', '', '');
/*!40000 ALTER TABLE `table 94` ENABLE KEYS */;

-- Dumping structure for table arcm.tempusers
DROP TABLE IF EXISTS `tempusers`;
CREATE TABLE IF NOT EXISTS `tempusers` (
  `Name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `OngoingCases` int(11) NOT NULL,
  `CumulativeCases` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tempusers: ~0 rows (approximately)
DELETE FROM `tempusers`;
/*!40000 ALTER TABLE `tempusers` DISABLE KEYS */;
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
DELETE FROM `tenderaddendums`;
/*!40000 ALTER TABLE `tenderaddendums` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenderaddendums` ENABLE KEYS */;

-- Dumping structure for table arcm.tenders
DROP TABLE IF EXISTS `tenders`;
CREATE TABLE IF NOT EXISTS `tenders` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TenderNo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PEID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TenderValue` float(255,0) DEFAULT '0',
  `StartDate` datetime DEFAULT NULL,
  `ClosingDate` datetime DEFAULT NULL,
  `AwardDate` datetime DEFAULT NULL,
  `Created_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  `Updated_At` datetime DEFAULT NULL,
  `Updated_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Deleted` tinyint(4) DEFAULT NULL,
  `Deleted_At` datetime DEFAULT NULL,
  `Deleted_By` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TenderType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TenderSubCategory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TenderCategory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Timer` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`,`TenderNo`),
  UNIQUE KEY `UK_tenders_ID` (`ID`),
  KEY `ID` (`ID`),
  KEY `FK_PEID` (`PEID`),
  CONSTRAINT `FK_PEID` FOREIGN KEY (`PEID`) REFERENCES `procuremententity` (`PEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tenders: ~0 rows (approximately)
DELETE FROM `tenders`;
/*!40000 ALTER TABLE `tenders` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tendertypes: ~2 rows (approximately)
DELETE FROM `tendertypes`;
/*!40000 ALTER TABLE `tendertypes` DISABLE KEYS */;
INSERT INTO `tendertypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(1, 'A', 'Tenders of Ascertainable Value', '2019-12-05 13:45:55', 'Admin', '2019-12-05 13:45:55', 'Admin', 0, NULL),
	(2, 'B', 'Tenders of Unascertainable Value', '2019-12-05 13:46:08', 'Admin', '2019-12-05 13:46:08', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `tendertypes` ENABLE KEYS */;

-- Dumping structure for table arcm.towns
DROP TABLE IF EXISTS `towns`;
CREATE TABLE IF NOT EXISTS `towns` (
  `PostCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Postoffice` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.towns: ~887 rows (approximately)
DELETE FROM `towns`;
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

-- Dumping structure for procedure arcm.TrackApplicationSequence
DROP PROCEDURE IF EXISTS `TrackApplicationSequence`;
DELIMITER //
CREATE  PROCEDURE `TrackApplicationSequence`(IN _ApplicationNo varchar(50))
BEGIN
select * from applicationsequence where ApplicationNo=_ApplicationNo order by ID ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UnBookVenue
DROP PROCEDURE IF EXISTS `UnBookVenue`;
DELIMITER //
CREATE  PROCEDURE `UnBookVenue`(IN _VenueID INT(11),IN _Date DATETIME,IN _Slot VARCHAR(50),IN _UserID varchar(50),IN _Content VARCHAR(255))
BEGIN
  DECLARE lSaleDesc varchar(200);
  set lSaleDesc= CONCAT('Unbooked Booked Venue:',_VenueID); 
  Update venuebookings set Deleted=1 where VenueID=_VenueID and Date=_Date and Slot=_Slot;
    
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
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateApplication`(IN _ApplicationNo VARCHAR(50), IN _TenderID BIGINT, IN _ApplicantID BIGINT, IN _PEID VARCHAR(50), IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Application :',_ApplicationNo); 

Update applications SET TenderID=_TenderID, ApplicantID=_ApplicantID, PEID=_PEID,  Updated_At=now(),Updated_By=_userID
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
set lSaleDesc= CONCAT('Updated Approver for module: '+ _ModuleCode); 
Update approvers set Username=_Username,ModuleCode=_ModuleCode ,Level=_Level, Update_at=now(),UpdatedBy=_UserID,Active=_Active
where ID=_ID;
call SaveAuditTrail(_userID,lSaleDesc,'UPDATE','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateBank
DROP PROCEDURE IF EXISTS `UpdateBank`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateBank`(  IN _ID INT,IN _Name VARCHAR(100), IN _Branch VARCHAR(50), IN _AcountNo VARCHAR(100), IN _PayBill VARCHAR(50),  IN _userID VARCHAR(50))
    NO SQL
BEGIN

Update  banks  set 
  Name=_Name , Branch=_Branch , AcountNo=_AcountNo,PayBill=_PayBill ,Updated_At=now(),Update_By=_userID WHERE ID=_ID;
call SaveAuditTrail(_userID,'Updated bank Account','Update','0' );
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
CREATE  PROCEDURE `UpdateCaseOfficers`(IN _Username VARCHAR(50), IN _Active BOOLEAN, IN _NotAvailableFrom DATETIME, IN _NotAvailableTo DATETIME, IN _UserID VARCHAR(50))
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Case Officer: ',_Username); 
UPDATE `caseofficers` SET`Active`=_Active,`NotAvailableFrom`=_NotAvailableFrom,`NotAvailableTo`=_NotAvailableTo,
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

-- Dumping structure for procedure arcm.Updatedecisionorders
DROP PROCEDURE IF EXISTS `Updatedecisionorders`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatedecisionorders`(IN _ApplicationNo VARCHAR(50),IN _NO INT(11),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated decision order for Application: ', _ApplicationNo); 
Update decisionorders set  Description=_Description,Updated_At=now() ,Updated_By=_userID 
 where NO=_NO and ApplicationNo=_ApplicationNo;
 
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );

  
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

-- Dumping structure for procedure arcm.Updatefindingsonissues
DROP PROCEDURE IF EXISTS `Updatefindingsonissues`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatefindingsonissues`(IN _ApplicationNo VARCHAR(50),IN _NO INT(11),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated findings on issues for Application: ', _ApplicationNo); 
Update findingsonissues set Description=_Description where NO=_NO;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );

  
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
CREATE  PROCEDURE `UpdateGroupRoles`(IN `_UserGroupID` BIGINT, IN `_RoleID` BIGINT, IN `_Status` BOOLEAN, IN `_Desc` VARCHAR(50), IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
if(SELECT count(*)  from groupaccess where UserGroupID=_UserGroupID and  RoleID=_RoleID)>0 THEN
set lSaleDesc= CONCAT('Updated groupaccess  role for userGroup: ', _UserGroupID ); 

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

-- Dumping structure for procedure arcm.UpdateIssuesforDetermination
DROP PROCEDURE IF EXISTS `UpdateIssuesforDetermination`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateIssuesforDetermination`(IN _ApplicationNo VARCHAR(50),IN _NO INT(11),IN _Description TEXT, IN _userID VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated issue for dertermination application: ', _ApplicationNo); 
Update issuesfordetermination set  Description=_Description where NO=_NO; 
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatejudicialreview
DROP PROCEDURE IF EXISTS `Updatejudicialreview`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatejudicialreview`(IN _ApplicationNo VARCHAR(50), IN _DateofCourtRulling DATE, IN _CaseNO VARCHAR(100), IN _userID VARCHAR(50), IN _Status VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Judicial Review  ApplicationNo:',_ApplicationNo); 
Update judicialreview set
 DateofCourtRulling=_DateofCourtRulling,Status=_Status
  Where ApplicationNo=_ApplicationNo and CaseNO=_CaseNO;
call Saveapplicationsequence(_ApplicationNo,'Judicial Review Closed','Judicial Review Closed',_userID); 
call SaveAuditTrail(_userID,lSaleDesc,'Add','0');
 
  update applications set Status='Closed' where ApplicationNo=_ApplicationNo;

End//
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
CREATE  PROCEDURE `Updatepassword`(IN _Password VARCHAR(128), IN _Username VARCHAR(50))
BEGIN
Update users set `Password`=_Password Where Username=_Username;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatepaymenttypes
DROP PROCEDURE IF EXISTS `Updatepaymenttypes`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatepaymenttypes`( IN _ID INT,IN _Description VARCHAR(100),  IN _userID VARCHAR(50))
    NO SQL
BEGIN

Update paymenttypes set 
  Description=_Description, Update_By=_userID ,Updated_At=now where ID=_ID;
call SaveAuditTrail(_userID,'Updated Payment type','Add','0' );
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
CREATE  PROCEDURE `UpdatePEResponseDetails`(IN _GroundNo VARCHAR(50), IN _GroundType VARCHAR(50), IN _Response TEXT, IN _UserID VARCHAR(50), IN _PEResponseID INT)
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
CREATE  PROCEDURE `UpdatePEResponseStatus`(IN _ApplicationNo VARCHAR(50))
BEGIN
  
Update peresponsetimer set Status='Awaiting Response' where ApplicationNo=_ApplicationNo;

Select Created_By from applicants where ID in (select ApplicantID from applications where ApplicationNo=_ApplicationNo) LIMIT 1 into @Applicant;

Select Email from users where Username=@Applicant into @ApplicantEmail;
Select Phone from users where Username=@Applicant into @ApplicantMobile;
Select Name from users where Username=@Applicant into @ApplicantName;
select TenderID from applications where ApplicationNo=_ApplicationNo LIMIT 1 into @tenderID;

select TenderNo from tenders where ID=@tenderID limit 1 into @TenderNo;
select Name from tenders where ID=@tenderID limit 1 into @TenderName;

Select Email from configurations limit 1 into @PPRAEmail;
Select Mobile  from configurations  limit 1 into @PPRAMobile;

select @ApplicantEmail as ApplicantEmail,@TenderNo as TenderNo,@TenderName as TenderName, @ApplicantMobile as Applicantmobile,@ApplicantName as Applicantname,@PPRAEmail as PPRAEmail,@PPRAMobile as PPRAMobile;

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
CREATE  PROCEDURE `UpdateProfile`(IN _Name VARCHAR(120), IN _Email VARCHAR(128), IN _phone VARCHAR(20), IN _Photo VARCHAR(100), IN _username VARCHAR(50))
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
set lSaleDesc= CONCAT('Changed User Photo for user: ',_username ); 

UPDATE `users`set Photo=_Photo
WHERE `Username`=_username;
call SaveAuditTrail(_username,lSaleDesc,'Update','0' );

End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateRoles
DROP PROCEDURE IF EXISTS `UpdateRoles`;
DELIMITER //
CREATE  PROCEDURE `UpdateRoles`(IN `_RoleName` VARCHAR(128), IN `__RoleDescription` VARCHAR(128), IN `_RoleID` BIGINT, IN `_userID` VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Role  name:' ,_RoleName); 
UPDATE roles set RoleName=_RoleName, RoleDescription=__RoleDescription, UpdatedAt=now() ,UpdateBy=_userID
Where RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateSentjudicialreviewUpdate
DROP PROCEDURE IF EXISTS `UpdateSentjudicialreviewUpdate`;
DELIMITER //
CREATE  PROCEDURE `UpdateSentjudicialreviewUpdate`()
BEGIN
update judicialreviewdocuments set ActionSent='Yes';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateSMSDetails
DROP PROCEDURE IF EXISTS `UpdateSMSDetails`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateSMSDetails`(IN _SenderID VARCHAR(100), IN _UserName VARCHAR(50), IN _URL VARCHAR(200), IN _Key VARCHAR(50),IN _userID VARCHAR(50))
    NO SQL
BEGIN

Update  smsdetails  set 
  SenderID=_SenderID , UserName=_UserName,URL=_URL,`Key`=_Key;
call SaveAuditTrail(_userID,'Updated sms details','Update','0' );
END//
DELIMITER ;

-- Dumping structure for procedure arcm.Updatesmtpdetails
DROP PROCEDURE IF EXISTS `Updatesmtpdetails`;
DELIMITER //
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `Updatesmtpdetails`(IN _Host VARCHAR(100), IN _Port VARCHAR(50), IN _Sender VARCHAR(200),IN _Password VARCHAR(200),IN _userID VARCHAR(50))
    NO SQL
BEGIN

Update  smtpdetails  set 
  Host=_Host , Port=_Port,Sender=_Sender,Password=_Password;
call SaveAuditTrail(_userID,'Updated smtp details','Update','0' );
END//
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
CREATE DEFINER=`Arcm`@`localhost` PROCEDURE `UpdateTender`(IN _ID BIGINT, IN _TenderNo VARCHAR(100), IN _Name VARCHAR(150), IN _PEID VARCHAR(50), IN _StartDate DATETIME, IN _ClosingDate DATETIME, IN _userID VARCHAR(50), IN _TenderValue FLOAT, IN _TenderType VARCHAR(50), IN _TenderSubCategory VARCHAR(50), IN _TenderCategory VARCHAR(50))
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated Tender with TenderNo:',_TenderNo); 

Update tenders
set TenderNo=_TenderNo,TenderType= _TenderType,TenderSubCategory= _TenderSubCategory ,TenderCategory= _TenderCategory,
  Name=_Name, PEID=_PEID, StartDate=_StartDate, ClosingDate=_StartDate,AwardDate=_ClosingDate, Updated_At=now(),  Updated_By=_userID,TenderValue=_TenderValue
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
CREATE  PROCEDURE `UpdateUser`(IN _Name VARCHAR(128), IN _Email VARCHAR(128), IN _UserGroup BIGINT, IN _username VARCHAR(50), IN _IsActive BOOLEAN, IN _userID VARCHAR(50), IN _Phone VARCHAR(20), IN _Signature VARCHAR(128), IN _IDnumber VARCHAR(50), IN _DOB DATETIME, IN _Gender VARCHAR(50), IN _Board BOOLEAN)
    NO SQL
BEGIN
DECLARE lSaleDesc varchar(200);
set lSaleDesc= CONCAT('Updated  User with username: ',_username ); 

UPDATE `users`set `Name`=_Name , `Email`=_Email,Board=_Board,`Phone`=_Phone, `Update_at`=Now(),`IsActive`=_IsActive,`UserGroupID`=_UserGroup,UpdatedBy=_userID, Signature=_Signature,IDnumber=_IDnumber,Gender=_Gender,DOB=_DOB
WHERE `Username`=_username;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );

End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateUserAccess
DROP PROCEDURE IF EXISTS `UpdateUserAccess`;
DELIMITER //
CREATE  PROCEDURE `UpdateUserAccess`(IN `_Username` VARCHAR(50), IN `_RoleID` BIGINT, IN `_Desc` VARCHAR(50), IN `_Status` BOOLEAN, IN `_userID` VARCHAR(50))
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
CREATE  PROCEDURE `UpdateUserGroup`(IN `_Name` VARCHAR(128), IN `_Description` VARCHAR(128), IN `_UserGroupID` BIGINT, IN `_userID` VARCHAR(50))
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
CREATE  PROCEDURE `Updatevenues`(IN _ID int,in _Name VARCHAR(100),IN _Description VARCHAR(150),IN _UserID varchar(50),IN _Branch INT)
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

-- Dumping data for table arcm.useraccess: ~229 rows (approximately)
DELETE FROM `useraccess`;
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
	('Admin', 60, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-09 10:57:28', '2019-10-09 10:57:35'),
	('Admin', 61, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-15 17:09:35', '2019-10-15 17:09:42'),
	('Admin', 62, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-29 10:06:01', '2019-10-29 10:06:04'),
	('Admin', 63, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-07 15:56:34', '2019-11-07 15:56:44'),
	('Admin', 64, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-07 15:56:36', '2019-11-07 15:56:45'),
	('Admin', 65, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:14', '2019-11-16 10:07:40'),
	('Admin', 66, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:12', '2019-11-16 10:07:42'),
	('Admin', 67, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:10', '2019-11-16 10:07:42'),
	('Admin', 68, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:10', '2019-11-16 10:07:43'),
	('Admin', 69, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:08', '2019-11-16 10:07:44'),
	('Admin', 70, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:11', '2019-11-16 10:07:44'),
	('Admin', 71, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:07', '2019-11-16 10:07:45'),
	('Admin', 72, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:07', '2019-11-16 10:07:46'),
	('Admin', 73, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:07:06', '2019-11-16 10:07:47'),
	('Admin', 74, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:23:02', '2019-11-18 10:23:10'),
	('Admin', 75, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:23:02', '2019-11-18 10:23:11'),
	('Admin', 76, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:23:03', '2019-11-18 10:23:12'),
	('Admin', 77, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 16:46:58', '2019-11-18 16:47:01'),
	('Admin', 78, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-19 15:09:59', '2019-11-19 15:10:03'),
	('Admin', 79, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-21 16:07:57', '2019-11-21 16:08:02'),
	('Admin', 80, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-21 16:07:57', '2019-11-21 16:08:03'),
	('Admin', 81, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-26 14:53:00', '2019-11-26 14:53:03'),
	('Admin', 82, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-27 16:57:20', '2019-11-27 16:57:22'),
	('Admin', 83, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 12:10:13', '2019-12-05 12:10:15'),
	('Admin', 84, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-12-05 12:23:41', '2019-12-05 12:23:43'),
	('pkiprop', 24, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 25, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 26, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 27, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 28, 0, 0, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 33, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 35, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 36, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 37, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 38, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 39, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 40, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 42, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 43, 0, 0, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 44, 0, 1, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 45, 0, 1, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 46, 1, 1, 0, 0, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 47, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 48, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 49, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 50, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 51, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 52, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 53, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 54, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 55, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 56, 0, 1, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 57, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 58, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 59, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 60, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 61, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 62, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 63, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('pkiprop', 64, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 10:38:19', '2019-11-15 10:38:19'),
	('Pokumu', 17, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-22 12:55:51', '2019-11-22 12:55:51'),
	('Pokumu', 24, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 25, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 26, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 27, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 28, 0, 0, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 29, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-16 10:04:37', '2019-11-16 10:04:37'),
	('Pokumu', 33, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 35, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 36, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 37, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 38, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 39, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 40, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 42, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 43, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 44, 0, 1, 0, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 45, 0, 1, 0, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 46, 1, 1, 0, 0, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 47, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 48, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 49, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 50, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 51, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 52, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 53, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 54, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 55, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 56, 0, 1, 0, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 57, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 58, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 59, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 60, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 61, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 62, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 63, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('Pokumu', 64, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:28:49', '2019-11-15 10:28:49'),
	('smiheso', 24, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 25, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 26, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 27, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 28, 0, 0, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 33, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 35, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 36, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 37, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 38, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 39, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 40, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 42, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 43, 0, 0, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 44, 0, 1, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 45, 0, 1, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 46, 1, 1, 0, 0, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 47, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 48, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 49, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 50, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 51, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 52, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 53, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 54, 1, 1, 1, 1, 1, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 55, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 56, 0, 1, 0, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 57, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 58, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 59, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 60, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 61, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 62, 0, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 63, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 64, 1, 1, 1, 1, 0, 'SOdhiambo', 'SOdhiambo', '2019-11-15 12:41:09', '2019-11-15 12:41:09'),
	('smiheso', 75, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-22 13:07:40', '2019-11-22 13:07:50'),
	('smiheso', 76, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-22 13:07:41', '2019-11-22 13:07:51'),
	('smiheso', 77, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-22 13:07:42', '2019-11-22 13:07:52'),
	('smiheso', 78, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-22 13:07:43', '2019-11-22 13:07:53'),
	('SOdhiambo', 17, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 18, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 19, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 20, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 21, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 22, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 23, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 24, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 25, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 26, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 27, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 28, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 29, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 30, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 31, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 32, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 33, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 34, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 35, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 36, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 37, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 38, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 39, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 40, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 41, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 42, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 43, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 46, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 47, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 48, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 49, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 50, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 51, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 52, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 53, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 54, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 55, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 56, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 59, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 60, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 61, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 62, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 63, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58'),
	('SOdhiambo', 64, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-15 10:24:58', '2019-11-15 10:24:58');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.usergroups: ~7 rows (approximately)
DELETE FROM `usergroups`;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
INSERT INTO `usergroups` (`UserGroupID`, `Name`, `Description`, `CreatedAt`, `UpdatedAt`, `Deleted`, `CreatedBy`, `UpdatedBy`) VALUES
	(1, 'Admin', 'System Administrators ', '2019-06-13 14:54:49', '2019-11-13 14:31:21', 0, '', 'Admin'),
	(6, 'Clercks', 'Clercks up[dated', '2019-06-25 10:10:12', '2019-06-25 10:10:20', 1, 'admin', 'admin'),
	(7, 'others', 'tenders,', '2019-07-11 16:19:24', '2019-07-11 16:19:24', 1, 'admin', 'admin'),
	(8, 'Portal users', 'Applicants,PE,Interested parties', '2019-08-16 16:47:04', '2019-11-13 14:31:04', 0, 'Admin', 'Admin'),
	(9, 'Case Officers', 'Case Officers', '2019-08-27 17:47:15', '2019-11-11 15:30:36', 0, 'Admin', 'Admin'),
	(10, 'BOARD ROOM !', 'BOARD ROOM !', '2019-09-11 10:47:44', '2019-09-11 10:47:44', 1, 'Admin', 'Admin'),
	(11, 'Finance', 'Finance/Accounts', '2019-11-13 14:33:37', '2019-11-13 14:33:37', 0, 'Admin', 'Admin');
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
  `UserGroupID` bigint(20) DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UpdatedBy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Photo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Signature` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IDnumber` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Gender` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DOB` datetime DEFAULT NULL,
  `ChangePassword` tinyint(1) DEFAULT NULL,
  `Board` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Username`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `MobileNo` (`Phone`),
  UNIQUE KEY `IDNo` (`IDnumber`),
  KEY `users_ibfk_1` (`UserGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.users: ~5 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`Name`, `Username`, `Email`, `Password`, `Phone`, `Create_at`, `Update_at`, `Login_at`, `Deleted`, `IsActive`, `IsEmailverified`, `ActivationCode`, `ResetPassword`, `UserGroupID`, `CreatedBy`, `UpdatedBy`, `Photo`, `Category`, `Signature`, `IDnumber`, `Gender`, `DOB`, `ChangePassword`, `Board`) VALUES
	('Elvis kimutai', 'Admin', 'elviskcheruiyot@gmail.com', '$2b$10$W5YQ2FfNM3pc7poT7Blpz.Rws/nb6zHPo88EU0C1O0BEIWbrssWH6', '0705555285', '2019-07-12 15:50:56', '2019-11-26 14:56:57', '2019-07-12 15:50:56', 0, 1, 1, 'QDrts', '', 1, 'kim', 'Admin', '1573655832969-download.jpg', 'System_User', '1565251011001-signature.jpg', '31547833', 'Male', '1994-12-31 00:00:00', NULL, 1),
	('Philemon Kiprop', 'pkiprop', 'philchem2009@gmail.com', '$2b$10$2vVCH1AbRn3gRUaNcsFzIeEO2bmSw9aGRDBwRiqC91a/JEDeb6sQu', '0722955458', '2019-11-15 10:38:19', NULL, NULL, 0, 1, 0, 'Zhvpe', NULL, 9, 'SOdhiambo', NULL, 'default.png', 'System_User', '', '123456', 'Male', '2019-11-15 00:00:00', 1, 0),
	('Philip Okumu', 'Pokumu', 'okumupj@yahoo.com', '$2b$10$zy83GCav50YXdXDIGr1uq.q3eNTGdRQWFc0CJfqY1VI63xbDMfDnq', '0720768894', '2019-11-15 10:28:49', '2019-11-15 10:29:46', NULL, 0, 1, 1, 'MwEe2', NULL, 9, 'Admin', 'Admin', 'default.png', 'System_User', '', '10811856', 'Male', '1970-01-01 00:00:00', 1, 0),
	('Stanley Miheso', 'smiheso', 'mihesosc@yahoo.com', '$2b$10$.2VIwiMBs4xGuPrwdp7IOupE0YK1FExuQ3fFuxQOT8Weh7zYLtCHK', '0722607127', '2019-11-15 12:41:09', '2019-11-15 12:49:31', NULL, 0, 1, 1, 'SQFjZ', NULL, 9, 'SOdhiambo', 'SOdhiambo', 'default.png', 'System_User', '', '9136339', 'Male', '2004-09-07 00:00:00', 1, 1),
	('Samson Odhiambo', 'SOdhiambo', 'x2press@gmail.com', '$2b$10$IVW/TndrqUkbsuh3AhxCqeRrbetmP.TZyXRTZylbMsZjNDLfJScjK', '0721382630', '2019-11-15 10:24:58', '2019-11-15 10:30:18', NULL, 0, 1, 1, 'GbO8J', NULL, 1, 'Admin', 'SOdhiambo', 'default.png', 'System_User', '', '20566933', 'Male', '1983-01-01 00:00:00', 1, 1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.venuebookings: ~0 rows (approximately)
DELETE FROM `venuebookings`;
/*!40000 ALTER TABLE `venuebookings` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.venues: ~0 rows (approximately)
DELETE FROM `venues`;
/*!40000 ALTER TABLE `venues` DISABLE KEYS */;
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
