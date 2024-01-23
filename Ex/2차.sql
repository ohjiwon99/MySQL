use hrdb;

/*************************
select문(조회)
**************************/

#select ~ fromw절
-- 테이블 전체 조회하기

-- select문
#select문
 
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from jobs;
select * from job_history;

-- select절
select first_name, salary
 from employees;
 
 select employees;
 -- selext 모든 직원의 이름(fisrt_name, last_name)과 전화번호 입사일 연봉을 출력하세요
 select employees;
 
 select employee_id, first_name, last_name from employees;
 
  #모든 직원의 이름(fisrt_name)과 전화번호 입사일 연봉을 출력하세요
 select first_name, phone_number, hire_date, salary
 from employees;
 
 #모든 직원의 이름(first_name)과 성(last_name), 
 #월급,전화번호,이메일,입사일을 출력하세요.
 select first_name,
        last_name, 
        phone_number, 
        hire_date, 
        salary,
        email
 from employees;
 
 #직원아이디, 이름, 월급을 출력하세요. 
 #단 직원아이디는 empNO, 이름은 "f-name", 월급은 "월 급" 으로 컬럼명을 출력하세요
 
 select employee_id as empMo,
        first_name as 'f-name',
        salary as '월 급' 
from employees;

#직원의 이름(fisrt_name)과 전화번호, 입사일, 월급 으로 표시되도록 출력하세요
 select first_name 이름,
        phone_number 전화번호,
        hire_date 입사일,
        salary 월급
from employees;


#직원의 직원아이디를 사 번, 이름(first_name), 성(last_name), 월급, 전화번호, 이메일,
#입사일로 표시되도록 출력하세요
 select employee_id,
        first_name 이름,
        last_name 성, 
        salary 월급,
        phone_number 전화번호,
        email 이메일,
         hire_date 입사일
from employees;

-- 산술 연산자 사용하기 
select first_name,
       salary,
       salary-100 '월급-식대', 
       salary*12 연봉,
       salary*12+500 '보너스 포함',
       salary/30 일급,
       employee_id%3 '워크샵 팀'
       from employees;

-- 문자열은 0으로 처리 --> 오류가 나지 않음으로 모르고 넘어갈수 있으니 주의 바람.       
select job_id*12
from employees;

-- 컬럼 합치기
select concat(first_name,' ',last_name)
from employees; 


# 2024-01-22


-- like
select first_name, last_name, salary
from employees
where first_name like 'L%';


# 이름에 am 을 포함한 사원의 이름과 월급을 출력하세요
select first_name, last_name, salary
from employees
where first_name like 'am%';

# 이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select first_name, salary
from employees
where first_name like '_a%';

# 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name,  salary
from employees
where first_name like '___a%';

# 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name,  salary
from employees
where first_name like '_a__%';



-- null
select * 
from employees
where salary between 13000 and 15000;

select first_name,  
       salary,
       commission_pct
from employees
where salary between 13000 and 15000;

select * 
from employees
where commission_pct is null;
# 주의 where commision_pct = null 은 잘못된 표현

select * 
from employees
where commission_pct is not null;

#커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select first_name,
       salary
from employees
where commission_pct is null;

#담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select first_name,
       manager_id,
       commission_pct 
from employees
where commission_pct and manager_id is null;

#부서가 없는 직원의 이름과 월급을 출력하세요
select first_name,
       salary,
       department_id
from employees
where department_id is null;

-- order by
select first_name,
       salary
from employees
where salary >= 10000
order by salary asc;
# asc 작은것부터 큰거// desc 큰거부터 작은거

select * 
from employees
order by employee_id asc;

-- a부터 이름 정렬
select first_name 
from employees
order by first_name asc;

-- a부터 이름과 월급 정렬
select first_name , salary
from employees
order by first_name asc;

-- 가장 최근 입사순
select * 
from employees
order by hire_date desc;

-- (최근 입사일 순, 입사일이 같으면 월급이 많은 사람부터)
select first_name , salary, hire_date 
from employees
order by hire_date desc;

-- 1.최근 입사일 순
select *
from employees
order by hire_date desc;
-- 2. 입사일이 같으면 월급이 많은 사람부터
select first_name , salary, hire_date 
from employees
order by hire_date desc, salary desc;

#부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select employee_id, salary, first_name
from employees
order by employee_id asc;

#월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select  salary, first_name
from employees
where salary >=10000
order by salary desc, first_name asc;

#부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요
select department_id, salary, first_name
from employees
order by department_id asc, salary desc;

