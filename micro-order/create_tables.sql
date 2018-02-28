/*
Navicat MySQL Data Transfer

Source Server         : 192.168.16.103
Source Server Version : 50718
Source Host           : 192.168.16.103:3307
Source Database       : dev-artist-micro-order

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-02-02 16:15:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_number` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `flow_type` int(11) DEFAULT NULL COMMENT '流程类型（1：非详细资料，2：详细资料，3：销售下单）',
  `customer_id` int(11) DEFAULT NULL COMMENT '客户id',
  `customer_number` varchar(50) DEFAULT NULL COMMENT '客户编号',
  `customer_account_id` int(11) DEFAULT NULL COMMENT '客户账号id',
  `customer_name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `principal_sale_id` int(11) DEFAULT NULL COMMENT '订单负责人',
  `order_handler_sale_id` int(11) DEFAULT NULL COMMENT '订单处理人',
  `order_status` int(11) DEFAULT NULL COMMENT '订单状态',
  `company_id` int(11) DEFAULT NULL COMMENT '公司id',
  `delete_flg` int(11) DEFAULT NULL COMMENT '删除标志（0：正常，1：客户删除，2：销售删除）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='订单';

-- ----------------------------
-- Table structure for orders_assignlog
-- ----------------------------
DROP TABLE IF EXISTS `orders_assignlog`;
CREATE TABLE `orders_assignlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orders_id` int(11) NOT NULL COMMENT '订单id',
  `principal_sale_id` int(11) DEFAULT NULL COMMENT '负责销售',
  `assign_sale_id` int(11) DEFAULT NULL COMMENT '指派销售',
  `op_account_id` int(11) DEFAULT NULL COMMENT '操作人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='订单指派日志';

-- ----------------------------
-- Table structure for orders_product
-- ----------------------------
DROP TABLE IF EXISTS `orders_product`;
CREATE TABLE `orders_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orders_id` int(11) DEFAULT NULL COMMENT '订单id',
  `product_id` int(11) DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `attr_json` varchar(1000) DEFAULT NULL COMMENT '可选属性',
  `is_details` int(11) DEFAULT NULL COMMENT '是否详细资料',
  `remark` json DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_3` (`orders_id`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='订单-产品';

-- ----------------------------
-- Table structure for orders_product_detail
-- ----------------------------
DROP TABLE IF EXISTS `orders_product_detail`;
CREATE TABLE `orders_product_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orders_product_id` int(11) DEFAULT NULL COMMENT '订单产品id',
  `specification_josn` varchar(500) DEFAULT NULL COMMENT '规格JSON',
  `orders_id` int(11) DEFAULT NULL COMMENT '订单id',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `product_weight` double DEFAULT NULL COMMENT '产品克重',
  `shipment_weight` double DEFAULT NULL COMMENT '出货克重',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_5` (`orders_product_id`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`orders_product_id`) REFERENCES `orders_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='订单-产品-详情';

-- ----------------------------
-- Table structure for orders_statuslog
-- ----------------------------
DROP TABLE IF EXISTS `orders_statuslog`;
CREATE TABLE `orders_statuslog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orders_id` int(11) NOT NULL COMMENT '订单id',
  `before_change` int(11) DEFAULT NULL COMMENT '变更前',
  `after_change` int(11) DEFAULT NULL COMMENT '变更后',
  `op_account_id` int(11) DEFAULT NULL COMMENT '操作人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='订单状态日志';

-- ----------------------------
-- Table structure for shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `shoppingcart`;
CREATE TABLE `shoppingcart` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `customer_account_id` int(11) NOT NULL COMMENT '客户id',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `attr_json` json DEFAULT NULL COMMENT '可选属性JSON',
  `remark` json DEFAULT NULL COMMENT '备注',
  `product_name` varchar(100) NOT NULL COMMENT '产品名称',
  `is_details` int(11) NOT NULL COMMENT '是否详细资料',
  `company_id` int(11) NOT NULL COMMENT '公司id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8 COMMENT='购物车';

-- ----------------------------
-- Table structure for shoppingcart_detail
-- ----------------------------
DROP TABLE IF EXISTS `shoppingcart_detail`;
CREATE TABLE `shoppingcart_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `shoppingcart_id` int(11) DEFAULT NULL COMMENT '购物车id',
  `product_id` int(11) DEFAULT NULL COMMENT '产品id',
  `attr_json` json DEFAULT NULL COMMENT '可选属性JSON',
  `specification_josn` json DEFAULT NULL COMMENT '规格JSON',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `product_weight` double DEFAULT NULL COMMENT '产品克重',
  `shipment_weight` double DEFAULT NULL COMMENT '出货克重',
  `create_time` date DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_4` (`shoppingcart_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`shoppingcart_id`) REFERENCES `shoppingcart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8 COMMENT='购物车-产品详情';
