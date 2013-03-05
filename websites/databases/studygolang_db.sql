/*---------------------------------------------------------------------------*
  NAME: topics
  用途：帖子内容表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics` (
  `tid` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `nid` int NOT NULL COMMENT '节点id',
  `uid` int unsigned NOT NULL COMMENT '帖子作者',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mtime` timestamp NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: topics_ex
  用途：帖子扩展表（计数）
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `topics_ex`;
CREATE TABLE `topics_ex` (
  `tid` int unsigned NOT NULL,
  `view` int unsigned NOT NULL DEFAULT 0 COMMENT '浏览数',
  `reply` int unsigned NOT NULL DEFAULT 0 COMMENT '回复数',
  `like` int unsigned NOT NULL DEFAULT 0 COMMENT '喜欢数',
  `mtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: topics_reply
  用途：帖子回复表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `topics_reply`;
CREATE TABLE `topics_reply` (
  `rid` int unsigned NOT NULL AUTO_INCREMENT,
  `tid` int unsigned NOT NULL COMMENT '所属主帖',
  `content` text NOT NULL,
  `nid` int NOT NULL COMMENT '节点id',
  `uid` int unsigned NOT NULL COMMENT '回复者',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rid`),
  KEY (`tid`),
  KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: topics_node
  用途：帖子节点表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `topics_node`;
CREATE TABLE `topics_node` (
  `nid` int unsigned NOT NULL AUTO_INCREMENT,
  `parent` int unsigned NOT NULL DEFAULT 0 COMMENT '父节点id，无父节点为0',
  `name` varchar(20) NOT NULL COMMENT '节点名',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: user_login
  用途：用户登录表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `user_login`;
CREATE TABLE `user_login` (
  `uid` int unsigned NOT NULL,
  `email` varchar(128) NOT NULL DEFAULT '',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `passcode` char(20) NOT NULL DEFAULT '' COMMENT '加密随机数',
  `passwd` char(32) NOT NULL DEFAULT '' COMMENT 'md5密码',
  PRIMARY KEY (`uid`),
  UNIQUE KEY (`username`),
  UNIQUE KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: bind_user
  用途：第三方绑定表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `bind_user`;
CREATE TABLE `bind_user` (
  `uid` int unsigned NOT NULL,
  `type` tinyint NOT NULL DEFAULT 0 COMMENT '绑定的第三方类型',
  `email` varchar(128) NOT NULL DEFAULT '',
  `tuid` int unsigned NOT NULL DEFAULT 0 COMMENT '第三方uid',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `token` varchar(50) NOT NULL COMMENT '第三方access_token',
  `refresh` varchar(50) NOT NULL COMMENT '第三方refresh_token',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: user_info
  用途：用户信息表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `uid` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL DEFAULT '',
  `open` tinyint NOT NULL DEFAULT 1 COMMENT '邮箱是否公开，默认公开',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '姓名',
  `avatar` varchar(128) NOT NULL DEFAULT '' COMMENT '头像',
  `city` varchar(10) NOT NULL DEFAULT '',
  `company` varchar(64) NOT NULL DEFAULT '',
  `github` varchar(20) NOT NULL DEFAULT '',
  `weibo` varchar(20) NOT NULL DEFAULT '',
  `website` varchar(50) NOT NULL DEFAULT '' COMMENT '个人主页，博客',
  `status` varchar(140) NOT NULL DEFAULT '' COMMENT '个人状态，签名',
  `introduce` text NOT NULL DEFAULT '' COMMENT '个人简介',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  UNIQUE KEY (`username`),
  UNIQUE KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: role
  用途：角色表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleid` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '角色名',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`roleid`),
  UNIQUE KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: authority
  用途：权限表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `aid` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '权限名',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`aid`),
  UNIQUE KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: role_authority
  用途：角色拥有的权限表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `role_authority`;
CREATE TABLE `role_authority` (
  `roleid` int unsigned NOT NULL,
  `aid` int unsigned NOT NULL,
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`roleid`, `aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: user_role
  用途：用户角色表（用户是什么角色，可以多个角色）
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `uid` int unsigned NOT NULL,
  `roleid` int unsigned NOT NULL,
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`, `roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: notification
  用途：通知表
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `read` tinyint NOT NULL DEFAULT 0 COMMENT '是否已读',
  `uid` int unsigned NOT NULL,
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*---------------------------------------------------------------------------*
  NAME: message
  用途：短消息（暂不实现）
*---------------------------------------------------------------------------*/
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `read` tinyint NOT NULL DEFAULT 0 COMMENT '是否已读',
  `uid` int unsigned NOT NULL,
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