#직원의 이름, 급여, 입사일 이름을 알파벳 올림차순으로 출력하세요
select first_name, salary, hire_date
from employees
order by  first_name asc;

#직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select first_name, salary, hire_date
from employees
order by  hire_date asc;

/**********************************************
#2일차 수업
***********************************************/

-- 단일행 함수(숫자함수)
#ROUND(숫자, m) 반올림, 소수점 m 자리까지 표현
#CEIL(숫자) 올림
#FLOOR(숫자) 내림
#TRUNCATE(숫자, m) 버림, 소수점 m 자리까지 표현
#POWER(숫자,n) 숫자의 n승
#POW(숫자, n) 숫자의 n승
#SQRT(숫자) 숫자의 제곱근
#SIGN(숫자) 숫자가 음수이면 -1, 0이면 0, 양수이면 1
#ABS(숫자) 절대값
#GREATEST(x, y, z, ...) 괄호안의 값중 가장 큰값
#LEAST(x, y, z, ...) 괄호안의 값중 가장 작은값

-- 단일행 함수 > 숫자함수(- ROUND(숫자, m): 반올림, 소수점 m 자리까지 표현)

select round(123.123, 2),
       round(123.126, 2),
       round(234.567, 0),
       round(123.456, 0),
       round(123.456),
       round(123.126, -1),
       round(125.126, -1),
       round(123.126, -2)
from dual;

-- 개발 tip (콤마를 앞에 찍으면 수정과 이동 용이)
select round(123.123, 2)
       ,round(123.126, 2)
       ,round(234.567, 0)
       ,round(123.456, 0)
       ,round(123.456)
       ,round(123.126, -1)
       ,round(125.126, -1)
       ,round(123.126, -2)
from dual;

-- CEIL(숫자): 올림
select ceil(123.456),
       ceil(123.789),
       ceil(123.7892313),
       ceil(987.1234);
       
--  FLOOR(숫자): 내림
select floor(123.456),
floor(123.789),
floor(123.7892313),
floor(987.1234);

-- TRUNCATE(숫자, m) : 버림, 소수점 m 자리까지 표현
select truncate(1234.34567, 2),
truncate(1234.34567, 3),
truncate(1234.34567, 0),
truncate(1235.34567, -2);

--  POWER(숫자, n), POW(숫자, n): 숫자의 n승
select pow(12,2), power(12,2);

--  SQRT(숫자): 숫자의 제곱근
select sqrt(144); 

--  SIGN(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1
select sign(123),
sign(0),
sign(-123);

-- ABS(숫자): 절대값
select abs(123),
abs(0),
abs(-123);

--  GREATEST(x, y, z, ...): 괄호안의 값중 가장 큰값
select greatest(2, 0, -2), 
greatest(4, 3.2, 5.25), 
greatest('B', 'A', 'C', 'c');

-- #나중에 배움 이중에 뭐가 제일 크니! 
select max(salary)
from employees;

select employee_id,
       manager_id,
       department_id,
       greatest(employee_id,manager_id,department_id)
from employees;

-- LEAST(x, y, z, ...): 괄호안의 값중 가장 작은값
select least(2, 0, -2),
least(4, 3.2, 5.25), 
least('B', 'A', 'C', 'c');

-- 단일행 함수 --> 문자함수

#CONCAT(s1, s2, ..., sn) s1, s2, ..., sn을 연결
#CONCAT_WS(s, s1, s2, ..., sn) s1, s2, ..., sn을 연결할때 사이에 s 로 연결
#LCASE(str) / LOWER(str) str의 모든 대문자를 소문자로 변환
#UCASE(str) / UPPER(str) str의 모든 소문자를 대문자로 변환
#LENGTH(str) str의 길이를 바이트로 반환
#CHAR_LENGTH(str) / CHARACTER_LENGTH() str의 문자열 길이를 반환
#SUBSTRING(str, pos, len) / SUBSTR(str, pos, len) str의 pos 위치에서 시작하여 len 길이의 문자열 반환
#LPAD(str, len, padstr) str 왼쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
#RPAD(str, len, padstr) str 오른쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
#TRIM(str) str의 양쪽에 있는 공백 문자를 제거
#LTRIM(str) str의 왼쪽에 있는 공백 문자를 제거
#RTRIM(str) str의 오른쪽에 있는 공백 문자를 제거
#REPLACE(str, from_str, to_str) str에서 from_str을 to_str로 변경

-- > 문자함수
-- CONCAT(str1, str2, ..., strn): str1, str2, ..., strn을 연결
select concat('안녕','하세요');
select concat('안녕','-','하세요');
select concat(first_name,'',last_name)
from employees;
-- - CONCAT_WS(s, str1, str2, ..., strn): str1, str2, ..., strn을 연결할때 사이에 s 로 연결
select concat_ws("-","abc","123","가나다");

select concat_ws("-", first_name, last_name, salary)
from employees;

-- LCASE(str) 또는 LOWER(str): str의 모든 대문자를 소문자로 변환
select first_name,
lcase(first_name),
lower(first_name),
lower('ABCabc!#$%'),
lower('가나다')
from employees;

-- UCASE(str) 또는 UPPER(str): str의 모든 소문자를 대문자로 변환
select first_name,
ucase(first_name),
upper(first_name),
upper('ABCabc!#$%'),
upper('가나다')
from employees;

-- LENGTH(str): str의 길이를 바이트로 반환
#CHAR_LENGTH(str) 또는 CHARACTER_LENGTH(): str의 문자열 길이를 반환
select first_name,
length(first_name),
char_length(first_name), 
character_length(first_name)
from employees;
 -- 문자 갯수
 select first_name,
length(first_name),
char_length(first_name), 
character_length(first_name)
from employees;
 
 -- UBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len):
 select first_name, 
		substr(first_name,1,3),
        substr(first_name,2,2),
        substr(first_name,-3,2)
