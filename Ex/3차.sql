
-- >단일행함수와 구룹함수의 차이점은 단일행은 세부적인 내용을 보여줌,그룹함수는 대표값을 보여줌.
/****************************************************
					그룹함수(대표값)
*****************************************************/

# 종류
--  avg() : 평균값을 반환합니다.
--  count() : 총 건 수를 반환합니다.
     -- > count(*)
     -- > count(컬럼명)
-- max() : 최대값을 반환합니다.
-- min() : 최소값을 반환합니다.
-- sum() : 합계를 반환합니다.

select sum(salary)
from employees;

-- 오류
select first_name,
       salary,
       sum(salary)
from employees;

-- 단일행 함수
select first_name,
       salary,
       round(salary,2)
from employees;

-- ------------------------
-- count() 총 갯수를 알려준다
-- ------------------------
select * 
from employees;

select count(*) -- 전체직원의 수 (null 포함)
from employees;

select count(*), 
	   count(commission_pct)-- 수당을 받는 직원 수 (null 제외)
from employees;

select count(first_name)
from employees;

select count(manager_id)
from employees;

-- •월급이 16000 초과 되는 직원의 수는?
select count(*)
from employees
where salary>16000;

-- -------------------------------
-- sum() --데이터들의 합계를 구하는 함수
-- -------------------------------
select count(*),
	   sum(salary)
from employees;

-- ---------------------------------
--  avg() --데이터들의 평균를 구하는 함수
-- ---------------------------------
select count(*),
       sum(salary),
       avg(salary)
from employees;

select count(*),
       sum(salary),
       avg(ifnull(salary,0))
from employees;

-- ------------------------------------------------------
--   max() / min() -- 입력된 값들중 가장 큰값/작은값 을 구하는 함수
-- -------------------------------------------------------
select count(*),
       max(salary), 
       min(salary)
from employees;

/****************************************************
					GROUP BY절
*****************************************************/
 select department_id,-- Group by에 참여한 컬럼이나 그룹함수만 올 수 있다
        avg(salary),
        max(salary)
 from employees
 group by department_id;
 #order by department_id asc;
 
 select department_id, 
		job_id, 
        count(*), 
        sum(salary)
from employees
group by department_id, job_id;

-- 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력
select department_id,
       count(*),
       sum(salary)
from employees
-- where salary >= 20000
group by department_id;




















