
CREATE TABLE USERINFO (
   email varchar2(100)   PRIMARY KEY NOT NULL,
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

INSERT INTO USERINFO VALUES('admin','1234','M', SYSDATE, '1994-05-02', '최승언', SYSDATE, SYSDATE, '경기도 수원시', 1000000, 0);
INSERT INTO USERINFO VALUES('admin','987654123','M', SYSDATE, '1900-01-01', '관리자', SYSDATE, SYSDATE, '평양', 1000000, 0);

DROP TABLE DIARY;

CREATE TABLE DIARY (
   diaryno number NOT NULL,
   folderno number NOT NULL,
   email varchar2(100) NOT NULL,
   title varchar2(1000) NULL,
   content varchar2(3000) NULL,
   regdate date NULL,
   fileurl varchar2(3000) NULL,
   picurl varchar2(3000) NULL,
   mapname varchar2(1000) NULL,
   maplati number NULL,
   maplong number NULL,
   videourl varchar2(3000)   NULL,
   groupno number NULL,
   groupsq number NULL
);


CREATE TABLE MUSIC (
   musicno number NOT NULL,
   email varchar2(100) NOT NULL,
   singer varchar2(500) NULL,
   musictitle varchar2(500) NULL,
   runtime varchar2(100) NULL,
   musicalbum varchar2(500) NULL,
   background varchar2(1) NOT NULL
);

CREATE TABLE VISIT (
   email varchar2(100) NOT NULL,
   v_email varchar2(100) NOT NULL,
   v_date date NOT NULL
);


CREATE TABLE CHAT (
   chatno number NOT NULL,
   chatrmno number NOT NULL,
   chattext varchar2(500) NULL,
   chatdate date NULL
);


CREATE TABLE FRIENDCREATE (
   friendcreno number NOT NULL,
   email varchar2(100) NOT NULL,
   relationno number NOT NULL
);


CREATE TABLE CHATCREATE (
   chatcreno number NOT NULL,
   chatrmno number NOT NULL,
   email varchar2(100) NOT NULL
);


CREATE TABLE CHATROOM (
   chatrmno number NOT NULL
);


CREATE TABLE DIARYROOT (
   folderno number NOT NULL,
   email varchar2(100) NOT NULL,
   foldername varchar2(100) NULL,
   foldersq number NULL
);



CREATE TABLE HOMEINFO (

   email varchar2(100) NOT NULL,
   p_picurl varchar2(500) NOT NULL,
   p_content varchar2(500) NULL,
   p_title varchar2(500) NULL
);

ALTER TABLE USERINFO ADD CONSTRAINT PK_USERINFO PRIMARY KEY (
   email
);

ALTER TABLE DIARY ADD CONSTRAINT PK_DIARY PRIMARY KEY (
   diaryno,
   folderno,
   email
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
<<<<<<< HEAD
	email
);

CREATE TABLE DIARY (
	diaryno number NOT NULL,
	folderno number NOT NULL,
	email varchar2(100) NOT NULL,
	title varchar2(1000) NULL,
	content varchar2(3000) NULL,
	regdate date NULL,
	fileurl varchar2(3000) NULL,
	picurl varchar2(3000) NULL,
	mapname varchar2(1000) NULL,
	maplati number NULL,
	maplong number NULL,
	videourl varchar2(3000)	NULL,
	groupno number NULL,
	groupsq number NULL
);


CREATE TABLE MUSIC (
	musicno number NOT NULL,
	email varchar2(100) NOT NULL,
	singer varchar2(500) NULL,
	musictitle varchar2(500) NULL,
	runtime varchar2(100) NULL,
	musicalbum varchar2(500) NULL,
	background varchar2(1) NOT NULL
);

CREATE TABLE VISIT (
	email varchar2(100) NOT NULL,
	v_email varchar2(100) NOT NULL,
	v_date date NOT NULL
);


CREATE TABLE CHAT (
	chatno number NOT NULL,
	chatrmno number NOT NULL,
	chattext varchar2(500) NULL,
	chatdate date NULL
);


CREATE TABLE FRIENDCREATE (
	friendcreno number NOT NULL,
	email varchar2(100) NOT NULL,
	relationno number NOT NULL
);


CREATE TABLE CHATCREATE (
	chatcreno number NOT NULL,
	chatrmno number NOT NULL,
	email varchar2(100) NOT NULL
);


CREATE TABLE CHATROOM (
	chatrmno number NOT NULL
);


CREATE TABLE DIARYROOT (
	folderno number NOT NULL,
	email varchar2(100) NOT NULL,
	foldername varchar2(100) NULL,
	foldersq number NULL
);



CREATE TABLE HOMEINFO (

	email varchar2(100) NOT NULL,
	p_picurl varchar2(500) NOT NULL,
	p_content varchar2(500) NULL,
	p_title varchar2(500) NULL
);

ALTER TABLE USERINFO ADD CONSTRAINT PK_USERINFO PRIMARY KEY (
	email
);

ALTER TABLE DIARY ADD CONSTRAINT PK_DIARY PRIMARY KEY (
	diaryno,
	folderno,
	email
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

ALTER TABLE DIARY ADD CONSTRAINT FK_DIARYROOT_TO_DIARY_1 FOREIGN KEY (
	folderno
)
REFERENCES DIARYROOT (
	folderno
) ON DELETE CASCADE ENABLE;

ALTER TABLE DIARY ADD CONSTRAINT FK_USERINFO_TO_DIARY_1 FOREIGN KEY (
	email
)
REFERENCES USERINFO (
	email
);

ALTER TABLE MUSIC ADD CONSTRAINT FK_USERINFO_TO_MUSIC_1 FOREIGN KEY (
	email
)
REFERENCES USERINFO (
	email
);

ALTER TABLE VISIT ADD CONSTRAINT FK_USERINFO_TO_VISIT_1 FOREIGN KEY (
	email
)
REFERENCES USERINFO (
	email
);

ALTER TABLE CHAT ADD CONSTRAINT FK_CHATROOM_TO_CHAT_1 FOREIGN KEY (
	chatrmno
)
REFERENCES CHATROOM (
	chatrmno
);

ALTER TABLE FRIENDCREATE ADD CONSTRAINT FK_USERINFO_TO_FRIENDCREATE_1 FOREIGN KEY (
	email
)
REFERENCES USERINFO (
	email
);

ALTER TABLE CHATCREATE ADD CONSTRAINT FK_CHATROOM_TO_CHATCREATE_1 FOREIGN KEY (
	chatrmno
)
REFERENCES CHATROOM (
	chatrmno
);

ALTER TABLE CHATCREATE ADD CONSTRAINT FK_USERINFO_TO_CHATCREATE_1 FOREIGN KEY (
	email
)
REFERENCES USERINFO (
	email
);

ALTER TABLE HOMEINFO ADD CONSTRAINT FK_USERINFO_TO_HOMEINFO_1 FOREIGN KEY (
	email
)
REFERENCES USERINFO (
	email
);


/*DROP TABLE*/
DROP TABLE HOMEINFO;
DROP TABLE CHATCREATE;
DROP TABLE CHATROOM;
DROP TABLE FRIENDCREATE;
DROP TABLE CHAT;
DROP TABLE VISIT;
DROP TABLE MUSIC;
DROP TABLE DIARY;
DROP TABLE DIARYROOT;
DROP TABLE USERINFO;

DROP SEQUENCE DIARYROOT_FOLDERNOSEQ;
DROP SEQUENCE DIARYROOT_FOLDERSEQ;

DROP SEQUENCE DIARY_DIARYNOSEQ;
DROP SEQUENCE DIARY_GROUPNOSEQ;


/*유저 등록*/
INSERT INTO USERINFO VALUES('admin', '1234', 'M', SYSDATE, '1994-05-02','관리자', SYSDATE, SYSDATE, '경기도 수원시', 10000, 1);
INSERT INTO USERINFO VALUES('admin2', '1234', 'M', SYSDATE, '1994-05-02','관리자2', SYSDATE, SYSDATE, '경기도 수원시', 10000, 2);

SELECT * FROM USERINFO;


CREATE SEQUENCE DIARYROOT_FOLDERNOSEQ;
CREATE SEQUENCE DIARYROOT_FOLDERSEQ;

INSERT INTO DIARYROOT VALUES(DIARYROOT_FOLDERNOSEQ.NEXTVAL,'admin','뚱s',0);

SELECT * FROM DIARYROOT;

DELETE DIARYROOT WHERE FOLDERNO=1;

DROP TABLE DIARY ;
DROP SEQUENCE DIARY_DIARYNOSEQ;
DROP SEQUENCE DIARY_GROUPNOSEQ;

/*다이어리 번호,그룹번호 SEQ*/
CREATE SEQUENCE DIARY_DIARYNOSEQ;
CREATE SEQUENCE DIARY_GROUPNOSEQ;

SELECT DIARYNO, FOLDERNO, EMAIL,TITLE, CONTENT, REGDATE, 
	FILEURL, MAPNAME, PICURL, MAPNAME, MAPLATI, MAPLONG, VIDEOURL,
	GROUPNO, GROUPSQ
FROM DIARY

/* 다이어리 임의 원글글 작성 쿼리*/
INSERT INTO DIARY 
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'2','admin',' 1 원글제목',' 1 원글내용 ',SYSDATE,
		'test fileurl','test picurl', 'mpaname','1.1','2.2','test videourl',
		DIARY_GROUPNOSEQ.NEXTVAL,0);
/* 다이어리 임의 댓글 작성 쿼리*/
INSERT INTO DIARY 
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'1','admin',' 1 답글제목',' 1-1 답글내용 ',SYSDATE,
		'test fileurl','test picurl','mapname','1.1','2.2','test videourl',
		1,1);
	