from employees
where department_id = 100;

select substr('990526-2345678',8,1), -- 민증 성별 구별 가능
	   substr('990526-1234567',8,1)
from dual;

-- LPAD(str, len, padstr): str 문자열 왼쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
-- RPAD(str, len, padstr)str 문자열 오른쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
select first_name,
	lpad(first_name,10,'*'),# 모두 10칸으로 만들어서 빈곳은 기호로 채우기! 왼쪽부터
    rpad(first_name,10,'*')# 모두 10칸으로 만들어서 빈곳은 기호로 채우기! 오른쪽부터
    from employees;
    
-- TRIM(str): str의 양쪽에 있는 공백 문자를 제거
-- LTRIM(str): str의 왼쪽에 있는 공백 문자를 제거
-- RTRIM(str): str의 오른쪽에 있는 공백 문자를 제거
select concat('|', '          안녕하세요          ','|'),
       concat('|', trim('         안녕하세요       '),'|'),
       concat('|', ltrim('         안녕하세요       '),'|'),
       concat('|', rtrim('         안녕하세요       '),'|')
       from dual;
    
-- REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경
select first_name, 
       replace(first_name, 'a', '*') # a를 *로 바꿔라
from employees
where department_id =100;

select first_name, 
       replace(first_name, 'a', '*'), 
       replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id =100;

-- 단일행 함수 --> 날짜/시간함수
#CURRENT_DATE() 또는 CURDATE() 현재 날짜를 반환
#CURRENT_TIME() 또는 CURTIME() 현재 시간을 반환
#CURRENT_TIMESTAMP() 또는 NOW() 현재 날짜와시간을 반환
#ADDDATE(), DATE_ADD() 날짜 시간 더하기
#SUBDATE(), DATE_SUB() 날짜 시간 빼기
#DATEDIFF() 두 날짜간 일수차
#TIMEDIFF() 두 날짜/시간 간 시간차

-- 날짜/시간함수
-- CURRENT_DATE() 또는 CURDATE(): 현재 날짜를 반환
-- CURRENT_TIME() 또는 CURTIME(): 현재 시간을 반환
-- CURRENT_TIMESTAMP() 또는 NOW(): 현재 날짜와시간을 반환
select current_date(), curdate();
select current_time(), curtime();
select current_timestamp(), now();

/* MySQL에서 날짜 및 시간 타입의 데이터는 '1970-01-01 00:00:00' UTC를 기준으로 저장됩니다.
예) 1970-01-01 00:00:00 ->0
    1970-01-01 00:00:01 ->1
    1970-01-01 00:02:00 ->120 */
    
