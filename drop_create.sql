DROP TABLE IF EXISTS Friends;
DROP TABLE IF EXISTS Announcements;
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS AchievementRecords;
DROP TABLE IF EXISTS Histories;
DROP TABLE IF EXISTS ProblemBelongto;
DROP TABLE IF EXISTS Problems;
DROP TABLE IF EXISTS TagAssign;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Quizzes;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Achievements;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	usrID VARCHAR(255) primary key,
	password VARCHAR(64),
	createTime DATETIME,
	permission INT,
	imagepath VARCHAR(2047),
	privacy VARCHAR(10)
);

DROP TABLE IF EXISTS Messages;
CREATE TABLE Messages(
	fromID VARCHAR(255),
	toID VARCHAR(255),
	msg TEXT,
	time DATETIME,
	type VARCHAR(255),
	FOREIGN KEY (fromID) REFERENCES Users(usrID),
	FOREIGN KEY (toID) REFERENCES Users(usrID)
);

DROP TABLE IF EXISTS Achievements;
CREATE TABLE Achievements(
	achID VARCHAR(255),
	description TEXT,
	PRIMARY KEY (achID)
);

DROP TABLE IF EXISTS AchievementRecords;
CREATE TABLE AchievementRecords(
	usrID varchar(255),
	achID varchar(255),
	time DATETIME,
	FOREIGN KEY (usrID) REFERENCES Users(usrID),
	FOREIGN KEY (achID) REFERENCES Achievements(achID)
);

DROP TABLE IF EXISTS Quizzes;
CREATE TABLE Quizzes(
	quizID VARCHAR(255),
	name VARCHAR(1023),
	creator VARCHAR(255),
	createTime DATETIME,
	updateTime DATETIME,
	description TEXT,
	spec TEXT,
	PRIMARY KEY (quizID),
	FOREIGN KEY (creator) REFERENCES Users(usrID)
);

DROP TABLE IF EXISTS Histories;
CREATE TABLE Histories(
	quizID VARCHAR(255),
	usrID VARCHAR(255),
	playmode VARCHAR(255),
	start DATETIME,
	end DATETIME,
	score FLOAT,
	review TEXT,
	rating FLOAT,
	span INT,
	FOREIGN KEY (quizID) REFERENCES Quizzes(quizID),
	FOREIGN KEY (usrID) REFERENCES Users(usrID)
);

DROP TABLE IF EXISTS Tags;
CREATE TABLE Tags(
	tagsID VARCHAR(255),
	PRIMARY KEY (tagsID)
);

DROP TABLE IF EXISTS TagAssign;
CREATE TABLE TagAssign(
	tagsID VARCHAR(255),
	quizID VARCHAR(255),
	FOREIGN KEY (tagsID) REFERENCES Tags(tagsID),
	FOREIGN KEY (quizID) REFERENCES Quizzes(quizID)
);


DROP TABLE IF EXISTS Problems;
CREATE TABLE Problems(
	proID VARCHAR(255),
	description TEXT,
	picURL VARCHAR(255),
	type VARCHAR(255),
	createTime DATETIME,
	timed BIGINT(255),
	solution TEXT,
	solorder INT,
	PRIMARY KEY (proID)
);

DROP TABLE IF EXISTS ProblemBelongto;
CREATE TABLE ProblemBelongto(
	proID varchar(255),
	quizID varchar(255),
	FOREIGN KEY (proID) REFERENCES Problems(proID),
	FOREIGN KEY (quizID) REFERENCES Quizzes(quizID)
);

DROP TABLE IF EXISTS Announcements;
CREATE TABLE Announcements(
	announceID varchar(1024),
	content  TEXT,
	creatorID varchar(255),
	time DATETIME,
	FOREIGN KEY (creatorID) REFERENCES Users(usrID)
);

DROP TABLE IF EXISTS Friends;
CREATE TABLE Friends(
	usr1ID VARCHAR(255),
	usr2ID VARCHAR(255),
	time DATETIME,
	FOREIGN KEY (usr1ID) REFERENCES Users(usrID),
	FOREIGN KEY (usr2ID) REFERENCES Users(usrID)
);

