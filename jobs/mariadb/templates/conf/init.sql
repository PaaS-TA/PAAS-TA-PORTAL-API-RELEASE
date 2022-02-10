/*
UPDATE mysql.user SET password=PASSWORD('<%= p("mariadb.admin_user.password") %>') WHERE user='root';
*/

<% if p("cce_enable") %>

-- auth : ed25519
ALTER USER 'vcap'@'localhost' IDENTIFIED VIA ed25519 USING PASSWORD('<%= p("mariadb.admin_user.password") %>');

ALTER USER 'root'@'localhost' IDENTIFIED VIA ed25519 USING PASSWORD('<%= p("mariadb.admin_user.password") %>');
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED VIA ed25519 USING PASSWORD('<%= p("mariadb.admin_user.password") %>') WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'keystone'@'localhost' IDENTIFIED VIA ed25519 USING PASSWORD('swiftstack');
CREATE DATABASE IF NOT EXISTS keystone CHARACTER SET utf8 COLLATE utf8_general_ci;
use keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED VIA ed25519 USING PASSWORD('swiftstack') WITH GRANT OPTION;

<% else %>

-- auth : mysql_native_password
ALTER USER 'root'@'localhost' IDENTIFIED BY '<%= p("mariadb.admin_user.password") %>';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<%= p("mariadb.admin_user.password") %>' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'keystone'@'localhost' IDENTIFIED BY 'swiftstack';
CREATE DATABASE IF NOT EXISTS keystone CHARACTER SET utf8 COLLATE utf8_general_ci;
use keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'swiftstack' WITH GRANT OPTION;

<% end %>


