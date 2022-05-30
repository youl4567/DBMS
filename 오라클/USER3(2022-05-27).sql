-- user3 화면



drop table tbl_user;

create table tbl_user (
    username varchar2(30) primary key,
    password varchar2(128) not null,
    name nvarchar2(20),
    email varchar2(125),
    role varchar2(10)
);

select * from tbl_user;

UPDATE tbl_student 
SET st_tel = '010-1111-1111'
where st_num = '20220001';

UPDATE tbl_student 
SET st_tel = '010-1111-2222'
where st_num = '20220002';

UPDATE tbl_student 
SET st_tel = '010-1111-3333'
where st_num = '20220003';

COMMIT;