/*원글 리스트*/
SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE, 
	FILEURL, PICURL, MAPNAME, MAPLATI, MAPLONG, VIDEOURL,
	GROUPNO, GROUPSQ
FROM DIARY
WHERE GROUPSQ=0
ORDER BY DIARYNO DESC, GROUPSQ


/*답글 리스트*/
SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE, 
	FILEURL, PICURL, MAPNAME, MAPLATI, MAPLONG, VIDEOURL,
	GROUPNO, GROUPSQ
FROM DIARY
WHERE GROUPSQ >0
ORDER BY GROUPNO DESC, GROUPSQ

/*게시글 카운트*/
SELECT COUNT(*)
FROM DIARY
WHERE GROUPSQ=0

/*d*/
SELECT * 
FROM 
	(SELECT ROWNUM AS RN, A.*
	FROM (SELECT DIARYNO, FOLDERNO, EMAIL, TITLE, CONTENT, REGDATE,   
			FILEURL, PICURL, MAPLATI, MAPNAME,MAPLONG, VIDEOURL, GROUPNO, GROUPSQ, ROWNUM    
		  FROM DIARY WHERE title like '%'||''||'%' 
		 AND GROUPSQ=0   ORDER BY GROUPNO DESC, GROUPSQ ) A   
	) 
