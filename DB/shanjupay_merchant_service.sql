/*
Navicat MySQL Data Transfer

Source Server         : lidadaibiao
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : shanjupay_merchant_service

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-06-09 20:33:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `app`
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `ID` bigint(20) NOT NULL,
  `APP_ID` varchar(50) DEFAULT NULL,
  `APP_NAME` varchar(50) DEFAULT NULL COMMENT '商店名称',
  `MERCHANT_ID` bigint(20) DEFAULT NULL COMMENT '所属商户',
  `PUBLIC_KEY` varchar(50) DEFAULT NULL COMMENT '应用公钥(RSAWithSHA256)',
  `NOTIFY_URL` varchar(50) DEFAULT NULL COMMENT '授权回调地址',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `APP_ID` (`APP_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES ('1268600746629754881', '6d62ca3e03b94f64baa418269357072c', 'xxx航空服务', '1268401949890924545', 'ssssssss', 'ssssss');

-- ----------------------------
-- Table structure for `merchant`
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `MERCHANT_NAME` varchar(50) DEFAULT NULL COMMENT '商户名称',
  `MERCHANT_NO` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `MERCHANT_ADDRESS` varchar(255) DEFAULT NULL COMMENT '企业地址',
  `MERCHANT_TYPE` varchar(50) DEFAULT NULL COMMENT '商户类型',
  `BUSINESS_LICENSES_IMG` varchar(100) DEFAULT NULL COMMENT '营业执照（企业证明）',
  `ID_CARD_FRONT_IMG` varchar(100) DEFAULT NULL COMMENT '法人身份证正面照片',
  `ID_CARD_AFTER_IMG` varchar(100) DEFAULT NULL COMMENT '法人身份证反面照片',
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '联系人姓名',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '联系人手机号(关联统一账号)',
  `CONTACTS_ADDRESS` varchar(255) DEFAULT NULL COMMENT '联系人地址',
  `AUDIT_STATUS` varchar(20) DEFAULT NULL COMMENT '审核状态 0-未申请,1-已申请待审核,2-审核通过,3-审核拒绝',
  `TENANT_ID` bigint(20) DEFAULT NULL COMMENT '租户ID,关联统一用户',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of merchant
-- ----------------------------
INSERT INTO `merchant` VALUES ('1', '1', '1', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `merchant` VALUES ('1268172402536828929', null, null, null, null, null, null, null, null, '11', null, '0', null);
INSERT INTO `merchant` VALUES ('1268199358569451522', null, null, null, null, null, null, null, '11', '11', null, null, null);
INSERT INTO `merchant` VALUES ('1268199986179936258', null, null, null, null, null, null, null, '11', '11', null, null, null);
INSERT INTO `merchant` VALUES ('1268201415217000450', null, null, null, null, null, null, null, 'lssl', '22222', null, null, null);
INSERT INTO `merchant` VALUES ('1268401949890924545', 'JAVA研发工程师', '2222123123', '深圳宝安区', 'it', '2d44a‐19e4‐44a7‐a714‐58ffc7da8e45e.png', '2d44a‐19e4‐44a7‐a714‐58ffc7da8e45e.png', '2d44a‐19e4‐44a7‐a714‐58ffc7da8e45e.png', '大代表', '15237227086', '阿里云', '2', null);
INSERT INTO `merchant` VALUES ('1270030368416296962', null, null, null, null, null, null, null, '大代表1', '15237227022', null, '0', '9');
INSERT INTO `merchant` VALUES ('1270030730980323330', null, null, null, null, null, null, null, '大代表122', '15237227011', null, '0', '10');
INSERT INTO `merchant` VALUES ('1270208054287761409', null, null, null, null, null, null, null, 'dabiao122', '15237227090', null, '0', '11');
INSERT INTO `merchant` VALUES ('1270217408319688706', null, null, null, null, null, null, null, 'daibiao01', '15237227222', null, '0', '14');
INSERT INTO `merchant` VALUES ('1270218112350371841', null, null, null, null, null, null, null, 'daibiao02', '15237227221', null, '0', '15');

-- ----------------------------
-- Table structure for `staff`
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `MERCHANT_ID` bigint(20) DEFAULT NULL COMMENT '商户ID',
  `FULL_NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `POSITION` varchar(50) DEFAULT NULL COMMENT '职位',
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '用户名(关联统一用户)',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '手机号(关联统一用户)',
  `STORE_ID` bigint(20) DEFAULT NULL COMMENT '员工所属门店',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT '最后一次登录时间',
  `STAFF_STATUS` bit(1) DEFAULT NULL COMMENT '0表示禁用，1表示启用',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('1270030369255157761', '1270030368416296962', null, null, '大代表1', '15237227022', '1270030368835727361', null, null);
INSERT INTO `staff` VALUES ('1270030731085180930', '1270030730980323330', null, null, '大代表122', '15237227011', '1270030731009683457', null, null);
INSERT INTO `staff` VALUES ('1270208072352628738', '1270208054287761409', null, null, 'dabiao122', '15237227090', '1270208067311075329', null, null);
INSERT INTO `staff` VALUES ('1270217413206052866', '1270217408319688706', null, null, 'daibiao01', '15237227222', '1270217411746435073', null, null);
INSERT INTO `staff` VALUES ('1270218113755463682', '1270218112350371841', null, null, 'daibiao02', '15237227221', '1270218112971128834', null, null);

-- ----------------------------
-- Table structure for `store`
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `ID` bigint(20) NOT NULL,
  `STORE_NAME` varchar(50) DEFAULT NULL COMMENT '门店名称',
  `STORE_NUMBER` bigint(20) DEFAULT NULL COMMENT '门店编号',
  `MERCHANT_ID` bigint(20) DEFAULT NULL COMMENT '所属商户',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父门店',
  `STORE_STATUS` bit(1) DEFAULT NULL COMMENT '0表示禁用，1表示启用',
  `STORE_ADDRESS` varchar(50) DEFAULT NULL COMMENT '门店地址',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of store
-- ----------------------------
INSERT INTO `store` VALUES ('1270030368835727361', '根门店', null, '1270030368416296962', null, null, null);
INSERT INTO `store` VALUES ('1270030731009683457', '根门店', null, '1270030730980323330', null, null, null);
INSERT INTO `store` VALUES ('1270208067311075329', '根门店', null, '1270208054287761409', null, null, null);
INSERT INTO `store` VALUES ('1270217411746435073', '根门店', null, '1270217408319688706', null, null, null);
INSERT INTO `store` VALUES ('1270218112971128834', '根门店', null, '1270218112350371841', null, null, null);

-- ----------------------------
-- Table structure for `store_staff`
-- ----------------------------
DROP TABLE IF EXISTS `store_staff`;
CREATE TABLE `store_staff` (
  `ID` bigint(20) NOT NULL,
  `STORE_ID` bigint(20) DEFAULT NULL COMMENT '门店标识',
  `STAFF_ID` bigint(20) DEFAULT NULL COMMENT '员工标识',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of store_staff
-- ----------------------------
INSERT INTO `store_staff` VALUES ('1270030369255157762', '1270030368835727361', '1270030369255157761');
INSERT INTO `store_staff` VALUES ('1270030731101958146', '1270030731009683457', '1270030731085180930');
INSERT INTO `store_staff` VALUES ('1270208072642035713', '1270208067311075329', '1270208072352628738');
INSERT INTO `store_staff` VALUES ('1270217413491265537', '1270217411746435073', '1270217413206052866');
INSERT INTO `store_staff` VALUES ('1270218113789018114', '1270218112971128834', '1270218113755463682');
