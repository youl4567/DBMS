
create table TBL_BOOKS (
    ISBN        varchar2(13)    primary key,
    title       nvarchar2(50)   not null,
    author      nvarchar2(50)   not null,
    publisher   nvarchar2(50)   not null,
    price       NUMBER,
    discount    NUMBER,
    description nvarchar2(2000),
    pubdate     varchar2(10),
    link        varchar2(125),
    image       varchar2(125)
);

DROP TABLE TBL_BOOKS;

INSERT all
INTO tbl_books(isbn, title, author, publisher)
values('0001', '자바', '홍길동', '우리출판사')
INTO tbl_books(isbn, title, author, publisher)
values('0002', '오라클', '홍길동', '우리출판사')
select * from dual;

INSERT INTO tbl_books(isbn, title, author, publisher, price)
values('0003', 'MySQL', '이몽룡', '남원출판사', '9000');

INSERT INTO tbl_books(isbn, title, author, publisher, price)
values('0004', 'MySQL', '이몽룡', '남원출판사', '');

select * from tbl_books;

/*
SQL Developer 에서 INSERT, UPDATE, DELETE 수행하였으나
다른(spring) 프로젝트에서 데이터 반영이 안되는 경우
명령 끝에 반드시 commit 을 수행한다.

INSERT, UPDATE, DELETE 를 수행한 결과는
아직 메모리 버퍼에 머물러있는 상태이다.
실제 물리적 저장소에 아직 저장이 안된 상태이다.
이 상태에서 다른 프로젝트에서 데이터를 조회하면
데이터가 보이지 않는다.
COMMIT 을 할 때까지 
*/
commit;