-- ADDDATE() 또는 DATE_ADD(): 날짜 시간 더하기
-- SUBDATE() 또는 DATE_SUB(): 날짜 시간 빼기
select adddate('2021-06-20 00:00:00', INTERVAL 1 YEAR), -- > 2022-06-20 00:00:00
adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH),       -- > 2022-07-20 00:00:00
adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK),        -- > 2022-06-27 00:00:00
adddate('2021-06-20 00:00:00', INTERVAL 1 DAY),         -- > 2022-06-21 00:00:00
adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR),        -- > 2022-06-20 01:00:00
adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE),      -- > 2022-06-20 00:01:00
adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND);      -- > 2022-06-20 00:00:01
# subdate()비교 
-- 음수로 넣으면 빼기 효과 subdate()
select subdate('2021-06-20 00:00:00', INTERVAL 1 YEAR), -- > 2020-06-20 00:00:00
subdate('2021-06-20 00:00:00', INTERVAL 1 MONTH),       -- > 2021-05-20 00:00:00
subdate('2021-06-20 00:00:00', INTERVAL 1 WEEK),        -- > 2021-06-13 00:00:00
subdate('2021-06-20 00:00:00', INTERVAL 1 DAY),         -- > 2021-06-19 00:00:00
subdate('2021-06-20 00:00:00', INTERVAL 1 HOUR),        -- > 2021-06-19 23:00:00
subdate('2021-06-20 00:00:00', INTERVAL 1 MINUTE),      -- > 2021-06-19 23:59:00
subdate('2021-06-20 00:00:00', INTERVAL 1 SECOND);      -- > 2021-06-19 23:59:59

-- DATEDIFF(): 두 날짜간 일수차
-- TIMEDIFF(): 두 날짜시간 간 시간차
select datediff('2021-06-21 01:05:05', '2021-06-21 01:00:00'),
       timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')
from dual;

select first_name, 
       hire_date,
round(datediff(now(), hire_date)/365,1) workday
from employees
order by workday desc;

-- 단일행 함수 --> 변환함수의 종류
#FORMAT() => 숫자 -> 문자열 *많이씀 중요
#DATE_FORMAT(date, format) => 날짜(시간) -> 문자열 *많이씀 중요
#STR_TO_DATE(str, format) => 문자열 -> 날짜(시간)

-- ■ 변환함수: 날짜(시간)->문자열
-- DATE_FORMAT(date, format): date를 format형식으로 변환
select now(), -- 2024-01-14 
       date_format(now(),'%y-%m-%d %H:%i:%s'), -- 24-01-14 22:43:18
       date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p') -- 2024-01-14(Sun) 22:43:18 PM
from dual;

-- ■ 변환함수: 문자열->날짜(시간)
-- STR_TO_DATE(str, format): str를 format형식으로 변환
select datediff('2021-Jun-04', '2021-06-01'); -- 계산안됨

select str_to_date('2021-Jun-04 07:48:52', '%Y-%b-%d');
select str_to_date('2021-06-01 12:30:05', '%Y-%m-%d');

select datediff(str_to_date('2021-Jun-04 07:48:52', '%Y-%b-%d'), 
                str_to_date('2021-06-01 12:30:05', '%Y-%m-%d'));

-- ■ 변환함수
-- FORMAT(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력
SELECT format(1234567.89, 2),
       format(1234567.89, 0),
       format(1234567.89, -5);
       
#변환함수 [format 형식: DATE_FORMAT(date, format)]

/*구분     형식   의미                           결과       */
  #년  -- %Y   4자리 연도                       2024
	   -- %y   2자리 연도                       24
  #월  -- %m   2자리 월 (01 ~ 12)               01
       -- %c   1~2자리 월 (1 ~ 12)              1
       -- %M   월 이름                          January
	   -- %b   축약된 월 이름                    Jan
  #일  -- %d   2자리 일 (01 ~ 31)               07
	   -- %e   1~2자리 일 (1 ~ 31)              7
  #요일 -- %W   월요일을 시작으로 하는 주의 요일 이름   Wednesday
       -- %a   축약된 요일 이름                   Wed
  #시  -- %H   2자리 24시간 형식 시간 (00 ~ 23)    15
       -- %h   2자리 12시간 형식 시간 (01 ~ 12)    03
  #분  -- %i   2자리 분 (00 ~ 59)                09
  #초  -- %s   2자리 초 (00 ~ 59)                02
#오전/오후-- %p  AM 또는 PM                       PM

-- ■ 변환함수 CAST(expression AS type): expression을 type형식으로 변환
# MySql 타입 P53 표확인

-- 숫자-->문자열
select cast(1234567.89 as char);
-- 날짜-->문자열
select cast('2024-01-10' as char);
-- 문자열-->숫자 unsigned
select cast('1234' as unsigned); 
-- 문자열-->날짜
select cast('2024-01-10' as date);

-- ■ 변환함수
-- IFNULL(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력 (중요중요)
#- IF(), CASE~END 비교해볼것
select commission_pct, ifnull(commission_pct, 0)
from employees;

select commission_pct, ifnull(commission_pct, "없음")
from employees;




















