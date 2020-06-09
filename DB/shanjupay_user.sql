/*
Navicat MySQL Data Transfer

Source Server         : lidadaibiao
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : shanjupay_user

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-06-09 20:33:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '用户名',
  `MOBILE` varchar(50) NOT NULL COMMENT '手机号',
  `PASSWORD` varchar(50) DEFAULT NULL COMMENT '密码',
  `SALT` varchar(50) DEFAULT NULL COMMENT '盐',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `mobile_idx` (`MOBILE`),
  UNIQUE KEY `username_idx` (`USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('2', '大代表', '15237227094', '587be5738ca4f22730a9d67c7a86fbd1', 'WEbf7');
INSERT INTO `account` VALUES ('3', '大代表1', '15237227022', '4da1230fc95436760b678a5b8e52bcf4', '51Ner');
INSERT INTO `account` VALUES ('4', '大代表122', '15237227011', 'a8aba98908549fd5472f62bc7473dcf8', '10y97');
INSERT INTO `account` VALUES ('5', 'dabiao122', '15237227090', '9005c4c29eb6122d0621acc928282e23', '20kYS');
INSERT INTO `account` VALUES ('7', 'daibiao01', '15237227222', 'a4b5170204b716222e8baa41fad5dbf2', 'jBV6I');
INSERT INTO `account` VALUES ('9', 'daibiao02', '15237227221', 'e593b90af6f2771d7c529d77a2996643', '5B4WB');

-- ----------------------------
-- Table structure for `account_role`
-- ----------------------------
DROP TABLE IF EXISTS `account_role`;
CREATE TABLE `account_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '用户名',
  `ROLE_CODE` varchar(50) DEFAULT NULL COMMENT '角色编码',
  `TENANT_ID` bigint(20) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='账号-角色关系';

-- ----------------------------
-- Records of account_role
-- ----------------------------
INSERT INTO `account_role` VALUES ('1', '大代表', 'r_001', '2');
INSERT INTO `account_role` VALUES ('2', '大代表', 'r_002', '2');
INSERT INTO `account_role` VALUES ('3', '大代表1', 'r_001', '9');
INSERT INTO `account_role` VALUES ('4', '大代表1', 'r_002', '9');
INSERT INTO `account_role` VALUES ('5', '大代表122', 'r_001', '10');
INSERT INTO `account_role` VALUES ('6', '大代表122', 'r_002', '10');
INSERT INTO `account_role` VALUES ('7', 'dabiao122', 'r_001', '11');
INSERT INTO `account_role` VALUES ('8', 'dabiao122', 'r_002', '11');
INSERT INTO `account_role` VALUES ('9', 'daibiao01', 'r_001', '14');
INSERT INTO `account_role` VALUES ('10', 'daibiao01', 'r_002', '14');
INSERT INTO `account_role` VALUES ('11', 'daibiao02', 'r_001', '15');
INSERT INTO `account_role` VALUES ('12', 'daibiao02', 'r_002', '15');

-- ----------------------------
-- Table structure for `authorization_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `authorization_privilege`;
CREATE TABLE `authorization_privilege` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '权限编码',
  `PRIVILEGE_GROUP_ID` bigint(20) DEFAULT NULL COMMENT '所属权限组id',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `priv_unq_code` (`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限';

-- ----------------------------
-- Records of authorization_privilege
-- ----------------------------
INSERT INTO `authorization_privilege` VALUES ('1', '工作台', 'sj_m_console', '1');
INSERT INTO `authorization_privilege` VALUES ('2', '应用管理', 'sj_m_app_list', '4');
INSERT INTO `authorization_privilege` VALUES ('3', '应用交易总览', 'sj_m_transaction_list', '4');
INSERT INTO `authorization_privilege` VALUES ('4', '应用财务对账', 'sj_m_account_check', '4');
INSERT INTO `authorization_privilege` VALUES ('5', '开始支付', 'sj_m_payment', '4');
INSERT INTO `authorization_privilege` VALUES ('6', '账户中心', 'sj_m_account_list', '5');
INSERT INTO `authorization_privilege` VALUES ('7', '企业认证', 'sj_m_enterprise_auth', '5');
INSERT INTO `authorization_privilege` VALUES ('8', '门店管理', 'sj_m_store_list', '6');
INSERT INTO `authorization_privilege` VALUES ('9', '成员管理', 'sj_m_staff_list', '6');
INSERT INTO `authorization_privilege` VALUES ('10', '会员管理', 'sj_o_member_list', '7');
INSERT INTO `authorization_privilege` VALUES ('11', '企业管理', 'sj_o_entreprise_list', '7');
INSERT INTO `authorization_privilege` VALUES ('12', '审核管理', 'sj_o_audit', '7');
INSERT INTO `authorization_privilege` VALUES ('13', '服务类型管理', 'sj_o_service_type', '8');
INSERT INTO `authorization_privilege` VALUES ('14', '往来对账', 'sj_o_account_check', '9');
INSERT INTO `authorization_privilege` VALUES ('15', '管理员管理', 'sj_o_admin_list', '10');
INSERT INTO `authorization_privilege` VALUES ('16', '角色管理', 'sj_o_role_list', '10');
INSERT INTO `authorization_privilege` VALUES ('17', '应用创建', 'sj_m_app_create', '4');
INSERT INTO `authorization_privilege` VALUES ('18', '设置默认支付', 'sj_m_payment_set', '4');
INSERT INTO `authorization_privilege` VALUES ('19', '门店新增', 'sj_m_store_create', '6');
INSERT INTO `authorization_privilege` VALUES ('20', '门店查询', 'sj_m_store_query', '6');
INSERT INTO `authorization_privilege` VALUES ('21', '成员新增', 'sj_m_staff_create', '6');
INSERT INTO `authorization_privilege` VALUES ('22', '成员查询', 'sj_m_staff_query', '6');
INSERT INTO `authorization_privilege` VALUES ('23', '会员查询', 'sj_o_member_query', '7');
INSERT INTO `authorization_privilege` VALUES ('24', '企业查询', 'sj_o_enterprise_query', '7');
INSERT INTO `authorization_privilege` VALUES ('25', '企业新建', 'sj_o_enterprise_create', '7');
INSERT INTO `authorization_privilege` VALUES ('26', '服务类型新建', 'sj_o_service_create', '8');
INSERT INTO `authorization_privilege` VALUES ('27', '服务类型查询', 'sj_o_service_query', '8');
INSERT INTO `authorization_privilege` VALUES ('28', '管理员新建', 'sj_o_admin_create', '10');
INSERT INTO `authorization_privilege` VALUES ('29', '管理员查询', 'sj_o_admin_query', '10');
INSERT INTO `authorization_privilege` VALUES ('30', '角色新建', 'sj_o_role_create', '10');
INSERT INTO `authorization_privilege` VALUES ('31', '课程列表', 'xc_course_base_list', '17');
INSERT INTO `authorization_privilege` VALUES ('32', '课程保存', 'xc_course_base_save', '17');
INSERT INTO `authorization_privilege` VALUES ('33', '课程修改', 'xc_course_base_edit', '17');
INSERT INTO `authorization_privilege` VALUES ('34', '课程删除', 'xc_course_base_del', '17');
INSERT INTO `authorization_privilege` VALUES ('38', '课程详情', 'xc_course_base_view', '17');
INSERT INTO `authorization_privilege` VALUES ('39', '课程计划详情', 'xc_teachplan_view', '17');
INSERT INTO `authorization_privilege` VALUES ('40', '操作课程计划', 'xc_teachplan_save_modify', '17');
INSERT INTO `authorization_privilege` VALUES ('41', '删除课程计划', 'xc_teachplan_del', '17');
INSERT INTO `authorization_privilege` VALUES ('42', '操作课程营销', 'xc_market_save_modify', '17');
INSERT INTO `authorization_privilege` VALUES ('43', '课程营销详情', 'xc_market_view', '17');
INSERT INTO `authorization_privilege` VALUES ('44', '发布课程', 'xc_course_publish', '17');
INSERT INTO `authorization_privilege` VALUES ('45', '媒资列表', 'xc_media_list', '18');
INSERT INTO `authorization_privilege` VALUES ('46', '媒资保存', 'xc_media_save', '18');
INSERT INTO `authorization_privilege` VALUES ('47', '媒资（视频）预览', 'xc_media_preview', '18');
INSERT INTO `authorization_privilege` VALUES ('48', '媒资删除', 'xc_media_del', '18');
INSERT INTO `authorization_privilege` VALUES ('49', '机构修改', 'xc_company_modify', '19');
INSERT INTO `authorization_privilege` VALUES ('50', '机构详情', 'xc_company_view', '19');
INSERT INTO `authorization_privilege` VALUES ('51', '教师列表', 'xc_teacher_list', '19');
INSERT INTO `authorization_privilege` VALUES ('52', '保存教师信息', 'xc_teacher_save', '19');
INSERT INTO `authorization_privilege` VALUES ('53', '修改教师信息', 'xc_teacher_modify', '19');
INSERT INTO `authorization_privilege` VALUES ('54', '作业列表', 'xc_teachplanwork_list', '19');
INSERT INTO `authorization_privilege` VALUES ('55', '操作课程作业', 'xc_teachplanwork_save_modify', '19');
INSERT INTO `authorization_privilege` VALUES ('56', '删除课程作业', 'xc_teachplanwork_del', '19');
INSERT INTO `authorization_privilege` VALUES ('57', '作业记录列表', 'xc_workrecord_list', '19');
INSERT INTO `authorization_privilege` VALUES ('58', '作业记录批改', 'xc_workrecord_correction', '19');
INSERT INTO `authorization_privilege` VALUES ('59', '角色查询', 'sj_o_role_query', '10');
INSERT INTO `authorization_privilege` VALUES ('60', '角色权限保存', 'sj_o_role_save', '10');
INSERT INTO `authorization_privilege` VALUES ('61', '企业认证的申请', 'sj_m_auth_apply', '7');
INSERT INTO `authorization_privilege` VALUES ('62', '工作台续费', 'sj_m_console_renew', '1');
INSERT INTO `authorization_privilege` VALUES ('63', '工作台升级', 'sj_m_console_upgrade', '1');
INSERT INTO `authorization_privilege` VALUES ('64', '应用保存', 'sj_m_app_save', '4');
INSERT INTO `authorization_privilege` VALUES ('65', '应用编辑', 'sj_m_app_modify', '4');
INSERT INTO `authorization_privilege` VALUES ('66', '支付参数保存', 'sj_m_payparam_save', '4');
INSERT INTO `authorization_privilege` VALUES ('67', '设置默认支付', 'sj_m_pay_set', '4');
INSERT INTO `authorization_privilege` VALUES ('68', '默认支付保存', 'sj_m_pay_save', '4');
INSERT INTO `authorization_privilege` VALUES ('69', 'C扫B二维码生成', 'sj_m_c2b_qrcode', '4');
INSERT INTO `authorization_privilege` VALUES ('70', 'B扫C订单生成', 'sj_m_b2c_order', '4');
INSERT INTO `authorization_privilege` VALUES ('71', '线上支付参数展示', 'sj_m_h5_view', '4');
INSERT INTO `authorization_privilege` VALUES ('72', '购买套餐', 'sj_m_bundle_buy', '5');
INSERT INTO `authorization_privilege` VALUES ('73', '企业认证资料提交', 'sj_m_enterprise_info_submit', '5');
INSERT INTO `authorization_privilege` VALUES ('74', '企业认证资料取消', 'sj_m_enterprise_info_cancel', '5');
INSERT INTO `authorization_privilege` VALUES ('76', '通过企业认证', 'sj_o_enterprise_auth_pass', '7');
INSERT INTO `authorization_privilege` VALUES ('77', '驳回企业认证', 'sj_o_enterprise_auth_rejection', '7');
INSERT INTO `authorization_privilege` VALUES ('81', '门店管理-编辑', 'sj_m_store_edit', '6');
INSERT INTO `authorization_privilege` VALUES ('82', '成员管理-编辑', 'sj_m_staff_edit', '6');
INSERT INTO `authorization_privilege` VALUES ('83', '管理员管理-编辑', 'sj_o_admin_edit', '10');
INSERT INTO `authorization_privilege` VALUES ('84', '角色管理-编辑', 'sj_o_role_edit', '10');
INSERT INTO `authorization_privilege` VALUES ('85', '门店管理-保存', 'sj_m_store_save', '6');
INSERT INTO `authorization_privilege` VALUES ('86', '门店管理-删除', 'sj_m_store_del', '6');
INSERT INTO `authorization_privilege` VALUES ('87', '成员管理-保存', 'sj_m_staff_save', '6');
INSERT INTO `authorization_privilege` VALUES ('88', '成员管理-删除', 'sj_m_staff_del', '6');

-- ----------------------------
-- Table structure for `authorization_privilege_group`
-- ----------------------------
DROP TABLE IF EXISTS `authorization_privilege_group`;
CREATE TABLE `authorization_privilege_group` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父id',
  `NAME` varchar(50) DEFAULT NULL COMMENT '权限组名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限组';

-- ----------------------------
-- Records of authorization_privilege_group
-- ----------------------------
INSERT INTO `authorization_privilege_group` VALUES ('1', null, '商户平台');
INSERT INTO `authorization_privilege_group` VALUES ('2', null, '运营平台');
INSERT INTO `authorization_privilege_group` VALUES ('3', null, '门户网站');
INSERT INTO `authorization_privilege_group` VALUES ('4', '1', '应用管理');
INSERT INTO `authorization_privilege_group` VALUES ('5', '1', '账户管理');
INSERT INTO `authorization_privilege_group` VALUES ('6', '1', '组织管理');
INSERT INTO `authorization_privilege_group` VALUES ('7', '2', '企业管理');
INSERT INTO `authorization_privilege_group` VALUES ('8', '2', '服务类型管理');
INSERT INTO `authorization_privilege_group` VALUES ('9', '2', '账单管理');
INSERT INTO `authorization_privilege_group` VALUES ('10', '2', '系统管理');
INSERT INTO `authorization_privilege_group` VALUES ('12', null, '商户平台app端');

-- ----------------------------
-- Table structure for `authorization_role`
-- ----------------------------
DROP TABLE IF EXISTS `authorization_role`;
CREATE TABLE `authorization_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '角色编码',
  `TENANT_ID` bigint(20) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `tenant_id_code_unique` (`CODE`,`TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色信息';

-- ----------------------------
-- Records of authorization_role
-- ----------------------------
INSERT INTO `authorization_role` VALUES ('1', '商户管理员', 'r_001', '1177111672565059586');
INSERT INTO `authorization_role` VALUES ('2', '商户门店收银员', 'r_002', '1177111672565059586');
INSERT INTO `authorization_role` VALUES ('11', '商户管理员', 'r_001', '1177112064011063298');
INSERT INTO `authorization_role` VALUES ('12', '商户门店收银员', 'r_002', '1177112064011063298');
INSERT INTO `authorization_role` VALUES ('13', '商户管理员', 'r_001', '1177140318218563585');
INSERT INTO `authorization_role` VALUES ('14', '商户门店收银员', 'r_002', '1177140318218563585');
INSERT INTO `authorization_role` VALUES ('15', '商户管理员', 'r_001', '1177141851660300290');
INSERT INTO `authorization_role` VALUES ('16', '商户门店收银员', 'r_002', '1177141851660300290');
INSERT INTO `authorization_role` VALUES ('17', '商户管理员', 'r_001', '1177142745177075713');
INSERT INTO `authorization_role` VALUES ('18', '商户门店收银员', 'r_002', '1177142745177075713');
INSERT INTO `authorization_role` VALUES ('19', '商户管理员', 'r_001', '1177144209463128065');
INSERT INTO `authorization_role` VALUES ('20', '商户门店收银员', 'r_002', '1177144209463128065');
INSERT INTO `authorization_role` VALUES ('23', '商户管理员', 'r_001', '1186165689237438465');
INSERT INTO `authorization_role` VALUES ('24', '商户门店收银员', 'r_002', '1186165689237438465');
INSERT INTO `authorization_role` VALUES ('25', '商户管理员', 'r_001', '1186168085229404161');
INSERT INTO `authorization_role` VALUES ('26', '商户门店收银员', 'r_002', '1186168085229404161');
INSERT INTO `authorization_role` VALUES ('27', '商户管理员', 'r_001', '1186170919618412546');
INSERT INTO `authorization_role` VALUES ('28', '商户门店收银员', 'r_002', '1186170919618412546');
INSERT INTO `authorization_role` VALUES ('29', '商户管理员', 'r_001', '1186171861839446018');
INSERT INTO `authorization_role` VALUES ('30', '商户门店收银员', 'r_002', '1186171861839446018');
INSERT INTO `authorization_role` VALUES ('31', '商户管理员', 'r_001', '1186172654604845058');
INSERT INTO `authorization_role` VALUES ('32', '商户门店收银员', 'r_002', '1186172654604845058');
INSERT INTO `authorization_role` VALUES ('33', '商户管理员', 'r_001', '1186173819157544962');
INSERT INTO `authorization_role` VALUES ('34', '商户门店收银员', 'r_002', '1186173819157544962');
INSERT INTO `authorization_role` VALUES ('35', '商户管理员', 'r_001', '1186855107896029186');
INSERT INTO `authorization_role` VALUES ('36', '商户门店收银员', 'r_002', '1186855107896029186');
INSERT INTO `authorization_role` VALUES ('38', '商户管理员', 'r_001', '1194527284107677698');
INSERT INTO `authorization_role` VALUES ('39', '商户门店收银员', 'r_002', '1194527284107677698');
INSERT INTO `authorization_role` VALUES ('40', '商户管理员', 'r_001', '1194528354401783809');
INSERT INTO `authorization_role` VALUES ('41', '商户门店收银员', 'r_002', '1194528354401783809');
INSERT INTO `authorization_role` VALUES ('46', '商户管理员', 'r_001', '1199893397776707585');
INSERT INTO `authorization_role` VALUES ('47', '商户门店收银员', 'r_002', '1199893397776707585');
INSERT INTO `authorization_role` VALUES ('48', '商户管理员', 'r_001', '1199981635597017089');
INSERT INTO `authorization_role` VALUES ('49', '商户门店收银员', 'r_002', '1199981635597017089');
INSERT INTO `authorization_role` VALUES ('50', '商户管理员', 'r_001', '2');
INSERT INTO `authorization_role` VALUES ('51', '商户门店收银员', 'r_002', '2');
INSERT INTO `authorization_role` VALUES ('52', '商户管理员', 'r_001', '9');
INSERT INTO `authorization_role` VALUES ('53', '商户门店收银员', 'r_002', '9');
INSERT INTO `authorization_role` VALUES ('54', '商户管理员', 'r_001', '10');
INSERT INTO `authorization_role` VALUES ('55', '商户门店收银员', 'r_002', '10');
INSERT INTO `authorization_role` VALUES ('56', '商户管理员', 'r_001', '11');
INSERT INTO `authorization_role` VALUES ('57', '商户门店收银员', 'r_002', '11');
INSERT INTO `authorization_role` VALUES ('58', '商户管理员', 'r_001', '14');
INSERT INTO `authorization_role` VALUES ('59', '商户门店收银员', 'r_002', '14');
INSERT INTO `authorization_role` VALUES ('60', '商户管理员', 'r_001', '15');
INSERT INTO `authorization_role` VALUES ('61', '商户门店收银员', 'r_002', '15');

-- ----------------------------
-- Table structure for `authorization_role_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `authorization_role_privilege`;
CREATE TABLE `authorization_role_privilege` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROLE_ID` bigint(20) DEFAULT NULL COMMENT '角色id',
  `PRIVILEGE_ID` bigint(20) DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `role_priv_unique` (`ROLE_ID`,`PRIVILEGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=786 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色-权限关系';

-- ----------------------------
-- Records of authorization_role_privilege
-- ----------------------------
INSERT INTO `authorization_role_privilege` VALUES ('1', '1', '1');
INSERT INTO `authorization_role_privilege` VALUES ('2', '1', '2');
INSERT INTO `authorization_role_privilege` VALUES ('3', '1', '3');
INSERT INTO `authorization_role_privilege` VALUES ('4', '1', '4');
INSERT INTO `authorization_role_privilege` VALUES ('5', '1', '5');
INSERT INTO `authorization_role_privilege` VALUES ('6', '1', '6');
INSERT INTO `authorization_role_privilege` VALUES ('7', '1', '7');
INSERT INTO `authorization_role_privilege` VALUES ('8', '1', '8');
INSERT INTO `authorization_role_privilege` VALUES ('9', '1', '9');
INSERT INTO `authorization_role_privilege` VALUES ('10', '1', '10');
INSERT INTO `authorization_role_privilege` VALUES ('11', '1', '11');
INSERT INTO `authorization_role_privilege` VALUES ('12', '1', '12');
INSERT INTO `authorization_role_privilege` VALUES ('13', '1', '13');
INSERT INTO `authorization_role_privilege` VALUES ('14', '2', '14');
INSERT INTO `authorization_role_privilege` VALUES ('15', '11', '1');
INSERT INTO `authorization_role_privilege` VALUES ('16', '11', '2');
INSERT INTO `authorization_role_privilege` VALUES ('17', '11', '3');
INSERT INTO `authorization_role_privilege` VALUES ('18', '11', '4');
INSERT INTO `authorization_role_privilege` VALUES ('19', '11', '5');
INSERT INTO `authorization_role_privilege` VALUES ('20', '11', '6');
INSERT INTO `authorization_role_privilege` VALUES ('21', '11', '7');
INSERT INTO `authorization_role_privilege` VALUES ('22', '11', '8');
INSERT INTO `authorization_role_privilege` VALUES ('23', '11', '9');
INSERT INTO `authorization_role_privilege` VALUES ('24', '11', '10');
INSERT INTO `authorization_role_privilege` VALUES ('25', '11', '11');
INSERT INTO `authorization_role_privilege` VALUES ('26', '11', '12');
INSERT INTO `authorization_role_privilege` VALUES ('27', '11', '13');
INSERT INTO `authorization_role_privilege` VALUES ('28', '12', '14');
INSERT INTO `authorization_role_privilege` VALUES ('29', '13', '1');
INSERT INTO `authorization_role_privilege` VALUES ('30', '13', '2');
INSERT INTO `authorization_role_privilege` VALUES ('31', '13', '3');
INSERT INTO `authorization_role_privilege` VALUES ('32', '13', '4');
INSERT INTO `authorization_role_privilege` VALUES ('33', '13', '5');
INSERT INTO `authorization_role_privilege` VALUES ('34', '13', '6');
INSERT INTO `authorization_role_privilege` VALUES ('35', '13', '7');
INSERT INTO `authorization_role_privilege` VALUES ('36', '13', '8');
INSERT INTO `authorization_role_privilege` VALUES ('37', '13', '9');
INSERT INTO `authorization_role_privilege` VALUES ('38', '13', '10');
INSERT INTO `authorization_role_privilege` VALUES ('39', '13', '11');
INSERT INTO `authorization_role_privilege` VALUES ('40', '13', '12');
INSERT INTO `authorization_role_privilege` VALUES ('41', '13', '13');
INSERT INTO `authorization_role_privilege` VALUES ('42', '14', '23');
INSERT INTO `authorization_role_privilege` VALUES ('43', '15', '1');
INSERT INTO `authorization_role_privilege` VALUES ('44', '15', '2');
INSERT INTO `authorization_role_privilege` VALUES ('45', '15', '3');
INSERT INTO `authorization_role_privilege` VALUES ('46', '15', '4');
INSERT INTO `authorization_role_privilege` VALUES ('47', '15', '5');
INSERT INTO `authorization_role_privilege` VALUES ('48', '15', '6');
INSERT INTO `authorization_role_privilege` VALUES ('49', '15', '7');
INSERT INTO `authorization_role_privilege` VALUES ('50', '15', '8');
INSERT INTO `authorization_role_privilege` VALUES ('51', '15', '9');
INSERT INTO `authorization_role_privilege` VALUES ('52', '15', '10');
INSERT INTO `authorization_role_privilege` VALUES ('53', '15', '11');
INSERT INTO `authorization_role_privilege` VALUES ('54', '15', '12');
INSERT INTO `authorization_role_privilege` VALUES ('55', '15', '13');
INSERT INTO `authorization_role_privilege` VALUES ('56', '16', '23');
INSERT INTO `authorization_role_privilege` VALUES ('57', '17', '1');
INSERT INTO `authorization_role_privilege` VALUES ('58', '17', '2');
INSERT INTO `authorization_role_privilege` VALUES ('59', '17', '3');
INSERT INTO `authorization_role_privilege` VALUES ('60', '17', '4');
INSERT INTO `authorization_role_privilege` VALUES ('61', '17', '5');
INSERT INTO `authorization_role_privilege` VALUES ('62', '17', '6');
INSERT INTO `authorization_role_privilege` VALUES ('63', '17', '7');
INSERT INTO `authorization_role_privilege` VALUES ('64', '17', '8');
INSERT INTO `authorization_role_privilege` VALUES ('65', '17', '9');
INSERT INTO `authorization_role_privilege` VALUES ('66', '17', '10');
INSERT INTO `authorization_role_privilege` VALUES ('67', '17', '11');
INSERT INTO `authorization_role_privilege` VALUES ('68', '17', '12');
INSERT INTO `authorization_role_privilege` VALUES ('69', '17', '13');
INSERT INTO `authorization_role_privilege` VALUES ('70', '18', '23');
INSERT INTO `authorization_role_privilege` VALUES ('71', '19', '1');
INSERT INTO `authorization_role_privilege` VALUES ('72', '19', '2');
INSERT INTO `authorization_role_privilege` VALUES ('73', '19', '3');
INSERT INTO `authorization_role_privilege` VALUES ('74', '19', '4');
INSERT INTO `authorization_role_privilege` VALUES ('75', '19', '5');
INSERT INTO `authorization_role_privilege` VALUES ('76', '19', '6');
INSERT INTO `authorization_role_privilege` VALUES ('77', '19', '7');
INSERT INTO `authorization_role_privilege` VALUES ('78', '19', '8');
INSERT INTO `authorization_role_privilege` VALUES ('79', '19', '9');
INSERT INTO `authorization_role_privilege` VALUES ('80', '19', '10');
INSERT INTO `authorization_role_privilege` VALUES ('81', '19', '11');
INSERT INTO `authorization_role_privilege` VALUES ('82', '19', '12');
INSERT INTO `authorization_role_privilege` VALUES ('83', '19', '13');
INSERT INTO `authorization_role_privilege` VALUES ('84', '20', '23');
INSERT INTO `authorization_role_privilege` VALUES ('86', '22', '31');
INSERT INTO `authorization_role_privilege` VALUES ('196', '22', '32');
INSERT INTO `authorization_role_privilege` VALUES ('194', '22', '33');
INSERT INTO `authorization_role_privilege` VALUES ('193', '22', '34');
INSERT INTO `authorization_role_privilege` VALUES ('197', '22', '38');
INSERT INTO `authorization_role_privilege` VALUES ('215', '22', '39');
INSERT INTO `authorization_role_privilege` VALUES ('214', '22', '40');
INSERT INTO `authorization_role_privilege` VALUES ('213', '22', '41');
INSERT INTO `authorization_role_privilege` VALUES ('199', '22', '42');
INSERT INTO `authorization_role_privilege` VALUES ('200', '22', '43');
INSERT INTO `authorization_role_privilege` VALUES ('198', '22', '44');
INSERT INTO `authorization_role_privilege` VALUES ('202', '22', '45');
INSERT INTO `authorization_role_privilege` VALUES ('204', '22', '46');
INSERT INTO `authorization_role_privilege` VALUES ('203', '22', '47');
INSERT INTO `authorization_role_privilege` VALUES ('201', '22', '48');
INSERT INTO `authorization_role_privilege` VALUES ('191', '22', '49');
INSERT INTO `authorization_role_privilege` VALUES ('192', '22', '50');
INSERT INTO `authorization_role_privilege` VALUES ('205', '22', '51');
INSERT INTO `authorization_role_privilege` VALUES ('207', '22', '52');
INSERT INTO `authorization_role_privilege` VALUES ('206', '22', '53');
INSERT INTO `authorization_role_privilege` VALUES ('211', '22', '54');
INSERT INTO `authorization_role_privilege` VALUES ('212', '22', '55');
INSERT INTO `authorization_role_privilege` VALUES ('210', '22', '56');
INSERT INTO `authorization_role_privilege` VALUES ('209', '22', '57');
INSERT INTO `authorization_role_privilege` VALUES ('208', '22', '58');
INSERT INTO `authorization_role_privilege` VALUES ('89', '23', '1');
INSERT INTO `authorization_role_privilege` VALUES ('90', '23', '2');
INSERT INTO `authorization_role_privilege` VALUES ('91', '23', '3');
INSERT INTO `authorization_role_privilege` VALUES ('92', '23', '4');
INSERT INTO `authorization_role_privilege` VALUES ('93', '23', '5');
INSERT INTO `authorization_role_privilege` VALUES ('94', '23', '6');
INSERT INTO `authorization_role_privilege` VALUES ('95', '23', '7');
INSERT INTO `authorization_role_privilege` VALUES ('96', '23', '8');
INSERT INTO `authorization_role_privilege` VALUES ('97', '23', '9');
INSERT INTO `authorization_role_privilege` VALUES ('98', '23', '10');
INSERT INTO `authorization_role_privilege` VALUES ('99', '23', '11');
INSERT INTO `authorization_role_privilege` VALUES ('100', '23', '12');
INSERT INTO `authorization_role_privilege` VALUES ('101', '23', '13');
INSERT INTO `authorization_role_privilege` VALUES ('102', '24', '23');
INSERT INTO `authorization_role_privilege` VALUES ('103', '25', '1');
INSERT INTO `authorization_role_privilege` VALUES ('104', '25', '2');
INSERT INTO `authorization_role_privilege` VALUES ('105', '25', '3');
INSERT INTO `authorization_role_privilege` VALUES ('106', '25', '4');
INSERT INTO `authorization_role_privilege` VALUES ('107', '25', '5');
INSERT INTO `authorization_role_privilege` VALUES ('108', '25', '6');
INSERT INTO `authorization_role_privilege` VALUES ('109', '25', '7');
INSERT INTO `authorization_role_privilege` VALUES ('110', '25', '8');
INSERT INTO `authorization_role_privilege` VALUES ('111', '25', '9');
INSERT INTO `authorization_role_privilege` VALUES ('112', '25', '10');
INSERT INTO `authorization_role_privilege` VALUES ('113', '25', '11');
INSERT INTO `authorization_role_privilege` VALUES ('114', '25', '12');
INSERT INTO `authorization_role_privilege` VALUES ('115', '25', '13');
INSERT INTO `authorization_role_privilege` VALUES ('116', '26', '23');
INSERT INTO `authorization_role_privilege` VALUES ('117', '27', '1');
INSERT INTO `authorization_role_privilege` VALUES ('118', '27', '2');
INSERT INTO `authorization_role_privilege` VALUES ('119', '27', '3');
INSERT INTO `authorization_role_privilege` VALUES ('120', '27', '4');
INSERT INTO `authorization_role_privilege` VALUES ('121', '27', '5');
INSERT INTO `authorization_role_privilege` VALUES ('122', '27', '6');
INSERT INTO `authorization_role_privilege` VALUES ('123', '27', '7');
INSERT INTO `authorization_role_privilege` VALUES ('124', '27', '8');
INSERT INTO `authorization_role_privilege` VALUES ('125', '27', '9');
INSERT INTO `authorization_role_privilege` VALUES ('126', '27', '10');
INSERT INTO `authorization_role_privilege` VALUES ('127', '27', '11');
INSERT INTO `authorization_role_privilege` VALUES ('128', '27', '12');
INSERT INTO `authorization_role_privilege` VALUES ('129', '27', '13');
INSERT INTO `authorization_role_privilege` VALUES ('130', '28', '23');
INSERT INTO `authorization_role_privilege` VALUES ('131', '29', '1');
INSERT INTO `authorization_role_privilege` VALUES ('132', '29', '2');
INSERT INTO `authorization_role_privilege` VALUES ('133', '29', '3');
INSERT INTO `authorization_role_privilege` VALUES ('134', '29', '4');
INSERT INTO `authorization_role_privilege` VALUES ('135', '29', '5');
INSERT INTO `authorization_role_privilege` VALUES ('136', '29', '6');
INSERT INTO `authorization_role_privilege` VALUES ('137', '29', '7');
INSERT INTO `authorization_role_privilege` VALUES ('138', '29', '8');
INSERT INTO `authorization_role_privilege` VALUES ('139', '29', '9');
INSERT INTO `authorization_role_privilege` VALUES ('140', '29', '10');
INSERT INTO `authorization_role_privilege` VALUES ('141', '29', '11');
INSERT INTO `authorization_role_privilege` VALUES ('142', '29', '12');
INSERT INTO `authorization_role_privilege` VALUES ('143', '29', '13');
INSERT INTO `authorization_role_privilege` VALUES ('144', '30', '23');
INSERT INTO `authorization_role_privilege` VALUES ('145', '31', '1');
INSERT INTO `authorization_role_privilege` VALUES ('146', '31', '2');
INSERT INTO `authorization_role_privilege` VALUES ('147', '31', '3');
INSERT INTO `authorization_role_privilege` VALUES ('148', '31', '4');
INSERT INTO `authorization_role_privilege` VALUES ('149', '31', '5');
INSERT INTO `authorization_role_privilege` VALUES ('150', '31', '6');
INSERT INTO `authorization_role_privilege` VALUES ('151', '31', '7');
INSERT INTO `authorization_role_privilege` VALUES ('152', '31', '8');
INSERT INTO `authorization_role_privilege` VALUES ('153', '31', '9');
INSERT INTO `authorization_role_privilege` VALUES ('154', '31', '10');
INSERT INTO `authorization_role_privilege` VALUES ('155', '31', '11');
INSERT INTO `authorization_role_privilege` VALUES ('156', '31', '12');
INSERT INTO `authorization_role_privilege` VALUES ('157', '31', '13');
INSERT INTO `authorization_role_privilege` VALUES ('158', '32', '23');
INSERT INTO `authorization_role_privilege` VALUES ('159', '33', '1');
INSERT INTO `authorization_role_privilege` VALUES ('160', '33', '2');
INSERT INTO `authorization_role_privilege` VALUES ('161', '33', '3');
INSERT INTO `authorization_role_privilege` VALUES ('162', '33', '4');
INSERT INTO `authorization_role_privilege` VALUES ('163', '33', '5');
INSERT INTO `authorization_role_privilege` VALUES ('164', '33', '6');
INSERT INTO `authorization_role_privilege` VALUES ('165', '33', '7');
INSERT INTO `authorization_role_privilege` VALUES ('166', '33', '8');
INSERT INTO `authorization_role_privilege` VALUES ('167', '33', '9');
INSERT INTO `authorization_role_privilege` VALUES ('168', '33', '10');
INSERT INTO `authorization_role_privilege` VALUES ('169', '33', '11');
INSERT INTO `authorization_role_privilege` VALUES ('170', '33', '12');
INSERT INTO `authorization_role_privilege` VALUES ('171', '33', '13');
INSERT INTO `authorization_role_privilege` VALUES ('172', '34', '23');
INSERT INTO `authorization_role_privilege` VALUES ('173', '35', '1');
INSERT INTO `authorization_role_privilege` VALUES ('174', '35', '2');
INSERT INTO `authorization_role_privilege` VALUES ('175', '35', '3');
INSERT INTO `authorization_role_privilege` VALUES ('176', '35', '4');
INSERT INTO `authorization_role_privilege` VALUES ('177', '35', '5');
INSERT INTO `authorization_role_privilege` VALUES ('178', '35', '6');
INSERT INTO `authorization_role_privilege` VALUES ('179', '35', '7');
INSERT INTO `authorization_role_privilege` VALUES ('180', '35', '8');
INSERT INTO `authorization_role_privilege` VALUES ('181', '35', '9');
INSERT INTO `authorization_role_privilege` VALUES ('182', '35', '10');
INSERT INTO `authorization_role_privilege` VALUES ('183', '35', '11');
INSERT INTO `authorization_role_privilege` VALUES ('184', '35', '12');
INSERT INTO `authorization_role_privilege` VALUES ('185', '35', '13');
INSERT INTO `authorization_role_privilege` VALUES ('186', '36', '23');
INSERT INTO `authorization_role_privilege` VALUES ('216', '38', '1');
INSERT INTO `authorization_role_privilege` VALUES ('217', '38', '2');
INSERT INTO `authorization_role_privilege` VALUES ('218', '38', '3');
INSERT INTO `authorization_role_privilege` VALUES ('219', '38', '4');
INSERT INTO `authorization_role_privilege` VALUES ('220', '38', '5');
INSERT INTO `authorization_role_privilege` VALUES ('221', '38', '6');
INSERT INTO `authorization_role_privilege` VALUES ('222', '38', '7');
INSERT INTO `authorization_role_privilege` VALUES ('223', '38', '8');
INSERT INTO `authorization_role_privilege` VALUES ('224', '38', '9');
INSERT INTO `authorization_role_privilege` VALUES ('225', '38', '10');
INSERT INTO `authorization_role_privilege` VALUES ('226', '38', '11');
INSERT INTO `authorization_role_privilege` VALUES ('227', '38', '12');
INSERT INTO `authorization_role_privilege` VALUES ('228', '38', '13');
INSERT INTO `authorization_role_privilege` VALUES ('229', '38', '14');
INSERT INTO `authorization_role_privilege` VALUES ('230', '38', '15');
INSERT INTO `authorization_role_privilege` VALUES ('231', '38', '16');
INSERT INTO `authorization_role_privilege` VALUES ('232', '38', '17');
INSERT INTO `authorization_role_privilege` VALUES ('233', '38', '18');
INSERT INTO `authorization_role_privilege` VALUES ('234', '38', '19');
INSERT INTO `authorization_role_privilege` VALUES ('235', '38', '20');
INSERT INTO `authorization_role_privilege` VALUES ('236', '38', '21');
INSERT INTO `authorization_role_privilege` VALUES ('237', '38', '22');
INSERT INTO `authorization_role_privilege` VALUES ('238', '38', '23');
INSERT INTO `authorization_role_privilege` VALUES ('239', '38', '24');
INSERT INTO `authorization_role_privilege` VALUES ('240', '38', '25');
INSERT INTO `authorization_role_privilege` VALUES ('241', '38', '26');
INSERT INTO `authorization_role_privilege` VALUES ('242', '38', '27');
INSERT INTO `authorization_role_privilege` VALUES ('243', '38', '28');
INSERT INTO `authorization_role_privilege` VALUES ('244', '38', '29');
INSERT INTO `authorization_role_privilege` VALUES ('245', '38', '30');
INSERT INTO `authorization_role_privilege` VALUES ('246', '38', '59');
INSERT INTO `authorization_role_privilege` VALUES ('247', '38', '60');
INSERT INTO `authorization_role_privilege` VALUES ('248', '38', '61');
INSERT INTO `authorization_role_privilege` VALUES ('249', '38', '62');
INSERT INTO `authorization_role_privilege` VALUES ('250', '38', '63');
INSERT INTO `authorization_role_privilege` VALUES ('251', '38', '64');
INSERT INTO `authorization_role_privilege` VALUES ('252', '38', '65');
INSERT INTO `authorization_role_privilege` VALUES ('253', '38', '66');
INSERT INTO `authorization_role_privilege` VALUES ('254', '38', '67');
INSERT INTO `authorization_role_privilege` VALUES ('255', '38', '68');
INSERT INTO `authorization_role_privilege` VALUES ('256', '38', '69');
INSERT INTO `authorization_role_privilege` VALUES ('257', '38', '70');
INSERT INTO `authorization_role_privilege` VALUES ('258', '38', '71');
INSERT INTO `authorization_role_privilege` VALUES ('259', '38', '72');
INSERT INTO `authorization_role_privilege` VALUES ('260', '38', '73');
INSERT INTO `authorization_role_privilege` VALUES ('261', '38', '74');
INSERT INTO `authorization_role_privilege` VALUES ('262', '38', '76');
INSERT INTO `authorization_role_privilege` VALUES ('263', '38', '77');
INSERT INTO `authorization_role_privilege` VALUES ('264', '38', '81');
INSERT INTO `authorization_role_privilege` VALUES ('265', '38', '82');
INSERT INTO `authorization_role_privilege` VALUES ('266', '38', '83');
INSERT INTO `authorization_role_privilege` VALUES ('267', '38', '84');
INSERT INTO `authorization_role_privilege` VALUES ('268', '38', '85');
INSERT INTO `authorization_role_privilege` VALUES ('269', '38', '86');
INSERT INTO `authorization_role_privilege` VALUES ('270', '38', '87');
INSERT INTO `authorization_role_privilege` VALUES ('272', '39', '3');
INSERT INTO `authorization_role_privilege` VALUES ('271', '39', '4');
INSERT INTO `authorization_role_privilege` VALUES ('273', '40', '1');
INSERT INTO `authorization_role_privilege` VALUES ('274', '40', '2');
INSERT INTO `authorization_role_privilege` VALUES ('275', '40', '3');
INSERT INTO `authorization_role_privilege` VALUES ('276', '40', '4');
INSERT INTO `authorization_role_privilege` VALUES ('277', '40', '5');
INSERT INTO `authorization_role_privilege` VALUES ('278', '40', '6');
INSERT INTO `authorization_role_privilege` VALUES ('279', '40', '7');
INSERT INTO `authorization_role_privilege` VALUES ('280', '40', '8');
INSERT INTO `authorization_role_privilege` VALUES ('281', '40', '9');
INSERT INTO `authorization_role_privilege` VALUES ('282', '40', '10');
INSERT INTO `authorization_role_privilege` VALUES ('283', '40', '11');
INSERT INTO `authorization_role_privilege` VALUES ('284', '40', '12');
INSERT INTO `authorization_role_privilege` VALUES ('285', '40', '13');
INSERT INTO `authorization_role_privilege` VALUES ('286', '40', '14');
INSERT INTO `authorization_role_privilege` VALUES ('287', '40', '15');
INSERT INTO `authorization_role_privilege` VALUES ('288', '40', '16');
INSERT INTO `authorization_role_privilege` VALUES ('289', '40', '17');
INSERT INTO `authorization_role_privilege` VALUES ('290', '40', '18');
INSERT INTO `authorization_role_privilege` VALUES ('291', '40', '19');
INSERT INTO `authorization_role_privilege` VALUES ('292', '40', '20');
INSERT INTO `authorization_role_privilege` VALUES ('293', '40', '21');
INSERT INTO `authorization_role_privilege` VALUES ('294', '40', '22');
INSERT INTO `authorization_role_privilege` VALUES ('295', '40', '23');
INSERT INTO `authorization_role_privilege` VALUES ('296', '40', '24');
INSERT INTO `authorization_role_privilege` VALUES ('297', '40', '25');
INSERT INTO `authorization_role_privilege` VALUES ('298', '40', '26');
INSERT INTO `authorization_role_privilege` VALUES ('299', '40', '27');
INSERT INTO `authorization_role_privilege` VALUES ('300', '40', '28');
INSERT INTO `authorization_role_privilege` VALUES ('301', '40', '29');
INSERT INTO `authorization_role_privilege` VALUES ('302', '40', '30');
INSERT INTO `authorization_role_privilege` VALUES ('303', '40', '59');
INSERT INTO `authorization_role_privilege` VALUES ('304', '40', '60');
INSERT INTO `authorization_role_privilege` VALUES ('305', '40', '61');
INSERT INTO `authorization_role_privilege` VALUES ('306', '40', '62');
INSERT INTO `authorization_role_privilege` VALUES ('307', '40', '63');
INSERT INTO `authorization_role_privilege` VALUES ('308', '40', '64');
INSERT INTO `authorization_role_privilege` VALUES ('309', '40', '65');
INSERT INTO `authorization_role_privilege` VALUES ('310', '40', '66');
INSERT INTO `authorization_role_privilege` VALUES ('311', '40', '67');
INSERT INTO `authorization_role_privilege` VALUES ('312', '40', '68');
INSERT INTO `authorization_role_privilege` VALUES ('313', '40', '69');
INSERT INTO `authorization_role_privilege` VALUES ('314', '40', '70');
INSERT INTO `authorization_role_privilege` VALUES ('315', '40', '71');
INSERT INTO `authorization_role_privilege` VALUES ('316', '40', '72');
INSERT INTO `authorization_role_privilege` VALUES ('317', '40', '73');
INSERT INTO `authorization_role_privilege` VALUES ('318', '40', '74');
INSERT INTO `authorization_role_privilege` VALUES ('319', '40', '76');
INSERT INTO `authorization_role_privilege` VALUES ('320', '40', '77');
INSERT INTO `authorization_role_privilege` VALUES ('321', '40', '81');
INSERT INTO `authorization_role_privilege` VALUES ('322', '40', '82');
INSERT INTO `authorization_role_privilege` VALUES ('323', '40', '83');
INSERT INTO `authorization_role_privilege` VALUES ('324', '40', '84');
INSERT INTO `authorization_role_privilege` VALUES ('325', '40', '85');
INSERT INTO `authorization_role_privilege` VALUES ('326', '40', '86');
INSERT INTO `authorization_role_privilege` VALUES ('327', '40', '87');
INSERT INTO `authorization_role_privilege` VALUES ('329', '41', '3');
INSERT INTO `authorization_role_privilege` VALUES ('328', '41', '4');
INSERT INTO `authorization_role_privilege` VALUES ('330', '46', '1');
INSERT INTO `authorization_role_privilege` VALUES ('331', '46', '2');
INSERT INTO `authorization_role_privilege` VALUES ('332', '46', '3');
INSERT INTO `authorization_role_privilege` VALUES ('333', '46', '4');
INSERT INTO `authorization_role_privilege` VALUES ('334', '46', '5');
INSERT INTO `authorization_role_privilege` VALUES ('335', '46', '6');
INSERT INTO `authorization_role_privilege` VALUES ('336', '46', '7');
INSERT INTO `authorization_role_privilege` VALUES ('337', '46', '8');
INSERT INTO `authorization_role_privilege` VALUES ('338', '46', '9');
INSERT INTO `authorization_role_privilege` VALUES ('339', '46', '10');
INSERT INTO `authorization_role_privilege` VALUES ('340', '46', '11');
INSERT INTO `authorization_role_privilege` VALUES ('341', '46', '12');
INSERT INTO `authorization_role_privilege` VALUES ('342', '46', '13');
INSERT INTO `authorization_role_privilege` VALUES ('343', '46', '14');
INSERT INTO `authorization_role_privilege` VALUES ('344', '46', '15');
INSERT INTO `authorization_role_privilege` VALUES ('345', '46', '16');
INSERT INTO `authorization_role_privilege` VALUES ('346', '46', '17');
INSERT INTO `authorization_role_privilege` VALUES ('347', '46', '18');
INSERT INTO `authorization_role_privilege` VALUES ('348', '46', '19');
INSERT INTO `authorization_role_privilege` VALUES ('349', '46', '20');
INSERT INTO `authorization_role_privilege` VALUES ('350', '46', '21');
INSERT INTO `authorization_role_privilege` VALUES ('351', '46', '22');
INSERT INTO `authorization_role_privilege` VALUES ('352', '46', '23');
INSERT INTO `authorization_role_privilege` VALUES ('353', '46', '24');
INSERT INTO `authorization_role_privilege` VALUES ('354', '46', '25');
INSERT INTO `authorization_role_privilege` VALUES ('355', '46', '26');
INSERT INTO `authorization_role_privilege` VALUES ('356', '46', '27');
INSERT INTO `authorization_role_privilege` VALUES ('357', '46', '28');
INSERT INTO `authorization_role_privilege` VALUES ('358', '46', '29');
INSERT INTO `authorization_role_privilege` VALUES ('359', '46', '30');
INSERT INTO `authorization_role_privilege` VALUES ('360', '46', '59');
INSERT INTO `authorization_role_privilege` VALUES ('361', '46', '60');
INSERT INTO `authorization_role_privilege` VALUES ('362', '46', '61');
INSERT INTO `authorization_role_privilege` VALUES ('363', '46', '62');
INSERT INTO `authorization_role_privilege` VALUES ('364', '46', '63');
INSERT INTO `authorization_role_privilege` VALUES ('365', '46', '64');
INSERT INTO `authorization_role_privilege` VALUES ('366', '46', '65');
INSERT INTO `authorization_role_privilege` VALUES ('367', '46', '66');
INSERT INTO `authorization_role_privilege` VALUES ('368', '46', '67');
INSERT INTO `authorization_role_privilege` VALUES ('369', '46', '68');
INSERT INTO `authorization_role_privilege` VALUES ('370', '46', '69');
INSERT INTO `authorization_role_privilege` VALUES ('371', '46', '70');
INSERT INTO `authorization_role_privilege` VALUES ('372', '46', '71');
INSERT INTO `authorization_role_privilege` VALUES ('373', '46', '72');
INSERT INTO `authorization_role_privilege` VALUES ('374', '46', '73');
INSERT INTO `authorization_role_privilege` VALUES ('375', '46', '74');
INSERT INTO `authorization_role_privilege` VALUES ('376', '46', '76');
INSERT INTO `authorization_role_privilege` VALUES ('377', '46', '77');
INSERT INTO `authorization_role_privilege` VALUES ('378', '46', '81');
INSERT INTO `authorization_role_privilege` VALUES ('379', '46', '82');
INSERT INTO `authorization_role_privilege` VALUES ('380', '46', '83');
INSERT INTO `authorization_role_privilege` VALUES ('381', '46', '84');
INSERT INTO `authorization_role_privilege` VALUES ('382', '46', '85');
INSERT INTO `authorization_role_privilege` VALUES ('383', '46', '86');
INSERT INTO `authorization_role_privilege` VALUES ('384', '46', '87');
INSERT INTO `authorization_role_privilege` VALUES ('386', '47', '3');
INSERT INTO `authorization_role_privilege` VALUES ('385', '47', '4');
INSERT INTO `authorization_role_privilege` VALUES ('387', '48', '1');
INSERT INTO `authorization_role_privilege` VALUES ('388', '48', '2');
INSERT INTO `authorization_role_privilege` VALUES ('389', '48', '3');
INSERT INTO `authorization_role_privilege` VALUES ('390', '48', '4');
INSERT INTO `authorization_role_privilege` VALUES ('391', '48', '5');
INSERT INTO `authorization_role_privilege` VALUES ('392', '48', '6');
INSERT INTO `authorization_role_privilege` VALUES ('393', '48', '7');
INSERT INTO `authorization_role_privilege` VALUES ('394', '48', '8');
INSERT INTO `authorization_role_privilege` VALUES ('395', '48', '9');
INSERT INTO `authorization_role_privilege` VALUES ('396', '48', '10');
INSERT INTO `authorization_role_privilege` VALUES ('397', '48', '11');
INSERT INTO `authorization_role_privilege` VALUES ('398', '48', '12');
INSERT INTO `authorization_role_privilege` VALUES ('399', '48', '13');
INSERT INTO `authorization_role_privilege` VALUES ('400', '48', '14');
INSERT INTO `authorization_role_privilege` VALUES ('401', '48', '15');
INSERT INTO `authorization_role_privilege` VALUES ('402', '48', '16');
INSERT INTO `authorization_role_privilege` VALUES ('403', '48', '17');
INSERT INTO `authorization_role_privilege` VALUES ('404', '48', '18');
INSERT INTO `authorization_role_privilege` VALUES ('405', '48', '19');
INSERT INTO `authorization_role_privilege` VALUES ('406', '48', '20');
INSERT INTO `authorization_role_privilege` VALUES ('407', '48', '21');
INSERT INTO `authorization_role_privilege` VALUES ('408', '48', '22');
INSERT INTO `authorization_role_privilege` VALUES ('409', '48', '23');
INSERT INTO `authorization_role_privilege` VALUES ('410', '48', '24');
INSERT INTO `authorization_role_privilege` VALUES ('411', '48', '25');
INSERT INTO `authorization_role_privilege` VALUES ('412', '48', '26');
INSERT INTO `authorization_role_privilege` VALUES ('413', '48', '27');
INSERT INTO `authorization_role_privilege` VALUES ('414', '48', '28');
INSERT INTO `authorization_role_privilege` VALUES ('415', '48', '29');
INSERT INTO `authorization_role_privilege` VALUES ('416', '48', '30');
INSERT INTO `authorization_role_privilege` VALUES ('417', '48', '59');
INSERT INTO `authorization_role_privilege` VALUES ('418', '48', '60');
INSERT INTO `authorization_role_privilege` VALUES ('419', '48', '61');
INSERT INTO `authorization_role_privilege` VALUES ('420', '48', '62');
INSERT INTO `authorization_role_privilege` VALUES ('421', '48', '63');
INSERT INTO `authorization_role_privilege` VALUES ('422', '48', '64');
INSERT INTO `authorization_role_privilege` VALUES ('423', '48', '65');
INSERT INTO `authorization_role_privilege` VALUES ('424', '48', '66');
INSERT INTO `authorization_role_privilege` VALUES ('425', '48', '67');
INSERT INTO `authorization_role_privilege` VALUES ('426', '48', '68');
INSERT INTO `authorization_role_privilege` VALUES ('427', '48', '69');
INSERT INTO `authorization_role_privilege` VALUES ('428', '48', '70');
INSERT INTO `authorization_role_privilege` VALUES ('429', '48', '71');
INSERT INTO `authorization_role_privilege` VALUES ('430', '48', '72');
INSERT INTO `authorization_role_privilege` VALUES ('431', '48', '73');
INSERT INTO `authorization_role_privilege` VALUES ('432', '48', '74');
INSERT INTO `authorization_role_privilege` VALUES ('433', '48', '76');
INSERT INTO `authorization_role_privilege` VALUES ('434', '48', '77');
INSERT INTO `authorization_role_privilege` VALUES ('435', '48', '81');
INSERT INTO `authorization_role_privilege` VALUES ('436', '48', '82');
INSERT INTO `authorization_role_privilege` VALUES ('437', '48', '83');
INSERT INTO `authorization_role_privilege` VALUES ('438', '48', '84');
INSERT INTO `authorization_role_privilege` VALUES ('439', '48', '85');
INSERT INTO `authorization_role_privilege` VALUES ('440', '48', '86');
INSERT INTO `authorization_role_privilege` VALUES ('441', '48', '87');
INSERT INTO `authorization_role_privilege` VALUES ('443', '49', '3');
INSERT INTO `authorization_role_privilege` VALUES ('442', '49', '4');
INSERT INTO `authorization_role_privilege` VALUES ('444', '50', '1');
INSERT INTO `authorization_role_privilege` VALUES ('445', '50', '2');
INSERT INTO `authorization_role_privilege` VALUES ('446', '50', '3');
INSERT INTO `authorization_role_privilege` VALUES ('447', '50', '4');
INSERT INTO `authorization_role_privilege` VALUES ('448', '50', '5');
INSERT INTO `authorization_role_privilege` VALUES ('449', '50', '6');
INSERT INTO `authorization_role_privilege` VALUES ('450', '50', '7');
INSERT INTO `authorization_role_privilege` VALUES ('451', '50', '8');
INSERT INTO `authorization_role_privilege` VALUES ('452', '50', '9');
INSERT INTO `authorization_role_privilege` VALUES ('453', '50', '10');
INSERT INTO `authorization_role_privilege` VALUES ('454', '50', '11');
INSERT INTO `authorization_role_privilege` VALUES ('455', '50', '12');
INSERT INTO `authorization_role_privilege` VALUES ('456', '50', '13');
INSERT INTO `authorization_role_privilege` VALUES ('457', '50', '14');
INSERT INTO `authorization_role_privilege` VALUES ('458', '50', '15');
INSERT INTO `authorization_role_privilege` VALUES ('459', '50', '16');
INSERT INTO `authorization_role_privilege` VALUES ('460', '50', '17');
INSERT INTO `authorization_role_privilege` VALUES ('461', '50', '18');
INSERT INTO `authorization_role_privilege` VALUES ('462', '50', '19');
INSERT INTO `authorization_role_privilege` VALUES ('463', '50', '20');
INSERT INTO `authorization_role_privilege` VALUES ('464', '50', '21');
INSERT INTO `authorization_role_privilege` VALUES ('465', '50', '22');
INSERT INTO `authorization_role_privilege` VALUES ('466', '50', '23');
INSERT INTO `authorization_role_privilege` VALUES ('467', '50', '24');
INSERT INTO `authorization_role_privilege` VALUES ('468', '50', '25');
INSERT INTO `authorization_role_privilege` VALUES ('469', '50', '26');
INSERT INTO `authorization_role_privilege` VALUES ('470', '50', '27');
INSERT INTO `authorization_role_privilege` VALUES ('471', '50', '28');
INSERT INTO `authorization_role_privilege` VALUES ('472', '50', '29');
INSERT INTO `authorization_role_privilege` VALUES ('473', '50', '30');
INSERT INTO `authorization_role_privilege` VALUES ('474', '50', '59');
INSERT INTO `authorization_role_privilege` VALUES ('475', '50', '60');
INSERT INTO `authorization_role_privilege` VALUES ('476', '50', '61');
INSERT INTO `authorization_role_privilege` VALUES ('477', '50', '62');
INSERT INTO `authorization_role_privilege` VALUES ('478', '50', '63');
INSERT INTO `authorization_role_privilege` VALUES ('479', '50', '64');
INSERT INTO `authorization_role_privilege` VALUES ('480', '50', '65');
INSERT INTO `authorization_role_privilege` VALUES ('481', '50', '66');
INSERT INTO `authorization_role_privilege` VALUES ('482', '50', '67');
INSERT INTO `authorization_role_privilege` VALUES ('483', '50', '68');
INSERT INTO `authorization_role_privilege` VALUES ('484', '50', '69');
INSERT INTO `authorization_role_privilege` VALUES ('485', '50', '70');
INSERT INTO `authorization_role_privilege` VALUES ('486', '50', '71');
INSERT INTO `authorization_role_privilege` VALUES ('487', '50', '72');
INSERT INTO `authorization_role_privilege` VALUES ('488', '50', '73');
INSERT INTO `authorization_role_privilege` VALUES ('489', '50', '74');
INSERT INTO `authorization_role_privilege` VALUES ('490', '50', '76');
INSERT INTO `authorization_role_privilege` VALUES ('491', '50', '77');
INSERT INTO `authorization_role_privilege` VALUES ('492', '50', '81');
INSERT INTO `authorization_role_privilege` VALUES ('493', '50', '82');
INSERT INTO `authorization_role_privilege` VALUES ('494', '50', '83');
INSERT INTO `authorization_role_privilege` VALUES ('495', '50', '84');
INSERT INTO `authorization_role_privilege` VALUES ('496', '50', '85');
INSERT INTO `authorization_role_privilege` VALUES ('497', '50', '86');
INSERT INTO `authorization_role_privilege` VALUES ('498', '50', '87');
INSERT INTO `authorization_role_privilege` VALUES ('500', '51', '3');
INSERT INTO `authorization_role_privilege` VALUES ('499', '51', '4');
INSERT INTO `authorization_role_privilege` VALUES ('501', '52', '1');
INSERT INTO `authorization_role_privilege` VALUES ('502', '52', '2');
INSERT INTO `authorization_role_privilege` VALUES ('503', '52', '3');
INSERT INTO `authorization_role_privilege` VALUES ('504', '52', '4');
INSERT INTO `authorization_role_privilege` VALUES ('505', '52', '5');
INSERT INTO `authorization_role_privilege` VALUES ('506', '52', '6');
INSERT INTO `authorization_role_privilege` VALUES ('507', '52', '7');
INSERT INTO `authorization_role_privilege` VALUES ('508', '52', '8');
INSERT INTO `authorization_role_privilege` VALUES ('509', '52', '9');
INSERT INTO `authorization_role_privilege` VALUES ('510', '52', '10');
INSERT INTO `authorization_role_privilege` VALUES ('511', '52', '11');
INSERT INTO `authorization_role_privilege` VALUES ('512', '52', '12');
INSERT INTO `authorization_role_privilege` VALUES ('513', '52', '13');
INSERT INTO `authorization_role_privilege` VALUES ('514', '52', '14');
INSERT INTO `authorization_role_privilege` VALUES ('515', '52', '15');
INSERT INTO `authorization_role_privilege` VALUES ('516', '52', '16');
INSERT INTO `authorization_role_privilege` VALUES ('517', '52', '17');
INSERT INTO `authorization_role_privilege` VALUES ('518', '52', '18');
INSERT INTO `authorization_role_privilege` VALUES ('519', '52', '19');
INSERT INTO `authorization_role_privilege` VALUES ('520', '52', '20');
INSERT INTO `authorization_role_privilege` VALUES ('521', '52', '21');
INSERT INTO `authorization_role_privilege` VALUES ('522', '52', '22');
INSERT INTO `authorization_role_privilege` VALUES ('523', '52', '23');
INSERT INTO `authorization_role_privilege` VALUES ('524', '52', '24');
INSERT INTO `authorization_role_privilege` VALUES ('525', '52', '25');
INSERT INTO `authorization_role_privilege` VALUES ('526', '52', '26');
INSERT INTO `authorization_role_privilege` VALUES ('527', '52', '27');
INSERT INTO `authorization_role_privilege` VALUES ('528', '52', '28');
INSERT INTO `authorization_role_privilege` VALUES ('529', '52', '29');
INSERT INTO `authorization_role_privilege` VALUES ('530', '52', '30');
INSERT INTO `authorization_role_privilege` VALUES ('531', '52', '59');
INSERT INTO `authorization_role_privilege` VALUES ('532', '52', '60');
INSERT INTO `authorization_role_privilege` VALUES ('533', '52', '61');
INSERT INTO `authorization_role_privilege` VALUES ('534', '52', '62');
INSERT INTO `authorization_role_privilege` VALUES ('535', '52', '63');
INSERT INTO `authorization_role_privilege` VALUES ('536', '52', '64');
INSERT INTO `authorization_role_privilege` VALUES ('537', '52', '65');
INSERT INTO `authorization_role_privilege` VALUES ('538', '52', '66');
INSERT INTO `authorization_role_privilege` VALUES ('539', '52', '67');
INSERT INTO `authorization_role_privilege` VALUES ('540', '52', '68');
INSERT INTO `authorization_role_privilege` VALUES ('541', '52', '69');
INSERT INTO `authorization_role_privilege` VALUES ('542', '52', '70');
INSERT INTO `authorization_role_privilege` VALUES ('543', '52', '71');
INSERT INTO `authorization_role_privilege` VALUES ('544', '52', '72');
INSERT INTO `authorization_role_privilege` VALUES ('545', '52', '73');
INSERT INTO `authorization_role_privilege` VALUES ('546', '52', '74');
INSERT INTO `authorization_role_privilege` VALUES ('547', '52', '76');
INSERT INTO `authorization_role_privilege` VALUES ('548', '52', '77');
INSERT INTO `authorization_role_privilege` VALUES ('549', '52', '81');
INSERT INTO `authorization_role_privilege` VALUES ('550', '52', '82');
INSERT INTO `authorization_role_privilege` VALUES ('551', '52', '83');
INSERT INTO `authorization_role_privilege` VALUES ('552', '52', '84');
INSERT INTO `authorization_role_privilege` VALUES ('553', '52', '85');
INSERT INTO `authorization_role_privilege` VALUES ('554', '52', '86');
INSERT INTO `authorization_role_privilege` VALUES ('555', '52', '87');
INSERT INTO `authorization_role_privilege` VALUES ('557', '53', '3');
INSERT INTO `authorization_role_privilege` VALUES ('556', '53', '4');
INSERT INTO `authorization_role_privilege` VALUES ('558', '54', '1');
INSERT INTO `authorization_role_privilege` VALUES ('559', '54', '2');
INSERT INTO `authorization_role_privilege` VALUES ('560', '54', '3');
INSERT INTO `authorization_role_privilege` VALUES ('561', '54', '4');
INSERT INTO `authorization_role_privilege` VALUES ('562', '54', '5');
INSERT INTO `authorization_role_privilege` VALUES ('563', '54', '6');
INSERT INTO `authorization_role_privilege` VALUES ('564', '54', '7');
INSERT INTO `authorization_role_privilege` VALUES ('565', '54', '8');
INSERT INTO `authorization_role_privilege` VALUES ('566', '54', '9');
INSERT INTO `authorization_role_privilege` VALUES ('567', '54', '10');
INSERT INTO `authorization_role_privilege` VALUES ('568', '54', '11');
INSERT INTO `authorization_role_privilege` VALUES ('569', '54', '12');
INSERT INTO `authorization_role_privilege` VALUES ('570', '54', '13');
INSERT INTO `authorization_role_privilege` VALUES ('571', '54', '14');
INSERT INTO `authorization_role_privilege` VALUES ('572', '54', '15');
INSERT INTO `authorization_role_privilege` VALUES ('573', '54', '16');
INSERT INTO `authorization_role_privilege` VALUES ('574', '54', '17');
INSERT INTO `authorization_role_privilege` VALUES ('575', '54', '18');
INSERT INTO `authorization_role_privilege` VALUES ('576', '54', '19');
INSERT INTO `authorization_role_privilege` VALUES ('577', '54', '20');
INSERT INTO `authorization_role_privilege` VALUES ('578', '54', '21');
INSERT INTO `authorization_role_privilege` VALUES ('579', '54', '22');
INSERT INTO `authorization_role_privilege` VALUES ('580', '54', '23');
INSERT INTO `authorization_role_privilege` VALUES ('581', '54', '24');
INSERT INTO `authorization_role_privilege` VALUES ('582', '54', '25');
INSERT INTO `authorization_role_privilege` VALUES ('583', '54', '26');
INSERT INTO `authorization_role_privilege` VALUES ('584', '54', '27');
INSERT INTO `authorization_role_privilege` VALUES ('585', '54', '28');
INSERT INTO `authorization_role_privilege` VALUES ('586', '54', '29');
INSERT INTO `authorization_role_privilege` VALUES ('587', '54', '30');
INSERT INTO `authorization_role_privilege` VALUES ('588', '54', '59');
INSERT INTO `authorization_role_privilege` VALUES ('589', '54', '60');
INSERT INTO `authorization_role_privilege` VALUES ('590', '54', '61');
INSERT INTO `authorization_role_privilege` VALUES ('591', '54', '62');
INSERT INTO `authorization_role_privilege` VALUES ('592', '54', '63');
INSERT INTO `authorization_role_privilege` VALUES ('593', '54', '64');
INSERT INTO `authorization_role_privilege` VALUES ('594', '54', '65');
INSERT INTO `authorization_role_privilege` VALUES ('595', '54', '66');
INSERT INTO `authorization_role_privilege` VALUES ('596', '54', '67');
INSERT INTO `authorization_role_privilege` VALUES ('597', '54', '68');
INSERT INTO `authorization_role_privilege` VALUES ('598', '54', '69');
INSERT INTO `authorization_role_privilege` VALUES ('599', '54', '70');
INSERT INTO `authorization_role_privilege` VALUES ('600', '54', '71');
INSERT INTO `authorization_role_privilege` VALUES ('601', '54', '72');
INSERT INTO `authorization_role_privilege` VALUES ('602', '54', '73');
INSERT INTO `authorization_role_privilege` VALUES ('603', '54', '74');
INSERT INTO `authorization_role_privilege` VALUES ('604', '54', '76');
INSERT INTO `authorization_role_privilege` VALUES ('605', '54', '77');
INSERT INTO `authorization_role_privilege` VALUES ('606', '54', '81');
INSERT INTO `authorization_role_privilege` VALUES ('607', '54', '82');
INSERT INTO `authorization_role_privilege` VALUES ('608', '54', '83');
INSERT INTO `authorization_role_privilege` VALUES ('609', '54', '84');
INSERT INTO `authorization_role_privilege` VALUES ('610', '54', '85');
INSERT INTO `authorization_role_privilege` VALUES ('611', '54', '86');
INSERT INTO `authorization_role_privilege` VALUES ('612', '54', '87');
INSERT INTO `authorization_role_privilege` VALUES ('614', '55', '3');
INSERT INTO `authorization_role_privilege` VALUES ('613', '55', '4');
INSERT INTO `authorization_role_privilege` VALUES ('615', '56', '1');
INSERT INTO `authorization_role_privilege` VALUES ('616', '56', '2');
INSERT INTO `authorization_role_privilege` VALUES ('617', '56', '3');
INSERT INTO `authorization_role_privilege` VALUES ('618', '56', '4');
INSERT INTO `authorization_role_privilege` VALUES ('619', '56', '5');
INSERT INTO `authorization_role_privilege` VALUES ('620', '56', '6');
INSERT INTO `authorization_role_privilege` VALUES ('621', '56', '7');
INSERT INTO `authorization_role_privilege` VALUES ('622', '56', '8');
INSERT INTO `authorization_role_privilege` VALUES ('623', '56', '9');
INSERT INTO `authorization_role_privilege` VALUES ('624', '56', '10');
INSERT INTO `authorization_role_privilege` VALUES ('625', '56', '11');
INSERT INTO `authorization_role_privilege` VALUES ('626', '56', '12');
INSERT INTO `authorization_role_privilege` VALUES ('627', '56', '13');
INSERT INTO `authorization_role_privilege` VALUES ('628', '56', '14');
INSERT INTO `authorization_role_privilege` VALUES ('629', '56', '15');
INSERT INTO `authorization_role_privilege` VALUES ('630', '56', '16');
INSERT INTO `authorization_role_privilege` VALUES ('631', '56', '17');
INSERT INTO `authorization_role_privilege` VALUES ('632', '56', '18');
INSERT INTO `authorization_role_privilege` VALUES ('633', '56', '19');
INSERT INTO `authorization_role_privilege` VALUES ('634', '56', '20');
INSERT INTO `authorization_role_privilege` VALUES ('635', '56', '21');
INSERT INTO `authorization_role_privilege` VALUES ('636', '56', '22');
INSERT INTO `authorization_role_privilege` VALUES ('637', '56', '23');
INSERT INTO `authorization_role_privilege` VALUES ('638', '56', '24');
INSERT INTO `authorization_role_privilege` VALUES ('639', '56', '25');
INSERT INTO `authorization_role_privilege` VALUES ('640', '56', '26');
INSERT INTO `authorization_role_privilege` VALUES ('641', '56', '27');
INSERT INTO `authorization_role_privilege` VALUES ('642', '56', '28');
INSERT INTO `authorization_role_privilege` VALUES ('643', '56', '29');
INSERT INTO `authorization_role_privilege` VALUES ('644', '56', '30');
INSERT INTO `authorization_role_privilege` VALUES ('645', '56', '59');
INSERT INTO `authorization_role_privilege` VALUES ('646', '56', '60');
INSERT INTO `authorization_role_privilege` VALUES ('647', '56', '61');
INSERT INTO `authorization_role_privilege` VALUES ('648', '56', '62');
INSERT INTO `authorization_role_privilege` VALUES ('649', '56', '63');
INSERT INTO `authorization_role_privilege` VALUES ('650', '56', '64');
INSERT INTO `authorization_role_privilege` VALUES ('651', '56', '65');
INSERT INTO `authorization_role_privilege` VALUES ('652', '56', '66');
INSERT INTO `authorization_role_privilege` VALUES ('653', '56', '67');
INSERT INTO `authorization_role_privilege` VALUES ('654', '56', '68');
INSERT INTO `authorization_role_privilege` VALUES ('655', '56', '69');
INSERT INTO `authorization_role_privilege` VALUES ('656', '56', '70');
INSERT INTO `authorization_role_privilege` VALUES ('657', '56', '71');
INSERT INTO `authorization_role_privilege` VALUES ('658', '56', '72');
INSERT INTO `authorization_role_privilege` VALUES ('659', '56', '73');
INSERT INTO `authorization_role_privilege` VALUES ('660', '56', '74');
INSERT INTO `authorization_role_privilege` VALUES ('661', '56', '76');
INSERT INTO `authorization_role_privilege` VALUES ('662', '56', '77');
INSERT INTO `authorization_role_privilege` VALUES ('663', '56', '81');
INSERT INTO `authorization_role_privilege` VALUES ('664', '56', '82');
INSERT INTO `authorization_role_privilege` VALUES ('665', '56', '83');
INSERT INTO `authorization_role_privilege` VALUES ('666', '56', '84');
INSERT INTO `authorization_role_privilege` VALUES ('667', '56', '85');
INSERT INTO `authorization_role_privilege` VALUES ('668', '56', '86');
INSERT INTO `authorization_role_privilege` VALUES ('669', '56', '87');
INSERT INTO `authorization_role_privilege` VALUES ('671', '57', '3');
INSERT INTO `authorization_role_privilege` VALUES ('670', '57', '4');
INSERT INTO `authorization_role_privilege` VALUES ('672', '58', '1');
INSERT INTO `authorization_role_privilege` VALUES ('673', '58', '2');
INSERT INTO `authorization_role_privilege` VALUES ('674', '58', '3');
INSERT INTO `authorization_role_privilege` VALUES ('675', '58', '4');
INSERT INTO `authorization_role_privilege` VALUES ('676', '58', '5');
INSERT INTO `authorization_role_privilege` VALUES ('677', '58', '6');
INSERT INTO `authorization_role_privilege` VALUES ('678', '58', '7');
INSERT INTO `authorization_role_privilege` VALUES ('679', '58', '8');
INSERT INTO `authorization_role_privilege` VALUES ('680', '58', '9');
INSERT INTO `authorization_role_privilege` VALUES ('681', '58', '10');
INSERT INTO `authorization_role_privilege` VALUES ('682', '58', '11');
INSERT INTO `authorization_role_privilege` VALUES ('683', '58', '12');
INSERT INTO `authorization_role_privilege` VALUES ('684', '58', '13');
INSERT INTO `authorization_role_privilege` VALUES ('685', '58', '14');
INSERT INTO `authorization_role_privilege` VALUES ('686', '58', '15');
INSERT INTO `authorization_role_privilege` VALUES ('687', '58', '16');
INSERT INTO `authorization_role_privilege` VALUES ('688', '58', '17');
INSERT INTO `authorization_role_privilege` VALUES ('689', '58', '18');
INSERT INTO `authorization_role_privilege` VALUES ('690', '58', '19');
INSERT INTO `authorization_role_privilege` VALUES ('691', '58', '20');
INSERT INTO `authorization_role_privilege` VALUES ('692', '58', '21');
INSERT INTO `authorization_role_privilege` VALUES ('693', '58', '22');
INSERT INTO `authorization_role_privilege` VALUES ('694', '58', '23');
INSERT INTO `authorization_role_privilege` VALUES ('695', '58', '24');
INSERT INTO `authorization_role_privilege` VALUES ('696', '58', '25');
INSERT INTO `authorization_role_privilege` VALUES ('697', '58', '26');
INSERT INTO `authorization_role_privilege` VALUES ('698', '58', '27');
INSERT INTO `authorization_role_privilege` VALUES ('699', '58', '28');
INSERT INTO `authorization_role_privilege` VALUES ('700', '58', '29');
INSERT INTO `authorization_role_privilege` VALUES ('701', '58', '30');
INSERT INTO `authorization_role_privilege` VALUES ('702', '58', '59');
INSERT INTO `authorization_role_privilege` VALUES ('703', '58', '60');
INSERT INTO `authorization_role_privilege` VALUES ('704', '58', '61');
INSERT INTO `authorization_role_privilege` VALUES ('705', '58', '62');
INSERT INTO `authorization_role_privilege` VALUES ('706', '58', '63');
INSERT INTO `authorization_role_privilege` VALUES ('707', '58', '64');
INSERT INTO `authorization_role_privilege` VALUES ('708', '58', '65');
INSERT INTO `authorization_role_privilege` VALUES ('709', '58', '66');
INSERT INTO `authorization_role_privilege` VALUES ('710', '58', '67');
INSERT INTO `authorization_role_privilege` VALUES ('711', '58', '68');
INSERT INTO `authorization_role_privilege` VALUES ('712', '58', '69');
INSERT INTO `authorization_role_privilege` VALUES ('713', '58', '70');
INSERT INTO `authorization_role_privilege` VALUES ('714', '58', '71');
INSERT INTO `authorization_role_privilege` VALUES ('715', '58', '72');
INSERT INTO `authorization_role_privilege` VALUES ('716', '58', '73');
INSERT INTO `authorization_role_privilege` VALUES ('717', '58', '74');
INSERT INTO `authorization_role_privilege` VALUES ('718', '58', '76');
INSERT INTO `authorization_role_privilege` VALUES ('719', '58', '77');
INSERT INTO `authorization_role_privilege` VALUES ('720', '58', '81');
INSERT INTO `authorization_role_privilege` VALUES ('721', '58', '82');
INSERT INTO `authorization_role_privilege` VALUES ('722', '58', '83');
INSERT INTO `authorization_role_privilege` VALUES ('723', '58', '84');
INSERT INTO `authorization_role_privilege` VALUES ('724', '58', '85');
INSERT INTO `authorization_role_privilege` VALUES ('725', '58', '86');
INSERT INTO `authorization_role_privilege` VALUES ('726', '58', '87');
INSERT INTO `authorization_role_privilege` VALUES ('728', '59', '3');
INSERT INTO `authorization_role_privilege` VALUES ('727', '59', '4');
INSERT INTO `authorization_role_privilege` VALUES ('729', '60', '1');
INSERT INTO `authorization_role_privilege` VALUES ('730', '60', '2');
INSERT INTO `authorization_role_privilege` VALUES ('731', '60', '3');
INSERT INTO `authorization_role_privilege` VALUES ('732', '60', '4');
INSERT INTO `authorization_role_privilege` VALUES ('733', '60', '5');
INSERT INTO `authorization_role_privilege` VALUES ('734', '60', '6');
INSERT INTO `authorization_role_privilege` VALUES ('735', '60', '7');
INSERT INTO `authorization_role_privilege` VALUES ('736', '60', '8');
INSERT INTO `authorization_role_privilege` VALUES ('737', '60', '9');
INSERT INTO `authorization_role_privilege` VALUES ('738', '60', '10');
INSERT INTO `authorization_role_privilege` VALUES ('739', '60', '11');
INSERT INTO `authorization_role_privilege` VALUES ('740', '60', '12');
INSERT INTO `authorization_role_privilege` VALUES ('741', '60', '13');
INSERT INTO `authorization_role_privilege` VALUES ('742', '60', '14');
INSERT INTO `authorization_role_privilege` VALUES ('743', '60', '15');
INSERT INTO `authorization_role_privilege` VALUES ('744', '60', '16');
INSERT INTO `authorization_role_privilege` VALUES ('745', '60', '17');
INSERT INTO `authorization_role_privilege` VALUES ('746', '60', '18');
INSERT INTO `authorization_role_privilege` VALUES ('747', '60', '19');
INSERT INTO `authorization_role_privilege` VALUES ('748', '60', '20');
INSERT INTO `authorization_role_privilege` VALUES ('749', '60', '21');
INSERT INTO `authorization_role_privilege` VALUES ('750', '60', '22');
INSERT INTO `authorization_role_privilege` VALUES ('751', '60', '23');
INSERT INTO `authorization_role_privilege` VALUES ('752', '60', '24');
INSERT INTO `authorization_role_privilege` VALUES ('753', '60', '25');
INSERT INTO `authorization_role_privilege` VALUES ('754', '60', '26');
INSERT INTO `authorization_role_privilege` VALUES ('755', '60', '27');
INSERT INTO `authorization_role_privilege` VALUES ('756', '60', '28');
INSERT INTO `authorization_role_privilege` VALUES ('757', '60', '29');
INSERT INTO `authorization_role_privilege` VALUES ('758', '60', '30');
INSERT INTO `authorization_role_privilege` VALUES ('759', '60', '59');
INSERT INTO `authorization_role_privilege` VALUES ('760', '60', '60');
INSERT INTO `authorization_role_privilege` VALUES ('761', '60', '61');
INSERT INTO `authorization_role_privilege` VALUES ('762', '60', '62');
INSERT INTO `authorization_role_privilege` VALUES ('763', '60', '63');
INSERT INTO `authorization_role_privilege` VALUES ('764', '60', '64');
INSERT INTO `authorization_role_privilege` VALUES ('765', '60', '65');
INSERT INTO `authorization_role_privilege` VALUES ('766', '60', '66');
INSERT INTO `authorization_role_privilege` VALUES ('767', '60', '67');
INSERT INTO `authorization_role_privilege` VALUES ('768', '60', '68');
INSERT INTO `authorization_role_privilege` VALUES ('769', '60', '69');
INSERT INTO `authorization_role_privilege` VALUES ('770', '60', '70');
INSERT INTO `authorization_role_privilege` VALUES ('771', '60', '71');
INSERT INTO `authorization_role_privilege` VALUES ('772', '60', '72');
INSERT INTO `authorization_role_privilege` VALUES ('773', '60', '73');
INSERT INTO `authorization_role_privilege` VALUES ('774', '60', '74');
INSERT INTO `authorization_role_privilege` VALUES ('775', '60', '76');
INSERT INTO `authorization_role_privilege` VALUES ('776', '60', '77');
INSERT INTO `authorization_role_privilege` VALUES ('777', '60', '81');
INSERT INTO `authorization_role_privilege` VALUES ('778', '60', '82');
INSERT INTO `authorization_role_privilege` VALUES ('779', '60', '83');
INSERT INTO `authorization_role_privilege` VALUES ('780', '60', '84');
INSERT INTO `authorization_role_privilege` VALUES ('781', '60', '85');
INSERT INTO `authorization_role_privilege` VALUES ('782', '60', '86');
INSERT INTO `authorization_role_privilege` VALUES ('783', '60', '87');
INSERT INTO `authorization_role_privilege` VALUES ('785', '61', '3');
INSERT INTO `authorization_role_privilege` VALUES ('784', '61', '4');

-- ----------------------------
-- Table structure for `bundle`
-- ----------------------------
DROP TABLE IF EXISTS `bundle`;
CREATE TABLE `bundle` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '套餐名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '套餐编码',
  `TENANT_TYPE_CODE` varchar(50) DEFAULT NULL COMMENT '租户类型编码',
  `ABILITY` longtext COMMENT '套餐包含功能描述,JSON格式的角色与权限',
  `NUMBER_OF_INVOCATION` int(11) NOT NULL COMMENT 'API调用次数/月',
  `NUMBER_OF_CONCURRENT` int(11) NOT NULL COMMENT '并发数/秒',
  `NUMBER_OF_APP` int(11) NOT NULL COMMENT '允许创建应用数量',
  `COMMENT` varchar(200) DEFAULT NULL COMMENT '套餐说明',
  `INITIALIZE` int(1) DEFAULT NULL COMMENT '是否为初始化套餐',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `bundle_unq_code` (`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of bundle
-- ----------------------------
INSERT INTO `bundle` VALUES ('1', '系统管理根租户初始化套餐', 'admin', 'admin', null, '0', '0', '0', null, '1');
INSERT INTO `bundle` VALUES ('2', '闪聚支付-商户初始化版', 'shanju-merchant', 'shanju-merchant', '[{\"name\":\"商户管理员\",\"code\": \"r_001\",\"privilegeCodes\": [\"sj_m_console\",\"sj_m_app_list\",\"sj_m_transaction_list\",\"sj_m_account_check\",\"sj_m_payment\",\"sj_m_account_list\",\"sj_m_enterprise_auth\",\"sj_m_store_list\",\"sj_m_staff_list\",\"sj_o_member_list\",\"sj_o_entreprise_list\",\"sj_o_audit\",\"sj_o_service_type\",\"sj_o_account_check\",\"sj_o_admin_list\",\"sj_o_role_list\",\"sj_m_app_create\",\"sj_m_payment_set\",\"sj_m_store_create\",\"sj_m_store_query\",\"sj_m_staff_create\",\"sj_m_staff_query\",\"sj_o_member_query\",\"sj_o_enterprise_query\",\"sj_o_enterprise_create\",\"sj_o_service_create\",\"sj_o_service_query\",\"sj_o_admin_create\",\"sj_o_admin_query\",\"sj_o_role_create\",\"sj_o_role_query\",\"sj_o_role_save\",\"sj_m_auth_apply\",\"sj_m_console_renew\",\"sj_m_console_upgrade\",\"sj_m_app_save\",\"sj_m_app_modify\",\"sj_m_payparam_save\",\"sj_m_pay_set\",\"sj_m_pay_save\",\"sj_m_c2b_qrcode\",\"sj_m_b2c_order\",\"sj_m_h5_view\",\"sj_m_bundle_buy\",\"sj_m_enterprise_info_submit\",\"sj_m_enterprise_info_cancel\",\"sj_o_enterprise_auth_pass\",\"sj_o_enterprise_auth_rejection\",\"sj_m_store_edit\",\"sj_m_staff_edit\",\"sj_o_admin_edit\",\"sj_o_role_edit\",\"sj_m_store_save\",\"sj_m_store_del\",\"sj_m_staff_save\"]},{\"name\": \"商户门店收银员\",\"code\": \"r_002\",\"privilegeCodes\": [\"sj_m_account_check\",\"sj_m_transaction_list\"]}]', '1000', '10', '1', null, '1');

-- ----------------------------
-- Table structure for `resource_application`
-- ----------------------------
DROP TABLE IF EXISTS `resource_application`;
CREATE TABLE `resource_application` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '应用名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '应用编码',
  `TENANT_ID` bigint(20) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用信息';

-- ----------------------------
-- Records of resource_application
-- ----------------------------
INSERT INTO `resource_application` VALUES ('1', '闪聚支付-商户平台', 'merchant-platform', '1');
INSERT INTO `resource_application` VALUES ('2', '闪聚支付-运营平台', 'operation-platform', '1');
INSERT INTO `resource_application` VALUES ('3', '门户', 'portal-site', '1');
INSERT INTO `resource_application` VALUES ('4', '商户平台app版', 'merchant-platform-app', '1');

-- ----------------------------
-- Table structure for `resource_button`
-- ----------------------------
DROP TABLE IF EXISTS `resource_button`;
CREATE TABLE `resource_button` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父id',
  `TITLE` varchar(50) NOT NULL COMMENT '按钮标题',
  `URL` varchar(200) DEFAULT NULL COMMENT '链接url',
  `ICON` varchar(50) DEFAULT NULL COMMENT '图标',
  `SORT` int(11) NOT NULL COMMENT '排序',
  `COMMENT` varchar(200) DEFAULT NULL COMMENT '说明',
  `STATUS` int(11) NOT NULL COMMENT '状态',
  `APPLICATION_CODE` varchar(50) DEFAULT NULL COMMENT '所属应用编码',
  `PRIVILEGE_CODE` varchar(50) DEFAULT NULL COMMENT '绑定权限',
  `PCODE` varchar(200) DEFAULT NULL COMMENT '用于鉴权',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1241761810982985032 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='按钮资源';

-- ----------------------------
-- Records of resource_button
-- ----------------------------
INSERT INTO `resource_button` VALUES ('1241761810982985001', null, '工作台-升级', null, null, '2', null, '1', 'merchant-platform', 'sj_m_console_upgrade', 'sj_m_console_upgrade');
INSERT INTO `resource_button` VALUES ('1241761810982985002', null, '工作台-续费', null, null, '1', null, '1', 'merchant-platform', 'sj_m_console_renew', 'sj_m_console_renew');
INSERT INTO `resource_button` VALUES ('1241761810982985003', null, '创建应用', null, null, '1', null, '1', 'merchant-platform', 'sj_m_app_create', 'sj_m_app_create');
INSERT INTO `resource_button` VALUES ('1241761810982985004', null, '保存应用', null, null, '1', null, '1', 'merchant-platform', 'sj_m_app_save', 'sj_m_app_save');
INSERT INTO `resource_button` VALUES ('1241761810982985005', null, '编辑应用', null, null, '1', null, '1', 'merchant-platform', 'sj_m_app_edit', 'sj_m_app_edit');
INSERT INTO `resource_button` VALUES ('1241761810982985010', null, '支付参数保存', null, null, '1', null, '1', 'merchant-platform', 'sj_m_payparam_save', 'sj_m_payparam_save');
INSERT INTO `resource_button` VALUES ('1241761810982985011', null, '设置默认支付', null, null, '1', null, '1', 'merchant-platform', 'sj_m_pay_set', 'sj_m_pay_set');
INSERT INTO `resource_button` VALUES ('1241761810982985012', null, '保存默认支付', null, null, '1', null, '1', 'merchant-platform', 'sj_m_pay_save', 'sj_m_pay_save');
INSERT INTO `resource_button` VALUES ('1241761810982985013', null, 'C扫B二维码', null, null, '1', null, '1', 'merchant-platform', 'sj_m_c2b_qrcode', 'sj_m_c2b_qrcode');
INSERT INTO `resource_button` VALUES ('1241761810982985014', null, 'B扫C订单', null, null, '1', null, '1', 'merchant-platform', 'sj_m_b2c_order', 'sj_m_b2c_order');
INSERT INTO `resource_button` VALUES ('1241761810982985015', null, '购买套餐', null, null, '1', null, '1', 'merchant-platform', 'sj_m_bundle_buy', 'sj_m_bundle_buy');
INSERT INTO `resource_button` VALUES ('1241761810982985017', null, '企业认证资料提交', null, null, '1', null, '1', 'merchant-platform', 'sj_m_enterprise_info_submit', 'sj_m_enterprise_info_submit');
INSERT INTO `resource_button` VALUES ('1241761810982985018', null, '会员查询', null, null, '1', null, '1', 'merchant-platform', 'sj_o_member_query', 'sj_o_member_query');
INSERT INTO `resource_button` VALUES ('1241761810982985019', null, '审核管理企业查询', null, null, '1', null, '1', 'merchant-platform', 'sj_o_enterprise_query', 'sj_o_enterprise_query');
INSERT INTO `resource_button` VALUES ('1241761810982985021', null, '门店管理-新建按钮', null, null, '1', null, '1', 'merchant-platform', 'sj_m_store_create', 'sj_m_store_create');
INSERT INTO `resource_button` VALUES ('1241761810982985022', null, '门店管理-编辑按钮', null, null, '1', null, '1', 'merchant-platform', 'sj_m_store_edit', 'sj_m_store_edit');
INSERT INTO `resource_button` VALUES ('1241761810982985023', null, '门店管理-删除按钮', null, null, '1', null, '1', 'merchant-platform', 'sj_m_store_del', 'sj_m_store_del');
INSERT INTO `resource_button` VALUES ('1241761810982985024', null, '门店管理-查询按钮', null, null, '1', null, '1', 'merchant-platform', 'sj_m_store_query', 'sj_m_store_query');
INSERT INTO `resource_button` VALUES ('1241761810982985025', null, '门店管理-保存按钮', null, null, '1', null, '1', 'merchant-platform', 'sj_m_store_save', 'sj_m_store_save');
INSERT INTO `resource_button` VALUES ('1241761810982985026', null, '成员管理-新建按钮', null, null, '1', null, '1', 'merchant-platform', 'sj_m_staff_create', 'sj_m_staff_create');
INSERT INTO `resource_button` VALUES ('1241761810982985027', null, '成员管理-编辑按钮', null, null, '1', null, '1', 'merchant-platform', 'sj_m_staff_edit', 'sj_m_staff_edit');
INSERT INTO `resource_button` VALUES ('1241761810982985029', null, '课程管理-课程审核', null, null, '1', null, '1', null, 'p_xc_c_001', null);
INSERT INTO `resource_button` VALUES ('1241761810982985030', null, '媒资管理-审核媒体资质', null, null, '1', null, '1', null, 'p_xc_m_001', null);
INSERT INTO `resource_button` VALUES ('1241761810982985031', null, '机构管理-审核机构', null, null, '1', null, '1', null, 'p_xc_t_001', null);

-- ----------------------------
-- Table structure for `resource_menu`
-- ----------------------------
DROP TABLE IF EXISTS `resource_menu`;
CREATE TABLE `resource_menu` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父id',
  `TITLE` varchar(50) NOT NULL COMMENT '菜单标题',
  `URL` varchar(200) DEFAULT NULL COMMENT '链接url',
  `ICON` varchar(50) DEFAULT NULL COMMENT '图标',
  `SORT` int(11) NOT NULL COMMENT '排序',
  `COMMENT` varchar(200) DEFAULT NULL COMMENT '说明',
  `STATUS` int(11) NOT NULL COMMENT '状态',
  `APPLICATION_CODE` varchar(50) DEFAULT NULL COMMENT '所属应用编码',
  `PRIVILEGE_CODE` varchar(50) DEFAULT NULL COMMENT '绑定权限',
  `PCODE` varchar(200) DEFAULT NULL COMMENT '用于鉴权',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单';

-- ----------------------------
-- Records of resource_menu
-- ----------------------------
INSERT INTO `resource_menu` VALUES ('1', null, '商户后台', null, null, '1', null, '1', '', null, null);
INSERT INTO `resource_menu` VALUES ('2', null, '运营商后台', null, null, '1', null, '1', '', null, null);
INSERT INTO `resource_menu` VALUES ('3', null, '门户', null, null, '1', null, '1', '', null, null);
INSERT INTO `resource_menu` VALUES ('4', '1', '工作台', null, null, '1', null, '1', 'merchant-platform', 'sj_m_console', 'sj_m_console');
INSERT INTO `resource_menu` VALUES ('5', '1', '应用管理', null, null, '2', null, '1', 'merchant-platform', '', '');
INSERT INTO `resource_menu` VALUES ('6', '1', '账户管理', null, null, '3', null, '1', 'merchant-platform', null, null);
INSERT INTO `resource_menu` VALUES ('7', '1', '组织管理', null, null, '4', null, '1', 'merchant-platform', null, null);
INSERT INTO `resource_menu` VALUES ('8', '2', '企业管理', null, null, '1', null, '1', 'merchant-platform', '', null);
INSERT INTO `resource_menu` VALUES ('9', '2', '服务类型管理', null, null, '2', null, '1', 'merchant-platform', '', null);
INSERT INTO `resource_menu` VALUES ('10', '2', '账单管理', null, null, '3', null, '1', 'merchant-platform', '', null);
INSERT INTO `resource_menu` VALUES ('11', '2', '系统管理', null, null, '4', null, '1', 'merchant-platform', '', null);
INSERT INTO `resource_menu` VALUES ('12', '5', '应用管理列表', null, null, '1', null, '1', 'merchant-platform', 'sj_m_app_list', 'sj_m_app_list');
INSERT INTO `resource_menu` VALUES ('13', '5', '应用交易总览', null, null, '2', null, '1', 'merchant-platform', 'sj_m_transaction_list', 'sj_m_transaction_list');
INSERT INTO `resource_menu` VALUES ('14', '5', '应用财务对账', null, null, '3', null, '1', 'merchant-platform', 'sj_m_account_check', 'sj_m_account_check');
INSERT INTO `resource_menu` VALUES ('15', '5', '开始支付', null, null, '4', null, '1', 'merchant-platform', 'sj_m_payment', 'sj_m_payment');
INSERT INTO `resource_menu` VALUES ('16', '6', '账户中心', null, null, '1', null, '1', 'merchant-platform', 'sj_m_account_list', 'sj_m_account_list');
INSERT INTO `resource_menu` VALUES ('17', '6', '企业认证申请', null, null, '2', null, '1', 'merchant-platform', 'sj_m_enterprise_auth', 'sj_m_enterprise_auth');
INSERT INTO `resource_menu` VALUES ('18', '7', '门店管理', null, null, '1', null, '1', 'merchant-platform', 'sj_m_store_list', 'sj_m_store_list');
INSERT INTO `resource_menu` VALUES ('19', '7', '成员管理', null, null, '2', null, '1', 'merchant-platform', 'sj_m_staff_list', 'sj_m_staff_list');
INSERT INTO `resource_menu` VALUES ('20', '8', '会员管理', null, null, '1', null, '1', 'operation-platform', 'sj_o_member_list', 'sj_o_member_list');
INSERT INTO `resource_menu` VALUES ('21', '8', '企业管理', null, null, '2', null, '1', 'operation-platform', 'sj_o_entreprise_list', 'sj_o_entreprise_list');
INSERT INTO `resource_menu` VALUES ('22', '8', '审核管理', null, null, '3', null, '1', 'operation-platform', 'sj_o_audit', 'sj_o_audit');
INSERT INTO `resource_menu` VALUES ('23', '9', '服务类型管理', null, null, '1', null, '1', 'operation-platform', 'sj_o_service_type', 'sj_o_service_type');
INSERT INTO `resource_menu` VALUES ('24', '10', '往来对账', null, null, '1', null, '1', 'operation-platform', 'sj_o_account_check', 'sj_o_account_check');
INSERT INTO `resource_menu` VALUES ('25', '11', '管理员管理', null, null, '1', null, '1', 'operation-platform', 'sj_o_admin_list', 'sj_o_admin_list');
INSERT INTO `resource_menu` VALUES ('26', '11', '角色管理', null, null, '2', null, '1', 'operation-platform', 'sj_o_role_list', 'sj_o_role_list');

-- ----------------------------
-- Table structure for `tenant`
-- ----------------------------
DROP TABLE IF EXISTS `tenant`;
CREATE TABLE `tenant` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(512) DEFAULT NULL COMMENT '租户名称',
  `TENANT_TYPE_CODE` varchar(50) DEFAULT NULL COMMENT '租户类型编码',
  `BUNDLE_CODE` varchar(50) DEFAULT NULL COMMENT '购买套餐编码',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tenant
-- ----------------------------
INSERT INTO `tenant` VALUES ('1', '根租户', 'admin', 'admin');
INSERT INTO `tenant` VALUES ('2', '大代表_BohuRH', 'shanju-merchant', 'shanju-merchant');
INSERT INTO `tenant` VALUES ('9', '大代表1_Wu646i', 'shanju-merchant', 'shanju-merchant');
INSERT INTO `tenant` VALUES ('10', '大代表122_zuLhM5', 'shanju-merchant', 'shanju-merchant');
INSERT INTO `tenant` VALUES ('11', 'dabiao122_2JZKO6', 'shanju-merchant', 'shanju-merchant');
INSERT INTO `tenant` VALUES ('14', 'daibiao01_A29B2z', 'shanju-merchant', 'shanju-merchant');
INSERT INTO `tenant` VALUES ('15', 'daibiao02_q76jip', 'shanju-merchant', 'shanju-merchant');

-- ----------------------------
-- Table structure for `tenant_account`
-- ----------------------------
DROP TABLE IF EXISTS `tenant_account`;
CREATE TABLE `tenant_account` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TENANT_ID` bigint(20) DEFAULT NULL COMMENT '租户id',
  `ACCOUNT_ID` bigint(20) DEFAULT NULL COMMENT '账号d',
  `IS_ADMIN` tinyint(1) DEFAULT NULL COMMENT '是否是租户管理员',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tenant_account
-- ----------------------------
INSERT INTO `tenant_account` VALUES ('1', '2', '2', '1');
INSERT INTO `tenant_account` VALUES ('2', '9', '3', '1');
INSERT INTO `tenant_account` VALUES ('3', '10', '4', '1');
INSERT INTO `tenant_account` VALUES ('4', '11', '5', '1');
INSERT INTO `tenant_account` VALUES ('5', '14', '7', '1');
INSERT INTO `tenant_account` VALUES ('6', '15', '9', '1');

-- ----------------------------
-- Table structure for `tenant_type`
-- ----------------------------
DROP TABLE IF EXISTS `tenant_type`;
CREATE TABLE `tenant_type` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '租户类型名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '租户类型编码',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tenant_type
-- ----------------------------
INSERT INTO `tenant_type` VALUES ('1', '系统管理组织', 'admin');
INSERT INTO `tenant_type` VALUES ('2', '闪聚支付-运营商', 'shanju-operation');
INSERT INTO `tenant_type` VALUES ('3', '闪聚支付-签约商户', 'shanju-merchant');
