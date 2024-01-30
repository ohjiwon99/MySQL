-- 작가등록
insert into author
value(null,'박명수','개그맨');

-- 작가삭제
delete from author
where author_id = 11;

-- 작가 select
select author_id,
       author_name,
       author_desc
from author;

-- 작가수정
update author 
set author_name = '기안84', 
    author_desc = '웹툰작가'
where author_id = 3;

select *
from author;

-- 책등록
insert into book
value(null, '우리들의 일그러진 영웅','다림','1998-02-22' ,1);