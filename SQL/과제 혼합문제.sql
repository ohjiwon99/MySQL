-- 혼합 SQL 문제입니다.
/*문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)*/
select manager_id,
       first_name,
       salary,
       commission_pct
from employees
where commission_pct is null 
and salary >3000;




/*문제2. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 월급
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하
세요
-조건절비교 방법으로 작성하세요
-월급의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)*/
-- 각 부서별로 최고의 월급을 받는 사원
select department_id,
       max(salary)
from employees
group by department_id;

-- 직원번호(employee_id), 이름(first_name), 월급(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id)
select employee_id,
       first_name,
        salary,
        hire_date,
        phone_number,
        department_id
from employees;
-- 조건절 비교
select employee_id,
       first_name,
        salary,
        hire_date,
        phone_number,
        department_id
from employees
where salary = (select department_id,
                        max(salary)
                 from employees
                 group by department_id);
/*문제3
매니저별 담당직원들의 평균월급 최소월급 최대월급을 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균월급이 5000이상만 출력합니다.
-매니저별 평균월급의 내림차순으로 출력합니다.
-매니저별 평균월급은 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균월급, 매니저별최소월급, 매
니저별최대월급 입니다.
(9건)*/

/*문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/

/*문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 월급, 입사일을 입사일 순서로 출력하세요*/






-- 6번부터 표있음
/*문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 월급(salary)과 근무하는 부서 이름
(department_name)은?*/

/*문제7.
평균월급(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 월급(salary)을 조회하시오.*/

/*문제8.
평균 월급(salary)이 가장 높은 부서명과 월급은? (limt사용하지 말고 그룹함수 사용할 것)*/

/*문제9.
평균 월급(salary)이 가장 높은 지역과 평균월급은? */

/*문제10.
평균 월급(salary)이 가장 높은 업무와 평균월급은? (limt사용하지 말고 그룹함수 사용할 것*/
