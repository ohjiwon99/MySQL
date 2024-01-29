#4일차
    -- ---------------------------------------------------------
   -- outer join
    -- ---------------------------------------------------------
#종류   
-- Left Outer Join: 왼쪽의 모든 튜플은 결과 테이블에 나타남
-- Right Outer Join: 오른쪽의 모든 튜플은 결과 테이블에 나타남
-- Full Outer Join: 양쪽 모두 결과 테이블에 참여 union

#모든 직원의 부서번호, 이름, 부서번호를 출력하세요
#부서번호가 없는 직원도 표시

-- ------------------------------
# left outer join
-- ------------------------------
-- 왼쪽 테이블을 기준으로 조인
-- (Kimberely 가 결과에 있어야 함:소속부서가 없는 직원)
select  e.department_id,
        e.first_name,
        d.department_name
from employees e 
left outer join departments d 
    on e.department_id = d.department_id
;


#모든 직원의 부서번호, 이름, 부서번호를 출력하세요
#직원이 없는 부서도 표시
-- ------------------------------
# right outer join
-- ------------------------------
--  오른쪽 테이블을 기준으로 조인
-- (Treasury, Corporate Tax 등 16개의 부서명이 결과에 있어야함:부서인원이 없는 부서명 )
select  e.department_id,
        first_name,
        d.department_name
from employees e
right outer join departments d
    on e.department_id = d.department_id
;

select first_name, e.department_id, d.department_name
from departments d
left outer join employees e 
    on e.department_id = d.department_id
;

-- ------------------------------
# full outer join
-- ------------------------------
-- mysql은 full outer join 문법이 없음
-- 그래서 각각의 결과를 구해서 합쳐야 함(union) 


(select  e.employee_id,         -- left조인
         e.department_id,
         e.first_name,
         d.department_name
from employees e
left outer join departments d
    on e.department_id = d.department_id)
union
(select  e.employee_id,         -- right조인
         e.department_id,
         e.first_name,
         d.department_name
from employees e
right outer join departments d
    on e.department_id = d.department_id)
    ;
     
     
-- 일부데이터 누락 되는 경우: 공유폴더에 엑셀파일 참고 
(select  -- e.employee_id,         -- left조인
         e.department_id,
         e.first_name,
         d.department_name
from employees e
left outer join departments d
    on e.department_id = d.department_id)
union
(select  -- e.employee_id,         -- right조인
         e.department_id,
         e.first_name,
         d.department_name
from employees e
right outer join departments d
    on e.department_id = d.department_id)
;
     
-- ------------------------------
# self join
-- ------------------------------
-- 같은 테이블을 다름이름으로 2개 메모리에 올린다
-- 직원번호, 직원이름, 매니저이름 을 출력하세요
select  e.employee_id,
        e.first_name,
        m.first_name manager_name
from employees e, employees m
where e.manager_id = m.employee_id
;


-- 같은 테이블을 2번 메모리에 올릴뿐이지 문법은 동일하다
-- 직원, 부서 조인과 비교해볼것
-- 직원이름, 부서이름
select  e.first_name,
        d.department_name
from employees e, departments d
where e.department_id = d.department_id
;

-- ------------------------------
# 잘못된 join
-- ------------------------------
-- 직원테이블의 월급과 로케이션 테이블의 id 값은 아무런 연관성이 없다
-- 조인을 할 경우 결과는 나오지만 아무런 의미없는 데이터가 나오게 된다
-- 따라서 조인을 할때는 조건은 주의 깊게 봐야한다
select  e.first_name,
        e.salary,
        l.location_id,
        l.street_address,
        l.city
from employees e, locations l
where e.salary = l.location_id
;


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