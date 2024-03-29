-- 작가 테이블 만들기
create table author (
    author_id   int  auto_increment   primary key, -- not null + unique
    author_name varchar(100) ,
    author_desc varchar(500)
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

-- 책 테이블 만들기
create table book (
    book_id int auto_increment primary key,
    title varchar(100) not null,
    pubs varchar(100),
    pub_date datetime,
    author_id int,
    constraint book_fk foreign key(author_id)
    references author(author_id)
);
-- 책등록
insert into book
values(1,'우리들의 일그러진 영웅','다림','1998-02-22' ,1);
insert into book
values(2,'삼국지','민음사','2002-03-01', 1);
insert into book
values(3,'토지','마로니에북스','2012-08-15', 2);
insert into book
values(4,'유시민의 글쓰기 특강','생각의길','2015-04-01', 3);
insert into book
values(5,'패션왕','중앙북스(books)','2012-02-22', 4);
insert into book
values(6,'순정만화','재미주의','2011-08-03', 5);
insert into book
values(7,'오직두사람','문학동네','2017-05-04', 6);
insert into book
values(8,'26년','재미주의','2012-02-04', 5);
insert into book
values(9,'자바의정석','열린책들','2015-10-20',null);
select * from book;

-- 책등록
insert into book
value(null, '우리들의 일그러진 영웅','다림','1998-02-22' ,1);

select *
from book b
left join author a on b.author_id = a.author_id
order by book_id asc;

select *
from book;

-- 책삭제
delete from book
where book_id = 11;

-- 책수정
update book
set title = '기안84',
	pubs = '웹툰작가',
	pub_date = '2024-05-01',
	author_id = 6
where book_id = 7;

-- 책 select
select book_id, 
	   title, 
       pubs,
       date_format(pub_date, '%Y년   %m월   %d일')pub_date, 
       author_id 
from book ;



select 	b.book_id
		,b.title
		,b.pubs
        ,date_format(b.pub_date, '%Y년   %m월   %d일') pub_date
        ,b.author_id 
        ,a.author_id 
        ,a.author_name
        ,a.author_desc
from book b

left outer join author a
	 on b.author_id = a.author_id 
order by title desc;
