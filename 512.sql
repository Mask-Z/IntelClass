-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.18 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 app_aixuexiao 的数据库结构
CREATE DATABASE IF NOT EXISTS `app_aixuexiao` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `app_aixuexiao`;

-- 导出  表 app_aixuexiao.class 结构
CREATE TABLE IF NOT EXISTS `class` (
  `id` smallint(5) unsigned NOT NULL COMMENT '班级编号，302表示三年级二班',
  `name` char(16) NOT NULL COMMENT '班级名称，三年级二班',
  `headteacher` char(8) NOT NULL COMMENT '班主任姓名',
  `studentcount` tinyint(4) NOT NULL COMMENT '学生数量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.class 的数据：3 rows
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
REPLACE INTO `class` (`id`, `name`, `headteacher`, `studentcount`) VALUES
	(302, '三年级二班', '赖导', 7),
	(301, '三年级一班', '曾近荣', 7),
	(303, '三年三班', '卷西', 4);
/*!40000 ALTER TABLE `class` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.class_news 结构
CREATE TABLE IF NOT EXISTS `class_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '公告编号',
  `classid` int(10) unsigned NOT NULL COMMENT '考试班级',
  `content` varchar(128) NOT NULL,
  `inserttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_class_news` (`classid`,`inserttime`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.class_news 的数据：3 rows
/*!40000 ALTER TABLE `class_news` DISABLE KEYS */;
REPLACE INTO `class_news` (`id`, `classid`, `content`, `inserttime`) VALUES
	(1, 302, '大家好，三年级二班将于本周六举行家长会，届时请各位学生家长准时到达开会，谢谢！', '2013-08-21 10:42:04'),
	(2, 301, '各位学生家长注意了，最近有不少同学出现逃学的情况，还号称“逃学威龙”。', '2013-08-21 10:48:20'),
	(3, 303, '新课堂开课啦', '2017-05-10 15:01:54');
/*!40000 ALTER TABLE `class_news` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.exam 结构
CREATE TABLE IF NOT EXISTS `exam` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '考试编号',
  `classid` int(10) unsigned NOT NULL COMMENT '考试班级',
  `course` char(8) NOT NULL COMMENT '科目',
  `examtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '考试时间',
  `fullmarks` decimal(4,1) NOT NULL COMMENT '满分',
  `average` decimal(4,1) DEFAULT NULL COMMENT '平均分',
  `topmark` decimal(4,1) DEFAULT NULL COMMENT '最高分',
  `lowestmark` decimal(4,1) DEFAULT NULL COMMENT '最低分',
  `remark` varchar(32) NOT NULL COMMENT '考试说明',
  PRIMARY KEY (`id`),
  KEY `index_exams` (`id`),
  KEY `index_classes` (`classid`,`course`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.exam 的数据：4 rows
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
REPLACE INTO `exam` (`id`, `classid`, `course`, `examtime`, `fullmarks`, `average`, `topmark`, `lowestmark`, `remark`) VALUES
	(1, 301, '英语', '2013-08-21 10:56:07', 100.0, 84.1, 100.0, 59.0, '精诚中学三年级二班下学期英语单元测验'),
	(2, 302, '数学', '2013-08-22 11:02:20', 100.0, 88.3, 100.0, 78.0, '数学单元测验'),
	(3, 303, '操作系统', '2017-05-10 15:03:33', 100.0, 67.5, 100.0, 10.0, '必修课'),
	(4, 303, '编译原理', '2017-05-10 15:16:15', 100.0, 35.8, 66.0, 12.0, '人间炼狱');
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.exam_mark 结构
CREATE TABLE IF NOT EXISTS `exam_mark` (
  `classid` int(10) unsigned NOT NULL COMMENT '考试班级',
  `studentid` int(10) unsigned NOT NULL COMMENT '学生编号',
  `studentname` char(8) NOT NULL COMMENT '学生姓名',
  `examid` int(10) unsigned NOT NULL COMMENT '考试编号',
  `mark` decimal(4,1) NOT NULL COMMENT '分数',
  `examtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '考试时间',
  `rank` tinyint(4) DEFAULT NULL COMMENT '班级排名',
  `remark` varchar(32) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`classid`,`studentid`,`examid`),
  KEY `index_exam_mark` (`classid`,`studentid`,`studentname`,`examid`,`mark`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.exam_mark 的数据：22 rows
/*!40000 ALTER TABLE `exam_mark` DISABLE KEYS */;
REPLACE INTO `exam_mark` (`classid`, `studentid`, `studentname`, `examid`, `mark`, `examtime`, `rank`, `remark`) VALUES
	(301, 3011, '周星星', 1, 59.0, '2013-08-21 10:56:07', 7, '逃课就是这个下场'),
	(301, 3013, '大飞', 1, 60.0, '2013-08-21 10:56:07', 6, '这次给你及格了'),
	(301, 3014, '黄小龟', 1, 84.0, '2013-08-21 10:56:07', 5, '好好学习天天向上'),
	(301, 3017, '林大岳', 1, 91.0, '2013-08-21 10:56:07', 4, '继续努力'),
	(301, 3012, '曹达华', 1, 97.0, '2013-08-21 10:56:07', 3, '不错，有进步'),
	(301, 3016, '汤朱迪', 1, 98.0, '2013-08-21 10:56:07', 2, '这次发挥有点小失常哟'),
	(301, 3015, '仙蒂', 1, 100.0, '2013-08-21 10:56:07', 1, '满分不错，值得表扬'),
	(302, 3027, '许博淳', 2, 78.0, '2013-08-22 11:02:20', 7, '要加油了'),
	(302, 3022, '柯景腾', 2, 80.0, '2013-08-22 11:02:20', 6, '上课认真听讲'),
	(302, 3024, '谢明和', 2, 87.0, '2013-08-22 11:02:20', 5, '好好学习天天向上'),
	(302, 3026, '胡家玮', 2, 88.0, '2013-08-22 11:02:20', 4, '继续努力'),
	(302, 3023, '曹国胜', 2, 90.0, '2013-08-22 11:02:20', 3, '有进步'),
	(302, 3025, '廖英宏', 2, 95.0, '2013-08-22 11:02:20', 2, '非常好'),
	(302, 3021, '沈佳宜', 2, 100.0, '2013-08-22 11:02:20', 1, '非常不错，好好保持'),
	(303, 3031, '路飞', 3, 10.0, '2017-05-10 15:03:33', 4, 'terrible'),
	(303, 3032, '索隆', 3, 70.0, '2017-05-10 15:03:33', 3, 'good'),
	(303, 3033, '香吉士', 3, 90.0, '2017-05-10 15:03:33', 2, 'surprise'),
	(303, 3034, '妮可罗宾', 3, 100.0, '2017-05-10 15:03:33', 1, 'best'),
	(303, 3034, '妮可罗宾', 4, 12.0, '2017-05-10 15:16:15', 4, '哈哈'),
	(303, 3032, '索隆', 4, 21.0, '2017-05-10 15:16:15', 3, '呵呵'),
	(303, 3031, '路飞', 4, 44.0, '2017-05-10 15:16:15', 2, '晋级'),
	(303, 3033, '香吉士', 4, 66.0, '2017-05-10 15:16:15', 1, '不错');
/*!40000 ALTER TABLE `exam_mark` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.message 结构
CREATE TABLE IF NOT EXISTS `message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tousername` char(32) NOT NULL,
  `fromusername` char(32) NOT NULL,
  `msgtype` enum('TEXT','IMAGE','LOCATION','LINK','EVENT') NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `msgId` char(64) NOT NULL,
  `content` varchar(128) DEFAULT NULL,
  `picurl` varchar(128) DEFAULT NULL,
  `title` varchar(32) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  `locationx` char(10) DEFAULT NULL,
  `locationy` char(10) DEFAULT NULL,
  `scale` char(8) DEFAULT NULL,
  `label` varchar(32) DEFAULT NULL,
  `event` varchar(16) DEFAULT NULL,
  `eventkey` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user` (`msgtype`,`tousername`,`fromusername`,`createtime`)
) ENGINE=MyISAM AUTO_INCREMENT=154 DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.message 的数据：153 rows
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
REPLACE INTO `message` (`id`, `tousername`, `fromusername`, `msgtype`, `createtime`, `msgId`, `content`, `picurl`, `title`, `description`, `url`, `locationx`, `locationy`, `scale`, `label`, `event`, `eventkey`) VALUES
	(1, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:35', '6418378266896646218', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:35', '6418378391450697812', '3021_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:35', '6418379400768012451', '3021_动态历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:35', '6418379495257292968', '3021_动态', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:35', '6418379843149643955', '3021_考试历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:37', '6418387282033001089', '302_考试成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:37', '6418387539731038855', '3021_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:37', '6418387668580057743', '302_考试历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:37', '6418387715824698001', '302_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:37', '6418388390134563504', '302_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:37', '6418388420199334579', '301_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(12, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:40', '6418401433950242205', '303_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(13, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:46', '6418428917445971562', '303_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(14, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:46', '6418429102129565304', '301_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(15, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:46', '6418429162259107454', '302_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(16, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418442949104128880', '302_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(17, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418443000643736441', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(18, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418443601939157941', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(19, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418444924789085243', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(20, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418445182487123017', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(21, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418445740832871542', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(22, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418446208984306835', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(23, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:06:50', '6418446234754110616', '302_班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:48', '6418694896180687332', 'WW_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(25, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:48', '6418694956310229479', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(26, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:48', '6418695020734738921', ' *_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(27, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:48', '6418695269842842103', '3021_动态', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(28, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:48', '6418695334267351547', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(29, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:49', '6418697039369368178', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(30, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'IMAGE', '1970-01-18 15:07:50', '6418700728746275623', NULL, 'http://mmbiz.qpic.cn/mmbiz_jpg/4icWcdicIsGP4rS4m2BlgBouFJ4mz6Hwrgl0J46yLCsPqNBibLiaBp5BjnuT6zLBY51siafQvRicXq770Jn2CMvqZzYg/0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(31, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:50', '6418701437415879492', '*_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(32, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '1970-01-18 15:07:50', '6418701596329669452', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(33, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 10:54:45', '6418705066663244842', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(34, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 11:14:30', '6418710156199491367', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(35, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 11:16:57', '6418710787559683905', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(36, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 11:18:19', '6418711045257721676', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(37, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 11:18:06', '6418711045257721676', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(38, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 11:18:11', '6418711045257721676', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(39, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 11:22:07', '6418712118999545714', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(40, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 11:26:09', '6418713158381631408', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(41, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:31:21', '6418745422175960825', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(42, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:40:09', '6418747689918693308', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(43, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:40:34', '6418747797292875725', '302_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(44, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:40:39', '6418747818767712207', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(45, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:41:15', '6418747973386534893', '3031__图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(46, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:42:08', '6418748201019801595', '3021__图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(47, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:43:00', '6418748420063133695', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(48, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:43:21', '6418748514552414213', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(49, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:45:11', '6418748986998816787', '3021_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(50, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:46:01', '6418749201747181596', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(51, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:47:10', '6418749498099925042', '3021_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(52, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:50:03', '6418750241129267285', '3031_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(53, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:50:59', '6418750481647435881', '021_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(54, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:54:31', '6418751392180502691', '3031_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(55, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:54:47', '6418751460899979435', '031_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(56, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:59:14', '6418752607656247569', '3031_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(57, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 13:59:22', '6418752642015985941', '31_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(58, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 14:01:24', '6418753166001996086', '31_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(59, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 14:01:36', '6418753166001996086', '31_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(60, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 14:01:36', '6418753166001996086', '31_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(61, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 14:03:16', '6418753647038333281', '31_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(62, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 14:39:16', '6418762924167693131', '31_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(63, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 14:40:03', '6418763121736188754', '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(64, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:32:41', '6418776689537877811', '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(65, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:32:49', '6418776723897616187', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(66, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:33:12', '6418776822681864006', '3021_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(67, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:34:04', '6418777046020163419', '3011_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(68, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:35:24', '6418777389617547143', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(69, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:35:36', '6418777436862187409', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(70, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:35:46', '6418777479811860376', '3011_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(71, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:36:01', '6418777544236369822', '3011_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(72, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:36:22', '6418777638725650343', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(73, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:36:57', '6418777789049505715', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(74, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:37:03', '6418777814819309495', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(75, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:37:47', '6418778003797870552', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(76, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:37:51', '6418778020977739740', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(77, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:38:17', '6418778132646889444', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(78, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:38:36', '6418778214251268071', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(79, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:38:53', '6418778287265712114', '3011_动态', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(80, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:39:03', '6418778330215385079', '3011_11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(81, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:39:11', '6418778360280156153', '3021', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(82, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:49:34', '6418781036044781769', '3021', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(83, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:50:30', '6418781246498179289', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(84, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:50:28', '6418781246498179289', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(85, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:50:47', '6418781246498179289', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(86, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:55:08', '6418782474858826005', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(87, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:55:38', '6418782603707844890', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(88, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:55:46', '6418782638067583262', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(89, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:56:37', '6418782857110915367', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(90, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:59:43', '6418783613025159498', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(91, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:59:43', '6418783613025159498', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(92, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 15:59:44', '6418783613025159498', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(93, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:02:42', '6418784424773978501', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(94, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:02:57', '6418784484903520648', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(95, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:11:34', '6418786709696580108', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(96, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:12:32', '6418786954509716012', '11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(97, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:15:15', '6418787658884352643', 'test1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(98, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:16:04', '6418787865042782874', '3021_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(99, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:16:31', '6418787981006899877', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(100, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:16:46', '6418788049726376624', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(101, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:16:55', '6418788084086115001', '3021_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(102, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:20:04', '6418788895834934020', '3011_考试历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(103, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:20:55', '6418789114878266136', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(104, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:21:57', '6418789381166238515', '3021_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(105, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:23:05', '6418789677518981962', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(106, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:23:21', '6418789746238458710', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(107, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:25:30', '6418790295994272655', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(108, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:25:36', '6418790295994272655', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(109, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:25:43', '6418790295994272655', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(110, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:28:32', '6418791081973287859', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(111, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:28:38', '6418791103448124341', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(112, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:28:48', '6418791146397797304', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(113, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 16:29:03', '6418791215117274049', '3011_考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(114, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 17:56:09', '6418813656321397279', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(115, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 17:56:34', '6418813763695579691', '3011_图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(116, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 17:56:46', '6418813819530154546', '图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(117, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 17:56:53', '6418813849594925622', '考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(118, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 17:58:04', '6418814154537603656', 'os_oo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(119, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 17:59:13', '6418814450890347099', '11_aa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(120, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 17:59:43', '6418814579739365989', '11_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(121, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:01:02', '6418814919041782386', '图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(122, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:03:53', '6418815653481190045', '考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(123, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:04:14', '6418815743675503265', '考试历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(124, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:04:35', '6418815833869816492', '留言', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(125, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:04:44', '6418815872524522158', '留言历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(126, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:04:57', '6418815924064129717', '动态', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(127, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:05:10', '6418815984193671865', '动态历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(128, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:05:21', '6418816027143344828', '班级成绩', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(129, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:10:12', '6418817276978828049', '图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(130, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-11 18:10:21', '6418817319928501013', '考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(131, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:29:23', '6419038682542942205', 'nihao ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(132, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:29:42', '6419038764147320833', '动态', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(133, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:29:54', '6419038815686928387', '考试历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(134, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:29:59', '6419038841456732166', '图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(135, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:30:36', '6419038996075554826', '3021_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(136, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:30:56', '6419039086269868047', 'ss_ss', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(137, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:31:05', '6419039120629606417', 'ss_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(138, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:31:31', '6419039232298756117', '11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(139, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:36:20', '6419040473544304682', '考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(140, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:37:05', '6419040671112800303', '3021_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(141, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:37:25', '6419040757012146228', 'help', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(142, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 08:45:02', '6419042719812200538', '图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(143, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 14:52:22', '6419137376596443201', 'nihao ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(144, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 14:52:28', '6419137402366246979', 'tuwen', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(145, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 14:52:32', '6419137419546116168', '图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(146, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:17:49', '6419236702010136548', '你好', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(147, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:17:59', '6419236744959809514', '考试', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(148, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:18:03', '6419236766434645996', '考试历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(149, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:18:10', '6419236792204449776', '图文', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(150, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:18:40', '6419236921053468666', '0010_绑定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(151, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:18:46', '6419236946823272444', '操作', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(152, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:18:58', '6419237002657847298', '留言', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(153, 'gh_1aff82adf8c3', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'TEXT', '2017-05-12 21:19:05', '6419237028427651078', '动态历史', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.reply 结构
CREATE TABLE IF NOT EXISTS `reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tousername` char(32) NOT NULL,
  `fromusername` char(32) NOT NULL,
  `msgtype` enum('TEXT','MUSIC','NEWS') NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `content` varchar(512) NOT NULL COMMENT '回复消息内容',
  `musicurl` varchar(128) DEFAULT NULL,
  `hqmusicurl` varchar(128) DEFAULT NULL,
  `articlecount` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user` (`msgtype`,`tousername`,`fromusername`,`createtime`)
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.reply 的数据：131 rows
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
REPLACE INTO `reply` (`id`, `tousername`, `fromusername`, `msgtype`, `createtime`, `content`, `musicurl`, `hqmusicurl`, `articlecount`) VALUES
	(1, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 13:46:34', '欢迎订阅爱学校，你可以回复指定内容来了解学生考试情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(2, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 13:47:02', '您好，编号为3021的学生(沈佳宜)最近一次考试记录如下:\n科目：数学\n分数：100.0\n班级排名：1\n考试时间：2013-08-22\n老师备注：非常不错，好好保持\n试卷满分：100.0\n班级均分：88.3\n班级最高分：100.0\n班级最低分：78.0\n考试说明：数学单元测验', NULL, NULL, 0),
	(3, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 13:50:58', '您好，编号为3021的学生(沈佳宜)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：大家好，三年级二班将于本周六举行家长会，届时请各位学生家长准时到达开会，谢谢！\n------分割线-------', NULL, NULL, 0),
	(4, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 13:51:20', '您好，编号为3021的学生(沈佳宜)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：大家好，三年级二班将于本周六举行家长会，届时请各位学生家长准时到达开会，谢谢！', NULL, NULL, 0),
	(5, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 13:52:41', '您好，编号为3021的学生(沈佳宜)最近10次考试情况如下:\n考试时间：2013-08-22\n科目：数学\n分数：100.0\n班级排名：1\n老师备注：非常不错，好好保持\n试卷满分：100.0\n班级均分：88.3\n班级最高分：100.0\n班级最低分：78.0\n考试说明：数学单元测验\n------分割线-------', NULL, NULL, 0),
	(6, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 14:21:33', '欢迎订阅爱学校，你可以回复指定内容来了解学生考试情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(7, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 14:22:32', '该班成绩如下:\n', NULL, NULL, 0),
	(8, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 14:23:03', '您好，未找到编号为302的学生！', NULL, NULL, 0),
	(9, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 14:23:13', '该班成绩如下:\n廖英宏非常好\n曹国胜有进步\n柯景腾上课认真听讲\n沈佳宜非常不错，好好保持\n胡家玮继续努力\n许博淳要加油了\n谢明和好好学习天天向上\n', NULL, NULL, 0),
	(10, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 14:25:51', '该班成绩如下:\n廖英宏 : 95.0\n曹国胜 : 90.0\n柯景腾 : 80.0\n沈佳宜 : 100.0\n胡家玮 : 88.0\n许博淳 : 78.0\n谢明和 : 87.0\n', NULL, NULL, 0),
	(11, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 14:25:58', '该班成绩如下:\n仙蒂 : 100.0\n周星星 : 59.0\n大飞 : 60.0\n曹达华 : 97.0\n林大岳 : 91.0\n汤朱迪 : 98.0\n黄小龟 : 84.0\n', NULL, NULL, 0),
	(12, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 15:16:28', '该班成绩如下:\n妮可罗宾 : 12.0\n索隆 : 21.0\n路飞 : 44.0\n香吉士 : 66.0\n', NULL, NULL, 0),
	(13, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 17:03:07', '该班成绩如下:\n妮可罗宾 : 12.0\n索隆 : 21.0\n路飞 : 44.0\n香吉士 : 66.0\n', NULL, NULL, 0),
	(14, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 17:03:50', '该班成绩如下:\n仙蒂 : 100.0\n周星星 : 59.0\n大飞 : 60.0\n曹达华 : 97.0\n林大岳 : 91.0\n汤朱迪 : 98.0\n黄小龟 : 84.0\n', NULL, NULL, 0),
	(15, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 17:04:04', '该班成绩如下:\n廖英宏 : 95.0\n曹国胜 : 90.0\n柯景腾 : 80.0\n沈佳宜 : 100.0\n胡家玮 : 88.0\n许博淳 : 78.0\n谢明和 : 87.0\n', NULL, NULL, 0),
	(16, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 17:57:35', '该班成绩如下:\n廖英宏 : 95.0\n曹国胜 : 90.0\n柯景腾 : 80.0\n沈佳宜 : 100.0\n胡家玮 : 88.0\n许博淳 : 78.0\n谢明和 : 87.0\n', NULL, NULL, 0),
	(17, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 17:57:46', '<xml>\n  <CreateTime><![CDATA[0]]></CreateTime>\n  <FuncFlag><![CDATA[0]]></FuncFlag>\n  <ArticleCount><![CDATA[1]]></ArticleCount>\n  <Articles>\n    <item>\n      <id><![CDATA[0]]></id>\n      <title><![CDATA[考试成绩]]></title>\n      <description><![CDATA[301班英语成绩]]></description>\n      <picUrl><![CDATA[http://localhost:8080/aixuexiao/assets/img/bg1.jpg]]></picUrl>\n      <url><![CDATA[http://localhost:8080/aixuexiao/manager/echats]]></url>\n      <replyId><![CDATA[0]]></replyId>\n    </item>\n  </Articles>\n</xml>', NULL, NULL, 0),
	(18, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 18:00:06', '<xml>\n  <CreateTime><![CDATA[0]]></CreateTime>\n  <FuncFlag><![CDATA[0]]></FuncFlag>\n  <ArticleCount><![CDATA[1]]></ArticleCount>\n  <Articles>\n    <item>\n      <id><![CDATA[0]]></id>\n      <title><![CDATA[考试成绩]]></title>\n      <description><![CDATA[301班英语成绩]]></description>\n      <picUrl><![CDATA[http://localhost:8080/aixuexiao/assets/img/bg1.jpg]]></picUrl>\n      <url><![CDATA[http://localhost:8080/aixuexiao/manager/echats]]></url>\n      <replyId><![CDATA[0]]></replyId>\n    </item>\n  </Articles>\n</xml>', NULL, NULL, 0),
	(19, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-10 18:10:19', '该班成绩如下:\n廖英宏 : 95.0\n曹国胜 : 90.0\n柯景腾 : 80.0\n沈佳宜 : 100.0\n胡家玮 : 88.0\n许博淳 : 78.0\n谢明和 : 87.0\n', NULL, NULL, 0),
	(20, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 10:15:16', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(21, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 10:15:31', '欢迎订阅爱学校，你可以回复指定内容来了解学生考试情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩图表请回复： *_图文\n', NULL, NULL, 0),
	(22, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 10:15:46', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(23, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 10:16:44', '您好，编号为3021的学生(沈佳宜)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：大家好，三年级二班将于本周六举行家长会，届时请各位学生家长准时到达开会，谢谢！', NULL, NULL, 0),
	(24, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 10:37:55', '欢迎订阅爱学校，你可以回复指定内容来了解学生考试情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩图表请回复： *_图文\n', NULL, NULL, 0),
	(25, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 10:40:40', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(26, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 11:26:09', '', NULL, NULL, 1),
	(27, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:31:21', '', NULL, NULL, 1),
	(28, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:40:39', '', NULL, NULL, 1),
	(29, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 13:41:15', '欢迎订阅爱学校，你可以回复指定内容来了解学生考试情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩图表请回复： *_图文\n', NULL, NULL, 0),
	(30, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 13:42:08', '欢迎订阅爱学校，你可以回复指定内容来了解学生考试情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩图表请回复： *_图文\n', NULL, NULL, 0),
	(31, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:43:00', '', NULL, NULL, 1),
	(32, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:43:21', '', NULL, NULL, 1),
	(33, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:45:11', '', NULL, NULL, 1),
	(34, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:46:01', '', NULL, NULL, 1),
	(35, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:47:10', '', NULL, NULL, 1),
	(36, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:50:03', '', NULL, NULL, 1),
	(37, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:54:31', '', NULL, NULL, 1),
	(38, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 13:59:15', '', NULL, NULL, 1),
	(39, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 13:59:22', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(40, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 14:01:36', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(41, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 14:01:36', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(42, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 14:02:05', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(43, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 14:03:16', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n', NULL, NULL, 0),
	(44, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 14:39:16', '你还未绑定学号,请回复以下格式消息绑定学号:学号_绑定(如:3011_绑定)\n注意:一个微信号只能绑定一个学号,且不可解绑!', NULL, NULL, 0),
	(45, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 14:40:03', '你还未绑定学号,请回复以下格式消息绑定学号:学号_绑定(如:3011_绑定)\n注意:一个微信号只能绑定一个学号,且不可解绑!', NULL, NULL, 0),
	(46, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:32:41', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(47, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:32:49', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(48, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:33:12', ' 你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(49, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:34:04', ' 你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(50, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:35:25', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(51, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:35:36', ' 你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(52, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:35:46', ' 你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(53, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:36:01', ' 绑定学号成功!\n\n\n查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(54, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:36:22', '', NULL, NULL, 1),
	(55, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:36:58', '', NULL, NULL, 1),
	(56, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:37:03', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(57, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:37:47', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(58, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:37:51', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(59, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:38:17', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(60, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:38:36', '', NULL, NULL, 1),
	(61, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:38:53', '您好，编号为3011的学生(周星星)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：各位学生家长注意了，最近有不少同学出现逃学的情况，还号称“逃学威龙”。', NULL, NULL, 0),
	(62, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:39:03', '', NULL, NULL, 0),
	(63, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:39:11', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(64, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:49:34', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(65, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:51:11', '', NULL, NULL, 1),
	(66, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:51:11', '', NULL, NULL, 1),
	(67, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:52:27', '', NULL, NULL, 1),
	(68, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:55:08', '', NULL, NULL, 1),
	(69, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:55:38', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(70, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 15:55:46', '', NULL, NULL, 1),
	(71, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 15:56:37', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(72, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:00:23', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(73, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:00:23', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(74, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:01:13', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(75, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:02:43', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(76, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 16:02:57', '', NULL, NULL, 1),
	(77, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:11:34', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(78, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:12:32', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(79, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:15:15', '欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(80, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:16:04', ' 你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(81, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 16:16:31', '', NULL, NULL, 1),
	(82, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:16:46', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(83, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:16:55', ' 你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(84, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:20:04', '您好，编号为3011的学生(周星星)最近10次考试情况如下:\n考试时间：2013-08-21\n科目：英语\n分数：59.0\n班级排名：7\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验\n------分割线-------', NULL, NULL, 0),
	(85, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 16:20:55', '', NULL, NULL, 1),
	(86, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:21:57', ' 你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(87, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 16:23:05', '', NULL, NULL, 1),
	(88, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:23:21', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(89, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:25:30', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(90, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:25:43', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(91, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:25:56', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(92, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:28:32', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(93, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:28:38', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(94, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 16:28:48', '', NULL, NULL, 1),
	(95, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 16:29:03', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(96, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 17:56:09', '', NULL, NULL, 0),
	(97, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 17:56:34', '请按指示命令操作!', NULL, NULL, 0),
	(98, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 17:56:46', '', NULL, NULL, 1),
	(99, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 17:56:53', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(100, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 17:58:04', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(101, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 17:59:13', '请按指示命令操作!', NULL, NULL, 0),
	(102, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 17:59:43', '该微信已绑定学号!', NULL, NULL, 0),
	(103, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 18:01:02', '', NULL, NULL, 1),
	(104, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:03:53', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(105, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:04:14', '您好，编号为3011的学生(周星星)最近10次考试情况如下:\n考试时间：2013-08-21\n科目：英语\n分数：59.0\n班级排名：7\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验\n------分割线-------', NULL, NULL, 0),
	(106, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:04:35', '您好，编号为3011的学生(周星星)最近老师留言如下:\n留言时间：2013-08-21\n留言内容：不准逃课', NULL, NULL, 0),
	(107, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:04:44', '您好，编号为3011的学生(周星星)最近(10次)老师留言如下:\n留言时间：2013-08-21\n留言内容：不准逃课\n------分割线-------', NULL, NULL, 0),
	(108, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:04:57', '您好，编号为3011的学生(周星星)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：各位学生家长注意了，最近有不少同学出现逃学的情况，还号称“逃学威龙”。', NULL, NULL, 0),
	(109, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:05:10', '您好，编号为3011的学生(周星星)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：各位学生家长注意了，最近有不少同学出现逃学的情况，还号称“逃学威龙”。\n------分割线-------', NULL, NULL, 0),
	(110, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:05:21', '该班成绩如下:\n', NULL, NULL, 0),
	(111, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'NEWS', '2017-05-11 18:10:12', '', NULL, NULL, 1),
	(112, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-11 18:10:21', '您好，编号为3011的学生(周星星)最近一次考试记录如下:\n科目：英语\n分数：59.0\n班级排名：7\n考试时间：2013-08-21\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验', NULL, NULL, 0),
	(113, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:29:23', '请输入正确的指令\n欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(114, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:29:42', '您好，编号为3011的学生(周星星)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：各位学生家长注意了，最近有不少同学出现逃学的情况，还号称“逃学威龙”。', NULL, NULL, 0),
	(115, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:29:54', '您好，编号为3011的学生(周星星)最近10次考试情况如下:\n考试时间：2013-08-21\n科目：英语\n分数：59.0\n班级排名：7\n老师备注：逃课就是这个下场\n试卷满分：100.0\n班级均分：84.1\n班级最高分：100.0\n班级最低分：59.0\n考试说明：精诚中学三年级二班下学期英语单元测验\n------分割线-------', NULL, NULL, 0),
	(116, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:30:36', '该微信已绑定学号!', NULL, NULL, 0),
	(117, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:30:56', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(118, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:31:05', '查询失败，请检查你的回复是否正确。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n\n 查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(119, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:31:31', '请输入正确的指令\n欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(120, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:36:20', '你还未绑定学号,请回复以下格式消息绑定学号 : 学号_绑定(如:3011_绑定)\n\n注意 : 一个微信号只能绑定一个学号! 且不可解绑!!!', NULL, NULL, 0),
	(121, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:37:05', '微信绑定成功!', NULL, NULL, 0),
	(122, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 08:37:25', '请输入正确的指令\n欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：学号_考试（如：3021_考试）\n 查询最近最近10次考试情况请回复：学号_考试历史（如：3021_考试历史）\n 查询老师留言情况请回复：学号_留言（如：3021_留言）\n查询老师留言记录（最近10次）情况请回复：学号_留言历史（如：3021_留言历史）\n查询班级动态情况请回复：学号_动态（如：3021_动态）\n查询班级动态记录（最近10次）情况请回复：学号_动态历史（如：3021_动态历史）\n查询班级成绩上次考试排名请回复： 学号_图文（如：3021_图文）\n', NULL, NULL, 0),
	(123, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 14:52:22', '请输入正确的指令\n欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：考试\n 查询最近最近10次考试情况请回复：考试历史\n 查询老师留言情况请回复：留言\n查询老师留言记录（最近10次）情况请回复：留言历史\n查询班级动态情况请回复：动态\n查询班级动态记录（最近10次）情况请回复：动态历史\n查询班级成绩上次考试排名请回复：图文\n', NULL, NULL, 0),
	(124, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 14:52:28', '请输入正确的指令\n欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：考试\n 查询最近最近10次考试情况请回复：考试历史\n 查询老师留言情况请回复：留言\n查询老师留言记录（最近10次）情况请回复：留言历史\n查询班级动态情况请回复：动态\n查询班级动态记录（最近10次）情况请回复：动态历史\n查询班级成绩上次考试排名请回复：图文\n', NULL, NULL, 0),
	(125, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 21:17:49', '请输入正确的指令\n欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：考试\n 查询最近最近10次考试情况请回复：考试历史\n 查询老师留言情况请回复：留言\n查询老师留言记录（最近10次）情况请回复：留言历史\n查询班级动态情况请回复：动态\n查询班级动态记录（最近10次）情况请回复：动态历史\n查询班级成绩上次考试排名请回复：图文\n', NULL, NULL, 0),
	(126, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 21:17:59', '您好，编号为3021的学生(沈佳宜)最近一次考试记录如下:\n科目：数学\n分数：100.0\n班级排名：1\n考试时间：2013-08-22\n老师备注：非常不错，好好保持\n试卷满分：100.0\n班级均分：88.3\n班级最高分：100.0\n班级最低分：78.0\n考试说明：数学单元测验', NULL, NULL, 0),
	(127, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 21:18:03', '您好，编号为3021的学生(沈佳宜)最近10次考试情况如下:\n考试时间：2013-08-22\n科目：数学\n分数：100.0\n班级排名：1\n老师备注：非常不错，好好保持\n试卷满分：100.0\n班级均分：88.3\n班级最高分：100.0\n班级最低分：78.0\n考试说明：数学单元测验\n------分割线-------', NULL, NULL, 0),
	(128, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 21:18:40', '该微信已绑定学号!', NULL, NULL, 0),
	(129, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 21:18:46', '请输入正确的指令\n欢迎订阅常州学校智能课堂，你可以回复指定内容来了解学生情况，老师留言和班级动态。\n查询最近考试情况请回复：考试\n 查询最近最近10次考试情况请回复：考试历史\n 查询老师留言情况请回复：留言\n查询老师留言记录（最近10次）情况请回复：留言历史\n查询班级动态情况请回复：动态\n查询班级动态记录（最近10次）情况请回复：动态历史\n查询班级成绩上次考试排名请回复：图文\n', NULL, NULL, 0),
	(130, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 21:18:58', '您好，编号为3021的学生(沈佳宜)最近老师留言如下:\n留言时间：2013-08-22\n留言内容：好好学习天天向上哈', NULL, NULL, 0),
	(131, 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 'gh_1aff82adf8c3', 'TEXT', '2017-05-12 21:19:05', '您好，编号为3021的学生(沈佳宜)最近班级动态如下:\n动态时间：2013-08-21\n动态内容：大家好，三年级二班将于本周六举行家长会，届时请各位学生家长准时到达开会，谢谢！\n------分割线-------', NULL, NULL, 0);
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.reply_article 结构
CREATE TABLE IF NOT EXISTS `reply_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `replyid` int(10) unsigned NOT NULL,
  `title` varchar(32) NOT NULL,
  `description` varchar(64) NOT NULL,
  `picurl` varchar(128) NOT NULL,
  `url` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_replyid` (`replyid`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.reply_article 的数据：27 rows
/*!40000 ALTER TABLE `reply_article` DISABLE KEYS */;
REPLACE INTO `reply_article` (`id`, `replyid`, `title`, `description`, `picurl`, `url`) VALUES
	(5, 26, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats'),
	(6, 27, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats'),
	(7, 28, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(8, 31, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(9, 32, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(10, 33, '考试成绩', '302班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=302'),
	(11, 34, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(12, 35, '考试成绩', '302班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=302'),
	(13, 36, '考试成绩', '303班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=303'),
	(14, 37, '考试成绩', '303班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=303'),
	(15, 38, '考试成绩', '303班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=303'),
	(16, 54, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(17, 55, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(18, 60, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(19, 65, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(20, 66, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(21, 67, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(22, 68, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(23, 70, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(24, 76, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(25, 81, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(26, 85, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(27, 87, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(28, 94, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(29, 98, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(30, 103, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301'),
	(31, 111, '考试成绩', '301班英语成绩', 'http://localhost:8080/aixuexiao/assets/img/bg1.jpg', 'http://localhost:8080/aixuexiao/changda/echats?classid=301');
/*!40000 ALTER TABLE `reply_article` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.signin 结构
CREATE TABLE IF NOT EXISTS `signin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) NOT NULL COMMENT '学生id',
  `classid` int(11) DEFAULT NULL COMMENT '班级id',
  `signnum` int(11) DEFAULT NULL COMMENT '签到码',
  `signtime` timestamp NULL DEFAULT NULL COMMENT '签到时间',
  PRIMARY KEY (`id`),
  KEY `Index_signin` (`studentid`,`classid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='学生签到表';

-- 正在导出表  app_aixuexiao.signin 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `signin` DISABLE KEYS */;
/*!40000 ALTER TABLE `signin` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.signin_detail 结构
CREATE TABLE IF NOT EXISTS `signin_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) DEFAULT '0',
  `classid` int(11) DEFAULT '0',
  `signid` int(11) DEFAULT '0',
  `flag` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Index_signin_detail` (`studentid`,`classid`,`signid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='签到情况';

-- 正在导出表  app_aixuexiao.signin_detail 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `signin_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `signin_detail` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.student 结构
CREATE TABLE IF NOT EXISTS `student` (
  `id` int(10) unsigned NOT NULL COMMENT '学生学号，通常为班级编号加上序号，如3021',
  `classid` int(10) unsigned NOT NULL COMMENT '所属班级编号',
  `name` char(8) NOT NULL COMMENT '学生姓名',
  `remark` varchar(32) DEFAULT NULL,
  `fromusername` char(100) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_classes` (`classid`,`name`,`fromusername`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.student 的数据：18 rows
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
REPLACE INTO `student` (`id`, `classid`, `name`, `remark`, `fromusername`, `flag`) VALUES
	(3021, 302, '沈佳宜', '佳宜（女主角）', 'oMMOrxBeKDXmqssrnNwwxHcy-Ktw', 1),
	(3022, 302, '柯景腾', '柯腾（男主角）', NULL, 0),
	(3023, 302, '曹国胜', '老曹(柯腾的挚友)', NULL, 0),
	(3024, 302, '谢明和', '阿和(柯腾的挚友)', NULL, 0),
	(3025, 302, '廖英宏', '该边(柯腾的挚友)', NULL, 0),
	(3026, 302, '胡家玮', '弯弯(沈佳宜的好友)', NULL, 0),
	(3027, 302, '许博淳', '勃起(柯腾的挚友)', NULL, 0),
	(3011, 301, '周星星', '周星驰', '', 2),
	(3012, 301, '曹达华', '吴孟达', NULL, 0),
	(3013, 301, '大飞', '张耀扬', NULL, 0),
	(3014, 301, '黄小龟', '黄一山', NULL, 0),
	(3015, 301, '仙蒂', '朱茵', NULL, 0),
	(3016, 301, '汤朱迪', '梅艳芳', NULL, 0),
	(3017, 301, '林大岳', '黄秋生', NULL, 0),
	(3031, 303, '路飞', '海贼王', NULL, 0),
	(3032, 303, '索隆', '路痴', NULL, 0),
	(3033, 303, '香吉士', '花痴', NULL, 0),
	(3034, 303, '妮可罗宾', '考古学家', NULL, 0);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;

-- 导出  表 app_aixuexiao.student_message 结构
CREATE TABLE IF NOT EXISTS `student_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息编号',
  `studentid` int(10) unsigned NOT NULL COMMENT '学生编号',
  `inserttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `content` varchar(128) NOT NULL,
  `formusername` char(50) NOT NULL COMMENT '微信号(唯一)',
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否关联过学号的标识',
  PRIMARY KEY (`id`),
  KEY `index_student_message` (`studentid`,`inserttime`,`formusername`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 正在导出表  app_aixuexiao.student_message 的数据：2 rows
/*!40000 ALTER TABLE `student_message` DISABLE KEYS */;
REPLACE INTO `student_message` (`id`, `studentid`, `inserttime`, `content`, `formusername`, `flag`) VALUES
	(1, 3011, '2013-08-21 11:09:44', '不准逃课', '', 0),
	(2, 3021, '2013-08-22 10:56:15', '好好学习天天向上哈', '', 0);
/*!40000 ALTER TABLE `student_message` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
