DROP TABLE USERINFO PURGE;

CREATE TABLE USERINFO(	
	EMAIL VARCHAR2(100) PRIMARY KEY,
	PASSWORD VARCHAR2(100) NOT NULL,
	GENDER CHAR(2) CHECK(GENDER IN ('M','W')),
	JOINDATE DATE,
	BIRTHDATE DATE,
	USERNAME VARCHAR2(100),
	VISITDATE DATE,
	PWDATE DATE,
	ADDR VARCHAR2(4000),
	COINNO NUMBER(38),
	USERCONDITION NUMBER(2)
);

INSERT INTO USERINFO VALUES('admin', '1234', 'M', SYSDATE, '1994-05-02','관리자', SYSDATE, SYSDATE, '경기도 수원시', 10000, 0);
INSERT INTO USERINFO VALUES('admin3', '1234', 'M', SYSDATE, '1994-05-02','관리자', SYSDATE, SYSDATE, '경기도 수원시', 10000, 0);
INSERT INTO USERINFO VALUES('admin2', '1234', 'M', SYSDATE, '1994-05-02','관리자2', SYSDATE, SYSDATE, '경기도 수원시', 10000, 1);

SELECT * FROM USERINFO;



DROP TABLE MUSIC;
DROP SEQUENCE JUKESEQ;

CREATE SEQUENCE JUKESEQ;

CREATE TABLE MUSIC (
	MUSICNO	number		NOT NULL,
	EMAIL	varchar2(100)		NOT NULL,
	SINGER	varchar2(500)	NULL,
	MUSICTITLE	varchar2(500)		NULL,
	RUNTIME	varchar2(100)		NULL,
	MUSICALBUM	varchar2(500)		NULL,
	BACKGROUND varchar2(1)	NOT NULL
);

ALTER TABLE "MUSIC" ADD CONSTRAINT "PK_MUSIC" PRIMARY KEY (
	MUSICNO,
	EMAIL
);

ALTER TABLE "MUSIC" ADD CONSTRAINT "FK_USERINFO_TO_MUSIC_1" FOREIGN KEY (
	EMAIL
)
REFERENCES "USERINFO" (
	EMAIL
);

SELECT * FROM MUSIC;