INSERT INTO Users VALUES('create','86f7e437faa5a7fce15d1ddcb9eaeaea377667b8','2022-11-15 17:17:24',0,'','d');
INSERT INTO Users VALUES('testuser','86f7e437faa5a7fce15d1ddcb9eaeaea377667b8','2022-11-15 17:15:56',0,'','d');
INSERT INTO Users VALUES('xiaotihu','106ebf8ff07edb87f0b72963cf708c3266f7d709','2018-11-15 16:02:34',1,'','d');
INSERT INTO Users VALUES('xinhuiwu','106ebf8ff07edb87f0b72963cf708c3266f7d709','2018-11-15 14:58:09',1,'','d');
INSERT INTO Users VALUES('yuez1989','b9df230cfa9935168b9b81057a589a1e9d0b80a7','2022-11-15 17:14:36',0,'','d');
INSERT INTO Users VALUES('jinzhiwang','4a60cc4b5c3862b4a546379d68fb34f813b39750','2023-11-15 23:34:43',0,'','d');
INSERT INTO Users VALUES('yuezhang','1520804714ae7301ba1c39f5cf943f96c7b4786b','2018-11-15 15:57:50',0,'','d');


INSERT INTO Quizzes VALUES('xiaotihu2015-11-23 19:12:15','MC_quiz','xiaotihu','2015-11-23 19:12:15','2015-11-23 19:12:15','this quiz has MC for test!','I');
INSERT INTO Quizzes VALUES('xinhuiwu2015-11-18 15:17:30','random','xinhuiwu','2015-11-18 15:17:30','2015-11-18 15:17:30','fuck this shit','MI');
INSERT INTO Quizzes VALUES('xinhuiwu2015-11-18 16:19:13','haha','xinhuiwu','2015-11-18 16:19:13','2015-11-18 16:19:13','fuck this shit','MI'); 

INSERT INTO Tags VALUES('history');
INSERT INTO Tags VALUES('random');
INSERT INTO Tags VALUES('sports');
INSERT INTO Tags VALUES('test');

INSERT INTO TagAssign VALUES('test','xinhuiwu2015-11-18 15:17:30');
INSERT INTO TagAssign VALUES('random','xinhuiwu2015-11-18 15:17:30');
INSERT INTO TagAssign VALUES('history','xinhuiwu2015-11-18 16:19:13');
INSERT INTO TagAssign VALUES('sports','xinhuiwu2015-11-18 16:19:13');  

