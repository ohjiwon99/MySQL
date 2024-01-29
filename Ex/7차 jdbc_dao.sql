-- 작가 테이블 만들기
create table author (
    author_id   int  auto_increment   primary key, -- not null + unique
    author_name varchar(100) not null,
    author_desc varchar(500)
);

-- 책 테이블 만들기
create table book (
    book_id int primary key,
    title varchar(100) not null,
    pubs varchar(100),
    pub_date datetime,
    author_id int,
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

-- 작가등록
-- 묵시적 방법 - 테이블 생성시 정의한 순서대로 들어가는 중
insert into author values(1,'이문열','경북 영양'); 
insert into author values(2,'박경리','경상남도 통영'); 
insert into author values(3,'유시민','17대 국회의원'); 
insert into author values(4,'기안84','기안동에서 산 84년생'); 
insert into author values(5,'강풀','온라인 만화가 1세대'); 
insert into author values(6,'김영하','알뜰신잡'); 
select * from author;

insert into author
value(null,'오지원','학생');

select *
from author;

delete from author
where author_id=9;

select author_id,
       author_name,
       author_desc
from author;

update author 
set author_name = '기안84', 
    author_desc = '웹툰작가'
where author_id = 3
;