WHERE RN BETWEEN 1 AND 10

/*리플 업뎃*/
UPDATE DIARY SET GROUPSQ=GROUPSQ+1
WHERE GROUPNO=(SELECT GROUPNO FROM DIARY  WHERE DIARYNO=1)
AND GROUPSQ>(SELECT GROUPSQ FROM DIARY WHERE DIARYNO=1);
/*리플 인서트*/
INSERT INTO DIARY
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'1','admin2',' 답글 제목 ',' 답글 내용',SYSDATE,
	'test fileurl','testpicurl', 'mapname', '1.1','2.2','testvideourl',
	(SELECT GROUPNO FROM DIARY WHERE DIARYNO =1),
	(SELECT GROUPSQ FROM DIARY WHERE DIARYNO =1)+1
);

DELETE FROM DIARY WHERE DIARYNO=2
=======
   email
);

ALTER TABLE DIARY ADD CONSTRAINT FK_DIARYROOT_TO_DIARY_1 FOREIGN KEY (
   folderno
)
REFERENCES DIARYROOT (
   folderno
) ON DELETE CASCADE ENABLE;

ALTER TABLE DIARY ADD CONSTRAINT FK_USERINFO_TO_DIARY_1 FOREIGN KEY (
   email
)
REFERENCES USERINFO (
   email
);