/*

 Source Server Type    : MySQL
 Source Server Version : 100122
 Source Schema         : portaldb

 Target Server Type    : MySQL
 Target Server Version : 100122
 File Encoding         : 65001

 Date: 11/07/2018 14:59:48
*/
CREATE DATABASE /*!32312 IF NOT EXISTS*/`portaldb` /*!40100 DEFAULT CHARACTER SET utf8 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`webconfig` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `portaldb`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` text,
  `file_size` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  `question_no` int(11) NOT NULL,
  `answerer` varchar(128) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auto_scaling_config
-- ----------------------------
DROP TABLE IF EXISTS `auto_scaling_config`;
CREATE TABLE `auto_scaling_config` (
  `no` int(11) NOT NULL,
  `guid` varchar(255) NOT NULL,
  `org` varchar(255) DEFAULT NULL,
  `space` varchar(255) DEFAULT NULL,
  `app` varchar(255) DEFAULT NULL,
  `instance_min_cnt` int(11) NOT NULL,
  `instance_max_cnt` int(11) NOT NULL,
  `cpu_threshold_min_per` decimal(2,1) NOT NULL,
  `cpu_threshold_max_per` decimal(2,1) NOT NULL,
  `memory_min_size` int(11) DEFAULT NULL,
  `memory_max_size` int(11) DEFAULT NULL,
  `check_time_sec` int(11) NOT NULL,
  `auto_increase_yn` varchar(1) DEFAULT NULL,
  `auto_decrease_yn` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for board
-- ----------------------------
DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `user_id` varchar(128) NOT NULL,
  `content` longtext,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` text,
  `file_size` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  `parent_no` int(11) NOT NULL,
  `group_no` int(11) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for board_comment
-- ----------------------------
DROP TABLE IF EXISTS `board_comment`;
CREATE TABLE `board_comment` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(128) NOT NULL,
  `content` longtext NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  `board_no` int(11) NOT NULL,
  `parent_no` int(11) NOT NULL,
  `group_no` int(11) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for buildpack_category
-- ----------------------------
DROP TABLE IF EXISTS `buildpack_category`;
CREATE TABLE `buildpack_category` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `classification` varchar(36) NOT NULL,
  `summary` varchar(255) NOT NULL,
  `description` text,
  `buildpack_name` varchar(255) NOT NULL,
  `thumb_img_name` varchar(255) DEFAULT NULL,
  `thumb_img_path` text,
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  `app_sample_file_name` varchar(255) DEFAULT NULL,
  `app_sample_file_path` text,
  `app_sample_file_size` bigint(20) DEFAULT NULL,
  `user_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  `doc_file_url` text,
  `tags_param` text,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=19165 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of buildpack_category
-- ----------------------------
BEGIN;
/* CAMBODIA */
INSERT INTO `buildpack_category` VALUES (3158,'GO App development','buildpack_system','GO offline App development environment','<h1>Cloud Foundry Go(Lang) Buildpack</h1>\n\n<p><a href=\"https://cloudfoundry.slack.com/messages/buildpacks/\"><img alt=\"CF Slack\" src=\"https://camo.githubusercontent.com/e4a605f6de93e9a6c885d47bf6e13e9cde87dbb3/68747470733a2f2f7777772e676f6f676c652e636f6d2f73322f66617669636f6e733f646f6d61696e3d7777772e736c61636b2e636f6d\" />&nbsp;Join us on Slack</a></p>\n\n<p>A Cloud Foundry&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/\">buildpack</a>&nbsp;for Go(lang) based apps.</p>\n\n<h3>Buildpack User Documentation</h3>\n\n<p>Official buildpack documentation can be found at&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/go/index.html\">go buildpack docs</a>.</p>\n\n<h3>Building the Buildpack</h3>\n\n<p>To build this buildpack, run the following command from the buildpack&#39;s directory:</p>\n\n<ol>\n <li>\n  <p>Source the .envrc file in the buildpack directory.</p>\n\n <pre>\nsource .envrc</pre>\n\n  <p>To simplify the process in the future, install&nbsp;<a href=\"https://direnv.net/\">direnv</a>&nbsp;which will automatically source .envrc when you change directories.</p>\n  </li>\n <li>\n  <p>Install buildpack-packager</p>\n\n <pre>\n(cd src/go/vendor/github.com/cloudfoundry/libbuildpack/packager/buildpack-packager &amp;&amp; go install)</pre>\n  </li>\n <li>\n  <p>Build the buildpack</p>\n\n  <pre>\nbuildpack-packager build [ --cached=(true|false) ]</pre>\n </li>\n <li>\n  <p>Use in Cloud Foundry</p>\n\n <p>Upload the buildpack to your Cloud Foundry and optionally specify it by name</p>\n\n <pre>\ncf create-buildpack [BUILDPACK_NAME] [BUILDPACK_ZIP_FILE_PATH] 1\ncf push my_app [-b BUILDPACK_NAME]</pre>\n </li>\n</ol>\n','go_buildpack','Go.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/bec3ac13625d450599fc8a8754ce5a8f-1538020729820-R28_Py5qcGc%3D','Y','go-15-sample.zip','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/ebdaf0ebda964ab7af28bc3d1b83b099-1538027099620-Z28tMTUtc2FtcGxlLnppcA%3D%3D',1937,'admin','2016-07-26 07:41:23','2022-02-03 02:04:36','https://github.com/cloudfoundry/go-buildpack','{\"paas-ta\":\"colors1\",\"free\":\"colors2\"}'),(3155,'eGov Framwork App development','buildpack_system','eGov Framework offline App development environment','<p>You can select and configure Tomcat and Jboss application servers as the e-government framework offline app development environment.</p>\n\n<h1>PaaS-TA eGovframework buildpack</h1>\n\n<p>Applications running in PaaS-TA can be developed using various languages and frameworks. The build pack serves to support applications developed in these various environments to run in PaaS-TA. The e-Government Framework Build Pack v3.5 supports the application developed by applying the e-Government Framework (<a href=\"https://www.egovframe.go.kr/\">https://www.egovframe.go.kr/</a>) to run in PaaS-TA.</p>\n','egv_offline_buildpack','eGov.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/accacbbf37bb4a1aa239bab93ec2d9f5-1538020822515-Pz8_Pz8_Pz8_Pz8_LnBuZw%3D%3D','N','spring-music.war','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/ceac45ae4bdf42b498c916db371f3779-1538020836794-c3ByaW5nLW11c2ljLndhcg%3D%3D',25679220,'admin','2016-07-26 07:25:25','2018-09-27 08:19:37','https://github.com/PaaS-TA/egov-buildpack-v3.5','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}'),(3161,'Java Pinpoint offline App development','buildpack_custom','Java Pinpoint offline APM App development environment','<p>It is pinpoint offline development environment for Java application monitoring.<br />\nIt is a distributed environment application monitoring created by Naver.</p>\n','Uninstalled development environment','pinpoint.png','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/f5d04383b7fc483ea5f8c9f302380b13-1538014025660-cGlucG9pbnQ_Pz8ucG5n','N','spring-music.war','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/788b7e6f7d0d400b938d394c887f18a2-1538014037013-c3ByaW5nLW11c2ljLndhcg%3D%3D',25679220,'admin','2016-07-26 07:47:17','2022-02-03 02:03:38','https://github.com/PaaS-TA/PINPOINT-BUILDPACK-MASTER','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}'),(772,'Ruby App development','buildpack_system','Ruby offline App development environment','<h1>Cloud Foundry Ruby Buildpack</h1>\n\n<p><a href=\"https://cloudfoundry.slack.com/messages/buildpacks/\"><img alt=\"CF Slack\" src=\"https://camo.githubusercontent.com/e4a605f6de93e9a6c885d47bf6e13e9cde87dbb3/68747470733a2f2f7777772e676f6f676c652e636f6d2f73322f66617669636f6e733f646f6d61696e3d7777772e736c61636b2e636f6d\" />&nbsp;Join us on Slack</a></p>\n\n<p>A Cloud Foundry&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/\">buildpack</a>&nbsp;for Ruby based apps.</p>\n\n<h3>Buildpack User Documentation</h3>\n\n<p>Official buildpack documentation can be found at&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/ruby/index.html\">Ruby buildpack docs</a>.</p>\n\n<h3>Building the Buildpack</h3>\n\n<p>To build this buildpack, run the following commands from the buildpack&#39;s directory:</p>\n\n<ol>\n  <li>\n  <p>Source the .envrc file in the buildpack directory.</p>\n\n <pre>\nsource .envrc</pre>\n\n  <p>To simplify the process in the future, install&nbsp;<a href=\"https://direnv.net/\">direnv</a>&nbsp;which will automatically source .envrc when you change directories.</p>\n  </li>\n <li>\n  <p>Install buildpack-packager</p>\n\n <pre>\n(cd src/ruby/vendor/github.com/cloudfoundry/libbuildpack/packager/buildpack-packager &amp;&amp; go install)</pre>\n  </li>\n <li>\n  <p>Build the buildpack</p>\n\n  <pre>\nbuildpack-packager build [ --cached ]</pre>\n  </li>\n <li>\n  <p>Use in Cloud Foundry</p>\n\n <p>Upload the buildpack to your Cloud Foundry and optionally specify it by name</p>\n\n <pre>\ncf create-buildpack [BUILDPACK_NAME] [BUILDPACK_ZIP_FILE_PATH] 1\ncf push my_app [-b BUILDPACK_NAME]</pre>\n </li>\n</ol>\n','ruby_buildpack','ruby.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/43830c6d07f64bf28ac2dd4891086484-1538026390849-cnVieT8_Py5qcGc%3D','Y','ruby-sample.zip','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/f42948f28f034b0684a3855a282b3a30-1538026812965-cnVieS1zYW1wbGUuemlw',57456,'admin','2016-07-21 01:32:10','2022-02-03 02:08:18','https://github.com/cloudfoundry/ruby-buildpack','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}'),(3156,'Java8 online App development','buildpack_system','Java8 online App development environment','<h1>Cloud Foundry Java Buildpack</h1>\n\n<p>The&nbsp;<code>java-buildpack</code>&nbsp;is a&nbsp;<a href=\"http://www.cloudfoundry.org/\">Cloud Foundry</a>&nbsp;buildpack for running JVM-based applications. It is designed to run many JVM-based applications (<a href=\"http://grails.org/\">Grails</a>,&nbsp;<a href=\"http://groovy.codehaus.org/\">Groovy</a>, Java Main,&nbsp;<a href=\"http://www.playframework.com/\">Play Framework</a>,&nbsp;<a href=\"http://projects.spring.io/spring-boot/\">Spring Boot</a>, and Servlet) with no additional configuration, but supports configuration of the standard components, and extension to add custom components.</p>\n\n<h2>Usage</h2>\n\n<p>To use this buildpack specify the URI of the repository when pushing an application to Cloud Foundry:</p>\n\n<pre>\n$ cf push &lt;APP-NAME&gt; -p &lt;ARTIFACT&gt; -b https://github.com/cloudfoundry/java-buildpack.git</pre>\n\n<h2>Examples</h2>\n\n<p>The following are&nbsp;<em>very</em>&nbsp;simple examples for deploying the artifact types that we support.</p>\n\n<ul>\n  <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-embedded-web-server.md\">Embedded web server</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-grails.md\">Grails</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-groovy.md\">Groovy</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-java_main.md\">Java Main</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-play_framework.md\">Play Framework</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-servlet.md\">Servlet</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-spring_boot_cli.md\">Spring Boot CLI</a></li>\n</ul>\n\n<h2>Configuration and Extension</h2>\n\n<p>The buildpack default configuration can be overridden with an environment variable matching the configuration file you wish to override minus the&nbsp;<code>.yml</code>&nbsp;extension and with a prefix of&nbsp;<code>JBP_CONFIG</code>. It is not possible to add new configuration properties and properties with&nbsp;<code>nil</code>&nbsp;or empty values will be ignored by the buildpack (in this case you will have to extend the buildpack, see below). The value of the variable should be valid inline yaml, referred to as &quot;flow style&quot; in the yaml spec (<a href=\"https://en.wikipedia.org/wiki/YAML#Basic_components_of_YAML\">Wikipedia</a>&nbsp;has a good description of this yaml syntax). For example, to change the default version of Java to 7 and adjust the memory heuristics apply this environment variable to the application.</p>\n\n<pre>\n$ cf set-env my-application JBP_CONFIG_OPEN_JDK_JRE &#39;{ jre: { version: 1.7.0_+ }, memory_calculator: { stack_threads: 200 } }&#39;</pre>\n\n<p>If the key or value contains a special character such as&nbsp;<code>:</code>&nbsp;it should be escaped with double quotes. For example, to change the default repository path for the buildpack.</p>\n\n<pre>\n$ cf set-env my-application JBP_CONFIG_REPOSITORY &#39;{ default_repository_root: &quot;http://repo.example.io&quot; }&#39;</pre>\n\n<p>If the key or value contains an environment variable that you want to bind at runtime you need to escape it from your shell. For example, to add command line arguments containing an environment variable to a&nbsp;<a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/container-java_main.md\">Java Main</a>&nbsp;application.</p>\n\n<pre>\n$ cf set-env my-application JBP_CONFIG_JAVA_MAIN &#39;{ arguments: &quot;-server.port=\\$PORT -foo=bar&quot; }&#39;</pre>\n\n<p>Environment variable can also be specified in the applications&nbsp;<code>manifest</code>&nbsp;file. For example, to specify an environment variable in an applications manifest file that disables Auto-reconfiguration.</p>\n\n<pre>\nenv:\n  JBP_CONFIG_SPRING_AUTO_RECONFIGURATION: &#39;{ enabled: false }&#39;</pre>\n\n<p>This final example shows how to change the version of Tomcat that is used by the buildpack with an environment variable specified in the applications manifest file.</p>\n\n<pre>\nenv:\n  JBP_CONFIG_TOMCAT: &#39;{ tomcat: { version: 8.0.+ } }&#39;</pre>\n\n<p>See the&nbsp;<a href=\"http://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html#env-block\">Environment Variables</a>&nbsp;documentation for more information.</p>\n\n<p>To learn how to configure various properties of the buildpack, follow the &quot;Configuration&quot; links below.</p>\n\n<p>The buildpack supports extension through the use of Git repository forking. The easiest way to accomplish this is to use&nbsp;<a href=\"https://help.github.com/articles/fork-a-repo\">GitHub&#39;s forking functionality</a>&nbsp;to create a copy of this repository. Make the required extension changes in the copy of the repository. Then specify the URL of the new repository when pushing Cloud Foundry applications. If the modifications are generally applicable to the Cloud Foundry community, please submit a&nbsp;<a href=\"https://help.github.com/articles/using-pull-requests\">pull request</a>&nbsp;with the changes. More information on extending the buildpack is available&nbsp;<a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/extending.md\">here</a>.</p>\n','java_buildpack','java8.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/29bb7c4cb4ba4506a0d0d9ed74daa7b9-1538020785700-Pz84LmpwZw%3D%3D','Y','sample-spring.war','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/1056ceb1c59947d59a15a679412da031-1538020789969-c2FtcGxlLXNwcmluZy53YXI%3D',9478983,'admin','2016-07-26 07:27:43','2022-02-03 02:05:21','https://github.com/cloudfoundry/java-buildpack','{\"paas-ta\":\"colors2\",\"free\":\"colors1\"}'),(20,'Java8 offline App development','buildpack_system','Java8 offline App development environment','<h1>Cloud Foundry Java Buildpack</h1>\n\n<p>The&nbsp;<code>java-buildpack</code>&nbsp;is a&nbsp;<a href=\"http://www.cloudfoundry.org/\">Cloud Foundry</a>&nbsp;buildpack for running JVM-based applications. It is designed to run many JVM-based applications (<a href=\"http://grails.org/\">Grails</a>,&nbsp;<a href=\"http://groovy.codehaus.org/\">Groovy</a>, Java Main,&nbsp;<a href=\"http://www.playframework.com/\">Play Framework</a>,&nbsp;<a href=\"http://projects.spring.io/spring-boot/\">Spring Boot</a>, and Servlet) with no additional configuration, but supports configuration of the standard components, and extension to add custom components.</p>\n\n<h2>Usage</h2>\n\n<p>To use this buildpack specify the URI of the repository when pushing an application to Cloud Foundry:</p>\n\n<pre>\n$ cf push &lt;APP-NAME&gt; -p &lt;ARTIFACT&gt; -b https://github.com/cloudfoundry/java-buildpack.git</pre>\n\n<h2>Examples</h2>\n\n<p>The following are&nbsp;<em>very</em>&nbsp;simple examples for deploying the artifact types that we support.</p>\n\n<ul>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-embedded-web-server.md\">Embedded web server</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-grails.md\">Grails</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-groovy.md\">Groovy</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-java_main.md\">Java Main</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-play_framework.md\">Play Framework</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-servlet.md\">Servlet</a></li>\n <li><a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/example-spring_boot_cli.md\">Spring Boot CLI</a></li>\n</ul>\n\n<h2>Configuration and Extension</h2>\n\n<p>The buildpack default configuration can be overridden with an environment variable matching the configuration file you wish to override minus the&nbsp;<code>.yml</code>&nbsp;extension and with a prefix of&nbsp;<code>JBP_CONFIG</code>. It is not possible to add new configuration properties and properties with&nbsp;<code>nil</code>&nbsp;or empty values will be ignored by the buildpack (in this case you will have to extend the buildpack, see below). The value of the variable should be valid inline yaml, referred to as &quot;flow style&quot; in the yaml spec (<a href=\"https://en.wikipedia.org/wiki/YAML#Basic_components_of_YAML\">Wikipedia</a>&nbsp;has a good description of this yaml syntax). For example, to change the default version of Java to 7 and adjust the memory heuristics apply this environment variable to the application.</p>\n\n<pre>\n$ cf set-env my-application JBP_CONFIG_OPEN_JDK_JRE &#39;{ jre: { version: 1.7.0_+ }, memory_calculator: { stack_threads: 200 } }&#39;</pre>\n\n<p>If the key or value contains a special character such as&nbsp;<code>:</code>&nbsp;it should be escaped with double quotes. For example, to change the default repository path for the buildpack.</p>\n\n<pre>\n$ cf set-env my-application JBP_CONFIG_REPOSITORY &#39;{ default_repository_root: &quot;http://repo.example.io&quot; }&#39;</pre>\n\n<p>If the key or value contains an environment variable that you want to bind at runtime you need to escape it from your shell. For example, to add command line arguments containing an environment variable to a&nbsp;<a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/container-java_main.md\">Java Main</a>&nbsp;application.</p>\n\n<pre>\n$ cf set-env my-application JBP_CONFIG_JAVA_MAIN &#39;{ arguments: &quot;-server.port=\\$PORT -foo=bar&quot; }&#39;</pre>\n\n<p>Environment variable can also be specified in the applications&nbsp;<code>manifest</code>&nbsp;file. For example, to specify an environment variable in an applications manifest file that disables Auto-reconfiguration.</p>\n\n<pre>\nenv:\n  JBP_CONFIG_SPRING_AUTO_RECONFIGURATION: &#39;{ enabled: false }&#39;</pre>\n\n<p>This final example shows how to change the version of Tomcat that is used by the buildpack with an environment variable specified in the applications manifest file.</p>\n\n<pre>\nenv:\n  JBP_CONFIG_TOMCAT: &#39;{ tomcat: { version: 8.0.+ } }&#39;</pre>\n\n<p>See the&nbsp;<a href=\"http://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html#env-block\">Environment Variables</a>&nbsp;documentation for more information.</p>\n\n<p>To learn how to configure various properties of the buildpack, follow the &quot;Configuration&quot; links below.</p>\n\n<p>The buildpack supports extension through the use of Git repository forking. The easiest way to accomplish this is to use&nbsp;<a href=\"https://help.github.com/articles/fork-a-repo\">GitHub&#39;s forking functionality</a>&nbsp;to create a copy of this repository. Make the required extension changes in the copy of the repository. Then specify the URL of the new repository when pushing Cloud Foundry applications. If the modifications are generally applicable to the Cloud Foundry community, please submit a&nbsp;<a href=\"https://help.github.com/articles/using-pull-requests\">pull request</a>&nbsp;with the changes. More information on extending the buildpack is available&nbsp;<a href=\"https://github.com/cloudfoundry/java-buildpack/blob/master/docs/extending.md\">here</a>.</p>\n','java_offline_buildpack','java8.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/f9b16a0688cd48289d699c23c613db62-1538013992878-Pz84LmpwZw%3D%3D','N','sample-spring.war','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/6088d57fb9214ad393609f15a246afc7-1538013997557-c2FtcGxlLXNwcmluZy53YXI%3D',9478983,'admin','2016-07-19 09:08:43','2018-09-27 08:21:17','https://github.com/cloudfoundry/java-buildpack','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}'),(3159,'Python App development','buildpack_system','Python offline App development environment','<h1>Cloud Foundry Python Buildpack</h1>\n\n<p><a href=\"https://cloudfoundry.slack.com/messages/buildpacks/\"><img alt=\"CF Slack\" src=\"https://camo.githubusercontent.com/e4a605f6de93e9a6c885d47bf6e13e9cde87dbb3/68747470733a2f2f7777772e676f6f676c652e636f6d2f73322f66617669636f6e733f646f6d61696e3d7777772e736c61636b2e636f6d\" />&nbsp;Join us on Slack</a></p>\n\n<p>A Cloud Foundry&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/\">buildpack</a>&nbsp;for Python based apps.</p>\n\n<p>This buildpack supports running Django and Flask apps.</p>\n\n<h3>Buildpack User Documentation</h3>\n\n<p>Official buildpack documentation can be found at&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/python/index.html\">python buildpack docs</a>.</p>\n\n<h3>Building the Buildpack</h3>\n\n<p>To build this buildpack, run the following commands from the buildpack&#39;s directory:</p>\n\n<ol>\n <li>\n  <p>Source the .envrc file in the buildpack directory.</p>\n\n <pre>\nsource .envrc</pre>\n\n  <p>To simplify the process in the future, install&nbsp;<a href=\"https://direnv.net/\">direnv</a>&nbsp;which will automatically source .envrc when you change directories.</p>\n  </li>\n <li>\n  <p>Install buildpack-packager</p>\n\n <pre>\n(cd src/python/vendor/github.com/cloudfoundry/libbuildpack/packager/buildpack-packager &amp;&amp; go install)</pre>\n  </li>\n <li>\n  <p>Build the buildpack</p>\n\n  <pre>\nbuildpack-packager build [ --cached=(true|false) ]</pre>\n </li>\n <li>\n  <p>Use in Cloud Foundry</p>\n\n <p>Upload the buildpack to your Cloud Foundry and optionally specify it by name</p>\n\n <pre>\ncf create-buildpack [BUILDPACK_NAME] [BUILDPACK_ZIP_FILE_PATH] 1\ncf push my_app [-b BUILDPACK_NAME]</pre>\n </li>\n</ol>\n','python_buildpack','python.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/d5172469efe7477db4eb89c0deba4b8b-1538014761877-cHl0aG9uLWxvZ28ucG5n','Y','python-sample.zip','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/519aac18e3114e6383aafc5953ba4bc3-1538014762194-cHl0aG9uLXNhbXBsZS56aXA%3D',3195,'admin','2016-07-26 07:44:40','2022-02-03 02:04:15','https://github.com/cloudfoundry/python-buildpack','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}'),(3160,'PHP App development','buildpack_system','PHP offline App development environment','<h1>Cloud Foundry PHP Buildpack</h1>\n\n<p><a href=\"https://cloudfoundry.slack.com/messages/buildpacks/\"><img alt=\"CF Slack\" src=\"https://camo.githubusercontent.com/e4a605f6de93e9a6c885d47bf6e13e9cde87dbb3/68747470733a2f2f7777772e676f6f676c652e636f6d2f73322f66617669636f6e733f646f6d61696e3d7777772e736c61636b2e636f6d\" />&nbsp;Join us on Slack</a></p>\n\n<p>A buildpack to deploy PHP applications to Cloud Foundry based systems, such as a&nbsp;<a href=\"https://www.cloudfoundry.org/learn/certified-providers/\">cloud provider</a>&nbsp;or your own instance.</p>\n\n<h3>Buildpack User Documentation</h3>\n\n<p>Official buildpack documentation can be found here:&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/php/index.html\">php buildpack docs</a>.</p>\n\n<h3>Building the Buildpack</h3>\n\n<ol>\n  <li>\n  <p>Make sure you have fetched submodules</p>\n\n  <pre>\ngit submodule update --init</pre>\n  </li>\n <li>\n  <p>Get latest buildpack dependencies</p>\n\n  <pre>\nBUNDLE_GEMFILE=cf.Gemfile bundle</pre>\n </li>\n <li>\n  <p>Build the buildpack</p>\n\n  <pre>\nBUNDLE_GEMFILE=cf.Gemfile bundle exec buildpack-packager [ --uncached | --cached ] [ --any-stack | --stack=STACK ]</pre>\n </li>\n <li>\n  <p>Use in Cloud Foundry</p>\n\n <p>Upload the buildpack to your Cloud Foundry instance and optionally specify it by name</p>\n\n  <pre>\ncf create-buildpack custom_php_buildpack php_buildpack-cached-custom.zip 1\ncf push my_app -b custom_php_buildpack</pre>\n </li>\n</ol>\n','php_buildpack','php.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/dd32d7febd754cc1b551882a9da3d601-1538014256035-cGhwPz8_LmpwZw%3D%3D','Y','php-sample.zip','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/b42e78f712ec4cbe8a5b1fb773ed175a-1538014257190-cGhwLXNhbXBsZS56aXA%3D',84439,'admin','2016-07-26 07:45:11','2022-02-03 02:03:26','https://github.com/cloudfoundry/php-buildpack','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}'),(3157,'Nodejs App development','buildpack_system','Nodejs offline App development environment','<h1>Cloud Foundry Node.js Buildpack</h1>\n\n<p><a href=\"https://cloudfoundry.slack.com/messages/buildpacks/\"><img alt=\"CF Slack\" src=\"https://camo.githubusercontent.com/e4a605f6de93e9a6c885d47bf6e13e9cde87dbb3/68747470733a2f2f7777772e676f6f676c652e636f6d2f73322f66617669636f6e733f646f6d61696e3d7777772e736c61636b2e636f6d\" />&nbsp;Join us on Slack</a></p>\n\n<p>A Cloud Foundry&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/\">buildpack</a>&nbsp;for Node based apps.</p>\n\n<h3>Buildpack User Documentation</h3>\n\n<p>Official buildpack documentation can be found at&nbsp;<a href=\"http://docs.cloudfoundry.org/buildpacks/node/index.html\">node buildpack docs</a>.</p>\n\n<h3>Building the Buildpack</h3>\n\n<p>To build this buildpack, run the following commands from the buildpack&#39;s directory:</p>\n\n<ol>\n  <li>\n  <p>Source the .envrc file in the buildpack directory.</p>\n\n <pre>\nsource .envrc</pre>\n\n  <p>To simplify the process in the future, install&nbsp;<a href=\"https://direnv.net/\">direnv</a>&nbsp;which will automatically source .envrc when you change directories.</p>\n  </li>\n <li>\n  <p>Install buildpack-packager</p>\n\n <pre>\n(cd src/nodejs/vendor/github.com/cloudfoundry/libbuildpack/packager/buildpack-packager &amp;&amp; go install)</pre>\n  </li>\n <li>\n  <p>Build the buildpack</p>\n\n  <pre>\nbuildpack-packager build [ --cached=(true|false) ]</pre>\n </li>\n <li>\n  <p>Use in Cloud Foundry</p>\n\n <p>Upload the buildpack to your Cloud Foundry and optionally specify it by name</p>\n\n <pre>\ncf create-buildpack [BUILDPACK_NAME] [BUILDPACK_ZIP_FILE_PATH] 1\ncf push my_app [-b BUILDPACK_NAME]</pre>\n </li>\n</ol>\n','nodejs_buildpack','nodejs.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/7cf028e3a39c48b5af1406cfb9d9726c-1538020757148-bm9kZWpzX2xvZ28ucG5n','Y','nodejs-sample.zip','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/cea09eec00664bcf99cdc39562c51287-1538020757819-bm9kZWpzLXNhbXBsZS56aXA%3D',1291728,'admin','2016-07-26 07:40:26','2022-02-03 02:04:56','https://github.com/cloudfoundry/nodejs-buildpack','{\"paas-ta\":\"colors2\",\"free\":\"colors1\"}'),(19142,'nginx','buildpack_system','nginx development environment','<h1>Cloud Foundry Staticfile Buildpack</h1>\n\n<p><a href=\"https://cloudfoundry.slack.com/messages/buildpacks/\"><img alt=\"CF Slack\" src=\"https://camo.githubusercontent.com/e4a605f6de93e9a6c885d47bf6e13e9cde87dbb3/68747470733a2f2f7777772e676f6f676c652e636f6d2f73322f66617669636f6e733f646f6d61696e3d7777772e736c61636b2e636f6d\" />&nbsp;Join us on Slack</a></p>\n\n<p>A Cloud Foundry&nbsp;<a href=\"https://docs.cloudfoundry.org/buildpacks/\">buildpack</a>&nbsp;for static content such as websites (HTML/JS/CSS).</p>\n\n<h3>Buildpack User Documentation</h3>\n\n<p>Official buildpack documentation can be found at&nbsp;<a href=\"https://docs.cloudfoundry.org/buildpacks/staticfile/index.html\">staticfile buildpack docs</a>.</p>\n\n<h3>Building the Buildpack</h3>\n\n<p>To build this buildpack, run the following commands from the buildpack&#39;s directory:</p>\n\n<ol>\n  <li>\n  <p>Source the .envrc file in the buildpack directory.</p>\n\n <pre>\nsource .envrc</pre>\n\n  <p>To simplify the process in the future, install&nbsp;<a href=\"https://direnv.net/\">direnv</a>&nbsp;which will automatically source .envrc when you change directories.</p>\n  </li>\n <li>\n  <p>Install buildpack-packager</p>\n\n <pre>\n(cd src/staticfile/vendor/github.com/cloudfoundry/libbuildpack/packager/buildpack-packager &amp;&amp; go install)</pre>\n  </li>\n <li>\n  <p>Build the buildpack</p>\n\n  <pre>\nbuildpack-packager build [ --cached=(true|false) ]</pre>\n </li>\n <li>\n  <p>Use in Cloud Foundry</p>\n\n <p>Upload the buildpack to your Cloud Foundry and optionally specify it by name</p>\n\n <pre>\ncf create-buildpack [BUILDPACK_NAME] [BUILDPACK_ZIP_FILE_PATH] 1\ncf push my_app [-b BUILDPACK_NAME]</pre>\n </li>\n</ol>\n\n<h3>Testing</h3>\n\n<p>To test this buildpack, run the following commands from the buildpack&#39;s directory:</p>\n\n<ol>\n <li>\n  <p>Source the .envrc file in the buildpack directory.</p>\n\n <pre>\nsource .envrc</pre>\n\n  <p>To simplify the process in the future, install&nbsp;<a href=\"https://direnv.net/\">direnv</a>&nbsp;which will automatically source .envrc when you change directories.</p>\n  </li>\n <li>\n  <p>Run unit tests</p>\n\n <pre>\n./scripts/unit.sh</pre>\n  </li>\n <li>\n  <p>Run integration tests</p>\n\n  <p>Buildpacks use the&nbsp;<a href=\"https://github.com/cloudfoundry/libbuildpack/tree/master/cutlass\">Cutlass</a>&nbsp;framework for running integration tests against Cloud Foundry. Before running the integration tests, you need to login to your Cloud Foundry using the&nbsp;<a href=\"https://github.com/cloudfoundry/cli\">cf cli</a>:</p>\n\n  <pre>\ncf login -a https://api.your-cf.com -u name@example.com -p pa55woRD</pre>\n\n  <p>Note that your user requires permissions to run&nbsp;<code>cf create-buildpack</code>&nbsp;and&nbsp;<code>cf update-buildpack</code>. To run the integration tests, run the following command from the buildpack&#39;s directory:</p>\n\n  <pre>\n./scripts/integration.sh</pre>\n </li>\n</ol>\n\n<p>More information can be found on&nbsp;<a href=\"https://github.com/cloudfoundry/libbuildpack/tree/master/cutlass\">here</a>.</p>\n\n<h3>Contributing</h3>\n\n<p>Find our guidelines&nbsp;<a href=\"https://github.com/cloudfoundry/staticfile-buildpack/blob/master/CONTRIBUTING.md\">here</a>.</p>\n\n<h3>Help and Support</h3>\n\n<p>Join the #buildpacks channel in our&nbsp;<a href=\"https://slack.cloudfoundry.org/\">Slack community</a>&nbsp;if you need any further assistance.</p>\n\n<h3>Reporting Issues</h3>\n\n<p>Open a GitHub issue on this project&nbsp;<a href=\"https://github.com/cloudfoundry/staticfile/issues/new\">here</a>.</p>\n\n<h3>Active Development</h3>\n\n<p>The project backlog is on&nbsp;<a href=\"https://www.pivotaltracker.com/projects/1042066\">Pivotal Tracker</a>.</p>\n\n<h3>Acknowledgements</h3>\n\n<p>This buildpack is based heavily upon Jordon Bedwell&#39;s Heroku buildpack and the modifications by David Laing for Cloud Foundry&nbsp;<a href=\"https://github.com/cloudfoundry-community/nginx-buildpack\">nginx-buildpack</a>. It has been tuned for usability (configurable with&nbsp;<code>Staticfile</code>) and to be included as a default buildpack (detects&nbsp;<code>Staticfile</code>&nbsp;rather than the presence of an&nbsp;<code>index.html</code>). Thanks for the buildpack Jordon!</p>\n','staticfile_buildpack','nginx.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/bd8d9ad56f3a4841915abb4644e32e90-1538013952322-bmdpbngucG5n','Y','sampleApp-static.zip','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/6585a79dda0b40da9ad609760ffe8e76-1538013953262-c2FtcGxlQXBwLXN0YXRpYy56aXA%3D',1300846,'admin','2018-05-25 17:12:37','2022-02-03 02:01:24','https://github.com/cloudfoundry/staticfile-buildpack','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}');
/* CAMBODIA */
COMMIT;

