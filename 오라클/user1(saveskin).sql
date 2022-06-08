-- save skin

-- 게시판 테이블
create table tbl_board (
    b_num         NUMBER            primary key,
    b_title       nvarchar2(25)     not null,
    b_hit         NUMBER            not null,
    b_content     nvarchar2(1000)   not null
);

-- 게시글 작성 테이블
CREATE TABLE   tbl_write (
    w_num        NUMBER         primary key,
    w_date       varchar2(8)     not null
);

-- 추천 수 테이블
CREATE TABLE tbl_recommend (
    r_num       NUMBER         primary key,
    r_hit       nvarchar2(500)     not null
); 

-- 댓글 작성 테이블
CREATE TABLE tbl_comment (
    c_num       NUMBER          primary key,
    c_date      varchar2(8)     not null,
    c_content   nvarchar2(500)  not null
);