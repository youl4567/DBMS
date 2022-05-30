-- 여기는 user2 화면
/*
처음으로 데이터를 저장하기 위해서 할 일
1. 등록된 사용자로 접속하기
2. 테이블 생성

*/

CREATE TABLE tbl_student (
	stnum	VARCHAR2(5)	PRIMARY KEY,
	stname	NVARCHAR2(20)	NOT NULL,
	sttel	VARCHAR2(15)	UNIQUE NOT NULL,
	staddr	NVARCHAR2(125)	NULL,
	stdept	NVARCHAR2(5)	NULL,
	stgrade	NUMBER(1)	NULL
);

-- DROP TABLE TBL_STUDENT;

--TBL_STUDENT TABLE 에 데이터 추가하기
-- 생성된 테이블에 데이터를 추가하는 행위를 DATA CREATE  라고 한다.
INSERT INTO TBL_STUDENT(STNUM, STNAME, STTEL, STDEPT)
VALUES('0001', '홍길동', '010-000-0000', '컴공과');

INSERT INTO TBL_STUDENT(STNUM, STNAME, STTEL, STDEPT)
VALUES('0002', '이몽룡', '010-000-0001', '전자과');

INSERT INTO TBL_STUDENT(STNUM, STNAME, STTEL, STDEPT)
VALUES('0003', '성춘향', '010-000-0002', '정보통신');

--저장된 데이터의 조회(QUERY), 읽기
-- SELECT * : 모든 칼럼을 다 표시하여 달라
-- SELECT STNUM, STNAME : 여러 칼럼중에서 STNUM, STNAME 칼럼만 표시해달라
-- PROJECTION : 보고싶은 칼럼만 보기
SELECT *
FROM TBL_STUDENT;

SELECT STNUM, STNAME, STDEPT
FROM TBL_STUDENT;

-- 칼럼의 표시 순서를 변경하여 보여달라
SELECT STNUM, STNAME, STTEL, STDEPT, STADDR, STGRADE
FROM tbl_student;

-- TBL_STUDENT 에 저장된 데이터 중에서 이름이 홍길동인 데이터만
-- 셀렉션 해달라.
SELECT *
FROM tbl_student
WHERE STNAME = '홍길동';

/*
SELECT 명령 수행
PROJECTION : 데이터를 조회할 때 보고자 하는 칼럼만 표시하는 것
SELECTION : 데이터를  조회할 때 WHERE 조건절을 붙여
        필요한 데이터 리스트만 보는 것
        
PROJECTION을 하면 실제 칼럼보다 적은 양의 칼럼을 보여준다
SELECTION 을 하면 실제 데이터 리스트보다 적은 양의 리스트를 보여준다.
*/

-- 전체 데이터를 조건없이 보여주되 이름 순으로 정령하여 보여라
-- 가나다 순으로 오름차순 정렬
SELECT *
FROM TBL_STUDENT
ORDER BY STNAME;
-- 역순 내림차순 정렬
SELECT *
FROM tbl_student
ORDER BY STNAME DESC;

INSERT INTO tbl_student(STNUM, STNAME, STTEL, STDEPT)
VALUES('0004', '장영실', '010-000-0004', '컴공과');
INSERT INTO tbl_student(STNUM, STNAME, STTEL, STDEPT)
VALUES('0005', '최순실', '010-000-0005', '컴공과');

-- 학과가 컴공과인 데이터만 셀렉션하여
-- 이름 순으로 정렬하라
SELECT *
FROM tbl_student
WHERE STDEPT = '컴공과'
ORDER BY STNAME;
--컴공과 학생들만 이름을 역순 정렬하여 보여라
SELECT *
FROM tbl_student
WHERE STDEPT = '컴공과'
ORDER BY STNAME DESC;

-- 전체 데이터를 학과명 순으로 정렬하고
-- 학과명이 같은 데이터끼리는 이름순으로 정렬하라
SELECT *
FROM tbl_student
ORDER BY STDEPT, STNAME;

-- 전체 데이터의 개수가 몇개냐?
SELECT COUNT(STDEPT)
FROM tbl_student;

-- 학과별로 학생이 몇 명인지 알고 싶다.
SELECT STDEPT, COUNT(STDEPT) AS 학생수 -- 3 : 묶은 그룹에 포함된 데이터가 몇개?
FROM tbl_student -- 1 : 데이터 가져오기
GROUP BY STDEPT; -- 2 : STDEPT 학과가 같은 데이터까지 묶고

SELECT COUNT(*)
FROM tbl_student;

-- 전체 데이터중에 컴공과 학생이 몇명인가
SELECT COUNT(STDEPT)
FROM tbl_student
WHERE STDEPT = '컴공과';

/*
 도구에서 데이터를 추가, 수정, 삭제명령을 수행한 경우
 ORACLE DBMS 에게 요청을 한 상태가 된다.
 하지만 ORACLE DBMS 는 아직 스토리지의 DBF 파일에 저장하지 않은 상태이다.
 이 상태에서 도구를 종료해버리면 
 ORACL DBMS 는 어떤 문제가 발생하여 종료된 것으로 생각하고
 데이터를 지워버린다.
 도구를 사용하여 접속하였을 경우는 도구를 종료하기 전에
 반드시 COMMIT 를 해주어야 한다.
*/
COMMIT;

SELECT * FROM TBL_STUDENT;

INSERT INTO TBL_STUDENT ( STNUM, STNAME, STTEL)
VALUES('0006', '신창원', '010-000-0006');

/*
 데이터를 추가, 수정, 삭제하고 아직 COMMIT 하지 않은 상태에서
 추가, 수정, 삭제를 취소하는 명령
*/
ROLLBACK;

DELETE
FROM tbl_student;

SELECT * FROM tbl_student;

/*
 DCL( DATA CONTROL LANG.)
 사용자에게 권한을 부여(GREANT)하거나 회수(REVOKE)하는 명령이 있고
 데이터를 COMMIT, 또는 ROLLBACK 하는 명령이 있다.
*/
DROP TABLE TBL_STUDENT;
DROP TABLE TBL_SCORE;

CREATE TABLE TBL_STUDENT(
STNUM	VARCHAR2(5)		PRIMARY KEY,
STNAME	NVARCHAR2(20)	NOT NULL,
STDEPT	NVARCHAR2(10),
STGRADE	NUMBER(2),	
STTEL	VARCHAR2(15)	NOT NULL	UNIQUE,
STADDR	NVARCHAR2(125)
);

CREATE TABLE TBL_SCORE(
SC_STNUM	VARCHAR2(5)		PRIMARY KEY,
SCKOR	NUMBER		,
SCENG	NUMBER		,
SCMATH	NUMBER		,
SCHIS	NUMBER		,
SCMORAL	NUMBER		,
SCSCI	NUMBER		
);
SELECT * FROM tbl_student;

SELECT STDEPT, COUNT(STDEPT)
FROM tbl_student
GROUP BY STDEPT;

-- 위 결과에서 학생수가 많은 학과부터 보여주기

SELECT STDEPT, COUNT(STDEPT)
FROM tbl_student
GROUP BY STDEPT
ORDER BY COUNT(STDEPT) DESC;

SELECT STDEPT, COUNT(STDEPT) AS 학생수
FROM tbl_student
GROUP BY STDEPT
ORDER BY COUNT(STDEPT) DESC;

SELECT STDEPT, COUNT(STDEPT) AS 학생수
FROM tbl_student
GROUP BY STDEPT
ORDER BY 학생수 DESC;
