-- ----------------------------
-- Table structure for catalog_history
-- ----------------------------
DROP TABLE IF EXISTS `catalog_history`;
CREATE TABLE `catalog_history` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `catalog_no` int(11) NOT NULL,
  `catalog_type` varchar(255) NOT NULL,
  `user_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=2721 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for code_detail
-- ----------------------------
DROP TABLE IF EXISTS `code_detail`;
CREATE TABLE `code_detail` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(36) NOT NULL,
  `value` text NOT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `group_id` varchar(36) NOT NULL,
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  `order` int(11) NOT NULL DEFAULT '1',
  `user_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code_detail
-- ----------------------------
BEGIN;
/* CAMBODIA */
INSERT INTO `code_detail` VALUES (1,'33','33',NULL,'test111','Y',1,'admin','2016-11-18 09:32:30','2016-11-18 09:32:30'),(120,'33','33','','key','Y',8,'admin','2018-04-09 16:15:59','2018-04-09 16:15:59'),(3,'512','512',NULL,'APP_MEMORY_SIZE','Y',1,'admin','2016-12-05 15:30:51','2016-12-05 15:32:20'),(4,'768','768',NULL,'APP_MEMORY_SIZE','Y',2,'admin','2016-12-05 15:31:00','2016-12-05 15:32:25'),(5,'1024','1024',NULL,'APP_MEMORY_SIZE','Y',3,'admin','2016-12-05 15:31:15','2016-12-05 15:32:29'),(119,'33','33','','key','N',7,'admin','2018-04-09 16:13:15','2018-04-09 16:13:15'),(118,'33','33','','key','Y',6,'admin','2018-04-09 16:13:10','2018-04-09 16:13:10'),(10,'documents_starter','App template',NULL,'DOCUMENTS_CLASSIFICATION','Y',1,'admin','2016-09-01 13:45:32','2016-09-01 13:45:32'),(11,'documents_build_pack','App development',NULL,'DOCUMENTS_CLASSIFICATION','Y',2,'admin','2016-09-01 13:45:32','2016-09-01 13:45:32'),(12,'documents_service_pack','Service',NULL,'DOCUMENTS_CLASSIFICATION','Y',3,'admin','2016-09-01 13:45:32','2016-09-01 13:45:32'),(13,'documents_etc','Etc.',NULL,'DOCUMENTS_CLASSIFICATION','Y',4,'admin','2016-09-01 13:45:32','2016-09-01 13:45:32'),(14,'2','Refusal','Reject email approval','USER_STATUS','Y',3,'admin','2016-08-02 04:56:27','2016-08-02 04:56:27'),(15,'3','Delete','Delete member','USER_STATUS','Y',4,'admin','2016-08-02 04:56:27','2016-08-02 04:56:27'),(16,'minCpu','20','Min CPU','USER_AUTOSCAILE','Y',4,'admin','2016-07-26 01:53:42','2016-07-26 08:02:02'),(17,'maxCpu','80','Max CPU','USER_AUTOSCAILE','Y',3,'admin','2016-07-26 01:53:42','2016-07-26 08:02:02'),(18,'1','Approval','Email approval completed','USER_STATUS','Y',2,'admin','2016-08-02 04:56:27','2016-08-02 04:56:27'),(19,'ORG MANAGER','Org Manager','Can invite users and manage user roles in the org ','ORG_ROLES','Y',1,'admin','2016-09-02 01:17:19','2016-09-02 01:22:38'),(20,'0','Create','Waiting for email approval','USER_STATUS','Y',1,'admin','2016-08-02 04:56:27','2016-08-02 04:57:19'),(21,'minInstance','2','Min Instances','USER_AUTOSCAILE','Y',1,'admin','2016-07-26 01:44:17','2016-07-26 08:33:01'),(22,'maxInstance','20','Max Instances','USER_AUTOSCAILE','Y',2,'admin','2016-07-26 01:44:44','2016-07-26 08:33:29'),(23,'service_storage','Data Storage','Data Storage','SERVICE_PACK_CATALOG','Y',0,'admin','2016-07-25 17:06:24','2022-01-27 07:06:32'),(24,'service_message','Messaging','Messaging','SERVICE_PACK_CATALOG','Y',2,'admin','2016-07-25 17:06:24','2016-08-25 00:11:49'),(25,'service_nosql','NoSQL database','NoSQL database','SERVICE_PACK_CATALOG','Y',3,'admin','2016-07-25 17:06:24','2016-08-25 00:11:56'),(26,'service_rdbms','RDBMS','RDBMS','SERVICE_PACK_CATALOG','Y',4,'admin','2016-07-25 17:06:24','2016-08-25 00:12:04'),(67,'starter_main','DefaultType','start_main','STARTER_CATALOG','Y',0,'admin','2018-04-06 13:58:06','2022-02-03 00:53:14'),(68,'1111','2222','ssdfsdf','ssdfsdfsd','Y',1,'admin','2018-04-06 05:02:36','2018-04-06 05:02:36'),(28,'service_monitoring','App monitoring','App monitoring','SERVICE_PACK_CATALOG','Y',5,'admin','2016-07-26 05:49:10','2016-08-25 00:12:12'),(29,'buildpack_custom','Custom Buildpack','Start the app now with the app development environment that the user has organized.','BUILD_PACK_CATALOG','Y',2,'admin','2016-07-25 17:05:32','2016-08-25 00:12:52'),(30,'buildpack_system','System Buildpack','Start the app now with the app development environment basically provided by PaaS-TA.','BUILD_PACK_CATALOG','Y',1,'admin','2016-07-25 17:05:32','2016-08-25 11:05:38'),(31,'notice_event','Event','Event notice','SUPPORT_NOTICE','Y',2,'admin','2016-08-23 17:55:10','2016-08-24 10:14:05'),(32,'notice_notice','Notice','Notice','SUPPORT_NOTICE','Y',1,'admin','2016-08-23 17:54:47','2016-08-24 10:14:05'),(33,'notice_problem','Disability','Disability notice','SUPPORT_NOTICE','Y',3,'admin','2016-08-23 17:55:59','2016-08-24 10:14:05'),(34,'answered','answered','answered','QUESTION_STATUS','Y',0,'admin','2016-08-24 13:13:50','2022-02-03 00:59:42'),(35,'question_etc','Etc.',NULL,'QUESTION_CLASSIFICATION','Y',4,'admin','2016-08-24 09:52:08','2016-08-24 09:56:39'),(36,'question_service_pack','Service',NULL,'QUESTION_CLASSIFICATION','Y',3,'admin','2016-08-24 09:52:01','2016-08-24 09:56:51'),(37,'question_build_pack','App development environment',NULL,'QUESTION_CLASSIFICATION','Y',2,'admin','2016-08-24 09:51:18','2016-08-24 09:56:59'),(38,'question_starter','App template',NULL,'QUESTION_CLASSIFICATION','N',1,'admin','2016-08-24 09:50:57','2016-08-24 09:57:08'),(39,'waiting','waiting','waitin','QUESTION_STATUS','Y',0,'admin','2016-08-24 13:11:39','2022-02-03 00:59:31'),(40,'dev_ops','Development tools','Development tools','SERVICE_PACK_CATALOG','Y',6,'admin','2017-12-21 04:29:23',NULL),(151,'min_size','128','128mb','APP_DISK_SIZE','Y',0,'admin','2018-09-27 09:10:28','2018-09-27 09:13:07'),(152,'256','256','256mb','APP_DISK_SIZE','Y',0,'admin','2018-09-27 09:10:56','2018-09-27 09:13:15'),(153,'512','512','512mb','APP_DISK_SIZE','Y',0,'admin','2018-09-27 09:11:09','2018-09-27 09:13:02'),(154,'768','768','768mb','APP_DISK_SIZE','Y',4,'admin','2018-09-27 09:11:46','2018-09-27 09:11:46'),(155,'max_size','1024','1024mb','APP_DISK_SIZE','Y',0,'admin','2018-09-27 09:12:07','2018-09-27 09:12:48'),(156,'min_size','1','Min Instances','APP_INSTANCE_SIZE','Y',0,'admin','2018-09-27 09:13:57','2022-02-03 00:55:39'),(157,'max_size','100','Max Instances','APP_INSTANCE_SIZE','Y',0,'admin','2018-09-27 09:14:11','2022-02-03 00:55:25'),(158,'max_size','2048','Max Memory','APP_MEMORY_SIZE','Y',0,'admin','2018-09-27 09:14:11','2018-09-27 09:14:22'),(164,'MARKET_PLACE_URL','http://marketplace-webuser.xxx.xxx.xxx.xxx.xip.io','MarketPlace_user','MARKET_PLACE_URL','N',0,'admin','2019-10-28 09:52:06','2019-11-04 09:28:32'),(165,'MARKET_ADMIN_URL','http://marketplace-webuser.xxx.xxx.xxx.xxx.xip.io','MarketPlace_admin','MARKET_ADMIN_URL','N',0,'admin','2019-10-28 09:52:06','2019-11-04 09:28:32');
/* CAMBODIA */
COMMIT;

