
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
-- where salary >= 20000 (where절에는 group by함수를 쓸 수 없다.) 
group by department_id;

/****************************************************
					HAVING절
*****************************************************/
-- 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력
select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary)>= 20000;
-- having 절에는 그룹함수와 Group by에 참여한 컬럼만 사용할 수 있다.

select department_id, 
	   count(*), 
       sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id = 100;

/****************************************************
          IF ~ ELSE 문 /CASE ~ END 문
*****************************************************/
select first_name,
       salary,
       commission_pct,
       if(commission_pct is null,0,1)as state
       -- 조건식 참일때 , 거짓일때
from employees;
/* •모든 직원의 이름, 월급, 수당, 상태(state)을 출력하세요
상태컬럼은 수당이 없으면 0, 수당이 있으면 1 을 state 컬럼에 표시하세요*/

-- - IFNULL(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력
select commission_pct, 
ifnull(commission_pct, 0)
from employees;

/*•직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
  실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,
				   'SA_REP' 월급+월급*0.2,
                   'ST_CLERL' 면 월급+월급*0.3
					그외에는 월급으로 계산하세요*/
select employee_id,
       salary,
       job_id,
       case when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
            when job_id = 'SA_REP' then salary + salary * 0.2
            when job_id = 'ST_CLERL' then salary + salary * 0.3
            else salary
       end realsalary
from employees;

/*▪ 직원의 이름, 부서번호, 팀을 출력하세요
    팀은 코드로 결정하며 부서코드가
    10~50 이면 'A-TEAM'
    60~100이면 'B-TEAM' 
    110~150이면 'C-TEAM' 
    나머지는 '팀없음' 으로 출력하세요*/
    
    select first_name,
           department_id,
		   case when department_id between 10 and 50 then 'A-TEAM'
                 when department_id between 60 and 100  then 'B-TEAM'
                 when department_id between 110 and 150  then 'C-TEAM' 
                 else '팀없음' 
           end team
    from employees;

    select first_name,
           department_id,
			case when department_id >= 10 and department_id <= 50 then 'A-TEAM'
                 when department_id >= 60 and department_id <= 100  then 'B-TEAM'
                 when department_id >= 110 and department_id <= 150  then 'C-TEAM'
                 else '팀없음' 
           end team
    from employees;
    
    /****************************************************
                       JOIN(테이블 조인)
*****************************************************/
-- 사원이름, 부서명 , 부서번호 <--- 원하는 결과
-- 데이터가 2개의 테이블(employees, departments)에 나눠져 있다

-- 직원
select *
from employees;

-- 부서
select *
from departments;


-- 2개의 데이블을 합치기 (join)
-- 107*27개의 row값이 생기고
-- 두테이블의 모든 컬럼이 한개로 합쳐진다 
-- (department_id 컬럼은 양쪽테이블에 있음)
select *
from employees, departments;

-- 원하는 컬럼명만 출력
-- department_id 컬럼때문에 오류(양쪽테이블에 같은 컬럼명으로 존재)
-- 어느테이블의 department_id 컬럼인지 명확하게 표시해야함
select  first_name, 
        department_name, 
        department_id
from employees, departments
; -- 오류

-- 테이블명을 써서 department_id 컬럼 어느테이블인지 표시함
select  first_name, 
        department_name, 
        employees.department_id,
        departments.department_id
from employees, departments;

-- 테이블 별명쓰기
-- 겹치지 않는 컬럼명은 테이블 별명을 쓰지 않아도 된다
-- 하지만 써도 된다
-- 겹치는 컬럼명은 꼭 써야 된다
select  e.first_name, 
        d.department_name, 
        e.department_id,
        d.department_id
from employees e, departments d
where e. department_id=d.department_id;

# EQUI Join (inner join)
select  e.first_name, 
        d.department_name, 
        e.department_id,
        d.department_id
from employees e
inner join departments d
  on e.department_id=d.department_id;
  
select first_name, -- 테이블에 별명을 사용.
       em.department_id,
       department_name, 
       de.department_id
from employees em inner join departments de
on em.department_id = de.department_id;

select first_name, -- inner 생략가능
       em.department_id,
       department_name, 
       de.department_id
from employees em join departments de
on em.department_id = de.department_id;

select first_name, -- where절 사용(가장 많이 쓰는 형태)
       em.department_id,
       department_name, 
       de.department_id
from employees em, departments de
where em.department_id = de.department_id;

# 모든 직원이름, 부서이름, 업무명 을 출력하세요 *3개의 테이블
select first_name, 
       department_name, 
       job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

select first_name, 
       department_name, 
       job_title
from employees e  
inner join  departments d  
      on e.department_id = d.department_id
inner join  jobs j
      on e.job_id = j.job_id;

# 이름, 부서번호, 부서명, 업무아이디, 업무명, 도시아이디, 도시명
-- 직원(이름,부서아이디,업무아이디)
-- 부서(부서아이디,부서명)
-- 업무(업무아이디,업무명,도시아이디)
-- 도시(도시아이디,도시명)
select e.first_name,
       e.department_id,
       d.department_name,
       e.job_id,
       j.job_id,
       j.job_title,
       d.location_id,
       l.location_id,
       l.city
from employees e, departments d, jobs j, locations l
where e.department_id = d.department_id 
and e.job_id = j.job_id
and d.location_id = l.location_id;

select e.first_name,
       e.department_id,
       d.department_id,
       d.department_name,
       e.job_id,
       j.job_id,
       j.job_title,
       d.location_id,
       l.location_id,
       l.city
from employees e
inner join departments d
	on e.department_id = d.department_id 
inner join jobs j
    on e.job_id = j.job_id
inner join locations l
	on d.location_id = l.location_id;

