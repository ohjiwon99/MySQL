# 로그인 화면

create table login (
    login_no   int  auto_increment   primary key, -- not null + unique
    login_id varchar(100) ,
    login_pw varchar(500)
);

select *
from login;

-- 로그인 정보
-- 묵시적 방법 - 테이블 생성시 정의한 순서대로 들어가는 중
insert into login values(null,'id','pw'); 
select * from login;