ALTER TABLE MUSIC ADD CONSTRAINT FK_USERINFO_TO_MUSIC_1 FOREIGN KEY (
   email
)
REFERENCES USERINFO (
   email
);

ALTER TABLE VISIT ADD CONSTRAINT FK_USERINFO_TO_VISIT_1 FOREIGN KEY (
   email
)
REFERENCES USERINFO (
   email
);

ALTER TABLE CHAT ADD CONSTRAINT FK_CHATROOM_TO_CHAT_1 FOREIGN KEY (
   chatrmno
)
REFERENCES CHATROOM (
   chatrmno
);

ALTER TABLE FRIENDCREATE ADD CONSTRAINT FK_USERINFO_TO_FRIENDCREATE_1 FOREIGN KEY (
   email
)
REFERENCES USERINFO (
   email
);

ALTER TABLE CHATCREATE ADD CONSTRAINT FK_CHATROOM_TO_CHATCREATE_1 FOREIGN KEY (
   chatrmno
)
REFERENCES CHATROOM (
   chatrmno
);

ALTER TABLE CHATCREATE ADD CONSTRAINT FK_USERINFO_TO_CHATCREATE_1 FOREIGN KEY (
   email
)
REFERENCES USERINFO (
   email
);

ALTER TABLE HOMEINFO ADD CONSTRAINT FK_USERINFO_TO_HOMEINFO_1 FOREIGN KEY (
   email
)
REFERENCES USERINFO (
   email
);


/*DROP TABLE*/
DROP TABLE HOMEINFO;
DROP TABLE CHATCREATE;
DROP TABLE CHATROOM;
DROP TABLE FRIENDCREATE;
DROP TABLE CHAT;
DROP TABLE VISIT;
DROP TABLE MUSIC;
DROP TABLE DIARY;
DROP TABLE DIARYROOT;
DROP TABLE USERINFO;

/* seq - drop&create  */
DROP SEQUENCE DIARYROOT_FOLDERNOSEQ;
DROP SEQUENCE DIARYROOT_FOLDERSEQ;
DROP SEQUENCE JUKESEQ;
DROP SEQUENCE DIARY_DIARYNOSEQ;
DROP SEQUENCE DIARY_GROUPNOSEQ;
DROP SEQUENCE RELATIONSEQ;
DROP SEQUENCE FRIENDSEQ;
DROP SEQUENCE CHATSEQ;

CREATE SEQUENCE DIARYROOT_FOLDERNOSEQ;
CREATE SEQUENCE DIARYROOT_FOLDERSEQ;
CREATE SEQUENCE DIARY_DIARYNOSEQ;
CREATE SEQUENCE DIARY_GROUPNOSEQ;
CREATE SEQUENCE JUKESEQ;
CREATE SEQUENCE RELATIONSEQ;
CREATE SEQUENCE FRIENDSEQ;
CREATE SEQUENCE CHATSEQ;

/*유저 등록*/
INSERT INTO USERINFO VALUES('admin', '1234', 'M', SYSDATE, '1994-05-02','관리자', SYSDATE, SYSDATE, '경기도 수원시', 10000, 1);
INSERT INTO USERINFO VALUES('admin2', '1234', 'M', SYSDATE, '1994-05-02','관리자2', SYSDATE, SYSDATE, '경기도 수원시', 10000, 2);

SELECT * FROM USERINFO;


