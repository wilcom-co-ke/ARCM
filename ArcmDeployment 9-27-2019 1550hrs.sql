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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.additionalsubmissiondocuments: ~9 rows (approximately)
DELETE FROM `additionalsubmissiondocuments`;
/*!40000 ALTER TABLE `additionalsubmissiondocuments` DISABLE KEYS */;
INSERT INTO `additionalsubmissiondocuments` (`ID`, `ApplicationID`, `Description`, `FileName`, `FilePath`, `Create_at`, `CreatedBy`, `Deleted`, `DeletedBY`, `Deleted_At`, `Category`, `Confidential`, `SubmitedBy`) VALUES
	(15, 15, 'Document', '1574079583705-6 OF 2019.pdf', 'http://localhost:3001/Documents', '2019-11-18 15:19:44', 'P09875345W', 0, NULL, NULL, 'Applicant', 0, NULL),
	(16, 15, 'Document', '1574079709756-6 OF 2019.pdf', 'http://localhost:3001/Documents', '2019-11-18 15:21:50', 'P09875345W', 0, NULL, NULL, 'Applicant', 0, NULL),
	(17, 15, 'Document 1', '1574082725510-Capture.PNG', 'http://localhost:3001/Documents', '2019-11-18 16:12:05', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 0, 'MINISTRY OF EDUCATION'),
	(18, 23, 'Document', '1574253580917-6 OF 2019.pdf', 'http://74.208.157.60:3001/Documents', '2019-11-20 15:39:41', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 0, 'MINISTRY OF EDUCATION'),
	(19, 26, 'Additional Submissions', '1574358504672-Tender Security.pdf', 'http://74.208.157.60:3001/Documents', '2019-11-21 17:48:25', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 0, 'MINISTRY OF EDUCATION'),
	(20, 26, 'Additional Submissions', '1574358531455-Tender Security.pdf', 'http://74.208.157.60:3001/Documents', '2019-11-21 17:48:51', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 0, 'MINISTRY OF EDUCATION'),
	(21, 26, 'Additional Submissions - Applicant', '1574359215432-Tender Security.pdf', 'http://74.208.157.60:3001/Documents', '2019-11-21 18:00:15', 'P0123456788X', 0, NULL, NULL, 'Applicant', 0, 'JAMES SUPPLIERS LTD'),
	(22, 26, 'Additional Submissions - Applicant 2', '1574359295706-Tender Security.pdf', 'http://74.208.157.60:3001/Documents', '2019-11-21 18:01:36', 'P0123456788X', 0, NULL, NULL, 'Applicant', 0, 'JAMES SUPPLIERS LTD'),
	(23, 28, 'Desc 4', '1574756221312-6 OF 2019.pdf', 'http://74.208.157.60:3001/Documents', '2019-11-26 11:17:01', 'P0123456788X', 0, NULL, NULL, 'Applicant', 0, 'JAMES SUPPLIERS LTD'),
	(24, 28, 'Desc 4', '1574772724063-6 OF 2019.pdf', 'http://74.208.157.60:3001/Documents', '2019-11-26 15:52:04', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 1, 'MINISTRY OF EDUCATION'),
	(25, 35, 'ADDITIONAL SUBMISSION', '1575010203858-6 OF 2019.pdf', 'http://localhost:3001/Documents', '2019-11-29 09:50:04', 'P0123456788X', 0, NULL, NULL, 'Applicant', 0, 'JAMES SUPPLIERS LTD'),
	(26, 36, 'Desc 4', '1575293355526-6 OF 2019.pdf', 'http://localhost:3001/Documents', '2019-12-02 16:29:15', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 0, 'MINISTRY OF EDUCATION');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.additionalsubmissions: ~11 rows (approximately)
DELETE FROM `additionalsubmissions`;
/*!40000 ALTER TABLE `additionalsubmissions` DISABLE KEYS */;
INSERT INTO `additionalsubmissions` (`ID`, `ApplicationID`, `Description`, `FileName`, `FilePath`, `Create_at`, `CreatedBy`, `Deleted`, `DeletedBY`, `Deleted_At`, `Category`, `SubmitedBy`) VALUES
	(5, 15, '<p>This will print all the components we have done so far in one shot. But in real application you need to create a module, divide those into functions and execute them one at a time whenever necessary.</p>\n', '1574079583705-6 OF 2019.pdf', 'http://localhost:3001/Documents', '2019-11-18 15:19:48', 'P09875345W', 0, NULL, NULL, 'Applicant', NULL),
	(6, 15, '<p>&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;</p>\n', '', '0', '2019-11-18 15:46:22', 'P09875345W', 0, NULL, NULL, 'Applicant', 'APPLICANT LTD'),
	(7, 15, '<p>&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;&#39;Procuring Entity&#39;</p>\n', NULL, NULL, '2019-11-18 15:47:28', 'P09875345W', 0, NULL, NULL, 'Applicant', 'APPLICANT LTD'),
	(8, 15, '<p>PE Add</p>\n\n<p>This will print all the components we have done so far in one shot. But in real application you need to create a module, divide those into functions and execute them one at a time whenever necessary.</p>\n', NULL, NULL, '2019-11-18 16:05:26', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 'MINISTRY OF EDUCATION'),
	(9, 15, '<p>DescriptionDescriptionDescriptionDescriptionDescription</p>\n', NULL, NULL, '2019-11-18 16:12:23', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 'MINISTRY OF EDUCATION'),
	(10, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', NULL, NULL, '2019-11-20 15:39:44', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 'MINISTRY OF EDUCATION'),
	(11, 26, '<p>Mr Rapando submitted that the Procuring Entity opposed the joining of the 2nd Respondent as a party to both review applications, contrary to section 170 of the Act and the same should be struck off forthwith.</p>\n', NULL, NULL, '2019-11-21 17:42:18', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 'MINISTRY OF EDUCATION'),
	(12, 26, '<p>Mr Rapando submitted that the Procuring Entity opposed the joining of the 2nd Respondent as a party to both review applications, contrary to section 170 of the Act and the same should be struck off forthwith.</p>\n', NULL, NULL, '2019-11-21 17:58:35', 'P0123456788X', 0, NULL, NULL, 'Applicant', 'JAMES SUPPLIERS LTD'),
	(13, 26, '<p>Mr Rapando submitted that the Procuring Entity opposed the joining of the 2nd Respondent as a party to both review applications, contrary to section 170 of the Act and the same should be struck off forthwith.</p>\n', NULL, NULL, '2019-11-21 18:00:20', 'P0123456788X', 0, NULL, NULL, 'Applicant', 'JAMES SUPPLIERS LTD'),
	(14, 26, '<p>Mr Rapando submitted that the Procuring Entity opposed the joining of the 2nd Respondent as a party to both review applications, contrary to section 170 of the Act and the same should be struck off forthwith.</p>\n', NULL, NULL, '2019-11-21 18:01:43', 'P0123456788X', 0, NULL, NULL, 'Applicant', 'JAMES SUPPLIERS LTD'),
	(15, 28, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula,</p>\n', NULL, NULL, '2019-11-26 11:17:09', 'P0123456788X', 0, NULL, NULL, 'Applicant', 'JAMES SUPPLIERS LTD'),
	(16, 28, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula</p>\n', NULL, NULL, '2019-11-26 15:52:10', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 'MINISTRY OF EDUCATION'),
	(17, 35, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', NULL, NULL, '2019-11-29 09:50:07', 'P0123456788X', 0, NULL, NULL, 'Applicant', 'JAMES SUPPLIERS LTD'),
	(18, 36, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae,&nbsp;</p>\n', NULL, NULL, '2019-12-02 16:29:18', 'A123456789X', 0, NULL, NULL, 'Procuring Entity', 'MINISTRY OF EDUCATION');
/*!40000 ALTER TABLE `additionalsubmissions` ENABLE KEYS */;

-- Dumping structure for procedure arcm.AddPanelMember
DROP PROCEDURE IF EXISTS `AddPanelMember`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPanelMember`(IN _ApplicationNo VARCHAR(50), IN _Role VARCHAR(100), IN _UserName VARCHAR(50), IN _UserID varchar(50))
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.adjournment: ~1 rows (approximately)
DELETE FROM `adjournment`;
/*!40000 ALTER TABLE `adjournment` DISABLE KEYS */;
INSERT INTO `adjournment` (`ID`, `Date`, `Applicant`, `ApplicationNo`, `Reason`, `DecisionDate`, `Status`, `Created_At`, `Created_By`, `Approver`, `ApprovalRemarks`) VALUES
	(6, '2019-11-29 11:31:30', 'AP-17', '31 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', '2019-11-29', 'Declined', '2019-11-29', 'P0123456788X', 'Admin', 'Declined'),
	(7, '2019-12-02 16:37:38', 'AP-17', '32 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae,&nbsp;</p>\n', '2019-12-02', 'Declined', '2019-12-02', 'P0123456788X', 'Admin', 'Declined');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=16384;

-- Dumping data for table arcm.adjournmentapprovalworkflow: ~5 rows (approximately)
DELETE FROM `adjournmentapprovalworkflow`;
/*!40000 ALTER TABLE `adjournmentapprovalworkflow` DISABLE KEYS */;
INSERT INTO `adjournmentapprovalworkflow` (`ID`, `Date`, `Applicant`, `ApplicationNo`, `Reason`, `DecisionDate`, `Status`, `Created_At`, `Created_By`, `Approver`, `ApprovalRemarks`) VALUES
	(4, '2019-11-28 14:31:27', 'AP-17', '28 OF 2019', '<p>WCF stands for Windows Communication Foundation. It is a framework for building, configuring, and deploying network-distributed services. Earlier known as Indigo, it enables hosting services in any type of operating system process. This tutorial explains the fundamentals of WCF and is conveniently divided into various sections. Every section of this tutorial has adequate number of examples to explain different concepts of WCF</p>\n', NULL, 'Pending Approval', '2019-11-28', 'P0123456788X', 'CASEOFFICER01', NULL),
	(12, '2019-11-29 11:31:30', 'AP-17', '31 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', '2019-11-29', 'Declined', '2019-11-29', 'P0123456788X', 'Admin', 'Declined'),
	(13, '2019-11-29 11:31:30', 'AP-17', '31 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', '2019-11-29', 'Declined', '2019-11-29', 'P0123456788X', 'CASEOFFICER01', 'Declined'),
	(14, '2019-12-02 16:37:38', 'AP-17', '32 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae,&nbsp;</p>\n', '2019-12-02', 'Declined', '2019-12-02', 'P0123456788X', 'Admin', 'Declined'),
	(15, '2019-12-02 16:37:38', 'AP-17', '32 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae,&nbsp;</p>\n', '2019-12-02', 'Declined', '2019-12-02', 'P0123456788X', 'CASEOFFICER01', 'Declined');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicants: ~3 rows (approximately)
DELETE FROM `applicants`;
/*!40000 ALTER TABLE `applicants` DISABLE KEYS */;
INSERT INTO `applicants` (`ID`, `ApplicantCode`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`, `RegistrationDate`, `PIN`, `RegistrationNo`) VALUES
	(8, 'AP-17', 'JAMES SUPPLIERS LTD', '', '001', 'Nairobi', '00101', '00101', 'Nairobi', '0122719412', '0122719412', 'KEREBEI@HOTMAIL.COM', '', 'www.wilcom.co.ke', 'P0123456788X', '2019-11-11 15:41:19', NULL, NULL, 0, NULL, NULL, '2000-12-08 00:00:00', 'P0123456788X', 'C1887432'),
	(9, 'AP-18', 'APPLICANT LTD', '', '001', 'Nairobi', '123', '00100', 'NAIROBI', '0722114567', '0722114567', 'info@wilcom.co.ke', '1573656756638-logoLister.png', '', 'P09875345W', '2019-11-13 14:56:01', NULL, NULL, 0, NULL, NULL, '2019-10-01 00:00:00', 'P09875345W', '12345'),
	(10, 'AP-19', 'CMC MOTORS CORPORATION', '', '047', 'LUSAKA ROAD', '1234', '00101', 'NAIROBI', '0705128595', '0705128595', 'judiejuma@gmail.com', '', 'CMC.CO.KE', 'P123456879Q', '2019-11-15 10:39:06', NULL, NULL, 0, NULL, NULL, '1980-08-12 00:00:00', 'P123456879Q', 'C1234568');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicantshistory: ~3 rows (approximately)
DELETE FROM `applicantshistory`;
/*!40000 ALTER TABLE `applicantshistory` DISABLE KEYS */;
INSERT INTO `applicantshistory` (`ID`, `ApplicantCode`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`) VALUES
	(1, 'AP-17', 'JAMES SUPPLIERS LTD', '', '001', 'Nairobi', '00101', '00101', 'Nairobi', '0122719412', '0122719412', 'KEREBEI@HOTMAIL.COM', '', 'www.wilcom.co.ke', 'P0123456788X', '2019-11-11 15:41:19', NULL, NULL, NULL, NULL, NULL),
	(2, 'AP-18', 'APPLICANT LTD', '', '001', 'Nairobi', '123', '00100', 'NAIROBI', '0722114567', '0722114567', 'info@wilcom.co.ke', '1573656756638-logoLister.png', '', 'P09875345W', '2019-11-13 14:56:01', NULL, NULL, NULL, NULL, NULL),
	(3, 'AP-19', 'CMC MOTORS CORPORATION', '', '047', 'LUSAKA ROAD', '1234', '00101', 'NAIROBI', '0705128595', '0705128595', 'judiejuma@gmail.com', '', 'CMC.CO.KE', 'P123456879Q', '2019-11-15 10:39:06', NULL, NULL, NULL, NULL, NULL);
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

-- Dumping data for table arcm.applicationapprovalcontacts: ~3 rows (approximately)
DELETE FROM `applicationapprovalcontacts`;
/*!40000 ALTER TABLE `applicationapprovalcontacts` DISABLE KEYS */;
INSERT INTO `applicationapprovalcontacts` (`Name`, `Email`, `Mobile`, `Msg`, `ApplicationNo`) VALUES
	('JAMES SUPPLIERS LTD', 'KEREBEI@HOTMAIL.COM', '0122719412', 'Applicant', '32 OF 2019'),
	('MINISTRY OF EDUCATION', 'elviskimcheruiyot@gmail.com', '0705555285', 'PE', '32 OF 2019'),
	('Home', 'elviskimcheruiyot@gmail.com', '0705555285', 'Interested Party', '32 OF 2019');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationdocuments: ~20 rows (approximately)
DELETE FROM `applicationdocuments`;
/*!40000 ALTER TABLE `applicationdocuments` DISABLE KEYS */;
INSERT INTO `applicationdocuments` (`ID`, `ApplicationID`, `Description`, `FileName`, `DateUploaded`, `Path`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `Confidential`) VALUES
	(1, 1, 'Form of Tender', '1573487662790-FORM OF TENDER.docx', '2019-11-11 15:54:23', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-11 15:54:23', NULL, NULL, 0, NULL, NULL, 0),
	(2, 1, 'Price Schedule', '1573487715016-Price Schedule.pdf', '2019-11-11 15:55:15', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-11 15:55:15', NULL, NULL, 0, NULL, NULL, 1),
	(3, 5, 'Tender document', '1573546570554-rptSalesSummaryReportcs.pdf', '2019-11-12 11:16:10', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-12 11:16:10', NULL, NULL, 0, NULL, NULL, 0),
	(4, 5, 'document', '1573546697849-6 OF 2019.pdf', '2019-11-12 11:18:18', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-12 11:18:18', NULL, NULL, 0, NULL, NULL, 0),
	(5, 10, 'Tender document', '1573632895965-6 OF 2019.pdf', '2019-11-13 11:14:56', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-13 11:14:56', NULL, NULL, 0, NULL, NULL, 0),
	(6, 15, 'Form of tender', '1573665453738-6 OF 2019.pdf', '2019-11-13 17:17:34', 'http://74.208.157.60:3001/Documents', 'P09875345W', '2019-11-13 17:17:34', NULL, NULL, 0, NULL, NULL, 1),
	(7, 17, 'Form of Tender', '1573815727889-Online Store.vsdx', '2019-11-15 11:02:08', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-15 11:02:08', NULL, NULL, 0, NULL, NULL, 0),
	(8, 17, 'Tender Document', '1573815758130-DECISION 54 OF 2019 KAREN Infrastructure Vs SD Irrigation.pdf', '2019-11-15 11:02:38', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-15 11:02:38', NULL, NULL, 0, NULL, NULL, 1),
	(9, 23, 'Form of tender', '1574250051412-6 OF 2019.pdf', '2019-11-20 14:40:51', 'http://74.208.157.60:3001/Documents', 'P09875345W', '2019-11-20 14:40:51', NULL, NULL, 0, NULL, NULL, 0),
	(10, 24, 'Form of Tender', '1574345527924-Form of Tender 2.pdf', '2019-11-21 14:12:08', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:12:08', NULL, NULL, 0, NULL, NULL, 0),
	(11, 24, 'Price Schedule', '1574345552934-Price Schedule 2.pdf', '2019-11-21 14:12:33', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:12:33', NULL, NULL, 0, NULL, NULL, 0),
	(12, 25, 'Form of Tender', '1574346578674-Form of Tender 2.pdf', '2019-11-21 14:29:39', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:29:39', NULL, NULL, 0, NULL, NULL, 0),
	(13, 25, 'Price Schedule', '1574346597315-Price Schedule 2.pdf', '2019-11-21 14:29:57', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:29:57', NULL, NULL, 0, NULL, NULL, 0),
	(14, 26, 'Form of Tender', '1574353985380-Tender Security.pdf', '2019-11-21 16:33:05', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 16:33:05', NULL, NULL, 0, NULL, NULL, 0),
	(15, 26, 'Tender Document', '1574353998754-RFP- Provision of Consultancy   Services on Comprehensive ICT Needs Assessment.pdf', '2019-11-21 16:33:19', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 16:33:19', NULL, NULL, 0, NULL, NULL, 0),
	(16, 27, 'Form of Tender', '1574371086253-6 OF 2019.pdf', '2019-11-21 21:18:06', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 21:18:06', NULL, NULL, 0, NULL, NULL, 0),
	(17, 29, 'Form of Tender', '1574421482022-6 OF 2019.pdf', '2019-11-22 11:18:02', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-22 11:18:02', NULL, NULL, 0, NULL, NULL, 0),
	(18, 29, 'Form of Tender2', '1574421502230-6 OF 2019.pdf', '2019-11-22 11:18:22', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-22 11:18:22', NULL, NULL, 0, NULL, NULL, 0),
	(19, 30, 'Form of Tender', '1574422085246-6 OF 2019.pdf', '2019-11-22 11:28:05', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-22 11:28:05', NULL, NULL, 0, NULL, NULL, 0),
	(20, 36, 'Form of Tender', '1575286322171-29 OF 2019 (1).pdf', '2019-12-02 14:32:02', 'http://localhost:3001/Documents', 'P0123456788X', '2019-12-02 14:32:02', NULL, NULL, 0, NULL, NULL, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationdocumentshistory: ~20 rows (approximately)
DELETE FROM `applicationdocumentshistory`;
/*!40000 ALTER TABLE `applicationdocumentshistory` DISABLE KEYS */;
INSERT INTO `applicationdocumentshistory` (`ID`, `ApplicationID`, `DocType`, `Description`, `FileName`, `DateUploaded`, `Path`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`) VALUES
	(1, 1, NULL, 'Form of Tender', '1573487662790-FORM OF TENDER.docx', '2019-11-11 15:54:23', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-11 15:54:23', NULL, NULL, 0, NULL, NULL),
	(2, 1, NULL, 'Price Schedule', '1573487715016-Price Schedule.pdf', '2019-11-11 15:55:15', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-11 15:55:15', NULL, NULL, 0, NULL, NULL),
	(3, 5, NULL, 'Tender document', '1573546570554-rptSalesSummaryReportcs.pdf', '2019-11-12 11:16:10', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-12 11:16:10', NULL, NULL, 0, NULL, NULL),
	(4, 5, NULL, 'document', '1573546697849-6 OF 2019.pdf', '2019-11-12 11:18:18', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-12 11:18:18', NULL, NULL, 0, NULL, NULL),
	(5, 10, NULL, 'Tender document', '1573632895965-6 OF 2019.pdf', '2019-11-13 11:14:56', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-13 11:14:56', NULL, NULL, 0, NULL, NULL),
	(6, 15, NULL, 'Form of tender', '1573665453738-6 OF 2019.pdf', '2019-11-13 17:17:34', 'http://74.208.157.60:3001/Documents', 'P09875345W', '2019-11-13 17:17:34', NULL, NULL, 0, NULL, NULL),
	(7, 17, NULL, 'Form of Tender', '1573815727889-Online Store.vsdx', '2019-11-15 11:02:08', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-15 11:02:08', NULL, NULL, 0, NULL, NULL),
	(8, 17, NULL, 'Tender Document', '1573815758130-DECISION 54 OF 2019 KAREN Infrastructure Vs SD Irrigation.pdf', '2019-11-15 11:02:38', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-15 11:02:38', NULL, NULL, 0, NULL, NULL),
	(9, 23, NULL, 'Form of tender', '1574250051412-6 OF 2019.pdf', '2019-11-20 14:40:51', 'http://74.208.157.60:3001/Documents', 'P09875345W', '2019-11-20 14:40:51', NULL, NULL, 0, NULL, NULL),
	(10, 24, NULL, 'Form of Tender', '1574345527924-Form of Tender 2.pdf', '2019-11-21 14:12:08', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:12:08', NULL, NULL, 0, NULL, NULL),
	(11, 24, NULL, 'Price Schedule', '1574345552934-Price Schedule 2.pdf', '2019-11-21 14:12:33', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:12:33', NULL, NULL, 0, NULL, NULL),
	(12, 25, NULL, 'Form of Tender', '1574346578674-Form of Tender 2.pdf', '2019-11-21 14:29:39', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:29:39', NULL, NULL, 0, NULL, NULL),
	(13, 25, NULL, 'Price Schedule', '1574346597315-Price Schedule 2.pdf', '2019-11-21 14:29:57', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 14:29:57', NULL, NULL, 0, NULL, NULL),
	(14, 26, NULL, 'Form of Tender', '1574353985380-Tender Security.pdf', '2019-11-21 16:33:05', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 16:33:05', NULL, NULL, 0, NULL, NULL),
	(15, 26, NULL, 'Tender Document', '1574353998754-RFP- Provision of Consultancy   Services on Comprehensive ICT Needs Assessment.pdf', '2019-11-21 16:33:19', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 16:33:19', NULL, NULL, 0, NULL, NULL),
	(16, 27, NULL, 'Form of Tender', '1574371086253-6 OF 2019.pdf', '2019-11-21 21:18:06', 'http://74.208.157.60:3001/Documents', 'P0123456788X', '2019-11-21 21:18:06', NULL, NULL, 0, NULL, NULL),
	(17, 29, NULL, 'Form of Tender', '1574421482022-6 OF 2019.pdf', '2019-11-22 11:18:02', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-22 11:18:02', NULL, NULL, 0, NULL, NULL),
	(18, 29, NULL, 'Form of Tender2', '1574421502230-6 OF 2019.pdf', '2019-11-22 11:18:22', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-22 11:18:22', NULL, NULL, 0, NULL, NULL),
	(19, 30, NULL, 'Form of Tender', '1574422085246-6 OF 2019.pdf', '2019-11-22 11:28:05', 'http://74.208.157.60:3001/Documents', 'P123456879Q', '2019-11-22 11:28:05', NULL, NULL, 0, NULL, NULL),
	(20, 36, NULL, 'Form of Tender', '1575286322171-29 OF 2019 (1).pdf', '2019-12-02 14:32:02', 'http://localhost:3001/Documents', 'P0123456788X', '2019-12-02 14:32:02', NULL, NULL, 0, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationfees: ~96 rows (approximately)
DELETE FROM `applicationfees`;
/*!40000 ALTER TABLE `applicationfees` DISABLE KEYS */;
INSERT INTO `applicationfees` (`ID`, `ApplicationID`, `EntryType`, `AmountDue`, `RefNo`, `BillDate`, `AmountPaid`, `PaidDate`, `PaymentRef`, `PaymentMode`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `CalculatedAmount`, `FeesStatus`, `ApprovedBy`, `DateApproved`, `Narration`) VALUES
	(1, 1, 14, 5000, '1', '2019-11-11 15:47:45', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-11 15:47:45', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'CASEOFFICER01', '2019-11-11 16:15:44', '12334444'),
	(2, 1, 1, 20000, '1', '2019-11-11 15:47:45', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-11 15:47:45', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'CASEOFFICER01', '2019-11-11 16:15:44', '12334444'),
	(3, 1, 2, 3800, '1', '2019-11-11 15:47:45', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-11 15:47:45', NULL, NULL, 0, NULL, NULL, 3800, 'Approved', 'CASEOFFICER01', '2019-11-11 16:15:44', '12334444'),
	(4, 5, 14, 5000, '5', '2019-11-12 10:58:39', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-12 10:58:39', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'PPRA01', '2019-11-12 11:42:38', '12344545'),
	(5, 5, 4, 10000, '5', '2019-11-12 10:58:39', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-12 10:58:39', NULL, NULL, 0, NULL, NULL, 10000, 'Approved', 'PPRA01', '2019-11-12 11:42:38', '12344545'),
	(6, 6, 14, 5000, '6', '2019-11-12 15:45:26', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-12 15:45:26', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'PPRA01', '2019-11-12 15:55:25', '12344545'),
	(7, 6, 1, 20000, '6', '2019-11-12 15:45:26', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-12 15:45:26', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'PPRA01', '2019-11-12 15:55:25', '12344545'),
	(8, 6, 2, 500, '6', '2019-11-12 15:45:26', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-12 15:45:26', NULL, NULL, 0, NULL, NULL, 500, 'Approved', 'PPRA01', '2019-11-12 15:55:25', '12344545'),
	(9, 7, 14, 5000, '7', '2019-11-12 16:42:15', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-12 16:42:15', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-12 17:00:55', '12344545'),
	(10, 7, 6, 40000, '7', '2019-11-12 16:42:15', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-12 16:42:15', NULL, NULL, 0, NULL, NULL, 40000, 'Approved', 'Admin', '2019-11-12 17:00:55', '12344545'),
	(11, 9, 14, 5000, '8', '2019-11-13 11:11:36', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-13 11:11:36', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(12, 9, 8, 20000, '8', '2019-11-13 11:11:36', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-13 11:11:36', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(13, 10, 14, 5000, '8', '2019-11-13 11:14:12', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-13 11:14:12', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-13 11:32:12', '12344545'),
	(14, 10, 8, 20000, '8', '2019-11-13 11:14:12', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-13 11:14:12', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'Admin', '2019-11-13 11:32:12', '12344545'),
	(15, 11, 14, 5000, '11', '2019-11-13 17:04:41', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:04:41', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(16, 11, 1, 12000, '11', '2019-11-13 17:04:41', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:04:41', NULL, NULL, 0, NULL, NULL, 12000, 'Pending Approval', NULL, NULL, NULL),
	(17, 12, 14, 5000, '12', '2019-11-13 17:05:23', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:05:23', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(18, 12, 1, 20000, '12', '2019-11-13 17:05:23', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:05:23', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(19, 12, 2, 40000, '12', '2019-11-13 17:05:23', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:05:23', NULL, NULL, 0, NULL, NULL, 40000, 'Pending Approval', NULL, NULL, NULL),
	(20, 13, 14, 5000, '13', '2019-11-13 17:05:55', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:05:55', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(21, 13, 1, 20000, '13', '2019-11-13 17:05:55', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:05:55', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(22, 13, 2, 48000, '13', '2019-11-13 17:05:55', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:05:55', NULL, NULL, 0, NULL, NULL, 48000, 'Pending Approval', NULL, NULL, NULL),
	(23, 13, 3, 13000, '13', '2019-11-13 17:05:55', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:05:55', NULL, NULL, 0, NULL, NULL, 13000, 'Pending Approval', NULL, NULL, NULL),
	(24, 14, 14, 5000, '14', '2019-11-13 17:07:40', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:07:40', NULL, NULL, 1, '2019-11-13 17:07:40', 'P09875345W', 5000, 'Approved', 'Admin', '2019-11-13 17:49:50', 'Reff123'),
	(25, 14, 14, 5000, '14', '2019-11-13 17:07:40', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:07:40', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-13 17:49:50', 'Reff123'),
	(26, 15, 14, 5000, '15', '2019-11-13 17:08:01', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:08:01', NULL, NULL, 1, '2019-11-13 17:08:01', 'P09875345W', 5000, 'Approved', 'Admin', '2019-11-13 17:31:36', 'Reff123'),
	(27, 15, 14, 5000, '15', '2019-11-13 17:08:01', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-13 17:08:01', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-13 17:31:36', 'Reff123'),
	(28, 16, 14, 5000, '16', '2019-11-14 14:45:02', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-14 14:45:02', NULL, NULL, 1, '2019-11-21 11:55:53', 'P0123456788X', 5000, 'Approved', 'Admin', '2019-11-14 14:48:40', 'Reff123'),
	(29, 16, 10, 20000, '16', '2019-11-14 14:45:02', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-14 14:45:02', NULL, NULL, 1, '2019-11-21 11:55:53', 'P0123456788X', 20000, 'Approved', 'Admin', '2019-11-14 14:48:40', 'Reff123'),
	(30, 17, 14, 5000, '17', '2019-11-15 10:55:18', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-15 10:55:18', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Pokumu', '2019-11-15 11:17:24', 'ARB0001/19'),
	(31, 17, 1, 20000, '17', '2019-11-15 10:55:18', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-15 10:55:18', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'Pokumu', '2019-11-15 11:17:24', 'ARB0001/19'),
	(32, 17, 2, 48000, '17', '2019-11-15 10:55:18', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-15 10:55:18', NULL, NULL, 0, NULL, NULL, 48000, 'Approved', 'Pokumu', '2019-11-15 11:17:24', 'ARB0001/19'),
	(33, 17, 3, 237500, '17', '2019-11-15 10:55:18', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-15 10:55:18', NULL, NULL, 0, NULL, NULL, 237500, 'Approved', 'Pokumu', '2019-11-15 11:17:24', 'ARB0001/19'),
	(34, 18, 14, 5000, '18', '2019-11-15 11:49:58', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-15 11:49:58', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-15 11:51:56', 'Reff123'),
	(35, 18, 1, 10000, '18', '2019-11-15 11:49:58', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-15 11:49:58', NULL, NULL, 0, NULL, NULL, 10000, 'Approved', 'Admin', '2019-11-15 11:51:56', 'Reff123'),
	(36, 19, 14, 5000, '19', '2019-11-20 10:47:42', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:47:42', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(37, 19, 1, 20000, '19', '2019-11-20 10:47:42', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:47:42', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(38, 19, 2, 48000, '19', '2019-11-20 10:47:42', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:47:42', NULL, NULL, 0, NULL, NULL, 48000, 'Pending Approval', NULL, NULL, NULL),
	(39, 19, 3, 142000, '19', '2019-11-20 10:47:42', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:47:42', NULL, NULL, 0, NULL, NULL, 142000, 'Pending Approval', NULL, NULL, NULL),
	(40, 20, 14, 5000, '20', '2019-11-20 10:51:53', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:51:53', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(41, 20, 1, 20000, '20', '2019-11-20 10:51:53', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:51:53', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(42, 20, 2, 48000, '20', '2019-11-20 10:51:53', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:51:53', NULL, NULL, 0, NULL, NULL, 48000, 'Pending Approval', NULL, NULL, NULL),
	(43, 20, 3, 132000, '20', '2019-11-20 10:51:54', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:51:54', NULL, NULL, 0, NULL, NULL, 132000, 'Pending Approval', NULL, NULL, NULL),
	(44, 21, 14, 5000, '21', '2019-11-20 10:52:30', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:52:30', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(45, 21, 1, 20000, '21', '2019-11-20 10:52:30', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:52:30', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(46, 22, 14, 5000, '22', '2019-11-20 10:52:50', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:52:50', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(47, 22, 1, 10000, '22', '2019-11-20 10:52:50', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:52:50', NULL, NULL, 0, NULL, NULL, 10000, 'Pending Approval', NULL, NULL, NULL),
	(48, 23, 14, 5000, '23', '2019-11-20 10:53:17', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:53:17', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-20 14:53:33', 'Reff123'),
	(49, 23, 1, 20000, '23', '2019-11-20 10:53:17', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:53:17', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'Admin', '2019-11-20 14:53:33', 'Reff123'),
	(50, 23, 2, 48000, '23', '2019-11-20 10:53:17', 0, NULL, NULL, NULL, 'P09875345W', '2019-11-20 10:53:17', NULL, NULL, 0, NULL, NULL, 48000, 'Approved', 'Admin', '2019-11-20 14:53:33', 'Reff123'),
	(51, 16, 14, 5000, '16', '2019-11-21 11:53:24', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 11:53:24', NULL, NULL, 1, '2019-11-21 11:55:53', 'P0123456788X', 5000, 'Pending Approval', NULL, NULL, NULL),
	(52, 16, 9, 10000, '16', '2019-11-21 11:53:24', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 11:53:24', NULL, NULL, 1, '2019-11-21 11:55:53', 'P0123456788X', 10000, 'Pending Approval', NULL, NULL, NULL),
	(53, 16, 14, 5000, '16', '2019-11-21 11:55:29', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 11:55:29', NULL, NULL, 1, '2019-11-21 11:55:53', 'P0123456788X', 5000, 'Pending Approval', NULL, NULL, NULL),
	(54, 16, 5, 20000, '16', '2019-11-21 11:55:29', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 11:55:29', NULL, NULL, 1, '2019-11-21 11:55:53', 'P0123456788X', 20000, 'Pending Approval', NULL, NULL, NULL),
	(55, 16, 14, 5000, '16', '2019-11-21 11:55:53', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 11:55:53', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(56, 16, 9, 10000, '16', '2019-11-21 11:55:53', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 11:55:53', NULL, NULL, 0, NULL, NULL, 10000, 'Pending Approval', NULL, NULL, NULL),
	(57, 24, 14, 5000, '24', '2019-11-21 14:09:34', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 14:09:34', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(58, 24, 1, 10000, '24', '2019-11-21 14:09:34', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 14:09:34', NULL, NULL, 0, NULL, NULL, 10000, 'Pending Approval', NULL, NULL, NULL),
	(59, 25, 14, 5000, '25', '2019-11-21 14:27:18', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 14:27:18', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'admin', '2019-11-21 14:35:14', 'Confirmed REF 0001'),
	(60, 25, 1, 10000, '25', '2019-11-21 14:27:18', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 14:27:18', NULL, NULL, 0, NULL, NULL, 10000, 'Approved', 'admin', '2019-11-21 14:35:14', 'Confirmed REF 0001'),
	(61, 26, 14, 5000, '26', '2019-11-21 16:27:26', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 16:27:26', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'admin', '2019-11-21 16:55:24', '1574354278238-PAYMENT SLIP.pdf'),
	(62, 26, 1, 20000, '26', '2019-11-21 16:27:26', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 16:27:26', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'admin', '2019-11-21 16:55:24', '1574354278238-PAYMENT SLIP.pdf'),
	(63, 26, 2, 48000, '26', '2019-11-21 16:27:26', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 16:27:26', NULL, NULL, 0, NULL, NULL, 48000, 'Approved', 'admin', '2019-11-21 16:55:24', '1574354278238-PAYMENT SLIP.pdf'),
	(64, 26, 3, 132000, '26', '2019-11-21 16:27:26', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 16:27:26', NULL, NULL, 0, NULL, NULL, 132000, 'Approved', 'admin', '2019-11-21 16:55:24', '1574354278238-PAYMENT SLIP.pdf'),
	(65, 27, 14, 5000, '27', '2019-11-21 21:14:47', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 21:14:47', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-21 21:25:10', 'REF123'),
	(66, 27, 10, 20000, '27', '2019-11-21 21:14:47', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 21:14:47', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'Admin', '2019-11-21 21:25:10', 'REF123'),
	(67, 28, 14, 5000, '28', '2019-11-21 21:39:45', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 21:39:45', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-21 21:43:39', 'REF123'),
	(68, 28, 1, 10000, '28', '2019-11-21 21:39:45', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-21 21:39:45', NULL, NULL, 0, NULL, NULL, 10000, 'Approved', 'Admin', '2019-11-21 21:43:39', 'REF123'),
	(69, 29, 14, 5000, '29', '2019-11-22 11:16:50', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:16:50', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(70, 29, 1, 20000, '29', '2019-11-22 11:16:50', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:16:50', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(71, 29, 2, 48000, '29', '2019-11-22 11:16:50', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:16:50', NULL, NULL, 0, NULL, NULL, 48000, 'Pending Approval', NULL, NULL, NULL),
	(72, 29, 3, 112500, '29', '2019-11-22 11:16:50', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:16:50', NULL, NULL, 0, NULL, NULL, 112500, 'Pending Approval', NULL, NULL, NULL),
	(73, 30, 14, 5000, '30', '2019-11-22 11:26:41', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:26:41', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 5000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(74, 30, 1, 20000, '30', '2019-11-22 11:26:41', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:26:41', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 20000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(75, 30, 2, 48000, '30', '2019-11-22 11:26:41', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:26:41', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 48000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(76, 30, 3, 112500, '30', '2019-11-22 11:26:41', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:26:41', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 112500, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(77, 30, 14, 5000, '30', '2019-11-22 11:31:01', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:31:01', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 5000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(78, 30, 1, 20000, '30', '2019-11-22 11:31:01', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:31:01', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 20000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(79, 30, 2, 120000, '30', '2019-11-22 11:31:01', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:31:01', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 120000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(80, 30, 3, 112500, '30', '2019-11-22 11:31:01', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:31:01', NULL, NULL, 1, '2019-11-22 11:32:56', 'P123456879Q', 112500, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(81, 30, 14, 5000, '30', '2019-11-22 11:32:56', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:32:56', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(82, 30, 1, 20000, '30', '2019-11-22 11:32:56', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:32:56', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(83, 30, 2, 120000, '30', '2019-11-22 11:32:56', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:32:56', NULL, NULL, 0, NULL, NULL, 120000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(84, 30, 3, 60000, '30', '2019-11-22 11:32:56', 0, NULL, NULL, NULL, 'P123456879Q', '2019-11-22 11:32:56', NULL, NULL, 0, NULL, NULL, 60000, 'Approved', 'Admin', '2019-11-22 11:40:43', 'REF00001'),
	(85, 31, 14, 5000, '31', '2019-11-26 14:35:28', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-26 14:35:28', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(86, 31, 1, 20000, '31', '2019-11-26 14:35:28', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-26 14:35:28', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(87, 31, 2, 120000, '31', '2019-11-26 14:35:28', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-26 14:35:28', NULL, NULL, 0, NULL, NULL, 120000, 'Pending Approval', NULL, NULL, NULL),
	(88, 32, 14, 5000, '32', '2019-11-26 15:21:11', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-26 15:21:11', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(89, 32, 1, 20000, '32', '2019-11-26 15:21:12', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-26 15:21:12', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(90, 33, 14, 5000, '33', '2019-11-28 15:34:36', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:34:36', NULL, NULL, 1, '2019-11-28 15:42:07', 'P0123456788X', 5000, 'Pending Approval', NULL, NULL, NULL),
	(91, 33, 1, 20000, '33', '2019-11-28 15:34:36', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:34:36', NULL, NULL, 1, '2019-11-28 15:42:07', 'P0123456788X', 20000, 'Pending Approval', NULL, NULL, NULL),
	(92, 33, 2, 120000, '33', '2019-11-28 15:34:36', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:34:36', NULL, NULL, 1, '2019-11-28 15:42:08', 'P0123456788X', 120000, 'Pending Approval', NULL, NULL, NULL),
	(93, 33, 14, 5000, '33', '2019-11-28 15:42:07', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:42:07', NULL, NULL, 0, NULL, NULL, 5000, 'Pending Approval', NULL, NULL, NULL),
	(94, 33, 1, 20000, '33', '2019-11-28 15:42:07', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:42:07', NULL, NULL, 0, NULL, NULL, 20000, 'Pending Approval', NULL, NULL, NULL),
	(95, 33, 2, 45000, '33', '2019-11-28 15:42:08', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:42:08', NULL, NULL, 0, NULL, NULL, 45000, 'Pending Approval', NULL, NULL, NULL),
	(96, 34, 14, 5000, '34', '2019-11-28 15:47:17', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:47:17', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-28 16:01:06', 'REF123'),
	(97, 34, 1, 20000, '34', '2019-11-28 15:47:17', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:47:17', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'Admin', '2019-11-28 16:01:06', 'REF123'),
	(98, 34, 2, 7500, '34', '2019-11-28 15:47:18', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-28 15:47:18', NULL, NULL, 0, NULL, NULL, 7500, 'Approved', 'Admin', '2019-11-28 16:01:06', 'REF123'),
	(99, 35, 14, 5000, '35', '2019-11-29 09:16:32', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-29 09:16:32', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-11-29 09:28:19', 'REF00001'),
	(100, 35, 1, 20000, '35', '2019-11-29 09:16:32', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-29 09:16:32', NULL, NULL, 0, NULL, NULL, 20000, 'Approved', 'Admin', '2019-11-29 09:28:19', 'REF00001'),
	(101, 35, 2, 1250, '35', '2019-11-29 09:16:32', 0, NULL, NULL, NULL, 'P0123456788X', '2019-11-29 09:16:32', NULL, NULL, 0, NULL, NULL, 1250, 'Approved', 'Admin', '2019-11-29 09:28:19', 'REF00001'),
	(102, 36, 14, 5000, '36', '2019-12-02 14:31:22', 0, NULL, NULL, NULL, 'P0123456788X', '2019-12-02 14:31:22', NULL, NULL, 0, NULL, NULL, 5000, 'Approved', 'Admin', '2019-12-02 14:52:10', 'REF00001'),
	(103, 36, 1, 12000, '36', '2019-12-02 14:31:22', 0, NULL, NULL, NULL, 'P0123456788X', '2019-12-02 14:31:22', NULL, NULL, 0, NULL, NULL, 12000, 'Approved', 'Admin', '2019-12-02 14:52:10', 'REF00001');
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applications: ~31 rows (approximately)
DELETE FROM `applications`;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` (`ID`, `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `ClosingDate`, `PaymentStatus`, `DecisionDate`, `Followup`, `Referral`, `WithdrawalDate`, `FileNumber`, `Closed`, `ApplicationSuccessful`, `Annulled`, `GiveDirection`, `ISTerminated`, `ReTender`, `CostsApplicant`, `CostsPE`, `CostsEachParty`, `Substitution`, `HearingNoticeGenerated`) VALUES
	(1, 12, 8, 'PE-2', '2019-11-11 15:47:45', '1', '12 OF 2019', 'Closed', 'P0123456788X', '2019-11-11 15:47:45', NULL, NULL, 0, NULL, NULL, '2019-12-02', 'Approved', '1970-01-01', 0, 0, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Yes'),
	(5, 16, 8, 'PE-3', '2019-11-12 10:58:39', '5', '13 OF 2019', 'Approved', 'P0123456788X', '2019-11-12 10:58:39', NULL, NULL, 0, NULL, NULL, '2019-12-03', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(6, 17, 8, 'PE-3', '2019-11-12 15:45:26', '6', '14 OF 2019', 'WITHDRAWN', 'P0123456788X', '2019-11-12 15:45:26', NULL, NULL, 0, NULL, NULL, '2019-12-03', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(7, 18, 8, 'PE-2', '2019-11-12 16:42:14', '7', '15 OF 2019', 'Submited', 'P0123456788X', '2019-11-12 16:42:14', NULL, NULL, 0, NULL, NULL, '2019-12-03', 'Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(10, 21, 8, 'PE-3', '2019-11-13 11:14:12', '8', '16 OF 2019', 'Closed', 'P0123456788X', '2019-11-13 11:14:12', NULL, NULL, 0, NULL, NULL, '2019-12-04', 'Approved', '1970-01-01', 0, 0, NULL, NULL, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 'No'),
	(11, 22, 9, 'PE-2', '2019-11-13 17:04:41', '11', '11', 'Not Submited', 'P09875345W', '2019-11-13 17:04:41', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(12, 23, 9, 'PE-2', '2019-11-13 17:05:23', '12', '12', 'Not Submited', 'P09875345W', '2019-11-13 17:05:23', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(13, 24, 9, 'PE-2', '2019-11-13 17:05:55', '13', '13', 'Not Submited', 'P09875345W', '2019-11-13 17:05:55', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(14, 25, 9, 'PE-2', '2019-11-13 17:07:40', '14', '14', 'DECLINED', 'P09875345W', '2019-11-13 17:07:40', NULL, NULL, 0, NULL, NULL, NULL, 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(15, 26, 9, 'PE-2', '2019-11-13 17:08:01', '15', '17 OF 2019', 'Closed', 'P09875345W', '2019-11-13 17:08:01', NULL, NULL, 0, NULL, NULL, '2019-12-04', 'Approved', '1970-01-01', 0, 0, NULL, NULL, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 'No'),
	(16, 27, 8, 'PE-3', '2019-11-14 14:45:01', '16', '21 OF 2019', 'Approved', 'P0123456788X', '2019-11-14 14:45:01', '2019-11-21 11:55:53', 'P0123456788X', 0, NULL, NULL, '2019-12-12', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(17, 28, 10, 'PE-4', '2019-11-15 10:55:17', '17', '18 OF 2019', 'Closed', 'P123456879Q', '2019-11-15 10:55:17', NULL, NULL, 0, NULL, NULL, '2019-12-06', 'Approved', '1970-01-01', 0, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(18, 29, 8, 'PE-2', '2019-11-15 11:49:58', '18', '19 OF 2019', 'Closed', 'P0123456788X', '2019-11-15 11:49:58', NULL, NULL, 0, NULL, NULL, '2019-12-08', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(19, 30, 9, 'PE-2', '2019-11-20 10:47:42', '19', '19', 'Not Submited', 'P09875345W', '2019-11-20 10:47:42', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(20, 31, 9, 'PE-2', '2019-11-20 10:51:53', '20', '20', 'Not Submited', 'P09875345W', '2019-11-20 10:51:53', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(21, 32, 9, 'PE-2', '2019-11-20 10:52:29', '21', '21', 'Not Submited', 'P09875345W', '2019-11-20 10:52:29', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(22, 33, 9, 'PE-2', '2019-11-20 10:52:50', '22', '22', 'Not Submited', 'P09875345W', '2019-11-20 10:52:50', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(23, 34, 9, 'PE-2', '2019-11-20 10:53:17', '23', '20 OF 2019', 'Closed', 'P09875345W', '2019-11-20 10:53:17', NULL, NULL, 0, NULL, NULL, '2019-12-11', 'Approved', '2019-11-20', 0, 1, NULL, NULL, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 'Yes'),
	(24, 35, 8, 'PE-1', '2019-11-21 14:09:33', '24', '24', 'Submited', 'P0123456788X', '2019-11-21 14:09:33', NULL, NULL, 0, NULL, NULL, NULL, 'Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(25, 36, 8, 'PE-2', '2019-11-21 14:27:18', '25', '22 OF 2019', 'Approved', 'P0123456788X', '2019-11-21 14:27:18', NULL, NULL, 0, NULL, NULL, '2019-12-12', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(26, 37, 8, 'PE-2', '2019-11-21 16:27:25', '26', '23 OF 2019', 'Closed', 'P0123456788X', '2019-11-21 16:27:25', NULL, NULL, 0, NULL, NULL, '2019-12-12', 'Approved', '2019-11-21', 1, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 'Yes'),
	(27, 38, 8, 'PE-2', '2019-11-21 21:14:46', '27', '27 OF 2019', 'Approved', 'P0123456788X', '2019-11-21 21:14:46', NULL, NULL, 0, NULL, NULL, '2019-12-12', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(28, 39, 8, 'PE-2', '2019-11-21 21:39:44', '28', '28 OF 2019', 'ADJOURNED', 'P0123456788X', '2019-11-21 21:39:44', NULL, NULL, 0, NULL, NULL, '2019-12-12', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(29, 40, 10, 'PE-4', '2019-11-22 11:16:50', '29', '29', 'Submited', 'P123456879Q', '2019-11-22 11:16:50', NULL, NULL, 0, NULL, NULL, NULL, 'Not Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(30, 41, 10, 'PE-4', '2019-11-22 11:26:40', '30', '29 OF 2019', 'Closed', 'P123456879Q', '2019-11-22 11:26:40', '2019-11-22 11:32:56', 'P123456879Q', 0, NULL, NULL, '2019-12-13', 'Approved', '2019-11-22', 0, 0, NULL, NULL, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 'Yes'),
	(31, 42, 8, 'PE-2', '2019-11-26 14:35:28', '31', '31', 'Submited', 'P0123456788X', '2019-11-26 14:35:28', NULL, NULL, 0, NULL, NULL, NULL, 'Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(32, 43, 8, 'PE-1', '2019-11-26 15:21:11', '32', '32', 'Submited', 'P0123456788X', '2019-11-26 15:21:11', NULL, NULL, 0, NULL, NULL, NULL, 'Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(33, 44, 8, 'PE-1', '2019-11-28 15:34:35', '33', '33', 'Submited', 'P0123456788X', '2019-11-28 15:34:35', '2019-11-28 15:42:07', 'P0123456788X', 0, NULL, NULL, NULL, 'Submited', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(34, 45, 8, 'PE-1', '2019-11-28 15:47:17', '34', '30 OF 2019', 'WITHDRAWN', 'P0123456788X', '2019-11-28 15:47:17', NULL, NULL, 0, NULL, NULL, '2019-12-19', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No'),
	(35, 46, 8, 'PE-2', '2019-11-29 09:16:32', '35', '31 OF 2019', 'WITHDRAWN', 'P0123456788X', '2019-11-29 09:16:32', NULL, NULL, 0, NULL, NULL, '2019-12-20', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes'),
	(36, 47, 8, 'PE-2', '2019-12-02 14:31:22', '36', '32 OF 2019', 'WITHDRAWN', 'P0123456788X', '2019-12-02 14:31:22', NULL, NULL, 0, NULL, NULL, '2019-12-23', 'Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes');
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
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applicationsequence: ~183 rows (approximately)
DELETE FROM `applicationsequence`;
/*!40000 ALTER TABLE `applicationsequence` DISABLE KEYS */;
INSERT INTO `applicationsequence` (`ID`, `ApplicationNo`, `Date`, `Action`, `Status`, `ExpectedAction`, `User`) VALUES
	(21, '16 OF 2019', '2019-11-13 00:00:00', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(22, '16 OF 2019', '2019-11-13 00:00:00', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(23, '16 OF 2019', '2019-11-13 00:00:00', 'Application Fees Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(24, '16 OF 2019', '2019-11-13 00:00:00', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(25, '16 OF 2019', '2019-11-13 00:00:00', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Pleriminary Fees Confirmation', 'A123456789U'),
	(26, '16 OF 2019', '2019-11-13 00:00:00', 'Pleriminary Fees Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(27, '11', '2019-11-13 17:04:41', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(28, '12', '2019-11-13 17:05:23', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(29, '13', '2019-11-13 17:05:55', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(30, '14', '2019-11-13 17:07:40', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(31, '17 OF 2019', '2019-11-13 17:08:01', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(32, '17 OF 2019', '2019-11-13 17:19:00', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P09875345W'),
	(33, '17 OF 2019', '2019-11-13 17:31:36', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(34, '17 OF 2019', '2019-11-13 17:40:43', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(35, '14', '2019-11-13 17:49:22', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P09875345W'),
	(36, '14', '2019-11-13 17:49:51', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(37, '17 OF 2019', '2019-11-13 18:34:06', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Pleriminary Fees Confirmation', 'A123456789X'),
	(38, '17 OF 2019', '2019-11-13 18:38:25', 'Preliminary Objection Fees Payment Confirmed', 'Done', 'Awaiting Panel Formation', 'Admin'),
	(39, '15 OF 2019', '2019-11-14 07:37:50', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'A123456789X'),
	(40, '21 OF 2019', '2019-11-14 14:45:01', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(41, '21 OF 2019', '2019-11-14 14:45:57', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(42, '21 OF 2019', '2019-11-14 14:48:40', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(43, '21 OF 2019', '2019-11-14 15:17:28', 'Resubmited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(44, '17 OF 2019', '2019-11-14 15:52:11', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(45, '17 OF 2019', '2019-11-14 16:07:38', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'PPRA01'),
	(46, '16 OF 2019', '2019-11-14 16:14:13', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'PPRA01'),
	(47, '16 OF 2019', '2019-11-14 16:18:53', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(48, '17 OF 2019', '2019-11-14 16:33:49', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(49, '17 OF 2019', '2019-11-14 16:34:34', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(50, '17 OF 2019', '2019-11-14 16:40:38', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(51, '18 OF 2019', '2019-11-15 10:55:17', 'Created New Application', 'Done', 'Not Submited Application', 'P123456879Q'),
	(52, '18 OF 2019', '2019-11-15 11:10:01', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P123456879Q'),
	(53, '18 OF 2019', '2019-11-15 11:17:24', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Pokumu'),
	(54, '18 OF 2019', '2019-11-15 11:36:02', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(55, '19 OF 2019', '2019-11-15 11:49:58', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(56, '19 OF 2019', '2019-11-15 11:50:57', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(57, '19 OF 2019', '2019-11-15 11:51:56', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(58, '18 OF 2019', '2019-11-15 12:06:43', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'P65498745R'),
	(59, '18 OF 2019', '2019-11-15 12:22:42', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(60, '18 OF 2019', '2019-11-15 12:28:47', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(61, '18 OF 2019', '2019-11-15 12:34:32', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(62, '18 OF 2019', '2019-11-15 12:34:58', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(63, '18 OF 2019', '2019-11-15 13:05:22', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(64, '18 OF 2019', '2019-11-15 13:50:02', 'Decision preparation', 'Done', 'Closed', 'Admin'),
	(65, '12 OF 2019', '2019-11-16 14:03:39', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'A123456789X'),
	(66, '17 OF 2019', '2019-11-16 17:39:20', 'Decision preparation', 'Done', 'Closed', 'Admin'),
	(67, '16 OF 2019', '2019-11-17 12:11:41', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(68, '16 OF 2019', '2019-11-17 12:11:48', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(69, '19 OF 2019', '2019-11-17 12:17:53', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(70, '17 OF 2019', '2019-11-18 13:45:32', 'Decision Report', 'Done', 'Awaiting Decision Report Approval', 'Admin'),
	(71, '16 OF 2019', '2019-11-19 13:25:01', 'Uploded case Analysis Report', 'Done', 'Awaiting Hearing', 'Admin'),
	(72, '19 OF 2019', '2019-11-19 15:11:17', 'Judicial Review', 'Done', 'Judicial Review', 'Admin'),
	(73, '19 OF 2019', '2019-11-20 10:29:39', 'Judicial Review Closed', 'Done', 'Judicial Review Closed', 'Admin'),
	(74, '19', '2019-11-20 10:47:42', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(75, '20', '2019-11-20 10:51:53', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(76, '21', '2019-11-20 10:52:29', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(77, '22', '2019-11-20 10:52:50', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(78, '20 OF 2019', '2019-11-20 10:53:17', 'Created New Application', 'Done', 'Not Submited Application', 'P09875345W'),
	(79, '12 OF 2019', '2019-11-20 11:00:00', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(80, '16 OF 2019', '2019-11-20 12:15:04', 'Decision preparation', 'Done', 'Closed', 'Admin'),
	(81, '16 OF 2019', '2019-11-20 12:20:27', 'Decision Report', 'Done', 'Awaiting Decision Report Approval', 'Admin'),
	(82, '12 OF 2019', '2019-11-20 12:24:53', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(83, '12 OF 2019', '2019-11-20 12:53:36', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(84, '12 OF 2019', '2019-11-20 13:49:14', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(85, '20 OF 2019', '2019-11-20 14:41:24', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P09875345W'),
	(86, '20 OF 2019', '2019-11-20 14:53:33', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(87, '20 OF 2019', '2019-11-20 14:59:58', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(88, '20 OF 2019', '2019-11-20 15:24:01', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Pleriminary Fees Confirmation', 'A123456789X'),
	(89, '20 OF 2019', '2019-11-20 15:32:26', 'Preliminary Objection Fees Payment Confirmed', 'Done', 'Awaiting Panel Formation', 'Admin'),
	(90, '20 OF 2019', '2019-11-20 15:43:23', 'Uploded case Analysis Report', 'Done', 'Awaiting Hearing', 'Admin'),
	(91, '20 OF 2019', '2019-11-20 15:50:16', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(92, '20 OF 2019', '2019-11-20 15:50:21', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(93, '20 OF 2019', '2019-11-20 15:52:01', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(94, '20 OF 2019', '2019-11-20 15:53:03', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(95, '20 OF 2019', '2019-11-20 16:22:07', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(96, '20 OF 2019', '2019-11-20 16:31:42', 'Decision preparation', 'Done', 'Closed', 'Admin'),
	(97, '24', '2019-11-21 14:09:33', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(98, '24', '2019-11-21 14:13:12', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(99, '21 OF 2019', '2019-11-21 14:19:16', 'Application Approved', 'Done', 'Awaiting PE Response', 'admin'),
	(100, '22 OF 2019', '2019-11-21 14:27:18', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(101, '22 OF 2019', '2019-11-21 14:31:58', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(102, '22 OF 2019', '2019-11-21 14:35:14', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'admin'),
	(103, '22 OF 2019', '2019-11-21 14:36:22', 'Application Approved', 'Done', 'Awaiting PE Response', 'admin'),
	(104, '23 OF 2019', '2019-11-21 16:27:25', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(105, '23 OF 2019', '2019-11-21 16:46:17', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(106, '23 OF 2019', '2019-11-21 16:55:24', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'admin'),
	(107, '23 OF 2019', '2019-11-21 17:00:59', 'Application Approved', 'Done', 'Awaiting PE Response', 'admin'),
	(108, '23 OF 2019', '2019-11-21 17:36:16', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'A123456789X'),
	(109, '23 OF 2019', '2019-11-21 18:11:50', 'Uploded case Analysis Report', 'Done', 'Awaiting Hearing', 'Admin'),
	(110, '23 OF 2019', '2019-11-21 18:24:40', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(111, '23 OF 2019', '2019-11-21 18:26:19', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(112, '23 OF 2019', '2019-11-21 18:28:52', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(113, '23 OF 2019', '2019-11-21 18:30:47', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(114, '23 OF 2019', '2019-11-21 18:38:20', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(115, '23 OF 2019', '2019-11-21 18:41:15', 'Decision preparation', 'Done', 'Closed', 'Admin'),
	(116, '23 OF 2019', '2019-11-21 18:52:19', 'Decision Report', 'Done', 'Awaiting Decision Report Approval', 'Admin'),
	(117, '23 OF 2019', '2019-11-21 18:56:34', 'Judicial Review', 'Done', 'Judicial Review', 'Admin'),
	(118, '23 OF 2019', '2019-11-21 19:00:43', 'Judicial Review Closed', 'Done', 'Judicial Review Closed', 'Admin'),
	(119, '27 OF 2019', '2019-11-21 21:14:46', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(120, '27 OF 2019', '2019-11-21 21:21:42', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(121, '27 OF 2019', '2019-11-21 21:25:10', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(122, '27 OF 2019', '2019-11-21 21:26:16', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(123, '28 OF 2019', '2019-11-21 21:39:44', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(124, '28 OF 2019', '2019-11-21 21:40:58', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(125, '28 OF 2019', '2019-11-21 21:43:39', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(126, '28 OF 2019', '2019-11-21 21:44:12', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(127, '27 OF 2019', '2019-11-21 21:53:41', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'A123456789X'),
	(128, '28 OF 2019', '2019-11-21 21:59:09', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(129, '28 OF 2019', '2019-11-21 21:59:27', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(130, '29', '2019-11-22 11:16:50', 'Created New Application', 'Done', 'Not Submited Application', 'P123456879Q'),
	(131, '29', '2019-11-22 11:25:11', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P123456879Q'),
	(132, '29 OF 2019', '2019-11-22 11:26:40', 'Created New Application', 'Done', 'Not Submited Application', 'P123456879Q'),
	(133, '29 OF 2019', '2019-11-22 11:35:32', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P123456879Q'),
	(134, '29 OF 2019', '2019-11-22 11:40:44', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(135, '29 OF 2019', '2019-11-22 11:47:04', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(136, '29 OF 2019', '2019-11-22 12:27:02', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'P65498745R'),
	(137, '29 OF 2019', '2019-11-22 12:36:04', 'Uploded case Analysis Report', 'Done', 'Awaiting Hearing', 'Admin'),
	(138, '29 OF 2019', '2019-11-22 12:59:03', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(139, '29 OF 2019', '2019-11-22 13:01:49', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(140, '29 OF 2019', '2019-11-22 13:17:19', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(141, '29 OF 2019', '2019-11-22 13:17:51', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(142, '29 OF 2019', '2019-11-22 13:48:21', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(143, '29 OF 2019', '2019-11-22 14:08:46', 'Decision preparation', 'Done', 'Closed', 'Admin'),
	(144, '29 OF 2019', '2019-11-22 14:31:58', 'Decision Report', 'Done', 'Awaiting Decision Report Approval', 'Admin'),
	(145, '29 OF 2019', '2019-11-22 14:48:50', 'Judicial Review', 'Done', 'Judicial Review', 'Admin'),
	(146, '12 OF 2019', '2019-11-23 12:12:18', 'Decision preparation', 'Done', 'Closed', 'Admin'),
	(147, '12 OF 2019', '2019-11-23 12:57:27', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(148, '29 OF 2019', '2019-11-25 16:00:34', 'Judicial Review Closed', 'Done', 'Judicial Review Closed', 'Admin'),
	(149, '31', '2019-11-26 14:35:28', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(150, '31', '2019-11-26 14:37:04', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(151, '32', '2019-11-26 15:21:11', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(152, '32', '2019-11-26 15:21:50', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(153, '28 OF 2019', '2019-11-28 13:36:55', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(154, '28 OF 2019', '2019-11-28 13:52:10', 'Submited Request for Adjournment', 'Done', 'Awaiting Approval', 'P0123456788X'),
	(155, '28 OF 2019', '2019-11-28 14:53:53', 'Approved Request for Adjournment', 'Done', 'Awaiting Approval', 'PPRA01'),
	(156, '33', '2019-11-28 15:34:35', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(157, '33', '2019-11-28 15:42:57', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(158, '30 OF 2019', '2019-11-28 15:47:17', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(159, '30 OF 2019', '2019-11-28 15:51:25', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(160, '30 OF 2019', '2019-11-28 15:58:50', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(161, '30 OF 2019', '2019-11-28 16:01:49', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(162, '28 OF 2019', '2019-11-28 16:06:11', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'A123456789X'),
	(163, '30 OF 2019', '2019-11-28 16:08:30', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(164, '30 OF 2019', '2019-11-28 16:09:45', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(165, '30 OF 2019', '2019-11-28 16:10:39', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(166, '28 OF 2019', '2019-11-28 16:13:01', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(167, '30 OF 2019', '2019-11-28 16:59:15', 'Submited Request for Adjournment', 'Done', 'Awaiting Approval', 'P0123456788X'),
	(168, '30 OF 2019', '2019-11-28 17:01:55', 'Approved Request for Adjournment', 'Done', 'Awaiting Approval', 'PPRA01'),
	(169, '31 OF 2019', '2019-11-29 09:16:32', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(170, '31 OF 2019', '2019-11-29 09:24:49', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(171, '31 OF 2019', '2019-11-29 09:28:19', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(172, '31 OF 2019', '2019-11-29 09:30:13', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(173, '31 OF 2019', '2019-11-29 09:59:45', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Panel Formation', 'A123456789X'),
	(174, '31 OF 2019', '2019-11-29 10:09:53', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(175, '31 OF 2019', '2019-11-29 10:10:57', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(176, '31 OF 2019', '2019-11-29 10:28:35', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(177, '31 OF 2019', '2019-11-29 10:28:40', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(178, '31 OF 2019', '2019-11-29 10:31:58', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(179, '31 OF 2019', '2019-11-29 10:41:03', 'Submited Request for Adjournment', 'Done', 'Awaiting Approval', 'P0123456788X'),
	(180, '31 OF 2019', '2019-11-29 11:01:24', 'Approved Request for Adjournment', 'Done', 'Awaiting Approval', 'CASEOFFICER01'),
	(181, '31 OF 2019', '2019-11-29 11:34:21', 'Declined Request for Adjournment', 'Done', 'Awaiting Approval', 'Admin'),
	(182, '31 OF 2019', '2019-11-29 12:04:00', 'Submited request for case withdrawal', 'Done', 'Awaiting Approval', 'P0123456788X'),
	(183, '31 OF 2019', '2019-11-29 12:12:25', 'WITHDRAWN', 'Done', '  ', 'Admin'),
	(184, '22 OF 2019', '2019-11-29 15:48:32', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Pleriminary Fees Confirmation', 'A123456789X'),
	(185, '22 OF 2019', '2019-11-29 15:49:40', 'Preliminary Objection Fees Payment Confirmed', 'Done', 'Awaiting Panel Formation', 'Admin'),
	(186, '30 OF 2019', '2019-12-02 09:45:16', 'Submited request for case withdrawal', 'Done', 'Awaiting Approval', 'P0123456788X'),
	(187, '30 OF 2019', '2019-12-02 13:48:57', 'Declined request for case withdrawal', 'Done', '  ', 'Admin'),
	(188, '30 OF 2019', '2019-12-02 14:24:43', 'WITHDRAWN', 'Done', '  ', 'Admin'),
	(189, '32 OF 2019', '2019-12-02 14:31:22', 'Created New Application', 'Done', 'Not Submited Application', 'P0123456788X'),
	(190, '32 OF 2019', '2019-12-02 14:34:02', 'Submited Application', 'Done', 'Awaiting fees confirmation', 'P0123456788X'),
	(191, '32 OF 2019', '2019-12-02 14:52:11', 'Application Fees Payment Confirmed', 'Done', 'Awaiting Application Approval', 'Admin'),
	(192, '32 OF 2019', '2019-12-02 14:56:01', 'Application Approved', 'Done', 'Awaiting PE Response', 'Admin'),
	(193, '32 OF 2019', '2019-12-02 15:59:20', 'Procuring Entity Submited her Response', 'Done', 'Awaiting Pleriminary Fees Confirmation', 'A123456789X'),
	(194, '32 OF 2019', '2019-12-02 16:04:38', 'Preliminary Objection Fees Payment Confirmed', 'Done', 'Awaiting Panel Formation', 'Admin'),
	(195, '32 OF 2019', '2019-12-02 16:19:35', 'Submited Hearing Panel', 'Done', 'Awaiting Panel Approval', 'Admin'),
	(196, '32 OF 2019', '2019-12-02 16:20:08', 'Approved PanelList', 'Done', 'Awaiting Hearing Date scheduling', 'Admin'),
	(197, '32 OF 2019', '2019-12-02 16:20:54', 'Scheduled Hearing Date and Venue', 'Done', 'HEARING IN PROGRESS', 'Admin'),
	(198, '32 OF 2019', '2019-12-02 16:20:59', 'Case Scheduled and hearing notice generated', 'Done', 'Hearing', 'Admin'),
	(199, '32 OF 2019', '2019-12-02 16:21:42', 'Case hearing', 'Done', 'Decision preparation', 'Admin'),
	(200, '32 OF 2019', '2019-12-02 16:37:38', 'Submited Request for Adjournment', 'Done', 'Awaiting Approval', 'P0123456788X'),
	(201, '32 OF 2019', '2019-12-02 16:39:26', 'Declined Request for Adjournment', 'Done', 'Awaiting Approval', 'Admin'),
	(202, '32 OF 2019', '2019-12-02 16:44:01', 'Submited request for case withdrawal', 'Done', 'Awaiting Approval', 'P0123456788X'),
	(203, '32 OF 2019', '2019-12-02 16:44:57', 'WITHDRAWN', 'Done', '  ', 'Admin');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.applications_approval_workflow: ~19 rows (approximately)
DELETE FROM `applications_approval_workflow`;
/*!40000 ALTER TABLE `applications_approval_workflow` DISABLE KEYS */;
INSERT INTO `applications_approval_workflow` (`ID`, `TenderID`, `ApplicantID`, `PEID`, `FilingDate`, `ApplicationREf`, `ApplicationNo`, `Status`, `Approver`, `Remarks`, `Created_By`, `Approved_At`, `Created_At`) VALUES
	(1, 12, 8, 'PE-2', '2019-11-11 15:47:45', '1', '1', 'Approved', 'Admin', 'APPROVED', 'Admin', '2019-11-11 16:20:11', '2019-11-11 16:20:11'),
	(2, 16, 8, 'PE-3', '2019-11-12 10:58:39', '5', '5', 'Approved', 'PPRA01', 'DateUploaded', 'PPRA01', '2019-11-12 11:51:53', '2019-11-12 11:51:53'),
	(3, 17, 8, 'PE-3', '2019-11-12 15:45:26', '6', '6', 'Approved', 'PPRA01', '593428', 'PPRA01', '2019-11-12 15:56:41', '2019-11-12 15:56:41'),
	(4, 18, 8, 'PE-2', '2019-11-12 16:42:14', '7', '7', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-12 17:02:35', '2019-11-12 17:02:35'),
	(5, 21, 8, 'PE-3', '2019-11-13 11:14:12', '8', '8', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-13 11:42:41', '2019-11-13 11:42:41'),
	(6, 26, 9, 'PE-2', '2019-11-13 17:08:01', '15', '15', 'Approved', 'Admin', 'Declined', 'Admin', '2019-11-13 17:40:43', '2019-11-13 17:40:43'),
	(7, 28, 10, 'PE-4', '2019-11-15 10:55:17', '17', '17', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-15 11:36:02', '2019-11-15 11:36:02'),
	(8, 29, 8, 'PE-2', '2019-11-15 11:49:58', '18', '18', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-17 12:17:53', '2019-11-17 12:17:53'),
	(9, 34, 9, 'PE-2', '2019-11-20 10:53:17', '23', '23', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-20 14:59:58', '2019-11-20 14:59:58'),
	(10, 27, 8, 'PE-3', '2019-11-14 14:45:01', '16', '16', 'Approved', 'admin', 'Approved', 'admin', '2019-11-21 14:19:16', '2019-11-21 14:19:16'),
	(11, 36, 8, 'PE-2', '2019-11-21 14:27:18', '25', '25', 'Approved', 'admin', 'Approved', 'admin', '2019-11-21 14:36:22', '2019-11-21 14:36:22'),
	(12, 37, 8, 'PE-2', '2019-11-21 16:27:25', '26', '26', 'Approved', 'admin', 'Approved By WK', 'admin', '2019-11-21 17:00:59', '2019-11-21 17:00:59'),
	(13, 38, 8, 'PE-2', '2019-11-21 21:14:46', '27', '27', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-21 21:26:16', '2019-11-21 21:26:16'),
	(14, 38, 8, 'PE-2', '2019-11-21 21:14:46', '27', '24 OF 2019', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-21 21:31:33', '2019-11-21 21:31:33'),
	(15, 38, 8, 'PE-2', '2019-11-21 21:14:46', '27', '25 OF 2019', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-21 21:34:40', '2019-11-21 21:34:40'),
	(16, 38, 8, 'PE-2', '2019-11-21 21:14:46', '27', '26 OF 2019', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-21 21:37:14', '2019-11-21 21:37:14'),
	(17, 39, 8, 'PE-2', '2019-11-21 21:39:44', '28', '28', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-21 21:44:12', '2019-11-21 21:44:12'),
	(18, 41, 10, 'PE-4', '2019-11-22 11:26:40', '30', '30', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-22 11:47:04', '2019-11-22 11:47:04'),
	(19, 45, 8, 'PE-1', '2019-11-28 15:47:17', '34', '34', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-28 16:01:49', '2019-11-28 16:01:49'),
	(20, 46, 8, 'PE-2', '2019-11-29 09:16:32', '35', '35', 'Approved', 'Admin', 'Approved', 'Admin', '2019-11-29 09:30:12', '2019-11-29 09:30:12'),
	(21, 47, 8, 'PE-2', '2019-12-02 14:31:22', '36', '36', 'Approved', 'Admin', 'Approved', 'Admin', '2019-12-02 14:56:00', '2019-12-02 14:56:00');
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApproveApplicationFees`(IN _Approver VARCHAR(50), IN _ApplicationID INT, IN _Amount FLOAT, IN _Reff VARCHAR(100), IN _Category VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApprovecaseAdjournment`(IN _ApplicationNo VARCHAR(50), IN _ApprovalRemarks VARCHAR(255), IN _userID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApprovecaseWithdrawal`(IN _ApplicationNo varchar(50), IN _RejectionReason VARCHAR(255), IN _userID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApproveDeadlineRequestExtension`(IN _Approver VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _Remarks VARCHAR(255), IN _Newdate DATETIME)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApprovePanelMember`(IN _ApplicationNo VARCHAR(50),  IN _UserName VARCHAR(50), IN _UserID varchar(50))
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.approvers: ~33 rows (approximately)
DELETE FROM `approvers`;
/*!40000 ALTER TABLE `approvers` DISABLE KEYS */;
INSERT INTO `approvers` (`ID`, `Username`, `ModuleCode`, `Mandatory`, `Active`, `Create_at`, `Update_at`, `CreatedBy`, `UpdatedBy`, `Deleted`, `DeletedBY`, `Deleted_At`) VALUES
	(1, 'Admin', 'APFRE', 0, 1, '2019-10-16 14:11:35', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(3, 'Admin', 'REXED', 0, 1, '2019-10-16 14:38:31', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(4, 'Admin', 'PAYMT', 0, 1, '2019-10-16 16:32:58', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(6, 'PPRA01', 'PAREQ', 0, 0, '2019-10-17 09:41:23', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(7, 'Admin', 'PAREQ', 0, 1, '2019-10-17 09:41:24', NULL, 'Admin', 'Admin2', 0, NULL, NULL),
	(8, 'Admin', 'WIOAP', 0, 1, '2019-10-28 14:27:20', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(10, 'PPRA01', 'PAYMT', 0, 0, '2019-11-11 16:04:25', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(11, 'PPRA01', 'APFRE', 0, 0, '2019-11-11 16:05:05', NULL, 'Admin', 'PPRA01', 0, NULL, NULL),
	(12, 'CASEOFFICER01', 'REXED', 0, 1, '2019-11-11 16:05:44', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(13, 'PPRA01', 'REXED', 0, 0, '2019-11-11 16:05:46', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(14, 'CASEOFFICER01', 'APFRE', 0, 1, '2019-11-11 16:06:05', NULL, 'Admin', NULL, 0, NULL, NULL),
	(15, 'CASEOFFICER01', 'PAYMT', 0, 1, '2019-11-11 16:06:15', NULL, 'Admin', NULL, 0, NULL, NULL),
	(16, 'CASEOFFICER01', 'PAREQ', 0, 1, '2019-11-11 16:06:33', NULL, 'Admin', NULL, 0, NULL, NULL),
	(17, 'PPRA01', 'PAREQ', 0, 0, '2019-11-11 16:06:34', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(18, 'CASEOFFICER01', 'WIOAP', 0, 1, '2019-11-11 16:06:48', NULL, 'Admin', NULL, 0, NULL, NULL),
	(19, 'PPRA01', 'WIOAP', 0, 0, '2019-11-11 16:06:49', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(20, 'Admin', 'ADJRE', 1, 1, '2019-11-11 16:07:22', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(21, 'CASEOFFICER01', 'ADJRE', 0, 1, '2019-11-11 16:07:23', NULL, 'Admin', NULL, 0, NULL, NULL),
	(22, 'PPRA01', 'ADJRE', 0, 0, '2019-11-11 16:07:24', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(23, 'pkiprop', 'APFRE', 0, 0, '2019-11-15 11:12:42', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(24, 'SOdhiambo', 'APFRE', 0, 0, '2019-11-15 11:12:47', NULL, 'Admin', 'PPRA01', 0, NULL, NULL),
	(25, 'pkiprop', 'PAYMT', 0, 0, '2019-11-15 11:14:18', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(26, 'Pokumu', 'PAYMT', 0, 0, '2019-11-15 11:14:21', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(27, 'SOdhiambo', 'PAYMT', 0, 0, '2019-11-15 11:14:26', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(28, 'Admin', 'DCAPR', 0, 1, '2019-11-18 13:26:21', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(29, 'Pokumu', 'PAREQ', 0, 0, '2019-11-22 11:42:22', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(30, 'SOdhiambo', 'PAREQ', 0, 0, '2019-11-22 11:42:29', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(31, 'Pokumu', 'DCAPR', 0, 0, '2019-11-22 11:43:12', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(32, 'smiheso', 'DCAPR', 0, 0, '2019-11-22 11:43:15', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(33, 'SOdhiambo', 'DCAPR', 0, 0, '2019-11-22 11:43:17', NULL, 'Admin', 'Admin', 0, NULL, NULL),
	(34, 'smiheso', 'APFRE', 0, 0, '2019-11-22 11:43:41', NULL, 'Admin', 'PPRA01', 0, NULL, NULL),
	(35, 'Pokumu', 'APFRE', 0, 0, '2019-11-22 11:43:43', NULL, 'Admin', 'PPRA01', 0, NULL, NULL),
	(36, 'CASEOFFICER01', 'DCAPR', 0, 1, '2019-11-29 09:13:29', NULL, 'Admin', NULL, 0, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.attendanceregister: ~11 rows (approximately)
DELETE FROM `attendanceregister`;
/*!40000 ALTER TABLE `attendanceregister` DISABLE KEYS */;
INSERT INTO `attendanceregister` (`ID`, `RegisterID`, `IDNO`, `MobileNo`, `Name`, `Email`, `Category`, `Created_At`, `Created_By`, `Designation`, `FirmFrom`) VALUES
	(1, 1, '1234567', '0705555285', 'KIMUTAI', 'info@wilcom.co.ke', 'Applicant', '2019-11-14 16:45:36', 'Admin', 'ENG', 'WILCOM SYSTEMS'),
	(2, 1, '123456789', '0722719412', 'WILSON B. KEREBEI', 'wkerebei@gmail.com', 'PPRA', '2019-11-14 16:49:26', 'Admin', 'Staff', 'PPRA'),
	(3, 2, '123456', '0722719412', 'WILSON B. KEREBEI', 'wkerebei@gmail.com', 'Applicant', '2019-11-15 13:11:50', 'Admin', 'md', 'W'),
	(4, 3, '123456', '0722719412', 'WILSON B. KEREBEI', 'wkerebei@gmail.com', 'PE', '2019-11-20 16:22:16', 'Admin', 'md', 'W'),
	(5, 4, '123456', '0722955458', 'Philemon Kiprop', 'philchem2009@gmail.com', 'PPRA', '2019-11-21 18:38:34', 'Admin', 'Staff', 'PPRA'),
	(6, 4, '10000', '0722719412', 'WILSON B. KEREBEI', 'wkerebei@gmail.com', 'PE', '2019-11-21 18:39:38', 'Admin', 'MD', 'SUPPLIERS LTD'),
	(7, 5, '1234567', '0705555285', 'KIMUTAI', 'info@wilcom.co.ke', 'Press', '2019-11-22 13:51:24', 'Admin', 'ENG', 'WILCOM SYSTEMS'),
	(8, 5, '123456', '0722955458', 'Philemon Kiprop', 'philchem2009@gmail.com', 'PPRA', '2019-11-22 13:51:45', 'Admin', 'Staff', 'PPRA'),
	(9, 6, '123456', '0722955458', 'Philemon Kiprop', 'philchem2009@gmail.com', 'PPRA', '2019-11-23 13:00:43', 'Admin', 'Staff', 'PPRA'),
	(10, 6, '1234567', '0705555285', 'KIMUTAI', 'info@wilcom.co.ke', 'Applicant', '2019-11-23 13:00:56', 'Admin', 'ENG', 'WILCOM SYSTEMS'),
	(11, 6, '12399', '0705555285', 'KIM KIM', 'philchem2009@gmail.com', 'InterestedParty', '2019-11-23 13:49:49', 'Admin', 'md', 'Interested party1'),
	(12, 7, '123456', '0722719412', 'WILSON B. KEREBEI', 'wkerebei@gmail.com', 'PE', '2019-11-28 16:13:10', 'Admin', 'md', 'W');
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
) ENGINE=InnoDB AUTO_INCREMENT=816 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.audittrails: ~152 rows (approximately)
DELETE FROM `audittrails`;
/*!40000 ALTER TABLE `audittrails` DISABLE KEYS */;
INSERT INTO `audittrails` (`AuditID`, `Date`, `Username`, `Description`, `Category`, `IpAddress`) VALUES
	(664, '2019-11-28 15:47:17', 'P0123456788X', 'Added new Tender with TenderNo:TENDER/0001/2019/2020', 'Add', 0),
	(665, '2019-11-28 15:47:17', 'P0123456788X', 'Added new Application with ApplicationNo:34', 'Add', 0),
	(666, '2019-11-28 15:47:17', 'P0123456788X', 'Added Fee for Application: 34', 'Add', 0),
	(667, '2019-11-28 15:47:17', 'P0123456788X', 'Added Fee for Application: 34', 'Add', 0),
	(668, '2019-11-28 15:47:18', 'P0123456788X', 'Added Fee for Application: 34', 'Add', 0),
	(669, '2019-11-28 15:47:36', 'P0123456788X', 'Added new Ground/Request for Application:34', 'Add', 0),
	(670, '2019-11-28 15:51:25', 'P0123456788X', 'Added new payment details for application: 34', 'Add', 0),
	(671, '2019-11-28 16:01:50', 'Admin', ' Approved Application: 34', 'Approval', 0),
	(672, '2019-11-28 16:04:39', 'Admin', 'Deleted Case Officer: Pokumu', 'Delete', 0),
	(673, '2019-11-28 16:05:58', 'A123456789X', 'Added new PE Response background Information for ApplicationNo:28 OF 2019', 'Add', 0),
	(674, '2019-11-28 16:06:03', 'A123456789X', ' Responded to application:28 OF 2019', 'Add', 0),
	(675, '2019-11-28 16:06:04', 'A123456789X', 'Updated PE Response for Response ID: 10', 'Add', 0),
	(676, '2019-11-28 16:06:52', 'Admin', 'Added new PanelMember for Application 30 OF 2019', 'Add', 0),
	(677, '2019-11-28 16:06:55', 'Admin', 'Added new PanelMember for Application 30 OF 2019', 'Add', 0),
	(678, '2019-11-28 16:06:58', 'Admin', 'Added new PanelMember for Application 30 OF 2019', 'Add', 0),
	(679, '2019-11-28 16:07:00', 'Admin', 'Submited PanelList  for Application: 30 OF 2019', 'Add', 0),
	(680, '2019-11-28 16:07:28', 'Admin', 'Submited PanelList  for Application: 30 OF 2019', 'Add', 0),
	(681, '2019-11-28 16:08:30', 'Admin', 'Submited PanelList  for Application: 30 OF 2019', 'Add', 0),
	(682, '2019-11-28 16:09:02', 'Admin', 'Approved  PanelMember:Admin', 'Approval', 0),
	(683, '2019-11-28 16:09:31', 'Admin', 'Approved  PanelMember:CASEOFFICER01', 'Approval', 0),
	(684, '2019-11-28 16:09:40', 'Admin', 'Approved  PanelMember:PPRA01', 'Approval', 0),
	(685, '2019-11-28 16:10:39', 'Admin', 'Booked Venue:5', 'Add', 0),
	(686, '2019-11-28 16:12:40', 'Admin', 'Booked Venue:5', 'Add', 0),
	(687, '2019-11-28 16:13:01', 'Admin', 'Registered hearing for Application:28 OF 2019', 'Add', 0),
	(688, '2019-11-28 16:13:10', 'Admin', 'Attended hearing for Application:28 OF 2019', 'Add', 0),
	(689, '2019-11-28 16:59:15', 'P0123456788X', 'Submited request for case withdrawal for application:30 OF 2019', 'Add', 0),
	(690, '2019-11-28 17:00:34', 'Admin', 'Approved Case Adjournment for Application : 30 OF 2019', 'Approval', 0),
	(691, '2019-11-28 17:01:56', 'PPRA01', 'Approved Case Adjournment for Application : 30 OF 2019', 'Approval', 0),
	(692, '2019-11-29 09:10:07', 'Admin', '0', 'Add', 0),
	(693, '2019-11-29 09:10:08', 'Admin', 'Updated Maximum Approvals for ModuleREXED', 'Add', 0),
	(694, '2019-11-29 09:10:17', 'Admin', 'Updated Maximum Approvals for ModuleREXED', 'Add', 0),
	(695, '2019-11-29 09:10:33', 'Admin', '0', 'Add', 0),
	(696, '2019-11-29 09:10:35', 'Admin', 'Updated Maximum Approvals for ModulePAYMT', 'Add', 0),
	(697, '2019-11-29 09:10:59', 'Admin', '0', 'Add', 0),
	(698, '2019-11-29 09:12:48', 'Admin', '0', 'Add', 0),
	(699, '2019-11-29 09:12:49', 'Admin', 'Updated Maximum Approvals for ModuleWIOAP', 'Add', 0),
	(700, '2019-11-29 09:13:06', 'Admin', '0', 'Add', 0),
	(701, '2019-11-29 09:13:08', 'Admin', 'Updated Maximum Approvals for ModuleADJRE', 'Add', 0),
	(702, '2019-11-29 09:13:24', 'Admin', '0', 'Add', 0),
	(703, '2019-11-29 09:13:24', 'Admin', '0', 'Add', 0),
	(704, '2019-11-29 09:13:26', 'Admin', '0', 'Add', 0),
	(705, '2019-11-29 09:13:29', 'Admin', '0', 'Add', 0),
	(706, '2019-11-29 09:13:32', 'Admin', 'Updated Maximum Approvals for ModuleDCAPR', 'Add', 0),
	(707, '2019-11-29 09:16:32', 'P0123456788X', 'Added new Tender with TenderNo:dbForge Data Compare for PostgreSQL', 'Add', 0),
	(708, '2019-11-29 09:16:32', 'P0123456788X', 'Added new Application with ApplicationNo:35', 'Add', 0),
	(709, '2019-11-29 09:16:32', 'P0123456788X', 'Added Fee for Application: 35', 'Add', 0),
	(710, '2019-11-29 09:16:32', 'P0123456788X', 'Added Fee for Application: 35', 'Add', 0),
	(711, '2019-11-29 09:16:32', 'P0123456788X', 'Added Fee for Application: 35', 'Add', 0),
	(712, '2019-11-29 09:16:51', 'P0123456788X', 'Added new Ground/Request for Application:35', 'Add', 0),
	(713, '2019-11-29 09:16:58', 'P0123456788X', 'Added new Ground/Request for Application:35', 'Add', 0),
	(714, '2019-11-29 09:25:49', 'P0123456788X', 'Added new bank slip for application: 35', 'Add', 0),
	(715, '2019-11-29 09:25:51', 'P0123456788X', 'Added new payment details for application: 35', 'Add', 0),
	(716, '2019-11-29 09:30:14', 'Admin', ' Approved Application: 35', 'Approval', 0),
	(717, '2019-11-29 09:50:04', 'P0123456788X', 'Added new additionalsubmissions doument for ApplicationNo:35', 'Add', 0),
	(718, '2019-11-29 09:50:07', 'P0123456788X', 'Added new additionalsubmissions for ApplicationNo:35', 'Add', 0),
	(719, '2019-11-29 09:58:57', 'A123456789X', 'Added new PE Response background Information for ApplicationNo:31 OF 2019', 'Add', 0),
	(720, '2019-11-29 09:59:06', 'A123456789X', ' Responded to application:31 OF 2019', 'Add', 0),
	(721, '2019-11-29 09:59:07', 'A123456789X', 'Updated PE Response for Response ID: 11', 'Add', 0),
	(722, '2019-11-29 09:59:15', 'A123456789X', 'Updated PE Response for Response ID: 11', 'Add', 0),
	(723, '2019-11-29 10:09:41', 'Admin', 'Added new PanelMember for Application 31 OF 2019', 'Add', 0),
	(724, '2019-11-29 10:09:44', 'Admin', 'Added new PanelMember for Application 31 OF 2019', 'Add', 0),
	(725, '2019-11-29 10:09:47', 'Admin', 'Added new PanelMember for Application 31 OF 2019', 'Add', 0),
	(726, '2019-11-29 10:09:53', 'Admin', 'Submited PanelList  for Application: 31 OF 2019', 'Add', 0),
	(727, '2019-11-29 10:10:51', 'Admin', 'Approved  PanelMember:Admin', 'Approval', 0),
	(728, '2019-11-29 10:10:53', 'Admin', 'Approved  PanelMember:CASEOFFICER01', 'Approval', 0),
	(729, '2019-11-29 10:10:55', 'Admin', 'Approved  PanelMember:PPRA01', 'Approval', 0),
	(730, '2019-11-29 10:17:30', 'Admin', 'Added new case analysis for Application: 31 OF 2019', 'Add', 0),
	(731, '2019-11-29 10:17:36', 'Admin', 'Added new case analysis for Application: 31 OF 2019', 'Add', 0),
	(732, '2019-11-29 10:17:48', 'Admin', 'Added new case analysis for Application: 31 OF 2019', 'Add', 0),
	(733, '2019-11-29 10:28:34', 'Admin', 'Booked Venue:5', 'Add', 0),
	(734, '2019-11-29 10:28:40', 'Admin', 'Generated hearing Notice for Application: 31 OF 2019', 'Add', 0),
	(735, '2019-11-29 10:31:58', 'Admin', 'Registered hearing for Application:31 OF 2019', 'Add', 0),
	(736, '2019-11-29 10:40:55', 'P0123456788X', 'Uploaded adjournment document for application:31 OF 2019', 'Add', 0),
	(737, '2019-11-29 10:41:03', 'P0123456788X', 'Submited request for case withdrawal for application:31 OF 2019', 'Add', 0),
	(738, '2019-11-29 10:43:53', 'Admin', 'Approved Case Adjournment for Application : 31 OF 2019', 'Approval', 0),
	(739, '2019-11-29 10:58:21', 'Admin', '569', 'Update', 0),
	(740, '2019-11-29 10:58:26', 'Admin', '749', 'Create', 0),
	(741, '2019-11-29 10:58:27', 'Admin', '749', 'Update', 0),
	(742, '2019-11-29 10:58:28', 'Admin', '749', 'Update', 0),
	(743, '2019-11-29 10:58:29', 'Admin', '749', 'Update', 0),
	(744, '2019-11-29 10:58:30', 'Admin', '749', 'Update', 0),
	(745, '2019-11-29 10:58:34', 'Admin', '819', 'Create', 0),
	(746, '2019-11-29 10:58:34', 'Admin', '819', 'Update', 0),
	(747, '2019-11-29 10:58:36', 'Admin', '819', 'Update', 0),
	(748, '2019-11-29 10:58:36', 'Admin', '819', 'Update', 0),
	(749, '2019-11-29 10:58:37', 'Admin', '819', 'Update', 0),
	(750, '2019-11-29 10:58:37', 'Admin', '829', 'Create', 0),
	(751, '2019-11-29 10:58:39', 'Admin', '829', 'Update', 0),
	(752, '2019-11-29 10:58:39', 'Admin', '829', 'Update', 0),
	(753, '2019-11-29 10:58:41', 'Admin', '829', 'Update', 0),
	(754, '2019-11-29 10:58:42', 'Admin', '829', 'Update', 0),
	(755, '2019-11-29 10:59:53', 'Admin', '569', 'Update', 0),
	(756, '2019-11-29 11:00:23', 'Admin', 'Updated  user access of role for user: CASEOFFICER01', 'Update', 0),
	(757, '2019-11-29 11:00:24', 'Admin', 'Updated  user access of role for user: CASEOFFICER01', 'Update', 0),
	(758, '2019-11-29 11:01:25', 'CASEOFFICER01', 'Approved Case Adjournment for Application : 31 OF 2019', 'Approval', 0),
	(759, '2019-11-29 11:31:30', 'P0123456788X', 'Submited request for case withdrawal for application:31 OF 2019', 'Add', 0),
	(760, '2019-11-29 11:34:21', 'Admin', 'Declined Case Adjournment for Application : 31 OF 2019', 'Approval', 0),
	(761, '2019-11-29 12:04:00', 'P0123456788X', 'Submited request for case withdrawal for application:31 OF 2019', 'Add', 0),
	(762, '2019-11-29 12:12:25', 'Admin', 'Approved Case Withdrawal for Application : 31 OF 2019', 'Approval', 0),
	(763, '2019-11-29 15:39:53', 'Admin', 'Added new Case Officer: Admin', 'Add', 0),
	(764, '2019-11-29 15:40:01', 'Admin', 'Deleted Case Officer: Admin', 'Delete', 0),
	(765, '2019-11-29 15:43:41', 'Admin', ' Declined Deadline Extension Request for Application:22 OF 2019', 'Approval', 0),
	(766, '2019-11-29 15:47:16', 'A123456789X', 'Added new PE Response background Information for ApplicationNo:22 OF 2019', 'Add', 0),
	(767, '2019-11-29 15:47:22', 'A123456789X', ' Responded to application:22 OF 2019', 'Add', 0),
	(768, '2019-11-29 15:47:23', 'A123456789X', 'Updated PE Response for Response ID: 12', 'Add', 0),
	(769, '2019-11-29 15:47:32', 'A123456789X', 'Updated PE Response for Response ID: 12', 'Add', 0),
	(770, '2019-11-29 15:48:09', 'A123456789X', 'Added new interested party for application:25', 'Add', 0),
	(771, '2019-11-29 15:48:29', 'A123456789X', 'Added new payment details for application: 25', 'Add', 0),
	(772, '2019-12-02 09:45:16', 'P0123456788X', 'Submited request for case withdrawal for application:30 OF 2019', 'Add', 0),
	(773, '2019-12-02 09:47:33', 'Admin', 'Declined Case Withdrawal for Application : 30 OF 2019', 'Approval', 0),
	(774, '2019-12-02 13:45:06', 'P0123456788X', 'Submited request for case withdrawal for application:30 OF 2019', 'Add', 0),
	(775, '2019-12-02 13:48:57', 'Admin', 'Declined Case Withdrawal for Application : 30 OF 2019', 'Approval', 0),
	(776, '2019-12-02 14:24:04', 'P0123456788X', 'Submited request for case withdrawal for application:30 OF 2019', 'Add', 0),
	(777, '2019-12-02 14:24:43', 'Admin', 'Approved Case Withdrawal for Application : 30 OF 2019', 'Approval', 0),
	(778, '2019-12-02 14:31:21', 'P0123456788X', 'Added new Tender with TenderNo:TENDER/0001/2019/2020', 'Add', 0),
	(779, '2019-12-02 14:31:22', 'P0123456788X', 'Added new Application with ApplicationNo:36', 'Add', 0),
	(780, '2019-12-02 14:31:22', 'P0123456788X', 'Added Fee for Application: 36', 'Add', 0),
	(781, '2019-12-02 14:31:22', 'P0123456788X', 'Added Fee for Application: 36', 'Add', 0),
	(782, '2019-12-02 14:31:37', 'P0123456788X', 'Added new Ground/Request for Application:36', 'Add', 0),
	(783, '2019-12-02 14:31:46', 'P0123456788X', 'Added new Ground/Request for Application:36', 'Add', 0),
	(784, '2019-12-02 14:32:02', 'P0123456788X', 'Added new Document for application: 36', 'Add', 0),
	(785, '2019-12-02 14:32:29', 'P0123456788X', 'Added new interested party for application:36', 'Add', 0),
	(786, '2019-12-02 14:34:31', 'P0123456788X', 'Added new bank slip for application: 36', 'Add', 0),
	(787, '2019-12-02 14:34:34', 'P0123456788X', 'Added new payment details for application: 36', 'Add', 0),
	(788, '2019-12-02 14:35:04', 'P0123456788X', 'Added new bank slip for application: 36', 'Add', 0),
	(789, '2019-12-02 14:35:08', 'P0123456788X', 'Added new payment details for application: 36', 'Add', 0),
	(790, '2019-12-02 14:56:02', 'Admin', ' Approved Application: 36', 'Approval', 0),
	(791, '2019-12-02 15:17:26', 'Admin', ' Declined Deadline Extension Request for Application:32 OF 2019', 'Approval', 0),
	(792, '2019-12-02 15:23:13', 'Admin', 'Approved Deadline Extension Request for Application:32 OF 2019', 'Approval', 0),
	(793, '2019-12-02 15:58:13', 'A123456789X', 'Added new PE Response background Information for ApplicationNo:32 OF 2019', 'Add', 0),
	(794, '2019-12-02 15:58:21', 'A123456789X', ' Responded to application:32 OF 2019', 'Add', 0),
	(795, '2019-12-02 15:58:22', 'A123456789X', 'Updated PE Response for Response ID: 13', 'Add', 0),
	(796, '2019-12-02 15:58:29', 'A123456789X', 'Updated PE Response for Response ID: 13', 'Add', 0),
	(797, '2019-12-02 15:59:11', 'A123456789X', 'Added new bank slip for application: 36', 'Add', 0),
	(798, '2019-12-02 15:59:16', 'A123456789X', 'Added new payment details for application: 36', 'Add', 0),
	(799, '2019-12-02 16:03:45', 'A123456789X', 'Added new payment details for application: 36', 'Add', 0),
	(800, '2019-12-02 16:19:22', 'Admin', 'Added new PanelMember for Application 32 OF 2019', 'Add', 0),
	(801, '2019-12-02 16:19:26', 'Admin', 'Added new PanelMember for Application 32 OF 2019', 'Add', 0),
	(802, '2019-12-02 16:19:29', 'Admin', 'Added new PanelMember for Application 32 OF 2019', 'Add', 0),
	(803, '2019-12-02 16:19:35', 'Admin', 'Submited PanelList  for Application: 32 OF 2019', 'Add', 0),
	(804, '2019-12-02 16:20:02', 'Admin', 'Approved  PanelMember:Admin', 'Approval', 0),
	(805, '2019-12-02 16:20:03', 'Admin', 'Approved  PanelMember:CASEOFFICER01', 'Approval', 0),
	(806, '2019-12-02 16:20:06', 'Admin', 'Approved  PanelMember:PPRA01', 'Approval', 0),
	(807, '2019-12-02 16:20:54', 'Admin', 'Booked Venue:5', 'Add', 0),
	(808, '2019-12-02 16:20:59', 'Admin', 'Generated hearing Notice for Application: 32 OF 2019', 'Add', 0),
	(809, '2019-12-02 16:21:42', 'Admin', 'Registered hearing for Application:32 OF 2019', 'Add', 0),
	(810, '2019-12-02 16:29:15', 'A123456789X', 'Added new additionalsubmissions doument for ApplicationNo:36', 'Add', 0),
	(811, '2019-12-02 16:29:18', 'A123456789X', 'Added new additionalsubmissions for ApplicationNo:36', 'Add', 0),
	(812, '2019-12-02 16:37:38', 'P0123456788X', 'Submited request for case withdrawal for application:32 OF 2019', 'Add', 0),
	(813, '2019-12-02 16:39:26', 'Admin', 'Declined Case Adjournment for Application : 32 OF 2019', 'Approval', 0),
	(814, '2019-12-02 16:44:01', 'P0123456788X', 'Submited request for case withdrawal for application:32 OF 2019', 'Add', 0),
	(815, '2019-12-02 16:44:57', 'Admin', 'Approved Case Withdrawal for Application : 32 OF 2019', 'Approval', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=5461;

-- Dumping data for table arcm.bankslips: ~25 rows (approximately)
DELETE FROM `bankslips`;
/*!40000 ALTER TABLE `bankslips` DISABLE KEYS */;
INSERT INTO `bankslips` (`ID`, `ApplicationID`, `Name`, `path`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `Category`) VALUES
	(1, 1, '1573488654509-WHT Certificate (7).pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-11 16:10:54', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(2, 5, '1573547073305-Capture.PNG', 'uploads/BankSlips', 'P0123456788X', '2019-11-12 11:24:33', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(3, 6, '1573573894355-MERU NP- PAYMENT SLIP.jpg', 'uploads/BankSlips', 'P0123456788X', '2019-11-12 15:51:34', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(4, 7, '1573577544506-KCPE CERTIFICATE.jpg', 'uploads/BankSlips', 'P0123456788X', '2019-11-12 16:52:24', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(5, 7, '1573579471376-CD Label.jpg', 'uploads/BankSlips', 'A123456789X', '2019-11-12 17:24:31', NULL, NULL, 0, NULL, NULL, 'PreliminaryObjection'),
	(6, 10, '1573633207292-Capture.PNG', 'uploads/BankSlips', 'P0123456788X', '2019-11-13 11:20:07', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(7, 10, '1573635354868-Capture.PNG', 'uploads/BankSlips', 'A123456789U', '2019-11-13 11:55:55', NULL, NULL, 0, NULL, NULL, 'PreliminaryObjection'),
	(8, 15, '1573665533807-Capture.PNG', 'uploads/BankSlips', 'P09875345W', '2019-11-13 17:18:54', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(9, 14, '1573667360757-6 OF 2019.pdf', 'uploads/BankSlips', 'P09875345W', '2019-11-13 17:49:21', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(10, 15, '1573669842870-6 OF 2019.pdf', 'uploads/BankSlips', 'A123456789X', '2019-11-13 18:30:43', NULL, NULL, 0, NULL, NULL, 'PreliminaryObjection'),
	(11, 16, '1573731987873-6 OF 2019.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-14 14:46:28', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(12, 17, '1573816192637-Price List - DEC 2015.pdf', 'uploads/BankSlips', 'P123456879Q', '2019-11-15 11:09:53', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(13, 23, '1574250127614-Capture1.PNG', 'uploads/BankSlips', 'P09875345W', '2019-11-20 14:42:07', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(14, 23, '1574252363528-Capture1.PNG', 'uploads/BankSlips', 'A123456789X', '2019-11-20 15:19:23', NULL, NULL, 0, NULL, NULL, 'PreliminaryObjection'),
	(15, 23, '1574252621629-Capture.PNG', 'uploads/BankSlips', 'A123456789X', '2019-11-20 15:23:41', NULL, NULL, 0, NULL, NULL, 'PreliminaryObjection'),
	(16, 24, '1574345795384-Job Card - EFT.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-21 14:16:35', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(17, 25, '1574346824786-Letter of Acceptance.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-21 14:33:45', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(18, 26, '1574354278238-PAYMENT SLIP.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-21 16:37:58', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(19, 26, '1574354945019-PAYMENT SLIP.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-21 16:49:05', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(20, 27, '1574371300137-6 OF 2019.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-21 21:21:40', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(21, 28, '1574372506083-6 OF 2019.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-21 21:41:46', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(22, 30, '1574422529278-6 OF 2019.pdf', 'uploads/BankSlips', 'P123456879Q', '2019-11-22 11:35:29', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(23, 31, '1574768222065-6 OF 2019.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-26 14:37:02', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(24, 33, '1574944976619-6 OF 2019.pdf', 'uploads/BankSlips', 'P0123456788X', '2019-11-28 15:42:56', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(25, 35, '1575008749045-Capture.PNG', 'uploads/BankSlips', 'P0123456788X', '2019-11-29 09:25:49', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(26, 36, '1575286470814-Capture.PNG', 'uploads/BankSlips', 'P0123456788X', '2019-12-02 14:34:31', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(27, 36, '1575286504638-Capture1.PNG', 'uploads/BankSlips', 'P0123456788X', '2019-12-02 14:35:04', NULL, NULL, 0, NULL, NULL, 'ApplicationFees'),
	(28, 36, '1575291550713-6 OF 2019.pdf', 'uploads/BankSlips', 'A123456789X', '2019-12-02 15:59:11', NULL, NULL, 0, NULL, NULL, 'PreliminaryObjection');
/*!40000 ALTER TABLE `bankslips` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2730;

-- Dumping data for table arcm.branches: ~5 rows (approximately)
DELETE FROM `branches`;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` (`ID`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(12, 'MOMBASA', '2019-09-18 10:25:17', 'Admin', '2019-11-21 10:53:40', 'Admin', 0, NULL),
	(13, 'Head office,National bank Building', '2019-09-18 10:25:26', 'Admin', '2019-09-18 10:25:44', 'Admin', 1, 'Admin'),
	(14, 'KISUMU', '2019-09-18 10:29:11', 'Admin', '2019-11-21 10:53:50', 'Admin', 0, NULL),
	(15, 'HEAD OFFICE', '2019-09-18 10:29:21', 'Admin', '2019-11-21 10:53:28', 'Admin', 0, NULL),
	(16, 'Kitale', '2019-11-22 13:11:02', 'Admin', '2019-11-22 13:11:02', 'Admin', 0, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.caseanalysis: ~13 rows (approximately)
DELETE FROM `caseanalysis`;
/*!40000 ALTER TABLE `caseanalysis` DISABLE KEYS */;
INSERT INTO `caseanalysis` (`ID`, `ApplicationNO`, `Description`, `Title`, `Create_at`, `CreatedBy`, `Deleted`, `DeletedBy`, `Deleted_At`) VALUES
	(7, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorp</p>\n', 'Background information', '2019-11-18 17:47:46', 'Admin', 0, NULL, NULL),
	(8, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorp</p>\n', 'Findings on issues', '2019-11-18 17:48:00', 'Admin', 1, 'Admin', '2019-11-19 09:45:28.000000'),
	(9, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,</p>\n', 'Introduction', '2019-11-19 10:04:41', 'Admin', 0, NULL, NULL),
	(10, '20 OF 2019', '<h2>Lorem ipsum dolor sit amet, consectetuer adipiscing</h2>\n\n<p>elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,</p>\n', 'Background information', '2019-11-20 15:48:37', 'Admin', 0, NULL, NULL),
	(11, '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,</p>\n', 'Introduction', '2019-11-20 15:48:46', 'Admin', 0, NULL, NULL),
	(12, '23 OF 2019', '<ol>\n	<li>Add <strong>ACCOUNTING OFFICER</strong> &ndash; to the PE in all reports and Notices</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Re-Scheduling Option: - To enable user re-schedule a hearing</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>When a New member of the Panel is added an option to Re-sent the Hearing Notice should be provided</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Attendance List &ndash; To include Organization and Designation</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Deadline for Submission of Documents :- Add Deadline for Submission of Documents (This can be added at the Approval of Application)</li>\n</ol>\n', 'Background', '2019-11-21 18:12:49', 'Admin', 0, NULL, NULL),
	(13, '23 OF 2019', '<ol>\n	<li>Add <strong>ACCOUNTING OFFICER</strong> &ndash; to the PE in all reports and Notices</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Re-Scheduling Option: - To enable user re-schedule a hearing</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>When a New member of the Panel is added an option to Re-sent the Hearing Notice should be provided</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Attendance List &ndash; To include Organization and Designation</li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li>Deadline for Submission of Documents :- Add Deadline for Submission of Documents (This can be added at the Approval of Application)</li>\n</ol>\n', 'Introduction', '2019-11-21 18:13:02', 'Admin', 0, NULL, NULL),
	(14, '29 OF 2019', '<p>The Kenya Airports Authority (KAA) seeks to contract a reputable insurance company (Underwriter) to provide Medical Insurance cover for its staff, their dependents and board members for a period of one (1) year with effect from 1st January, 2020 on a framework basis. KAA may at its own discretion renew the cover for a further period of two (2) years subject to satisfactory performance.The Kenya Airports Authority (KAA) seeks to contract a reputable insurance company (Underwriter) to provide Medical Insurance cover for its staff, their dependents and board members for a period of one (1) year with effect from 1st January, 2020 on a framework basis. KAA may at its own discretion renew the cover for a further period of two (2) years subject to satisfactory performance.</p>\n', 'BACKGROUND OF AWARD', '2019-11-22 12:38:32', 'Admin', 0, NULL, NULL),
	(15, '29 OF 2019', '<p>T<strong>he Tender was advertised through approval from</strong></p>\n\n<p><em>MyGov</em> publication (<em>Standard</em> and <em>Star</em> newspapers) and appeared in the print media on 17th July, 2019 and published on KAA website and PPIP portal.</p>\n\n<p>The tender closed on 1st August, 2019 in which the technical proposals were opened and thereafter the financial proposals were opened on 19th August 2019.</p>\n\n<p>Four (4) tenderers submitted their bids by the closing date and time as recorded and listed below:-</p>\n', 'ADVERTISEMENT AND OPENING OF TENDER', '2019-11-22 12:39:05', 'Admin', 0, NULL, NULL),
	(16, '29 OF 2019', '<table cellspacing="0" style="border-collapse:collapse; width:100.0%">\n	<thead>\n		<tr>\n			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:28px; width:6%px">\n			<p><strong>Bid No.</strong></p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; height:28px; width:37%px">\n			<p><strong>Bidder Name</strong></p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; height:28px; width:24%px">\n			<p><strong>Two Envelope Bid</strong></p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; height:28px; width:31%px">\n			<p><strong>Bid price</strong></p>\n			</td>\n		</tr>\n	</thead>\n	<tbody>\n		<tr>\n			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:31px; width:6%px">\n			<p>1</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:31px; width:37%px">\n			<p>Resolution Insurance Company Limited</p>\n\n			<p>P.O Box 4469-00100 Nairobi</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:31px; width:24%px">\n			<p>Original Technical&nbsp; and a Copy</p>\n\n			<p>Financial Envelope</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:31px; vertical-align:top; width:31%px">\n			<p>&nbsp;</p>\n\n			<p>Financial envelope returned un-opened</p>\n			</td>\n		</tr>\n		<tr>\n			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; width:6%px">\n			<p>2</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; width:37%px">\n			<p>AAR Insurance Company Limited</p>\n\n			<p>P.O Box 41766-00100</p>\n\n			<p>Nairobi</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; width:24%px">\n			<p>Original Technical&nbsp; and a Copy</p>\n\n			<p>Financial Envelope</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; vertical-align:top; width:31%px">\n			<p>&nbsp;</p>\n\n			<p>Year 1: Ksh. 449,620,860</p>\n\n			<p>Year 2: Ksh. 493,702,622</p>\n\n			<p>Year 3: Ksh.542,192,560</p>\n			</td>\n		</tr>\n		<tr>\n			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; width:6%px">\n			<p>3</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; width:37%px">\n			<p>Jubilee Insurance Company of Kenya Limited</p>\n\n			<p>P.O Box 30376-00100 Nairobi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; width:24%px">\n			<p>Original Technical&nbsp; and a Copy</p>\n\n			<p>Financial Envelope</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; vertical-align:top; width:31%px">\n			<p>&nbsp;</p>\n\n			<p>Year 1: Ksh. 478,613,578</p>\n\n			<p>Year 2: Ksh. 540,169,582</p>\n\n			<p>Year 3: Ksh. 609,727,866</p>\n			</td>\n		</tr>\n		<tr>\n			<td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; width:6%px">\n			<p>4</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; width:37%px">\n			<p>UAP Insurance Company Limited</p>\n\n			<p>P.O Box 43013-00100 Nairobi</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; width:24%px">\n			<p>Original Technical&nbsp; and a Copy</p>\n\n			<p>Financial Envelope</p>\n			</td>\n			<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:19px; vertical-align:top; width:31%px">\n			<p>&nbsp;</p>\n\n			<p>Year 1: Ksh. 423,000,006</p>\n\n			<p>Year 2: Ksh. 454,725,007</p>\n\n			<p>Year 3: Ksh.500,197,507</p>\n\n			<p>&nbsp;</p>\n			</td>\n		</tr>\n	</tbody>\n</table>\n', 'Another title', '2019-11-22 12:39:27', 'Admin', 0, NULL, NULL),
	(17, '29 OF 2019', '<p><strong>EVALUATION CRITERIA&nbsp; </strong></p>\n\n<p>The bids shall be evaluated based on their responsiveness to the following Mandatory and Technical requirements. KAA will award the contract to the successful tenderer whose tender has been determined to be the most responsive to the tender. Bidders who will pass the Mandatory requirements will be considered for technical evaluation</p>\n', 'TECHNICAL EVALUATION', '2019-11-22 12:40:03', 'Admin', 0, NULL, NULL),
	(18, '31 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', 'BACKGROUND OF AWARD', '2019-11-29 10:17:30', 'Admin', 0, NULL, NULL),
	(19, '31 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', 'BACKGROUND', '2019-11-29 10:17:48', 'Admin', 0, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.caseanalysisdocuments: ~7 rows (approximately)
DELETE FROM `caseanalysisdocuments`;
/*!40000 ALTER TABLE `caseanalysisdocuments` DISABLE KEYS */;
INSERT INTO `caseanalysisdocuments` (`ID`, `ApplicationNo`, `Description`, `FileName`, `FilePath`, `Create_at`, `CreatedBy`, `Deleted`, `DeletedBY`, `Deleted_At`, `Category`, `Confidential`, `SubmitedBy`) VALUES
	(18, '17 OF 2019', 'Case Analysis Document 1', '1574150233117-6 OF 2019.pdf', 'http://74.208.157.60:3001/CaseAnalysis/', '2019-11-19 10:57:13', 'Admin', 1, NULL, NULL, 'case analysis documents', 0, 'Elvis kimutai'),
	(19, '17 OF 2019', 'Case Analysis 2', '1574150423945-6 OF 2019.pdf', 'http://74.208.157.60:3001/CaseAnalysis', '2019-11-19 11:00:24', 'Admin', 0, NULL, NULL, 'case analysis documents', 0, 'Elvis kimutai'),
	(20, '17 OF 2019', 'Document 1', '1574151795833-6 OF 2019.pdf', 'http://74.208.157.60:3001/CaseAnalysis', '2019-11-19 11:23:16', 'Admin', 0, NULL, NULL, 'case analysis documents', 0, 'Elvis kimutai'),
	(21, '16 OF 2019', 'Case Analysis for application1', '1574159101550-6 OF 2019.pdf', 'http://74.208.157.60:3001/CaseAnalysis', '2019-11-19 13:25:01', 'Admin', 0, NULL, NULL, 'case analysis documents', 0, 'Elvis kimutai'),
	(22, '20 OF 2019', 'Case Analysis', '1574253803370-6 OF 2019.pdf', 'http://74.208.157.60:3001/CaseAnalysis', '2019-11-20 15:43:23', 'Admin', 0, NULL, NULL, 'case analysis documents', 0, 'Elvis kimutai'),
	(23, '23 OF 2019', 'Case Analysis', '1574359909870-ARCMS Update â€“ 15th November 2019.docx', 'http://74.208.157.60:3001/CaseAnalysis', '2019-11-21 18:11:50', 'Admin', 0, NULL, NULL, 'case analysis documents', 0, 'Elvis kimutai'),
	(24, '29 OF 2019', 'Case Report', '1574426164094-6 OF 2019.pdf', 'http://74.208.157.60:3001/CaseAnalysis', '2019-11-22 12:36:04', 'Admin', 0, NULL, NULL, 'case analysis documents', 0, 'Elvis kimutai');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casedetails: ~19 rows (approximately)
DELETE FROM `casedetails`;
/*!40000 ALTER TABLE `casedetails` DISABLE KEYS */;
INSERT INTO `casedetails` (`ID`, `UserName`, `ApplicationNo`, `DateAsigned`, `Status`, `PrimaryOfficer`, `ReassignedTo`, `DateReasigned`, `Reason`, `Created_At`, `Created_By`, `Updated_By`, `Deleted_At`, `Deleted`) VALUES
	(1, 'Admin', '12 OF 2019', '2019-11-11 16:20:11', 'Open', 1, NULL, NULL, NULL, '2019-11-11 16:20:11', 'Admin', NULL, NULL, 0),
	(2, 'CASEOFFICER01', '13 OF 2019', '2019-11-12 11:51:53', 'Open', 1, NULL, NULL, NULL, '2019-11-12 11:51:53', 'PPRA01', NULL, NULL, 0),
	(3, 'Admin', '14 OF 2019', '2019-11-12 15:56:41', 'Open', 1, NULL, NULL, NULL, '2019-11-12 15:56:41', 'PPRA01', NULL, NULL, 0),
	(4, 'CASEOFFICER01', '15 OF 2019', '2019-11-12 17:02:36', 'Open', 1, NULL, NULL, NULL, '2019-11-12 17:02:36', 'Admin', NULL, NULL, 0),
	(5, 'Admin', '16 OF 2019', '2019-11-13 11:42:41', 'Open', 1, NULL, NULL, NULL, '2019-11-13 11:42:41', 'Admin', NULL, NULL, 0),
	(6, 'Admin', '17 OF 2019', '2019-11-13 17:40:43', 'Open', 1, NULL, NULL, NULL, '2019-11-13 17:40:43', 'Admin', NULL, NULL, 0),
	(7, 'PPRA01', '18 OF 2019', '2019-11-15 11:36:02', 'Open', 1, NULL, NULL, NULL, '2019-11-15 11:36:02', 'Admin', NULL, NULL, 0),
	(8, 'Pokumu', '19 OF 2019', '2019-11-17 12:17:53', 'Open', 1, NULL, NULL, NULL, '2019-11-17 12:17:53', 'Admin', NULL, NULL, 0),
	(9, 'Admin', '20 OF 2019', '2019-11-20 14:59:58', 'Open', 1, NULL, NULL, NULL, '2019-11-20 14:59:58', 'Admin', NULL, NULL, 0),
	(10, 'PPRA01', '21 OF 2019', '2019-11-21 14:19:16', 'Open', 1, NULL, NULL, NULL, '2019-11-21 14:19:16', 'admin', NULL, NULL, 0),
	(11, 'Pokumu', '22 OF 2019', '2019-11-21 14:36:22', 'Open', 1, NULL, NULL, NULL, '2019-11-21 14:36:22', 'admin', NULL, NULL, 0),
	(12, 'Admin', '23 OF 2019', '2019-11-21 17:01:00', 'Open', 1, NULL, NULL, NULL, '2019-11-21 17:01:00', 'admin', NULL, NULL, 0),
	(13, 'PPRA01', '24 OF 2019', '2019-11-21 21:26:16', 'Open', 1, NULL, NULL, NULL, '2019-11-21 21:26:16', 'Admin', NULL, NULL, 0),
	(14, 'Pokumu', '25 OF 2019', '2019-11-21 21:31:33', 'Open', 1, NULL, NULL, NULL, '2019-11-21 21:31:33', 'Admin', NULL, NULL, 0),
	(15, 'Admin', '26 OF 2019', '2019-11-21 21:34:41', 'Open', 1, NULL, NULL, NULL, '2019-11-21 21:34:41', 'Admin', NULL, NULL, 0),
	(16, 'PPRA01', '27 OF 2019', '2019-11-21 21:37:14', 'Open', 1, NULL, NULL, NULL, '2019-11-21 21:37:14', 'Admin', NULL, NULL, 0),
	(17, 'Pokumu', '28 OF 2019', '2019-11-21 21:44:12', 'Open', 1, NULL, NULL, NULL, '2019-11-21 21:44:12', 'Admin', NULL, NULL, 0),
	(18, 'Admin', '29 OF 2019', '2019-11-22 11:47:05', 'Open', 1, NULL, NULL, NULL, '2019-11-22 11:47:05', 'Admin', NULL, NULL, 0),
	(19, 'PPRA01', '30 OF 2019', '2019-11-28 16:01:50', 'Open', 1, NULL, NULL, NULL, '2019-11-28 16:01:50', 'Admin', NULL, NULL, 0),
	(20, 'Admin', '31 OF 2019', '2019-11-29 09:30:13', 'Open', 1, NULL, NULL, NULL, '2019-11-29 09:30:13', 'Admin', NULL, NULL, 0),
	(21, 'PPRA01', '32 OF 2019', '2019-12-02 14:56:01', 'Open', 1, NULL, NULL, NULL, '2019-12-02 14:56:01', 'Admin', NULL, NULL, 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2340;

-- Dumping data for table arcm.caseofficers: ~1 rows (approximately)
DELETE FROM `caseofficers`;
/*!40000 ALTER TABLE `caseofficers` DISABLE KEYS */;
INSERT INTO `caseofficers` (`ID`, `Username`, `MinValue`, `MaximumValue`, `Active`, `NotAvailableFrom`, `NotAvailableTo`, `OngoingCases`, `CumulativeCases`, `Create_at`, `Update_at`, `CreatedBy`, `UpdatedBy`, `Deleted`, `DeletedBY`, `Deleted_At`) VALUES
	(4, 'PPRA01', NULL, NULL, 1, '2019-11-13 00:00:00', '2019-11-14 00:00:00', 7, 7, '2019-11-13 17:01:59', '2019-11-14 07:56:52', 'Admin', 'Admin', 0, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casesittingsregister: ~6 rows (approximately)
DELETE FROM `casesittingsregister`;
/*!40000 ALTER TABLE `casesittingsregister` DISABLE KEYS */;
INSERT INTO `casesittingsregister` (`ID`, `ApplicationNo`, `VenueID`, `Date`, `SittingNo`, `Created_At`, `Created_By`, `Open`) VALUES
	(1, '17 OF 2019', 6, '2019-11-14', 1, '2019-11-14 16:40:38', 'Admin', 0),
	(2, '18 OF 2019', 6, '2019-11-15', 1, '2019-11-15 13:05:22', 'Admin', 0),
	(3, '20 OF 2019', 5, '2019-11-20', 1, '2019-11-20 16:22:06', 'Admin', 1),
	(4, '23 OF 2019', 6, '2019-11-21', 1, '2019-11-21 18:38:20', 'Admin', 0),
	(5, '29 OF 2019', 8, '2019-11-22', 1, '2019-11-22 13:48:21', 'Admin', 0),
	(6, '12 OF 2019', 5, '2019-11-23', 1, '2019-11-23 12:57:27', 'Admin', 1),
	(7, '28 OF 2019', 8, '2019-11-28', 1, '2019-11-28 16:13:01', 'Admin', 1),
	(8, '31 OF 2019', 5, '2019-11-29', 1, '2019-11-29 10:31:58', 'Admin', 1),
	(9, '32 OF 2019', 5, '2019-12-02', 1, '2019-12-02 16:21:42', 'Admin', 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawal: ~6 rows (approximately)
DELETE FROM `casewithdrawal`;
/*!40000 ALTER TABLE `casewithdrawal` DISABLE KEYS */;
INSERT INTO `casewithdrawal` (`ID`, `Date`, `Applicant`, `ApplicationNo`, `Reason`, `DecisionDate`, `Status`, `RejectionReason`, `Frivolous`, `Created_At`, `Created_By`, `Approver`) VALUES
	(1, '2019-11-12 15:58:30', 'AP-17', '14 OF 2019', 'WILL TRY AGAIN LATER', '2019-11-12', 'Approved', 'Approved', 0, '2019-11-12', 'P0123456788X', NULL),
	(2, '2019-11-29 12:04:00', 'AP-17', '31 OF 2019', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo lig', '2019-11-29', 'Approved', 'Approved', 0, '2019-11-29', 'P0123456788X', NULL),
	(3, '2019-12-02 09:45:16', 'AP-17', '30 OF 2019', 'Withdraw', '2019-12-02', 'Approved', 'Approved', 0, '2019-12-02', 'P0123456788X', NULL),
	(4, '2019-12-02 13:45:06', 'AP-17', '30 OF 2019', 'Withdraw', '2019-12-02', 'Approved', 'Approved', 0, '2019-12-02', 'P0123456788X', NULL),
	(5, '2019-12-02 14:24:04', 'AP-17', '30 OF 2019', 'Withdraw', '2019-12-02', 'Approved', 'Approved', 0, '2019-12-02', 'P0123456788X', NULL),
	(6, '2019-12-02 16:44:01', 'AP-17', '32 OF 2019', 'Withdraw', '2019-12-02', 'Approved', 'Approved', 0, '2019-12-02', 'P0123456788X', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawalapprovalworkflow: ~11 rows (approximately)
DELETE FROM `casewithdrawalapprovalworkflow`;
/*!40000 ALTER TABLE `casewithdrawalapprovalworkflow` DISABLE KEYS */;
INSERT INTO `casewithdrawalapprovalworkflow` (`ID`, `Date`, `Applicant`, `ApplicationNo`, `Reason`, `DecisionDate`, `Status`, `RejectionReason`, `Frivolous`, `Created_At`, `Created_By`, `Approver`) VALUES
	(1, '2019-10-28 16:53:43', 'AP-11', '10 OF 2019', 'Approved', '2019-10-28', 'Approved', NULL, 0, '2019-10-28', 'Admin', 'Admin'),
	(2, '2019-10-28 16:55:01', 'AP-11', '10 OF 2019', 'Approved', '2019-10-28', 'Approved', NULL, 0, '2019-10-28', 'Admin', 'Admin'),
	(3, '2019-11-01 12:32:50', 'AP-11', '6 OF 2019', 'Approved', '2019-11-01', 'Approved', NULL, 0, '2019-11-01', 'Admin', 'Admin'),
	(4, '2019-11-01 12:33:37', 'AP-11', '6 OF 2019', '561064', '2019-11-01', 'Approved', NULL, 0, '2019-11-01', 'Admin2', 'Admin2'),
	(5, '2019-11-12 16:00:13', 'AP-17', '14 OF 2019', 'Approved', '2019-11-12', 'Approved', NULL, 0, '2019-11-12', 'PPRA01', 'PPRA01'),
	(6, '2019-11-12 16:04:21', 'AP-17', '14 OF 2019', 'Approved', '2019-11-12', 'Approved', NULL, 0, '2019-11-12', 'Admin', 'Admin'),
	(7, '2019-11-29 12:12:25', 'AP-17', '31 OF 2019', 'Approved', '2019-11-29', 'Approved', NULL, 0, '2019-11-29', 'Admin', 'Admin'),
	(8, '2019-12-02 14:24:42', 'AP-17', '30 OF 2019', 'Approved', '2019-12-02', 'Approved', NULL, 0, '2019-12-02', 'Admin', 'Admin'),
	(9, '2019-12-02 14:24:42', 'AP-17', '30 OF 2019', 'Approved', '2019-12-02', 'Approved', NULL, 0, '2019-12-02', 'Admin', 'Admin'),
	(10, '2019-12-02 14:24:42', 'AP-17', '30 OF 2019', 'Approved', '2019-12-02', 'Approved', NULL, 0, '2019-12-02', 'Admin', 'Admin'),
	(11, '2019-12-02 16:44:56', 'AP-17', '32 OF 2019', 'Approved', '2019-12-02', 'Approved', NULL, 0, '2019-12-02', 'Admin', 'Admin');
/*!40000 ALTER TABLE `casewithdrawalapprovalworkflow` ENABLE KEYS */;

-- Dumping structure for table arcm.casewithdrawalcontacts
DROP TABLE IF EXISTS `casewithdrawalcontacts`;
CREATE TABLE IF NOT EXISTS `casewithdrawalcontacts` (
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Msg` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.casewithdrawalcontacts: ~9 rows (approximately)
DELETE FROM `casewithdrawalcontacts`;
/*!40000 ALTER TABLE `casewithdrawalcontacts` DISABLE KEYS */;
INSERT INTO `casewithdrawalcontacts` (`Name`, `Email`, `Mobile`, `Msg`) VALUES
	('Elvis kimutai', 'elviskcheruiyot@gmail.com', '0705555285', 'Complete'),
	('CASE OFFICER', 'cmkikungu@gmail.com1', '070110292812', 'Complete'),
	('WILSON B. KEREBEI', 'wkerebei@gmail.com1', '07227194121', 'Complete'),
	('WILSON B. KEREBEI', 'wkerebei@gmail.com1', '07227194121', 'Complete'),
	('MINISTRY OF EDUCATION', 'elviskimcheruiyot@gmail.com', '0701102928', 'Complete'),
	('MINISTRY OF EDUCATION', 'elviskimcheruiyot@gmail.com', '0705555285', 'Complete'),
	('JAMES SUPPLIERS LTD', 'KEREBEI@HOTMAIL.COM1', '07184030861', 'Complete'),
	('JAMES SUPPLIERS LTD', 'KEREBEI@HOTMAIL.COM', '0122719412', 'Complete'),
	('Home', 'elviskimcheruiyot@gmail.com', '0705555285', 'Complete');
/*!40000 ALTER TABLE `casewithdrawalcontacts` ENABLE KEYS */;

-- Dumping structure for procedure arcm.CheckifregistrationIsOpen
DROP PROCEDURE IF EXISTS `CheckifregistrationIsOpen`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckifregistrationIsOpen`(IN _Applicationno VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `CloseRegistrations`(IN _Applicationno VARCHAR(50))
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.committeetypes: ~6 rows (approximately)
DELETE FROM `committeetypes`;
/*!40000 ALTER TABLE `committeetypes` DISABLE KEYS */;
INSERT INTO `committeetypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(6, 'COMT-1', 'Tender Opening Committee Updated', '2019-08-01 10:23:03', 'Admin', '2019-08-01 10:23:42', 'Admin', 1, 'Admin'),
	(7, 'COMT-2', 'Disposal Committee', '2019-08-01 11:10:39', 'Admin', '2019-10-04 09:51:37', 'Admin', 0, NULL),
	(8, 'COMT-3', 'Disposal Committee', '2019-08-01 11:11:30', 'Admin', '2019-08-01 11:11:30', 'Admin', 1, 'Admin'),
	(9, 'COMT-4', 'Accounting Officer', '2019-08-01 11:11:47', 'Admin', '2019-08-27 17:40:15', 'Admin', 0, NULL),
	(10, 'COMT-5', 'Special committees', '2019-08-08 12:30:36', 'Admin', '2019-08-08 12:30:36', 'Admin', 0, NULL),
	(11, 'COMT-6', 'Test', '2019-08-27 17:35:10', 'Admin', '2019-08-27 17:40:18', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `committeetypes` ENABLE KEYS */;

-- Dumping structure for procedure arcm.CompleteApplication
DROP PROCEDURE IF EXISTS `CompleteApplication`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `CompleteApplication`(IN _ApplicationID INT, IN _userID VARCHAR(50))
BEGIN
Update applications set Status='Submited' where ID=_ApplicationID;
 select ApplicationNo from applications where ID=_ApplicationID LIMIT 1 into @App; 
call Saveapplicationsequence(@App,'Submited Application','Awaiting fees confirmation',_userID); 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ComprehensiveAttendanceRegister
DROP PROCEDURE IF EXISTS `ComprehensiveAttendanceRegister`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ComprehensiveAttendanceRegister`(IN _ApplicationNo varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Computefeestest`(IN _ApplicationID Int, IN _UserID varchar(50))
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
	(3, 'PPARB', 'PUBLIC PROCUREMENT ADMINISTRATIVE REVIEW BOARD', 'National Bank Building', 'Harambee Avenue', '58535', '00200', 'Nairobi', '0203244214', '0203244241', '0724562264', 'fax', 'pparb@ppra.go.ke1', 'https://www.ppra.go.ke', '123456789098', '1574933357639-PPRALogo.png', '6', '7', '20', '1', '1', '1', '33', '1', '2019-07-29 14:14:38', '2019-12-02 14:25:09', 'Admin', 'Admin', 0, ' ', '14', '1', '1', '3', '2019', NULL, 21);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.deadlineapprovalworkflow: ~5 rows (approximately)
DELETE FROM `deadlineapprovalworkflow`;
/*!40000 ALTER TABLE `deadlineapprovalworkflow` DISABLE KEYS */;
INSERT INTO `deadlineapprovalworkflow` (`ID`, `PEID`, `ApplicationNo`, `Reason`, `RequestedDate`, `Created_At`, `Created_By`, `Status`, `Approver`, `Remarks`, `Approved_At`) VALUES
	(4, 'PE-2', '28 OF 2019', '<p>pedeadlineextensionsrequests</p>\n', '2019-11-28 00:00:00', '2019-11-28 11:39:11', 'A123456789X', 'Fully Approved', 'Admin', 'Approved', '2019-11-28 11:40:52'),
	(5, 'PE-2', '22 OF 2019', '<p>682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712</p>\n', '2019-11-29 00:00:00', '2019-11-29 15:42:31', 'A123456789X', 'DECLINED', 'Admin', 'Rejected', '2019-11-29 15:43:40'),
	(6, 'PE-2', '22 OF 2019', '<p>682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712</p>\n', '2019-11-29 00:00:00', '2019-11-29 15:42:31', 'A123456789X', 'Pending Approval', 'CASEOFFICER01', NULL, NULL),
	(7, 'PE-2', '32 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', '2019-12-23 00:00:00', '2019-12-02 15:13:49', 'A123456789X', 'Fully Approved', 'Admin', 'Accepted', '2019-12-02 15:23:13'),
	(8, 'PE-2', '32 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', '2019-12-23 00:00:00', '2019-12-02 15:13:49', 'A123456789X', 'Pending Approval', 'CASEOFFICER01', NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.decisiondocuments: ~14 rows (approximately)
DELETE FROM `decisiondocuments`;
/*!40000 ALTER TABLE `decisiondocuments` DISABLE KEYS */;
INSERT INTO `decisiondocuments` (`ID`, `ApplicationNo`, `Name`, `Description`, `Path`, `Created_At`, `Deleted`, `Confidential`, `Created_By`, `Deleted_By`, `Deleted_At`, `Status`) VALUES
	(6, '7 OF 2019', '1572957522072-EFT.docx', 'Does Not Exceed 2M', 'http://localhost:3001/HearingAttachments/Documents', '2019-11-05 15:38:43', 1, 0, 'Admin', 'Admin', '2019-11-05 16:13:19', 'Draft'),
	(7, '7 OF 2019', '1572957788405-EFT.docx', 'Does Not Exceed 2M', 'http://localhost:3001/HearingAttachments/Documents', '2019-11-05 15:43:10', 1, 0, 'Admin', 'Admin', '2019-11-05 16:14:12', 'Draft'),
	(8, '7 OF 2019', '1572958662011-6 OF 2019.pdf', 'Does Not Exceed 2M', 'http://localhost:3001/HearingAttachments/Documents', '2019-11-05 15:57:43', 1, 0, 'Admin', 'Admin', '2019-11-05 16:14:57', 'Draft'),
	(9, '7 OF 2019', '1572959891503-6 OF 2019.pdf', 'Does Not Exceed 2M', 'http://localhost:3001/HearingAttachments/Documents', '2019-11-05 16:18:11', 1, 1, 'Admin', 'Admin', '2019-11-06 09:51:49', 'Draft'),
	(10, '19 OF 2019', '1574060153641-6 OF 2019.pdf', 'Decision document', 'http://74.208.157.60:3001/Decisions', '2019-11-18 09:55:53', 0, 0, 'Admin', NULL, NULL, 'Approved'),
	(11, '19 OF 2019', '1574060228210-6 OF 2019.pdf', 'Decision document', 'http://74.208.157.60:3001/Decisions', '2019-11-18 09:57:08', 1, 0, 'Admin', 'Admin', '2019-11-18 10:02:08', 'Draft'),
	(12, '19 OF 2019', '1574062032537-6 OF 2019.pdf', 'Decision document', 'http://localhost:3001/Decisions', '2019-11-18 10:27:12', 0, 0, 'Admin', NULL, NULL, 'Approved'),
	(13, '17 OF 2019', '1574064682826-6 OF 2019.pdf', 'Decision document', 'http://localhost:3001/Decisions', '2019-11-18 11:11:23', 0, 0, 'Admin', 'Admin', '2019-11-18 11:11:44', 'Approved'),
	(14, '17 OF 2019', '1574064708541-6 OF 2019.pdf', 'Decision document', 'http://localhost:3001/Decisions', '2019-11-18 11:11:48', 0, 0, 'Admin', NULL, NULL, 'Approved'),
	(15, '16 OF 2019', '1574241488497-6 OF 2019.pdf', 'Decision document', 'http://74.208.157.60:3001/Decisions', '2019-11-20 12:18:09', 0, 0, 'Admin', NULL, NULL, 'Approved'),
	(16, '16 OF 2019', '1574241596760-6 OF 2019.pdf', 'Decision document', 'http://74.208.157.60:3001/Decisions', '2019-11-20 12:19:57', 1, 0, 'Admin', 'Admin', '2019-11-20 12:20:51', 'Draft'),
	(17, '16 OF 2019', '1574241605021-6 OF 2019.pdf', 'Decision document', 'http://74.208.157.60:3001/Decisions', '2019-11-20 12:20:05', 1, 0, 'Admin', 'Admin', '2019-11-20 12:20:50', 'Draft'),
	(18, '23 OF 2019', '1574362336520-Requirements_for_review.pdf', 'Decision document', 'http://74.208.157.60:3001/Decisions', '2019-11-21 18:52:16', 0, 0, 'Admin', NULL, NULL, 'Approved'),
	(19, '29 OF 2019', '1574433085567-29 OF 2019 (2).pdf', 'Decision document', 'http://74.208.157.60:3001/Decisions', '2019-11-22 14:31:25', 0, 0, 'Admin', NULL, NULL, 'Draft'),
	(20, '12 OF 2019', '1574496413509-6 OF 2019.pdf', '<p>Document1</p>\n', 'http://74.208.157.60:3001/HearingAttachments/Documents', '2019-11-23 11:06:53', 0, 0, 'Admin', NULL, NULL, 'Approved');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.decisionorders: ~20 rows (approximately)
DELETE FROM `decisionorders`;
/*!40000 ALTER TABLE `decisionorders` DISABLE KEYS */;
INSERT INTO `decisionorders` (`ID`, `NO`, `ApplicationNo`, `Description`, `Created_At`, `Deleted`, `Created_By`, `Deleted_By`, `Deleted_At`, `Updated_At`, `Updated_By`) VALUES
	(1, 1, '7 OF 2019', '<p>sss updated</p>\n', '2019-11-06 10:17:36', 1, 'Admin', 'Admin', '2019-11-06 10:34:46', '2019-11-06 10:29:49', 'Admin'),
	(2, 1, '7 OF 2019', '<p>sss updated</p>\n', '2019-11-06 10:18:23', 1, 'Admin', 'Admin', '2019-11-06 10:34:46', '2019-11-06 10:29:49', 'Admin'),
	(3, 1, '7 OF 2019', '<p>sss updated</p>\n', '2019-11-06 10:23:05', 1, 'Admin', 'Admin', '2019-11-06 10:34:46', '2019-11-06 10:29:49', 'Admin'),
	(4, 1, '7 OF 2019', '<p>sss updated</p>\n', '2019-11-06 10:29:31', 1, 'Admin', 'Admin', '2019-11-06 10:34:46', '2019-11-06 10:29:49', 'Admin'),
	(5, 2, '7 OF 2019', '<p>sss fff</p>\n', '2019-11-06 10:29:38', 1, 'Admin', 'Admin', '2019-11-06 15:11:05', '2019-11-06 10:31:23', 'Admin'),
	(6, 1, '7 OF 2019', '<p>1</p>\n', '2019-11-06 10:31:35', 1, 'Admin', 'Admin', '2019-11-06 10:34:46', NULL, NULL),
	(7, 1, '7 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n', '2019-11-06 15:10:54', 0, 'Admin', NULL, NULL, NULL, NULL),
	(8, 2, '7 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n', '2019-11-06 15:11:00', 1, 'Admin', 'Admin', '2019-11-06 15:11:05', NULL, NULL),
	(9, 1, '11 OF 2019', '<p>Whereas Wilcom Systems the applicant herein has instituted a complaint against MINISTRY OF<br />\nEDUCATION (Procuring Entity or Director General) on 2019-11-11 (Date) particulars of which<br />\nwere set out in a Request for Review served upon you on 2019-11-11 .<br />\nYou are hereby required to appear on the 2019-11-11 at 8.00AM . when the complaint against you<br />\nwill be heard by this Board sitting at Mombasa,Room 1 .<br />\nIf you fail to appear,the Applicant may proceed with the complaint and determination by order of the<br />\nBoard may be made in your absence.</p>\n', '2019-11-11 11:58:13', 0, 'Admin', NULL, NULL, NULL, NULL),
	(10, 1, '18 OF 2019', '<p>dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nib</p>\n', '2019-11-15 14:00:53', 0, 'Admin', NULL, NULL, NULL, NULL),
	(11, 1, '18 OF 2019', '<p>dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nib</p>\n', '2019-11-15 14:01:17', 0, 'Admin', NULL, NULL, NULL, NULL),
	(12, 1, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:40:13', 0, 'Admin', NULL, NULL, NULL, NULL),
	(13, 2, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:40:20', 0, 'Admin', NULL, NULL, NULL, NULL),
	(14, 1, '16 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 12:15:57', 0, 'Admin', NULL, NULL, NULL, NULL),
	(15, 1, '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', '2019-11-20 16:40:37', 0, 'Admin', NULL, NULL, NULL, NULL),
	(16, 2, '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', '2019-11-20 16:40:41', 0, 'Admin', NULL, NULL, NULL, NULL),
	(17, 1, '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', '2019-11-21 18:42:44', 0, 'Admin', NULL, NULL, NULL, NULL),
	(18, 1, '29 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.&nbsp;</p>\n', '2019-11-22 14:12:44', 0, 'Admin', NULL, NULL, NULL, NULL),
	(19, 2, '29 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.&nbsp;</p>\n', '2019-11-22 14:12:49', 0, 'Admin', NULL, NULL, NULL, NULL),
	(20, 3, '29 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.&nbsp;</p>\n', '2019-11-22 14:12:54', 0, 'Admin', NULL, NULL, NULL, NULL),
	(21, 1, '12 OF 2019', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n', '2019-11-23 12:18:52', 0, 'Admin', NULL, NULL, NULL, NULL),
	(22, 2, '12 OF 2019', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n', '2019-11-23 12:18:57', 0, 'Admin', NULL, NULL, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.decisions: ~9 rows (approximately)
DELETE FROM `decisions`;
/*!40000 ALTER TABLE `decisions` DISABLE KEYS */;
INSERT INTO `decisions` (`ID`, `Status`, `ApplicationNo`, `Backgroundinformation`, `Created_At`, `Created_By`, `Deleted_By`, `Deleted_At`, `Updated_At`, `Updated_By`, `DecisionSummary`, `RequestforReview`, `ApprovalRemarks`) VALUES
	(9, 'Submited', '7 OF 2019', '<p>Cool Text is a&nbsp;<strong>FREE</strong>&nbsp;graphics generator for web pages and anywhere else you need an impressive logo without a lot of design work. Simply choose what kind of image you would like. Then fill out a form and you&#39;ll have your own custom image created on the fly.</p>\n', '2019-11-06 16:31:57', 'Admin', NULL, NULL, '2019-11-06 17:14:21', 'Admin', NULL, NULL, NULL),
	(10, 'Submited', '11 OF 2019', '<p>Whereas Wilcom Systems the applicant herein has instituted a complaint against MINISTRY OF<br />\nEDUCATION (Procuring Entity or Director General) on 2019-11-11 (Date) particulars of which<br />\nwere set out in a Request for Review served upon you on 2019-11-11 .<br />\nYou are hereby required to appear on the 2019-11-11 at 8.00AM . when the complaint against you<br />\nwill be heard by this Board sitting at Mombasa,Room 1 .<br />\nIf you fail to appear,the Applicant may proceed with the complaint and determination by order of the<br />\nBoard may be made in your absence.</p>\n', '2019-11-11 11:57:37', 'Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 'Submited', '18 OF 2019', '<p>dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nib</p>\n', '2019-11-15 13:50:02', 'Admin', NULL, NULL, '2019-11-15 14:00:00', 'Admin', NULL, NULL, NULL),
	(12, 'Submited', '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla v</p>\n', '2019-11-16 17:39:20', 'Admin', NULL, NULL, '2019-11-17 11:00:01', 'Admin', '<p><em>Summary</em>&nbsp;of the&nbsp;<em>Decision</em>&nbsp;on the admissibility of the&nbsp;<em>case</em>&nbsp;against Mr Gaddafi. The Pre-Trial Chamber I of the International Criminal Court today issued its.Attention&nbsp;<strong>MINISTRY OF EDUCATION</strong>.<br />\nYour response for Application:&nbsp;<strong>12 OF 2019.</strong>&nbsp;has been received.You will be notified when hearing date will be set.<br />\nThis is computer generated message.Please do not reply.</p>\n', NULL, NULL),
	(13, 'Submited', '16 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 12:15:04', 'Admin', NULL, NULL, '2019-11-20 12:15:52', 'Admin', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', NULL, NULL),
	(14, 'Submited', '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', '2019-11-20 16:31:42', 'Admin', NULL, NULL, '2019-11-20 16:40:31', 'Admin', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', NULL, NULL),
	(15, 'Submited', '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Re-Scheduling Option: - To enable user re-schedule a hearing</strong></li>\n</ol>\n\n<ol>\n	<li><strong>When a New member of the Panel is added an option to Re-sent the Hearing Notice should be provided</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Attendance List &ndash; To include Organization and Designation</strong></li>\n</ol>\n\n<ol>\n	<li>Deadline for Submission of Documents :- Add Deadline for Submission of Documents (This can be added at the Approval of Application)</li>\n</ol>\n', '2019-11-21 18:41:15', 'Admin', NULL, NULL, '2019-11-21 18:42:35', 'Admin', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n\n<p>&nbsp;</p>\n\n<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', NULL, NULL),
	(16, 'Submited', '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-22 14:08:46', 'Admin', NULL, NULL, '2019-11-22 14:12:35', 'Admin', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.&nbsp;</p>\n', NULL, NULL),
	(17, 'Approved', '12 OF 2019', '<p>recommendation of award to M/s Kenya Airports Parking Services Limited and his Professional Opinion was approved by the Procuring Entity&rsquo;s Accounting Officer on the same date.</p>\n\n<p><span class="marker">submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</span></p>\n', '2019-11-23 12:12:18', 'Admin', NULL, NULL, '2019-11-23 12:47:22', 'Admin', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n\n<p>&nbsp;</p>\n\n<p>&nbsp;</p>\n', 'DECLINED');
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeclinecaseAdjournment`(IN _ApplicationNo VARCHAR(50), IN _ApprovalRemarks VARCHAR(255), IN _userID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeclinecaseWithdrawal`(IN _ApplicationNo varchar(50), IN _RejectionReason VARCHAR(255),IN _userID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeclineDeadlineRequestExtension`(IN _Approver VARCHAR(50), IN _ApplicationNo VARCHAR(50), IN _Remarks VARCHAR(255))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Deleteadditionalsubmissions`(IN `_ApplicationID` INT,IN _userID varchar(50) )
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteadditionalsubmissionsDocument`(IN _DocName VARCHAR(100),IN _userID varchar(50) )
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAttachments`(IN _Name VARCHAR(50), IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Deletecaseanalysisdocuments`(IN _DocName VARCHAR(100),IN _userID varchar(50) )
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCaseOfficers`(IN _Username VARCHAR(50), IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteInterestedParty`(IN _ID INT, IN `_userID` VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Deletejrcontactusers`(IN _UserName varchar(50),_ApplicationNO VARCHAR(50),IN _UserID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletejrInterestedparty`(IN _UserName varchar(50),_ApplicationNO VARCHAR(50),IN _UserID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteJudicialDocument`(IN _name VARCHAR(150), IN _UserID VARCHAR(50))
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=910;

-- Dumping data for table arcm.feesapprovalworkflow: ~27 rows (approximately)
DELETE FROM `feesapprovalworkflow`;
/*!40000 ALTER TABLE `feesapprovalworkflow` DISABLE KEYS */;
INSERT INTO `feesapprovalworkflow` (`ID`, `ApplicationID`, `Amount`, `RefNo`, `Status`, `ApprovedBy`, `DateApproved`, `Category`) VALUES
	(1, 1, 28800, '12344545', 'Approved', 'Admin', '2019-11-11 16:12:40', 'ApplicationFees'),
	(2, 1, 28800, '12334444', 'Approved', 'CASEOFFICER01', '2019-11-11 16:15:44', 'ApplicationFees'),
	(3, 5, 15000, '12344545', 'Approved', 'Admin', '2019-11-12 11:39:40', 'ApplicationFees'),
	(4, 5, 15000, '12344545', 'Approved', 'PPRA01', '2019-11-12 11:42:37', 'ApplicationFees'),
	(5, 6, 26000, '12344545', 'Approved', 'Admin', '2019-11-12 15:54:11', 'ApplicationFees'),
	(6, 6, 26000, '12344545', 'Approved', 'PPRA01', '2019-11-12 15:55:25', 'ApplicationFees'),
	(7, 7, 45000, '12344545', 'Approved', 'Admin', '2019-11-12 17:00:55', 'ApplicationFees'),
	(8, 7, 5000, '5000', 'Approved', 'Admin', '2019-11-12 17:32:57', 'PreliminaryObjectionFees'),
	(9, 10, 75000, '12344545', 'Approved', 'Admin', '2019-11-13 11:28:09', 'ApplicationFees'),
	(10, 10, 75000, '12344545', 'Approved', 'Admin', '2019-11-13 11:32:12', 'ApplicationFees'),
	(11, 10, 5000, '12344545', 'Approved', 'Admin', '2019-11-13 12:26:37', 'PreliminaryObjectionFees'),
	(12, 15, 5000, 'Reff123', 'Approved', 'Admin', '2019-11-13 17:31:36', 'ApplicationFees'),
	(13, 14, 5000, 'Reff123', 'Approved', 'Admin', '2019-11-13 17:49:50', 'ApplicationFees'),
	(14, 15, 10000, 'Reff123', 'Approved', 'Admin', '2019-11-13 18:38:25', 'PreliminaryObjectionFees'),
	(15, 16, 25000, 'Reff123', 'Approved', 'Admin', '2019-11-14 14:48:40', 'ApplicationFees'),
	(16, 16, 25000, 'Reff123', 'Approved', 'Admin', '2019-11-14 14:48:40', 'ApplicationFees'),
	(17, 17, 310500, 'ARB0001/19', 'Approved', 'Pokumu', '2019-11-15 11:17:24', 'ApplicationFees'),
	(18, 18, 15000, 'Reff123', 'Approved', 'Admin', '2019-11-15 11:51:56', 'ApplicationFees'),
	(19, 23, 73000, 'Reff123', 'Approved', 'Admin', '2019-11-20 14:53:32', 'ApplicationFees'),
	(20, 23, 6000, 'Reff123', 'Approved', 'Admin', '2019-11-20 15:32:26', 'PreliminaryObjectionFees'),
	(21, 25, 15000, 'Confirmed REF 0001', 'Approved', 'admin', '2019-11-21 14:35:14', 'ApplicationFees'),
	(22, 26, 205000, '1574354278238-PAYMENT SLIP.pdf', 'Approved', 'admin', '2019-11-21 16:55:24', 'ApplicationFees'),
	(23, 27, 25000, 'REF123', 'Approved', 'Admin', '2019-11-21 21:25:10', 'ApplicationFees'),
	(24, 28, 15000, 'REF123', 'Approved', 'Admin', '2019-11-21 21:43:39', 'ApplicationFees'),
	(25, 30, 205000, 'REF00001', 'Approved', 'Admin', '2019-11-22 11:40:43', 'ApplicationFees'),
	(26, 34, 32500, 'REF123', 'Approved', 'Admin', '2019-11-28 15:58:49', 'ApplicationFees'),
	(27, 34, 32500, 'REF123', 'Approved', 'Admin', '2019-11-28 16:01:06', 'ApplicationFees'),
	(28, 35, 26500, 'REF00001', 'Approved', 'Admin', '2019-11-29 09:28:19', 'ApplicationFees'),
	(29, 25, 5000, 'REF123', 'Approved', 'Admin', '2019-11-29 15:49:40', 'PreliminaryObjectionFees'),
	(30, 36, 17000, 'REF00001', 'Approved', 'Admin', '2019-12-02 14:52:10', 'ApplicationFees'),
	(31, 36, 5000, 'REF123', 'Approved', 'Admin', '2019-12-02 16:04:38', 'PreliminaryObjectionFees');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.financialyear: ~12 rows (approximately)
DELETE FROM `financialyear`;
/*!40000 ALTER TABLE `financialyear` DISABLE KEYS */;
INSERT INTO `financialyear` (`ID`, `Code`, `StartDate`, `EndDate`, `IsCurrentYear`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`) VALUES
	(1, 2019, '2019-01-01 00:00:00', '2019-12-31 00:00:00', 1, 'Admin', '2019-08-06 12:11:28', '2019-11-21 10:46:27', '', 0, NULL, NULL),
	(2, 2020, '2019-08-01 00:00:00', '2020-07-31 00:00:00', 0, 'Admin', '2019-08-06 12:11:55', '2019-08-27 17:13:02', '', 0, NULL, NULL),
	(3, 2021, '2019-08-02 00:00:00', '2020-07-31 00:00:00', 0, 'Admin', '2019-08-06 12:12:10', '2019-08-06 12:18:23', '', 0, NULL, NULL),
	(4, 2022, '2022-01-01 00:00:00', '2022-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:46:05', '2019-11-21 10:46:20', '', 0, NULL, NULL),
	(5, 2023, '2023-01-01 00:00:00', '2023-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:47:01', NULL, NULL, 0, NULL, NULL),
	(6, 2024, '2024-01-01 00:00:00', '2024-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:47:19', NULL, NULL, 0, NULL, NULL),
	(7, 2025, '2025-01-01 00:00:00', '2025-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:47:38', NULL, NULL, 0, NULL, NULL),
	(8, 2026, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:47:55', NULL, NULL, 0, NULL, NULL),
	(9, 2027, '2027-01-01 00:00:00', '2027-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:48:25', NULL, NULL, 0, NULL, NULL),
	(10, 2028, '2028-01-01 00:00:00', '2028-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:48:39', NULL, NULL, 0, NULL, NULL),
	(11, 2029, '2029-01-01 00:00:00', '2029-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:48:53', NULL, NULL, 0, NULL, NULL),
	(12, 2030, '2030-01-01 00:00:00', '2030-12-31 00:00:00', 0, 'Admin', '2019-11-21 10:49:04', NULL, NULL, 0, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.findingsonissues: ~14 rows (approximately)
DELETE FROM `findingsonissues`;
/*!40000 ALTER TABLE `findingsonissues` DISABLE KEYS */;
INSERT INTO `findingsonissues` (`ID`, `NO`, `ApplicationNo`, `Description`, `Actions`, `Created_At`, `Deleted`, `Created_By`, `Deleted_By`, `Deleted_At`) VALUES
	(1, 1, '7 OF 2019', '<p>Updated</p>\n', 'Allowed', '2019-11-05 17:57:49', 1, 'Admin', NULL, NULL),
	(2, 1, '7 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n', 'Allowed', '2019-11-06 15:10:41', 0, 'Admin', NULL, NULL),
	(3, 2, '7 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n', 'Not Allowed', '2019-11-06 15:10:46', 0, 'Admin', NULL, NULL),
	(4, 1, '11 OF 2019', '<p>Whereas Wilcom Systems the applicant herein has instituted a complaint against MINISTRY OF<br />\nEDUCATION (Procuring Entity or Director General) on 2019-11-11 (Date) particulars of which<br />\nwere set out in a Request for Review served upon you on 2019-11-11 .<br />\nYou are hereby required to appear on the 2019-11-11 at 8.00AM . when the complaint against you<br />\nwill be heard by this Board sitting at Mombasa,Room 1 .<br />\nIf you fail to appear,the Applicant may proceed with the complaint and determination by order of the<br />\nBoard may be made in your absence.</p>\n', 'Allowed', '2019-11-11 11:58:00', 0, 'Admin', NULL, NULL),
	(5, 2, '11 OF 2019', '<p>Whereas Wilcom Systems the applicant herein has instituted a complaint against MINISTRY OF<br />\nEDUCATION (Procuring Entity or Director General) on 2019-11-11 (Date) particulars of which<br />\nwere set out in a Request for Review served upon you on 2019-11-11 .<br />\nYou are hereby required to appear on the 2019-11-11 at 8.00AM . when the complaint against you<br />\nwill be heard by this Board sitting at Mombasa,Room 1 .<br />\nIf you fail to appear,the Applicant may proceed with the complaint and determination by order of the<br />\nBoard may be made in your absence.</p>\n', 'Not Allowed', '2019-11-11 11:58:05', 0, 'Admin', NULL, NULL),
	(6, 1, '18 OF 2019', '<p>Alowed</p>\n', 'Allowed', '2019-11-15 13:52:20', 0, 'Admin', NULL, NULL),
	(7, 1, '18 OF 2019', '<p>dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nib</p>\n', 'Allowed', '2019-11-15 14:00:38', 0, 'Admin', NULL, NULL),
	(8, 1, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', NULL, '2019-11-16 15:13:44', 0, 'Admin', NULL, NULL),
	(9, 2, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', NULL, '2019-11-16 15:40:32', 0, 'Admin', NULL, NULL),
	(10, 1, '16 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', NULL, '2019-11-20 12:15:47', 0, 'Admin', NULL, NULL),
	(11, 1, '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', NULL, '2019-11-20 16:40:11', 0, 'Admin', NULL, NULL),
	(12, 1, '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', NULL, '2019-11-21 18:42:24', 0, 'Admin', NULL, NULL),
	(13, 1, '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', NULL, '2019-11-22 14:11:46', 0, 'Admin', NULL, NULL),
	(14, 2, '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', NULL, '2019-11-22 14:11:51', 0, 'Admin', NULL, NULL),
	(15, 1, '12 OF 2019', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n', NULL, '2019-11-23 12:18:40', 0, 'Admin', NULL, NULL);
/*!40000 ALTER TABLE `findingsonissues` ENABLE KEYS */;

-- Dumping structure for procedure arcm.GenerateApplicationFeesReport
DROP PROCEDURE IF EXISTS `GenerateApplicationFeesReport`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateApplicationFeesReport`(IN _FromDate Date,IN _ToDate date,IN _All Boolean)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GeneratePreliminaryFeesReport`(IN _FromDate Date,IN _ToDate date,IN _All Boolean)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Generaterequesthandled`(IN _FromDate DATE, IN _ToDate DATE, IN _All BOOLEAN)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Getadditionalsubmissions`(IN _ApplicationID INT)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetadditionalsubmissionsDocuments`(IN _ApplicationID INT)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetadditionalsubmissionsPerApplicationNo`(IN `_ApplicationID` varchar(50))
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
select * from adjournment where _UserID 
  in (Select Username from approvers where ModuleCode='ADJRE' and Active=1 and Deleted=0) and 
  ApplicationNo not in (Select ApplicationNo from adjournmentApprovalWorkFlow where Status='Approved'  and Approver=_UserID)  
  and Status='Pending Approval';
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

-- Dumping structure for procedure arcm.getAllcasesittingsregister
DROP PROCEDURE IF EXISTS `getAllcasesittingsregister`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllcasesittingsregister`()
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllHearingInProgressApplications`()
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllinterestedparties`()
BEGIN
 Select  ID,Name,ApplicationID,ContactName ,Email,TelePhone,Mobile,PhysicalAddress,PostalCode,Town,POBox,Designation
  from interestedparties where Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAllPEResponse
DROP PROCEDURE IF EXISTS `getAllPEResponse`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllPEResponse`()
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllSubmitedDecisions`()
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

-- Dumping structure for procedure arcm.GetApplicationDecisionsBackgroundinformation
DROP PROCEDURE IF EXISTS `GetApplicationDecisionsBackgroundinformation`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationDecisionsBackgroundinformation`(IN _ApplicationNo VARCHAR(50))
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

-- Dumping structure for procedure arcm.GetApplicationPaymentDetails
DROP PROCEDURE IF EXISTS `GetApplicationPaymentDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationPaymentDetails`(IN _ApplicationID INT)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationRequestsOnly`(IN _ApplicationNo VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationsforDecision`(IN _userName varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApplicationsForEachPE`(IN _LoggedInuser VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceRegister`(IN _RegisterID int)
BEGIN
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID,RegisterID,IDNO,MobileNo,Name,Email,Category,FirmFrom,Designation from attendanceregister where RegisterID=_RegisterID order BY ID ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.getAuditrails
DROP PROCEDURE IF EXISTS `getAuditrails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAuditrails`()
    NO SQL
SELECT `AuditID`, `Date`, `Username`, `Description`, `Category`, `IpAddress` FROM `audittrails`//
DELIMITER ;

-- Dumping structure for procedure arcm.Getbanks
DROP PROCEDURE IF EXISTS `Getbanks`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Getbanks`()
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getcaseanalysisdocuments`(IN _ApplicationNo varchar(50))
BEGIN


  Select  ApplicationNo,  Description, FileName, FilePath as Path, Create_at, CreatedBy, Deleted,Category,Confidential,SubmitedBy 
  from caseanalysisdocuments where ApplicationNo= _ApplicationNo and Deleted=0;



END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetCaseProceedings
DROP PROCEDURE IF EXISTS `GetCaseProceedings`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCaseProceedings`()
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCaseWithdrawalPendingApproval`(IN _UserID VARCHAR(50))
BEGIN
select * from CaseWithdrawal where _UserID in (select Username from approvers WHERE ModuleCode='WIOAP' and Deleted=0 and Active=1)
  and CaseWithdrawal.ApplicationNo not in (select ApplicationNo from casewithdrawalapprovalworkflow where Approver=_UserID )
  and status='Pending Approval';
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetClosedApplicationsForDecisionUploads
DROP PROCEDURE IF EXISTS `GetClosedApplicationsForDecisionUploads`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetClosedApplicationsForDecisionUploads`()
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
select   ApplicationNo,Path , FileName, GeneratedOn,GeneratedBy from rb1forms order by ApplicationNo DESC;
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

-- Dumping structure for procedure arcm.getinterestedpartiesPerApplication
DROP PROCEDURE IF EXISTS `getinterestedpartiesPerApplication`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getinterestedpartiesPerApplication`(IN _ApplicationID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Getjrcontactusers`(_ApplicationNO VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getJRinterestedpartiesPerApplication`(IN _ApplicationNO VARCHAR(50))
BEGIN
SET @row_number = 0; 
select (@row_number:=@row_number + 1) AS ID,Name,ApplicationNO,ContactName ,Email,TelePhone,Mobile,PhysicalAddress,PostalCode,Town,POBox,Designation
  from jrinterestedparties where Deleted=0 and ApplicationNO=_ApplicationNO ;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetJudicialreviewApplications
DROP PROCEDURE IF EXISTS `GetJudicialreviewApplications`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJudicialreviewApplications`()
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getJudicialReviewDetails`(IN _ApplicationNo VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Getjudicialreviewdocuments`(IN _ApplicationNo VARCHAR(50))
BEGIN

Select  ApplicationNo ,Name as FileName,Description ,Path , Created_At,Deleted ,DocumentDate ,ActionDate,ActionDescription,ActionSent
 From judicialreviewdocuments where ApplicationNo=_ApplicationNo and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetLoogedinCompany
DROP PROCEDURE IF EXISTS `GetLoogedinCompany`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLoogedinCompany`(IN _Username VARCHAR(50), IN _Category VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMonthlyCasesDistributions`(IN _Year Date)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMyDecision`(IN _userName varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMySchedules`(IN _Username VARCHAR(50))
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
  inner join users on users.Username=panels.UserName where ApplicationNo=_ApplicationNo and panels.deleted=0 order by ID ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetpanelsApproval
DROP PROCEDURE IF EXISTS `GetpanelsApproval`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetpanelsApproval`(IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEAppearanceFrequency`(IN _FromDate Date,IN _ToDate Date ,IN _ALl Boolean)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEAppearanceFrequencyPercategory`(IN _Category varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEApplications`(IN _PEID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPendingApplicationFees`(IN _UserName VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPendingFeesApprovals`(IN _ApplicationID int)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPendingPreliminaryObjectionFees`(IN _UserName VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPEPerApplicationNo`(IN _ApplicationNo VARCHAR(50))
BEGIN
select PEID FROM  applications where ApplicationNo=_ApplicationNo into @PEID;
  select PEID,Name,PEType,County,Location,POBox,PostalCode,Town,Mobile,Telephone,Email,Website from procuremententity where PEID=@PEID;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseBackgrounInformation
DROP PROCEDURE IF EXISTS `GetPEResponseBackgrounInformation`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEResponseBackgrounInformation`(IN _ApplicationNo varchar(50))
BEGIN
select BackgroundInformation from peresponsebackgroundinformation where ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDetails
DROP PROCEDURE IF EXISTS `GetPEResponseDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEResponseDetails`(IN _ResponseID INT)
BEGIN
Select * from peresponsedetails where PEResponseID=_ResponseID and Deleted=0;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPEResponseDetailsPerApplication
DROP PROCEDURE IF EXISTS `GetPEResponseDetailsPerApplication`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEResponseDetailsPerApplication`(IN _Application varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPEResponseDocuments`(IN _ResponseID VARCHAR(50))
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

-- Dumping structure for procedure arcm.getPreliminaryObjections
DROP PROCEDURE IF EXISTS `getPreliminaryObjections`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPreliminaryObjections`()
BEGIN
select ID,Name,Description,MaxFee,SUM(MaxFee) as Total from feesstructure where Name='Filling Preliminary Objections' and Deleted=0;
 
END//
DELIMITER ;

-- Dumping structure for procedure arcm.GetPreliminaryObjectionsFeesPaymentDetails
DROP PROCEDURE IF EXISTS `GetPreliminaryObjectionsFeesPaymentDetails`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPreliminaryObjectionsFeesPaymentDetails`(IN _ApplicationID INT)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRespondedApplicationsToBeScheduled`()
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

-- Dumping structure for procedure arcm.GetsuccessfullApplications
DROP PROCEDURE IF EXISTS `GetsuccessfullApplications`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetsuccessfullApplications`(IN _FromDate DATE, IN _ToDate DATE, IN _Category VARCHAR(50), IN _All BOOLEAN)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTenderDetailsPerApplicationNo`(IN _ApplicationNo VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `getuser`(IN `_Username` VARCHAR(128))
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
SELECT users.Name, Username,users.Board, Email,Phone,IsActive,usergroups.Name as UserGroup,users.UserGroupID,Photo,Signature,IDnumber,DOB,Gender,Category from users
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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.groundsandrequestedorders: ~70 rows (approximately)
DELETE FROM `groundsandrequestedorders`;
/*!40000 ALTER TABLE `groundsandrequestedorders` DISABLE KEYS */;
INSERT INTO `groundsandrequestedorders` (`ID`, `ApplicationID`, `Description`, `EntryType`, `Status`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `GroundNO`) VALUES
	(1, 1, '<p>The Applicant was only awarded a score of 20 out of 30 on relevant experience despite having provided evidence of experience of a similar nature related to the subject tender</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-11 15:51:31', NULL, NULL, 0, NULL, NULL, '1'),
	(2, 1, '<p>The Applicant provide equipment to demonstrate that it is ready to execute the works of the subject tender. Mr. Njuguna submitted that the Applicant demonstrated the equipments that it owns and those that were leased but only managed to score 6 out of 15 marks</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-11 15:51:50', NULL, NULL, 0, NULL, NULL, '2'),
	(3, 1, '<p>The Applicant was awarded 23 out of 24 marks on its Key personnel despite them being qualified on the criteria for Key Personnel provided for in the Tender Document</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-11 15:52:05', NULL, NULL, 0, NULL, NULL, '3'),
	(4, 1, '<p>On financial capacity, the Applicant satisfied the sub-criteria of; audited accounts, line of credit of over 20 million and Annual turnover but was still not awarded the full marks for this criterion</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-11 15:52:22', NULL, NULL, 0, NULL, NULL, '4'),
	(5, 1, '<p>An order setting aside the Procuring Entity&rsquo;s award</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-11 15:52:42', NULL, NULL, 0, NULL, NULL, '1'),
	(6, 1, '<p>An order awarding the tender to the Applicant at its Bid Price of Kshs. 70,027,204.50</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-11 15:52:55', NULL, NULL, 0, NULL, NULL, '2'),
	(7, 1, '<p>A further order or direction as the Board may deem appropriate in the circumstances</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-11 15:53:11', NULL, NULL, 0, NULL, NULL, '3'),
	(8, 1, '<p>An order awarding costs of the proceedings to the Applicant</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-11 15:53:28', NULL, NULL, 0, NULL, NULL, '4'),
	(9, 5, '<p>That the Procuring Entity declined to furnish the Applicant with a summary of the due diligence report as the same was part of confidential documents which remain in the custody of the Procuring Entity pursuant to section 67 of the Act</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 11:00:15', NULL, NULL, 0, NULL, NULL, '1'),
	(10, 5, '<p>That the Procuring Entity conducted a fresh due diligence process as directed in the decision of the Board in Request for Review No. 149/2018 and a report of the process was submitted to the Board as part of the Procuring Entity&rsquo;s confidential file pursuant to section 67 (3) (e) of the Act;</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 11:00:36', NULL, NULL, 0, NULL, NULL, '2'),
	(11, 5, '<p>Grounds&nbsp;for&nbsp;appeal</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 11:11:33', NULL, NULL, 1, '2019-11-12 11:11:39', 'P0123456788X', '3'),
	(12, 5, '<p>That the Procuring Entity conducted a fresh due diligence process as directed in the decision of the Board in Request for Review No. 149/2018 and a report of the process was submitted to the Board as part of the Procuring Entity&rsquo;s confidential file pursuant to section 67 (3) (e) of the Act;</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 11:11:47', NULL, NULL, 0, NULL, NULL, '3'),
	(13, 5, '<p>An order cancelling the award of tender and/or contract made to Kenya Airports Parking Services;</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-12 11:14:40', NULL, NULL, 0, NULL, NULL, '1'),
	(14, 5, '<p>An order substituting the award of the Respondent of the tender with an award of tender by the Board to M/s Mason Services Limited &amp; Qntra Technology Limited (JV);</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-12 11:14:53', NULL, NULL, 0, NULL, NULL, '2'),
	(15, 6, '<p><strong>Post-conditions: </strong></p>\n\n<p>User is validated with database and successfully login to account. The account session details are logged in database</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 15:47:31', NULL, NULL, 0, NULL, NULL, '1'),
	(16, 6, '<p><strong>Post-conditions: </strong></p>\n\n<p>User is validated with database and successfully login to account. The account session details are logged in database</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 15:47:39', NULL, NULL, 0, NULL, NULL, '2'),
	(17, 6, '<p><strong>Post-conditions: </strong></p>\n\n<p>User is validated with database and successfully login to account. The account session details are logged in database</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-12 15:47:47', NULL, NULL, 0, NULL, NULL, '1'),
	(18, 7, '<p>The Applicant was only awarded a score of 20 out of 30 on relevant experience despite having provided evidence of experience of a similar nature related to the subject tender;</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 16:45:19', NULL, NULL, 0, NULL, NULL, '1'),
	(19, 7, '<p>The Applicant provide equipment to demonstrate that it is ready to execute the works of the subject tender. Mr. Njuguna submitted that the Applicant demonstrated the equipments that it owns and those that were leased but only managed to score 6 out of 15 marks</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 16:45:33', NULL, NULL, 0, NULL, NULL, '2'),
	(20, 7, '<p>The Applicant was awarded 23 out of 24 marks on its Key personnel despite them being qualified on the criteria for Key Personnel provided for in the Tender Document</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-12 16:45:48', NULL, NULL, 0, NULL, NULL, '3'),
	(21, 7, '<p>An order setting aside the Procuring Entity&rsquo;s award</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-12 16:46:08', NULL, NULL, 0, NULL, NULL, '1'),
	(22, 7, '<p>An order awarding the tender to the Applicant at its Bid Price of Kshs. 70,027,204.50</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-12 16:46:39', NULL, NULL, 1, '2019-11-12 16:46:44', 'P0123456788X', '3'),
	(23, 7, '<p>An order awarding the tender to the Applicant at its Bid Price of Kshs. 70,027,204.50</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-12 16:46:51', NULL, NULL, 0, NULL, NULL, '2'),
	(24, 7, '<p>A further order or direction as the Board may deem appropriate in the circumstances</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-12 16:47:08', NULL, NULL, 0, NULL, NULL, '3'),
	(25, 10, '<p><em>Preparation</em>&nbsp;definition is - the action or process of making something ready for use or service or of getting ready for some occasion, test, or duty. How to use&nbsp;.</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-13 11:14:42', NULL, NULL, 0, NULL, NULL, '1'),
	(26, 10, '<p><em>Preparation</em>&nbsp;definition is - the action or process of making something ready for use or service or of getting ready for some occasion, test, or duty. How to use&nbsp;.</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-13 11:14:46', NULL, NULL, 0, NULL, NULL, '1'),
	(27, 15, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Don</p>\n', 'Grounds for Appeal', 'Pending Review', 'P09875345W', '2019-11-13 17:17:02', NULL, NULL, 0, NULL, NULL, '1'),
	(28, 15, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Don</p>\n', 'Requested Orders', 'Pending Review', 'P09875345W', '2019-11-13 17:17:09', NULL, NULL, 0, NULL, NULL, '2'),
	(29, 16, '<p><em>he applicant risks losing his deposit, and in addition to this if found to be corrupt/ fraudulent, the DG of PPRA may initiate case proceedings against the applicant in a court of law.</em></p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-14 14:45:16', NULL, NULL, 0, NULL, NULL, '1'),
	(30, 16, '<p><em>he applicant risks losing his deposit, and in addition to this if found to be corrupt/ fraudulent, the DG of PPRA may initiate case proceedings against the applicant in a court of law.</em></p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-14 14:45:20', NULL, NULL, 0, NULL, NULL, '1'),
	(31, 17, '<p>&nbsp;Challanging the Content of Tender documents</p>\n', 'Grounds for Appeal', 'Pending Review', 'P123456879Q', '2019-11-15 10:58:03', NULL, NULL, 0, NULL, NULL, '1'),
	(32, 17, '<p>Challanging termination of process</p>\n', 'Grounds for Appeal', 'Pending Review', 'P123456879Q', '2019-11-15 10:58:48', NULL, NULL, 0, NULL, NULL, '2'),
	(33, 17, '<p>Termination to be anuled</p>\n', 'Requested Orders', 'Pending Review', 'P123456879Q', '2019-11-15 10:59:33', NULL, NULL, 0, NULL, NULL, '1'),
	(34, 17, '<p>Cancellation of the tender documentt</p>\n', 'Requested Orders', 'Pending Review', 'P123456879Q', '2019-11-15 11:00:22', NULL, NULL, 0, NULL, NULL, '2'),
	(35, 17, '<p>&nbsp; Cost of the review Application</p>\n', 'Requested Orders', 'Pending Review', 'P123456879Q', '2019-11-15 11:01:04', NULL, NULL, 0, NULL, NULL, '2'),
	(36, 18, '<p>P0123456788X</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-15 11:50:05', NULL, NULL, 0, NULL, NULL, '1'),
	(37, 18, '<p>P0123456788X</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-15 11:50:15', NULL, NULL, 0, NULL, NULL, '3'),
	(38, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Grounds for Appeal', 'Pending Review', 'P09875345W', '2019-11-20 14:29:05', NULL, NULL, 0, NULL, NULL, '1'),
	(39, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Grounds for Appeal', 'Pending Review', 'P09875345W', '2019-11-20 14:29:22', NULL, NULL, 0, NULL, NULL, '2'),
	(40, 23, '<p>&nbsp;&nbsp;&nbsp;toast.success(&quot;Saved&nbsp;Successfuly&quot;);</p>\n', 'Grounds for Appeal', 'Pending Review', 'P09875345W', '2019-11-20 14:33:11', NULL, NULL, 0, NULL, NULL, '3'),
	(41, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Requested Orders', 'Pending Review', 'P09875345W', '2019-11-20 14:35:21', NULL, NULL, 0, NULL, NULL, '1'),
	(42, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Requested Orders', 'Pending Review', 'P09875345W', '2019-11-20 14:35:44', NULL, NULL, 0, NULL, NULL, '2'),
	(43, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Requested Orders', 'Pending Review', 'P09875345W', '2019-11-20 14:38:08', NULL, NULL, 0, NULL, NULL, '3'),
	(44, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Requested Orders', 'Pending Review', 'P09875345W', '2019-11-20 14:40:28', NULL, NULL, 0, NULL, NULL, '4'),
	(45, 23, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Grounds for Appeal', 'Pending Review', 'P09875345W', '2019-11-20 14:40:38', NULL, NULL, 0, NULL, NULL, '4'),
	(46, 24, '<p>Following the User Acceptance Testing (UAT) Meeting held on Friday, November 15th 2019 a few issues were raised from the user testing and the consultant agreed to incorporate them into the system.</p>\n\n<p>It was also agreed that we resume with the UAT on Friday, 22nd November, 2019 and conduct user training thereafter.</p>\n\n<p>This is to remind you of the UAT meeting scheduled for Tomorrow, Friday 22nd November, 2019 from 9.00AM at the 10th Floor Board Room.</p>\n\n<p>You are kindly requested to attend.</p>\n\n<p>Regards SAMSON. &nbsp;</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 14:11:23', NULL, NULL, 0, NULL, NULL, '1'),
	(47, 24, '<p>Following the User Acceptance Testing (UAT) Meeting held on Friday, November 15th 2019 a few issues were raised from the user testing and the consultant agreed to incorporate them into the system.</p>\n\n<p>It was also agreed that we resume with the UAT on Friday, 22nd November, 2019 and conduct user training thereafter.</p>\n\n<p>This is to remind you of the UAT meeting scheduled for Tomorrow, Friday 22nd November, 2019 from 9.00AM at the 10th Floor Board Room.</p>\n\n<p>You are kindly requested to attend.</p>\n\n<p>Regards SAMSON. &nbsp;</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 14:11:30', NULL, NULL, 0, NULL, NULL, '1'),
	(48, 25, '<ol>\n	<li>In accordance with the Conditions of Contract, Specifications, Drawings and Bills of Quantities/Schedule of Rates for the execution of the above named Works, we, the undersigned offer to construct, install and complete such Works and remedy any defects therein for the sum of Kshs <strong>3,532,374.00</strong> Kenya Shillings <strong>Three Million Five Hundred and Thirty-Two Thousand Three Hundred and Seventy Four.</strong></li>\n</ol>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 14:28:37', NULL, NULL, 0, NULL, NULL, '1'),
	(49, 25, '<ol>\n	<li>In accordance with the Conditions of Contract, Specifications, Drawings and Bills of Quantities/Schedule of Rates for the execution of the above named Works, we, the undersigned offer to construct, install and complete such Works and remedy any defects therein for the sum of Kshs <strong>3,532,374.00</strong> Kenya Shillings <strong>Three Million Five Hundred and Thirty-Two Thousand Three Hundred and Seventy Four.</strong></li>\n</ol>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 14:28:44', NULL, NULL, 0, NULL, NULL, '2'),
	(50, 25, '<ol>\n	<li>In accordance with the Conditions of Contract, Specifications, Drawings and Bills of Quantities/Schedule of Rates for the execution of the above named Works, we, the undersigned offer to construct, install and complete such Works and remedy any defects therein for the sum of Kshs <strong>3,532,374.00</strong> Kenya Shillings <strong>Three Million Five Hundred and Thirty-Two Thousand Three Hundred and Seventy Four.</strong></li>\n</ol>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 14:28:56', NULL, NULL, 0, NULL, NULL, '2'),
	(51, 25, '<ol>\n	<li>In accordance with the Conditions of Contract, Specifications, Drawings and Bills of Quantities/Schedule of Rates for the execution of the above named Works, we, the undersigned offer to construct, install and complete such Works and remedy any defects therein for the sum of Kshs <strong>3,532,374.00</strong> Kenya Shillings <strong>Three Million Five Hundred and Thirty-Two Thousand Three Hundred and Seventy Four.</strong></li>\n</ol>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 14:29:04', NULL, NULL, 0, NULL, NULL, '3'),
	(52, 26, '<p>A responsive bid was considered as one which meets all the completeness criteria and which is at minimum consistent with the requirements of the Tender Document</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 16:30:48', NULL, NULL, 0, NULL, NULL, '1'),
	(53, 26, '<p>A responsive bid was considered as one which meets all the completeness criteria and which is at minimum consistent with the requirements of the Tender Document</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 16:30:56', NULL, NULL, 0, NULL, NULL, '2'),
	(54, 26, '<p>A responsive bid was considered as one which meets all the completeness criteria and which is at minimum consistent with the requirements of the Tender Document</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 16:31:08', NULL, NULL, 0, NULL, NULL, '3'),
	(55, 26, '<p>A responsive bid was considered as one which meets all the completeness criteria and which is at minimum consistent with the requirements of the Tender Document</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 16:31:40', NULL, NULL, 0, NULL, NULL, '4'),
	(56, 26, '<p>A responsive bid was considered as one which meets all the completeness criteria and which is at minimum consistent with the requirements of the Tender Document</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 16:32:03', NULL, NULL, 0, NULL, NULL, '1'),
	(57, 26, '<p>A responsive bid was considered as one which meets all the completeness criteria and which is at minimum consistent with the requirements of the Tender Document</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 16:32:09', NULL, NULL, 0, NULL, NULL, '2'),
	(58, 26, '<p>A responsive bid was considered as one which meets all the completeness criteria and which is at minimum consistent with the requirements of the Tender Document</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 16:32:18', NULL, NULL, 0, NULL, NULL, '3'),
	(59, 27, '<p>/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated 4th October 2018 against the decision of Kenya Airports Authority (hereinafter referred to as &ldquo;the Procuring Entity&rsquo;&rsquo;) in respect of Tender No.</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 21:15:30', NULL, NULL, 0, NULL, NULL, '1'),
	(60, 27, '<p>/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated 4th October 2018 against the decision of Kenya Airports Authority (hereinafter referred to as &ldquo;the Procuring Entity&rsquo;&rsquo;) in respect of Tender No.</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 21:15:39', NULL, NULL, 0, NULL, NULL, '2'),
	(61, 27, '<p>/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated 4th October 2018 against the decision of Kenya Airports Authority (hereinafter referred to as &ldquo;the Procuring Entity&rsquo;&rsquo;) in respect of Tender No.</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 21:15:52', NULL, NULL, 0, NULL, NULL, '1'),
	(62, 27, '<p>/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated 4th October 2018 against the decision of Kenya Airports Authority (hereinafter referred to as &ldquo;the Procuring Entity&rsquo;&rsquo;) in respect of Tender No.</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 21:16:02', NULL, NULL, 0, NULL, NULL, '2'),
	(63, 28, '<p>P0123456788X</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-21 21:39:53', NULL, NULL, 0, NULL, NULL, '1'),
	(64, 28, '<p>P0123456788X</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-21 21:40:02', NULL, NULL, 0, NULL, NULL, '1'),
	(65, 29, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncu</p>\n', 'Grounds for Appeal', 'Pending Review', 'P123456879Q', '2019-11-22 11:17:34', NULL, NULL, 0, NULL, NULL, '1'),
	(66, 29, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncu</p>\n', 'Requested Orders', 'Pending Review', 'P123456879Q', '2019-11-22 11:17:42', NULL, NULL, 0, NULL, NULL, '1'),
	(67, 30, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede jus</p>\n', 'Grounds for Appeal', 'Pending Review', 'P123456879Q', '2019-11-22 11:27:19', NULL, NULL, 0, NULL, NULL, '1'),
	(68, 30, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede jus</p>\n', 'Requested Orders', 'Pending Review', 'P123456879Q', '2019-11-22 11:27:35', NULL, NULL, 0, NULL, NULL, '1'),
	(69, 31, '<p>W3Schools is optimized for learning, testing, and training. Examples might be simplified to improve reading and basic understanding. Tutorials, references, and examples are constantly reviewed to avoid errors, but we cannot warrant full correctness of all content. While using this site, you agree to have read and accepted our&nbsp;<a href="https://www.w3schools.com/about/about_copyright.asp">terms of use</a>,&nbsp;<a href="https://www.w3schools.com/about/about_privacy.asp">cookie and privacy policy</a>.&nbsp;<a href="https://www.w3schools.com/about/about_copyright.asp">Copyright 1999-2019</a>&nbsp;by Refsnes Data. All Rights Reserved.</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-26 14:35:44', NULL, NULL, 0, NULL, NULL, '1'),
	(70, 31, '<p>W3Schools is optimized for learning, testing, and training. Examples might be simplified to improve reading and basic understanding. Tutorials, references, and examples are constantly reviewed to avoid errors, but we cannot warrant full correctness of all content. While using this site, you agree to have read and accepted our&nbsp;<a href="https://www.w3schools.com/about/about_copyright.asp">terms of use</a>,&nbsp;<a href="https://www.w3schools.com/about/about_privacy.asp">cookie and privacy policy</a>.&nbsp;<a href="https://www.w3schools.com/about/about_copyright.asp">Copyright 1999-2019</a>&nbsp;by Refsnes Data. All Rights Reserved.</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-26 14:35:55', NULL, NULL, 0, NULL, NULL, '1'),
	(71, 33, '<p>TENDER/0001/2019/2020</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-28 15:34:44', NULL, NULL, 0, NULL, NULL, '2'),
	(72, 33, '<p>TENDER/0001/2019/2020</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-28 15:34:49', NULL, NULL, 0, NULL, NULL, '2'),
	(73, 34, '<p>TENDER/0001/2019/2020</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-28 15:47:36', NULL, NULL, 0, NULL, NULL, '1'),
	(74, 35, '<h3><a href="https://www.devart.com/dbforge/postgresql/datacompare/">dbForge Data Compare for PostgreSQL</a></h3>\n\n<p>The tool for PostgreSQL is intended for quick and safe data comparison and synchronization, convenient management of data differences in a well-designed user interface, and customizable synchronization.</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-11-29 09:16:51', NULL, NULL, 0, NULL, NULL, '1'),
	(75, 35, '<p>The tool for PostgreSQL is intended for quick and safe data comparison and synchronization, convenient management of data differences in a well-designed user interface, and customizable synchronization.</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-11-29 09:16:58', NULL, NULL, 0, NULL, NULL, '1'),
	(76, 36, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', 'Grounds for Appeal', 'Pending Review', 'P0123456788X', '2019-12-02 14:31:37', NULL, NULL, 0, NULL, NULL, '1'),
	(77, 36, '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', 'Requested Orders', 'Pending Review', 'P0123456788X', '2019-12-02 14:31:45', NULL, NULL, 0, NULL, NULL, '1');
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

-- Dumping data for table arcm.groupaccess: ~149 rows (approximately)
DELETE FROM `groupaccess`;
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
	(1, 28, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-26 12:05:15', '2019-11-13 13:45:47', 0),
	(1, 29, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-29 09:48:18', '2019-11-22 10:55:30', 0),
	(1, 30, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-09 11:42:39', '2019-09-06 16:41:08', 0),
	(1, 31, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-07-29 14:07:57', '2019-07-29 14:08:04', 0),
	(1, 32, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-07-31 16:59:31', '2019-09-06 16:41:14', 0),
	(1, 33, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 10:22:15', '2019-09-06 16:41:18', 0),
	(1, 34, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-08-01 10:25:32', '2019-09-06 16:41:30', 0),
	(1, 35, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-01 10:49:22', '2019-11-13 13:45:49', 0),
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
	(1, 60, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-09 10:57:15', '2019-10-09 10:57:20', 0),
	(1, 61, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-15 17:09:17', '2019-10-15 17:09:21', 0),
	(1, 62, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-22 14:57:23', '2019-10-22 14:57:25', 0),
	(1, 63, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-07 15:55:53', '2019-11-07 15:55:57', 0),
	(1, 64, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-07 15:53:55', '2019-11-07 15:53:59', 0),
	(1, 65, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:17', '2019-11-16 10:05:47', 0),
	(1, 66, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:17', '2019-11-16 10:05:47', 0),
	(1, 67, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:18', '2019-11-16 10:05:48', 0),
	(1, 68, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:18', '2019-11-16 10:05:48', 0),
	(1, 69, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:19', '2019-11-16 10:05:49', 0),
	(1, 70, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:20', '2019-11-16 10:05:51', 0),
	(1, 71, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:22', '2019-11-16 10:05:52', 0),
	(1, 72, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:22', '2019-11-16 10:05:53', 0),
	(1, 73, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:05:23', '2019-11-16 10:05:53', 0),
	(1, 74, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:21:17', '2019-11-18 10:21:28', 0),
	(1, 75, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:21:18', '2019-11-18 10:21:28', 0),
	(1, 76, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:21:19', '2019-11-18 10:21:29', 0),
	(1, 77, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 16:46:01', '2019-11-18 16:46:04', 0),
	(1, 78, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-19 15:08:47', '2019-11-19 15:08:49', 0),
	(1, 79, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-21 16:07:20', '2019-11-21 16:07:25', 0),
	(1, 80, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-21 16:07:26', '2019-11-21 16:07:29', 0),
	(1, 81, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-26 14:52:38', '2019-11-26 14:52:41', 0),
	(1, 82, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-27 16:57:04', '2019-11-27 16:57:07', 0),
	(7, 20, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-07-26 15:20:23', '2019-07-26 15:20:23', 0),
	(7, 21, 0, 0, 0, 0, 0, 'Admin', 'Admin', '2019-07-20 14:35:36', '2019-07-26 15:20:21', 0),
	(7, 27, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-07-26 15:20:27', '2019-07-26 15:20:27', 0),
	(7, 29, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-07-26 15:20:25', '2019-07-26 15:20:25', 0),
	(7, 36, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:07', '2019-08-08 10:07:07', 0),
	(7, 37, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:08', '2019-08-08 10:07:08', 0),
	(7, 38, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:09', '2019-08-08 10:07:09', 0),
	(7, 39, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:10', '2019-08-08 10:07:10', 0),
	(7, 40, 0, 0, 1, 0, 0, 'Admin', 'Admin', '2019-08-08 10:07:10', '2019-08-08 10:07:10', 0),
	(8, 26, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-07 13:54:55', '2019-11-07 13:54:55', 0),
	(8, 32, 1, 1, 0, 1, 1, 'Admin', 'Admin', '2019-08-16 17:21:00', '2019-08-16 17:22:55', 0),
	(8, 33, 0, 0, 0, 0, 0, 'Admin', 'Admin', '2019-10-29 10:55:41', '2019-10-29 10:55:42', 0),
	(8, 36, 1, 1, 0, 1, 1, 'Admin', 'Admin', '2019-08-16 17:22:19', '2019-08-16 17:22:57', 0),
	(8, 38, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:31', '2019-08-16 17:22:34', 0),
	(8, 40, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:40', '2019-08-16 17:22:40', 0),
	(8, 41, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:42', '2019-08-16 17:22:42', 0),
	(8, 42, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:45', '2019-08-16 17:22:45', 0),
	(8, 43, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-08-16 17:22:49', '2019-08-16 17:22:49', 0),
	(8, 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-16 17:02:21', '2019-08-16 17:02:29', 0),
	(8, 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-08-16 17:02:20', '2019-08-16 17:02:29', 0),
	(8, 47, 1, 0, 1, 1, 1, 'Admin', 'Admin', '2019-10-29 10:56:15', '2019-10-29 10:56:20', 0),
	(8, 50, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-07 14:01:08', '2019-11-07 14:01:08', 0),
	(8, 51, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-07 14:01:20', '2019-11-07 14:01:20', 0),
	(8, 55, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-07 14:01:09', '2019-11-07 14:01:09', 0),
	(8, 56, 1, 0, 1, 1, 1, 'Admin', 'Admin', '2019-09-23 11:59:42', '2019-09-23 11:59:48', 0),
	(8, 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-09-24 11:10:20', '2019-09-24 11:10:25', 0),
	(8, 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-22 14:57:57', '2019-10-22 14:58:00', 0),
	(8, 62, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-10-22 14:57:51', '2019-10-22 14:57:54', 0),
	(8, 79, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-21 16:07:41', '2019-11-21 16:07:41', 0),
	(8, 80, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-21 16:07:42', '2019-11-21 16:07:42', 0),
	(9, 17, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-22 12:55:31', '2019-11-22 12:55:31', 0),
	(9, 22, 0, 0, 0, 0, 0, 'Admin', 'Admin', '2019-11-16 10:03:55', '2019-11-16 10:03:59', 0),
	(9, 24, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:28:34', '2019-11-11 15:28:38', 0),
	(9, 25, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:28:39', '2019-11-11 15:28:45', 0),
	(9, 26, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:28:46', '2019-11-11 15:28:49', 0),
	(9, 27, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:28:52', '2019-11-11 15:28:57', 0),
	(9, 28, 0, 0, 1, 1, 0, 'Admin', 'Admin', '2019-11-13 14:30:21', '2019-11-13 14:30:22', 0),
	(9, 29, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-16 10:03:52', '2019-11-16 10:03:52', 0),
	(9, 33, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:05', '2019-11-11 15:27:07', 0),
	(9, 35, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:18', '2019-11-11 15:27:20', 0),
	(9, 36, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:25', '2019-11-11 15:27:27', 0),
	(9, 37, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:29', '2019-11-11 15:27:32', 0),
	(9, 38, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:33', '2019-11-11 15:27:37', 0),
	(9, 39, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:39', '2019-11-11 15:27:41', 0),
	(9, 40, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:42', '2019-11-11 15:27:45', 0),
	(9, 42, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:27:55', '2019-11-11 15:27:58', 0),
	(9, 43, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-11 15:28:04', '2019-11-11 15:28:04', 0),
	(9, 44, 0, 1, 0, 1, 0, 'Admin', 'Admin', '2019-11-11 15:28:11', '2019-11-11 15:28:18', 0),
	(9, 45, 0, 1, 0, 1, 0, 'Admin', 'Admin', '2019-11-11 15:28:14', '2019-11-11 15:28:17', 0),
	(9, 46, 1, 1, 0, 0, 1, 'Admin', 'Admin', '2019-11-11 15:26:18', '2019-11-11 15:26:33', 0),
	(9, 47, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:28:58', '2019-11-11 15:29:02', 0),
	(9, 48, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:29:03', '2019-11-11 15:29:07', 0),
	(9, 49, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:26:35', '2019-11-11 15:26:38', 0),
	(9, 50, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:28:20', '2019-11-11 15:28:24', 0),
	(9, 51, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:29:10', '2019-11-11 15:29:15', 0),
	(9, 52, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:29:17', '2019-11-11 15:29:21', 0),
	(9, 53, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:26:43', '2019-11-11 15:26:45', 0),
	(9, 54, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:29:23', '2019-11-11 15:29:28', 0),
	(9, 55, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:28:29', '2019-11-11 15:28:31', 0),
	(9, 56, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:29:34', '2019-11-29 10:59:53', 0),
	(9, 57, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:29:36', '2019-11-11 15:29:39', 0),
	(9, 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:30:22', '2019-11-16 10:06:48', 0),
	(9, 59, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:29:43', '2019-11-11 15:29:45', 0),
	(9, 60, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:26:54', '2019-11-11 15:26:57', 0),
	(9, 61, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:29:49', '2019-11-11 15:29:56', 0),
	(9, 62, 0, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:30:07', '2019-11-11 15:30:08', 0),
	(9, 63, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:30:10', '2019-11-11 15:30:13', 0),
	(9, 64, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:30:14', '2019-11-11 15:30:18', 0),
	(9, 65, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:08', '2019-11-16 10:06:47', 0),
	(9, 66, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:11', '2019-11-16 10:06:47', 0),
	(9, 67, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:15', '2019-11-16 10:06:45', 0),
	(9, 68, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:15', '2019-11-16 10:06:45', 0),
	(9, 69, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:16', '2019-11-16 10:06:44', 0),
	(9, 70, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:26', '2019-11-16 10:06:43', 0),
	(9, 71, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:29', '2019-11-16 10:06:42', 0),
	(9, 72, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:33', '2019-11-16 10:06:42', 0),
	(9, 73, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-16 10:06:36', '2019-11-16 10:06:41', 0),
	(9, 74, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-29 10:58:26', '2019-11-29 10:58:30', 0),
	(9, 75, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:22:29', '2019-11-18 10:22:35', 0),
	(9, 76, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 10:22:31', '2019-11-18 10:22:35', 0),
	(9, 77, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-18 16:46:13', '2019-11-18 16:46:17', 0),
	(9, 78, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-19 15:09:32', '2019-11-19 15:09:36', 0),
	(9, 81, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-29 10:58:33', '2019-11-29 10:58:37', 0),
	(9, 82, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-29 10:58:37', '2019-11-29 10:58:42', 0),
	(11, 24, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-13 14:33:50', '2019-11-13 14:33:50', 0),
	(11, 25, 0, 0, 0, 0, 0, 'Admin', 'Admin', '2019-11-13 14:33:48', '2019-11-13 14:33:49', 0),
	(11, 28, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-13 14:34:25', '2019-11-13 14:34:27', 0),
	(11, 61, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-13 14:34:10', '2019-11-13 14:34:14', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.hearingattachments: ~6 rows (approximately)
DELETE FROM `hearingattachments`;
/*!40000 ALTER TABLE `hearingattachments` DISABLE KEYS */;
INSERT INTO `hearingattachments` (`ID`, `ApplicationNo`, `Name`, `Description`, `Path`, `Category`, `UploadedOn`, `UploadedBy`, `Deleted`, `DeletedBy`) VALUES
	(1, '17 OF 2019', '1573751119773-6 OF 2019.pdf', 'REPORT', 'http://74.208.157.60:3001/HearingAttachments/Documents', 'Documents', '2019-11-14 17:05:20', 'Admin', 1, 'Admin'),
	(2, '17 OF 2019', '1573751176263-Kanye West - -128.mp3', 'AUDIO', 'http://74.208.157.60:3001/HearingAttachments/Audios', 'Audio', '2019-11-14 17:06:16', 'Admin', 0, NULL),
	(3, '17 OF 2019', '1573751270229-Short video clip-nature.mp4-SD.mp4', 'VIDEO', 'http://74.208.157.60:3001/HearingAttachments/Vedios', 'Vedio', '2019-11-14 17:07:50', 'Admin', 0, NULL),
	(4, '29 OF 2019', '1574430968673-29 OF 2019 (1).pdf', 'Document1', 'http://74.208.157.60:3001/HearingAttachments/Documents', 'Documents', '2019-11-22 13:56:08', 'Admin', 0, NULL),
	(5, '29 OF 2019', '1574431000662-Kanye West - -128.mp3', 'Aud1', 'http://74.208.157.60:3001/HearingAttachments/Audios', 'Audio', '2019-11-22 13:56:40', 'Admin', 0, NULL),
	(6, '29 OF 2019', '1574431653192-Short video clip-nature.mp4-SD.mp4', 'Vid1', 'http://74.208.157.60:3001/HearingAttachments/Vedios', 'Vedio', '2019-11-22 14:07:33', 'Admin', 0, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.hearingnotices: ~19 rows (approximately)
DELETE FROM `hearingnotices`;
/*!40000 ALTER TABLE `hearingnotices` DISABLE KEYS */;
INSERT INTO `hearingnotices` (`ID`, `ApplicationNo`, `DateGenerated`, `DateSent`, `Path`, `Filename`, `Created_By`) VALUES
	(1, '17 OF 2019', '2019-11-14 16:34:34', '2019-11-14 16:36:36', 'HearingNotices/', '17 OF 2019.pdf', 'Admin'),
	(2, '18 OF 2019', '2019-11-15 12:34:58', '2019-11-15 12:58:37', 'HearingNotices/', '18 OF 2019.pdf', 'Admin'),
	(3, '18 OF 2019', '2019-11-15 12:46:09', '2019-11-15 12:58:37', 'HearingNotices/', '18 OF 2019.pdf', 'Admin'),
	(4, '18 OF 2019', '2019-11-15 12:58:29', '2019-11-15 12:58:37', 'HearingNotices/', '18 OF 2019.pdf', 'Admin'),
	(5, '17 OF 2019', '2019-11-16 10:11:04', NULL, 'HearingNotices/', '17 OF 2019.pdf', 'Admin'),
	(6, '16 OF 2019', '2019-11-17 12:11:48', NULL, 'HearingNotices/', '16 OF 2019.pdf', 'Admin'),
	(7, '16 OF 2019', '2019-11-20 11:05:45', NULL, 'HearingNotices/', '16 OF 2019.pdf', 'Admin'),
	(8, '12 OF 2019', '2019-11-20 12:53:36', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(9, '12 OF 2019', '2019-11-20 12:57:17', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(10, '12 OF 2019', '2019-11-20 13:42:29', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(11, '12 OF 2019', '2019-11-20 13:44:28', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(12, '12 OF 2019', '2019-11-20 13:45:51', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(13, '20 OF 2019', '2019-11-20 15:50:21', '2019-11-20 15:51:01', 'HearingNotices/', '20 OF 2019.pdf', 'Admin'),
	(14, '23 OF 2019', '2019-11-21 18:30:47', '2019-11-21 18:32:29', 'HearingNotices/', '23 OF 2019.pdf', 'Admin'),
	(15, '29 OF 2019', '2019-11-22 13:17:51', '2019-11-22 13:27:54', 'HearingNotices/', '29 OF 2019.pdf', 'Admin'),
	(16, '12 OF 2019', '2019-11-23 12:54:02', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(17, '12 OF 2019', '2019-11-23 12:54:20', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(18, '12 OF 2019', '2019-11-23 12:54:27', NULL, 'HearingNotices/', '12 OF 2019.pdf', 'Admin'),
	(19, '31 OF 2019', '2019-11-29 10:28:40', '2019-11-29 10:29:11', 'HearingNotices/', '31 OF 2019.pdf', 'Admin'),
	(20, '32 OF 2019', '2019-12-02 16:20:59', '2019-12-02 16:21:13', 'HearingNotices/', '32 OF 2019.pdf', 'Admin');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.interestedparties: ~15 rows (approximately)
DELETE FROM `interestedparties`;
/*!40000 ALTER TABLE `interestedparties` DISABLE KEYS */;
INSERT INTO `interestedparties` (`ID`, `Name`, `ApplicationID`, `ContactName`, `Email`, `TelePhone`, `Mobile`, `PhysicalAddress`, `PostalCode`, `Town`, `POBox`, `Create_at`, `Update_at`, `Deleted`, `CreatedBy`, `UpdatedBy`, `Designation`) VALUES
	(1, 'INTERESTED PARTY LTD', 1, 'WILSON K', 'wkerebei@wilcom.co.ke', '0122718412', '0122718412', '2nd Floor, Elysee Plaza', '00101', 'Nairobi', '10123', '2019-11-11 15:58:40', NULL, 0, 'P0123456788X', NULL, NULL),
	(2, 'Wilcom Systems', 5, 'Elvis Kimutai', 'cmkikungu@gmail.com', '0701102928', '0701102928', 'Nairobi', '0701102928', 'Nairobi', '1234', '2019-11-12 11:21:59', NULL, 0, 'P0123456788X', NULL, NULL),
	(3, 'WilCom Systems Ltd', 6, 'WILSON K', 'wkerebei@gmail.com', '0722719412', '0722719412', 'P.O BOX 102678', '00101', 'Nairobi', '12', '2019-11-12 15:48:28', NULL, 0, 'P0123456788X', NULL, NULL),
	(4, 'WilCom Systems Ltd', 7, 'JAMES MOSH', 'wkerebei@gmail.com', '07227194121', '0722719412', 'P.O BOX 102678', '00101', 'Nairobi', '123', '2019-11-12 16:47:51', NULL, 0, 'P0123456788X', NULL, NULL),
	(5, 'WilCom Systems Ltd', 7, 'JAMES MOSH', 'wkerebei@gmail.com', '0722719412', '0722719412', 'P.O BOX 102678', '00101', 'Nairobi', '1233', '2019-11-12 17:21:56', NULL, 0, 'A123456789X', NULL, NULL),
	(6, 'Wilcom Systems', 10, 'Elvis Kimutai', 'cmkikungu@gmail.com', '0701102928', '0701102928', 'Nairobi', '0701102928', 'Nairobi', '123', '2019-11-13 11:55:33', NULL, 0, 'A123456789U', NULL, NULL),
	(7, 'Wilcom Syustems', 15, 'Elvis', 'ekimutai810@gmail.com', '0705555285', '0705555285', 'Nairobi', '30106', 'Nairobi', '123', '2019-11-13 18:30:00', NULL, 0, 'A123456789X', NULL, NULL),
	(8, 'ECTA KENYA LIMITED', 17, '224687', 'pjokumu@hotmail.com', '2389347457', '0734470491', 'Landmawe', '00100', 'Nairobi', '3456', '2019-11-15 12:05:39', NULL, 0, 'P65498745R', NULL, NULL),
	(9, 'Wilcom Syustems', 23, 'Elvis', 'ekimutai810@gmail.com', '0705555285', '0705555285', 'Nairobi', '30106', 'Nairobi', '123', '2019-11-20 14:41:21', NULL, 0, 'P09875345W', NULL, NULL),
	(10, 'Techsource Point Ltd', 25, 'Fred Ojurex', 'INFO@1234.COM', '010000000000', '01000000250', 'Muranga Road', '00101', 'Nairobi', '10101', '2019-11-21 14:31:41', NULL, 0, 'P0123456788X', NULL, 'DIRECTOR'),
	(11, 'KELVIN AND ASSOCIATES', 26, 'KELVIN C', 'kserem20@gmail.com', '0700392599', '0700392599', 'NAIROBI', '00101', 'NAIROBI', '3254', '2019-11-21 16:35:27', NULL, 0, 'P0123456788X', NULL, 'DIRECTOR'),
	(12, 'Home', 27, 'Interestd Partyu', 'cmkikungu@gmail.com', '0701102928', '0701102928', 'Nairobi', '1001', 'Nairobi', '123', '2019-11-21 21:19:13', NULL, 0, 'P0123456788X', NULL, 'Dr'),
	(13, 'Home', 28, 'Interested party', 'elviskimcheruiyot@gmail.com', '0705555285', '0705555285', 'Nairobi', '1001', 'Nairobi', '123', '2019-11-21 21:40:53', NULL, 0, 'P0123456788X', NULL, 'Dr'),
	(14, 'PPRA', 29, 'Sam Sam', 'x2press@gmail.com', '0721382630', '0721382630', 'Nairobi', '1001', 'Nairobi', '1234', '2019-11-22 11:20:27', NULL, 0, 'P123456879Q', NULL, 'Eng'),
	(15, 'Home', 25, 'Interestd Partyu', 'elviskimcheruiyot@gmail.com', '12345678899', '12345678977', 'Nairobi', '1001', 'Nairobi', '234', '2019-11-29 15:48:08', NULL, 0, 'A123456789X', NULL, 'Eng'),
	(16, 'Home', 36, 'Interestd Partyu', 'elviskimcheruiyot@gmail.com', '0705555285', '0705555285', 'Nairobi', '1001', 'Nairobi', '123', '2019-12-02 14:32:29', NULL, 0, 'P0123456788X', NULL, 'Dr');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.issuesfordetermination: ~22 rows (approximately)
DELETE FROM `issuesfordetermination`;
/*!40000 ALTER TABLE `issuesfordetermination` DISABLE KEYS */;
INSERT INTO `issuesfordetermination` (`ID`, `NO`, `ApplicationNo`, `Description`, `Created_At`, `Deleted`, `Created_By`, `Deleted_By`, `Deleted_At`) VALUES
	(6, 1, '7 OF 2019', '<p>Issues:&nbsp;rowsIssues:&nbsp;rowsIssues:&nbsp;rowsIssues:&nbsp;rows</p>\n', '2019-11-05 16:52:26', 1, 'Admin', NULL, NULL),
	(7, 1, '7 OF 2019', '<p>Issues:&nbsp;rowsIssues:&nbsp;rowsIssues:&nbsp;rowsIssues:&nbsp;rows</p>\n', '2019-11-05 17:03:04', 1, 'Admin', NULL, NULL),
	(8, 2, '7 OF 2019', '<p>Lorem ipsum dolor sit amet,&nbsp;</p>\n', '2019-11-05 17:03:49', 1, 'Admin', NULL, NULL),
	(9, 1, '7 OF 2019', '<p>Issues:&nbsp;rowsIssues:&nbsp;rowsIssues:&nbsp;rowsIssues:&nbsp;rows</p>\n', '2019-11-05 17:05:47', 1, 'Admin', NULL, NULL),
	(10, 1, '7 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n', '2019-11-06 15:10:12', 0, 'Admin', NULL, NULL),
	(11, 2, '7 OF 2019', '<p>Lorem ipsum dolor sit amet,&nbsp;</p>\n', '2019-11-06 15:10:20', 0, 'Admin', NULL, NULL),
	(12, 1, '11 OF 2019', '<p>Whereas Wilcom Systems the applicant herein has instituted a complaint against MINISTRY OF<br />\nEDUCATION (Procuring Entity or Director General) on 2019-11-11 (Date) particulars of which<br />\nwere set out in a Request for Review served upon you on 2019-11-11 .<br />\nYou are hereby required to appear on the 2019-11-11 at 8.00AM . when the complaint against you<br />\nwill be heard by this Board sitting at Mombasa,Room 1 .<br />\nIf you fail to appear,the Applicant may proceed with the complaint and determination by order of the<br />\nBoard may be made in your absence.</p>\n', '2019-11-11 11:57:44', 0, 'Admin', NULL, NULL),
	(13, 2, '11 OF 2019', '<p>Whereas Wilcom Systems the applicant herein has instituted a complaint against MINISTRY OF<br />\nEDUCATION (Procuring Entity or Director General) on 2019-11-11 (Date) particulars of which<br />\nwere set out in a Request for Review served upon you on 2019-11-11 .<br />\nYou are hereby required to appear on the 2019-11-11 at 8.00AM . when the complaint against you<br />\nwill be heard by this Board sitting at Mombasa,Room 1 .<br />\nIf you fail to appear,the Applicant may proceed with the complaint and determination by order of the<br />\nBoard may be made in your absence.</p>\n', '2019-11-11 11:57:50', 0, 'Admin', NULL, NULL),
	(14, 1, '18 OF 2019', '<p>Usue One</p>\n', '2019-11-15 13:51:54', 0, 'Admin', NULL, NULL),
	(15, 1, '18 OF 2019', '<p>dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nib</p>\n', '2019-11-15 14:00:14', 0, 'Admin', NULL, NULL),
	(16, 2, '18 OF 2019', '<p>dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nib</p>\n', '2019-11-15 14:00:23', 0, 'Admin', NULL, NULL),
	(17, 1, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:13:30', 0, 'Admin', NULL, NULL),
	(18, 2, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:20:35', 0, 'Admin', NULL, NULL),
	(19, 3, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:22:13', 0, 'Admin', NULL, NULL),
	(20, 4, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:29:43', 0, 'Admin', NULL, NULL),
	(21, 1, '16 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 12:15:40', 0, 'Admin', NULL, NULL),
	(22, 1, '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', '2019-11-20 16:36:32', 0, 'Admin', NULL, NULL),
	(23, 2, '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', '2019-11-20 16:36:39', 0, 'Admin', NULL, NULL),
	(24, 1, '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', '2019-11-21 18:42:06', 0, 'Admin', NULL, NULL),
	(25, 2, '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', '2019-11-21 18:42:12', 0, 'Admin', NULL, NULL),
	(26, 1, '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-22 14:11:29', 0, 'Admin', NULL, NULL),
	(27, 2, '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-22 14:11:34', 0, 'Admin', NULL, NULL),
	(28, 1, '12 OF 2019', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n', '2019-11-23 12:18:34', 0, 'Admin', NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.jrcontactusers: ~3 rows (approximately)
DELETE FROM `jrcontactusers`;
/*!40000 ALTER TABLE `jrcontactusers` DISABLE KEYS */;
INSERT INTO `jrcontactusers` (`ID`, `UserName`, `ApplicationNO`, `Role`, `Create_at`, `Update_at`, `Deleted`, `CreatedBy`, `UpdatedBy`) VALUES
	(15, 'Admin', '29 OF 2019', 'Chair', '2019-11-25 14:39:50', NULL, 1, 'Admin', NULL),
	(16, 'CASEOFFICER01', '29 OF 2019', 'Chair', '2019-11-25 14:40:25', NULL, 0, 'Admin', NULL),
	(17, 'Admin', '29 OF 2019', 'Chair', '2019-11-25 14:53:40', NULL, 0, 'Admin', NULL),
	(18, 'Admin', '29 OF 2019', 'Case Officer', '2019-11-25 15:19:03', NULL, 0, 'Admin', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.jrinterestedparties: ~0 rows (approximately)
DELETE FROM `jrinterestedparties`;
/*!40000 ALTER TABLE `jrinterestedparties` DISABLE KEYS */;
INSERT INTO `jrinterestedparties` (`ID`, `Name`, `ApplicationNO`, `ContactName`, `Email`, `TelePhone`, `Mobile`, `PhysicalAddress`, `PostalCode`, `Town`, `POBox`, `Create_at`, `Update_at`, `Deleted`, `CreatedBy`, `UpdatedBy`, `Designation`) VALUES
	(15, 'Home', '29 OF 2019', 'Interestd Partyu', 'elviskimcheruiyot@gmail.com', '1234567890', '1234567890', 'Nairobi', '1001', 'Nairobi', '123', '2019-11-25 13:35:21', NULL, 1, 'Admin', NULL, 'Dr');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.judicialreview: ~5 rows (approximately)
DELETE FROM `judicialreview`;
/*!40000 ALTER TABLE `judicialreview` DISABLE KEYS */;
INSERT INTO `judicialreview` (`ID`, `ApplicationNo`, `DateFilled`, `CaseNO`, `Description`, `Applicant`, `Court`, `Town`, `DateRecieved`, `DateofReplyingAffidavit`, `DateofCourtRulling`, `Ruling`, `Created_At`, `Created_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `Status`) VALUES
	(1, '19 OF 2019', '2019-11-19', '308', 'Case No 308', 'Wilcom Systems', 'HIGH COURT', 'NAIROBI', '2019-11-19 15:11:17', '2019-11-20', '2019-11-20', 'Done', '2019-11-19 15:11:17', 'Admin', 0, NULL, NULL, 'Successful'),
	(2, '19 OF 2019', '2019-11-19', '333', 'CAse 2', 'ddf', 'HIGH COURT', 'MOMBASA', '2019-11-19 15:15:22', '2019-11-20', '2019-11-20', 'Done', '2019-11-19 15:15:22', 'Admin', 0, NULL, NULL, 'Successful'),
	(3, '23 OF 2019', '2019-11-20', '110 OF 2019', 'SUPPLIER VS MINISTRY OF EDUCATION', 'SUPPLIER LTD', 'HIGH COURT', 'MOMBASA', '2019-11-21 18:56:34', '2019-11-21', '2019-11-20', 'N/A', '2019-11-21 18:56:34', 'Admin', 0, NULL, NULL, 'Successful'),
	(4, '29 OF 2019', '2019-11-22', '1234 of 2019', 'dolor sit amet, consectetuer', 'Lorem ipsum', 'HIGH COURT', 'NAIROBI', '2019-11-22 14:48:50', NULL, '2019-11-25', NULL, '2019-11-22 14:48:50', 'Admin', 0, NULL, NULL, 'Successful'),
	(5, '29 OF 2019', '2019-11-22', '345', 'WELCOME TO PPRA', 'WELCOME TO PPRA', 'HIGH COURT', 'MOMBASA', '2019-11-22 15:01:27', NULL, NULL, NULL, '2019-11-22 15:01:27', 'Admin', 0, NULL, NULL, 'In Progress'),
	(6, '29 OF 2019', '2019-11-25', '3455', 'WELCOME TO PPRA', 'WELCOME TO PPRA', 'HIGH COURT', 'BAHATI', '2019-11-18 00:00:00', NULL, NULL, NULL, '2019-11-25 12:12:59', 'Admin', 0, NULL, NULL, 'In Progress'),
	(7, '29 OF 2019', '2019-11-25', '345', 'WELCOME TO PPRA', 'WELCOME TO PPRA', 'HIGH COURT', 'BAHATI', '2019-11-25 00:00:00', NULL, NULL, NULL, '2019-11-25 15:19:03', 'Admin', 0, NULL, NULL, 'In Progress');
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=2048;

-- Dumping data for table arcm.judicialreviewdocuments: ~14 rows (approximately)
DELETE FROM `judicialreviewdocuments`;
/*!40000 ALTER TABLE `judicialreviewdocuments` DISABLE KEYS */;
INSERT INTO `judicialreviewdocuments` (`ID`, `ApplicationNo`, `Name`, `Description`, `Path`, `Created_At`, `Deleted`, `DocumentDate`, `ActionDate`, `ActionDescription`, `ActionSent`) VALUES
	(10, '19 OF 2019', '1574168768805-6 OF 2019.pdf', 'Document', 'http://74.208.157.60:3001/Documents', '2019-11-19 16:06:09', 1, NULL, NULL, NULL, 'Yes'),
	(11, '19 OF 2019', '1574168775654-6 OF 2019.pdf', 'Document', 'http://74.208.157.60:3001/Documents', '2019-11-19 16:06:15', 0, NULL, NULL, NULL, 'Yes'),
	(12, '19 OF 2019', '1574168778360-6 OF 2019.pdf', 'Document', 'http://74.208.157.60:3001/Documents', '2019-11-19 16:06:18', 1, NULL, NULL, NULL, 'Yes'),
	(13, '19 OF 2019', '1574168783358-6 OF 2019.pdf', 'Document', 'http://74.208.157.60:3001/Documents', '2019-11-19 16:06:23', 1, NULL, NULL, NULL, 'Yes'),
	(14, '19 OF 2019', '1574168884809-6 OF 2019.pdf', 'Document 1', 'http://74.208.157.60:3001/Documents', '2019-11-19 16:08:05', 1, NULL, NULL, NULL, 'Yes'),
	(15, '19 OF 2019', '1574169466675-6 OF 2019.pdf', 'Document', 'http://74.208.157.60:3001/Documents', '2019-11-19 16:17:46', 0, NULL, NULL, NULL, 'Yes'),
	(16, '19 OF 2019', '1574169469823-6 OF 2019.pdf', 'Document', 'http://74.208.157.60:3001/Documents', '2019-11-19 16:17:50', 0, NULL, NULL, NULL, 'Yes'),
	(17, '19 OF 2019', '1574248713777-6 OF 2019.pdf', 'Court Rulling', 'http://74.208.157.60:3001/Documents', '2019-11-20 14:18:34', 1, NULL, NULL, NULL, 'Yes'),
	(18, '23 OF 2019', '1574362587422-Request_for_review.pdf', 'NOTICE OF MOTION', 'http://74.208.157.60:3001/Documents', '2019-11-21 18:56:27', 0, NULL, NULL, NULL, 'Yes'),
	(19, '29 OF 2019', '1574434108206-6 OF 2019.pdf', 'Lorem ipsum dolor ', 'http://74.208.157.60:3001/Documents', '2019-11-22 14:48:28', 0, NULL, NULL, NULL, 'Yes'),
	(20, '29 OF 2019', '1574434121272-29 OF 2019.pdf', 'Desc 4', 'http://74.208.157.60:3001/Documents', '2019-11-22 14:48:41', 0, NULL, NULL, NULL, 'Yes'),
	(21, '29 OF 2019', '1574685999331-6 OF 2019.pdf', 'Desc 45', 'http://74.208.157.60:3001/Documents', '2019-11-25 15:46:39', 0, NULL, NULL, NULL, 'Yes'),
	(22, '29 OF 2019', '1574690561504-6 OF 2019.pdf', 'Desc 4', 'http://74.208.157.60:3001/Documents', '2019-11-25 17:02:41', 0, '2019-11-25', '2019-11-25', 'Send Document', 'Yes'),
	(23, '29 OF 2019', '1574690891461-6 OF 2019.pdf', 'Without Date', 'http://74.208.157.60:3001/Documents', '2019-11-25 17:08:11', 0, '2019-11-25', '2019-11-25', 'Without Date', 'Yes');
/*!40000 ALTER TABLE `judicialreviewdocuments` ENABLE KEYS */;

-- Dumping structure for procedure arcm.MarkcaseWithdrawalasfrivolous
DROP PROCEDURE IF EXISTS `MarkcaseWithdrawalasfrivolous`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MarkcaseWithdrawalasfrivolous`(IN _ApplicationNo varchar(50), IN _userID varchar(50))
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.membertypes: ~2 rows (approximately)
DELETE FROM `membertypes`;
/*!40000 ALTER TABLE `membertypes` DISABLE KEYS */;
INSERT INTO `membertypes` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(1, 'COMT-1', 'Default Member', '2019-08-05 16:11:21', 'Admin', '2019-08-05 16:11:21', 'Admin', 1, 'Admin'),
	(2, 'COMT-2', 'Default members', '2019-08-09 17:48:49', 'Admin', '2019-08-27 17:19:25', 'Admin', 0, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=665 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.notifications: ~51 rows (approximately)
DELETE FROM `notifications`;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`ID`, `Username`, `Category`, `Description`, `Created_At`, `DueDate`, `Status`, `ApplicationNo`) VALUES
	(593, 'Admin', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-11-28 16:59:15', '2019-12-01 16:59:15', 'Resolved', '30 OF 2019'),
	(594, 'CASEOFFICER01', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-11-28 16:59:15', '2019-12-01 16:59:15', 'Resolved', '30 OF 2019'),
	(595, 'PPRA01', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-11-28 16:59:15', '2019-12-01 16:59:15', 'Resolved', '30 OF 2019'),
	(596, 'Admin', 'Applications Fees Approval', 'Applications pending fees confirmaion', '2019-11-29 09:25:51', '2019-12-02 09:25:51', 'Resolved', '35'),
	(597, 'CASEOFFICER01', 'Applications Fees Approval', 'Applications pending fees confirmaion', '2019-11-29 09:25:51', '2019-12-02 09:25:51', 'Resolved', '35'),
	(599, 'Admin', 'Applications Approval', 'Applications pending approval', '2019-11-29 09:28:19', '2019-12-02 09:28:19', 'Resolved', '35'),
	(600, 'CASEOFFICER01', 'Applications Approval', 'Applications pending approval', '2019-11-29 09:28:19', '2019-12-02 09:28:19', 'Resolved', '35'),
	(602, 'Admin', 'Panel Formation', 'Applications Awating Panel Formation', '2019-11-29 09:59:45', '2019-12-02 09:59:45', 'Resolved', '31 OF 2019'),
	(603, 'CASEOFFICER01', 'Panel Formation', 'Applications Awating Panel Formation', '2019-11-29 09:59:45', '2019-12-02 09:59:45', 'Not Resolved', '31 OF 2019'),
	(605, 'Admin', 'Panel Approval', 'Panel Lists Awiting Approval', '2019-11-29 10:09:53', '2019-12-02 10:09:53', 'Resolved', '31 OF 2019'),
	(606, 'CASEOFFICER01', 'Panel Approval', 'Panel Lists Awiting Approval', '2019-11-29 10:09:53', '2019-12-02 10:09:53', 'Resolved', '31 OF 2019'),
	(608, 'Admin', 'Case Scheduling', 'Applications Hearing date scheduling', '2019-11-29 10:10:57', '2019-12-02 10:10:57', 'Resolved', '31 OF 2019'),
	(609, 'Admin', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-11-29 10:41:03', '2019-12-02 10:41:03', 'Resolved', '31 OF 2019'),
	(610, 'CASEOFFICER01', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-11-29 10:41:03', '2019-12-02 10:41:03', 'Resolved', '31 OF 2019'),
	(612, 'Admin', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-11-29 11:31:30', '2019-12-02 11:31:30', 'Resolved', '31 OF 2019'),
	(613, 'CASEOFFICER01', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-11-29 11:31:30', '2019-12-02 11:31:30', 'Resolved', '31 OF 2019'),
	(615, 'Admin', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-11-29 12:04:00', '2019-12-02 12:04:00', 'Resolved', '31 OF 2019'),
	(616, 'CASEOFFICER01', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-11-29 12:04:00', '2019-12-02 12:04:00', 'Resolved', '31 OF 2019'),
	(618, 'Admin', 'Deadline Approval', 'Deadline Approval Request', '2019-11-29 15:42:32', '2019-12-02 15:42:32', 'Resolved', '22 OF 2019'),
	(619, 'CASEOFFICER01', 'Deadline Approval', 'Deadline Approval Request', '2019-11-29 15:42:32', '2019-12-02 15:42:32', 'Resolved', '22 OF 2019'),
	(621, 'Admin', 'Preliminary Objecions Fees Approval', 'Preliminary objection fees pending confirmation', '2019-11-29 15:48:29', '2019-12-02 15:48:29', 'Not Resolved', '22 OF 2019'),
	(622, 'CASEOFFICER01', 'Preliminary Objecions Fees Approval', 'Preliminary objection fees pending confirmation', '2019-11-29 15:48:29', '2019-12-02 15:48:29', 'Not Resolved', '22 OF 2019'),
	(624, 'Admin', 'Panel Formation', 'Applications Awating Panel Formation', '2019-11-29 15:49:40', '2019-12-02 15:49:40', 'Not Resolved', '25'),
	(625, 'CASEOFFICER01', 'Panel Formation', 'Applications Awating Panel Formation', '2019-11-29 15:49:40', '2019-12-02 15:49:40', 'Not Resolved', '25'),
	(626, 'Admin', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 09:45:16', '2019-12-05 09:45:16', 'Resolved', '30 OF 2019'),
	(627, 'CASEOFFICER01', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 09:45:16', '2019-12-05 09:45:16', 'Resolved', '30 OF 2019'),
	(628, 'Admin', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 13:45:06', '2019-12-05 13:45:06', 'Resolved', '30 OF 2019'),
	(629, 'CASEOFFICER01', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 13:45:06', '2019-12-05 13:45:06', 'Resolved', '30 OF 2019'),
	(631, 'Admin', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 14:24:04', '2019-12-05 14:24:04', 'Resolved', '30 OF 2019'),
	(632, 'CASEOFFICER01', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 14:24:04', '2019-12-05 14:24:04', 'Resolved', '30 OF 2019'),
	(634, 'Admin', 'Applications Fees Approval', 'Applications pending fees confirmaion', '2019-12-02 14:34:34', '2019-12-05 14:34:34', 'Resolved', '36'),
	(635, 'CASEOFFICER01', 'Applications Fees Approval', 'Applications pending fees confirmaion', '2019-12-02 14:34:34', '2019-12-05 14:34:34', 'Resolved', '36'),
	(637, 'Admin', 'Applications Fees Approval', 'Applications pending fees confirmaion', '2019-12-02 14:35:08', '2019-12-05 14:35:08', 'Resolved', '36'),
	(638, 'CASEOFFICER01', 'Applications Fees Approval', 'Applications pending fees confirmaion', '2019-12-02 14:35:08', '2019-12-05 14:35:08', 'Resolved', '36'),
	(640, 'Admin', 'Applications Approval', 'Applications pending approval', '2019-12-02 14:52:10', '2019-12-05 14:52:10', 'Resolved', '36'),
	(641, 'CASEOFFICER01', 'Applications Approval', 'Applications pending approval', '2019-12-02 14:52:10', '2019-12-05 14:52:10', 'Resolved', '36'),
	(643, 'Admin', 'Deadline Approval', 'Deadline Approval Request', '2019-12-02 15:13:49', '2019-12-05 15:13:49', 'Resolved', '32 OF 2019'),
	(644, 'CASEOFFICER01', 'Deadline Approval', 'Deadline Approval Request', '2019-12-02 15:13:49', '2019-12-05 15:13:49', 'Resolved', '32 OF 2019'),
	(646, 'Admin', 'Preliminary Objecions Fees Approval', 'Preliminary objection fees pending confirmation', '2019-12-02 15:59:16', '2019-12-05 15:59:16', 'Resolved', '32 OF 2019'),
	(647, 'CASEOFFICER01', 'Preliminary Objecions Fees Approval', 'Preliminary objection fees pending confirmation', '2019-12-02 15:59:16', '2019-12-05 15:59:16', 'Resolved', '32 OF 2019'),
	(649, 'Admin', 'Preliminary Objecions Fees Approval', 'Preliminary objection fees pending confirmation', '2019-12-02 16:03:45', '2019-12-05 16:03:45', 'Resolved', '32 OF 2019'),
	(650, 'CASEOFFICER01', 'Preliminary Objecions Fees Approval', 'Preliminary objection fees pending confirmation', '2019-12-02 16:03:45', '2019-12-05 16:03:45', 'Resolved', '32 OF 2019'),
	(652, 'Admin', 'Panel Formation', 'Applications Awating Panel Formation', '2019-12-02 16:04:38', '2019-12-05 16:04:38', 'Resolved', '32 OF 2019'),
	(653, 'CASEOFFICER01', 'Panel Formation', 'Applications Awating Panel Formation', '2019-12-02 16:04:38', '2019-12-05 16:04:38', 'Resolved', '32 OF 2019'),
	(655, 'Admin', 'Panel Approval', 'Panel Lists Awiting Approval', '2019-12-02 16:19:35', '2019-12-05 16:19:35', 'Resolved', '32 OF 2019'),
	(656, 'CASEOFFICER01', 'Panel Approval', 'Panel Lists Awiting Approval', '2019-12-02 16:19:35', '2019-12-05 16:19:35', 'Resolved', '32 OF 2019'),
	(658, 'PPRA01', 'Case Scheduling', 'Applications Hearing date scheduling', '2019-12-02 16:20:08', '2019-12-05 16:20:08', 'Resolved', '32 OF 2019'),
	(659, 'Admin', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-12-02 16:37:38', '2019-12-05 16:37:38', 'Resolved', '32 OF 2019'),
	(660, 'CASEOFFICER01', 'Case Adjournment Approval', 'Case Adjournment pending approval', '2019-12-02 16:37:38', '2019-12-05 16:37:38', 'Resolved', '32 OF 2019'),
	(662, 'Admin', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 16:44:01', '2019-12-05 16:44:01', 'Resolved', '32 OF 2019'),
	(663, 'CASEOFFICER01', 'Case withdrawal Approval', 'Case withdrawal pending approval', '2019-12-02 16:44:01', '2019-12-05 16:44:01', 'Resolved', '32 OF 2019');
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

-- Dumping data for table arcm.panelapprovalcontacts: ~4 rows (approximately)
DELETE FROM `panelapprovalcontacts`;
/*!40000 ALTER TABLE `panelapprovalcontacts` DISABLE KEYS */;
INSERT INTO `panelapprovalcontacts` (`Name`, `Email`, `Mobile`, `Msg`, `ApplicationNo`) VALUES
	('WILSON B. KEREBEI', 'wkerebei@gmail.com1', '07227194121', 'Case Officer', '32 OF 2019'),
	('Elvis kimutai', 'elviskcheruiyot@gmail.com', '0705555285', 'Panel', '32 OF 2019'),
	('CASE OFFICER', 'cmkikungu@gmail.com1', '070110292812', 'Panel', '32 OF 2019'),
	('WILSON B. KEREBEI', 'wkerebei@gmail.com1', '07227194121', 'Panel', '32 OF 2019');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.panellist: ~2 rows (approximately)
DELETE FROM `panellist`;
/*!40000 ALTER TABLE `panellist` DISABLE KEYS */;
INSERT INTO `panellist` (`ID`, `ApplicationNo`, `Path`, `FileName`, `GeneratedOn`, `GeneratedBy`) VALUES
	(1, '17 OF 2019', 'PanelLists/', '17 OF 2019.pdf', '2019-11-20 12:48:05', 'Admin'),
	(2, '29 OF 2019', 'PanelLists/', '29 OF 2019.pdf', '2019-11-22 15:34:01', 'Admin');
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.panels: ~20 rows (approximately)
DELETE FROM `panels`;
/*!40000 ALTER TABLE `panels` DISABLE KEYS */;
INSERT INTO `panels` (`ID`, `ApplicationNo`, `UserName`, `Status`, `Role`, `Deleted`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`) VALUES
	(23, '20 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-20 16:05:35', 'Admin', NULL, NULL),
	(24, '20 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-20 16:05:38', 'Admin', NULL, NULL),
	(25, '20 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-20 16:05:40', 'Admin', NULL, NULL),
	(26, '23 OF 2019', 'Admin', 'Approved', 'Member', 1, '2019-11-21 18:18:02', 'Admin', NULL, NULL),
	(27, '23 OF 2019', 'Admin', 'Approved', 'Member', 1, '2019-11-21 18:21:34', 'Admin', NULL, NULL),
	(28, '23 OF 2019', 'CASEOFFICER01', 'Approved', 'Chairperson', 1, '2019-11-21 18:21:42', 'Admin', NULL, NULL),
	(29, '23 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-21 18:22:37', 'Admin', NULL, NULL),
	(30, '23 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-21 18:23:39', 'Admin', NULL, NULL),
	(31, '23 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-21 18:23:50', 'Admin', NULL, NULL),
	(32, '23 OF 2019', 'smiheso', 'Approved', 'Member', 0, '2019-11-21 18:33:24', 'Admin', NULL, NULL),
	(33, '28 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-21 21:59:00', 'Admin', NULL, NULL),
	(34, '28 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-21 21:59:03', 'Admin', NULL, NULL),
	(35, '28 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-21 21:59:07', 'Admin', NULL, NULL),
	(36, '29 OF 2019', 'SOdhiambo', 'Approved', 'Chairperson', 0, '2019-11-22 12:56:48', 'Admin', NULL, NULL),
	(37, '29 OF 2019', 'smiheso', 'Approved', 'Vice Chairperson', 0, '2019-11-22 12:56:55', 'Admin', NULL, NULL),
	(38, '29 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-22 12:57:40', 'Admin', NULL, NULL),
	(39, '29 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-22 13:29:02', 'Admin', NULL, NULL),
	(40, '12 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-23 12:27:12', 'Admin', NULL, NULL),
	(41, '12 OF 2019', 'PPRA01', 'Approved', 'Chairperson', 0, '2019-11-23 12:27:16', 'Admin', NULL, NULL),
	(42, '12 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-23 12:27:24', 'Admin', NULL, NULL),
	(43, '30 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-28 16:06:52', 'Admin', NULL, NULL),
	(44, '30 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-28 16:06:55', 'Admin', NULL, NULL),
	(45, '30 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-28 16:06:58', 'Admin', NULL, NULL),
	(46, '31 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-29 10:09:41', 'Admin', NULL, NULL),
	(47, '31 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-29 10:09:44', 'Admin', NULL, NULL),
	(48, '31 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-29 10:09:47', 'Admin', NULL, NULL),
	(49, '32 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-12-02 16:19:21', 'Admin', NULL, NULL),
	(50, '32 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-12-02 16:19:26', 'Admin', NULL, NULL),
	(51, '32 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-12-02 16:19:29', 'Admin', NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=1638;

-- Dumping data for table arcm.panelsapprovalworkflow: ~47 rows (approximately)
DELETE FROM `panelsapprovalworkflow`;
/*!40000 ALTER TABLE `panelsapprovalworkflow` DISABLE KEYS */;
INSERT INTO `panelsapprovalworkflow` (`ID`, `ApplicationNo`, `UserName`, `Status`, `Role`, `Deleted`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Approver`, `Approved_At`) VALUES
	(32, '20 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-20 16:05:35', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:07:30'),
	(33, '20 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-20 16:05:38', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:07:32'),
	(34, '20 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-20 16:05:40', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:07:34'),
	(35, '20 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-20 16:05:35', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:13:16'),
	(36, '20 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-20 16:05:38', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:13:16'),
	(37, '20 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-20 16:05:40', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:13:16'),
	(38, '20 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-20 16:05:35', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:17:19'),
	(39, '20 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-20 16:05:38', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:17:19'),
	(40, '20 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-20 16:05:40', 'Admin', NULL, NULL, 'Admin', '2019-11-20 16:17:19'),
	(41, '23 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-21 18:22:37', 'Admin', NULL, NULL, 'Admin', '2019-11-21 18:25:51'),
	(42, '23 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-21 18:23:39', 'Admin', NULL, NULL, 'Admin', '2019-11-21 18:25:54'),
	(43, '23 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-21 18:23:50', 'Admin', NULL, NULL, 'Admin', '2019-11-21 18:25:57'),
	(44, '23 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-21 18:22:37', 'Admin', NULL, NULL, 'Admin', '2019-11-21 18:33:50'),
	(45, '23 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-21 18:23:39', 'Admin', NULL, NULL, 'Admin', '2019-11-21 18:33:50'),
	(46, '23 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-21 18:23:50', 'Admin', NULL, NULL, 'Admin', '2019-11-21 18:33:50'),
	(47, '23 OF 2019', 'smiheso', 'Approved', 'Member', 0, '2019-11-21 18:33:24', 'Admin', NULL, NULL, 'Admin', '2019-11-21 18:33:46'),
	(51, '28 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-21 21:59:00', 'Admin', NULL, NULL, 'Admin', '2019-11-21 21:59:20'),
	(52, '28 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-21 21:59:03', 'Admin', NULL, NULL, 'Admin', '2019-11-21 21:59:22'),
	(53, '28 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-21 21:59:07', 'Admin', NULL, NULL, 'Admin', '2019-11-21 21:59:25'),
	(54, '29 OF 2019', 'SOdhiambo', 'Approved', 'Chairperson', 0, '2019-11-22 12:56:48', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:00:34'),
	(55, '29 OF 2019', 'smiheso', 'Approved', 'Vice Chairperson', 0, '2019-11-22 12:56:55', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:00:40'),
	(56, '29 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-22 12:57:40', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:00:42'),
	(57, '29 OF 2019', 'SOdhiambo', 'Approved', 'Chairperson', 0, '2019-11-22 12:56:48', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:29:34'),
	(58, '29 OF 2019', 'smiheso', 'Approved', 'Vice Chairperson', 0, '2019-11-22 12:56:55', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:29:34'),
	(59, '29 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-22 12:57:40', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:29:34'),
	(60, '29 OF 2019', 'SOdhiambo', 'Approved', 'Chairperson', 0, '2019-11-22 12:56:48', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:29:34'),
	(61, '29 OF 2019', 'smiheso', 'Approved', 'Vice Chairperson', 0, '2019-11-22 12:56:55', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:29:34'),
	(62, '29 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-22 12:57:40', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:29:34'),
	(63, '29 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-22 13:29:02', 'Admin', NULL, NULL, 'Admin', '2019-11-22 13:29:32'),
	(67, '12 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-23 12:27:12', 'Admin', NULL, NULL, 'Admin', '2019-11-23 12:27:39'),
	(68, '12 OF 2019', 'PPRA01', 'Approved', 'Chairperson', 0, '2019-11-23 12:27:16', 'Admin', NULL, NULL, 'Admin', '2019-11-23 12:27:41'),
	(69, '12 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-23 12:27:24', 'Admin', NULL, NULL, 'Admin', '2019-11-23 12:27:44'),
	(70, '12 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-23 12:27:12', 'Admin', NULL, NULL, 'Admin', '2019-11-23 12:31:01'),
	(71, '12 OF 2019', 'PPRA01', 'Approved', 'Chairperson', 0, '2019-11-23 12:27:16', 'Admin', NULL, NULL, 'Admin', '2019-11-23 12:31:01'),
	(72, '12 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-23 12:27:24', 'Admin', NULL, NULL, 'Admin', '2019-11-23 12:31:01'),
	(73, '28 OF 2019', 'Admin', 'Pending Approval', 'Member', 0, '2019-11-21 21:59:00', 'Admin', NULL, NULL, NULL, NULL),
	(74, '28 OF 2019', 'CASEOFFICER01', 'Pending Approval', 'Member', 0, '2019-11-21 21:59:03', 'Admin', NULL, NULL, NULL, NULL),
	(75, '28 OF 2019', 'PPRA01', 'Pending Approval', 'Member', 0, '2019-11-21 21:59:07', 'Admin', NULL, NULL, NULL, NULL),
	(76, '30 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-28 16:06:52', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:02'),
	(77, '30 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-28 16:06:55', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:31'),
	(78, '30 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-28 16:06:58', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:40'),
	(79, '30 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-28 16:06:52', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:02'),
	(80, '30 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-28 16:06:55', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:31'),
	(81, '30 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-28 16:06:58', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:40'),
	(82, '30 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-28 16:06:52', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:02'),
	(83, '30 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-28 16:06:55', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:31'),
	(84, '30 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-28 16:06:58', 'Admin', NULL, NULL, 'Admin', '2019-11-28 16:09:40'),
	(85, '31 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-11-29 10:09:41', 'Admin', NULL, NULL, 'Admin', '2019-11-29 10:10:51'),
	(86, '31 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-11-29 10:09:44', 'Admin', NULL, NULL, 'Admin', '2019-11-29 10:10:53'),
	(87, '31 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-11-29 10:09:47', 'Admin', NULL, NULL, 'Admin', '2019-11-29 10:10:55'),
	(88, '32 OF 2019', 'Admin', 'Approved', 'Member', 0, '2019-12-02 16:19:21', 'Admin', NULL, NULL, 'Admin', '2019-12-02 16:20:02'),
	(89, '32 OF 2019', 'CASEOFFICER01', 'Approved', 'Member', 0, '2019-12-02 16:19:26', 'Admin', NULL, NULL, 'Admin', '2019-12-02 16:20:03'),
	(90, '32 OF 2019', 'PPRA01', 'Approved', 'Member', 0, '2019-12-02 16:19:29', 'Admin', NULL, NULL, 'Admin', '2019-12-02 16:20:06');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=4096;

-- Dumping data for table arcm.partysubmision: ~15 rows (approximately)
DELETE FROM `partysubmision`;
/*!40000 ALTER TABLE `partysubmision` DISABLE KEYS */;
INSERT INTO `partysubmision` (`ID`, `Party`, `ApplicationNo`, `Description`, `Created_At`, `Deleted`, `Created_By`, `Deleted_By`, `Deleted_At`) VALUES
	(8, 'PE', '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 14:59:12', 1, 'Admin', NULL, NULL),
	(9, 'Applicant', '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 14:59:24', 1, 'Admin', NULL, NULL),
	(10, 'PE', '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:29:56', 0, 'Admin', NULL, NULL),
	(11, 'Applicant', '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:30:00', 1, 'Admin', NULL, NULL),
	(12, 'Interested Party', '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 15:30:05', 0, 'Admin', NULL, NULL),
	(13, 'PE', '16 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 12:15:33', 0, 'Admin', NULL, NULL),
	(14, 'PE', '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', '2019-11-20 16:36:16', 0, 'Admin', NULL, NULL),
	(15, 'Applicant', '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum f</p>\n', '2019-11-20 16:36:21', 0, 'Admin', NULL, NULL),
	(16, 'PE', '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', '2019-11-21 18:41:27', 0, 'Admin', NULL, NULL),
	(17, 'Applicant', '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', '2019-11-21 18:41:36', 0, 'Admin', NULL, NULL),
	(18, 'Interested Party', '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', '2019-11-21 18:41:43', 0, 'Admin', NULL, NULL),
	(19, 'Applicant Rejoinder', '23 OF 2019', '<ol>\n	<li><strong>Add ACCOUNTING OFFICER &ndash; to the PE in all reports and Notices</strong></li>\n</ol>\n\n<ol>\n	<li><strong>Panel Approval &ndash; Add a Check Box for approval of all panelists at once</strong></li>\n</ol>\n', '2019-11-21 18:41:54', 0, 'Admin', NULL, NULL),
	(20, 'Applicant', '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-22 14:09:14', 0, 'Admin', NULL, NULL),
	(21, 'Interested Party', '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-22 14:09:21', 0, 'Admin', NULL, NULL),
	(22, 'Applicant Rejoinder', '29 OF 2019', '<p>orem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-22 14:09:29', 0, 'Admin', NULL, NULL),
	(23, 'PE', '12 OF 2019', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n', '2019-11-23 12:18:24', 0, 'Admin', NULL, NULL),
	(24, 'Applicant', '12 OF 2019', '<p>M/s Mason Services Limited &amp; Qntra Technology Limited (hereinafter referred to as &ldquo;the Applicant&rdquo;) lodged a Request for Review dated and filed on 11th January 2019 (hereinafter referred to as &ldquo;the Request for Review&rdquo;) together with a Statement in support of the Request for Review filed on even date (hereinafter referred to as &ldquo;the Applicant&rsquo;s Statement&rdquo;) and written submissions dated and filed on 21st January 2019 (hereinafter referred to as &ldquo;the Applicant&rsquo;s written submissions&rdquo;).</p>\n', '2019-11-23 12:18:28', 0, 'Admin', NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AVG_ROW_LENGTH=5461;

-- Dumping data for table arcm.paymentdetails: ~31 rows (approximately)
DELETE FROM `paymentdetails`;
/*!40000 ALTER TABLE `paymentdetails` DISABLE KEYS */;
INSERT INTO `paymentdetails` (`ID`, `ApplicationID`, `Paidby`, `Refference`, `DateOfpayment`, `AmountPaid`, `Created_By`, `Created_At`, `Category`, `PaymentType`, `ChequeDate`, `CHQNO`) VALUES
	(1, 1, 'wk', 'PYMREF00001', '2019-11-11', 28800, 'P0123456788X', '2019-11-11 16:10:58', 'Applicationfees', NULL, NULL, NULL),
	(2, 5, 'Elvis kimutai', '0987656544322', '2019-11-12', 15000, 'P0123456788X', '2019-11-12 11:24:36', 'Applicationfees', NULL, NULL, NULL),
	(3, 6, 'ALVIN', 'REFD00002', '2019-11-11', 26000, 'P0123456788X', '2019-11-12 15:51:39', 'Applicationfees', NULL, NULL, NULL),
	(4, 7, 'ALVIN', 'REFD00003', '2019-11-12', 45000, 'P0123456788X', '2019-11-12 16:52:41', 'Applicationfees', NULL, NULL, NULL),
	(5, 7, 'wk', 'REFD00004', '2019-11-12', 5000, 'A123456789X', '2019-11-12 17:25:08', 'PreliminaryObjectionsFees', NULL, NULL, NULL),
	(6, 10, 'Elvis kimutai', '0987656544322', '2019-11-13', 25000, 'P0123456788X', '2019-11-13 11:20:13', 'Applicationfees', NULL, NULL, NULL),
	(7, 10, 'Elvis kimutai', '0987656544322', '2019-11-13', 25000, 'P0123456788X', '2019-11-13 11:21:59', 'Applicationfees', NULL, NULL, NULL),
	(8, 10, 'Elvis kimutai', '0987656544322', '2019-11-13', 25000, 'P0123456788X', '2019-11-13 11:24:41', 'Applicationfees', NULL, NULL, NULL),
	(9, 10, 'Elvis kimutai', '0987656544322', '2019-11-13', 5000, 'A123456789U', '2019-11-13 11:56:03', 'PreliminaryObjectionsFees', NULL, NULL, NULL),
	(10, 15, 'Elvis', 'REF124', '2019-11-20', 5000, 'P09875345W', '2019-11-13 17:19:00', 'Applicationfees', NULL, NULL, NULL),
	(11, 14, 'Kim', '123', '2019-11-13', 5000, 'P09875345W', '2019-11-13 17:49:22', 'Applicationfees', NULL, NULL, NULL),
	(12, 15, 'KIM', 'REF123', '2019-11-13', 5000, 'A123456789X', '2019-11-13 18:30:45', 'PreliminaryObjectionsFees', NULL, NULL, NULL),
	(13, 15, 'KIM', 'REF123', '2019-11-13', 5000, 'A123456789X', '2019-11-13 18:34:00', 'PreliminaryObjectionsFees', NULL, NULL, NULL),
	(14, 16, 'Kimutai Elvis', '123344', '2019-11-14', 25000, 'P0123456788X', '2019-11-14 14:46:35', 'Applicationfees', NULL, NULL, NULL),
	(15, 17, 'Judy J', 'REF0000015', '2019-11-15', 310500, 'P123456879Q', '2019-11-15 11:10:01', 'Applicationfees', NULL, NULL, NULL),
	(16, 18, 'Kim', '12344', '2019-11-15', 15000, 'P0123456788X', '2019-11-15 11:50:57', 'Applicationfees', NULL, NULL, NULL),
	(17, 23, 'Kimutai', 'REF!234', '2019-11-20', 73000, 'P09875345W', '2019-11-20 14:42:09', 'Applicationfees', NULL, NULL, NULL),
	(18, 23, 'Kimutai', 'REF!234', '2019-11-20', 5000, 'A123456789X', '2019-11-20 15:19:25', 'PreliminaryObjectionsFees', NULL, NULL, NULL),
	(19, 23, 'Kimutai', 'REF!234', '2019-11-20', 1000, 'A123456789X', '2019-11-20 15:23:48', 'PreliminaryObjectionsFees', NULL, NULL, NULL),
	(20, 24, 'ALVIN', 'REFD00002', '2019-11-20', 15000, 'P0123456788X', '2019-11-21 14:16:39', 'Applicationfees', NULL, NULL, NULL),
	(21, 25, 'ALVIN', 'REF0000045', '2019-11-20', 15000, 'P0123456788X', '2019-11-21 14:33:52', 'Applicationfees', NULL, NULL, NULL),
	(22, 26, 'WK', 'REFD00004', '2019-11-21', 200000, 'P0123456788X', '2019-11-21 16:46:17', 'Applicationfees', 2, '', ''),
	(23, 26, 'WK', 'REF1254784', '2019-11-20', 5000, 'P0123456788X', '2019-11-21 16:49:18', 'Applicationfees', 4, '2019-11-20', '00001'),
	(24, 27, 'Kim', '1234', '2019-11-21', 25000, 'P0123456788X', '2019-11-21 21:21:42', 'Applicationfees', 4, '2019-11-21', '035'),
	(25, 28, 'Kim', '1234', '2019-11-21', 15000, 'P0123456788X', '2019-11-21 21:41:49', 'Applicationfees', 1, '', ''),
	(26, 30, 'kimutai', 'REf10002', '2019-11-22', 205000, 'P123456879Q', '2019-11-22 11:35:32', 'Applicationfees', 2, '', ''),
	(27, 31, '0705555284', '1234', '2019-11-26', 10000, 'P0123456788X', '2019-11-26 14:37:04', 'Applicationfees', 1, '', ''),
	(28, 32, 'Kim', '1234', '2019-11-26', 25007, 'P0123456788X', '2019-11-26 15:21:50', 'Applicationfees', 1, '', ''),
	(29, 33, 'Kim', '1234', '2019-11-28', 70000, 'P0123456788X', '2019-11-28 15:42:57', 'Applicationfees', 1, '', ''),
	(30, 34, 'Kim', '1234', '2019-11-28', 32500, 'P0123456788X', '2019-11-28 15:51:25', 'Applicationfees', 3, '', ''),
	(31, 35, 'Kim Elvis', '1000267', '2019-11-29', 26500, 'P0123456788X', '2019-11-29 09:25:51', 'Applicationfees', 4, '2019-11-29', '035'),
	(32, 25, 'Kim', '1234', '2019-11-29', 5000, 'A123456789X', '2019-11-29 15:48:29', 'PreliminaryObjectionsFees', 1, '', ''),
	(33, 36, 'Kim', '1234', '2019-12-02', 12000, 'P0123456788X', '2019-12-02 14:34:34', 'Applicationfees', 1, '', ''),
	(34, 36, 'Kim', '1234', '2019-12-02', 5000, 'P0123456788X', '2019-12-02 14:35:08', 'Applicationfees', 4, '2019-12-02', '035'),
	(35, 36, 'Kim', '1234', '2019-12-02', 4000, 'A123456789X', '2019-12-02 15:59:16', 'PreliminaryObjectionsFees', 1, '', ''),
	(36, 36, 'Kim', '1234', '2019-12-02', 1000, 'A123456789X', '2019-12-02 16:03:45', 'PreliminaryObjectionsFees', 1, '', '');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.pedeadlineextensionsrequests: ~2 rows (approximately)
DELETE FROM `pedeadlineextensionsrequests`;
/*!40000 ALTER TABLE `pedeadlineextensionsrequests` DISABLE KEYS */;
INSERT INTO `pedeadlineextensionsrequests` (`ID`, `PEID`, `ApplicationNo`, `Reason`, `RequestedDate`, `Created_At`, `Created_By`, `Status`) VALUES
	(4, 'PE-2', '28 OF 2019', '<p>pedeadlineextensionsrequests</p>\n', '2019-11-28 00:00:00', '2019-11-28 11:39:11', 'A123456789X', 'Fully Approved'),
	(5, 'PE-2', '22 OF 2019', '<p>682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712682712</p>\n', '2019-11-29 00:00:00', '2019-11-29 15:42:31', 'A123456789X', 'DECLINED'),
	(6, 'PE-2', '32 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', '2019-12-23 00:00:00', '2019-12-02 15:13:49', 'A123456789X', 'Fully Approved');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponse: ~13 rows (approximately)
DELETE FROM `peresponse`;
/*!40000 ALTER TABLE `peresponse` DISABLE KEYS */;
INSERT INTO `peresponse` (`ID`, `ApplicationNo`, `PEID`, `ResponseType`, `ResponseDate`, `Created_By`, `Created_At`, `Status`, `PanelStatus`) VALUES
	(1, '12 OF 2019', 'PE-2', 'Memorandum of Response', '2019-11-11 17:39:01', 'A123456789X', '2019-11-11 17:39:01', 'Submited', 'Submited'),
	(2, '13 OF 2019', 'PE-3', 'Memorandum of Response', '2019-11-12 14:40:06', 'A123456789U', '2019-11-12 14:40:06', 'Submited', 'Undefined'),
	(3, '15 OF 2019', 'PE-2', 'Preliminary Objection', '2019-11-12 17:19:56', 'A123456789X', '2019-11-12 17:19:56', 'Submited', 'Undefined'),
	(4, '16 OF 2019', 'PE-3', 'Preliminary Objection', '2019-11-13 11:53:34', 'A123456789U', '2019-11-13 11:53:34', 'Submited', 'Submited'),
	(5, '17 OF 2019', 'PE-2', 'Preliminary Objection', '2019-11-13 18:28:46', 'A123456789X', '2019-11-13 18:28:46', 'Fees Pending Confirmation', 'Submited'),
	(6, '18 OF 2019', 'PE-4', 'Memorandum of Response', '2019-11-15 12:01:35', 'P65498745R', '2019-11-15 12:01:35', 'Submited', 'Submited'),
	(7, '20 OF 2019', 'PE-2', 'Preliminary Objection', '2019-11-20 15:16:48', 'A123456789X', '2019-11-20 15:16:48', 'Submited', 'Submited'),
	(8, '23 OF 2019', 'PE-2', 'Memorandum of Response', '2019-11-21 17:34:10', 'A123456789X', '2019-11-21 17:34:10', 'Submited', 'Submited'),
	(9, '29 OF 2019', 'PE-4', 'Memorandum of Response', '2019-11-22 12:18:20', 'P65498745R', '2019-11-22 12:18:20', 'Submited', 'Submited'),
	(10, '28 OF 2019', 'PE-2', 'Memorandum of Response', '2019-11-28 16:06:03', 'A123456789X', '2019-11-28 16:06:03', 'Submited', 'Undefined'),
	(11, '31 OF 2019', 'PE-2', 'Memorandum of Response', '2019-11-29 09:59:06', 'A123456789X', '2019-11-29 09:59:06', 'Submited', 'Submited'),
	(12, '22 OF 2019', 'PE-2', 'Preliminary Objection', '2019-11-29 15:47:22', 'A123456789X', '2019-11-29 15:47:22', 'Submited', 'Undefined'),
	(13, '32 OF 2019', 'PE-2', 'Preliminary Objection', '2019-12-02 15:58:21', 'A123456789X', '2019-12-02 15:58:21', 'Submited', 'Submited');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsebackgroundinformation: ~11 rows (approximately)
DELETE FROM `peresponsebackgroundinformation`;
/*!40000 ALTER TABLE `peresponsebackgroundinformation` DISABLE KEYS */;
INSERT INTO `peresponsebackgroundinformation` (`ID`, `ApplicationNo`, `BackgroundInformation`, `ResponseType`, `Created_At`, `Updated_At`, `Updated_By`, `Created_By`) VALUES
	(1, '13 OF 2019', '<p><strong>Note:</strong>&nbsp;The INNER JOIN keyword selects all rows from both tables as long as there is a match between the columns. If there are records in the &quot;Orders&quot; table that do not have matches in &quot;Customers&quot;, these orders will not be shown!</p>\n', 'Memorandum of Response', '2019-11-12 14:20:43', '2019-11-12 14:43:37', 'A123456789U', NULL),
	(2, '15 OF 2019', '<p>Review against the decision of the Principal Secretary, State Department of Irrigation and the award of Tender No: MALF &amp; I/SDI/OT/04/2018-2019 for Procurement of Construction of Kaigunji Irrigation Project Phase II Section One.</p>\n', 'Preliminary Objection', '2019-11-12 17:19:23', NULL, NULL, 'A123456789X'),
	(3, '16 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.</p>\n', 'Preliminary Objection', '2019-11-13 11:46:28', NULL, NULL, 'A123456789U'),
	(4, '17 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', 'Preliminary Objection', '2019-11-13 18:28:40', NULL, NULL, 'A123456789X'),
	(5, '18 OF 2019', '<p>We procured for motor vehicle for government agencies and ministries</p>\n', 'Memorandum of Response', '2019-11-15 12:00:02', NULL, NULL, 'P65498745R'),
	(6, '12 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,</p>\n', 'Preliminary Objection', '2019-11-16 11:51:46', '2019-11-16 13:37:15', 'A123456789X', 'A123456789X'),
	(7, '20 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', 'Preliminary Objection', '2019-11-20 15:04:19', '2019-11-20 15:12:30', 'A123456789X', 'A123456789X'),
	(8, '23 OF 2019', '<p>On behalf of the Procuring Entity, Mr. Rapando fully relied on its Response to Request for Review No. 78/2019 and Response to Request for Review No. 79 of 2019, both dated and filed on 1st August 2019.<br />\nMr Rapando submitted that the Procuring Entity opposed the joining of the 2nd Respondent as a party to both review applications, contrary to section 170 of the Act and the same should be struck off forthwith.</p>\n', 'Memorandum of Response', '2019-11-21 17:33:51', NULL, NULL, 'A123456789X'),
	(9, '27 OF 2019', '<p>The source is corresponding to &#39;PBS NewsHour, PBS NewsHour, Rivet&#39; I Think inverted comma is missing which leads to 12 values instead of 14&nbsp;&ndash;&nbsp;<a href="https://stackoverflow.com/users/2614719/prateek-mishra">Prateek Mishra</a>&nbsp;<a href="https://stackoverflow.com/questions/24773064/error-er-wrong-value-count-on-row-column-count-doesnt-match-value-count-at-ro#comment38443009_24773161">Jul 16 &#39;14 at 6:35</a></p>\n', 'Memorandum of Response', '2019-11-21 21:53:09', NULL, NULL, 'A123456789X'),
	(10, '29 OF 2019', '<p>abcd</p>\n', 'Memorandum of Response', '2019-11-22 12:18:00', NULL, NULL, 'P65498745R'),
	(11, '28 OF 2019', '<p>WCF stands for Windows Communication Foundation. It is a framework for building, configuring, and deploying network-distributed services. Earlier known as Indigo, it enables hosting services in any type of operating system process. This tutorial explains the fundamentals of WCF and is conveniently divided into various sections. Every section of this tutorial has adequate number of examples to explain different concepts of WCF</p>\n', 'Memorandum of Response', '2019-11-28 16:05:58', NULL, NULL, 'A123456789X'),
	(12, '31 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', 'Memorandum of Response', '2019-11-29 09:58:57', NULL, NULL, 'A123456789X'),
	(13, '22 OF 2019', '<p>PRAGIM is known for placements in major IT companies. Major MNC&#39;s visit PRAGIM campus every week for interviews.You can contact our old students who are placed with in 1 week of completing their Training and are getting a salary ranging from Rs. 25,000 to</p>\n', 'Preliminary Objection', '2019-11-29 15:47:15', NULL, NULL, 'A123456789X'),
	(14, '32 OF 2019', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', 'Preliminary Objection', '2019-12-02 15:58:13', NULL, NULL, 'A123456789X');
/*!40000 ALTER TABLE `peresponsebackgroundinformation` ENABLE KEYS */;

-- Dumping structure for table arcm.peresponsecontacts
DROP TABLE IF EXISTS `peresponsecontacts`;
CREATE TABLE IF NOT EXISTS `peresponsecontacts` (
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Role` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsecontacts: ~4 rows (approximately)
DELETE FROM `peresponsecontacts`;
/*!40000 ALTER TABLE `peresponsecontacts` DISABLE KEYS */;
INSERT INTO `peresponsecontacts` (`Name`, `Email`, `Mobile`, `Role`) VALUES
	('Elvis kimutai', 'elviskcheruiyot@gmail.com', '0705555285', 'Incomplete'),
	('CASE OFFICER', 'cmkikungu@gmail.com1', '070110292812', 'Incomplete'),
	('WILSON B. KEREBEI', 'wkerebei@gmail.com1', '07227194121', 'Case officer'),
	('JAMES SUPPLIERS LTD', 'KEREBEI@HOTMAIL.COM', '07184030861', 'Applicant');
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsedetails: ~33 rows (approximately)
DELETE FROM `peresponsedetails`;
/*!40000 ALTER TABLE `peresponsedetails` DISABLE KEYS */;
INSERT INTO `peresponsedetails` (`ID`, `PEResponseID`, `GroundNO`, `GroundType`, `Response`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `BackgrounInformation`, `Deleted`) VALUES
	(11, 2, '1', 'Grounds', '<p>That the Procuring Entity declined to furnish the Applicant with a summary of the due diligence report as the same was part of confidential documents which remain in the custody of the Procuring Entity pursuant to section 67 of the Act</p>\n', '2019-11-12 14:55:01', 'A123456789U', NULL, NULL, NULL, 0),
	(12, 2, '2', 'Grounds', '<p>That the Procuring Entity declined to furnish the Applicant with a summary of the due diligence report as the same was part of confidential documents which remain in the custody of the Procuring Entity pursuant to section 67 of the Act</p>\n', '2019-11-12 14:55:07', 'A123456789U', NULL, NULL, NULL, 0),
	(13, 2, '1', 'Prayers', '<p>An order cancelling the award of tender and/or contract made to Kenya Airports Parking Services;</p>\n', '2019-11-12 14:56:55', 'A123456789U', NULL, NULL, NULL, 0),
	(14, 2, '2', 'Prayers', '<p>An order cancelling the award of tender and/or contract made to Kenya Airports Parking Services;</p>\n', '2019-11-12 14:57:01', 'A123456789U', NULL, NULL, NULL, 0),
	(15, 3, '1', 'Grounds', '<p>Review against the decision of the Principal Secretary, State Department of Irrigation and the award of Tender No: MALF &amp; I/SDI/OT/04/2018-2019 for Procurement of Construction of Kaigunji Irrigation Project Phase II Section One.</p>\n', '2019-11-12 17:19:56', 'A123456789X', NULL, NULL, NULL, 0),
	(16, 3, '2', 'Grounds', '<p>Review against the decision of the Principal Secretary, State Department of Irrigation and the award of Tender No: MALF &amp; I/SDI/OT/04/2018-2019 for Procurement of Construction of Kaigunji Irrigation Project Phase II Section One.</p>\n', '2019-11-12 17:20:06', 'A123456789X', NULL, NULL, NULL, 0),
	(17, 3, '3', 'Grounds', '<p>Review against the decision of the Principal Secretary, State Department of Irrigation and the award of Tender No: MALF &amp; I/SDI/OT/04/2018-2019 for Procurement of Construction of Kaigunji Irrigation Project Phase II Section One.</p>\n', '2019-11-12 17:20:14', 'A123456789X', NULL, NULL, NULL, 0),
	(18, 3, '1', 'Prayers', '<p>Review against the decision of the Principal Secretary, State Department of Irrigation and the award of Tender No: MALF &amp; I/SDI/OT/04/2018-2019 for Procurement of Construction of Kaigunji Irrigation Project Phase II Section One.</p>\n', '2019-11-12 17:20:49', 'A123456789X', NULL, NULL, NULL, 0),
	(19, 3, '2', 'Prayers', '<p>Review against the decision of the Principal Secretary, State Department of Irrigation and the award of Tender No: MALF &amp; I/SDI/OT/04/2018-2019 for Procurement of Construction of Kaigunji Irrigation Project Phase II Section One.</p>\n', '2019-11-12 17:21:03', 'A123456789X', NULL, NULL, NULL, 0),
	(20, 3, '3', 'Prayers', '<p>Review against the decision of the Principal Secretary, State Department of Irrigation and the award of Tender No: MALF &amp; I/SDI/OT/04/2018-2019 for Procurement of Construction of Kaigunji Irrigation Project Phase II Section One.</p>\n', '2019-11-12 17:21:10', 'A123456789X', NULL, NULL, NULL, 0),
	(21, 4, '1', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo,</p>\n', '2019-11-13 11:53:34', 'A123456789U', NULL, NULL, NULL, 0),
	(22, 4, '1', 'Prayers', '<p>ackground Information</p>\n', '2019-11-13 11:55:17', 'A123456789U', NULL, NULL, NULL, 0),
	(23, 5, '1', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-13 18:28:47', 'A123456789X', NULL, NULL, NULL, 0),
	(24, 5, '2', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut,</p>\n', '2019-11-13 18:28:54', 'A123456789X', NULL, NULL, NULL, 0),
	(25, 6, '1', 'Grounds', '<p>The Tender Document was in accordance with standard tender documents issued by PPRA</p>\n', '2019-11-15 12:01:35', 'P65498745R', NULL, NULL, NULL, 0),
	(26, 6, '2', 'Grounds', '<p>The termination of the tendering process was done in accordance with section 63 of the Act</p>\n', '2019-11-15 12:02:04', 'P65498745R', NULL, NULL, NULL, 0),
	(27, 6, '1', 'Prayers', '<p>The award to the successful bidder was lawful</p>\n', '2019-11-15 12:02:57', 'P65498745R', NULL, NULL, NULL, 0),
	(28, 6, '2', 'Prayers', '<p>The Applicant is not entitled to the costs of this application</p>\n', '2019-11-15 12:03:17', 'P65498745R', NULL, NULL, NULL, 0),
	(29, 1, '1', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 14:02:33', 'A123456789X', NULL, NULL, NULL, 0),
	(30, 1, '2', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 14:02:39', 'A123456789X', NULL, NULL, NULL, 0),
	(31, 1, '3', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 14:02:49', 'A123456789X', NULL, NULL, NULL, 0),
	(32, 1, '4', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede</p>\n', '2019-11-16 14:02:54', 'A123456789X', NULL, NULL, NULL, 0),
	(33, 7, '1', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 15:16:48', 'A123456789X', NULL, NULL, NULL, 0),
	(34, 7, '2', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 15:16:53', 'A123456789X', NULL, NULL, NULL, 0),
	(35, 7, '3', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 15:16:58', 'A123456789X', NULL, NULL, NULL, 0),
	(36, 7, '4', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 15:17:03', 'A123456789X', NULL, NULL, NULL, 0),
	(37, 7, '1', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 15:18:32', 'A123456789X', NULL, NULL, NULL, 0),
	(38, 7, '2', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 15:18:37', 'A123456789X', NULL, NULL, NULL, 0),
	(39, 7, '3', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo lig</p>\n', '2019-11-20 15:18:44', 'A123456789X', NULL, NULL, NULL, 0),
	(47, 9, '1', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pelle</p>\n', '2019-11-22 12:18:21', 'P65498745R', NULL, NULL, NULL, 0),
	(48, 9, '1', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pelle</p>\n', '2019-11-22 12:18:52', 'P65498745R', NULL, NULL, NULL, 0),
	(49, 10, '1', 'Grounds', '<p>WCF stands for Windows Communication Foundation. It is a framework for building, configuring, and deploying network-distributed services. Earlier known as Indigo, it enables hosting services in any type of operating system process. This tutorial explains the fundamentals of WCF and is conveniently divided into various sections. Every section of this tutorial has adequate number of examples to explain different concepts of WCF</p>\n', '2019-11-28 16:06:04', 'A123456789X', NULL, NULL, NULL, 0),
	(50, 11, '1', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', '2019-11-29 09:59:06', 'A123456789X', NULL, NULL, NULL, 0),
	(51, 11, '1', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus.</p>\n', '2019-11-29 09:59:15', 'A123456789X', NULL, NULL, NULL, 0),
	(52, 12, '1', 'Grounds', '<p>PRAGIM is known for placements in major IT companies. Major MNC&#39;s visit PRAGIM campus every week for interviews.You can contact our old students who are placed with in 1 week of completing their Training and are getting a salary ranging from Rs. 25,000 to</p>\n', '2019-11-29 15:47:23', 'A123456789X', NULL, NULL, NULL, 0),
	(53, 12, '2', 'Prayers', '<p>PRAGIM is known for placements in major IT companies. Major MNC&#39;s visit PRAGIM campus every week for interviews.You can contact our old students who are placed with in 1 week of completing their Training and are getting a salary ranging from Rs. 25,000 to</p>\n', '2019-11-29 15:47:32', 'A123456789X', NULL, NULL, NULL, 0),
	(54, 13, '1', 'Grounds', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', '2019-12-02 15:58:21', 'A123456789X', NULL, NULL, NULL, 0),
	(55, 13, '1', 'Prayers', '<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n', '2019-12-02 15:58:29', 'A123456789X', NULL, NULL, NULL, 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsedocuments: ~11 rows (approximately)
DELETE FROM `peresponsedocuments`;
/*!40000 ALTER TABLE `peresponsedocuments` DISABLE KEYS */;
INSERT INTO `peresponsedocuments` (`ID`, `PEResponseID`, `Name`, `Description`, `Path`, `Created_At`, `Deleted`, `Confidential`) VALUES
	(1, 1, '1573494093285-2020190002762066.pdf', 'Evaluation Criteria', 'Documents', '2019-11-11 17:41:33', 0, 0),
	(2, 1, '1573494100741-2020190002762066.pdf', 'Evaluation Criteria', 'Documents', '2019-11-11 17:41:41', 1, 0),
	(3, 1, '1573494111039-2020190002762066.pdf', 'Evaluation Criteria', 'Documents', '2019-11-11 17:41:51', 1, 0),
	(4, 1, '1573494179819-2020190002762066.pdf', 'Evaluation Criteria- Confidential', 'Documents', '2019-11-11 17:43:00', 0, 1),
	(5, 1, '1573495250165-2020190002762066.pdf', 'Document', 'Documents', '2019-11-11 18:00:50', 0, 0),
	(6, 2, '1573559846237-6 OF 2019.pdf', 'Tender Document', 'Documents', '2019-11-12 14:57:26', 0, 0),
	(7, 3, '1573579434053-CD Label.jpg', 'Evidence', 'Documents', '2019-11-12 17:23:54', 0, 0),
	(8, 5, '1573669819245-6 OF 2019.pdf', 'Document 1', 'Documents', '2019-11-13 18:30:19', 0, 1),
	(9, 1, '1573902198171-6 OF 2019.pdf', 'Document', 'Documents', '2019-11-16 14:03:18', 0, 0),
	(10, 8, '1574357772071-Tender Security.pdf', 'Response Document One', 'Documents', '2019-11-21 17:36:12', 0, 0),
	(11, 9, '1574425450609-FINAL ORDERS.pdf', 'Evaluation Report', 'Documents', '2019-11-22 12:24:10', 0, 1),
	(12, 11, '1575010780194-29 OF 2019 (1).pdf', 'ADDITIONAL SUBMISSION', 'http://localhost:3001/Documents', '2019-11-29 09:59:40', 0, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peresponsetimer: ~20 rows (approximately)
DELETE FROM `peresponsetimer`;
/*!40000 ALTER TABLE `peresponsetimer` DISABLE KEYS */;
INSERT INTO `peresponsetimer` (`ID`, `PEID`, `ApplicationNo`, `RegisteredOn`, `DueOn`, `Status`) VALUES
	(1, 'PE-2', '12 OF 2019', '2019-11-11 16:20:11', '2019-11-15 00:00:00', 'Submited'),
	(2, 'PE-3', '13 OF 2019', '2019-11-12 11:51:53', '2019-11-17 11:51:53', 'Awaiting Response'),
	(3, 'PE-3', '14 OF 2019', '2019-11-12 15:56:41', '2019-11-17 15:56:41', 'Pending Acknowledgement'),
	(4, 'PE-2', '15 OF 2019', '2019-11-12 17:02:35', '2019-11-17 17:02:35', 'Submited'),
	(5, 'PE-3', '16 OF 2019', '2019-11-13 11:42:41', '2019-11-18 11:42:41', 'Awaiting Response'),
	(6, 'PE-2', '17 OF 2019', '2019-11-13 17:40:43', '2019-11-18 17:40:43', 'Submited'),
	(7, 'PE-4', '18 OF 2019', '2019-11-15 11:36:02', '2019-11-20 11:36:02', 'Submited'),
	(8, 'PE-2', '19 OF 2019', '2019-11-17 12:17:53', '2019-11-22 12:17:53', 'Pending Acknowledgement'),
	(9, 'PE-2', '20 OF 2019', '2019-11-20 14:59:58', '2019-11-25 14:59:58', 'Submited'),
	(10, 'PE-3', '21 OF 2019', '2019-11-21 14:19:16', '2019-11-26 14:19:16', 'Pending Acknowledgement'),
	(11, 'PE-2', '22 OF 2019', '2019-11-21 14:36:22', '2019-11-26 14:36:22', 'Submited'),
	(12, 'PE-2', '23 OF 2019', '2019-11-21 17:00:59', '2019-11-26 17:00:59', 'Submited'),
	(13, 'PE-2', '24 OF 2019', '2019-11-21 21:26:16', '2019-11-26 21:26:16', 'Pending Acknowledgement'),
	(14, 'PE-2', '25 OF 2019', '2019-11-21 21:31:33', '2019-11-26 21:31:33', 'Pending Acknowledgement'),
	(15, 'PE-2', '26 OF 2019', '2019-11-21 21:34:40', '2019-11-26 21:34:40', 'Pending Acknowledgement'),
	(16, 'PE-2', '27 OF 2019', '2019-11-21 21:37:14', '2019-11-26 21:37:14', 'Submited'),
	(17, 'PE-2', '28 OF 2019', '2019-11-21 21:44:12', '2019-11-28 00:00:00', 'Submited'),
	(18, 'PE-4', '29 OF 2019', '2019-11-22 11:47:04', '2019-11-27 11:47:04', 'Submited'),
	(19, 'PE-1', '30 OF 2019', '2019-11-28 16:01:49', '2019-12-03 16:01:49', 'Pending Acknowledgement'),
	(20, 'PE-2', '31 OF 2019', '2019-11-29 09:30:13', '2019-12-04 09:30:13', 'Submited'),
	(21, 'PE-2', '32 OF 2019', '2019-12-02 14:56:01', '2019-12-23 00:00:00', 'Submited');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.petypes: ~11 rows (approximately)
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
	(13, 'PET-13', 'Public Colleges', '2019-11-21 11:12:50', 'Admin', '2019-11-21 11:12:50', 'Admin', 0, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.peusers: ~4 rows (approximately)
DELETE FROM `peusers`;
/*!40000 ALTER TABLE `peusers` DISABLE KEYS */;
INSERT INTO `peusers` (`ID`, `UserName`, `PEID`, `Created_At`, `Created_by`) VALUES
	(5, 'A123456789X', 'PE-2', '2019-11-11 16:26:50', 'A123456789X'),
	(6, 'A123456789U', 'PE-3', '2019-11-12 13:41:59', 'A123456789U'),
	(7, 'P65498745R', 'PE-4', '2019-11-15 11:46:49', 'P65498745R'),
	(8, 'P0000000001', 'PE-5', '2019-11-21 11:31:04', 'P0000000001');
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
  UNIQUE KEY `UK_procuremententity_PEID` (`PEID`),
  KEY `financialyear_ibfk_1` (`Created_By`),
  KEY `financialyear_ibfk_2` (`Updated_By`),
  KEY `PEID` (`PEID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.procuremententity: ~5 rows (approximately)
DELETE FROM `procuremententity`;
/*!40000 ALTER TABLE `procuremententity` DISABLE KEYS */;
INSERT INTO `procuremententity` (`ID`, `PEID`, `Name`, `PEType`, `County`, `Location`, `POBox`, `PostalCode`, `Town`, `Mobile`, `Telephone`, `Email`, `Logo`, `Website`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`, `Deleted_At`, `RegistrationDate`, `PIN`, `RegistrationNo`) VALUES
	(1, 'PE-1', 'MASINDE MULIRO UNIVERSITY OF SCIENCE AND TECHNOLOGY', 'PET-10', '037', 'Kakamega', '190', '50100', 'KAKAMEGA', '0705555285', '07055555287', 'elviskimcheruiyot@gmail.com', '1574335219150-MMUST Logo.jpg', 'https://www.google.com', 'Admin', '2019-08-09 11:55:00', '2019-11-21 11:20:22', 'admin', 0, 'Admin', '2019-08-09 12:58:17', '2019-09-04 00:00:00', 'A123456789X', 'TS2345678KS'),
	(2, 'PE-2', 'MINISTRY OF EDUCATION', 'PET-2', '047', 'Kakamega', '190', '00200', 'NAIROBI', '0705555285', '07055555287', 'elviskimcheruiyot@gmail.com', '1574333430553-Kenya_Court_of_Arms.png', 'https://www.google.com', 'Admin', '2019-08-09 12:11:23', '2019-11-21 11:15:07', 'admin', 0, NULL, NULL, '1970-01-01 00:00:00', 'A123456789X', 'TS2345678KS'),
	(3, 'PE-3', 'UNIVERSITY OF NAIROBI', 'PET-6', '047', 'University of Nairobi', '190', '00200', 'NAIROBI', '0705555285', '1234567890', 'elviskimcheruiyot@gmail.com', '1574333534598-UON Logo.jpg', 'https://www.google.com', 'Admin', '2019-09-03 12:22:41', '2019-11-21 11:16:35', 'admin', 0, NULL, NULL, '2019-09-01 00:00:00', 'A123456789X', 'TS2345678KS'),
	(4, 'PE-4', 'STATE DEPARTMENT OF INTERIOR ', 'PET-4', '047', 'HARAMBEE HOUSE', '45654', '00200', 'NAIROBI', '0718403086', '0733299665', 'judyjay879@gmail.com', '1574333463169-Kenya_Court_of_Arms.png', 'www.interior.go.ke', 'admin', '2019-11-15 10:51:14', '2019-11-21 10:52:56', 'admin', 0, NULL, NULL, '1963-12-12 00:00:00', 'P65498745R', 'c1234565'),
	(5, 'PE-5', 'KENYA POLICE SERVICE', 'PET-4', '047', 'NAIROBI', '30083 ', '00200', 'NAIROBI', '0100000000', '02034141168', 'info@kenyapolice.go.ke', '1574335469868-Kenya_Court_of_Arms.png', 'www.kenyapolice.go.ke', 'admin', '2019-11-21 11:26:10', '2019-11-21 11:27:35', 'admin', 0, NULL, NULL, '1963-12-12 00:00:00', 'P0000000001', 'N/A');
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
DELETE FROM `procurementmethods`;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.rb1forms: ~16 rows (approximately)
DELETE FROM `rb1forms`;
/*!40000 ALTER TABLE `rb1forms` DISABLE KEYS */;
INSERT INTO `rb1forms` (`ID`, `ApplicationNo`, `Path`, `FileName`, `GeneratedOn`, `GeneratedBy`) VALUES
	(1, '12 OF 2019', 'RB1FORMS/', '12 OF 2019.pdf', '2019-11-11 16:20:15', 'Admin'),
	(2, '13 OF 2019', 'RB1FORMS/', '13 OF 2019.pdf', '2019-11-12 11:52:00', 'PPRA01'),
	(3, '14 OF 2019', 'RB1FORMS/', '14 OF 2019.pdf', '2019-11-12 15:56:44', 'PPRA01'),
	(4, '15 OF 2019', 'RB1FORMS/', '15 OF 2019.pdf', '2019-11-12 17:02:38', 'Admin'),
	(5, '16 OF 2019', 'RB1FORMS/', '16 OF 2019.pdf', '2019-11-13 11:42:48', 'Admin'),
	(6, '17 OF 2019', 'RB1FORMS/', '17 OF 2019.pdf', '2019-11-13 17:40:46', 'Admin'),
	(7, '19 OF 2019', 'RB1FORMS/', '19 OF 2019.pdf', '2019-11-17 12:17:59', 'Admin'),
	(8, '20 OF 2019', 'RB1FORMS/', '20 OF 2019.pdf', '2019-11-20 15:00:04', 'Admin'),
	(9, '21 OF 2019', 'RB1FORMS/', '21 OF 2019.pdf', '2019-11-21 14:19:19', 'Admin'),
	(10, '22 OF 2019', 'RB1FORMS/', '22 OF 2019.pdf', '2019-11-21 14:36:25', 'Admin'),
	(11, '23 OF 2019', 'RB1FORMS/', '23 OF 2019.pdf', '2019-11-21 17:01:02', 'Admin'),
	(12, '26 OF 2019', 'RB1FORMS/', '26 OF 2019.pdf', '2019-11-21 21:34:43', 'Admin'),
	(13, '27 OF 2019', 'RB1FORMS/', '27 OF 2019.pdf', '2019-11-21 21:37:17', 'Admin'),
	(14, '28 OF 2019', 'RB1FORMS/', '28 OF 2019.pdf', '2019-11-21 21:44:14', 'Admin'),
	(15, '29 OF 2019', 'RB1FORMS/', '29 OF 2019.pdf', '2019-11-22 11:47:08', 'Admin'),
	(16, '30 OF 2019', 'RB1FORMS/', '30 OF 2019.pdf', '2019-11-28 16:01:56', 'Admin'),
	(17, '31 OF 2019', 'RB1FORMS/', '31 OF 2019.pdf', '2019-11-29 09:30:20', 'Admin'),
	(18, '32 OF 2019', 'RB1FORMS/', '32 OF 2019.pdf', '2019-12-02 14:56:10', 'Admin');
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

-- Dumping data for table arcm.requesthandledbuffer: ~30 rows (approximately)
DELETE FROM `requesthandledbuffer`;
/*!40000 ALTER TABLE `requesthandledbuffer` DISABLE KEYS */;
INSERT INTO `requesthandledbuffer` (`Applicationno`, `ApplicationDate`, `Status`) VALUES
	('23 OF 2019', '2019-11-21', 'Successful'),
	('29 OF 2019', '2019-11-22', 'Successful'),
	('12 OF 2019', '2019-11-11', 'Unsuccessful'),
	('16 OF 2019', '2019-11-13', 'Unsuccessful'),
	('17 OF 2019', '2019-11-13', 'Unsuccessful'),
	('18 OF 2019', '2019-11-15', 'Unsuccessful'),
	('20 OF 2019', '2019-11-20', 'Unsuccessful'),
	('14 OF 2019', '2019-11-12', 'Withdrawn'),
	('30 OF 2019', '2019-11-28', 'Withdrawn'),
	('31 OF 2019', '2019-11-29', 'Withdrawn'),
	('32 OF 2019', '2019-12-02', 'Withdrawn'),
	('13 OF 2019', '2019-11-12', 'Pending Determination'),
	('15 OF 2019', '2019-11-12', 'Pending Determination'),
	('11', '2019-11-13', 'Pending Determination'),
	('12', '2019-11-13', 'Pending Determination'),
	('13', '2019-11-13', 'Pending Determination'),
	('14', '2019-11-13', 'Pending Determination'),
	('21 OF 2019', '2019-11-14', 'Pending Determination'),
	('19', '2019-11-20', 'Pending Determination'),
	('20', '2019-11-20', 'Pending Determination'),
	('21', '2019-11-20', 'Pending Determination'),
	('22', '2019-11-20', 'Pending Determination'),
	('24', '2019-11-21', 'Pending Determination'),
	('22 OF 2019', '2019-11-21', 'Pending Determination'),
	('27 OF 2019', '2019-11-21', 'Pending Determination'),
	('28 OF 2019', '2019-11-21', 'Pending Determination'),
	('29', '2019-11-22', 'Pending Determination'),
	('31', '2019-11-26', 'Pending Determination'),
	('32', '2019-11-26', 'Pending Determination'),
	('33', '2019-11-28', 'Pending Determination');
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Resolveapplicationsequence`(IN _ApplicationNo VARCHAR(50),IN _Action VARCHAR(255))
BEGIN
  Update applicationsequence set Status='Done' where ApplicationNo=_ApplicationNo and  Action=_Action ;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ResolveMyNotification
DROP PROCEDURE IF EXISTS `ResolveMyNotification`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ResolveMyNotification`(IN _UserName VARCHAR(50), IN _Category VARCHAR(50),IN _ApplicationNo VARCHAR(50))
BEGIN
-- select ID from notifications where Username=_UserName and Category=_Category and Status='Not Resolved' LIMIT 1 into @UnresolvedID;
update notifications set Status='Resolved' where Username=_UserName and Category=_Category and ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.ResubmitApplication
DROP PROCEDURE IF EXISTS `ResubmitApplication`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ResubmitApplication`(IN _ApplicationID INT, IN _userID VARCHAR(50))
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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.roles: ~64 rows (approximately)
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
	(82, 'Applications Custom Report', 'Applications Custom Report', 'user', 'user', '2019-06-27 17:31:29', '2019-06-27 17:31:29', 0, 'Reports');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for procedure arcm.Saveadditionalsubmissions
DROP PROCEDURE IF EXISTS `Saveadditionalsubmissions`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Saveadditionalsubmissions`(IN _ApplicationID INT, IN _Description TEXT,  IN `_userID` VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveadditionalsubmissionsDocuments`(IN _ApplicationID INT, IN _Description TEXT, IN _DocName VARCHAR(100), IN _FilePath VARCHAR(50), IN _userID VARCHAR(50), IN _Confidential BOOLEAN)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Saveapplicationsequence`(IN _ApplicationNo VARCHAR(50),IN _Action VARCHAR(255),IN _ExpectedAction VARCHAR(150),IN _UserID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveAuditTrail`(IN `_Username` VARCHAR(50), IN `_Description` VARCHAR(128), IN `_Category` VARCHAR(50), IN `_IpAddress` VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Savecaseanalysisdocuments`(IN _ApplicationNo varchar(50), IN _Description TEXT, IN _DocName VARCHAR(100), IN _FilePath VARCHAR(50), IN _userID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveCaseOfficers`(IN _Username VARCHAR(50), IN _Active BOOLEAN, IN _NotAvailableFrom DATETIME, IN _NotAvailableTo DATETIME, IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveCaseWithdrawal`(IN _Applicant VARCHAR(50),IN _ApplicationNo VARCHAR(50),IN _Reason VARCHAR(255),IN _UserID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveHearingAttachments`(IN _ApplicationNo VARCHAR(50),IN _Name LongText,IN _Description VARCHAR(255),IN _Path VARCHAR(255),IN _Category VARCHAR(50),IN _UserID VARCHAR(50))
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
    call Saveapplicationsequence(_ApplicationNo,'Case Scheduled and hearing notice generated','Hearing',_UserID);  
  update applications set HearingNoticeGenerated='Yes' WHERE ApplicationNo=_ApplicationNo;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.SaveInterestedParty
DROP PROCEDURE IF EXISTS `SaveInterestedParty`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveInterestedParty`(IN _Name VARCHAR(120), IN _ApplicationID INT(11), IN _ContactName VARCHAR(150), IN _Email VARCHAR(128), IN _TelePhone VARCHAR(20), IN _Mobile VARCHAR(20),
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Savejrcontactusers`(IN _UserName VARCHAR(50),_ApplicationNO VARCHAR(50),IN _Role VARCHAR(100),IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Savejrinterestedparties`(IN _Name VARCHAR(120), IN _ApplicationNO varchar(50), IN _ContactName VARCHAR(150), IN _Email VARCHAR(128), IN _TelePhone VARCHAR(20), IN _Mobile VARCHAR(20),
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Savejudicialreviewdocuments`(IN _ApplicationNo VARCHAR(50), IN _Name VARCHAR(100), IN _Description VARCHAR(255), IN _Path VARCHAR(155), 
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveMpesaTransactions`(IN `_TransactionType` VARCHAR(100), IN `_TransID` VARCHAR(100), IN `_TransTime` VARCHAR(100), 
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveNotification`(IN `_UserName` VARCHAR(50), IN `_Category` VARCHAR(50), IN `_Description` VARCHAR(255), IN `_DueDate` DATETIME,IN _ApplicationNo VARCHAR(50))
    NO SQL
BEGIN
INSERT INTO notifications( Username, Category, Description, Created_At, DueDate, Status,ApplicationNo)
  VALUES (_Username,_Category,_Description,NOW(),_DueDate,'Not Resolved',_ApplicationNo);

END//
DELIMITER ;

-- Dumping structure for procedure arcm.SavePanel
DROP PROCEDURE IF EXISTS `SavePanel`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePanel`(IN _ApplicationNo VARCHAR(50), IN _Role VARCHAR(100), IN _UserName VARCHAR(50), IN _UserID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePEResponse`(IN _ApplicationNo VARCHAR(50), IN _ResponseType VARCHAR(50), IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePEResponseDetails`(IN _PERsponseID INT, IN _GrounNo VARCHAR(50), IN _Groundtype VARCHAR(50), IN _Response TEXT, IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SavePEresponseDocuments`(IN _PEResponseID INT, IN _Name VARCHAR(100), IN _Description VARCHAR(255), IN _Path VARCHAR(155), IN _Confidential Boolean)
BEGIN
insert into peresponsedocuments (PEResponseID ,Name ,Description ,Path , Created_At,Deleted,Confidential )
  VALUES(_PEResponseID,_Name,_Description,_Path,now(),0,_Confidential);
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveUser`(IN _Name VARCHAR(120), IN _Email VARCHAR(128), IN _Password VARCHAR(128), IN _UserGroupID BIGINT, IN _Username VARCHAR(50), IN _userID VARCHAR(50), IN _Phone VARCHAR(20), IN _Signature VARCHAR(128), IN _IsActive BOOLEAN, IN _IDnumber VARCHAR(50), IN _DOB DATETIME, IN _Gender VARCHAR(50), IN _ActivationCode VARCHAR(50), IN _Board BOOLEAN)
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
DELETE FROM `schedules`;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;

-- Dumping structure for procedure arcm.selfAttendanceregistration
DROP PROCEDURE IF EXISTS `selfAttendanceregistration`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `selfAttendanceregistration`(IN _RegisterID INT(11), IN _Name VARCHAR(100), IN _IDNO VARCHAR(50), IN _MobileNo VARCHAR(50), IN _Category VARCHAR(55)
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
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.sentsms: ~277 rows (approximately)
DELETE FROM `sentsms`;
/*!40000 ALTER TABLE `sentsms` DISABLE KEYS */;
INSERT INTO `sentsms` (`ID`, `Recepient`, `SenderID`, `Message`, `SentTime`) VALUES
	(1, '0705555285', 'WILCOM-TVET', '838700', '2019-10-17 09:54:15'),
	(2, '07087654322456', 'WILCOM-TVET', '296872', '2019-10-17 17:26:42'),
	(3, '0705555285', 'WILCOM-TVET', '949523', '2019-10-17 17:27:42'),
	(4, '07055552851', 'WILCOM-TVET', '287515', '2019-10-17 17:42:41'),
	(5, '0705555285', 'WILCOM-TVET', '757241', '2019-10-17 17:45:46'),
	(6, '070555528512', 'WILCOM-TVET', '461574', '2019-10-17 18:12:28'),
	(7, '070555528512', 'WILCOM-TVET', '438717', '2019-10-17 18:14:35'),
	(8, '0705555285', 'WILCOM-TVET', '946583', '2019-10-17 18:15:25'),
	(9, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO: has been Received', '2019-10-23 11:39:25'),
	(10, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-24 14:40:01'),
	(11, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-24 14:40:01'),
	(12, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-24 14:40:01'),
	(13, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-25 09:23:53'),
	(14, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:23:53'),
	(15, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:23:54'),
	(16, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-25 09:24:29'),
	(17, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:24:30'),
	(18, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:24:30'),
	(19, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-25 09:25:45'),
	(20, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:25:46'),
	(21, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:25:46'),
	(22, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-25 09:27:43'),
	(23, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:27:44'),
	(24, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:27:44'),
	(25, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-25 09:28:30'),
	(26, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:28:30'),
	(27, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:28:30'),
	(28, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-25 09:32:59'),
	(29, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:32:59'),
	(30, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:32:59'),
	(31, '0722114567', 'WILCOM-TVET', 'Your Application with ApplicationNO:15 has been Received', '2019-10-25 09:37:36'),
	(32, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:37:36'),
	(33, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 09:37:36'),
	(34, '0722114567', 'WILCOM-TVET', 'Your Application with Reference:15 has been Received', '2019-10-25 10:22:14'),
	(35, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 10:22:14'),
	(36, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-10-25 10:22:14'),
	(37, '0722114567', 'WILCOM-TVET', 'Your Application with Reference:12 has been Received', '2019-10-25 11:28:47'),
	(38, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:12 has been submited and is awaiting your review', '2019-10-25 11:28:47'),
	(39, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:12 has been submited and is awaiting your review', '2019-10-25 11:28:47'),
	(40, '0722114567', 'WILCOM-TVET', 'Your Application with Reference:6 has been Received', '2019-10-25 11:33:31'),
	(41, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:6 has been submited and is awaiting your review', '2019-10-25 11:33:31'),
	(42, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:6 has been submited and is awaiting your review', '2019-10-25 11:33:31'),
	(43, '0722114567', 'WILCOM-TVET', 'Your Application with Reference:10 has been Received', '2019-10-25 11:35:26'),
	(44, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:10 has been submited and is awaiting your review', '2019-10-25 11:35:26'),
	(45, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:10 has been submited and is awaiting your review', '2019-10-25 11:35:26'),
	(46, '0722114567', 'WILCOM-TVET', 'Your Application with Reference:16 has been Received', '2019-10-25 11:36:43'),
	(47, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:16 has been submited and is awaiting your review', '2019-10-25 11:36:43'),
	(48, '07221145671', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:16 has been submited and is awaiting your review', '2019-10-25 11:36:43'),
	(49, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited payment details for Filling Preliminary Objection for application:1 OF 2019.You are required confirm the payment.', '2019-10-30 15:39:50'),
	(50, '07221145671', 'WILCOM-TVET', 'Dear Admin2.PE has submited payment details for Filling Preliminary Objection for application:1 OF 2019.You are required confirm the payment.', '2019-10-30 15:39:50'),
	(51, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:1 has been Received', '2019-11-11 16:07:49'),
	(52, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:1 has been Received', '2019-11-11 16:10:59'),
	(53, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:1 has been submited and is awaiting your review', '2019-11-11 16:10:59'),
	(54, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:1 has been submited and is awaiting your review', '2019-11-11 16:11:00'),
	(55, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:1 has been submited and is awaiting your review', '2019-11-11 16:11:00'),
	(56, '0701102928', 'WILCOM-TVET', 'New request to approve application fees with Reference No:12344545 has been submited and is awaiting your review', '2019-11-11 16:12:40'),
	(57, '0722719412', 'WILCOM-TVET', 'New request to approve application fees with Reference No:12344545 has been submited and is awaiting your review', '2019-11-11 16:12:40'),
	(58, '0122719412', 'WILCOM-TVET', 'Fees amount of: 28800 paid for application with Reference 12334444 has been confirmed.Application is now marked as paid.', '2019-11-11 16:15:44'),
	(59, '0122719412', 'WILCOM-TVET', 'Fees amount of: 28800 paid for application with Reference 12334444 has been confirmed.Application is now marked as paid.', '2019-11-11 16:15:44'),
	(60, '0705555285', 'WILCOM-TVET', 'New application with Reference 12334444 has been submited and it\'s awaiting your review.', '2019-11-11 16:15:44'),
	(61, '0722719412', 'WILCOM-TVET', 'New application with Reference 12334444 has been submited and it\'s awaiting your review.', '2019-11-11 16:15:45'),
	(62, '0701102928', 'WILCOM-TVET', 'New application with Reference 12334444 has been submited and it\'s awaiting your review.', '2019-11-11 16:15:45'),
	(63, '0705555285', 'WILCOM-TVET', 'New Application 12 OF 2019 has been submited. You are required to Login to ARCMS and respond to it before: 2019-11-16T16:20:11.000Z', '2019-11-11 16:20:12'),
	(64, '0705555285', 'WILCOM-TVET', 'You have been selected as case officer for  Application:12 OF 2019.', '2019-11-11 16:20:13'),
	(65, '0705555285', 'WILCOM-TVET', 'New deadline extension request has been submited and it\'s awaiting your review.', '2019-11-11 17:31:46'),
	(66, '0705555285', 'WILCOM-TVET', 'Your request for deadline extension has been DECLINED.You are expected to submit your response before 2019-11-16 16:20:11.', '2019-11-11 17:35:16'),
	(67, '0105555285', 'WILCOM-TVET', 'Dear MINISTRY OF EDUCATION.Your response for Application12 OF 2019has been received.You will be notified when hearing date will be set.', '2019-11-11 17:43:27'),
	(68, '0122718412', 'WILCOM-TVET', 'Dear INTERESTED PARTY LTD.A response for Application12 OF 2019has been sent by the Procuring Entity.', '2019-11-11 17:43:27'),
	(69, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited a response for Application12 OF 2019.You are required to form a panel and submit it for review.', '2019-11-11 17:43:27'),
	(70, '0122719412', 'WILCOM-TVET', 'Dear JAMES SUPPLIERS LTD.A response for Application12 OF 2019has been sent by the Procuring Entity.', '2019-11-11 17:43:27'),
	(71, '0105555285', 'WILCOM-TVET', 'Dear MINISTRY OF EDUCATION.Your response for Application12 OF 2019has been received.You will be notified when hearing date will be set.', '2019-11-11 18:01:22'),
	(72, '0122718412', 'WILCOM-TVET', 'Dear INTERESTED PARTY LTD.A response for Application12 OF 2019has been sent by the Procuring Entity.', '2019-11-11 18:01:22'),
	(73, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited a response for Application12 OF 2019.You are required to form a panel and submit it for review.', '2019-11-11 18:01:22'),
	(74, '0122719412', 'WILCOM-TVET', 'Dear JAMES SUPPLIERS LTD.A response for Application12 OF 2019has been sent by the Procuring Entity.', '2019-11-11 18:01:23'),
	(75, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:5 has been Received', '2019-11-12 11:22:11'),
	(76, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:5 has been submited and is awaiting your review', '2019-11-12 11:24:37'),
	(77, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:5 has been submited and is awaiting your review', '2019-11-12 11:24:37'),
	(78, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:5 has been submited and is awaiting your review', '2019-11-12 11:24:38'),
	(79, '0701102928', 'WILCOM-TVET', 'New request to approve application fees with Reference No:12344545 has been submited and is awaiting your review', '2019-11-12 11:39:41'),
	(80, '0722719412', 'WILCOM-TVET', 'New request to approve application fees with Reference No:12344545 has been submited and is awaiting your review', '2019-11-12 11:39:41'),
	(81, '0705555285', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 11:42:39'),
	(82, '0122719412', 'WILCOM-TVET', 'Fees amount of: 15000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-12 11:42:39'),
	(83, '0122719412', 'WILCOM-TVET', 'Fees amount of: 15000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-12 11:42:39'),
	(84, '0701102928', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 11:42:39'),
	(85, '0722719412', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 11:42:39'),
	(86, '0705555285', 'WILCOM-TVET', 'New Application 13 OF 2019 has been submited. You are required to Login to ARCMS and respond to it before: 2019-11-17T08:51:54.000Z', '2019-11-12 11:51:54'),
	(87, '0700392599', 'WILCOM-TVET', 'Dear University of Nairobi.Your response for Application13 OF 2019has been received.You will be notified when hearing date will be set.', '2019-11-12 14:57:30'),
	(88, '0701102928', 'WILCOM-TVET', 'Dear CASE OFFICER.PE has submited a response for Application13 OF 2019.You are required to form a panel and submit it for review.', '2019-11-12 14:57:30'),
	(89, '0701102928', 'WILCOM-TVET', 'Dear Wilcom Systems.A response for Application13 OF 2019has been sent by the Procuring Entity.', '2019-11-12 14:57:30'),
	(90, '0122719412', 'WILCOM-TVET', 'Dear JAMES SUPPLIERS LTD.A response for Application13 OF 2019has been sent by the Procuring Entity.', '2019-11-12 14:57:31'),
	(91, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:6 has been Received', '2019-11-12 15:50:06'),
	(92, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:6 has been Received', '2019-11-12 15:51:40'),
	(93, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:6 has been submited and is awaiting your review', '2019-11-12 15:51:40'),
	(94, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:6 has been submited and is awaiting your review', '2019-11-12 15:51:40'),
	(95, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:6 has been submited and is awaiting your review', '2019-11-12 15:51:41'),
	(96, '0722719412', 'WILCOM-TVET', 'New request to approve application fees with Reference No:12344545 has been submited and is awaiting your review', '2019-11-12 15:54:12'),
	(97, '0701102928', 'WILCOM-TVET', 'New request to approve application fees with Reference No:12344545 has been submited and is awaiting your review', '2019-11-12 15:54:12'),
	(98, '0122719412', 'WILCOM-TVET', 'Fees amount of: 26000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-12 15:55:26'),
	(99, '0122719412', 'WILCOM-TVET', 'Fees amount of: 26000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-12 15:55:26'),
	(100, '0705555285', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 15:55:26'),
	(101, '0722719412', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 15:55:26'),
	(102, '0701102928', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 15:55:26'),
	(103, '0705555285', 'WILCOM-TVET', 'New Application 14 OF 2019 has been submited. You are required to Login to ARCMS and respond to it before: 2019-11-17T15:56:41.000Z', '2019-11-12 15:56:42'),
	(104, '0705555285', 'WILCOM-TVET', 'You have been selected as case officer for  Application:14 OF 2019.', '2019-11-12 15:56:42'),
	(105, '0122719412', 'WILCOM-TVET', 'Your request to withdrawal appeal :14 OF 2019 has been received and is awaiting approval.', '2019-11-12 15:58:30'),
	(106, '0705555285', 'WILCOM-TVET', 'New request to withdrawal appeal:14 OF 2019 has been submited and is awaiting your review.', '2019-11-12 15:58:31'),
	(107, '0122719412', 'WILCOM-TVET', 'Your request to withdrawal appeal :14 OF 2019 has been received and is awaiting approval.', '2019-11-12 15:58:31'),
	(108, '0701102928', 'WILCOM-TVET', 'New request to withdrawal appeal:14 OF 2019 has been submited and is awaiting your review.', '2019-11-12 15:58:31'),
	(109, '0122719412', 'WILCOM-TVET', 'Your request to withdrawal appeal :14 OF 2019 has been received and is awaiting approval.', '2019-11-12 15:58:31'),
	(110, '0722719412', 'WILCOM-TVET', 'New request to withdrawal appeal:14 OF 2019 has been submited and is awaiting your review.', '2019-11-12 15:58:31'),
	(111, '0701102928', 'WILCOM-TVET', 'New request to withdrawal appeal:14 OF 2019 has been submited and is awaiting your review.', '2019-11-12 16:00:13'),
	(112, '0705555285', 'WILCOM-TVET', 'New request to withdrawal appeal:14 OF 2019 has been submited and is awaiting your review.', '2019-11-12 16:00:13'),
	(113, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai. A request to withdraw application 14 OF 2019 has been Accepted. The Appeal is now marked withdrawn.', '2019-11-12 16:04:21'),
	(114, '0700392599', 'WILCOM-TVET', 'Dear University of Nairobi. A request to withdraw application 14 OF 2019 has been Accepted. The Appeal is now marked withdrawn.', '2019-11-12 16:04:21'),
	(115, '0705555285', 'WILCOM-TVET', 'Dear University of Nairobi. A request to withdraw application 14 OF 2019 has been Accepted. The Appeal is now marked withdrawn.', '2019-11-12 16:04:22'),
	(116, '0122719412', 'WILCOM-TVET', 'Dear JAMES SUPPLIERS LTD. A request to withdraw application 14 OF 2019 has been Accepted. The Appeal is now marked withdrawn.', '2019-11-12 16:04:22'),
	(117, '0122719412', 'WILCOM-TVET', 'Dear JAMES SUPPLIERS LTD. A request to withdraw application 14 OF 2019 has been Accepted. The Appeal is now marked withdrawn.', '2019-11-12 16:04:22'),
	(118, '0722719412', 'WILCOM-TVET', 'Dear WilCom Systems Ltd. A request to withdraw application 14 OF 2019 has been Accepted. The Appeal is now marked withdrawn.', '2019-11-12 16:04:23'),
	(119, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:7 has been Received', '2019-11-12 16:48:05'),
	(120, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:7 has been Received', '2019-11-12 16:52:42'),
	(121, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:7 has been submited and is awaiting your review', '2019-11-12 16:52:42'),
	(122, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:7 has been submited and is awaiting your review', '2019-11-12 16:52:42'),
	(123, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:7 has been submited and is awaiting your review', '2019-11-12 16:52:43'),
	(124, '0122719412', 'WILCOM-TVET', 'Fees amount of: 45000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-12 17:00:56'),
	(125, '0705555285', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 17:00:56'),
	(126, '0122719412', 'WILCOM-TVET', 'Fees amount of: 45000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-12 17:00:56'),
	(127, '0722719412', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 17:00:57'),
	(128, '0701102928', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-12 17:00:57'),
	(129, '0705555285', 'WILCOM-TVET', 'New Application 15 OF 2019 has been submited. You are required to Login to ARCMS and respond to it before: 2019-11-17T17:02:36.000Z', '2019-11-12 17:02:36'),
	(130, '0701102928', 'WILCOM-TVET', 'You have been selected as case officer for  Application:15 OF 2019.', '2019-11-12 17:02:36'),
	(131, '0705555285', 'WILCOM-TVET', 'New deadline extension request has been submited and it\'s awaiting your review.', '2019-11-12 17:15:50'),
	(132, '0705555285', 'WILCOM-TVET', 'Your request for deadline extension has been DECLINED.You are expected to submit your response before 2019-11-17 17:02:35.', '2019-11-12 17:17:51'),
	(133, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited payment details for Filling Preliminary Objection for application:15 OF 2019.You are required confirm the payment.', '2019-11-12 17:25:24'),
	(134, '0701102928', 'WILCOM-TVET', 'Dear CASE OFFICER.PE has submited payment details for Filling Preliminary Objection for application:15 OF 2019.You are required confirm the payment.', '2019-11-12 17:25:24'),
	(135, '0722719412', 'WILCOM-TVET', 'Dear WILSON B. KEREBEI.PE has submited payment details for Filling Preliminary Objection for application:15 OF 2019.You are required confirm the payment.', '2019-11-12 17:25:24'),
	(136, '0105555285', 'WILCOM-TVET', 'Fees amount of: 5000 paid for filing Preliminary Objection  has been confirmed.Your response is now marked as paid and submited.', '2019-11-12 17:32:57'),
	(137, '0122719412', 'WILCOM-TVET', 'Your Application with Reference:8 has been Received', '2019-11-13 11:24:43'),
	(138, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:8 has been submited and is awaiting your review', '2019-11-13 11:24:43'),
	(139, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:8 has been submited and is awaiting your review', '2019-11-13 11:24:43'),
	(140, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:8 has been submited and is awaiting your review', '2019-11-13 11:24:43'),
	(141, '0122719412', 'WILCOM-TVET', 'Fees amount of: 75000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-13 11:32:12'),
	(142, '0122719412', 'WILCOM-TVET', 'Fees amount of: 75000 paid for application with Reference 12344545 has been confirmed.Application is now marked as paid.', '2019-11-13 11:32:13'),
	(143, '0705555285', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-13 11:32:13'),
	(144, '0722719412', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-13 11:32:13'),
	(145, '0701102928', 'WILCOM-TVET', 'New application with Reference 12344545 has been submited and it\'s awaiting your review.', '2019-11-13 11:32:13'),
	(146, '0705555285', 'WILCOM-TVET', 'New Application 16 OF 2019 has been submited. You are required to Login to ARCMS and respond to it before: 2019-11-18T08:42:42.000Z', '2019-11-13 11:42:42'),
	(147, '0705555285', 'WILCOM-TVET', 'You have been selected as case officer for  Application:16 OF 2019.', '2019-11-13 11:42:43'),
	(148, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited payment details for Filling Preliminary Objection for application:16 OF 2019.You are required confirm the payment.', '2019-11-13 11:56:15'),
	(149, '0701102928', 'WILCOM-TVET', 'Dear CASE OFFICER.PE has submited payment details for Filling Preliminary Objection for application:16 OF 2019.You are required confirm the payment.', '2019-11-13 11:56:15'),
	(150, '0722719412', 'WILCOM-TVET', 'Dear WILSON B. KEREBEI.PE has submited payment details for Filling Preliminary Objection for application:16 OF 2019.You are required confirm the payment.', '2019-11-13 11:56:15'),
	(151, '0700392599', 'WILCOM-TVET', 'Fees amount of: 5000 paid for filing Preliminary Objection  has been confirmed.Your response is now marked as paid and submited.', '2019-11-13 12:26:38'),
	(152, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 438956 Use this to activate your account.', '2019-11-13 14:08:20'),
	(153, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 402248 Use this to activate your account.', '2019-11-13 14:36:03'),
	(154, '0722114567', 'WILCOM-TVET', 'Your Activation Code is: 821525 Use this to activate your account.', '2019-11-13 15:01:29'),
	(155, '0722114567', 'WILCOM-TVET', 'Your Activation Code is: 121630 Use this to activate your account.', '2019-11-13 15:14:40'),
	(156, '0722114567', 'WILCOM-TVET', 'Your Activation Code is: 242481 Use this to activate your account.', '2019-11-13 15:24:33'),
	(157, '0722114567', 'WILCOM-TVET', 'Your Application with Reference:15 has been Received', '2019-11-13 17:19:01'),
	(158, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-11-13 17:19:01'),
	(159, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-11-13 17:19:01'),
	(160, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:15 has been submited and is awaiting your review', '2019-11-13 17:19:02'),
	(161, '0722114567', 'WILCOM-TVET', 'Fees amount of: 5000 paid for application with Reference Reff123 has been confirmed.Application is now marked as paid.', '2019-11-13 17:31:37'),
	(162, '0722114567', 'WILCOM-TVET', 'Fees amount of: 5000 paid for application with Reference Reff123 has been confirmed.Application is now marked as paid.', '2019-11-13 17:31:37'),
	(163, '0705555285', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-13 17:31:37'),
	(164, '0722719412', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-13 17:31:38'),
	(165, '0701102928', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-13 17:31:38'),
	(166, '0705555285', 'WILCOM-TVET', 'New Application 17 OF 2019 has been submited. You are required to Login to ARCMS and respond to it before: 2019-11-18T17:40:43.000Z', '2019-11-13 17:40:44'),
	(167, '0705555285', 'WILCOM-TVET', 'You have been selected as case officer for  Application:17 OF 2019.', '2019-11-13 17:40:44'),
	(168, '0722114567', 'WILCOM-TVET', 'Your Application with Reference:14 has been Received', '2019-11-13 17:49:23'),
	(169, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:14 has been submited and is awaiting your review', '2019-11-13 17:49:23'),
	(170, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:14 has been submited and is awaiting your review', '2019-11-13 17:49:23'),
	(171, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:14 has been submited and is awaiting your review', '2019-11-13 17:49:24'),
	(172, '0722114567', 'WILCOM-TVET', 'Fees amount of: 5000 paid for application with Reference Reff123 has been confirmed.Application is now marked as paid.', '2019-11-13 17:49:51'),
	(173, '0722114567', 'WILCOM-TVET', 'Fees amount of: 5000 paid for application with Reference Reff123 has been confirmed.Application is now marked as paid.', '2019-11-13 17:49:51'),
	(174, '0705555285', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-13 17:49:51'),
	(175, '0701102928', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-13 17:49:52'),
	(176, '0722719412', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-13 17:49:52'),
	(177, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-13 18:34:07'),
	(178, '0701102928', 'WILCOM-TVET', 'Dear CASE OFFICER.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-13 18:34:07'),
	(179, '0722719412', 'WILCOM-TVET', 'Dear WILSON B. KEREBEI.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-13 18:34:07'),
	(180, '0105555285', 'WILCOM-TVET', 'Fees amount of: 10000 paid for filing Preliminary Objection  has been confirmed.Your response is now marked as paid and submited.', '2019-11-13 18:38:25'),
	(181, '0705555285', 'WILCOM-TVET', 'New deadline extension request has been submited and it\'s awaiting your review.', '2019-11-13 18:50:06'),
	(182, '0705555285', 'WILCOM-TVET', 'New deadline extension request has been submited and it\'s awaiting your review.', '2019-11-14 07:29:45'),
	(183, '0705555285', 'WILCOM-TVET', 'New deadline extension request has been submited and it\'s awaiting your review.', '2019-11-14 07:31:37'),
	(184, '0722719412', 'WILCOM-TVET', 'Dear WILSON B. KEREBEI.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-14 07:33:32'),
	(185, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-14 07:33:32'),
	(186, '0701102928', 'WILCOM-TVET', 'Dear CASE OFFICER.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-14 07:33:32'),
	(187, '0722719412', 'WILCOM-TVET', 'Dear WILSON B. KEREBEI.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-14 07:37:33'),
	(188, '0705555285', 'WILCOM-TVET', 'Dear Elvis kimutai.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-14 07:37:33'),
	(189, '0701102928', 'WILCOM-TVET', 'Dear CASE OFFICER.PE has submited payment details for Filling Preliminary Objection for application:17 OF 2019.You are required confirm the payment.', '2019-11-14 07:37:33'),
	(190, '0105555285', 'WILCOM-TVET', 'Dear MINISTRY OF EDUCATION.Your response for Application15 OF 2019has been received.You will be notified when hearing date will be set.', '2019-11-14 07:37:50'),
	(191, '0722719412', 'WILCOM-TVET', 'Dear WilCom Systems Ltd.A response for Application15 OF 2019has been sent by the Procuring Entity.', '2019-11-14 07:37:50'),
	(192, '0722719412', 'WILCOM-TVET', 'Dear WilCom Systems Ltd.A response for Application15 OF 2019has been sent by the Procuring Entity.', '2019-11-14 07:37:50'),
	(193, '0701102928', 'WILCOM-TVET', 'Dear CASE OFFICER.PE has submited a response for Application15 OF 2019.You are required to form a panel and submit it for review.', '2019-11-14 07:37:51'),
	(194, '0122719412', 'WILCOM-TVET', 'Dear JAMES SUPPLIERS LTD.A response for Application15 OF 2019has been sent by the Procuring Entity.', '2019-11-14 07:37:51'),
	(195, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 394387 Use this to activate your account.', '2019-11-14 15:31:53'),
	(196, '0122719412', 'WILCOM-TVET', 'Application 16 that you had submited to ACRB has been declined.', '2019-11-14 15:35:51'),
	(197, '0122719412', 'WILCOM-TVET', 'Application 16 that you had submited to ACRB has been declined.', '2019-11-14 15:35:51'),
	(198, '0122719412', 'WILCOM-TVET', 'Application 16 that you had submited to ACRB has been declined.', '2019-11-14 15:40:08'),
	(199, '0122719412', 'WILCOM-TVET', 'Application 16 that you had submited to ACRB has been declined.', '2019-11-14 15:40:09'),
	(200, '0705555285', 'WILCOM-TVET', 'New Panel List for ApplicationNo:17 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 15:52:12'),
	(201, '0701102928', 'WILCOM-TVET', 'New Panel List for ApplicationNo:17 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 15:52:12'),
	(202, '0722719412', 'WILCOM-TVET', 'New Panel List for ApplicationNo:17 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 15:52:12'),
	(203, '0705555285', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 16:14:13'),
	(204, '0701102928', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 16:14:13'),
	(205, '0722719412', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 16:14:14'),
	(206, '0701102928', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 16:16:44'),
	(207, '0705555285', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 16:16:44'),
	(208, '0722719412', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-14 16:16:44'),
	(209, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 848331 Use this to activate your account.', '2019-11-14 20:23:37'),
	(210, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 566835 Use this to activate your account.', '2019-11-15 09:47:21'),
	(211, '0721382630', 'WILCOM-TVET', 'Your Activation Code is: 780799 Use this to activate your account.', '2019-11-15 10:28:19'),
	(212, '0721382630', 'WILCOM-TVET', 'Your Activation Code is: 918251 Use this to activate your account.', '2019-11-15 10:30:35'),
	(213, '0720768894', 'WILCOM-TVET', 'Your Activation Code is: 479438 Use this to activate your account.', '2019-11-15 10:31:47'),
	(214, '0721382630', 'WILCOM-TVET', 'Your Activation Code is: 662849 Use this to activate your account.', '2019-11-15 10:32:30'),
	(215, '0705128595', 'WILCOM-TVET', 'Your Activation Code is: 587989 Use this to activate your account.', '2019-11-15 10:40:29'),
	(216, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 565124 Use this to activate your account.', '2019-11-15 10:43:35'),
	(217, '0720768894', 'WILCOM-TVET', 'Your Activation Code is: 308586 Use this to activate your account.', '2019-11-15 10:51:47'),
	(218, '0705128595', 'WILCOM-TVET', 'Your Activation Code is: 365271 Use this to activate your account.', '2019-11-15 10:52:42'),
	(219, '0705128595', 'WILCOM-TVET', 'Your Application with Reference:17 has been Received', '2019-11-15 11:10:02'),
	(220, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:17 has been submited and is awaiting your review', '2019-11-15 11:10:03'),
	(221, '0722719412', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:17 has been submited and is awaiting your review', '2019-11-15 11:10:03'),
	(222, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:17 has been submited and is awaiting your review', '2019-11-15 11:10:03'),
	(223, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 823383 Use this to activate your account.', '2019-11-15 11:11:08'),
	(224, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 332303 Use this to activate your account.', '2019-11-15 11:19:00'),
	(225, '0722719412', 'WILCOM-TVET', 'Your Activation Code is: 267527 Use this to activate your account.', '2019-11-15 11:27:08'),
	(226, '0701102928', 'WILCOM-TVET', 'Your Activation Code is: 915051 Use this to activate your account.', '2019-11-15 11:28:33'),
	(227, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 401882 Use this to activate your account.', '2019-11-15 11:29:27'),
	(228, '0721382630', 'WILCOM-TVET', 'Your Activation Code is: 187952 Use this to activate your account.', '2019-11-15 11:33:15'),
	(229, '0720768894', 'WILCOM-TVET', 'Your Activation Code is: 428004 Use this to activate your account.', '2019-11-15 11:33:20'),
	(230, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 542677 Use this to activate your account.', '2019-11-15 11:36:19'),
	(231, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 382076 Use this to activate your account.', '2019-11-15 11:38:12'),
	(232, '0720768894', 'WILCOM-TVET', 'Your Activation Code is: 652471 Use this to activate your account.', '2019-11-15 11:39:37'),
	(233, '0122719412', 'WILCOM-TVET', 'Your Activation Code is: 881353 Use this to activate your account.', '2019-11-15 11:41:48'),
	(234, '0122719412', 'WILCOM-TVET', 'Your Activation Code is: 743431 Use this to activate your account.', '2019-11-15 11:42:25'),
	(235, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 886421 Use this to activate your account.', '2019-11-15 11:43:34'),
	(236, '0733299665', 'WILCOM-TVET', 'Your Activation Code is: 140454 Use this to activate your account.', '2019-11-15 11:47:49'),
	(237, '0722719412', 'WILCOM-TVET', 'Your Activation Code is: 732771 Use this to activate your account.', '2019-11-15 11:48:46'),
	(238, '0722719412', 'WILCOM-TVET', 'Your Application with Reference:18 has been Received', '2019-11-15 11:50:58'),
	(239, '0705555285', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:18 has been submited and is awaiting your review', '2019-11-15 11:50:59'),
	(240, '0701102928', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:18 has been submited and is awaiting your review', '2019-11-15 11:50:59'),
	(241, '0722955458', 'WILCOM-TVET', 'New request to approve application fees for Application with Reference No:18 has been submited and is awaiting your review', '2019-11-15 11:50:59'),
	(242, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 894771 Use this to activate your account.', '2019-11-15 11:51:15'),
	(243, '0722719412', 'WILCOM-TVET', 'Fees amount of: 15000 paid for application with Reference Reff123 has been confirmed.Application is now marked as paid.', '2019-11-15 11:51:57'),
	(244, '0122719412', 'WILCOM-TVET', 'Fees amount of: 15000 paid for application with Reference Reff123 has been confirmed.Application is now marked as paid.', '2019-11-15 11:51:57'),
	(245, '0705555285', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-15 11:51:57'),
	(246, '07227194121', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-15 11:51:57'),
	(247, '0701102928', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-15 11:51:57'),
	(248, '0721382630', 'WILCOM-TVET', 'New application with Reference Reff123 has been submited and it\'s awaiting your review.', '2019-11-15 11:51:58'),
	(249, '0734470491', 'WILCOM-TVET', 'Dear ECTA KENYA LIMITED.A response for Application18 OF 2019has been sent by the Procuring Entity.', '2019-11-15 12:06:44'),
	(250, '0733299665', 'WILCOM-TVET', 'Dear STATE DEPARTMENT OF INTERIOR .Your response for Application18 OF 2019has been received.You will be notified when hearing date will be set.', '2019-11-15 12:06:44'),
	(251, '07227194121', 'WILCOM-TVET', 'Dear WILSON B. KEREBEI.PE has submited a response for Application18 OF 2019.You are required to form a panel and submit it for review.', '2019-11-15 12:06:44'),
	(252, '0705128595', 'WILCOM-TVET', 'Dear CMC MOTORS CORPORATION.A response for Application18 OF 2019has been sent by the Procuring Entity.', '2019-11-15 12:06:44'),
	(253, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 568004 Use this to activate your account.', '2019-11-15 12:12:04'),
	(254, '0720768894', 'WILCOM-TVET', 'Your Activation Code is: 166787 Use this to activate your account.', '2019-11-15 12:20:29'),
	(255, '07227194121', 'WILCOM-TVET', 'New Panel List for ApplicationNo:18 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-15 12:22:42'),
	(256, '0705555285', 'WILCOM-TVET', 'New Panel List for ApplicationNo:18 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-15 12:22:43'),
	(257, '0701102928', 'WILCOM-TVET', 'New Panel List for ApplicationNo:18 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-15 12:22:43'),
	(258, '0721382630', 'WILCOM-TVET', 'Your Activation Code is: 833798 Use this to activate your account.', '2019-11-15 12:37:36'),
	(259, '0722607128', 'WILCOM-TVET', 'Your Activation Code is: 211789 Use this to activate your account.', '2019-11-15 12:44:23'),
	(260, '0721382630', 'WILCOM-TVET', 'Your Activation Code is: 489501 Use this to activate your account.', '2019-11-15 12:45:52'),
	(261, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 290806 Use this to activate your account.', '2019-11-15 12:50:21'),
	(262, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 283751 Use this to activate your account.', '2019-11-15 12:59:07'),
	(263, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 524430 Use this to activate your account.', '2019-11-15 12:59:07'),
	(264, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 500759 Use this to activate your account.', '2019-11-15 12:59:07'),
	(265, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 703165 Use this to activate your account.', '2019-11-15 12:59:09'),
	(266, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 236302 Use this to activate your account.', '2019-11-15 12:59:10'),
	(267, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 605152 Use this to activate your account.', '2019-11-15 12:59:10'),
	(268, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 306684 Use this to activate your account.', '2019-11-15 12:59:11'),
	(269, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 785490 Use this to activate your account.', '2019-11-15 12:59:11'),
	(270, '0720768894', 'WILCOM-TVET', 'Your Activation Code is: 665796 Use this to activate your account.', '2019-11-15 12:59:31'),
	(271, '0722607127', 'WILCOM-TVET', 'Your Activation Code is: 853895 Use this to activate your account.', '2019-11-15 13:00:47'),
	(272, '0720768894', 'WILCOM-TVET', 'Your Activation Code is: 812360 Use this to activate your account.', '2019-11-15 13:00:57'),
	(273, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 666523 Use this to activate your account.', '2019-11-15 13:12:54'),
	(274, '0705555285', 'WILCOM-TVET', 'Your Activation Code is: 742549 Use this to activate your account.', '2019-11-15 14:13:25'),
	(275, '07227194121', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-16 10:33:31'),
	(276, '0705555285', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-16 10:33:31'),
	(277, '0701102928', 'WILCOM-TVET', 'New Panel List for ApplicationNo:16 OF 2019 has been submited and it\'s awaiting your review.', '2019-11-16 10:33:31');
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetSentHearingNotice`(IN _ApplicationNo VARCHAR(50))
BEGIN

Update hearingnotices set DateSent=now() where ApplicationNo=_ApplicationNo;

END//
DELIMITER ;

-- Dumping structure for procedure arcm.Signup
DROP PROCEDURE IF EXISTS `Signup`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Signup`(IN _Name VARCHAR(120), IN _Username VARCHAR(50), IN _Email VARCHAR(128), IN _Phone VARCHAR(20), IN _Password VARCHAR(128), IN _Category VARCHAR(50), IN _ActivationCode VARCHAR(100), IN _IDnumber VARCHAR(50), IN _DOB DATETIME)
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
DELETE FROM `smtpdetails`;
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

-- Dumping data for table arcm.stdtenderdocs: ~3 rows (approximately)
DELETE FROM `stdtenderdocs`;
/*!40000 ALTER TABLE `stdtenderdocs` DISABLE KEYS */;
INSERT INTO `stdtenderdocs` (`ID`, `Code`, `Description`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_By`) VALUES
	(10, 'STDOC-1', 'Civil Engineering Works', '2019-08-01 11:42:28', 'Admin', '2019-10-04 09:49:43', 'Admin', 0, NULL),
	(11, 'STDOC-2', 'Works(Building and associated)', '2019-08-01 11:43:04', 'Admin', '2019-08-01 11:45:21', 'Admin', 0, NULL),
	(12, 'STDOC-3', 'Tender Register', '2019-08-01 11:43:32', 'Admin', '2019-08-01 11:44:02', 'Admin', 0, NULL);
/*!40000 ALTER TABLE `stdtenderdocs` ENABLE KEYS */;

-- Dumping structure for procedure arcm.SubmitApplicationdecision
DROP PROCEDURE IF EXISTS `SubmitApplicationdecision`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitApplicationdecision`(IN _ApplicationNo varchar(50),IN _UserID varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitApprovedPanelList`(IN _UserID varchar(50),IN _ApplicationNo varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitCaseDecision`(IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50), IN _DecisionDate DATE, IN _Followup BOOLEAN, IN _Referral BOOLEAN, IN _Closed BOOLEAN, IN _ApplicationSuccessful BOOLEAN, IN _Annulled BOOLEAN, IN _GiveDirection BOOLEAN, IN _Terminated BOOLEAN, IN _ReTender BOOLEAN, IN _CostsPE BOOLEAN, IN _CostsApplicant BOOLEAN, IN _CostsEachParty BOOLEAN, IN _Substitution BOOLEAN)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitPanelList`(IN _UserID varchar(50),IN _ApplicationNo varchar(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitPePreliminaryObjection`(IN _RespID INT, IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SubmitPeResponse`(IN _RespID INT, IN _ApplicationNo VARCHAR(50), IN _UserID VARCHAR(50))
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tenderaddendums: ~6 rows (approximately)
DELETE FROM `tenderaddendums`;
/*!40000 ALTER TABLE `tenderaddendums` DISABLE KEYS */;
INSERT INTO `tenderaddendums` (`ID`, `TenderID`, `ApplicantID`, `Description`, `StartDate`, `ClosingDate`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `AdendumNo`) VALUES
	(1, 12, 0, 'CLARIFICATION FOLLOWING PRE-BID CONFERENCE', '2019-04-22 00:00:00', '2019-10-21 00:00:00', 'P0123456788X', '2019-11-11 15:48:54', NULL, NULL, 0, NULL, NULL, '1'),
	(2, 18, 0, 'CLARIFICATION 02', '2019-11-06 00:00:00', '2019-11-12 00:00:00', 'P0123456788X', '2019-11-12 16:43:21', NULL, NULL, 0, NULL, NULL, '1'),
	(3, 35, 0, 'PRE-BID CONFERENCE NOTES', '2019-10-17 00:00:00', '2019-10-01 00:00:00', 'P0123456788X', '2019-11-21 14:10:54', NULL, NULL, 0, NULL, NULL, '1'),
	(4, 36, 0, 'ADDENDUM 01', '2019-09-18 00:00:00', '2019-12-01 00:00:00', 'P0123456788X', '2019-11-21 14:28:07', NULL, NULL, 0, NULL, NULL, '1'),
	(5, 37, 0, 'ADDENDUM 01', '2019-09-18 00:00:00', '2019-11-14 00:00:00', 'P0123456788X', '2019-11-21 16:28:11', NULL, NULL, 0, NULL, NULL, '01'),
	(6, 40, 0, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa', '2019-11-13 00:00:00', '2019-11-22 00:00:00', 'P123456879Q', '2019-11-22 11:17:11', NULL, NULL, 0, NULL, NULL, '1');
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.tenders: ~26 rows (approximately)
DELETE FROM `tenders`;
/*!40000 ALTER TABLE `tenders` DISABLE KEYS */;
INSERT INTO `tenders` (`ID`, `TenderNo`, `Name`, `PEID`, `TenderValue`, `StartDate`, `ClosingDate`, `AwardDate`, `Created_By`, `Created_At`, `Updated_At`, `Updated_By`, `Deleted`, `Deleted_At`, `Deleted_By`, `TenderType`, `TenderSubCategory`, `TenderCategory`, `Timer`) VALUES
	(12, 'MOEST/ICT/02/2018-2019', 'DESIGN, DEVELOPMENT, TRAINING AND COMMISSIONING OF ONLINE EVENT TRACKING SYSTEM', 'PE-2', 5800000, '2019-04-12 00:00:00', '2019-04-12 00:00:00', '2019-11-11 00:00:00', 'P0123456788X', '2019-11-11 15:47:45', '2019-11-11 15:47:45', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(16, 'CGS/SCM/WENR/OT/18-19/081', 'TENDER FOR PROVISION OF COMPREHENSIVE MAINTENANCE SERVICE OF VARIABLE REFRIGERANT FLOW (VRF) AIR CONDITIONING SYSTEMS AT CENTRAL BANK OF KENYA, MOMBAS', 'PE-3', 0, '2019-10-29 00:00:00', '2019-10-29 00:00:00', '2019-11-12 00:00:00', 'P0123456788X', '2019-11-12 10:58:39', '2019-11-12 10:58:39', NULL, 0, NULL, NULL, 'B', 'Simple', 'Pre-qualification', 'Submited within 14 days'),
	(17, 'UON/ICT/2019-2020', 'POS HARDWARE FOR UNES BOKKSHOP', 'PE-3', 2500000, '2019-11-12 00:00:00', '2019-11-12 00:00:00', '2019-11-05 00:00:00', 'P0123456788X', '2019-11-12 15:45:25', '2019-11-12 15:45:25', NULL, 0, NULL, NULL, 'A', 'Complex', 'Pre-qualification', 'Submited within 14 days'),
	(18, 'MOE/VTT/ICT/2018-2019', 'TVET MIS SUPPORT', 'PE-2', 0, '2019-11-15 00:00:00', '2019-11-15 00:00:00', '2019-11-11 00:00:00', 'P0123456788X', '2019-11-12 16:42:14', '2019-11-12 16:42:14', NULL, 0, NULL, NULL, 'B', 'Complex', 'Pre-qualification', 'Submited within 14 days'),
	(21, 'CGS/SCM/WENR/OT/18-19/081', 'PROPOSED ESTABLISHMENT OF TREE NURSERIES AND TREE SEEDLINGS IN UGUNJA', 'PE-3', 0, '2019-11-21 00:00:00', '2019-11-21 00:00:00', '2019-11-05 00:00:00', 'P0123456788X', '2019-11-13 11:14:12', '2019-11-13 11:14:12', NULL, 0, NULL, NULL, 'B', 'Medium', 'Unquantified Tenders', 'Submited within 14 days'),
	(22, 'TNDE/0001/2019', 'and in addition to this if fou', 'PE-2', 1200000, '2019-11-13 00:00:00', '2019-11-13 00:00:00', '2019-11-13 00:00:00', 'P09875345W', '2019-11-13 17:04:41', '2019-11-13 17:04:41', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(23, 'TNDE/0001/2019', 'and in addition to this if fou', 'PE-2', 42000000, '2019-11-13 00:00:00', '2019-11-13 00:00:00', '2019-11-13 00:00:00', 'P09875345W', '2019-11-13 17:05:22', '2019-11-13 17:05:22', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(24, 'TNDE/0001/2019', 'and in addition to this if fou', 'PE-2', 102000000, '2019-11-13 00:00:00', '2019-11-13 00:00:00', '2019-11-13 00:00:00', 'P09875345W', '2019-11-13 17:05:54', '2019-11-13 17:05:54', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(25, 'TNDE/0001/2019', 'and in addition to this if fou', 'PE-2', 0, '2019-11-13 00:00:00', '2019-11-13 00:00:00', '2019-11-13 00:00:00', 'P09875345W', '2019-11-13 17:07:39', '2019-11-13 17:07:39', NULL, 0, NULL, NULL, 'B', 'Simple', 'Other Tenders', 'Submited within 14 days'),
	(26, 'TNDE/0001/2019', 'and in addition to this if fou', 'PE-2', 0, '2019-11-13 00:00:00', '2019-11-13 00:00:00', '2019-11-13 00:00:00', 'P09875345W', '2019-11-13 17:08:00', '2019-11-13 17:08:00', NULL, 0, NULL, NULL, 'B', 'Simple', 'Other Tenders', 'Submited within 14 days'),
	(27, 'TNDE/0001/2019', 'PROVISION OF SECURITY GUARDING SERVICES', 'PE-3', 0, '2019-11-01 00:00:00', '2019-11-01 00:00:00', '2019-11-20 00:00:00', 'P0123456788X', '2019-11-14 14:45:01', '2019-11-21 11:55:52', 'P0123456788X', 0, NULL, NULL, 'B', 'Simple', 'Unquantified Tenders', 'Submited within 14 days'),
	(28, 'SDI/MISNG/004/2019-2020', 'LEASE OF MOTOR VEHICLES', 'PE-4', 1000000000, '2019-10-10 00:00:00', '2019-10-10 00:00:00', '2019-11-01 00:00:00', 'P123456879Q', '2019-11-15 10:55:16', '2019-11-15 10:55:16', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(29, 'TNDE/0001/2019', 'Tender test', 'PE-2', 120000, '2019-11-15 00:00:00', '2019-11-15 00:00:00', '2019-11-15 00:00:00', 'P0123456788X', '2019-11-15 11:49:58', '2019-11-15 11:49:58', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(30, 'TNDE/0001/2019', 'Tender of value more than 50M', 'PE-2', 2000000000, '2019-11-20 00:00:00', '2019-11-20 00:00:00', '2019-11-20 00:00:00', 'P09875345W', '2019-11-20 10:47:42', '2019-11-20 10:47:42', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(31, 'TNDE/0001/2019', 'Tender of value more than 50M', 'PE-2', 2000000000, '2019-11-20 00:00:00', '2019-11-20 00:00:00', '2019-11-20 00:00:00', 'P09875345W', '2019-11-20 10:51:53', '2019-11-20 10:51:53', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(32, 'TNDE/0001/2019', 'Tender of value more than 50M', 'PE-2', 2000000, '2019-11-20 00:00:00', '2019-11-20 00:00:00', '2019-11-20 00:00:00', 'P09875345W', '2019-11-20 10:52:29', '2019-11-20 10:52:29', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(33, 'TNDE/0001/2019', 'Tender of value more than 50M', 'PE-2', 500000, '2019-11-20 00:00:00', '2019-11-20 00:00:00', '2019-11-20 00:00:00', 'P09875345W', '2019-11-20 10:52:50', '2019-11-20 10:52:50', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(34, 'TNDE/0001/2019', 'Tender of value more than 50M', 'PE-2', 50000000, '2019-11-20 00:00:00', '2019-11-20 00:00:00', '2019-11-20 00:00:00', 'P09875345W', '2019-11-20 10:53:16', '2019-11-20 10:53:16', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(35, 'UON/ICT/2019-2020', 'DESIGN AND DEVELOPMENT OF STUDENT PORTAL\n', 'PE-1', 575000, '2019-10-01 00:00:00', '2019-10-01 00:00:00', '2019-11-18 00:00:00', 'P0123456788X', '2019-11-21 14:09:33', '2019-11-21 14:09:33', NULL, 0, NULL, NULL, 'A', '', '', 'Submited within 14 days'),
	(36, 'MOE/PPRA/UAT/2019-2020', 'CONSULTANCY TO CARRYOUT PPRA UAT', 'PE-2', 785000, '2019-10-01 00:00:00', '2019-10-01 00:00:00', '2019-11-14 00:00:00', 'P0123456788X', '2019-11-21 14:27:18', '2019-11-21 14:27:18', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(37, 'MOE/PRA/UAT/01/2019-2020', 'PPRA ARCMS UAT 01', 'PE-2', 1000000000, '2019-10-03 00:00:00', '2019-10-03 00:00:00', '2019-11-14 00:00:00', 'P0123456788X', '2019-11-21 16:27:25', '2019-11-21 16:27:25', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(38, 'KAA/OT/JKIA/1343/2017-2018', 'Installation, Operation and Maintenance of an Automated Car Parking Management System at Jomo Kenyatta International Airport, Nairobi', 'PE-2', 0, '2019-11-21 00:00:00', '2019-11-21 00:00:00', '2019-11-21 00:00:00', 'P0123456788X', '2019-11-21 21:14:46', '2019-11-21 21:14:46', NULL, 0, NULL, NULL, 'B', NULL, 'Other Tenders', 'Submited within 14 days'),
	(39, 'Tender 1', 'Tender 2', 'PE-2', 1000000, '2019-11-21 00:00:00', '2019-11-21 00:00:00', '2019-11-21 00:00:00', 'P0123456788X', '2019-11-21 21:39:44', '2019-11-21 21:39:44', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(40, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa', 'PE-4', 500000000, '2019-11-21 00:00:00', '2019-11-21 00:00:00', '2019-11-22 00:00:00', 'P123456879Q', '2019-11-22 11:16:49', '2019-11-22 11:16:49', NULL, 0, NULL, NULL, 'A', NULL, 'Pre-qualification', 'Submited within 14 days'),
	(41, 'TENDER/0001/2019/2020', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean', 'PE-4', 500000000, '2019-11-20 00:00:00', '2019-11-20 00:00:00', '2019-11-20 00:00:00', 'P123456879Q', '2019-11-22 11:26:40', '2019-11-22 11:32:55', 'P123456879Q', 0, NULL, NULL, 'A', NULL, 'Pre-qualification', 'Submited within 14 days'),
	(42, 'TENDER/0001/2019/2020', 'Tender Name 2', 'PE-2', 5000000, '2019-11-26 00:00:00', '2019-11-26 00:00:00', '2019-11-26 00:00:00', 'P0123456788X', '2019-11-26 14:35:27', '2019-11-26 14:35:27', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(43, 'TENDER/0001/2019/2020', 'Tender 3', 'PE-1', 2000000, '2019-11-26 00:00:00', '2019-11-26 00:00:00', '2019-11-26 00:00:00', 'P0123456788X', '2019-11-26 15:21:11', '2019-11-26 15:21:11', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(44, 'TENDER/0001/2019/2020', 'TENDER/0001/2019/2020', 'PE-1', 20000000, '2019-11-28 00:00:00', '2019-11-28 00:00:00', '2019-11-28 00:00:00', 'P0123456788X', '2019-11-28 15:34:35', '2019-11-28 15:42:06', 'P0123456788X', 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(45, 'TENDER/0001/2019/2020', 'TENDER/0001/2019/2020', 'PE-1', 5000000, '2019-11-28 00:00:00', '2019-11-28 00:00:00', '2019-11-28 00:00:00', 'P0123456788X', '2019-11-28 15:47:17', '2019-11-28 15:47:17', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(46, 'dbForge Data Compare for PostgreSQL', 'dbForge Data Compare for PostgreSQL', 'PE-2', 2500000, '2019-11-29 00:00:00', '2019-11-29 00:00:00', '2019-11-29 00:00:00', 'P0123456788X', '2019-11-29 09:16:32', '2019-11-29 09:16:32', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days'),
	(47, 'TENDER/0001/2019/2020', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean', 'PE-2', 1200000, '2019-12-02 00:00:00', '2019-12-02 00:00:00', '2019-12-02 00:00:00', 'P0123456788X', '2019-12-02 14:31:21', '2019-12-02 14:31:21', NULL, 0, NULL, NULL, 'A', NULL, '', 'Submited within 14 days');
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
	(1, 'A', 'Tenders of Ascertainable Value', '2019-10-22 15:25:51', 'Admin', '2019-10-22 15:25:51', 'Admin', 0, NULL),
	(2, 'B', 'Tenders of Unascertainable Value', '2019-10-22 15:26:33', 'Admin', '2019-10-22 15:26:33', 'Admin', 0, NULL);
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `TrackApplicationSequence`(IN _ApplicationNo varchar(50))
BEGIN
select * from applicationsequence where ApplicationNo=_ApplicationNo order by ID ASC;
END//
DELIMITER ;

-- Dumping structure for procedure arcm.UnBookVenue
DROP PROCEDURE IF EXISTS `UnBookVenue`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UnBookVenue`(IN _VenueID INT(11),IN _Date DATETIME,IN _Slot VARCHAR(50),IN _UserID varchar(50),IN _Content VARCHAR(255))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCaseOfficers`(IN _Username VARCHAR(50), IN _Active BOOLEAN, IN _NotAvailableFrom DATETIME, IN _NotAvailableTo DATETIME, IN _UserID VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGroupRoles`(IN `_UserGroupID` BIGINT, IN `_RoleID` BIGINT, IN `_Status` BOOLEAN, IN `_Desc` VARCHAR(50), IN `_userID` VARCHAR(50))
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `Updatepassword`(IN _Password VARCHAR(128), IN _Username VARCHAR(50))
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
set lSaleDesc= CONCAT('Changed User Photo for user: ',_username ); 

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
set lSaleDesc= CONCAT('Updated Role  name:' ,_RoleName); 
UPDATE roles set RoleName=_RoleName, RoleDescription=__RoleDescription, UpdatedAt=now() ,UpdateBy=_userID
Where RoleID=_RoleID;
call SaveAuditTrail(_userID,lSaleDesc,'Update','0' );
End//
DELIMITER ;

-- Dumping structure for procedure arcm.UpdateSentjudicialreviewUpdate
DROP PROCEDURE IF EXISTS `UpdateSentjudicialreviewUpdate`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSentjudicialreviewUpdate`()
BEGIN
update judicialreviewdocuments set ActionSent='Yes';
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser`(IN _Name VARCHAR(128), IN _Email VARCHAR(128), IN _UserGroup BIGINT, IN _username VARCHAR(50), IN _IsActive BOOLEAN, IN _userID VARCHAR(50), IN _Phone VARCHAR(20), IN _Signature VARCHAR(128), IN _IDnumber VARCHAR(50), IN _DOB DATETIME, IN _Gender VARCHAR(50), IN _Board BOOLEAN)
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

-- Dumping data for table arcm.useraccess: ~463 rows (approximately)
DELETE FROM `useraccess`;
/*!40000 ALTER TABLE `useraccess` DISABLE KEYS */;
INSERT INTO `useraccess` (`Username`, `RoleID`, `Edit`, `Remove`, `AddNew`, `View`, `Export`, `UpdateBy`, `CreateBy`, `CreatedAt`, `UpdatedAt`) VALUES
	('A123456789U', 26, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 32, 1, 1, 0, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 33, 0, 0, 0, 0, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 36, 1, 1, 0, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 38, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 40, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 41, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 42, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 43, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 44, 1, 1, 1, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 45, 1, 1, 1, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 47, 1, 0, 1, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 50, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 51, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 55, 0, 0, 0, 1, 0, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 56, 1, 0, 1, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 57, 1, 1, 1, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 58, 1, 1, 1, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789U', 62, 1, 1, 1, 1, 1, NULL, 'A123456789U', '2019-11-12 13:41:58', NULL),
	('A123456789X', 26, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 32, 1, 1, 0, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 33, 0, 0, 0, 0, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 36, 1, 1, 0, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 38, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 40, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 41, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 42, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 43, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 44, 1, 1, 1, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 45, 1, 1, 1, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 47, 1, 0, 1, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 50, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 51, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 55, 0, 0, 0, 1, 0, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 56, 1, 0, 1, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 57, 1, 1, 1, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 58, 1, 1, 1, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 62, 1, 1, 1, 1, 1, NULL, 'A123456789X', '2019-11-11 16:26:50', NULL),
	('A123456789X', 79, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-21 16:11:44', '2019-11-21 16:11:44'),
	('A123456789X', 80, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-21 16:11:45', '2019-11-21 16:11:45'),
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
	('CASEOFFICER01', 24, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 25, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 26, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 27, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 33, 0, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 35, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 36, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 37, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 38, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 39, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 40, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 42, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 43, 0, 0, 0, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 44, 0, 1, 0, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 45, 0, 1, 0, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 46, 1, 1, 0, 0, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 47, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 48, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 49, 0, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 50, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 51, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 52, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 53, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 54, 1, 1, 1, 1, 1, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 55, 0, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 56, 1, 1, 1, 1, 0, 'Admin', 'PPRA01', '2019-11-11 15:34:20', '2019-11-29 11:00:24'),
	('CASEOFFICER01', 57, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 58, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 59, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 60, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 61, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 62, 0, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 63, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('CASEOFFICER01', 64, 1, 1, 1, 1, 0, 'PPRA01', 'PPRA01', '2019-11-11 15:34:20', '2019-11-11 15:34:20'),
	('P0000000001', 26, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 32, 1, 1, 0, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 33, 0, 0, 0, 0, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 36, 1, 1, 0, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 38, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 40, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 41, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 42, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 43, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 44, 1, 1, 1, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 45, 1, 1, 1, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 47, 1, 0, 1, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 50, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 51, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 55, 0, 0, 0, 1, 0, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 56, 1, 0, 1, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 57, 1, 1, 1, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 58, 1, 1, 1, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0000000001', 62, 1, 1, 1, 1, 1, NULL, 'P0000000001', '2019-11-21 11:31:03', NULL),
	('P0123456788X', 26, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 32, 1, 1, 0, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 33, 0, 0, 0, 0, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 36, 1, 1, 0, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 38, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 40, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 41, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 42, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 43, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 44, 1, 1, 1, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 45, 1, 1, 1, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 47, 1, 0, 1, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 50, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 51, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 55, 0, 0, 0, 1, 0, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 56, 1, 0, 1, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 57, 1, 1, 1, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 58, 1, 1, 1, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 62, 1, 1, 1, 1, 1, NULL, 'P0123456788X', '2019-11-11 15:41:19', NULL),
	('P0123456788X', 79, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-21 16:11:01', '2019-11-21 16:11:01'),
	('P0123456788X', 80, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-21 16:11:02', '2019-11-21 16:11:02'),
	('P09875345W', 26, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 32, 1, 1, 0, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 33, 0, 0, 0, 0, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 36, 1, 1, 0, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 38, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 40, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 41, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 42, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 43, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 44, 1, 1, 1, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 45, 1, 1, 1, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 47, 1, 0, 1, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 50, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 51, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 55, 0, 0, 0, 1, 0, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 56, 1, 0, 1, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 57, 1, 1, 1, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 58, 1, 1, 1, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P09875345W', 62, 1, 1, 1, 1, 1, NULL, 'P09875345W', '2019-11-13 14:56:01', NULL),
	('P121212121L', 26, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 32, 1, 1, 0, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 33, 0, 0, 0, 0, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 36, 1, 1, 0, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 38, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 40, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 41, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 42, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 43, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 44, 1, 1, 1, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 45, 1, 1, 1, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 47, 1, 0, 1, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 50, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 51, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 55, 0, 0, 0, 1, 0, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 56, 1, 0, 1, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 57, 1, 1, 1, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 58, 1, 1, 1, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P121212121L', 62, 1, 1, 1, 1, 1, NULL, 'P121212121L', '2019-11-15 12:12:49', NULL),
	('P123456879Q', 26, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 32, 1, 1, 0, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 33, 0, 0, 0, 0, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 36, 1, 1, 0, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 38, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 40, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 41, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 42, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 43, 0, 0, 0, 1, 0, 'Admin', 'P123456879Q', '2019-11-15 10:39:06', '2019-11-22 10:57:25'),
	('P123456879Q', 44, 1, 1, 1, 1, 0, 'Admin', 'P123456879Q', '2019-11-15 10:39:06', '2019-11-22 10:54:28'),
	('P123456879Q', 45, 1, 1, 1, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 47, 1, 0, 1, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 50, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 51, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 55, 0, 0, 0, 1, 0, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 56, 1, 0, 1, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 57, 1, 1, 1, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 58, 1, 1, 1, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 62, 1, 1, 1, 1, 1, NULL, 'P123456879Q', '2019-11-15 10:39:06', NULL),
	('P123456879Q', 79, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-22 10:54:21', '2019-11-22 10:54:21'),
	('P123456879Q', 80, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-22 10:54:22', '2019-11-22 10:54:22'),
	('P65498745R', 26, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 32, 1, 1, 0, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 33, 0, 0, 0, 0, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 36, 1, 1, 0, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 38, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 40, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 41, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 42, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 43, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 44, 1, 1, 1, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 45, 1, 1, 1, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 47, 1, 0, 1, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 50, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 51, 0, 0, 1, 1, 0, 'Admin', 'P65498745R', '2019-11-15 11:46:48', '2019-11-22 11:03:34'),
	('P65498745R', 55, 0, 0, 0, 1, 0, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 56, 1, 0, 1, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 57, 1, 1, 1, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 58, 1, 1, 1, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
	('P65498745R', 62, 1, 1, 1, 1, 1, NULL, 'P65498745R', '2019-11-15 11:46:48', NULL),
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
	('PPRA01', 17, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 18, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 19, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 20, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 21, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 22, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 23, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 24, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 25, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 26, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 27, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 28, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 29, 0, 0, 0, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 30, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 31, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 32, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 33, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 34, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 35, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 36, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 37, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 38, 1, 1, 1, 1, 0, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 39, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 40, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 41, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 42, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 43, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 44, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 45, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 46, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 47, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 48, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 49, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 50, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 51, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 52, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 53, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 54, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 55, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 56, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 57, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 58, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 59, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 60, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 61, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 62, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 63, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
	('PPRA01', 64, 1, 1, 1, 1, 1, 'Admin', 'Admin', '2019-11-11 15:19:43', '2019-11-11 15:19:43'),
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

-- Dumping data for table arcm.users: ~15 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`Name`, `Username`, `Email`, `Password`, `Phone`, `Create_at`, `Update_at`, `Login_at`, `Deleted`, `IsActive`, `IsEmailverified`, `ActivationCode`, `ResetPassword`, `UserGroupID`, `CreatedBy`, `UpdatedBy`, `Photo`, `Category`, `Signature`, `IDnumber`, `Gender`, `DOB`, `ChangePassword`, `Board`) VALUES
	('University of Nairobi', 'A123456789U', 'kserem20@gmail.com', '$2b$10$/xdWc9xaT227CFc8yXK3XuLCPat.kpSL63We0nrSQOxsKhhB/HY4G', '0700392599', '2019-11-12 13:41:58', NULL, NULL, 0, 1, 1, 'lXkDW', NULL, 8, 'A123456789U', NULL, 'default.png', 'PE', NULL, 'A123456789U', NULL, '2019-09-01 00:00:00', 0, 0),
	('MINISTRY OF EDUCATION', 'A123456789X', 'elviskimcheruiyot@gmail.com', '$2b$10$wnGcZGX.rgUqB1lEVU2kleMogBMyQkHwc7cesgoGFIHa3mccBSs0e', '0701102928', '2019-11-11 16:26:50', '2019-11-26 15:31:47', NULL, 0, 1, 1, 'Xz1rd', NULL, 8, 'A123456789X', 'Admin', 'default.png', 'PE', NULL, 'A123456789X', NULL, '1963-12-12 00:00:00', 0, 0),
	('Elvis kimutai', 'Admin', 'elviskcheruiyot@gmail.com', '$2b$10$W5YQ2FfNM3pc7poT7Blpz.Rws/nb6zHPo88EU0C1O0BEIWbrssWH6', '0705555285', '2019-07-12 15:50:56', '2019-11-26 14:56:57', '2019-07-12 15:50:56', 0, 1, 1, 'QDrts', '', 1, 'kim', 'Admin', '1573655832969-download.jpg', 'System_User', '1565251011001-signature.jpg', '31547833', 'Male', '1994-12-31 00:00:00', NULL, 1),
	('CASE OFFICER', 'CASEOFFICER01', 'cmkikungu@gmail.com1', '$2b$10$W5YQ2FfNM3pc7poT7Blpz.Rws/nb6zHPo88EU0C1O0BEIWbrssWH6', '070110292812', '2019-11-11 15:34:20', NULL, NULL, 0, 1, 1, '0c3R5', NULL, 9, 'PPRA01', NULL, 'default.png', 'System_User', '', '23456789', 'Male', '2019-10-28 00:00:00', 1, 1),
	('KENYA POLICE SERVICE', 'P0000000001', 'sales@Wilcom.co.ke', '$2b$10$K6bemATl6bhF8aIzhrt7AOMxyjN1OOZiboWaaAXlbTt.vdNOIfgnG', '0766944664', '2019-11-21 11:31:03', '2019-11-26 14:56:46', NULL, 0, 1, 0, 'AXwwC', NULL, 8, 'P0000000001', 'Admin', 'default.png', 'PE', NULL, '0', NULL, '1963-12-12 00:00:00', 0, 0),
	('JAMES SUPPLIERS LTD', 'P0123456788X', 'KEREBEI@HOTMAIL.COM1', '$2b$10$xlt0b6DmhvHrO1XrmLjp9O78NkSjzo40Dcs1vc07BANYUpXdtaBbe', '07184030861', '2019-11-11 15:41:19', '2019-11-21 11:52:42', NULL, 0, 1, 1, 'AymPi', NULL, 8, 'P0123456788X', 'P0123456788X', '1574337159446-Kerebei PP Photo.jpg', 'Applicant', NULL, 'P0123456788X', NULL, '2000-12-08 00:00:00', 0, 0),
	('APPLICANT LTD', 'P09875345W', 'info@wilcom.co.ke', '$2b$10$W5YQ2FfNM3pc7poT7Blpz.Rws/nb6zHPo88EU0C1O0BEIWbrssWH6', '0722114567', '2019-11-13 14:56:01', NULL, NULL, 0, 1, 1, 'l7XVZ', NULL, 8, 'P09875345W', NULL, 'default.png', 'Applicant', NULL, 'P09875345W', NULL, '2019-10-01 00:00:00', 1, 0),
	('ECTA KENYA LIMITED', 'P121212121L', 'pjokumu@hotmail.com1', '$2b$10$SdLj45h5bK7eqsLEz3LpTu95mIaGygUjTODe.ATYDFMeh89b0dyxK', '0734479491', '2019-11-15 12:12:49', NULL, NULL, 0, 0, 0, 'wfLdf', NULL, 8, 'P121212121L', NULL, 'default.png', 'Applicant', NULL, 'P121212121L', NULL, '2014-10-10 00:00:00', 1, 0),
	('CMC MOTORS CORPORATION', 'P123456879Q', 'judiejuma@gmail.com1', '$2b$10$W1Z/ojsrv9vvHjZ7.WB5UOlRxhIUrsFrpISvjV3Nb0sPXjfKymDQO', '0705128595', '2019-11-15 10:39:06', NULL, NULL, 0, 1, 1, 'x1RNQ', NULL, 8, 'P123456879Q', NULL, 'default.png', 'Applicant', NULL, 'P123456879Q', NULL, '1980-08-12 00:00:00', 0, 0),
	('STATE DEPARTMENT OF INTERIOR ', 'P65498745R', 'judyjay879@gmail.com1', '$2b$10$gO.U6rOmx94CG.xF8dZJcea0P8BBAdvFtLUg31Y4h8VQjLr2LR3JS', '0718403086', '2019-11-15 11:46:48', NULL, NULL, 0, 1, 1, '8cj9S', NULL, 8, 'P65498745R', NULL, 'default.png', 'PE', NULL, 'P65498745R', NULL, '1963-12-12 00:00:00', 1, 0),
	('Philemon Kiprop', 'pkiprop', 'philchem2009@gmail.com1', '$2b$10$2vVCH1AbRn3gRUaNcsFzIeEO2bmSw9aGRDBwRiqC91a/JEDeb6sQu', '07229554581', '2019-11-15 10:38:19', NULL, NULL, 0, 1, 0, 'Zhvpe', NULL, 9, 'SOdhiambo', NULL, 'default.png', 'System_User', '', '123456', 'Male', '2019-11-15 00:00:00', 1, 0),
	('Philip Okumu', 'Pokumu', 'okumupj@yahoo.com1', '$2b$10$zy83GCav50YXdXDIGr1uq.q3eNTGdRQWFc0CJfqY1VI63xbDMfDnq', '07207688941', '2019-11-15 10:28:49', '2019-11-15 10:29:46', NULL, 0, 1, 1, 'MwEe2', NULL, 9, 'Admin', 'Admin', 'default.png', 'System_User', '', '10811856', 'Male', '1970-01-01 00:00:00', 1, 0),
	('WILSON B. KEREBEI', 'PPRA01', 'wkerebei@gmail.com1', '$2b$10$ICLCDuzBJpmhS5msvd1KwOTbg8NmbaZlEg62iHOhwLzhPWQg9P.pC', '07227194121', '2019-11-11 15:19:43', '2019-11-11 15:22:14', NULL, 0, 1, 1, 'tyCON', NULL, 1, 'Admin', 'PPRA01', '1573485732625-IMG_20190705_162423_7.jpg', 'System_User', '', '123456789', 'Male', '1980-12-12 00:00:00', 1, 1),
	('Stanley Miheso', 'smiheso', 'mihesosc@yahoo.com1', '$2b$10$.2VIwiMBs4xGuPrwdp7IOupE0YK1FExuQ3fFuxQOT8Weh7zYLtCHK', '07226071271', '2019-11-15 12:41:09', '2019-11-15 12:49:31', NULL, 0, 1, 1, 'SQFjZ', NULL, 9, 'SOdhiambo', 'SOdhiambo', 'default.png', 'System_User', '', '9136339', 'Male', '2004-09-07 00:00:00', 1, 1),
	('Samson Odhiambo', 'SOdhiambo', 'x2press@gmail.com1', '$2b$10$IVW/TndrqUkbsuh3AhxCqeRrbetmP.TZyXRTZylbMsZjNDLfJScjK', '07213826301', '2019-11-15 10:24:58', '2019-11-15 10:30:18', NULL, 0, 1, 1, 'GbO8J', NULL, 1, 'Admin', 'SOdhiambo', 'default.png', 'System_User', '', '20566933', 'Male', '1983-01-01 00:00:00', 1, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.venuebookings: ~37 rows (approximately)
DELETE FROM `venuebookings`;
/*!40000 ALTER TABLE `venuebookings` DISABLE KEYS */;
INSERT INTO `venuebookings` (`ID`, `VenueID`, `Date`, `Slot`, `Booked_By`, `Content`, `Booked_On`, `Deleted`) VALUES
	(1, 6, '2019-11-14', '8.00AM', 'Admin', '17 OF 2019', '2019-11-14 16:30:51', 0),
	(2, 6, '2019-11-14', '8.00AM', 'Admin', '17 OF 2019', '2019-11-14 16:33:49', 0),
	(3, 6, '2019-11-18', '2.00PM', 'Admin', '18 OF 2019', '2019-11-15 12:34:32', 0),
	(4, 6, '2019-11-18', '3.00AM', 'Admin', '18 OF 2019', '2019-11-15 12:34:32', 0),
	(5, 6, '2019-11-18', '5.00AM', 'Admin', '18 OF 2019', '2019-11-15 12:34:32', 0),
	(6, 6, '2019-11-18', '4.00AM', 'Admin', '18 OF 2019', '2019-11-15 12:34:32', 0),
	(7, 6, '2019-11-15', '1.00PM', 'Admin', '18 OF 2019', '2019-11-15 12:46:03', 1),
	(8, 6, '2019-11-15', '2.00AM', 'Admin', '18 OF 2019', '2019-11-15 12:46:03', 0),
	(9, 6, '2019-11-15', '3.00AM', 'Admin', '18 OF 2019', '2019-11-15 12:58:22', 0),
	(10, 6, '2019-11-15', '2.00PM', 'Admin', '18 OF 2019', '2019-11-15 12:58:22', 0),
	(11, 6, '2019-11-15', '4.00AM', 'Admin', '18 OF 2019', '2019-11-15 12:58:23', 0),
	(12, 5, '2019-11-16', '10.00AM', 'Admin', '17 OF 2019', '2019-11-16 10:10:57', 0),
	(13, 5, '2019-11-17', '8.00AM', 'Admin', '16 OF 2019', '2019-11-17 12:11:41', 1),
	(14, 5, '2019-11-17', '9.00AM', 'Admin', '16 OF 2019', '2019-11-17 12:13:09', 1),
	(15, 5, '2019-11-17', '9.00AM', 'Admin', '16 OF 2019', '2019-11-17 12:13:17', 0),
	(16, 5, '2019-11-17', '8.00AM', 'Admin', '16 OF 2019', '2019-11-17 12:13:25', 0),
	(17, 5, '2019-11-17', '10.00AM', 'Admin', '16 OF 2019', '2019-11-17 12:13:41', 0),
	(18, 5, '2019-11-17', '11.00AM', 'Admin', '16 OF 2019', '2019-11-17 12:13:41', 1),
	(19, 5, '2019-11-17', '11.00AM', 'Admin', '16 OF 2019', '2019-11-17 12:13:48', 0),
	(20, 5, '2019-11-20', '8.00AM', 'Admin', '16 OF 2019', '2019-11-20 11:05:28', 1),
	(21, 5, '2019-11-20', '9.00AM', 'Admin', '12 OF 2019', '2019-11-20 12:24:53', 1),
	(22, 5, '2019-11-20', '9.00AM', 'Admin', '12 OF 2019', '2019-11-20 12:25:50', 1),
	(23, 5, '2019-11-20', '9.00AM', 'Admin', '12 OF 2019', '2019-11-20 12:28:18', 1),
	(24, 5, '2019-11-20', '9.00AM', 'Admin', '12 OF 2019', '2019-11-20 12:35:54', 1),
	(25, 5, '2019-11-20', '8.00AM', 'Admin', '12 OF 2019', '2019-11-20 12:36:01', 0),
	(26, 5, '2019-11-20', '9.00AM', 'Admin', '12 OF 2019', '2019-11-20 12:53:30', 1),
	(27, 5, '2019-11-20', '9.00AM', 'Admin', '12 OF 2019', '2019-11-20 12:57:14', 0),
	(28, 5, '2019-11-20', '10.00AM', 'Admin', '12 OF 2019', '2019-11-20 13:42:23', 1),
	(29, 5, '2019-11-20', '10.00AM', 'Admin', '12 OF 2019', '2019-11-20 13:44:24', 1),
	(30, 5, '2019-11-20', '10.00AM', 'Admin', '12 OF 2019', '2019-11-20 13:45:47', 0),
	(31, 5, '2019-11-20', '11.00AM', 'Admin', '20 OF 2019', '2019-11-20 15:50:16', 0),
	(32, 6, '2019-11-25', '9.00AM', 'Admin', '23 OF 2019', '2019-11-21 18:28:52', 0),
	(33, 6, '2019-11-21', '9.00AM', 'Admin', '23 OF 2019', '2019-11-21 18:30:33', 0),
	(34, 8, '2019-11-22', '2.00PM', 'Admin', '29 OF 2019', '2019-11-22 13:17:19', 0),
	(35, 8, '2019-11-22', '4.00AM', 'Admin', '29 OF 2019', '2019-11-22 13:17:19', 0),
	(36, 8, '2019-11-22', '3.00AM', 'Admin', '29 OF 2019', '2019-11-22 13:17:19', 0),
	(37, 5, '2019-11-23', '8.00AM', 'Admin', '12 OF 2019', '2019-11-23 12:53:52', 0),
	(38, 8, '2019-11-28', '8.00AM', 'Admin', '28 OF 2019', '2019-11-28 13:36:55', 0),
	(39, 5, '2019-11-28', '8.00AM', 'Admin', '30 OF 2019', '2019-11-28 16:10:39', 0),
	(40, 5, '2019-11-28', '9.00AM', 'Admin', '30 OF 2019', '2019-11-28 16:12:40', 0),
	(41, 5, '2019-11-29', '8.00AM', 'Admin', '31 OF 2019', '2019-11-29 10:28:34', 0),
	(42, 5, '2019-12-02', '8.00AM', 'Admin', '32 OF 2019', '2019-12-02 16:20:54', 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table arcm.venues: ~8 rows (approximately)
DELETE FROM `venues`;
/*!40000 ALTER TABLE `venues` DISABLE KEYS */;
INSERT INTO `venues` (`ID`, `Name`, `Branch`, `Description`, `Deleted`, `Created_At`, `Created_By`, `Updated_At`, `Updated_By`) VALUES
	(1, 'Board room 1', 0, 'Board room 1 Updated', 1, '2019-09-11 10:49:34', 'Admin', '2019-09-11 10:58:15', 'Admin'),
	(2, 'Board Room1', 0, '10th Floor', 0, '2019-09-11 14:47:48', 'Admin', NULL, NULL),
	(3, 'Board Room 1', 15, 'Room 1', 1, '2019-09-18 10:51:37', 'Admin', NULL, NULL),
	(4, 'Room 1', 14, 'Main Board room', 0, '2019-09-18 10:52:47', 'Admin', '2019-10-04 10:13:26', 'Admin'),
	(5, 'Room 1', 12, 'Room 1', 0, '2019-09-18 14:34:26', 'Admin', NULL, NULL),
	(6, 'Room 1', 15, 'Room 1', 0, '2019-09-18 14:34:33', 'Admin', NULL, NULL),
	(7, 'Room2', 14, 'Room2', 0, '2019-09-18 16:53:06', 'Admin', NULL, NULL),
	(8, 'DC\'s Office', 16, 'Kitale', 0, '2019-11-22 13:11:44', 'Admin', NULL, NULL);
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
