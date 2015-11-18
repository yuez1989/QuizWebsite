
DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	usrID VARCHAR(255) primary key,
	password VARCHAR(64),
	createTime DATETIME,
	premission INT,
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
	score INT,
	review TEXT,
	rating INT,
	FOREIGN KEY (quizID) REFERENCES Quizzes(quizID),
	FOREIGN KEY (usrID) REFERENCES Users(usrID)
);


DROP TABLE IF EXISTS Tags;
CREATE TABLE Tags(
	tagsID VARCHAR(255),
	description TEXT,
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
	time DATETIME
);






