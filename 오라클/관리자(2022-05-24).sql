-- 관리자 화면
-- TAbleSpace 생성하기
-- 이름 : iolist
-- 데이터파일(물리적저장소) : 'C:/oraclexe/data/iolist.dbf'
-- 초기크기 : 1MB
-- 용량이 부족할 경우 : 자동장 1KB 씩

CREATE TableSpace iolist
DATAFILE 'C:/oraclexe/data/iolist.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- TableSpace 삭제하기
DROP TABLESPACE IOLIST
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

-- 사용자(USER) 생성
-- USERNAME: USER3, PASSWOR: 12341234
-- DEFAULT TALESPACE "IOLIST"
-- 이 사용자 계정으로 데이터를 추가하면 IOLIST 에 저장하라
-- DBA 권한 부여
CREATE USER user3 IDENTIFIED BY 12341234
DEFAULT TABLESPACE IOLIST;

-- 사용자 계정 완전 삭제하기
DROP USER USER3 CASCADE;

-- 사용자 등록을 완료했으나 현재는 아무런 일도 할 수 없는 상태이다
-- 사용자에게 DB연결, 조회, 추가, 삭제, 변경 등을 할 수 잇는 권한을 부여해야 한다.
-- 원칙은 권한을 세세하게 부여하여 불필요한 권한을 갖지 않도록 해야하지만
-- 학습상 불편함이 있어서 여기서는 DBA 권한을 부여할 것이다.
GRANT DBA TO USER3; -- 권한 부여
REVOKE DBA FROM USER3; -- 권한 회수



ALTER USER bookuser ACCOUNT UNLOCK;

















