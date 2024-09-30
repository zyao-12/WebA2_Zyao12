/*
 Navicat Premium Dump SQL

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : crowdfunding_db

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 30/09/2024 17:09:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `CATEGORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`CATEGORY_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Medical');
INSERT INTO `category` VALUES (2, 'Education');
INSERT INTO `category` VALUES (3, 'Social Impact');

-- ----------------------------
-- Table structure for fundraiser
-- ----------------------------
DROP TABLE IF EXISTS `fundraiser`;
CREATE TABLE `fundraiser`  (
  `FUNDRAISER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORGANIZER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CAPTION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TARGET_FUNDING` decimal(10, 2) NOT NULL,
  `CURRENT_FUNDING` decimal(10, 2) NOT NULL,
  `CITY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ACTIVE` tinyint(1) NOT NULL,
  `CATEGORY_ID` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`FUNDRAISER_ID`) USING BTREE,
  INDEX `CATEGORY_ID`(`CATEGORY_ID`) USING BTREE,
  CONSTRAINT `fundraiser_ibfk_1` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `category` (`CATEGORY_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fundraiser
-- ----------------------------
INSERT INTO `fundraiser` VALUES (1, 'Jackson Family', 'Help The Jacksons Rebuild After Flood', 30000.00, 7394.00, 'Byron Bay', 1, 1);
INSERT INTO `fundraiser` VALUES (2, 'Xiaoshan School', 'Fund New Library for Xiaoshan School', 9000.00, 5000.00, 'Coffs Harbour', 1, 2);
INSERT INTO `fundraiser` VALUES (3, 'Animal Shelter', 'Support the Local Animal Shelter', 13000.00, 6000.00, 'Lismore', 1, 3);
INSERT INTO `fundraiser` VALUES (4, 'Community Garden', 'Build a Community Garden', 7000.00, 2000.00, 'Sydney', 1, 2);
INSERT INTO `fundraiser` VALUES (5, 'Medical Fund', 'Help Jane with Her Medical Bills', 10000.00, 25000.00, 'Tweed Heads', 1, 1);

SET FOREIGN_KEY_CHECKS = 1;
