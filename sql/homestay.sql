/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : homestay

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 05/02/2024 10:09:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (5, 'sys_house', '', NULL, NULL, 'SysHouse', 'crud', '', 'com.ruoyi.system', 'system', 'house', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2024-01-25 23:51:47', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (7, 'sys_service', '', NULL, NULL, 'SysService', 'crud', '', 'com.ruoyi.system', 'system', 'service', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2024-01-29 14:52:05', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (16, 'sys_contract', '合同', NULL, NULL, 'SysContract', 'crud', '', 'com.ruoyi.system', 'system', 'contract', '合同', 'ruoyi', '0', '/', NULL, 'admin', '2024-02-01 02:07:59', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (26, 'sys_comment', '评价', NULL, NULL, 'SysComment', 'crud', '', 'com.ruoyi.system', 'system', 'comment', '评价', 'ruoyi', '0', '/', NULL, 'admin', '2024-02-05 05:24:19', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (28, 'sys_repair', '报修', NULL, NULL, 'SysRepair', 'crud', '', 'com.ruoyi.system', 'system', 'repair', '报修', 'ruoyi', '0', '/', NULL, 'admin', '2024-02-05 07:29:21', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (29, 'sys_order', '主订单', NULL, NULL, 'SysOrder', 'crud', '', 'com.ruoyi.system', 'system', 'order', '主订单', 'ruoyi', '0', '/', NULL, 'admin', '2024-02-05 08:53:11', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (30, 'sys_order_item', '子订单', NULL, NULL, 'SysOrderItem', 'crud', '', 'com.ruoyi.system', 'system', 'item', '子订单', 'ruoyi', '0', '/', NULL, 'admin', '2024-02-05 08:53:11', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 386 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (54, 5, 'house_id', '房源ID', 'bigint', 'Long', 'houseId', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (55, 5, 'user_id', '房东用户ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (56, 5, 'name', '名称', 'varchar(255)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (57, 5, 'address', '地址', 'varchar(255)', 'String', 'address', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (58, 5, 'infrastructure', '基础设施字典ID，多个英文逗号分隔', 'varchar(255)', 'String', 'infrastructure', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (59, 5, 'image_url', '图片url，多个英文逗号分隔', 'varchar(255)', 'String', 'imageUrl', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (60, 5, 'area', '面积', 'decimal(10,2)', 'BigDecimal', 'area', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (61, 5, 'price', '价格/天', 'decimal(10,2)', 'BigDecimal', 'price', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (62, 5, 'description', '描述', 'varchar(255)', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (63, 5, 'rent_status', '租赁状态，0-未租，1-已租', 'tinyint(1)', 'Integer', 'rentStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (64, 5, 'house_status', '房屋状态，0-空置，1-已入住', 'tinyint(1)', 'Integer', 'houseStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (65, 5, 'password', '门禁密码', 'varchar(255)', 'String', 'password', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (66, 5, 'del_flag', '删除标志（0代表存在 2代表删除）', 'tinyint(1)', 'Integer', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (67, 5, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (68, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (69, 5, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (70, 5, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2024-01-25 23:51:47', '', NULL);
INSERT INTO `gen_table_column` VALUES (83, 7, 'service_id', '特色服务ID', 'bigint', 'Long', 'serviceId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (84, 7, 'house_id', '房源ID', 'bigint', 'Long', 'houseId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (85, 7, 'name', '服务名称', 'varchar(255)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (86, 7, 'price', '价格', 'decimal(10,2)', 'BigDecimal', 'price', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (87, 7, 'description', '服务描述', 'varchar(255)', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (88, 7, 'cost', '成本', 'decimal(10,2)', 'BigDecimal', 'cost', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (89, 7, 'remain', '剩余数量', 'bigint', 'Long', 'remain', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (90, 7, 'del_flag', '删除标志（0代表存在 2代表删除）', 'tinyint(1)', 'Integer', 'delFlag', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (91, 7, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (92, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (93, 7, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (94, 7, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2024-01-29 14:52:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (248, 16, 'contract_id', '合同ID', 'bigint', 'Long', 'contractId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (249, 16, 'house_id', '房源ID', 'bigint', 'Long', 'houseId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (250, 16, 'house_address', '房源地址', 'varchar(255)', 'String', 'houseAddress', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (251, 16, 'user_id', '房东用户ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (252, 16, 'landlord_name', '房东姓名', 'varchar(255)', 'String', 'landlordName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (253, 16, 'landlord_idcard', '房东身份证', 'varchar(255)', 'String', 'landlordIdcard', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (254, 16, 'landlord_phone', '房东电话', 'varchar(255)', 'String', 'landlordPhone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (255, 16, 'landlord_address', '房东地址', 'varchar(255)', 'String', 'landlordAddress', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (256, 16, 'platform_name', '平台公司名称', 'varchar(255)', 'String', 'platformName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 9, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (257, 16, 'platform_address', '平台公司地址', 'varchar(255)', 'String', 'platformAddress', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (258, 16, 'platform_legal_name', '平台公司法人', 'varchar(255)', 'String', 'platformLegalName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 11, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (259, 16, 'platform_phone', '平台公司电话', 'varchar(255)', 'String', 'platformPhone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (260, 16, 'status', '状态，0-审批中，1-审批失败，2-合同生效，3-合同终止', 'tinyint(1)', 'Integer', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 13, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (261, 16, 'signing_date', '平台审核通过后合同生效日期', 'date', 'Date', 'signingDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (262, 16, 'submit_date', '房东合同提交日期', 'date', 'Date', 'submitDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 15, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (263, 16, 'terminate_date', '合同终止日期', 'date', 'Date', 'terminateDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 16, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (264, 16, 'err_msg', '审核失败原因', 'varchar(255)', 'String', 'errMsg', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 17, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (265, 16, 'del_flag', '删除标志（0代表存在 2代表删除）', 'tinyint(1)', 'Integer', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 18, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (266, 16, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (267, 16, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 20, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (268, 16, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 21, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (269, 16, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 22, 'admin', '2024-02-01 02:07:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (386, 26, 'comment_id', '评论ID', 'bigint', 'Long', 'commentId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-02-05 05:24:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (387, 26, 'order_item_id', '子订单ID', 'bigint', 'Long', 'orderItemId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2024-02-05 05:24:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (388, 26, 'house_id', '房源ID', 'bigint', 'Long', 'houseId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2024-02-05 05:24:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (389, 26, 'service_id', '特色服务ID', 'bigint', 'Long', 'serviceId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2024-02-05 05:24:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (390, 26, 'user_id', '房客用户ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2024-02-05 05:24:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (391, 26, 'type', '评论类型（1房屋评论2特色服务评论）', 'tinyint(1)', 'Integer', 'type', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 6, 'admin', '2024-02-05 05:24:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (392, 26, 'content', '评论内容', 'varchar(255)', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 7, 'admin', '2024-02-05 05:24:19', '', NULL);
INSERT INTO `gen_table_column` VALUES (393, 26, 'score', '评分（1-5）', 'int', 'Long', 'score', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2024-02-05 05:24:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (394, 26, 'del_flag', '删除标志（0代表存在 2代表删除）', 'tinyint(1)', 'Integer', 'delFlag', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2024-02-05 05:24:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (395, 26, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2024-02-05 05:24:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (396, 26, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2024-02-05 05:24:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (397, 26, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2024-02-05 05:24:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (398, 26, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2024-02-05 05:24:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (409, 28, 'repair_id', '报修ID', 'bigint', 'Long', 'repairId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (410, 28, 'landlord_user_id', '房东用户ID', 'bigint', 'Long', 'landlordUserId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (411, 28, 'house_id', '房源ID', 'bigint', 'Long', 'houseId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (412, 28, 'user_id', '房客用户ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (413, 28, 'description', '报修描述', 'varchar(255)', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (414, 28, 'status', '报修状态，0-未维修，1-已维修', 'tinyint(1)', 'Integer', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 6, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (415, 28, 'del_flag', '删除标志（0代表存在 2代表删除）', 'tinyint(1)', 'Integer', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (416, 28, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (417, 28, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (418, 28, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (419, 28, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2024-02-05 07:29:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (420, 29, 'order_id', '订单ID', 'bigint', 'Long', 'orderId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (421, 29, 'house_id', '房源ID', 'bigint', 'Long', 'houseId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (422, 29, 'landlord_user_id', '房东ID', 'bigint', 'Long', 'landlordUserId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (423, 29, 'user_id', '房客ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (424, 29, 'price', '订单总金额', 'decimal(10,2)', 'BigDecimal', 'price', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (425, 29, 'arrival_date', '入住日期', 'date', 'Date', 'arrivalDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (426, 29, 'departure_date', '离开日期', 'date', 'Date', 'departureDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (427, 29, 'tenant_info', '入住房客信息，json字符串，例[{\"name\":\"xx\",\"idcard\":\"35023023\"}]', 'varchar(255)', 'String', 'tenantInfo', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (428, 29, 'status', '订单状态，0-待使用，1-进行中，2-已完成，3-退款中，4-已退款', 'tinyint(1)', 'Integer', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (429, 29, 'del_flag', '删除标志（0代表存在 2代表删除）', 'tinyint(1)', 'Integer', 'delFlag', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (430, 29, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (431, 29, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (432, 29, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (433, 29, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (434, 30, 'order_item_id', '子订单ID', 'bigint', 'Long', 'orderItemId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (435, 30, 'order_id', '主订单ID', 'bigint', 'Long', 'orderId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (436, 30, 'landlord_user_id', '房东用户ID', 'bigint', 'Long', 'landlordUserId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (437, 30, 'user_id', '房客用户ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (438, 30, 'type', '子订单产品类型，1-房屋，2-特色服务', 'tinyint(1)', 'Integer', 'type', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (439, 30, 'product_id', '子订单产品ID，type=1时为房屋ID，type=2时为服务ID', 'bigint', 'Long', 'productId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (440, 30, 'num', '产品数量，type=1时为入住天数，type=2时为服务数量', 'int', 'Long', 'num', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (441, 30, 'price', '产品单价，type=1时为房屋单天价格，type=2时为服务单价', 'decimal(10,2)', 'BigDecimal', 'price', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (442, 30, 'total', '子订单总价', 'decimal(10,0)', 'Long', 'total', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (443, 30, 'status', '状态，0-待使用，1-进行中，2-待评价，3-已完成，4-退款中，5-已退款', 'tinyint(1)', 'Integer', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (444, 30, 'del_flag', '删除标志（0代表存在 2代表删除）', 'tinyint(1)', 'Integer', 'delFlag', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (445, 30, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (446, 30, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (447, 30, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2024-02-05 08:53:11', '', NULL);
INSERT INTO `gen_table_column` VALUES (448, 30, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2024-02-05 08:53:11', '', NULL);

-- ----------------------------
-- Table structure for sys_comment
-- ----------------------------
DROP TABLE IF EXISTS `sys_comment`;
CREATE TABLE `sys_comment`  (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `order_item_id` bigint NULL DEFAULT NULL COMMENT '子订单ID',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房源ID',
  `service_id` bigint NULL DEFAULT NULL COMMENT '特色服务ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '房客用户ID',
  `type` tinyint(1) NOT NULL COMMENT '评论类型（1房屋评论2特色服务评论）',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `score` int NULL DEFAULT NULL COMMENT '评分（1-5）',
  `del_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评价' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_comment
-- ----------------------------
INSERT INTO `sys_comment` VALUES (2, 3, 2, NULL, 102, 1, '环境不错，老板人很好。。', 4, 0, '', '2024-02-05 05:35:38', '', '2024-02-05 05:37:17');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2024-01-11 16:13:55', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2024-01-11 16:13:55', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2024-01-11 16:13:55', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2024-01-11 16:13:55', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2024-01-11 16:13:55', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2024-01-11 16:13:55', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_contract
-- ----------------------------
DROP TABLE IF EXISTS `sys_contract`;
CREATE TABLE `sys_contract`  (
  `contract_id` bigint NOT NULL AUTO_INCREMENT COMMENT '合同ID',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房源ID',
  `house_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房源地址',
  `user_id` bigint NULL DEFAULT NULL COMMENT '房东用户ID',
  `landlord_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房东姓名',
  `landlord_idcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房东身份证',
  `landlord_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房东电话',
  `landlord_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房东地址',
  `platform_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台公司名称',
  `platform_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台公司地址',
  `platform_legal_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台公司法人',
  `platform_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台公司电话',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态，0-审批中，1-审批失败，2-合同生效，3-合同终止',
  `signing_date` date NULL DEFAULT NULL COMMENT '平台审核通过后合同生效日期',
  `submit_date` date NULL DEFAULT NULL COMMENT '房东合同提交日期',
  `terminate_date` date NULL DEFAULT NULL COMMENT '合同终止日期',
  `err_msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核失败原因',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合同' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_contract
-- ----------------------------
INSERT INTO `sys_contract` VALUES (2, 1, '新澳路1509,1511号', 103, '李四', '350205198309090012', '13023928329', '福建省厦门市翔安区新澳路', '特色民宿科技有限公司', '福建省厦门市xx路', '章三', '0592-1233423', 2, '2024-02-01', '2024-01-31', NULL, '房东地址无效', 0, '', '2024-01-31 19:25:31', '', '2024-02-01 02:48:23');
INSERT INTO `sys_contract` VALUES (3, 104, '新澳路1497号', 103, '李四', '350205198309090012', '13023928329', '福建省厦门市翔安区xx', '特色民宿科技有限公司', '福建省厦门市xx路', '章三', '0592-1233423', 3, '2024-01-31', '2024-01-31', '2024-02-01', NULL, 0, '', '2024-01-31 20:47:05', '', '2024-02-01 02:33:24');
INSERT INTO `sys_contract` VALUES (4, 104, '新澳路1497号', 103, '李四', '350205198302090012', '13023985798', '谢谢撒倒萨倒萨', '特色民宿科技有限公司', '福建省厦门市xx路', '章三', '0592-1233423', 1, NULL, '2024-02-01', NULL, '地址错误', 0, '', '2024-02-01 02:41:02', '', '2024-02-01 02:41:37');
INSERT INTO `sys_contract` VALUES (5, 2, '新澳路1525号', 104, '王五', '350205199002040012', '13023923829', '福建省厦门市翔安区', '特色民宿科技有限公司', '福建省厦门市xx路', '章三', '0592-1233423', 2, '2024-02-01', '2024-02-01', NULL, NULL, 0, '', '2024-02-01 15:59:51', '', '2024-02-01 16:03:49');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (103, 0, '0', '平台', 1, '', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-01-11 16:13:55', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 0, '0', '房东', 2, '', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-01-11 16:13:55', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 0, '0', '房客', 3, '', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-01-11 16:13:55', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, 'WIFI', 'wifi', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-28 13:02:16', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 1, '空调', 'air-conditioning', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-28 13:03:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 2, '洗衣机', 'washer', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-28 13:03:40', 'admin', '2024-01-28 13:04:57', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 3, '电吹风', 'hairDrier', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-28 13:04:42', 'admin', '2024-01-28 13:05:02', NULL);
INSERT INTO `sys_dict_data` VALUES (104, 4, '床', 'bed', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-29 01:52:30', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 5, '衣柜', 'wardrobe', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-29 01:52:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 6, '沙发', 'sofa', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-29 01:53:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 7, '电视', 'tv', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-29 01:53:25', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 8, '冰箱', 'refrigerator', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-29 01:53:44', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 9, '热水器', 'heater', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-29 01:54:07', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 10, '燃气灶', 'gasStove', 'house_infrastructure', NULL, 'default', 'N', '0', 'admin', '2024-01-29 01:54:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 0, '特色民宿科技有限公司', 'platformName', 'contract_info', NULL, 'default', 'N', '0', 'admin', '2024-01-29 18:06:16', 'admin', '2024-01-31 15:36:22', NULL);
INSERT INTO `sys_dict_data` VALUES (112, 0, '福建省厦门市xx路', 'platformAddress', 'contract_info', NULL, 'default', 'N', '0', 'admin', '2024-01-31 15:37:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 0, '章三', 'platformLegalName', 'contract_info', NULL, 'default', 'N', '0', 'admin', '2024-01-31 15:38:58', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (114, 0, '0592-1233423', 'platformPhone', 'contract_info', NULL, 'default', 'N', '0', 'admin', '2024-01-31 15:39:22', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 0, 'feeRatio', '15', 'platform', NULL, 'default', 'N', '0', 'admin', '2024-02-05 08:46:51', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '房源基础设施', 'house_infrastructure', '0', 'admin', '2024-01-28 13:00:51', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (12, '合同参数信息', 'contract_info', '0', 'admin', '2024-01-29 18:05:30', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (13, '平台参数', 'platform', '0', 'admin', '2024-02-05 08:45:12', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_house
-- ----------------------------
DROP TABLE IF EXISTS `sys_house`;
CREATE TABLE `sys_house`  (
  `house_id` bigint NOT NULL AUTO_INCREMENT COMMENT '房源ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '房东用户ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `infrastructure` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '基础设施字典编码，多个英文逗号分隔',
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片url，多个英文逗号分隔',
  `area` decimal(10, 2) NULL DEFAULT NULL COMMENT '面积',
  `max_person` int NULL DEFAULT NULL COMMENT '最大入住人数',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格/天',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `rent_status` tinyint(1) NULL DEFAULT 0 COMMENT '供租状态，0-未供租，1-已供租，2-已退租',
  `house_status` tinyint(1) NULL DEFAULT 0 COMMENT '房屋状态，0-空置，1-已下单未入住，2-已入住',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '门禁密码',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`house_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_house
-- ----------------------------
INSERT INTO `sys_house` VALUES (1, 103, '隧道口温馨住家一房一厅带阳台', '新澳路1509,1511号', '100,101,102,103', '1706464141949.jpg,1706464039131.jpg', 55.00, 6, 400.00, '房屋特点：\n1、户型特点：中高层、户型方正、采光视野好，适宜居住。\n2、室内精装修，拎包入住，客厅宽敞大方，使用率高；卧室温馨舒适，搭配心怡；厨房设施齐全，让美味来得更加轻松。\n3、环境优雅，低密度社区，小区绿化率高，让你每天生活在空气清新的环境下。\n小区地理位置好，位于商业圈，交通便利，出小区就是公交站牌，小区周边配套设施齐全，银行、超市、菜市、学校、医院、商务会所，应有尽有。小区环境幽雅，绿化面积大，家里家室家电齐全，可带衣物直接入住！看房方便，提前预约！欢迎致电！', 1, 0, '123456', 0, '', '2024-01-28 18:51:04', '', '2024-02-01 04:34:40');
INSERT INTO `sys_house` VALUES (2, 104, '边套采光杠杠 三台空调 中央集成灶 自住装 电梯房 地铁口', '新澳路1525号', '100,101,102,103,104,105,110,109,108,107,106', '1706774933276.jpg,1706774933282.jpg', 88.00, 1, 500.00, '房源理由：\n（1）小区地段非常繁华，小区入住率非常高！出门就是同兴生鲜超市，水果店，包子店、餐饮店、奶茶店、咖啡店、烧烤店、炸鸡店、卤味店、理发店、美甲店、近闽蓝城市广场、奥特莱斯、农贸市场等！\n（2）周边银行、医院、公园等配套非常齐全。\n（3）在隧道口、地铁口、翔安大桥旁，楼下有公交非常方便，楼下周边停车不收费！\n（4）小区附近有汇德乐幼儿园、幼儿托育中心、翔城小学、金海小学、和风小学、翔城中学、双十中学、翔安中学等。\n（5）房东非常诚心出租，等您来电，看房随时方便！东西非常清爽，都是房东自己住的配套！', 1, 2, '123456', 0, '', '2024-01-29 01:56:25', '', '2024-02-01 16:08:53');
INSERT INTO `sys_house` VALUES (104, 103, '新景国际城融汇公馆 2室2厅1卫 电梯房', '新澳路1497号', '100,101,107,106,108,102,109,103,110,104,105', '1706513398823.jpg,1706513398826.jpg', 89.00, 8, 400.00, '正规户型,整套出租,2室2厅1卫,南朝向,精装修,电梯房', 0, 0, '123456', 0, '', '2024-01-29 15:29:59', '', '2024-02-01 04:34:55');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (100, '每日14点登记入住', 'SYSTEM', 'orderTask.checkIn', '0 0 14 * * ?', '1', '1', '0', 'admin', '2024-02-05 03:16:44', 'admin', '2024-02-05 03:33:10', '');
INSERT INTO `sys_job` VALUES (101, '每日12点登记离店', 'SYSTEM', 'orderTask.checkOut', '0 0 12 * * ?', '1', '1', '0', 'admin', '2024-02-05 03:33:55', 'admin', '2024-02-05 03:34:21', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 428 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 16:14:14');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 16:24:41');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 17:32:22');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 17:33:27');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 17:37:52');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 17:39:38');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 17:41:05');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 17:43:51');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 18:03:11');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 18:10:38');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 18:38:36');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 19:26:58');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-11 19:29:17');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 19:29:22');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 19:32:10');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 20:08:24');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 20:14:07');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 20:20:34');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-11 20:24:40');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2024-01-16 01:19:12');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2024-01-16 01:19:22');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2024-01-16 01:21:35');
INSERT INTO `sys_logininfor` VALUES (122, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '注册成功', '2024-01-18 21:11:18');
INSERT INTO `sys_logininfor` VALUES (123, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '注册成功', '2024-01-18 23:35:23');
INSERT INTO `sys_logininfor` VALUES (124, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:37:04');
INSERT INTO `sys_logininfor` VALUES (125, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-18 23:46:02');
INSERT INTO `sys_logininfor` VALUES (126, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:47:53');
INSERT INTO `sys_logininfor` VALUES (127, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:53:56');
INSERT INTO `sys_logininfor` VALUES (128, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:54:02');
INSERT INTO `sys_logininfor` VALUES (129, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:54:12');
INSERT INTO `sys_logininfor` VALUES (130, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:54:39');
INSERT INTO `sys_logininfor` VALUES (131, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:54:58');
INSERT INTO `sys_logininfor` VALUES (132, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:55:02');
INSERT INTO `sys_logininfor` VALUES (133, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:55:22');
INSERT INTO `sys_logininfor` VALUES (134, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:55:59');
INSERT INTO `sys_logininfor` VALUES (135, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:57:02');
INSERT INTO `sys_logininfor` VALUES (136, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:57:18');
INSERT INTO `sys_logininfor` VALUES (137, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:58:08');
INSERT INTO `sys_logininfor` VALUES (138, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-18 23:59:04');
INSERT INTO `sys_logininfor` VALUES (139, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:00:39');
INSERT INTO `sys_logininfor` VALUES (140, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-19 00:00:59');
INSERT INTO `sys_logininfor` VALUES (141, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:01:02');
INSERT INTO `sys_logininfor` VALUES (142, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-19 00:02:45');
INSERT INTO `sys_logininfor` VALUES (143, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:02:48');
INSERT INTO `sys_logininfor` VALUES (144, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-19 00:03:04');
INSERT INTO `sys_logininfor` VALUES (145, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:03:06');
INSERT INTO `sys_logininfor` VALUES (146, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:03:38');
INSERT INTO `sys_logininfor` VALUES (147, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:07:01');
INSERT INTO `sys_logininfor` VALUES (148, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:07:31');
INSERT INTO `sys_logininfor` VALUES (149, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:10:04');
INSERT INTO `sys_logininfor` VALUES (150, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-19 00:10:09');
INSERT INTO `sys_logininfor` VALUES (151, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:10:15');
INSERT INTO `sys_logininfor` VALUES (152, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-19 00:10:34');
INSERT INTO `sys_logininfor` VALUES (153, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:10:46');
INSERT INTO `sys_logininfor` VALUES (154, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:11:50');
INSERT INTO `sys_logininfor` VALUES (155, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-19 00:11:54');
INSERT INTO `sys_logininfor` VALUES (156, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-19 00:11:58');
INSERT INTO `sys_logininfor` VALUES (157, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-21 02:14:48');
INSERT INTO `sys_logininfor` VALUES (158, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-21 02:15:11');
INSERT INTO `sys_logininfor` VALUES (159, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-21 02:15:24');
INSERT INTO `sys_logininfor` VALUES (160, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-21 02:15:31');
INSERT INTO `sys_logininfor` VALUES (161, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-21 02:15:35');
INSERT INTO `sys_logininfor` VALUES (162, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-21 02:15:40');
INSERT INTO `sys_logininfor` VALUES (163, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-21 02:15:59');
INSERT INTO `sys_logininfor` VALUES (164, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-21 02:19:20');
INSERT INTO `sys_logininfor` VALUES (165, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-21 02:19:24');
INSERT INTO `sys_logininfor` VALUES (166, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-21 14:46:10');
INSERT INTO `sys_logininfor` VALUES (167, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-21 16:51:05');
INSERT INTO `sys_logininfor` VALUES (168, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-22 01:34:47');
INSERT INTO `sys_logininfor` VALUES (169, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-22 01:48:53');
INSERT INTO `sys_logininfor` VALUES (170, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-22 01:49:00');
INSERT INTO `sys_logininfor` VALUES (171, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-23 22:21:09');
INSERT INTO `sys_logininfor` VALUES (172, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-23 23:58:38');
INSERT INTO `sys_logininfor` VALUES (173, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-23 23:58:45');
INSERT INTO `sys_logininfor` VALUES (174, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-23 23:59:25');
INSERT INTO `sys_logininfor` VALUES (175, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 11:56:54');
INSERT INTO `sys_logininfor` VALUES (176, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 14:28:27');
INSERT INTO `sys_logininfor` VALUES (177, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 15:26:24');
INSERT INTO `sys_logininfor` VALUES (178, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 15:32:13');
INSERT INTO `sys_logininfor` VALUES (179, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 15:32:18');
INSERT INTO `sys_logininfor` VALUES (180, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 15:32:22');
INSERT INTO `sys_logininfor` VALUES (181, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 15:32:27');
INSERT INTO `sys_logininfor` VALUES (182, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 15:32:41');
INSERT INTO `sys_logininfor` VALUES (183, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 15:33:49');
INSERT INTO `sys_logininfor` VALUES (184, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 15:33:52');
INSERT INTO `sys_logininfor` VALUES (185, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 15:36:03');
INSERT INTO `sys_logininfor` VALUES (186, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 16:32:02');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:43:21');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:43:38');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:43:42');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:43:49');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:43:53');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:48:01');
INSERT INTO `sys_logininfor` VALUES (193, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:48:10');
INSERT INTO `sys_logininfor` VALUES (194, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:48:18');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:48:22');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:49:19');
INSERT INTO `sys_logininfor` VALUES (197, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:49:24');
INSERT INTO `sys_logininfor` VALUES (198, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:49:33');
INSERT INTO `sys_logininfor` VALUES (199, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:50:00');
INSERT INTO `sys_logininfor` VALUES (200, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:55:19');
INSERT INTO `sys_logininfor` VALUES (201, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:55:23');
INSERT INTO `sys_logininfor` VALUES (202, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:55:45');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:55:49');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:56:45');
INSERT INTO `sys_logininfor` VALUES (205, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:56:50');
INSERT INTO `sys_logininfor` VALUES (206, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:57:12');
INSERT INTO `sys_logininfor` VALUES (207, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:58:10');
INSERT INTO `sys_logininfor` VALUES (208, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 22:58:50');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 22:58:53');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:00:04');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:00:06');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:00:11');
INSERT INTO `sys_logininfor` VALUES (213, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:00:15');
INSERT INTO `sys_logininfor` VALUES (214, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:02:06');
INSERT INTO `sys_logininfor` VALUES (215, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:02:09');
INSERT INTO `sys_logininfor` VALUES (216, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:02:12');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:02:15');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:02:19');
INSERT INTO `sys_logininfor` VALUES (219, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:02:23');
INSERT INTO `sys_logininfor` VALUES (220, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:02:42');
INSERT INTO `sys_logininfor` VALUES (221, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:02:45');
INSERT INTO `sys_logininfor` VALUES (222, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:02:49');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:02:51');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:02:55');
INSERT INTO `sys_logininfor` VALUES (225, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:02:59');
INSERT INTO `sys_logininfor` VALUES (226, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-24 23:03:43');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-24 23:03:46');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-25 23:50:10');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 11:09:58');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 12:09:47');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-28 12:22:23');
INSERT INTO `sys_logininfor` VALUES (232, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 12:22:26');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 14:37:08');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 15:25:46');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 17:41:23');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 18:23:04');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 18:24:46');
INSERT INTO `sys_logininfor` VALUES (238, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 18:48:02');
INSERT INTO `sys_logininfor` VALUES (239, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 18:50:21');
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 19:03:33');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 20:43:26');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 21:53:46');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 22:00:35');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-28 22:19:38');
INSERT INTO `sys_logininfor` VALUES (245, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 00:26:48');
INSERT INTO `sys_logininfor` VALUES (246, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 00:49:03');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:00:51');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:21:08');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:22:07');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:27:19');
INSERT INTO `sys_logininfor` VALUES (251, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:30:57');
INSERT INTO `sys_logininfor` VALUES (252, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:33:41');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:37:22');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:39:23');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-29 01:56:43');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 01:56:45');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 11:37:35');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 12:48:08');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 12:53:52');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 13:26:30');
INSERT INTO `sys_logininfor` VALUES (261, 'landlord2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '注册成功', '2024-01-29 13:52:15');
INSERT INTO `sys_logininfor` VALUES (262, 'landlord2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 13:53:24');
INSERT INTO `sys_logininfor` VALUES (263, 'landlord2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-29 13:53:34');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 13:53:40');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 13:56:26');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:18:27');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:25:33');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:30:35');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:31:37');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-29 14:37:47');
INSERT INTO `sys_logininfor` VALUES (271, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:37:51');
INSERT INTO `sys_logininfor` VALUES (272, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-29 14:39:33');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:39:43');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:49:41');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 14:58:29');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 15:01:42');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 15:20:55');
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 15:27:37');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-29 15:28:07');
INSERT INTO `sys_logininfor` VALUES (280, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 15:28:12');
INSERT INTO `sys_logininfor` VALUES (281, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-29 15:30:05');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 15:30:10');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 16:24:19');
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 16:59:07');
INSERT INTO `sys_logininfor` VALUES (285, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 17:11:17');
INSERT INTO `sys_logininfor` VALUES (286, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-29 19:41:47');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 12:28:09');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 12:35:19');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 13:45:00');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 13:53:25');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 14:10:53');
INSERT INTO `sys_logininfor` VALUES (292, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 14:13:31');
INSERT INTO `sys_logininfor` VALUES (293, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 14:13:37');
INSERT INTO `sys_logininfor` VALUES (294, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 14:16:37');
INSERT INTO `sys_logininfor` VALUES (295, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 14:17:38');
INSERT INTO `sys_logininfor` VALUES (296, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 14:17:47');
INSERT INTO `sys_logininfor` VALUES (297, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 15:11:10');
INSERT INTO `sys_logininfor` VALUES (298, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 15:11:14');
INSERT INTO `sys_logininfor` VALUES (299, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 15:11:18');
INSERT INTO `sys_logininfor` VALUES (300, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 15:12:54');
INSERT INTO `sys_logininfor` VALUES (301, 'tenant2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '注册成功', '2024-01-31 15:32:26');
INSERT INTO `sys_logininfor` VALUES (302, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 15:32:39');
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 15:35:07');
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 15:42:12');
INSERT INTO `sys_logininfor` VALUES (305, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 15:42:17');
INSERT INTO `sys_logininfor` VALUES (306, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 18:47:08');
INSERT INTO `sys_logininfor` VALUES (307, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:31:48');
INSERT INTO `sys_logininfor` VALUES (308, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:31:53');
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:33:04');
INSERT INTO `sys_logininfor` VALUES (310, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:33:07');
INSERT INTO `sys_logininfor` VALUES (311, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:33:49');
INSERT INTO `sys_logininfor` VALUES (312, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:33:51');
INSERT INTO `sys_logininfor` VALUES (313, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:33:57');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:34:02');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:34:36');
INSERT INTO `sys_logininfor` VALUES (316, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:34:40');
INSERT INTO `sys_logininfor` VALUES (317, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:34:56');
INSERT INTO `sys_logininfor` VALUES (318, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:35:00');
INSERT INTO `sys_logininfor` VALUES (319, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:35:20');
INSERT INTO `sys_logininfor` VALUES (320, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:35:24');
INSERT INTO `sys_logininfor` VALUES (321, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 19:36:09');
INSERT INTO `sys_logininfor` VALUES (322, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 19:36:12');
INSERT INTO `sys_logininfor` VALUES (323, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 20:45:48');
INSERT INTO `sys_logininfor` VALUES (324, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 23:06:46');
INSERT INTO `sys_logininfor` VALUES (325, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-01-31 23:18:10');
INSERT INTO `sys_logininfor` VALUES (326, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 23:18:17');
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-01-31 23:19:32');
INSERT INTO `sys_logininfor` VALUES (328, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 00:39:10');
INSERT INTO `sys_logininfor` VALUES (329, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 01:22:03');
INSERT INTO `sys_logininfor` VALUES (330, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 01:22:22');
INSERT INTO `sys_logininfor` VALUES (331, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 01:22:32');
INSERT INTO `sys_logininfor` VALUES (332, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 01:59:29');
INSERT INTO `sys_logininfor` VALUES (333, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 02:07:41');
INSERT INTO `sys_logininfor` VALUES (334, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 02:07:45');
INSERT INTO `sys_logininfor` VALUES (335, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 02:10:44');
INSERT INTO `sys_logininfor` VALUES (336, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 02:41:16');
INSERT INTO `sys_logininfor` VALUES (337, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 02:41:20');
INSERT INTO `sys_logininfor` VALUES (338, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 02:46:29');
INSERT INTO `sys_logininfor` VALUES (339, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 02:46:36');
INSERT INTO `sys_logininfor` VALUES (340, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 02:48:06');
INSERT INTO `sys_logininfor` VALUES (341, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 02:48:10');
INSERT INTO `sys_logininfor` VALUES (342, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 02:48:12');
INSERT INTO `sys_logininfor` VALUES (343, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 02:48:29');
INSERT INTO `sys_logininfor` VALUES (344, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 02:48:33');
INSERT INTO `sys_logininfor` VALUES (345, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 04:30:02');
INSERT INTO `sys_logininfor` VALUES (346, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 12:16:33');
INSERT INTO `sys_logininfor` VALUES (347, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 12:20:22');
INSERT INTO `sys_logininfor` VALUES (348, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 12:20:27');
INSERT INTO `sys_logininfor` VALUES (349, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 12:33:15');
INSERT INTO `sys_logininfor` VALUES (350, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 12:33:20');
INSERT INTO `sys_logininfor` VALUES (351, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 14:15:02');
INSERT INTO `sys_logininfor` VALUES (352, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 14:17:18');
INSERT INTO `sys_logininfor` VALUES (353, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 14:18:13');
INSERT INTO `sys_logininfor` VALUES (354, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 14:26:05');
INSERT INTO `sys_logininfor` VALUES (355, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 14:32:47');
INSERT INTO `sys_logininfor` VALUES (356, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 14:37:21');
INSERT INTO `sys_logininfor` VALUES (357, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 14:37:26');
INSERT INTO `sys_logininfor` VALUES (358, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 15:27:00');
INSERT INTO `sys_logininfor` VALUES (359, 'landlord2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 15:59:02');
INSERT INTO `sys_logininfor` VALUES (360, 'landlord2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 15:59:55');
INSERT INTO `sys_logininfor` VALUES (361, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:00:01');
INSERT INTO `sys_logininfor` VALUES (362, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:03:36');
INSERT INTO `sys_logininfor` VALUES (363, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 16:03:59');
INSERT INTO `sys_logininfor` VALUES (364, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:04:04');
INSERT INTO `sys_logininfor` VALUES (365, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 16:07:29');
INSERT INTO `sys_logininfor` VALUES (366, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:07:37');
INSERT INTO `sys_logininfor` VALUES (367, 'landlord1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 16:07:43');
INSERT INTO `sys_logininfor` VALUES (368, 'landlord2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:07:47');
INSERT INTO `sys_logininfor` VALUES (369, 'landlord2', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 16:09:00');
INSERT INTO `sys_logininfor` VALUES (370, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:09:06');
INSERT INTO `sys_logininfor` VALUES (371, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:18:25');
INSERT INTO `sys_logininfor` VALUES (372, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:47:37');
INSERT INTO `sys_logininfor` VALUES (373, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 16:58:00');
INSERT INTO `sys_logininfor` VALUES (374, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 17:03:54');
INSERT INTO `sys_logininfor` VALUES (375, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 17:15:36');
INSERT INTO `sys_logininfor` VALUES (376, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 17:15:39');
INSERT INTO `sys_logininfor` VALUES (377, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 17:15:46');
INSERT INTO `sys_logininfor` VALUES (378, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 17:15:49');
INSERT INTO `sys_logininfor` VALUES (379, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-01 17:21:16');
INSERT INTO `sys_logininfor` VALUES (380, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 17:21:22');
INSERT INTO `sys_logininfor` VALUES (381, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 18:19:15');
INSERT INTO `sys_logininfor` VALUES (382, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 18:23:42');
INSERT INTO `sys_logininfor` VALUES (383, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 18:35:46');
INSERT INTO `sys_logininfor` VALUES (384, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-01 23:37:53');
INSERT INTO `sys_logininfor` VALUES (385, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 11:54:29');
INSERT INTO `sys_logininfor` VALUES (386, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 14:56:45');
INSERT INTO `sys_logininfor` VALUES (387, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 15:16:59');
INSERT INTO `sys_logininfor` VALUES (388, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 15:41:14');
INSERT INTO `sys_logininfor` VALUES (389, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 18:24:18');
INSERT INTO `sys_logininfor` VALUES (390, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 18:37:42');
INSERT INTO `sys_logininfor` VALUES (391, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 19:52:47');
INSERT INTO `sys_logininfor` VALUES (392, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-02 22:19:20');
INSERT INTO `sys_logininfor` VALUES (393, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 21:20:35');
INSERT INTO `sys_logininfor` VALUES (394, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 21:27:02');
INSERT INTO `sys_logininfor` VALUES (395, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 21:32:47');
INSERT INTO `sys_logininfor` VALUES (396, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 21:49:56');
INSERT INTO `sys_logininfor` VALUES (397, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 22:03:53');
INSERT INTO `sys_logininfor` VALUES (398, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 22:05:57');
INSERT INTO `sys_logininfor` VALUES (399, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 22:41:04');
INSERT INTO `sys_logininfor` VALUES (400, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 22:55:51');
INSERT INTO `sys_logininfor` VALUES (401, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-03 23:31:40');
INSERT INTO `sys_logininfor` VALUES (402, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 00:34:08');
INSERT INTO `sys_logininfor` VALUES (403, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 11:35:19');
INSERT INTO `sys_logininfor` VALUES (404, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 13:44:44');
INSERT INTO `sys_logininfor` VALUES (405, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 15:21:06');
INSERT INTO `sys_logininfor` VALUES (406, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 15:26:50');
INSERT INTO `sys_logininfor` VALUES (407, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 16:25:21');
INSERT INTO `sys_logininfor` VALUES (408, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 16:29:26');
INSERT INTO `sys_logininfor` VALUES (409, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 16:46:44');
INSERT INTO `sys_logininfor` VALUES (410, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-04 19:27:21');
INSERT INTO `sys_logininfor` VALUES (411, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 19:27:25');
INSERT INTO `sys_logininfor` VALUES (412, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 19:51:38');
INSERT INTO `sys_logininfor` VALUES (413, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 19:53:50');
INSERT INTO `sys_logininfor` VALUES (414, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 19:55:14');
INSERT INTO `sys_logininfor` VALUES (415, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 19:56:08');
INSERT INTO `sys_logininfor` VALUES (416, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 20:10:02');
INSERT INTO `sys_logininfor` VALUES (417, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-04 20:26:47');
INSERT INTO `sys_logininfor` VALUES (418, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 20:32:02');
INSERT INTO `sys_logininfor` VALUES (419, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 20:47:08');
INSERT INTO `sys_logininfor` VALUES (420, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 20:54:01');
INSERT INTO `sys_logininfor` VALUES (421, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 20:57:31');
INSERT INTO `sys_logininfor` VALUES (422, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 21:27:45');
INSERT INTO `sys_logininfor` VALUES (423, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 21:36:55');
INSERT INTO `sys_logininfor` VALUES (424, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 21:39:04');
INSERT INTO `sys_logininfor` VALUES (425, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-04 21:54:38');
INSERT INTO `sys_logininfor` VALUES (426, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 21:54:43');
INSERT INTO `sys_logininfor` VALUES (427, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 23:16:08');
INSERT INTO `sys_logininfor` VALUES (428, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-04 23:22:09');
INSERT INTO `sys_logininfor` VALUES (429, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 00:17:32');
INSERT INTO `sys_logininfor` VALUES (430, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 01:28:48');
INSERT INTO `sys_logininfor` VALUES (431, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 01:31:11');
INSERT INTO `sys_logininfor` VALUES (432, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 01:34:13');
INSERT INTO `sys_logininfor` VALUES (433, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 02:11:39');
INSERT INTO `sys_logininfor` VALUES (434, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 02:46:24');
INSERT INTO `sys_logininfor` VALUES (435, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 02:46:28');
INSERT INTO `sys_logininfor` VALUES (436, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 02:52:13');
INSERT INTO `sys_logininfor` VALUES (437, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 02:52:17');
INSERT INTO `sys_logininfor` VALUES (438, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 03:16:04');
INSERT INTO `sys_logininfor` VALUES (439, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 03:22:01');
INSERT INTO `sys_logininfor` VALUES (440, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 03:27:58');
INSERT INTO `sys_logininfor` VALUES (441, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 03:32:19');
INSERT INTO `sys_logininfor` VALUES (442, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 03:44:22');
INSERT INTO `sys_logininfor` VALUES (443, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 03:44:26');
INSERT INTO `sys_logininfor` VALUES (444, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 03:57:32');
INSERT INTO `sys_logininfor` VALUES (445, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 03:58:18');
INSERT INTO `sys_logininfor` VALUES (446, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 04:27:48');
INSERT INTO `sys_logininfor` VALUES (447, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 04:36:07');
INSERT INTO `sys_logininfor` VALUES (448, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 04:37:36');
INSERT INTO `sys_logininfor` VALUES (449, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 04:42:43');
INSERT INTO `sys_logininfor` VALUES (450, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 04:48:32');
INSERT INTO `sys_logininfor` VALUES (451, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:15:02');
INSERT INTO `sys_logininfor` VALUES (452, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:18:22');
INSERT INTO `sys_logininfor` VALUES (453, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 05:23:37');
INSERT INTO `sys_logininfor` VALUES (454, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:23:45');
INSERT INTO `sys_logininfor` VALUES (455, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 05:23:52');
INSERT INTO `sys_logininfor` VALUES (456, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:23:57');
INSERT INTO `sys_logininfor` VALUES (457, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:32:34');
INSERT INTO `sys_logininfor` VALUES (458, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:34:23');
INSERT INTO `sys_logininfor` VALUES (459, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:35:21');
INSERT INTO `sys_logininfor` VALUES (460, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 05:37:45');
INSERT INTO `sys_logininfor` VALUES (461, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:37:49');
INSERT INTO `sys_logininfor` VALUES (462, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 05:50:48');
INSERT INTO `sys_logininfor` VALUES (463, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 06:53:15');
INSERT INTO `sys_logininfor` VALUES (464, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:14:02');
INSERT INTO `sys_logininfor` VALUES (465, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 07:26:16');
INSERT INTO `sys_logininfor` VALUES (466, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:26:19');
INSERT INTO `sys_logininfor` VALUES (467, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 07:29:05');
INSERT INTO `sys_logininfor` VALUES (468, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:29:10');
INSERT INTO `sys_logininfor` VALUES (469, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:31:54');
INSERT INTO `sys_logininfor` VALUES (470, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 07:35:02');
INSERT INTO `sys_logininfor` VALUES (471, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:35:06');
INSERT INTO `sys_logininfor` VALUES (472, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:39:09');
INSERT INTO `sys_logininfor` VALUES (473, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:41:53');
INSERT INTO `sys_logininfor` VALUES (474, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:49:44');
INSERT INTO `sys_logininfor` VALUES (475, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 07:55:32');
INSERT INTO `sys_logininfor` VALUES (476, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:55:38');
INSERT INTO `sys_logininfor` VALUES (477, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 07:56:55');
INSERT INTO `sys_logininfor` VALUES (478, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:56:58');
INSERT INTO `sys_logininfor` VALUES (479, 'tenant1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-02-05 07:59:40');
INSERT INTO `sys_logininfor` VALUES (480, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 07:59:44');
INSERT INTO `sys_logininfor` VALUES (481, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 08:27:42');
INSERT INTO `sys_logininfor` VALUES (482, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 09:31:29');
INSERT INTO `sys_logininfor` VALUES (483, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 09:44:54');
INSERT INTO `sys_logininfor` VALUES (484, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-02-05 10:01:15');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2049 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 8, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2024-01-11 16:13:55', 'admin', '2024-02-05 06:59:33', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 9, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2024-01-11 16:13:55', 'admin', '2024-01-29 11:47:32', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 13, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2024-01-11 16:13:55', 'admin', '2024-01-29 11:47:37', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2024-01-11 16:13:55', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2024-01-11 16:13:55', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2024-01-11 16:13:55', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2024-01-11 16:13:55', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2024-01-11 16:13:55', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2024-01-11 16:13:55', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2024-01-11 16:13:55', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2024-01-11 16:13:55', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2024-01-11 16:13:55', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2024-01-11 16:13:55', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2024-01-11 16:13:55', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2024-01-11 16:13:55', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2024-01-11 16:13:55', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2024-01-11 16:13:55', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2024-01-11 16:13:55', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2024-01-11 16:13:55', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2024-01-11 16:13:55', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2024-01-11 16:13:55', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2024-01-11 16:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '房源列表', 2008, 1, 'house', 'house/index', NULL, 1, 0, 'C', '0', '0', 'system:house:list', 'list', 'admin', '2024-01-28 11:07:43', 'admin', '2024-01-29 12:25:07', '【请填写功能名称】菜单');
INSERT INTO `sys_menu` VALUES (2003, '房源查询', 2002, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:house:query', '#', 'admin', '2024-01-28 11:07:43', 'admin', '2024-01-28 11:33:37', '');
INSERT INTO `sys_menu` VALUES (2004, '房源新增', 2002, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:house:add', '#', 'admin', '2024-01-28 11:07:43', 'admin', '2024-01-28 11:33:43', '');
INSERT INTO `sys_menu` VALUES (2005, '房源修改', 2002, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:house:edit', '#', 'admin', '2024-01-28 11:07:43', 'admin', '2024-01-28 11:33:49', '');
INSERT INTO `sys_menu` VALUES (2006, '房源删除', 2002, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:house:remove', '#', 'admin', '2024-01-28 11:07:43', 'admin', '2024-01-28 11:33:58', '');
INSERT INTO `sys_menu` VALUES (2007, '房源导出', 2002, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:house:export', '#', 'admin', '2024-01-28 11:07:43', 'admin', '2024-01-28 11:34:05', '');
INSERT INTO `sys_menu` VALUES (2008, '房源管理', 0, 1, 'house', NULL, NULL, 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2024-01-28 11:32:24', 'admin', '2024-01-29 12:24:59', '');
INSERT INTO `sys_menu` VALUES (2009, '评价管理', 0, 4, 'comment', NULL, NULL, 1, 0, 'M', '0', '0', '', 'form', 'admin', '2024-01-29 11:47:10', 'admin', '2024-02-04 21:55:56', '');
INSERT INTO `sys_menu` VALUES (2010, '房源评价', 2009, 1, 'comment/house', 'comment/house', NULL, 1, 0, 'C', '0', '0', 'system:comment:list', 'log', 'admin', '2024-01-29 11:48:25', 'admin', '2024-01-29 12:26:05', '评论菜单');
INSERT INTO `sys_menu` VALUES (2011, '评价查询', 2010, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:query', '#', 'admin', '2024-01-29 11:48:25', 'admin', '2024-01-29 11:50:12', '');
INSERT INTO `sys_menu` VALUES (2012, '评价新增', 2010, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:add', '#', 'admin', '2024-01-29 11:48:25', 'admin', '2024-01-29 11:50:22', '');
INSERT INTO `sys_menu` VALUES (2013, '评价修改', 2010, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:edit', '#', 'admin', '2024-01-29 11:48:25', 'admin', '2024-01-29 11:50:29', '');
INSERT INTO `sys_menu` VALUES (2014, '评价删除', 2010, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:remove', '#', 'admin', '2024-01-29 11:48:25', 'admin', '2024-01-29 11:50:34', '');
INSERT INTO `sys_menu` VALUES (2015, '评价导出', 2010, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:export', '#', 'admin', '2024-01-29 11:48:25', 'admin', '2024-01-29 11:50:40', '');
INSERT INTO `sys_menu` VALUES (2016, '特色服务评价', 2009, 1, 'comment/service', 'comment/service', NULL, 1, 0, 'C', '0', '0', 'system:comment:list', 'logininfor', 'admin', '2024-01-29 11:51:36', 'admin', '2024-01-29 12:26:13', '评价菜单');
INSERT INTO `sys_menu` VALUES (2017, '评价查询', 2016, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:query', '#', 'admin', '2024-01-29 11:51:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '评价新增', 2016, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:add', '#', 'admin', '2024-01-29 11:51:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '评价修改', 2016, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:edit', '#', 'admin', '2024-01-29 11:51:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '评价删除', 2016, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:remove', '#', 'admin', '2024-01-29 11:51:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '评价导出', 2016, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:comment:export', '#', 'admin', '2024-01-29 11:51:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '特色服务管理', 0, 2, 'service', NULL, NULL, 1, 0, 'M', '0', '0', '', 'component', 'admin', '2024-01-29 13:37:29', 'admin', '2024-01-29 15:45:03', '');
INSERT INTO `sys_menu` VALUES (2023, '服务列表', 2022, 1, 'service', 'service/index', NULL, 1, 0, 'C', '0', '0', 'system:service:list', 'list', 'admin', '2024-01-29 13:42:00', 'admin', '2024-01-29 14:50:51', '特色服务菜单');
INSERT INTO `sys_menu` VALUES (2024, '特色服务查询', 2023, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:service:query', '#', 'admin', '2024-01-29 13:42:00', 'admin', '2024-01-31 19:35:41', '');
INSERT INTO `sys_menu` VALUES (2025, '特色服务新增', 2023, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:service:add', '#', 'admin', '2024-01-29 13:42:00', 'admin', '2024-01-31 19:35:47', '');
INSERT INTO `sys_menu` VALUES (2026, '特色服务修改', 2023, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:service:edit', '#', 'admin', '2024-01-29 13:42:00', 'admin', '2024-01-31 19:35:53', '');
INSERT INTO `sys_menu` VALUES (2027, '特色服务删除', 2023, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:service:remove', '#', 'admin', '2024-01-29 13:42:00', 'admin', '2024-01-31 19:35:59', '');
INSERT INTO `sys_menu` VALUES (2028, '特色服务导出', 2023, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:service:export', '#', 'admin', '2024-01-29 13:42:00', 'admin', '2024-01-31 19:36:05', '');
INSERT INTO `sys_menu` VALUES (2029, '合同管理', 0, 5, 'contract', NULL, NULL, 1, 0, 'M', '0', '0', '', 'excel', 'admin', '2024-01-29 15:45:45', 'admin', '2024-02-05 06:59:41', '');
INSERT INTO `sys_menu` VALUES (2030, '合同列表', 2029, 1, 'contract', 'contract/index', NULL, 1, 0, 'C', '0', '0', 'system:contract:list', 'list', 'admin', '2024-01-29 17:02:49', 'admin', '2024-01-29 17:39:22', '合同菜单');
INSERT INTO `sys_menu` VALUES (2031, '合同查询', 2030, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:contract:query', '#', 'admin', '2024-01-29 17:02:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '合同新增', 2030, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:contract:add', '#', 'admin', '2024-01-29 17:02:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '合同修改', 2030, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:contract:edit', '#', 'admin', '2024-01-29 17:02:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '合同删除', 2030, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:contract:remove', '#', 'admin', '2024-01-29 17:02:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '合同导出', 2030, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:contract:export', '#', 'admin', '2024-01-29 17:02:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '订单管理', 0, 3, 'order', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'shopping', 'admin', '2024-02-04 21:55:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '订单列表', 2042, 1, 'order', 'order/index', NULL, 1, 0, 'C', '0', '0', 'system:order:list', 'list', 'admin', '2024-02-04 21:57:09', 'admin', '2024-02-04 21:58:16', '主订单菜单');
INSERT INTO `sys_menu` VALUES (2044, '主订单查询', 2043, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:order:query', '#', 'admin', '2024-02-04 21:57:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '主订单新增', 2043, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:order:add', '#', 'admin', '2024-02-04 21:57:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '主订单修改', 2043, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:order:edit', '#', 'admin', '2024-02-04 21:57:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '主订单删除', 2043, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:order:remove', '#', 'admin', '2024-02-04 21:57:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '主订单导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:order:export', '#', 'admin', '2024-02-04 21:57:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '子订单修改', 2043, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:item:edit', '#', 'admin', '2024-02-05 03:38:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2050, '子订单删除', 2043, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:item:remove', '#', 'admin', '2024-02-05 03:38:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '报修管理', 0, 6, 'repair', NULL, NULL, 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2024-02-05 06:56:52', 'admin', '2024-02-05 06:59:46', '');
INSERT INTO `sys_menu` VALUES (2052, '报修列表', 2051, 1, 'repair', 'repair/index', NULL, 1, 0, 'C', '0', '0', 'system:repair:list', 'list', 'admin', '2024-02-05 06:58:28', 'admin', '2024-02-05 06:59:08', '报修菜单');
INSERT INTO `sys_menu` VALUES (2053, '报修查询', 2052, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:repair:query', '#', 'admin', '2024-02-05 06:58:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '报修新增', 2052, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:repair:add', '#', 'admin', '2024-02-05 06:58:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '报修修改', 2052, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:repair:edit', '#', 'admin', '2024-02-05 06:58:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2056, '报修删除', 2052, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:repair:remove', '#', 'admin', '2024-02-05 06:58:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '报修导出', 2052, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:repair:export', '#', 'admin', '2024-02-05 06:58:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '财务管理', 0, 7, 'finance', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'chart', 'admin', '2024-02-05 08:01:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '盈利情况', 2058, 1, 'finance', 'finance/index', NULL, 1, 0, 'C', '0', '0', 'system:finance:list', 'money', 'admin', '2024-02-05 08:04:51', 'admin', '2024-02-05 08:33:39', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 355 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order`  (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房源ID',
  `landlord_user_id` bigint NULL DEFAULT NULL COMMENT '房东ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '房客ID',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总金额',
  `arrival_date` date NULL DEFAULT NULL COMMENT '入住日期',
  `departure_date` date NULL DEFAULT NULL COMMENT '离开日期',
  `tenant_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入住房客信息，json字符串，例[{\"name\":\"xx\",\"idcard\":\"35023023\"}]',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '订单状态，0-待使用，1-进行中，2-已完成，3-退款中，4-已退款',
  `del_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '主订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_order
-- ----------------------------
INSERT INTO `sys_order` VALUES (3, 2, 104, 102, 800.00, '2024-02-04', '2024-02-05', '[{\"id\":1707027059644,\"name\":\"测试\",\"idcard\":\"350205199709080012\"}]', 1, 0, '', '2024-02-04 16:44:13', '', '2024-02-05 03:28:08');
INSERT INTO `sys_order` VALUES (4, 2, 104, 102, 500.00, '2024-02-04', '2024-02-05', '[{\"id\":1707035497477,\"name\":\"测试说试试\",\"idcard\":\"350205199609080012\"}]', 2, 0, '', '2024-02-04 16:44:24', '', '2024-02-05 02:46:07');

-- ----------------------------
-- Table structure for sys_order_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_order_item`;
CREATE TABLE `sys_order_item`  (
  `order_item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '子订单ID',
  `order_id` bigint NULL DEFAULT NULL COMMENT '主订单ID',
  `landlord_user_id` bigint NULL DEFAULT NULL COMMENT '房东用户ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '房客用户ID',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '子订单产品类型，1-房屋，2-特色服务',
  `product_id` bigint NULL DEFAULT NULL COMMENT '子订单产品ID，type=1时为房屋ID，type=2时为服务ID',
  `num` int NULL DEFAULT NULL COMMENT '产品数量，type=1时为入住天数，type=2时为服务数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '产品单价，type=1时为房屋单天价格，type=2时为服务单价',
  `total` decimal(10, 0) NULL DEFAULT NULL COMMENT '子订单总价',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态，0-待使用，1-进行中，2-待评价，3-已完成，4-退款中，5-已退款',
  `del_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_item_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '子订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_order_item
-- ----------------------------
INSERT INTO `sys_order_item` VALUES (1, 3, 104, 102, 2, 2, 1, 300.00, 300, 1, 0, '', '2024-02-04 16:44:29', '', '2024-02-05 04:48:59');
INSERT INTO `sys_order_item` VALUES (2, 3, 104, 102, 1, 2, 1, 500.00, 500, 1, 0, '', '2024-02-04 16:44:31', '', NULL);
INSERT INTO `sys_order_item` VALUES (3, 4, 104, 102, 1, 2, 1, 500.00, 500, 3, 0, '', '2024-02-04 16:44:34', '', '2024-02-05 05:35:38');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'developer', '研发', 1, '0', 'admin', '2024-01-11 16:13:55', 'admin', '2024-01-11 18:39:15', '');
INSERT INTO `sys_post` VALUES (6, 'operator', '平台运营', 2, '0', 'admin', '2024-01-31 15:19:54', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_repair
-- ----------------------------
DROP TABLE IF EXISTS `sys_repair`;
CREATE TABLE `sys_repair`  (
  `repair_id` bigint NOT NULL AUTO_INCREMENT COMMENT '报修ID',
  `landlord_user_id` bigint NULL DEFAULT NULL COMMENT '房东用户ID',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房源ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '房客用户ID',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报修描述',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '报修状态，0-未维修，1-已维修',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`repair_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报修' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_repair
-- ----------------------------
INSERT INTO `sys_repair` VALUES (1, 104, 2, 102, '水龙头坏了', 1, 0, '', '2024-02-05 07:53:49', '', '2024-02-05 07:56:28');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '平台管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '房客', 'tenant', 2, '2', 1, 1, '0', '0', 'admin', '2024-01-11 16:13:55', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (3, '房东', 'landlord', 3, '4', 1, 1, '0', '0', 'admin', '2024-01-11 18:18:02', 'admin', '2024-02-05 06:58:41', '普通角色');
INSERT INTO `sys_role` VALUES (102, '平台运营', 'operator', 4, '1', 1, 1, '0', '2', 'admin', '2024-01-31 15:23:45', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (3, 2002);
INSERT INTO `sys_role_menu` VALUES (3, 2003);
INSERT INTO `sys_role_menu` VALUES (3, 2004);
INSERT INTO `sys_role_menu` VALUES (3, 2005);
INSERT INTO `sys_role_menu` VALUES (3, 2006);
INSERT INTO `sys_role_menu` VALUES (3, 2007);
INSERT INTO `sys_role_menu` VALUES (3, 2008);
INSERT INTO `sys_role_menu` VALUES (3, 2009);
INSERT INTO `sys_role_menu` VALUES (3, 2010);
INSERT INTO `sys_role_menu` VALUES (3, 2011);
INSERT INTO `sys_role_menu` VALUES (3, 2012);
INSERT INTO `sys_role_menu` VALUES (3, 2013);
INSERT INTO `sys_role_menu` VALUES (3, 2014);
INSERT INTO `sys_role_menu` VALUES (3, 2015);
INSERT INTO `sys_role_menu` VALUES (3, 2016);
INSERT INTO `sys_role_menu` VALUES (3, 2017);
INSERT INTO `sys_role_menu` VALUES (3, 2018);
INSERT INTO `sys_role_menu` VALUES (3, 2019);
INSERT INTO `sys_role_menu` VALUES (3, 2020);
INSERT INTO `sys_role_menu` VALUES (3, 2021);
INSERT INTO `sys_role_menu` VALUES (3, 2022);
INSERT INTO `sys_role_menu` VALUES (3, 2023);
INSERT INTO `sys_role_menu` VALUES (3, 2024);
INSERT INTO `sys_role_menu` VALUES (3, 2025);
INSERT INTO `sys_role_menu` VALUES (3, 2026);
INSERT INTO `sys_role_menu` VALUES (3, 2027);
INSERT INTO `sys_role_menu` VALUES (3, 2028);
INSERT INTO `sys_role_menu` VALUES (3, 2029);
INSERT INTO `sys_role_menu` VALUES (3, 2030);
INSERT INTO `sys_role_menu` VALUES (3, 2031);
INSERT INTO `sys_role_menu` VALUES (3, 2032);
INSERT INTO `sys_role_menu` VALUES (3, 2033);
INSERT INTO `sys_role_menu` VALUES (3, 2034);
INSERT INTO `sys_role_menu` VALUES (3, 2035);
INSERT INTO `sys_role_menu` VALUES (3, 2042);
INSERT INTO `sys_role_menu` VALUES (3, 2043);
INSERT INTO `sys_role_menu` VALUES (3, 2044);
INSERT INTO `sys_role_menu` VALUES (3, 2045);
INSERT INTO `sys_role_menu` VALUES (3, 2046);
INSERT INTO `sys_role_menu` VALUES (3, 2047);
INSERT INTO `sys_role_menu` VALUES (3, 2048);
INSERT INTO `sys_role_menu` VALUES (3, 2049);
INSERT INTO `sys_role_menu` VALUES (3, 2050);
INSERT INTO `sys_role_menu` VALUES (3, 2051);
INSERT INTO `sys_role_menu` VALUES (3, 2052);
INSERT INTO `sys_role_menu` VALUES (3, 2053);
INSERT INTO `sys_role_menu` VALUES (3, 2054);
INSERT INTO `sys_role_menu` VALUES (3, 2055);
INSERT INTO `sys_role_menu` VALUES (3, 2056);
INSERT INTO `sys_role_menu` VALUES (3, 2057);

-- ----------------------------
-- Table structure for sys_service
-- ----------------------------
DROP TABLE IF EXISTS `sys_service`;
CREATE TABLE `sys_service`  (
  `service_id` bigint NOT NULL AUTO_INCREMENT COMMENT '特色服务ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '房东用户ID',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房源ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务描述',
  `cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '成本',
  `remain` bigint NULL DEFAULT NULL COMMENT '剩余数量',
  `del_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_service
-- ----------------------------
INSERT INTO `sys_service` VALUES (1, 103, 1, '早餐', 20.00, '提供当地特色早餐', 10.00, 10000, 0, '', '2024-01-29 15:11:50', '', NULL);
INSERT INTO `sys_service` VALUES (2, 104, 2, '车辆租赁', 300.00, '提供按天收费的车辆租赁', 20.00, 5, 0, '', '2024-01-29 15:34:15', '', NULL);
INSERT INTO `sys_service` VALUES (3, 103, 1, '接送', 50.00, '提供专车从动车站、机场等地方接送', 10.00, 1000, 0, '', '2024-01-31 19:37:20', '', NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `id_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '平台管理员', '00', NULL, 'test@163.com', '15888888888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2024-02-05 10:01:16', 'admin', '2024-01-11 16:13:55', '', '2024-02-05 10:01:15', '管理员');
INSERT INTO `sys_user` VALUES (102, 105, 'tenant1', '爱生活爱旅游', '00', 'PpINEWVFu9mZdZ9TB+KjSIuVyoOdV5hxMXkBpMaalrY=', '21321313@qq.com', '13023911782', '1', '', '$2a$10$pDKLFv3YqcKvrqavTTgjHO3/L5iB4P/m1FmDOc3i6wH4OLNS/3Noi', '0', '0', '127.0.0.1', '2024-02-05 07:56:59', '', '2024-01-18 21:11:18', '', '2024-02-05 07:56:58', NULL);
INSERT INTO `sys_user` VALUES (103, 104, 'landlord1', '房东1', '00', 'PpINEWVFu9mZdZ9TB+KjSIuVyoOdV5hxMXkBpMaalrY=', '', '13000000000', '0', '', '$2a$10$PbsvdXUfqnalBzE38wYZJ.D9fPixoHy57620dpJRDg8mRmWwMI.6e', '0', '0', '127.0.0.1', '2024-02-01 16:07:37', '', '2024-01-18 23:35:23', '', '2024-02-01 16:07:37', NULL);
INSERT INTO `sys_user` VALUES (104, 104, 'landlord2', '房东2', '00', 'u7+BJT2cKOpZkI4kkjMRtL/4cDSgqVrqDpm9xbF8MEw=', '', '13000232301', '0', '', '$2a$10$dmouDvtbRmFocdxCBOD2JexIHi7jI2RICAKUVFJCl9sXw.dAVmxie', '0', '0', '127.0.0.1', '2024-02-01 16:07:48', '', '2024-01-29 13:52:14', '', '2024-02-01 16:07:47', NULL);
INSERT INTO `sys_user` VALUES (106, 105, 'tenant2', '房客2', '00', 'EkvyixeMvy0FED3w1p+JeYuVyoOdV5hxMXkBpMaalrY=', '', '13053402313', '0', '', '$2a$10$cZ2i011kZM7p8KAXvNe55.0bcJcXN9uAveMUqRpT/IbDqQfK/bN6u', '0', '0', '', NULL, '', '2024-01-31 15:32:26', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (102, 2);
INSERT INTO `sys_user_role` VALUES (103, 3);
INSERT INTO `sys_user_role` VALUES (104, 3);
INSERT INTO `sys_user_role` VALUES (106, 2);

SET FOREIGN_KEY_CHECKS = 1;
