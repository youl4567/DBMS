-- 여기는 USER3 로 접속한 화면
DROP TABLE TBL_STUDENT;
DROP TABLE TBL_DEPT;
DROP TABLE TBL_BELONG;

CREATE TABLE TBL_STUDENT(
ST_NUM	VARCHAR2(8) PRIMARY KEY,
ST_NAME	NVARCHAR2(15) NOT NULL,
ST_GRADE	NUMBER(1,0),	
ST_TEL	VARCHAR2(15),	
ST_ADDR	NVARCHAR2(255)	
);

CREATE TABLE TBL_DEPT (
D_CODE	VARCHAR2(5) PRIMARY KEY,
D_NAME	NVARCHAR2(20) NOT NULL,
D_PRO	NVARCHAR2(15),
D_CLASS	VARCHAR2(5)
);

CREATE TABLE TBL_BELONG(
B_SEQ	NUMBER	PRIMARY KEY,
B_STNUM	VARCHAR2(8 BYTE) NOT NULL,
B_DCODE	VARCHAR2(5 BYTE) NOT NULL,
UNIQUE(B_STNUM, B_DCODE)
);

-- 학생정보 샘플데이터 추가
INSERT INTO TBL_STUDENT(ST_NUM, ST_NAME, ST_GRADE) VALUES ('20220001', '홍길동', 1);
INSERT INTO TBL_STUDENT(ST_NUM, ST_NAME, ST_GRADE) VALUES ('20220002', '이몽룡', 3);
INSERT INTO TBL_STUDENT(ST_NUM, ST_NAME, ST_GRADE) VALUES ('20220003', '성춘향', 2);

-- 학과정보 샘플데이터 추가
INSERT INTO TBL_DEPT(D_CODE, D_NAME, D_PRO, D_CLASS) VALUES ('D0001', '컴퓨터공학', '장영실', '505');
INSERT INTO TBL_DEPT(D_CODE, D_NAME, D_PRO, D_CLASS) VALUES ('D0002', '법학과', '임꺽정', '502');
INSERT INTO TBL_DEPT(D_CODE, D_NAME, D_PRO, D_CLASS) VALUES ('D0003', '체육과', '장영자', '503');

-- 소속정보 샘플데이터 추가
INSERT INTO TBL_BELONG(b_seq, b_stnum, b_dcode) VALUES(1,'20220001', 'D0001');
INSERT INTO TBL_BELONG(b_seq, b_stnum, b_dcode) VALUES(2,'20220002', 'D0001');
INSERT INTO TBL_BELONG(b_seq, b_stnum, b_dcode) VALUES(3,'20220002', 'D0002');
INSERT INTO TBL_BELONG(b_seq, b_stnum, b_dcode) VALUES(4,'20220003', 'D0001');
INSERT INTO TBL_BELONG(b_seq, b_stnum, b_dcode) VALUES(5,'20220003', 'D0002');
INSERT INTO TBL_BELONG(b_seq, b_stnum, b_dcode) VALUES(6,'20220003', 'D0003');

/*
 테이블에 일련번호 칼럼이 있을 경우
 중복되지 않은 일련번호를 사용하여 PK로 설정한다.
 오라클 이외의 다른 DBMS 에서는 AUTO IMCREMENT 라는 속성을 사용하여
 데이터를 INSERT 할 때 자동으로 칼럼 데이터를 추가한다.
 하지만 오라클은 그러한 속성이 없어서 상당히 불편하다.
 
 오라클에서는 SEQUENCE 라는 특별한 객체가 있어서
 그 객체를 사용하여 같은 효과를 발휘한다.
 
 또는 PK에 해당하는 칼럼을 문자열 32BYTE 크기로 설정하고
 UUID 를 사용하기도 한다.
 프로그래밍 언어(JAVA, C, PYTHON : 호스트 언어)와 함께
 프로젝트를 할 때는 UUID를 사용한다.
*/

-- seq_belong 이라는 SEQUENCE 객체를 생성하고
-- 시작값을 1로 자동 증가 옵션을 1로 설정하겠따.
CREATE SEQUENCE seq_belong
INCREMENT BY 1 START WITH 1;

-- seq_belong SEQUENT 의 NEXTVAL 값을 조회(SELECT) 하라
-- NEXTVAL 값은 호출 할때마다 항상 1증가된 값을 보여준다.
SELECT seq_belong.NEXTVAL FROM DUAL;

-- 표준 SQL 에서 간단한 4칙 연산을 수행하는 방법
-- 오라클에서는 SELECT 명령문이 FROME 절이 없이 수행하는 것이 불가능하다
-- 그래서 의미없는(DUMY) 테이블인 DUAL TABLE 을 사용하여 FROM 절을 붙여준다
SELECT 10 + 20 FROM DUAL;
SELECT 100 * 100 FROM DUAL;
SELECT 100 - 10 FROM DUAL;
SELECT 50 / 20 FROM DUAL;

-- SEQUENCE 를 사용하여 자동 증가하는 SEQ 를 만들고, INSERT 에서 사용하기
INSERT INTO tbl_belong ( b_seq, b_stnum, b_dcode )
VALUES( seq_belong.NEXTVAL, '20220003', 'D0004');
INSERT INTO TBL_BELONG(b_seq, b_stnum, b_dcode) VALUES(seq_belong.NEXTVAL, '20220001', 'D0004');

SELECT * FROM TBL_BELONG;

-- tbl_student, tbl_dept, tbl_belong 3개의 테이블 left join 하여
-- 학번, 이름, 학과코드, 학과명, 학년을 표시하는 select문 작성

SELECT  st.st_num, st.st_name, b.b_dcode, d.d_name,
        st.st_grade
