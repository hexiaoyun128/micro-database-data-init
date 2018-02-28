/*
Navicat MySQL Data Transfer

Source Server         : 192.168.16.103
Source Server Version : 50718
Source Host           : 192.168.16.103:3307
Source Database       : dev-artist-micro-account

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-02-05 15:00:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_type` int(11) NOT NULL COMMENT '账号类型(1:客户，2:销售)',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `role_id` varchar(100) DEFAULT NULL COMMENT '角色id（多个用逗号隔开）',
  `jobtitle_id` varchar(100) DEFAULT NULL COMMENT '职位',
  `status` int(11) NOT NULL COMMENT '状态（0：正常，1：禁用）',
  `company_id` int(11) DEFAULT NULL COMMENT '公司id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `icon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100057 DEFAULT CHARSET=utf8 COMMENT='账号';

-- ----------------------------
-- Table structure for account_name
-- ----------------------------
DROP TABLE IF EXISTS `account_name`;
CREATE TABLE `account_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_id` int(11) NOT NULL COMMENT '账号id',
  `account_name` varchar(50) NOT NULL COMMENT '账号名',
  `type` varchar(50) NOT NULL COMMENT '如：邮箱、手机、注册账号',
  `company_id` int(11) DEFAULT NULL COMMENT '公司id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`account_id`) USING BTREE,
  CONSTRAINT `account_name_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='账号名';

-- ----------------------------
-- Table structure for account_token
-- ----------------------------
DROP TABLE IF EXISTS `account_token`;
CREATE TABLE `account_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_id` int(11) DEFAULT NULL COMMENT '用户id',
  `app_id` varchar(50) DEFAULT NULL COMMENT '应用标识',
  `access_token` varchar(50) DEFAULT NULL COMMENT '访问凭证',
  `access_token_expires` int(11) DEFAULT NULL COMMENT '访问凭证失效时间（秒）',
  `refresh_token` varchar(50) DEFAULT NULL COMMENT '刷新token的凭证',
  `refresh_token_expires` int(11) DEFAULT NULL COMMENT '刷新凭证失效时间（秒）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8 COMMENT='账号token';

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_id` int(11) DEFAULT NULL COMMENT '账号id',
  `consignee` varchar(50) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(50) DEFAULT NULL COMMENT '联系电话',
  `detail_address` varchar(500) DEFAULT NULL COMMENT '详细地址',
  `is_default` int(11) DEFAULT NULL COMMENT '默认地址（0：否，1：默认地址）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_4` (`account_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='收货地址';

-- ----------------------------
-- Table structure for app_version
-- ----------------------------
DROP TABLE IF EXISTS `app_version`;
CREATE TABLE `app_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_force` int(11) DEFAULT NULL,
  `update_content` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `dispose_time` datetime DEFAULT NULL,
  `feed_number` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `res_person` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `suggest` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `menu_url` varchar(100) DEFAULT NULL COMMENT '菜单url(仅用于前端)',
  `company_id` int(11) DEFAULT NULL COMMENT '公司id',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级菜单id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `is_default` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='菜单';
