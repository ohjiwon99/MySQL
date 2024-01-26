-- 서브쿼리(SUBQUERY) SQL 문제입니다.

/*문제1. --------------------------------------------------
평균 월급보다 적은 월급을 받는 직원은 몇명인지 구하시요.
(56건)----------------------------------------------------*/

select count(salary)
from employees
where salary <= (select avg(salary)
				from employees);

/*문제2. --------------------------------------------------------------------
평균월급 이상, 최대월급 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 월급(salary), 평균월급, 최대월급을 월급의 오름차
순으로 정렬하여 출력하세요 **조금 어려웠음 나중에 다시 풀어보기!
(51건)-------------------------------------------------------------------------*/
-- 평균월급/최대월급
select avg(salary),
       max(salary)
from employees;

select employee_id,
       first_name,
       salary
from employees
where salary >=(select avg(salary) -- 평균월급이상
                from employees);
                
select employee_id,
       first_name,
       salary
from employees
where salary <=(select max(salary) -- 최대월급이하
                from employees);


 -- order by salary asc;
-- 직원번호(employee_id), 이름(first_name), 월급(salary)
select employee_id,
       first_name,
       salary,
        avg(salary) asalary,
        max(salary) msalary
from employees
where salary 
group by asalary 
order by msalary asc;


-- 합치기
select employee_id,
       first_name,
       salary,
       avg(salary) ,
       max(salary) 
from employees
where salary >= (select avg(salary)from employees) 
and salary <= (select max(salary)from employees)
group by employee_id
order by salary asc ;

/*문제3.---------------------------------------------------------------------
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)------------------------------------------------------------------------*/

-- 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
select * -- 스티븐 부서 90
from employees
where department_id=90;

select *
from employees
where first_name ='Steven';

select location_id,
	   street_address,
       postal_code,
       city,
       state_province,
       country_id
from locations right outer join departments
				     on location_id = location_id
                     where department_id=90;
-- 합치기
select 	l.location_id
		,street_address
        ,postal_code
        ,city
        ,state_province
        ,country_id
from locations l right outer join departments d
				on l.location_id = d.location_id
where department_id = (select department_id
						from employees
						where first_name = 'Steven'
						and last_name = 'king');

/*문제4.-----------------------------------------------------------------
job_id 가 'ST_MAN' 인 직원의 월급보다 작은 직원의 사번,이름,월급을 월급의 내림차순으로
출력하세요 -ANY연산자 사용
(74건)-------------------------------------------------------------------*/

-- 1. job_id 가 'ST_MAN' 인 직원
select *
from employees
where job_id='ST_MAN'; -- (8000,8200,7900,6500,5800)
-- 2. 월급보다 작은 직원의 사번,이름,월급
select employee_id,
       first_name,
       salary
from employees;
-- 3. 합치기
select employee_id,
       first_name,
       salary
from employees
where salary < any (select salary
				   from employees
                    where job_id='ST_MAN'
                    order by salary desc);

/*문제5. -------------------------------------------------------------
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 월급의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)--------------------------------------------------------------------*/
-- 1) 그룹 사용 (각 부서별로 최고의 월급)
select department_id,
       max(salary)
from employees
group by department_id;
-- 2) 사원의 직원번호(employee_id), 이름(first_name)과 월급(salary) 부서번호(department_id)
select employee_id,
       first_name,
       salary,
       department_id
from employees;

-- 3) 조건절 합치기
select employee_id,
       first_name,
       salary,
       department_id
from employees 
where (department_id, salary) in (select department_id,
                                        max(salary)
								 from employees
				                 group by department_id
                                 order by salary desc);
                  
-- 4) 테이블조인 합치기
select e.employee_id,
       e.first_name,
       e.salary,
       e.department_id
from employees e, (select department_id,
                        max(salary) s
                 from employees
				  group by department_id)s
where e.department_id = s.department_id
and e.salary = s
order by salary desc;

/*문제6.---------------------------------------------------------
각 업무(job) 별로 월급(salary)의 총합을 구하고자 합니다. 
월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회하시오 
(19건)----------------------------------------------------------*/

-- 1. 각 업무(job) 별로 월급(salary)의 총합
select job_id,
       sum(salary)
from employees
group by job_id;

-- 2. 월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합 (내림차순)
select j.job_title,
       j.job_id 
from jobs j left outer join employees e
               on j.job_id = e.job_id;
               
select j.job_title
from jobs j left outer join employees e
               on j.job_id = e.job_id,(select job_id,
                                       sum(salary) Ssalary
			                           from employees
                                       group by job_id) s
		where j.job_id = s.job_id
order by Ssalary desc;

select j.job_title
		,s.sSalary
from jobs j ,(select job_id
					,sum(salary) sSalary
					from employees
					group by job_id) s
where j.job_id = s.job_id
order by sSalary desc;


/*문제7.
자신의 부서 평균 월급보다 월급(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 월급(salary)을 조회하세요
(38건)*/

-- 자신의 부서 평균 월급
select department_id,
       avg(salary)
from employees
group by department_id;

-- 자신의 부서 평균 월급보다 월급이 많은 직원의 직원번호,이름,월급

select employee_id,
       first_name,
       salary
from employees e , (select department_id
				,avg(salary) aSalary
				from employees
				group by department_id) a
where e.department_id = a.department_id
and e.salary > a.aSalary;

/*문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 월급, 입사일을 입사일 순서로 출력
하세요*/

select employee_id,
	   first_name,
       salary,
       hire_date
from employees
order by hire_date asc
limit 10,5;