FROM tbl_student ST
    left join tbl_belong B
    ON st.st_num = b.b_stnum
    LEFT JOIN tbl_dept D
    ON B.b_dcode = D.d_code;

-- Projection(칼럼을 제한하여 보여주기)
SELECT st_num, st_name, st_grade
FROM tbl_student;

-- 학생정보를 확인하면서 어떤 학과에 소속되어있는지를 알고싶다
-- 소속은 tbl_belong 에 저장되어 있다.
SELECT st_num, st_name, st_grade
FROM tbl_student;

-- 20220001 학생이 어떤 학과 소속인지 알고싶다
SELECT *
FROM TBL_BELONG
WHERE B_STNUM = '20220001';

-- 20220001 학생이 소속된 학과가 D0001 인것을 확인했다.
-- D0001 학과 이름이 무엇인지 궁금하다

SELECT *
FROM TBL_DEPT
WHERE D_CODE = 'D0001';

SELECT ST.st_num, ST.st_name, B.b_dcode, D.D_NAME, ST.st_grade
FROM tbl_student ST
    LEFT JOIN tbl_belong B
        ON b_stnum = st_num
    LEFT JOIN tbl_dept D
        ON d_code = b_dcode
ORDER BY ST_NUM;

SELECT ST.st_num, ST.st_name, B.b_dcode, ST.st_grade
FROM tbl_student ST, tbl_belong B, tbl_dept D
WHERE ST.ST_NUM = B.B_STNUM AND B.B_DCODE = D.D_CODE;

-- 학생, 학과, 소속 테이블 간에 FK 설정하기
-- 1. FK 설정하기 앞서 참조무결성 관계를 조회하기
-- 2. 다음의 SQL의 결과에서 결과가 한개도 없어야 참조무결성 관계가 성립된다.
SELECT ST.st_num, ST.st_name, b.b_seq, B.b_dcode, D.D_NAME, ST.st_grade
FROM tbl_student ST
    LEFT JOIN tbl_belong B
        ON b_stnum = st_num
    LEFT JOIN tbl_dept D
        ON d_code = b_dcode
WHERE ST_NUM IS NULL OR D_NAME IS NULL;

-- 위의 SQL 결과 참조무결성이 성립되지 않는 데이터들은
-- SEQ 8번 이다.
-- 2. 참조 무결성이 성립되지 않은 데이터를 삭제한다.
DELETE FROM tbl_belong
WHERE B_SEQ IN(8);

SELECT B_SEQ, B_STNUM, B_DCODE, ST_NUM, D_NAME
FROM TBL_BELONG
    LEFT JOIN tbl_student
     ON B_STNUM = ST_NUM
    LEFT JOIN tbl_dept
     ON B_DCODE = D_CODE
WHERE ST_NUM IS NULL OR D_NAME IS NULL;

-- 3. 테이블간의 참조무결성 제약조건을 부여한다
-- 참조무결성 제약조건을 테이블에 추가하는데
-- 이때는 Relation 테이블에 추가한다.
-- 테이블에 FK 를 추가하여 참조무결성 제약조건을 부여한다.
ALTER TABLE TBL_BELONG
ADD CONSTRAINT FK_TBL_STUDENT
FOREIGN KEY (B_STNUM)
REFERENCES TBL_STUDENT ( ST_NUM);

ALTER TABLE TBL_BELONG
ADD CONSTRAINT FK_TBL_DEPT
FOREIGN KEY (B_DCODE)
REFERENCES TBL_DEPT(D_CODE);

SELECT * FROM TBL_STUDENT;
/*
20220001	홍길동	1		
20220002	이몽룡	3		
20220003	성춘향	2		
*/
SELECT * FROM TBL_DEPT;
/*
D0001	컴퓨터공학	장영실	505
D0002	법학과	임꺽정	502
D0003	체육과	장영자	503
*/
SELECT * FROM TBL_BELONG;
/*
1	20220001	D0001
2	20220002	D0001
3	20220002	D0002
4	20220003	D0001
5	20220003	D0002
6	20220003	D0003
*/

-- tbl_student 에 아직 추가되지 않은 학번을 belong table에 추가하기
-- tbl_student 에 없는 20220004 학번을 추가하려고 했더니
-- parent key not found 오류가 발생한다.
INSERT INTO tbl_belong(B_SEQ, b_stnum, b_dcode)
VALUES(seq_belong.NEXTVAL, '20220004', 'D0003');
-- 먼저 tbl_student 에 해당 학번의 학생정보를 추가해 두어야 한다.
-- tbl_student 에 아래 데이터를 추가한 후 다시 위의 SQL 을 실행하면 정상 추가된다.
INSERT INTO tbl_student(st_num, st_name, st_grade ) 
VALUES('20220004', '장보고', 2);

-- tbl_belong 에 등록된 학번의 정보를 tbl_student에서 삭제하려고 한다.
-- 이미 tbl_belong 에 등록된 학번이므로 학번의 정보를 삭제할 수 없다.
-- child key found
-- FK 를 설정할 때
-- parent table 의 데이터를 삭제하려고 할 때 child table에 데이터가 있으면
-- 보통 삭제 금지
-- parent table 의 데이터를 업데이트하려고 할 때 child table에 데이터가 있으면
-- 보통 변경 금지

-- FK 의 옵션을 지정하여 parent 의 정보가 삭제되면, child 데이터를 모두 삭제하거나
-- parent 의 데이터가 변경되면 child 데이터를 변경하도록 설정할 수 있다.
DELETE FROM tbl_student WHERE st_num = '20220004';

-- 만약 parent table 의 데이터를 일괄 변경하거나, table 의 구조를 변경하려고 하면
-- FK 를 먼저 제거하고 실행을 해야 한다.
ALTER TABLE tbl_belong
DROP CONSTRAINT FK_tbl_student CASCADE;