CREATE SEQUENCE DIARYROOT_FOLDERNOSEQ;
CREATE SEQUENCE DIARYROOT_FOLDERSEQ;
CREATE SEQUENCE JUKESEQ;

INSERT INTO DIARYROOT VALUES(DIARYROOT_FOLDERNOSEQ.NEXTVAL,'admin','뚱s',0);

SELECT * FROM DIARYROOT;

DELETE DIARYROOT WHERE FOLDERNO=1;

DROP TABLE DIARY ;
DROP SEQUENCE DIARY_DIARYNOSEQ;
DROP SEQUENCE DIARY_GROUPNOSEQ;

/*다이어리 번호,그룹번호 SEQ*/
CREATE SEQUENCE DIARY_DIARYNOSEQ;
CREATE SEQUENCE DIARY_GROUPNOSEQ;

SELECT DIARYNO, FOLDERNO, EMAIL,TITLE, CONTENT, REGDATE, 
   FILEURL, MAPNAME, PICURL, MAPNAME, MAPLATI, MAPLONG, VIDEOURL,
   GROUPNO, GROUPSQ
FROM DIARY

/* 다이어리 임의 원글글 작성 쿼리*/
INSERT INTO DIARY 
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'2','admin',' 1 원글제목',' 1 원글내용 ',SYSDATE,
      'test fileurl','test picurl', 'mpaname','1.1','2.2','test videourl',
      DIARY_GROUPNOSEQ.NEXTVAL,0);
/* 다이어리 임의 댓글 작성 쿼리*/
INSERT INTO DIARY 
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'1','admin',' 1 답글제목',' 1-1 답글내용 ',SYSDATE,
      'test fileurl','test picurl','mapname','1.1','2.2','test videourl',
      1,1);
   
/*원글 리스트*/
SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE, 
   FILEURL, PICURL, MAPNAME, MAPLATI, MAPLONG, VIDEOURL,
   GROUPNO, GROUPSQ
FROM DIARY
WHERE GROUPSQ=0
ORDER BY DIARYNO DESC, GROUPSQ


/*답글 리스트*/
SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE, 
   FILEURL, PICURL, MAPNAME, MAPLATI, MAPLONG, VIDEOURL,
   GROUPNO, GROUPSQ
FROM DIARY
WHERE GROUPSQ >0
ORDER BY GROUPNO DESC, GROUPSQ

/*게시글 카운트*/
SELECT COUNT(*)
FROM DIARY
WHERE GROUPSQ=0

/*d*/
SELECT * 
FROM 
   (SELECT ROWNUM AS RN, A.*
   FROM (SELECT DIARYNO, FOLDERNO, EMAIL, TITLE, CONTENT, REGDATE,   
         FILEURL, PICURL, MAPLATI, MAPNAME,MAPLONG, VIDEOURL, GROUPNO, GROUPSQ, ROWNUM    
        FROM DIARY WHERE title like '%'||''||'%' 
       AND GROUPSQ=0   ORDER BY GROUPNO DESC, GROUPSQ ) A   
   ) 
WHERE RN BETWEEN 1 AND 10

/*리플 업뎃*/
UPDATE DIARY SET GROUPSQ=GROUPSQ+1
WHERE GROUPNO=(SELECT GROUPNO FROM DIARY  WHERE DIARYNO=1)
AND GROUPSQ>(SELECT GROUPSQ FROM DIARY WHERE DIARYNO=1);
/*리플 인서트*/
INSERT INTO DIARY
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'1','admin2',' 답글 제목 ',' 답글 내용',SYSDATE,
   'test fileurl','testpicurl', 'mapname', '1.1','2.2','testvideourl',
   (SELECT GROUPNO FROM DIARY WHERE DIARYNO =1),
   (SELECT GROUPSQ FROM DIARY WHERE DIARYNO =1)+1
);

DELETE FROM DIARY WHERE DIARYNO=2
>>>>>>> branch 'master' of https://github.com/ddoongi3152/Saisiot.git
