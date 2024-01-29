/*********************************
             5일차
**********************************/
-- ------------------------------
# 내일 예고 - SubQuery
# 질문안에 질문이 들어가는 형태로 각각의 질문을 잘해야 한다.
# 따라서 오늘배운것까지 열심히 해서 정확한 질문을 하자
-- ------------------------------
-- 'Den' 보다 월급을 많은 사람의 이름과 월급은?
-- 1) Den의 월급을 구한다.  Den의 월급이 11000 이라고 하면
-- 2) 월급이 11000보다 많은 사람의 이름과 월급은?

-- 1) Den의 월급을 구한다.
select  salary
from employees
where first_name = 'Den';  -- 11000

-- 2) 월급이 11000보다 많은 사람의 이름과 월급은?
select first_name, 
       salary
from employees
where salary >= 11000;

-- 3) 합치기
select first_name, 
       salary
from employees
where salary >= (select  salary
                 from employees
                 where first_name = 'Den');
-- --------------------------------------------                 
-- 단일행은 바로 기호쓰고 사용 가능, 다중행(IN,ANY,ALL) 구분
-- --------------------------------------------
-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
# 한번에 출력 안되는 이유는 단일행 + 다중행이기 때문에 히힛!!
-- 1) 이름 월급 사원번호?
select first_name,
       salary,
       employee_id
from employees;

-- 2) 월급을 가장 적게받는 사람은?
select min(salary)-- 최소월급
from employees;

-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
select first_name,
       salary,
       employee_id
from employees
where salary = (select min(salary)
                from employees);
                
                
-- ▪ 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요?
-- 1) 평균월급 조회
select avg(salary)-- 평균월급
from employees;
-- 2) 적게받는 사람의 이름 월급
select first_name,
       salary
from employees;
-- ▪ 합치기         
select first_name,
       salary
from employees
where salary >(select avg(salary)
               from employees);
               
-- ------------------------------------
--  SubQuery - IN
-- ------------------------------------
               
-- 부서번호가 110인 직원의 급여와 같은 월급을 받는 모든 직원의 사번, 이름, 급여를 출력하세요
-- 1. 전체 직원테이블에서 월급이 10000인 직원 구하기
select *
from employees
where salary in (12008,8300);
-- 2. 부서번호가 110인 사람월급 구하기
select *
from employees
where department_id = 110;
-- 3. 합치기 
select first_name, 
       salary
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);
                 
-- ▪ 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요

-- 부서 사원이름 월급
select first_name,
       salary,
       department_id,
       employee_id
from employees;

--  각 부서별 최고급여
select department_id,
       max(salary)
from employees
group by department_id;

-- 합치기
select department_id,-- 부서
       first_name,-- 직원이름
       salary-- 월급
from employees
where (department_id,salary) in (select department_id,-- 각 부서 
                                        max(salary) -- 최고급여
                                 from employees
                                 group by department_id);-- 각 부서별 

/*
각 부서별로 최고월급를 받는 사원의 이름과 월급을 출력하세요
1. 각부서별 최고월급을 구한다 --> 1이상  100부서는 10000,   200번부서는 20000)
2. 직원테이블에서 월급이 10000 또는 20000인 구한다
3. 합친다
*/
-- 각 부서별 최고월급
select max(salary) 
from employees
group by department_id;

-- 전체
select *
from employees
where salary in ('각부서별 최고월급');

-- 합치기
-- 부서번호를 제외하고 부서의 최고월급값만 가져와서 비교
-- 다른부서의 같은 월급의 받는 직원도 결과에 포함된다
-- where절에서 부서번호와 월급이 동시에 만족하는 직원만 결과에 포함되어야 한다
select  first_name,
        salary,
        department_id
from employees
where salary in (select max(salary) 
                 from employees
                 group by department_id)
;               
                
-- in 문법 확장 (문법테스트)
-- 여러가지 컬럼을 동시에 비교가능, 컬럼의 갯수와 데이터의 갯수가 일치해야 한다
select  first_name,
        salary,
        department_id
from employees
where (department_id, salary) in ( (10, 4400), (20, 13000), (30,11000) )
;

-- 다시 합치기
-- where절의 in 문법이 컬럼2개(department_id, salary)를 비교하는것으로 변경
select  first_name,
        salary,
        department_id
from employees
where (department_id, salary) in ( select department_id, max(salary) 
                                   from employees
                                   group by department_id  );

/*
부서별 최고값 이름
부서별 최고값 이름
월급 최저인 직원의 월급과 이름 --> in --> in확장 
*/
select min(salary)
from employees;

select salary,
       first_name
from employees
where salary = (select min(salary)
                from employees);
                
                
-- ------------------------------------
--  SubQuery - ANY (or)
-- ------------------------------------
  -- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
  -- 부서번호가 110인 직원의 급여
  select *
  from employees
  where department_id = 110; -- 12008,8300
  
  -- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 이름, 급여를 출력하세요
  select first_name,
         salary
  from employees
  where salary > any (select salary 
                      from employees
                      where department_id = 110);
                      
-- 월급이 110보다 큰 직원의 이름, 급여를 출력하세요	
select first_name,
       salary
from employees
where salary > 15000;	

-- ------------------------------------
--  SubQuery - ALL (and)
-- ------------------------------------
-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)

select*
from employees
where department_id=110;

select first_name,
        salary
from employees
where salary > all (select salary
				    from employees
                    where department_id=110);
                    
/*SubQuery
■ 조건절에서 비교 vs 테이블에서 조인
▪ 각 부서별로 최고월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요*/
-- 1. 각 부서별 최고월급
select department_id,
       max(salary)
from employees
group by department_id;
-- 2. 부서번호.직원번호.이름.월급
select department_id,
       employee_id,
       first_name,
       salary
from employees;
-- 3. 합치기
select department_id,
       employee_id,
       first_name,
       salary
from employees
where (department_id, salary) in (select department_id,
                                        max(salary)
                                 from employees
                                 group by department_id);
                

select e.department_id, -- employees 테이블
       e.employee_id,  
	   e.first_name, 
       e.salary
from employees e, (select department_id, 
						  max(salary) salary
                   from employees
				   group by department_id) s -- S라는 새로운 테이블 생성
where e.department_id = s.department_id
and e.salary = s.salary;

-- ------------------------------------------------------------
-- limit
-- ------------------------------------------------------------
select employee_id, 
       first_name, salary
from employees
order by employee_id asc
limit 0, 5; -- 1번부터 5개

select employee_id,
       first_name, salary
from employees
order by employee_id asc
limit 1, 5; -- 2번부터 5개

select employee_id, 
       first_name, salary
from employees
order by employee_id asc
limit 10, 5; -- 10번부터 5개

select employee_id,
       first_name, salary
from employees
order by employee_id asc
limit 5 offset 0; -- 1번부터 5개

select employee_id, 
	   first_name, salary
from employees
order by employee_id asc
limit 5 offset 1; -- 2번부터 5개

select employee_id, first_name, salary
from employees
order by employee_id asc
limit 5 offset 10; -- 11번부터 5개

-- ▪ 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?
-- 07년도 입사
-- 급여가 가장 많음
-- limit (2,5)

select employee_id,
       hire_date,
       salary
from employees
where hire_date >= '07/01/01' -- 07년도 입사
and hire_date < '07/12/31'
order by salary desc
limit 2,5;











