DROP TABLE USERINFO;

CREATE TABLE USERINFO (
	email varchar2(100)	NOT NULL,
	password varchar2(100) NULL,
	gender varchar2(1) NULL,
	joindate date NULL,
	birthdate date NULL,
	username varchar2(100) NULL,
	visitdate date NULL,
	pwdate date NULL,
	addr varchar2(500) NULL,
	coinno number NULL,
	usercondition number(1) NULL
);

DROP TABLE DIARY;

CREATE TABLE DIARY (
	diaryno number	NOT NULL,
	folderno number	NOT NULL,
	title varchar2(1000) NULL,
	content varchar2(3000) NULL,
	regdate date NULL,
	fileurl varchar2(3000) NULL,
	picurl varchar2(3000) NULL,
	mapname varchar2(1000) NULL,
	maplati	number NULL,
	maplong	number NULL,
	videourl varchar2(3000)	NULL,
	groupno	number NULL,
	groupsq	number NULL
);

DROP TABLE MUSIC;

CREATE TABLE MUSIC (
	musicno	number	NOT NULL,
	email varchar2(100)	NOT NULL,
	singer varchar2(500) NULL,
	musictitle varchar2(500) NULL,
	runtime	varchar2(100) NULL,
	musicalbum varchar2(500) NULL,
	background varchar2(1) NOT NULL
);

DROP TABLE VISIT;

CREATE TABLE VISIT (
	email	varchar2(100)	NOT NULL,
	v_email	varchar2(100)	NOT NULL,
	v_date	date	NOT NULL
);

DROP TABLE CHAT;

CREATE TABLE CHAT (
	chatno	number	NOT NULL,
	chatrmno	number	NOT NULL,
	chattext	varchar2(500)	NULL,
	chatdate	date	NULL
);

DROP TABLE FRIENDCREATE;

CREATE TABLE FRIENDCREATE (
	friendcreno	number	NOT NULL,
	email	varchar2(100)	NOT NULL,
	relationno	number	NOT NULL
);

DROP TABLE CHATCREATE;

CREATE TABLE CHATCREATE (
	chatcreno	number	NOT NULL,
	chatrmno	number	NOT NULL,
	email	varchar2(100)	NOT NULL
);

DROP TABLE CHATROOM;

CREATE TABLE CHATROOM (
	chatrmno	number	NOT NULL
);

DROP TABLE DIARYROOT;

CREATE TABLE DIARYROOT (
	folderno	number	NOT NULL,
	email	varchar2(100)	NOT NULL,
	foldername	varchar2(100)	NULL,
	foldersq	number	NULL
);

DROP TABLE HOMEINFO;

CREATE TABLE HOMEINFO (
	email	varchar2(100)	NOT NULL,
	p_picurl	varchar2(500)	NOT NULL,
	p_content	varchar2(500)	NULL,
	p_title	varchar2(500)	NULL
);

ALTER TABLE USERINFO ADD CONSTRAINT PK_USERINFO PRIMARY KEY (
	email
);

ALTER TABLE DIARY ADD CONSTRAINT PK_DIARY PRIMARY KEY (
	diaryno,
	folderno
);

ALTER TABLE MUSIC ADD CONSTRAINT PK_MUSIC PRIMARY KEY (
	musicno,
	email
);

ALTER TABLE VISIT ADD CONSTRAINT PK_VISIT PRIMARY KEY (
	email
);

ALTER TABLE CHAT ADD CONSTRAINT PK_CHAT PRIMARY KEY (
	chatno,
	chatrmno
);

ALTER TABLE FRIENDCREATE ADD CONSTRAINT PK_FRIENDCREATE PRIMARY KEY (
	friendcreno,
	email
);

ALTER TABLE CHATCREATE ADD CONSTRAINT PK_CHATCREATE PRIMARY KEY (
	chatcreno,
	chatrmno,
	email
);

ALTER TABLE CHATROOM ADD CONSTRAINT PK_CHATROOM PRIMARY KEY (
	chatrmno
);

ALTER TABLE DIARYROOT ADD CONSTRAINT PK_DIARYROOT PRIMARY KEY (
	folderno
);

ALTER TABLE HOMEINFO ADD CONSTRAINT PK_HOMEINFO PRIMARY KEY (
	email
);
