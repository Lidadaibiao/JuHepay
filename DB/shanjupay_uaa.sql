/*
Navicat MySQL Data Transfer

Source Server         : lidadaibiao
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : shanjupay_uaa

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-06-09 20:33:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `oauth_client_details`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(255) NOT NULL COMMENT '客户端标识',
  `resource_ids` varchar(255) DEFAULT NULL COMMENT '接入资源列表',
  `client_secret` varchar(255) DEFAULT NULL COMMENT '客户端秘钥',
  `scope` varchar(255) DEFAULT NULL,
  `authorized_grant_types` varchar(255) DEFAULT NULL,
  `web_server_redirect_uri` varchar(255) DEFAULT NULL,
  `authorities` varchar(255) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` longtext,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `archived` tinyint(4) DEFAULT NULL,
  `trusted` tinyint(4) DEFAULT NULL,
  `autoapprove` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='接入客户端信息';

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('507f38136d4443f3a07f07d3ce5f9a05', 'shanju-resource', '', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_API', '7200', '259200', null, '2019-11-13 08:18:32', null, '0', null);
INSERT INTO `oauth_client_details` VALUES ('5fe423628cd14143a94d05575323555d', 'shanju-resource', '', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_API', '7200', '259200', null, '2019-11-13 11:00:29', null, '0', null);
INSERT INTO `oauth_client_details` VALUES ('8016770e53ab495cb88bacb626930ceb', 'shanju-resource', '', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_API', '7200', '259200', null, '2019-11-13 08:16:27', null, '0', null);
INSERT INTO `oauth_client_details` VALUES ('e366cfc9373e440abbdbe5818aa6c91b', 'shanju-resource', '', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_API', '7200', '259200', null, '2019-11-13 10:02:01', null, '0', null);
INSERT INTO `oauth_client_details` VALUES ('merchant-platform', 'shanju-resource', '123456', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_MERCHANT,ROLE_USER', '31536000', '259200', null, '2020-06-09 14:32:55', '0', '0', 'false');
INSERT INTO `oauth_client_details` VALUES ('operation-platform', 'shanju-resource', '123456', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_OPERATION', '7200', '259200', null, '2019-09-26 10:10:07', '0', '0', 'false');
INSERT INTO `oauth_client_details` VALUES ('portal-site', 'shanju-resource', '123456', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_PORTAL', '7200', '259200', null, '2019-09-26 10:10:18', '0', '0', 'false');
INSERT INTO `oauth_client_details` VALUES ('shanju-resource', 'shanju-resource', 'suiyixie', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', null, 'ROLE_API', '7200', '259200', null, '2019-10-24 02:29:38', null, '0', null);

-- ----------------------------
-- Table structure for `oauth_code`
-- ----------------------------
DROP TABLE IF EXISTS `oauth_code`;
CREATE TABLE `oauth_code` (
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `code` varchar(255) NOT NULL COMMENT '授权码',
  `authentication` longblob COMMENT '认证信息',
  PRIMARY KEY (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='授权码';

-- ----------------------------
-- Records of oauth_code
-- ----------------------------
