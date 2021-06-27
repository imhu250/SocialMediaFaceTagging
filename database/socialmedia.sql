/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.7.9 : Database - socialmedia
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`socialmedia` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `socialmedia`;

/*Table structure for table `friends` */

DROP TABLE IF EXISTS `friends`;

CREATE TABLE `friends` (
  `friend_id` int(11) NOT NULL AUTO_INCREMENT,
  `userid1` int(11) DEFAULT NULL,
  `userid2` int(11) DEFAULT NULL,
  PRIMARY KEY (`friend_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `friends` */

insert  into `friends`(`friend_id`,`userid1`,`userid2`) values (1,5,4),(2,10,5);

/*Table structure for table `images` */

DROP TABLE IF EXISTS `images`;

CREATE TABLE `images` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `path` varchar(1000) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `images` */

insert  into `images`(`image_id`,`user_id`,`path`,`date`,`status`) values (1,3,'static/uploads/00bf0b03-62e3-47f5-b37a-64d0ba4e3054check.jpg','2020-07-18','pending'),(2,2,'static/uploads/bd6cc290-b7aa-4cc3-b86f-01ffd23cda3asureshgopi.jpg','2020-07-18','pending'),(4,2,'static/uploads/532cc6df-f64b-4a76-8357-ceefa8197697prithviraj.jpg','2020-07-18','pending'),(5,7,'static/uploads/2093ded4-e1f4-420b-bf97-5f64f13a3eefIMG-20200723-WA0006.jpg','2020-07-24','pending'),(6,7,'static/uploads/5718c1ca-88de-4091-b7a8-e71859afabd9IMG-20200723-WA0006.jpg','2020-07-24','pending'),(7,8,'static/uploads/8373e848-fb94-4549-8b8c-5c3d8caaa49cIMG-20200723-WA0007.jpg','2020-07-25','pending'),(8,8,'static/uploads/02bca669-c2c8-44ea-bb72-43a55a6e3075IMG-20200724-WA0024.jpg','2020-08-15','pending'),(9,9,'static/uploads/6b93dbf2-d1cb-4c58-8025-1ff18558b380IMG-20200724-WA0024.jpg','2020-08-15','pending'),(10,8,'static/uploads/b82bf318-b18a-40fe-ba2e-dbdd00f3a9bfcheck.jpg','2020-08-15','pending');

/*Table structure for table `imageusers` */

DROP TABLE IF EXISTS `imageusers`;

CREATE TABLE `imageusers` (
  `image_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`image_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `imageusers` */

insert  into `imageusers`(`image_user_id`,`image_id`,`user_id`,`status`) values (1,1,2,'Upload'),(2,4,4,'pending'),(3,7,-1,'pending'),(4,8,-1,'pending'),(5,9,-1,'pending'),(6,10,2,'Upload');

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `usertype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`logid`,`username`,`password`,`usertype`) values (1,'admin','admin','admin'),(5,'prithvi','prithvi','user'),(3,'mohan','mohan','user'),(4,'mammootty','mammotty','user'),(6,'sandra','sandra','user'),(7,'aa','aa','user'),(8,'minnu','minnu','user'),(9,'gadha','gadha','user'),(10,'aafna','aafna','user'),(11,'achu','achu','user'),(12,'gadhass','gadhass','user');

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` int(11) DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `post` */

insert  into `post`(`post_id`,`image_id`,`users_id`) values (1,1,3),(2,1,2),(3,2,2),(5,4,2),(6,5,7),(7,6,7),(8,7,8),(9,8,8),(10,9,9),(11,10,8),(12,10,2);

/*Table structure for table `requests` */

DROP TABLE IF EXISTS `requests`;

CREATE TABLE `requests` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `requests` */

insert  into `requests`(`request_id`,`sender_id`,`receiver_id`,`date`,`status`) values (5,3,4,'2020-07-18','NA'),(6,2,4,'2020-07-22','NA'),(7,8,6,'2020-08-14','NA'),(8,8,4,'2020-08-14','NA'),(9,5,4,'2020-08-15','Accept'),(10,10,5,'2020-08-15','Accept');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_id` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `lname` varchar(500) DEFAULT NULL,
  `phone` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `place` varchar(500) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `profileimage` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`user_id`,`login_id`,`fname`,`lname`,`phone`,`email`,`place`,`gender`,`profileimage`) values (4,5,'prithviraj','s','7898769007','prithvi@gmail.com','ernakulam','male','static/profilepic/fa030f6c-775d-44a0-8aa4-20f221142063prithviraj.jpg'),(2,3,'mohanlal','s','8789987788','mohanlal@gmail.com','kochi','male','static/profilepic/f97206e0-0bfb-444e-b2f3-037806ce6317mohanlal.jpg'),(3,4,'mamootty','mammootty','8909877789','mammooty@gmail.com','koxhikode','male','static/profilepic/33322043-8917-4b60-9e75-defa3f924188mammootty.jpg'),(5,6,'sandra','s','8900008909','sandra@gmail.com','kochi','female','static/profilepic/356ba83a-9dcc-4ffb-b657-c916c0883959262dab56-d501-4672-a734-d45175dc0bb9test.jpg'),(6,7,'j','jjjk','9888888888','dsldf@efg.eg','kjn','male','static/profilepic/ec390565-e264-49cc-ba74-291738ad5217admin home.PNG'),(7,8,'minnu','kk','9087654321','minnu@gmail.com','alpy','female','static/profilepic/6c622e1f-dcab-4897-931d-881d5cda1be5IMG-20200723-WA0006.jpg'),(8,9,'gadha','s','9080765098','gadha@gmail.com','kannur','female','static/profilepic/98579e38-2050-4df9-a9f5-639a4868876fIMG-20200723-WA0006.jpg'),(9,10,'aafna','achu','9061632168','aafna@gmail.com','alappuzha','female','static/profilepic/07e112aa-21a2-4c0a-bc62-a3db33afd721IMG-20200814-WA0006.jpg'),(10,11,'aafna','achu','9061632169','achu@gmail.com','alappuzha','female','static/profilepic/fb147131-4191-4a00-814b-d516c072a3f6IMG-20200814-WA0004.jpg'),(11,12,'gadha','ss','9876509810','gadha123@gmail.com','kannur','female','static/profilepic/8e99881e-4dec-415e-91ad-0fa8660ab3c0IMG-20200814-WA0012.jpg');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