-- ----------------------------
-- Table structure for code_group
-- ----------------------------
DROP TABLE IF EXISTS `code_group`;
CREATE TABLE `code_group` (
  `id` varchar(35) NOT NULL,
  `name` text NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  `user_id` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code_group
-- ----------------------------
BEGIN;
/* CAMBODIA */
INSERT INTO `code_group` VALUES ('USER_AUTOSCAILE','Autoscaling','2016-07-26 01:43:43','2018-04-05 11:00:03','admin'),('USER_STATUS','User status','2016-08-02 04:50:15','2016-08-02 04:50:15','admin'),('SERVICE_PACK_CATALOG','Service catalog','2016-07-25 17:03:16','2022-01-27 07:29:02','admin'),('BUILD_PACK_CATALOG','App development environment catalog','2016-07-25 17:03:16','2016-08-23 03:41:16','admin'),('QUESTION_STATUS','Answer status code','2016-08-24 13:10:39','2016-08-24 13:10:39','admin'),('DOCUMENTS_CLASSIFICATION','Document classification code','2016-09-01 13:43:04','2018-04-05 11:00:00','admin'),('ORG_ROLES','Organization Role','2016-09-02 01:16:18','2016-09-02 01:16:18','admin'),('QUESTION_CLASSIFICATION','Inquiry Classification Code','2016-08-24 09:38:21','2016-08-24 09:38:21','admin'),('SUPPORT_NOTICE','Notice classification code','2016-08-24 09:42:12','2016-08-24 10:14:05','admin'),('APP_MEMORY_SIZE','App memory size','2016-12-05 15:20:48','2018-04-05 18:00:52','admin'),('STARTER_CATALOG','Starter development environment catalog','2018-04-06 13:56:09','2018-04-06 13:56:12','admin'),('APP_DISK_SIZE','App disk size','2018-09-27 09:10:06','2018-09-27 09:10:06','admin'),('APP_INSTANCE_SIZE','App instance size','2018-09-27 09:13:41','2018-09-27 09:13:41','admin'),('MARKET_PLACE_URL','Marketplace URL','2019-10-28 09:51:58','2019-11-04 09:28:02','admin'),('MARKET_ADMIN_URL','Marketplace Admin URL','2019-10-29 09:51:58','2019-11-06 09:28:02','admin'),('test','test ','2022-01-27 07:29:44','2022-01-27 07:29:54','admin');
/* CAMBODIA */
COMMIT;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info` (
  `name` varchar(128) NOT NULL,
  `value` varchar(128) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config_info
-- ----------------------------
BEGIN;
INSERT INTO `config_info` VALUES ('email_auth_yn', '', NULL, '2018-02-23 14:16:35');
INSERT INTO `config_info` VALUES ('smtp_url', '', NULL, '2018-06-01 02:07:10');
INSERT INTO `config_info` VALUES ('web_ide_url', '', NULL, '2018-06-01 02:07:13');
INSERT INTO `config_info` VALUES ('api_url', '', NULL, '2018-06-01 02:19:01');
INSERT INTO `config_info` VALUES ('uaa_url', '', NULL, '2018-06-01 02:19:05');
INSERT INTO `config_info` VALUES ('user_portal_url', '', NULL, '2018-06-01 02:07:07');
COMMIT;

-- ----------------------------
-- Table structure for documents
-- ----------------------------
DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `user_id` varchar(128) NOT NULL,
  `classification` varchar(36) NOT NULL,
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  `content` longtext,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` text,
  `file_size` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for history_store
-- ----------------------------
DROP TABLE IF EXISTS `history_store`;
CREATE TABLE `history_store` (
  `timemark` datetime NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `pk_date_src` text NOT NULL,
  `pk_date_dest` text NOT NULL,
  `record_state` smallint(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for invite_org_space
-- ----------------------------
DROP TABLE IF EXISTS `invite_org_space`;
CREATE TABLE `invite_org_space` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id of invite org-space user table (auto increment)',
  `token` varchar(128) NOT NULL COMMENT 'inviting org id ',
  `gubun` varchar(128) NOT NULL,
  `invite_id` bigint(20) NOT NULL COMMENT 'inviting user id',
  `role_name` varchar(128) NOT NULL COMMENT 'org role permisson(OrgManager(4) / BillingManager(2) / OrgAuditor(1))',
  `invite_user_id` varchar(256) NOT NULL COMMENT 'space role permisson(JSON type, {"spaceName": (number : SpaceManager(4) / SpaceDeveloper(2) / SpaceAuditor(1)) })',
  `user_id` varchar(128) NOT NULL COMMENT 'recommended user id recently',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'updated at (update time)',
  `access_cnt` bigint(20) NOT NULL DEFAULT '0' COMMENT 'inviting count',
  `invite_name` varchar(128) NOT NULL,
  `setyn` varchar(1) NOT NULL DEFAULT 'N' COMMENT 'answer check for inviting user',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for invite_user
-- ----------------------------
DROP TABLE IF EXISTS `invite_user`;
CREATE TABLE `invite_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id of invite org-space user table (auto increment)',
  `user_id` varchar(128) NOT NULL,
  `gubun` varchar(8) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `token` varchar(128) NOT NULL,
  `role` text NOT NULL,
  `org_guid` varchar(100) NOT NULL,
  `invite_name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `parent_no` int(11) NOT NULL,
  `sort_no` int(11) NOT NULL,
  `menu_name` varchar(255) NOT NULL,
  `menu_path` text NOT NULL,
  `image_path` text,
  `open_window_yn` varchar(1) NOT NULL DEFAULT 'N',
  `login_yn` varchar(1) NOT NULL DEFAULT 'Y',
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  `description` longtext,
  `user_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=1937 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
/* CAMBODIA */
INSERT INTO `menu` VALUES (1,0,1,'대시보드','/org/orgMain',NULL,'N','Y','Y',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:45'),(1802,1,1,'MENU','#',NULL,'N','N','N',NULL,'admin','2016-11-18 11:20:50','2018-01-31 05:30:45'),(110,2,3,'menu 1','#',NULL,'N','N','N',NULL,'admin','2016-10-06 15:29:55','2018-01-31 05:30:45'),(111,2,2,'test 2-2','#',NULL,'N','N','N',NULL,'admin','2016-10-06 15:34:18','2018-01-31 05:30:45'),(8,2,4,'menu 2','#',NULL,'Y','N','N',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:45'),(7,2,1,'test 2-1','#',NULL,'Y','N','N',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:45'),(3,0,3,'도움말','https://github.com/PaaS-TA/Guide-2.0-Linguine-',NULL,'Y','Y','Y',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:46'),(2,0,2,'카탈로그','/catalog/catalogMain',NULL,'N','Y','Y',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:46'),(9,5,1,'test 5-1','#',NULL,'Y','N','N',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:46'),(5,0,4,'문서','/documents/documentsMain',NULL,'N','Y','Y',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:46'),(704,6,1,'MENU','#',NULL,'N','N','N',NULL,'admin','2016-10-18 05:25:37','2018-01-31 05:30:46'),(10,5,2,'test 5-2','#',NULL,'Y','N','N',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:46'),(6,0,5,'공지','/notice/noticeMain',NULL,'N','Y','Y',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:46'),(4,0,6,'커뮤니티','/board/boardMain',NULL,'N','Y','Y',NULL,'admin','2016-09-29 02:30:28','2018-01-31 05:30:46'),(559,0,7,'NEW_MAIN','/usage/testMain',NULL,'N','N','N',NULL,'admin','2016-10-14 05:22:30','2018-01-31 05:30:46'),(1702,0,8,'NEW_CATALOG','/catalog/catalogTestMain',NULL,'N','N','N',NULL,'admin','2016-11-17 15:08:13','2018-01-31 05:30:46'),(1936,0,10,'MENU22','#',NULL,'N','Y','N',NULL,'admin','2016-12-05 14:42:38','2018-01-31 05:30:46'),(1935,0,9,'MENU','#',NULL,'N','Y','N',NULL,'admin','2016-12-05 14:21:33','2018-01-31 05:30:46');
/* CAMBODIA */
COMMIT;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `important` varchar(5) NOT NULL,
  `classification` varchar(36) NOT NULL,
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  `content` longtext,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` text,
  `file_size` bigint(20) DEFAULT NULL,
  `start_date` varchar(20) NOT NULL,
  `end_date` varchar(20) NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------
BEGIN;
INSERT INTO `notice` VALUES (128, 'PaaS-TA 오픈 안내', 'true', 'notice_notice', 'Y', 'PaaS-TA 오픈 안내', 'PaaSTA 포털 코딩룰.docx', 'http://52.201.48.51:8080/v1/KEY_84586dfdc15e4f8b9c2a8e8090ed9810/portal-container/deff0f4dccd141368235b7e16fafa59d.docx', 83869, '2016/09/02', '2016/10/31', '2016-09-02 13:29:19', '2016-09-02 14:39:23');
COMMIT;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `classification` varchar(36) NOT NULL,
  `user_id` varchar(128) NOT NULL,
  `content` longtext NOT NULL,
  `cell_phone` varchar(11) DEFAULT NULL,
  `status` varchar(8) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` text,
  `file_size` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for servicepack_category
-- ----------------------------
DROP TABLE IF EXISTS `servicepack_category`;
CREATE TABLE `servicepack_category`  (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `classification` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `thumb_img_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `thumb_img_path` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `use_yn` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y',
  `user_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` datetime(0) NOT NULL,
  `lastmodified` datetime(0) NULL DEFAULT NULL,
  `parameter` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `app_bind_parameter` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `dashboard_use_yn` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `app_bind_yn` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `doc_file_url` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tags_param` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `on_demand_yn` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`no`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 37909 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of servicepack_category
-- ----------------------------
BEGIN;
/* CAMBODIA */
INSERT INTO `servicepack_category` VALUES (1756,'Redis Service','service_nosql','Redis NoSQL and In-memory Services','<p>Redis is a memory-based key/value store that is divided into NoSQL DBMS and in-memory solutions.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>Redis dedicated-node (2 units) and Redis service broker are the minimum configuration.&nbsp;<a href=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/images/redis/redis_image_01.png\" target=\"_blank\"><img alt=\"시스템 구성도\" src=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/raw/v3.5/Service-Guide/images/redis/redis_image_01.png\" /></a></p>\n','NONE','redis.jpg','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/e8aefaf4651f4161b72bf4ec6c95973d-1540343350521-cmVkaXM_Pz8uanBn','N','admin','2016-07-22 14:45:36','2022-02-03 02:50:14','','{\"app_guid\":\"default\"}','N','Y','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/NoSQL/PaaS-TA%20Redis%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','Y'),(8,'Mongo-DB DBMS Service','service_nosql','Mongo-DB document-oriented NoSQL DBMS','<p>MongoDB is a cross-platform document-oriented database system. Classified as a NoSQL database, MongoDB refrains from using traditional table-based relational database structures in favor of dynamic schema-type documents such as JSON.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>The minimum is configured with Mongodb Server and Mongodb service broker.</p>\n\n<p><a href=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/images/mongodb/mongodb_image_02.png\" target=\"_blank\"><img alt=\"시스템구성도\" src=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/raw/v3.5/Service-Guide/images/mongodb/mongodb_image_02.png\" /></a></p>\n','NONE','mongodb.png','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/0fbc26eb6758499fa1dc8348ae08cd02-1538035477338-bW9uZ29kYi5wbmc%3D','N','admin','2016-07-19 11:12:45','2022-02-03 02:51:50','','{}','N','Y','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/NoSQL/PaaS-TA%20Mongodb%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(1130,'RabbitMQ Message Queue Service','service_message','RabbitMQ is an asynchronous message queue implementing AMQP','<p>It is an open source asynchronous message-oriented middleware using AMQP (Advanced Message Queuing Protocol).</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>RabbitMQ (1 unit), RabbitMQ service broker, and haproxy are the minimum components</p>\n\n<p>.</p>\n\n<p><a href=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/images/rabbitmq/rabbitmq_image_01.png\" target=\"_blank\"><img alt=\"시스템 구성도\" src=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/raw/v3.5/Service-Guide/images/rabbitmq/rabbitmq_image_01.png\" /></a></p>\n\n<table>\n  <tbody>\n   <tr>\n      <td>구분</td>\n     <td>스펙</td>\n   </tr>\n </tbody>\n</table>\n','NONE','rabbitmq.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/1f1740682d7043158fd865dc3c61d626-1538035486131-cmFiYml0bXEuanBn','N','admin','2016-07-22 10:50:06','2022-02-03 02:51:00','','{}','N','Y','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/MessageQueue/PaaS-TA%20RabbitMQ%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(3126,'Java App APM Service','service_monitoring','Analyze Java application large-scale distributed system performance','<p>Pinpoint is a platform that analyzes the performance of large-scale distributed Java applications and diagnoses and handles problems.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>Pinpoint Server, HBase Master2 of HBase, HBase Slave2, Collector 2, Pinpoint Service Broker, WebUI3 is the minimum configuration.</p>\n\n<p><a href=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/images/pinpoint/pinpoint-image1.png\" target=\"_blank\"><img alt=\"시스템구성도\" src=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/raw/v3.5/Service-Guide/images/pinpoint/pinpoint-image1.png\" /></a></p>\n','NONE','pinpoint.jpg','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/df5dd461616f4163962c99c1b8299351-1541736160529-cGlucG9pbnQ_Pz8uanBn','N','admin','2016-07-26 05:50:50','2022-02-03 02:48:02','','{\"application_name\":\"text\"}','Y','Y','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/ETC/PaaS-TA%20Pinpoint%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(37908,'Swift object storage service','service_storage','Swift object storage service','<h1>Swift Service for PaaS-TA</h1>\n\n<p>Swift object storage service.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>The minimum is configured with Mysql Server and GlusterFS service broker, and the service backend is configured externally.&nbsp;<a href=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/images/glusterfs/glusterfs_image_01.png\" target=\"_blank\"><img alt=\"시스템 구성도\" src=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/raw/v3.5/Service-Guide/images/glusterfs/glusterfs_image_01.png\" /></a></p>\n','NONE','glusterfs.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/8bbceec2a28545f29cd738099ebe62cc-1540343303709-Pz8_Pz8_Pz8ucG5n','N','admin','2018-09-27 08:01:06','2022-02-03 02:44:08','','{}','N','Y','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/Storage/PaaS-TA%20GlusterFS%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C.md','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}','N'),(37869,'Pipeline Service','dev_ops','Pipeline Service for development','<p>Pipelines built for development</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>The minimum is configured as a distribution pipeline server and a distribution pipeline service broker.</p>\n\n<p>&nbsp;<a href=\"https://github.com/PaaS-TA/application-platform-guide/raw/CAMBODIA/install/service/images/pipeline/Delivery_Pipeline_Architecture_ENG.jpg\" target=\"_blank\"><img alt=\"1-1-3\" src=\"https://github.com/PaaS-TA/application-platform-guide/raw/CAMBODIA/install/service/images/pipeline/Delivery_Pipeline_Architecture_ENG.jpg\" style=\"float:left; height:223px; width:500px\" /></a></p>\n','NONE','pipeline.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/b31c5290c6924b5791da9eca92c6056e-1540343408129-cGlwZWxpbmUucG5n','N','admin','2018-01-04 05:10:24','2022-02-03 02:45:42','{\"owner\":\"default\"}','{}','Y','N','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/Tools/PaaS-TA%20%EB%B0%B0%ED%8F%AC%20%ED%8C%8C%EC%9D%B4%ED%94%84%EB%9D%BC%EC%9D%B8%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C_v1.0.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(3124,'CUBRID DBMS Service','service_rdbms','CUBRID RDBMS Service','<p>As a relational DBMS, Kubrid provides large data processing capacity, performance, stability, availability, and management convenience required in the enterprise market.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>The minimum requirements are configured as Cubrid Server and Cubrid service broker.</p>\n\n<p><br />\n<a href=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/images/cubrid/1-3-0-0.png\" target=\"_blank\"><img alt=\"시스템 구성도\" src=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/raw/v3.5/Service-Guide/images/cubrid/1-3-0-0.png\" /></a></p>\n','NONE','cubrid.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/ef016125492f4109ac53a2a292786b57-1538035500991-Pz8_Pz8_LmpwZw%3D%3D','N','admin','2016-07-26 05:44:57','2022-02-03 02:48:45','','{}','N','Y','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/DBMS/PaaS-TA%20Cubrid%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(37866,'Source Control Service','dev_ops','Source Control Service','<p>We provide GIT and SVN repositories as source&nbsp;management services.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>The minimum items are configured as source&nbsp; management server and service broker.</p>&nbsp;<a href=\"https://github.com/PaaS-TA/application-platform-guide/raw/CAMBODIA/install/service/images/source-control/source_controller_Service_Guide_ENG.png\" target=\"_blank\"><img alt=\"source_controller_Service_Guide01\" src=\"https://github.com/PaaS-TA/application-platform-guide/raw/CAMBODIA/install/service/images/source-control/source_controller_Service_Guide_ENG.png\" /></a></p>\n','NONE','scm.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/5cf601dc55e74d84909f6e774e3b6bec-1540343334396-c2NtLnBuZw%3D%3D','N','admin','2017-11-24 16:27:33','2022-02-03 02:47:11','{\"owner\":\"default\",\"org_name\":\"default\"}','{}','Y','N','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/Tools/PaaS-TA%20%ED%98%95%EC%83%81%EA%B4%80%EB%A6%AC%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C_v1.0.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(3123,'Mysql DBMS Service','service_rdbms','Mysql RDBMS Service','<p>MySQL is the most widely used open source relational database management system (RDBMS) and is a multi-threaded, multi-user structured query language database management system.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>The minimum is configured with MySQL Server, MySQL Service Broker, and Proxy.</p>\n\n<p><a href=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/images/mysql/mysql_vsphere_1.3.01.png\" target=\"_blank\"><img alt=\"시스템구성도\" src=\"https://github.com/PaaS-TA/Guide-3.0-Penne-/raw/v3.5/Service-Guide/images/mysql/mysql_vsphere_1.3.01.png\" /></a></p>\n','NONE','mysqldb.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/0cb3e10754564e2882b4567f6085184f-1540343376813-bXlzcWxkYi5wbmc%3D','N','admin','2016-07-26 04:32:32','2022-02-03 02:49:18','{\"test\":\"text\"}','{}','N','Y','https://github.com/PaaS-TA/Guide-3.0-Penne-/blob/v3.5/Service-Guide/DBMS/PaaS-TA%20MySQL%20%EC%84%9C%EB%B9%84%EC%8A%A4%ED%8C%A9%20%EC%84%A4%EC%B9%98%20%EA%B0%80%EC%9D%B4%EB%93%9C.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(37907,'CaaS Service','dev_ops','CAAS Service Broker','<h1>CaaS Service broker for PaaS-TA</h1>\n\n<p>CaaS</p>\n\n<p>service broker provides CaaS services as PaaS-TA services.</p>\n\n<p>This service broker responds to Kubernetes among CaaS services, and shows the v2 service API between the cloud controller and the service broker. This API should not be confused with the Cloud Controller API.</p>\n\n<p>This broker does not contain any CaaS servers or CaaS releases. Instead, it means deploying a CaaS Java broker that manages the services of a CaaS server.</p>\n\n<p>CaaS service broker refers to providing services between a CaaS server and PaaS-TA (Cloud Foundry), and does not support CaaS server applications that run independently.</p>\n\n<p>CaaS management tasks performed by this broker include:</p>\n\n<p>ㆍ Catalog registration of CaaS service<br />\nㆍ Create CaaS instance provisioning (create namespace and user)<br />\nㆍ CaaS Instance Provisioning Plan Renewal<br />\nㆍ Deprovisioning CaaS Instances (Deleting Users and Namespaces)</p>\n\n<p>This broker does not provide binding/unbinding to CaaS services. If you refer to the API development guide in the Service Pack Development Guide, you can learn more about the architecture, technology, implementation and development</p>\n\n<ul>\n  <li>.</li>\n</ul>\n','NONE','caas.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/9aa14ac5bdb242abb5bbfe2ff5819f2c-1540343318325-Y2Fhcy5wbmc%3D','N','admin','2018-08-17 05:26:01','2022-02-03 02:44:47','{\"owner\":\"default\"}','{}','Y','N','https://github.com/PaaS-TA/PAAS-TA-CAAS-SERVICE-BROKER','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(37911,'App Lifecycle Service','dev_ops','App Lifecycle Service','<p>TAIGA, which provides systematic agile development support and communication-oriented document and knowledge sharing support functions necessary for project collaboration, is provided in a dedicated way.</p>\n\n<p><strong>The service administrator account is serviceadmin /&lt;Password entered when applying for service&gt;.</strong></p>\n','NONE','taiga_logo.png','http://10.30.56.2:10008/v1/AUTH_567d37085272431bb6de5cf37e295439/portal-container/eab86a992fb64972b2e52ed1ca52cd41-1572861633073-dGFpZ2FfbG9nby5wbmc%3D','N','admin','2019-11-04 09:55:54','2022-02-03 02:33:57','{\"password\":\"password\"}','{}','Y','N','https://github.com/PaaS-TA/PAAS-TA-APP-LIFECYCLE-SERVICE-BROKER','{\"paas-ta\":\"colors1\",\"free\":\"colors2\"}','N'),(37909,'CaaS Jenkins Service','service_storage','CaaS Jenkins Service','<h1>Jenkins User Guide</h1>\n\n<p>Welcome to the Jenkins user documentation for those who want to use it. Existing and plugin features in Jenkins</p>\n\n<p>To develop your own Jenkins plugins to extend the capabilities of Jenkins, see Extending Jenkins (Developer Documentation).</p>\n\n<h2>What is Jenkins?</h2>\n\n<p>Jenkins is an independent, open-source automation server that can be used to automate any kind of task related to building, testing, serving, or deploying software.</p>\n\n<p>Jenkins can also be installed via native system packages, Docker, or run standalone on any machine with Java Runtime Environment (JRE) installed.</p>\n\n<h2>About this document</h2>\n\n<p>This article starts with a guided tour of getting Jenkins up and running and introducing Jenkins&#39; main feature, the pipeline.</p>\n\n<p>There are also tutorials aimed at developers who want to orchestrate and automate their projects in Jenkins using Pipelines and Blue Ocean.</p>\n\n<p>If you&#39;ve never used Jenkins or have limited Jenkins experience, we recommend starting with guided tours and introductory tutorials.</p>\n\n<p>For more information on using Jenkins, see the user guide.</p>\n\n<h3>Documentation scope</h3>\n\n<p>Jenkins is a highly extensible product that allows you to extend its functionality through the installation of plugins.</p>\n\n<p>There are various plugins available for Jenkins. However, the documentation covered in the Guided Tour, Tutorials, Solution pages and User Handbook of this document is based on a Jenkins installation with Blue Ocean plugin installed and &quot;suggested plugins&quot; specified when running via Post. Installation setup wizard.</p>\n\n<hr /><!-- HTML inclusion for chapter and section layouts (i.e. as footers) as well as\n     for use in AsciiDoc file inclusions. --><!--\nThis feedback form was prepared from a Google Form, based on the techniques in\nthe following documentation sources:\nhttps://codepen.io/learningcode/post/customize-a-google-form-for-your-website,\nhttps://mrhaki.blogspot.com.au/2014/06/awesome-asciidoc-include-raw-html.html,\nhttps://www.freshtechtips.com/2013/05/custom-google-drive-contact-form.html,\nhttps://stackoverflow.com/questions/24436165/set-value-of-hidden-input-inside-form\n--><!-- Feedback form functionality in JavaScript - refer to comments in this file\n     for details on the functionality. -->\n<p><a href=\"#feedback\">Was this page helpful?</a></p>\n\n<p>Please send us your comments on this page through this quick form.</p>\n\n<p>If you don&#39;t want to fill out the quick form, just mark this page as helpful.</p>\n<!-- Redirects to custom \"thank you\" page once form is submitted. --><!-- Set the value of the current URL into the form. -->\n\n<p>&nbsp;</p>\n<!-- The answer bit -->\n\n<p>Yes&nbsp;&nbsp;&nbsp;&nbsp; No</p>\n\n<p>&nbsp;</p>\n<!-- The CAPTCHA bit -->\n\n<p>Please enter your answers to 5+8 before clicking &quot;Submit&quot; below.</p>\n\n<p>&nbsp;</p>\n<!-- Submit button -->\n\n<p>&nbsp;</p>\n\n<p>See existing comments. <a href=\"https://docs.google.com/spreadsheets/d/1IIdpVs39JDYKg0sLQIv-MNO928qcGApAIfdW5ohfD78\" target=\"_blank\">here</a>.</p>\n','NONE','jenkins.png','http://10.174.7.35:10008/v1/AUTH_697702d44fed4b62953c9b86054f7c95/portal-container/348dc01e27fe4326af5db1327a23ab58-1574835878026-amVua2lucy5wbmc%3D','N','admin','2019-11-27 06:24:38','2022-02-03 02:43:05','','{}','Y','N','https://github.com/PaaS-TA/PAAS-TA-CAAS-JENKINS-BROKER','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}','N'),(37912,'Application Gateway Service','dev_ops','Application Gateway Service','<p>We provide WSO2 service, an application gateway service that provides functions such as API registration and API lifecycle management, in a dedicated way.</p>\n\n<p><strong>The service administrator account is serviceadmin /&lt;Password entered when applying for service&gt;.</strong></p>\n','NONE','gateway.png','http://10.30.56.2:10008/v1/AUTH_567d37085272431bb6de5cf37e295439/portal-container/eab86a992fb64972b2e52ed1ca52cd41-1572861633073-dGFpZ2FfbG9nby5wbmc%3D','N','admin','2019-11-04 09:55:54','2022-02-03 02:32:41','{\"password\":\"password\"}','{}','Y','N','https://github.com/PaaS-TA/PAAS-TA-API-GATEWAY-SERVICE-BROKER','{\"paas-ta\":\"colors1\",\"free\":\"colors2\"}','N'),(37920,'Container Platform Admin Portal Service','dev_ops','Container Platform Admin Portal Service','<h1>Container Platform Admin Portal Service Broker for PaaS-TA</h1>\n\n<p>The Container Platform Admin Portal service broker provides the Container Platform Operator Portal as a PaaS-TA service.</p>\n\n<p>This service broker is Kubernetes-aware and exposes the v2 service API between Cloud Controller and Service Broker. This API should not be confused with the Cloud Controller API.</p>\n\n<p>In this broker we mean deploying the Container Platform Admin Portal Java Broker, which manages the services of the Container Platform Operator Portal Server.</p>\n\n<p>The Container Platform Admin Portal service broker provides services between the Container Platform Operator Portal Server and PaaS-TA (Cloud Foundry), and does not support the standalone Container Platform Operator Portal Server application.</p>\n\n<p>Container platform operator portal administration tasks performed by this broker include:</p>\n\n<p>ㆍ Catalog Registration of Container Platform Operator Portal Service<br />\nㆍ Create Container Platform Operator Portal Instance Provisioning (Create User)<br />\nㆍ Renewal of Container Platform Operator Portal Instance Provisioning Plan<br />\nㆍ Deprovisioning Container Platform Operator Portal Instance (Delete User)</p>\n\n<p>This broker does not provide binding/unbinding to the Container Platform Operator Portal service. If you refer to the API development guide in the Service Pack Development Guide, you can learn more about the architecture, technology, implementation and development.</p>\n','NONE','caas.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/9aa14ac5bdb242abb5bbfe2ff5819f2c-1540343318325-Y2Fhcy5wbmc%3D','N','admin','2018-08-17 05:26:01','2022-02-03 02:31:33','{\"owner\":\"default\",\"org_name\":\"default\",\"space_name\":\"default\"}','{}','Y','N','https://github.com/PaaS-TA/container-platform-portal-service-broker','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(37922,'Container Platform User Portal Service','dev_ops','Container Platform User Portal Service','<h1>Container Platform User Portal Service Broker for PaaS-TA</h1>\n\n<p>The Container Platform User Portal service broker provides the Container Platform User Portal as a PaaS-TA.</p>\n\n<p><br />\nThis service broker is Kubernetes-aware and exposes the v2 service API between Cloud Controller and Service Broker. This API should not be confused with the Cloud Controller API.</p>\n\n<p>In this broker, we mean deploying the Container Platform User Portal Java Broker, which manages the services of the Container Platform User Portal Server.</p>\n\n<p>The Container Platform User Portal service broker provides services between the Container Platform User Portal Server and PaaS-TA (Cloud Foundry), and does not support independently running Container Platform User Portal Server applications.</p>\n\n<p>Container platform user portal administration tasks performed by this broker include:</p>\n\n<p>ㆍ Catalog Registration of Container Platform User Portal Service<br />\nㆍ Create container platform user portal instance provisioning (create namespace and user)<br />\nㆍ Renewal of Container Platform User Portal Instance Provisioning Plan<br />\nㆍ Deprovisioning Container Platform User Portal Instance (Delete User and Namespace)</p>\n\n<p>This broker does not provide binding/unbinding to the Container Platform User Portal service. If you refer to the API development guide in the Service Pack Development Guide, you can learn more about the architecture, technology, implementation and development.</p>\n','NONE','caas.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/9aa14ac5bdb242abb5bbfe2ff5819f2c-1540343318325-Y2Fhcy5wbmc%3D','N','admin','2018-08-17 05:26:01','2022-02-03 02:30:42','{\"owner\":\"default\",\"org_name\":\"default\",\"space_name\":\"default\"}','{}','Y','N','https://github.com/PaaS-TA/container-platform-portal-service-broker','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(40100,'Container Platform Pipeline','dev_ops','Container platform pipeline built for development.','<p>A container platform pipeline built for development.</p>\n\n<p><br />\nSystem Diagram</p>\n\n<p>The minimum is configured as a pipeline server and distribution pipeline service broker.</p>\n\n<p>&nbsp;<a href=\"https://github.com/PaaS-TA/container-platform-pipeline-release/blob/master/pipeline/Container_Platform_Pipeline_Diagram.PNG?raw=true\" target=\"_blank\"><img alt=\"1-1-3\" src=\"https://github.com/PaaS-TA/container-platform-pipeline-release/blob/master/pipeline/Container_Platform_Pipeline_Diagram.PNG?raw=true\" style=\"float:left; height:223px; width:400px\" /></a></p>\n','NONE','pipeline.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/b31c5290c6924b5791da9eca92c6056e-1540343408129-cGlwZWxpbmUucG5n','N','admin','2018-01-04 05:10:24','2022-02-03 02:29:49','{\"owner\":\"default\"}','{}','Y','N','https://github.com/PaaS-TA/paas-ta-container-platform/blob/master/use-guide/service/container-platform-pipeline-guide-v1.2.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N'),(40101,'Container Platform Source Control','dev_ops','Container Platform Source Control','<p>As a container platform configuration management service, we provide GIT and SVN repositories.</p>\n\n<h3>&nbsp;</h3>\n\n<p>System Diagram</p>\n\n<p>The minimum items are configured as configuration management server and configuration management service broker.&nbsp;<a href=\"https://github.com/PaaS-TA/container-platform-source-control-release/blob/master/source-control/SourceControl_Diagram.PNG?raw=true\" target=\"_blank\"><img alt=\"source_controller_Service_Guide01\" src=\"https://github.com/PaaS-TA/container-platform-source-control-release/blob/master/source-control/SourceControl_Diagram.PNG?raw=true\" /></a></p>\n','NONE','scm.png','http://10.30.107.212:10008/v1/KEY_004c50822d764bf5aca77e7ebf454d56/portal-container/5cf601dc55e74d84909f6e774e3b6bec-1540343334396-c2NtLnBuZw%3D%3D','N','admin','2017-11-24 16:27:33','2022-02-03 02:28:49','{\"owner\":\"default\",\"org_name\":\"default\"}','{}','Y','N','https://github.com/PaaS-TA/paas-ta-container-platform/blob/master/use-guide/service/container-platform-sourcecontrol-guide-v1.2.md','{\"paas-ta\":\"colors6\",\"free\":\"colors2\"}','N');
/* CAMBODIA */
COMMIT;

-- ----------------------------
-- Table structure for starter_buildpack_relation
-- ----------------------------
DROP TABLE IF EXISTS `starter_buildpack_relation`;
CREATE TABLE `starter_buildpack_relation` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `starter_category_no` int(11) NOT NULL,
  `buildpack_category_no` int(11) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=35785 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of starter_buildpack_relation
-- ----------------------------
BEGIN;
INSERT INTO `starter_buildpack_relation` VALUES (35783, 35644, 0);
INSERT INTO `starter_buildpack_relation` VALUES (31385, 31431, 20);
INSERT INTO `starter_buildpack_relation` VALUES (35641, 16893, 665);
INSERT INTO `starter_buildpack_relation` VALUES (82, 128, 3157);
INSERT INTO `starter_buildpack_relation` VALUES (9563, 9609, 3155);
INSERT INTO `starter_buildpack_relation` VALUES (35782, 127, 20);
INSERT INTO `starter_buildpack_relation` VALUES (31891, 31937, 20);
INSERT INTO `starter_buildpack_relation` VALUES (35599, 31937, 20);
INSERT INTO `starter_buildpack_relation` VALUES (35632, 0, 3161);
INSERT INTO `starter_buildpack_relation` VALUES (35631, 0, 19108);
INSERT INTO `starter_buildpack_relation` VALUES (35623, 0, 19109);
INSERT INTO `starter_buildpack_relation` VALUES (35621, 0, 19109);
INSERT INTO `starter_buildpack_relation` VALUES (35620, 0, 19109);
INSERT INTO `starter_buildpack_relation` VALUES (35749, 35659, 3160);
INSERT INTO `starter_buildpack_relation` VALUES (35727, 35727, 3160);
INSERT INTO `starter_buildpack_relation` VALUES (35784, 35730, 0);
INSERT INTO `starter_buildpack_relation` VALUES (35751, 35726, 0);
INSERT INTO `starter_buildpack_relation` VALUES (35753, 35729, 19161);
INSERT INTO `starter_buildpack_relation` VALUES (35781, 127, 20);
COMMIT;

-- ----------------------------
-- Table structure for starter_category
-- ----------------------------
DROP TABLE IF EXISTS `starter_category`;
CREATE TABLE `starter_category` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `classification` varchar(36) NOT NULL,
  `summary` varchar(255) NOT NULL,
  `description` longtext,
  `thumb_img_name` varchar(255) DEFAULT NULL,
  `thumb_img_path` text,
  `use_yn` varchar(1) NOT NULL DEFAULT 'Y',
  `user_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `lastmodified` datetime DEFAULT NULL,
  `tags_param` text,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=35731 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of starter_category
-- ----------------------------
BEGIN;
/* CAMBODIA */
INSERT INTO `starter_category` VALUES (128,'NodeJS + Mongo-DB App template','starter_main','NodeJS + Mongo-DB App template','NodeJS and No-SQL Mongo DB based web application execution environment template ','Node-mongodb.png','http://10.30.131.12:10008/v1/KEY_65a45a92376949e2a756e511e0d92d2b/portal-container/0d169298733b4cd0b73b270940b6d31c.png','N','admin','2016-07-20 14:55:42','2022-02-03 01:58:14','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}'),(9609,'eGov Framework Web Application Template','starter_main','eGov Framework Web Application Template','eGov Framework, Mysql DB, Redis and Object Storage based web application execution environment template ','egov.png','http://10.30.131.12:10008/v1/KEY_65a45a92376949e2a756e511e0d92d2b/portal-container/7272c77bc5234267b2b7e22bbbb0525a.png','N','admin','2016-08-22 07:18:29','2022-02-03 01:57:52','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}'),(127,'Java + Redis App template','starter_main','Java + Redis App template','Java8 Tomcat and Redis DB based web application execution environment template ','redis-java.jpg','http://10.30.107.112:10008/v1/KEY_28ffd3f738074f298c68de2e40c76d35/portal-container/c8baf82926c147c0b7e18ff403232e61-1537434189535-cmVkaXM_Pz8uanBn','N','admin','2016-07-20 14:54:38','2022-02-03 01:58:53','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}'),(31937,'Java default type app template','starter_main','Java and MySQL based web application execution environment template','Java and MySQL based web application execution environment template \n','java8.jpg','http://10.0.1.121:10008/v1/AUTH_e5ce8ad365f84c509684e3061ba715ad/portal-container/2ff6f29f5eb14e6a9aee9f84da5b849c-1643849432359-Pz84LmpwZw%3D%3D','N','admin','2016-11-09 01:06:29','2022-02-03 00:51:03','{\"paas-ta\":\"colors6\",\"free\":\"colors1\"}');
/* CAMBODIA */
COMMIT;

-- ----------------------------
-- Table structure for starter_servicepack_relation
-- ----------------------------
DROP TABLE IF EXISTS `starter_servicepack_relation`;
CREATE TABLE `starter_servicepack_relation` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `starter_category_no` int(11) NOT NULL,
  `servicepack_category_no` int(11) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=794482 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of starter_servicepack_relation
-- ----------------------------
BEGIN;
INSERT INTO `starter_servicepack_relation` VALUES (794480, 35644, 36498);
INSERT INTO `starter_servicepack_relation` VALUES (794219, 31431, 8);
INSERT INTO `starter_servicepack_relation` VALUES (794220, 31431, 3124);
INSERT INTO `starter_servicepack_relation` VALUES (794221, 31431, 3125);
INSERT INTO `starter_servicepack_relation` VALUES (794445, 35659, 3126);
INSERT INTO `starter_servicepack_relation` VALUES (794226, 128, 8);
INSERT INTO `starter_servicepack_relation` VALUES (794229, 9609, 1756);
INSERT INTO `starter_servicepack_relation` VALUES (794230, 9609, 3125);
INSERT INTO `starter_servicepack_relation` VALUES (794231, 9609, 3123);
INSERT INTO `starter_servicepack_relation` VALUES (794279, 0, 3124);
INSERT INTO `starter_servicepack_relation` VALUES (794278, 0, 37877);
INSERT INTO `starter_servicepack_relation` VALUES (794277, 0, 3126);
INSERT INTO `starter_servicepack_relation` VALUES (794276, 0, 3124);
INSERT INTO `starter_servicepack_relation` VALUES (794450, 35729, 37900);
INSERT INTO `starter_servicepack_relation` VALUES (794281, 0, 37877);
INSERT INTO `starter_servicepack_relation` VALUES (794280, 0, 3126);
INSERT INTO `starter_servicepack_relation` VALUES (35727, 35727, 3126);
INSERT INTO `starter_servicepack_relation` VALUES (794299, 16893, 3123);
INSERT INTO `starter_servicepack_relation` VALUES (794481, 35730, 37873);
INSERT INTO `starter_servicepack_relation` VALUES (794449, 35727, 3123);
INSERT INTO `starter_servicepack_relation` VALUES (794447, 35726, 37873);
INSERT INTO `starter_servicepack_relation` VALUES (794488, 127, 1756);
INSERT INTO `starter_servicepack_relation` VALUES (794489, 31937, 3123);
COMMIT;

-- ----------------------------
-- Table structure for user_detail
-- ----------------------------
DROP TABLE IF EXISTS `user_detail`;
CREATE TABLE `user_detail` (
  `user_id` varchar(128) NOT NULL,
  `status` varchar(8) NOT NULL,
  `tell_phone` varchar(11) DEFAULT NULL,
  `zip_code` varchar(15) DEFAULT NULL,
  `address` text,
  `address_detail` text,
  `user_name` varchar(128) DEFAULT NULL,
  `admin_yn` varchar(1) NOT NULL DEFAULT 'N',
  `refresh_token` varchar(128) DEFAULT NULL,
  `auth_access_cnt` double DEFAULT '0',
  `auth_access_time` date DEFAULT NULL,
  `img_path` text,
  `active` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_detail
-- ----------------------------
BEGIN;
/* CAMBODIA */
INSERT INTO `user_detail` VALUES ('admin','1','','','Open Cloud Platform Center, 7F, 39, Sejongdaero, Jung-gu, Seoul, 04513 Korea',NULL,'admin','Y',NULL,0,NULL,'http://115.68.46.218:10008/v1/KEY_eb08842a2fbc414c9d537006912705b2/portal-container/ce40ee519709419ea985f201dc0ec716-1533021594365-YTk0MjE2ODQwNjI3MjZlNjMwMGUyMWIyMjllYjNhNTcuZ2lm','Y'),('mhlee@irevit.com','0',NULL,NULL,NULL,NULL,'mhlee@irevit.com','N','AYE8RC9ZFRVRDYRHMHK',0,'2022-01-21',NULL,'N'),('dyoonnam@crossent.com','0',NULL,NULL,NULL,NULL,'dyoonnam@crossent.com','N','ZGL95EFMUMUDQ2J2CWB',0,'2022-01-21',NULL,'N'),('mhlee@irevit.co.kr','0','',NULL,'',NULL,'mhlee','N','',0,'2022-01-21',NULL,'Y'),('zinta@naver.com','1','',NULL,'',NULL,'zinta','N','2G5JYQIHP77A6SBEAPE',0,'2022-01-21',NULL,'Y'),('ski579579@naver.com','0',NULL,NULL,NULL,NULL,'ski579579@naver.com','N','9PNJ65IJGCASJRUABXV',0,'2022-01-21',NULL,'N'),('hayanZinta@gmail.com','0',NULL,NULL,NULL,NULL,'hayanZinta@gmail.com','N','YUFSZ8BCH2BZK7QPACZ',0,'2022-01-22',NULL,'N'),('dudfkd1223@gmail.com','0',NULL,NULL,NULL,NULL,'dudfkd1223@gmail.com','N','MEGVL0L9FA1HVSDSUDD',0,'2022-01-28',NULL,'N');
/* CAMBODIA */
COMMIT;

-- ----------------------------
-- Table structure for web_ide_user
-- ----------------------------
DROP TABLE IF EXISTS `web_ide_user`;
CREATE TABLE `web_ide_user` (
  `user_id` varchar(128) NOT NULL,
  `org_name` varchar(128) NOT NULL,
  `url` varchar(128) DEFAULT NULL,
  `use_yn` varchar(1) DEFAULT 'N',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`org_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;



USE `webconfig`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `infra_config`;
CREATE TABLE `infra_config`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `api_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uaa_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `authorization` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `caas_api_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `caas_authorization` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8; 

-- ----------------------------
-- Records of infra_config
-- ----------------------------
INSERT INTO `infra_config` VALUES (1, '<%= p("portal_default.name") %>', '<%= p("portal_default.url") %>', '<%= p("portal_default.uaa_url") %>', '<%= p("portal_default.header_auth") %>', '<%= p("portal_default.desc") %>', '', '');

SET FOREIGN_KEY_CHECKS = 1;
