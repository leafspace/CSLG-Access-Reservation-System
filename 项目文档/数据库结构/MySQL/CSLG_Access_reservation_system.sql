/*
Navicat MySQL Data Transfer

Source Server         : Raspberry
Source Server Version : 50555
Source Host           : 192.168.155.3:3306
Source Database       : CSLG_Access_reservation_system

Target Server Type    : MYSQL
Target Server Version : 50555
File Encoding         : 65001

Date: 2017-07-07 20:28:47
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
INSERT INTO `ActivityRooms` VALUES ('1', 'N6五楼活动室', 'N6五楼活动室');

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
  CONSTRAINT `Reservations_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `ActivityRooms` (`room_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Reservations
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Users
-- ----------------------------
INSERT INTO `Users` VALUES ('1', 'leafspace', '123456', '1141610886', '18852923073', '092214109', '\0', '', '');
INSERT INTO `Users` VALUES ('2', 'zhantaian', '123456', '', '', '092214107', '\0', '', '');
INSERT INTO `Users` VALUES ('3', 'cindy', '123456', '1037415664', '18852923073', '092214141', '\0', '\0', null);
INSERT INTO `Users` VALUES ('4', 'alen', '123456', '1179538914', '18852923073', '092214142', '', '\0', null);
INSERT INTO `Users` VALUES ('5', 'dock', '123456', '1213303441', '18852923073', '092214143', '', '\0', null);
