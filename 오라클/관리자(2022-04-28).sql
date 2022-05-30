-- 여기는 관리자 화면
--C:\oraclexe\data

/*
오라클 DBMS에 데이터를 저장하고 관리하기 위한 절차

1. 관리자로 접속하여 TABLE SPACE  생성
2. 사용자 생성 및 TABLE SPACE 연결
3. 사용자에게 권한 부여
*/

CREATE TABLESPACE school
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER user2 IDENTIFIED BY 12341234
DEFAULT TABLESPACE school;

GRANT DBA TO user2;






























