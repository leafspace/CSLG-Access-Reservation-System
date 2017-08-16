/*
Navicat MySQL Data Transfer

Source Server         : Raspberry
Source Server Version : 50555
Source Host           : 192.168.155.2:3306
Source Database       : CSLG_Access_reservation_system

Target Server Type    : MYSQL
Target Server Version : 50555
File Encoding         : 65001

Date: 2017-08-15 23:38:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ActivityRooms
-- ----------------------------
DROP TABLE IF EXISTS `ActivityRooms`;
CREATE TABLE `ActivityRooms` (
  `room_Id` int(11) NOT NULL AUTO_INCREMENT,
  `room_name` varchar(20) NOT NULL,
  `information` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`room_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ActivityRooms
-- ----------------------------
INSERT INTO `ActivityRooms` VALUES ('1', 'N6 五楼活动室', 'N6-507');

-- ----------------------------
-- Table structure for Open
-- ----------------------------
DROP TABLE IF EXISTS `Open`;
CREATE TABLE `Open` (
  `index` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Open
-- ----------------------------
INSERT INTO `Open` VALUES ('0');

-- ----------------------------
-- Table structure for Reservations
-- ----------------------------
DROP TABLE IF EXISTS `Reservations`;
CREATE TABLE `Reservations` (
  `reservation_Id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `valid` bit(1) NOT NULL,
  `lock` bit(1) NOT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `day` int(11) DEFAULT NULL,
  `start` int(11) DEFAULT NULL,
  `finish` int(11) DEFAULT NULL,
  `qr_location` varchar(50) DEFAULT NULL,
  `information` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reservation_Id`),
  KEY `user_id` (`user_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `Reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Reservations_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `ActivityRooms` (`room_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Reservations
-- ----------------------------
INSERT INTO `Reservations` VALUES ('2', '7', '1', '', '\0', '2017', '7', '10', '900', '1000', '../qr_img/qr2.jpg', '');
INSERT INTO `Reservations` VALUES ('3', '3', '1', '', '\0', '2017', '7', '10', '1530', '1600', '../qr_img/qr3.jpg', '');
INSERT INTO `Reservations` VALUES ('4', '3', '1', '', '\0', '2017', '8', '15', '2100', '2200', '../qr_img/qr4.jpg', '');

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) NOT NULL,
  `password` varchar(16) NOT NULL,
  `wechat_id` varchar(16) DEFAULT NULL,
  `phone_number` varchar(13) DEFAULT NULL,
  `identity_number` varchar(9) DEFAULT NULL,
  `is_temporary` bit(1) DEFAULT NULL,
  `is_manager` bit(1) DEFAULT NULL,
  `information` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Users
-- ----------------------------
INSERT INTO `Users` VALUES ('1', 'leafspace', '123456', '1141610886', '18852923073', '092214109', '\0', '', '');
INSERT INTO `Users` VALUES ('2', 'zhantaian', '123456', '', '', '092214107', '\0', '', '');
INSERT INTO `Users` VALUES ('3', 'cindy', '123456', '1037415664', '18852923073', '092214141', '\0', '\0', null);
INSERT INTO `Users` VALUES ('4', 'alen', '123456', '1179538914', '18852923073', '092214142', '', '\0', null);
INSERT INTO `Users` VALUES ('5', 'dock', '123456', '1213303441', '18852923073', '092214143', '', '\0', null);
INSERT INTO `Users` VALUES ('6', 'zta_hp', '123456', 'zta123456', '', '092214108', '', '\0', '');
INSERT INTO `Users` VALUES ('7', 'lzq_xb', 'lzq123456', 'lzq123456', '15006256432', '092214106', '', '\0', '');
INSERT INTO `Users` VALUES ('8', 'zlf', '123456', 'zlf123456', '18852923037', '02214109', '\0', '\0', '');
