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
	USERCONDITION NUMBER(2) CHECK(USERCONDITION IN (1,2))
);

INSERT INTO USERINFO VALUES('admin', '1234', 'M', SYSDATE, '1994-05-02','관리자', SYSDATE, SYSDATE, '경기도 수원시', 10000, 1);
INSERT INTO USERINFO VALUES('admin2', '1234', 'M', SYSDATE, '1994-05-02','관리자2', SYSDATE, SYSDATE, '경기도 수원시', 10000, 2);

SELECT * FROM USERINFO;


DROP TABLE DIARYROOT PURGE;
DROP SEQUENCE DIARYROOT_FOLDERNOSEQ;
DROP SEQUENCE DIARYROOT_FOLDERSEQ;

CREATE SEQUENCE DIARYROOT_FOLDERNOSEQ;
CREATE SEQUENCE DIARYROOT_FOLDERSEQ;
/* 다이어리 폴더 테이블 */
CREATE TABLE DIARYROOT (
	FOLDERNO NUMBER PRIMARY KEY,
	EMAIL VARCHAR2(100) NOT NULL,
	FOLDERNAME VARCHAR2(100) NULL,
	FOLDERSQ NUMBER	NULL
)
ALTER TABLE DIARYROOT ADD FOREIGN KEY (EMAIL) REFERENCES USERINFO(EMAIL)

INSERT INTO DIARYROOT VALUES(DIARYROOT_FOLDERNOSEQ.NEXTVAL,'admin','뚱s',DIARYROOT_FOLDERSEQ.NEXTVAL);

SELECT * FROM DIARYROOT

DROP TABLE DIARY PURGE;
DROP SEQUENCE DIARY_DIARYNOSEQ;
DROP SEQUENCE DIARY_GROUPNOSEQ;

/*다이어리 번호,그룹번호 SEQ*/
CREATE SEQUENCE DIARY_DIARYNOSEQ;
CREATE SEQUENCE DIARY_GROUPNOSEQ;
/*다이어리 테이블*/
CREATE TABLE DIARY (
	DIARYNO	NUMBER PRIMARY KEY,
	FOLDERNO NUMBER	NOT NULL,
	TITLE VARCHAR2(1000) NULL,
	CONTENT	VARCHAR2(3000) NULL,
	REGDATE	DATE NULL,
	FILEURL	VARCHAR2(3000) NULL,
	PICURL	VARCHAR2(3000) NULL,
	MAPLATI	NUMBER NULL,
	MAPLONG	NUMBER NULL,
	VIDEOURL VARCHAR2(3000) NULL,
	GROUPNO	NUMBER NULL,
	GROUPSQ	NUMBER NULL
)
ALTER TABLE DIARY ADD FOREIGN KEY (FOLDERNO) REFERENCES DIARYROOT(FOLDERNO)

SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE, 
	FILEURL, PICURL, MAPLATI, MAPLONG, VIDEOURL,
	GROUPNO, GROUPSQ
FROM DIARY

/* 다이어리 원글글 작성 쿼리*/
INSERT INTO DIARY 
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'1',' 3 제목',' 3 내용 ',SYSDATE,
		'test fileurl','test picurl','1.1','2.2','test videourl',
		DIARY_GROUPNOSEQ.NEXTVAL,0);
/* 다이어리 댓글 작성 쿼리*/
INSERT INTO DIARY 
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'1',' 2 답글제목',' 2-2 답글내용 ',SYSDATE,
		'test fileurl','test picurl','1.1','2.2','test videourl',
		2,1);
	
	
/*원글 리스트*/
SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE, 
	FILEURL, PICURL, MAPLATI, MAPLONG, VIDEOURL,
	GROUPNO, GROUPSQ
FROM DIARY
WHERE GROUPSQ=0
ORDER BY DIARYNO DESC, GROUPSQ


/*답글 리스트*/
SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE, 
	FILEURL, PICURL, MAPLATI, MAPLONG, VIDEOURL,
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
	FROM (SELECT DIARYNO, FOLDERNO, TITLE, CONTENT, REGDATE,   
			FILEURL, PICURL, MAPLATI, MAPLONG, VIDEOURL, GROUPNO, GROUPSQ, ROWNUM    
		  FROM DIARY WHERE title like '%'||''||'%' 
		 AND GROUPSQ=0   ORDER BY GROUPNO DESC, GROUPSQ ) A   
	) 
WHERE RN BETWEEN 1 AND 10

/*리플 업뎃*/
UPDATE DIARY SET GROUPSQ=GROUPSQ+1
WHERE GROUPNO=(SELECT GROUPNO FROM DIARY  WHERE DIARYNO=13)
AND GROUPSQ>(SELECT GROUPSQ FROM DIARY WHERE DIARYNO=13);
/*리플 인서트*/
INSERT INTO DIARY
VALUES(DIARY_DIARYNOSEQ.NEXTVAL,'1',' 답글 제목 ',' 답글 내용',SYSDATE,
	'test fileurl','testpicurl','1.1','2.2','testvideourl',
	(SELECT GROUPNO FROM DIARY WHERE DIARYNO =13),
	(SELECT GROUPSQ FROM DIARY WHERE DIARYNO =13)+1
);