INSERT INTO Problems VALUES('xiaotihu1448331783449','Who\'s the first presidents in US?<option>George Washington</option><option>John Adams</option><option>Thomas Jefferson</option>','','MC','2015-11-23 23:04:23',0,'<ans-list><ans>A</ans></ans-list>',0);
INSERT INTO Problems VALUES('xiaotihu1448344148216','Where is Stanford?<option>NYC</option><option>Palo Alto</option><option>Boston</option>','','MC','2015-11-23 23:04:23',0,'<ans-list><ans>B</ans></ans-list>',0);
INSERT INTO Problems VALUES('xiaotihu1448346260149','Who teaches cs108?','','FREERESPONSE','2015-11-23 23:04:23',0,'<ans-list><ans>Young</ans><ans>Patrick</ans><ans>Patrick Young</ans></ans-list>',0);
INSERT INTO Problems VALUES('xiaotihu1448348595340','Match movie with director<option_left>Interstellar</option_left><option_left>Coherence</option_left><option_right>Nolan</option_right><option_right>James Ward Byrkit</option_right>','','MATCH','2015-11-23 23:04:23',0,'<ans-list><ans>A</ans></ans-list><ans-list><ans>B</ans></ans-list>',0);
INSERT INTO Problems VALUES('xinhuiwu1447887660533','Name the first five presidents in US?','','FREERESPONSE','015-11-18 16:19:13',0,'<ans-list><ans>George Washington</ans><ans>Washington</ans></ans-list><ans-list><ans>John Adams</ans><ans>Adams</ans></ans-list><ans-list><ans>Thomas Jefferson</ans><ans>Jefferson</ans></ans-list><ans-list><ans>James Madison</ans><ans>Madison</ans></ans-list><ans-list><ans>James Monroe</ans><ans>Monroe</ans></ans-list>',0);
INSERT INTO Problems VALUES('xinhuiwu1447887660561','3+5=?','','FREERESPONSE','2015-11-18 16:19:13',0,'<ans-list><ans>8</ans></ans-list>',0);
INSERT INTO Problems VALUES('xinhuiwu1447887660572','Who won the super bowl in 2015?','','FREERESPONSE','2015-11-18 16:19:13',0,'<ans-list><ans>New England Patriots</ans><ans>Patriots</ans><ans>New England</ans></ans-list>',0);
INSERT INTO Problems VALUES('xinhuiwu1447887660583','List first three letter in order','','FREERESPONSE','2015-11-18 16:19:13',0,'<ans-list><ans>A</ans><ans>a</ans></ans-list><ans-list><ans>b</ans><ans>B</ans></ans-list><ans-list><ans>C</ans><ans>c</ans></ans-list>',1);
INSERT INTO Problems VALUES('xinhuiwu1447887660635','List last three letter in order','','FREERESPONSE','2015-11-18 16:19:13',0,'<ans-list><ans>X</ans><ans>x</ans></ans-list><ans-list><ans>Y</ans><ans>y</ans></ans-list><ans-list><ans>Z</ans><ans>z</ans></ans-list>',1);

INSERT INTO ProblemBelongto VALUES('xinhuiwu1447887660533','xinhuiwu2015-11-18 16:19:13');
INSERT INTO ProblemBelongto VALUES('xinhuiwu1447887660561','xinhuiwu2015-11-18 16:19:13');
INSERT INTO ProblemBelongto VALUES('xinhuiwu1447887660572','xinhuiwu2015-11-18 16:19:13');
INSERT INTO ProblemBelongto VALUES('xinhuiwu1447887660583','xinhuiwu2015-11-18 16:19:13');
INSERT INTO ProblemBelongto VALUES('xinhuiwu1447887660635','xinhuiwu2015-11-18 16:19:13');
INSERT INTO ProblemBelongto VALUES('xiaotihu1448331783449','xiaotihu2015-11-23 19:12:15');
INSERT INTO ProblemBelongto VALUES('xiaotihu1448344148216','xiaotihu2015-11-23 19:12:15');
INSERT INTO ProblemBelongto VALUES('xiaotihu1448346260149','xiaotihu2015-11-23 19:12:15');
INSERT INTO ProblemBelongto VALUES('xiaotihu1448348595340','xiaotihu2015-11-23 19:12:15');

INSERT INTO Histories VALUES('xinhuiwu2015-11-18 15:17:30','xinhuiwu','Regular','2015-11-18 15:05:21','2015-11-18 15:15:21',4,'dope',4,600000);
INSERT INTO Histories VALUES('xinhuiwu2015-11-18 15:17:30','xinhuiwu','Regular','2015-11-18 15:15:21','2015-11-18 15:25:21',4,'nice',3,600000);
INSERT INTO Histories VALUES('xinhuiwu2015-11-18 16:19:13','xiaotihu','Regular','2015-11-18 17:05:21','2015-11-18 17:15:21',4,'sucks',1,600000);
INSERT INTO Histories VALUES('xinhuiwu2015-11-18 16:19:13','yuezhang','Regular','2015-11-18 17:05:21','2015-11-18 17:15:21',4,'not bad',4,600000);

INSERT INTO Friends VALUES('yuezhang','xiaotihu','2018-11-15 16:17:23');
INSERT INTO Friends VALUES('yuezhang','xinhuiwu','2018-11-15 16:17:23');



