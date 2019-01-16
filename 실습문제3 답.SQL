-- 문제 1.
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
   select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', c.sal_max as '연봉'
     from employees a
     join (
   	 		select b.emp_no, max(b.salary) as sal_max
     		  from salaries b
    		 where b.to_date = '9999-01-01'
    		 group by b.emp_no) c
   	   on a.emp_no = c.emp_no
    order by c.sal_max desc;
-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
    select a.emp_no,
           concat(a.first_name, ' ', a.last_name) as name,
           b.title
      from employees a
      join titles b
        on a.emp_no = b.emp_no
     where b.to_date = '9999-01-01'
     order by concat(a.first_name, ' ', a.last_name) asc;
-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
    select a.emp_no,
           concat(a.first_name, ' ', a.last_name) as name,
           c.dept_name
      from employees a
      join dept_emp b
        on a.emp_no = b.emp_no
      join departments c
        on b.dept_no = c.dept_no
     where b.to_date = '9999-01-01'
     order by concat(a.first_name, ' ', a.last_name) asc;
-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
   select a.emp_no,
   		  concat(a.first_name, ' ', a.last_name) as name,
          b.salary,
          c.title,
          e.dept_name
     from employees a
     left join salaries b
       on a.emp_no = b.emp_no
     left join titles c
       on a.emp_no = c.emp_no
     left join dept_emp d
       on a.emp_no = d.emp_no
     join departments e
       on d.dept_no = e.dept_no
    where b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
      and d.to_date = '9999-01-01'
    order by concat(a.first_name, ' ', a.last_name) asc;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
   select b.emp_no,
   		  concat(b.first_name, ' ', b.last_name) as name
     from titles a
     join employees b
       on a.emp_no = b.emp_no
    where a.title = 'Technique Leader'
      and a.to_date != '9999-01-01'
    order by a.emp_no;
-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
   select a.last_name,
          c.dept_name,
          d.title
     from employees a
     join dept_emp b
       on a.emp_no = b.emp_no
     join departments c
       on b.dept_no = c.dept_no
     join titles d
       on a.emp_no = d.emp_no
    where SUBSTRING(a.last_name, 1, 1) = 'S'
    order by a.last_name;
-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
   select a.emp_no,
          b.salary
     from titles a
     join salaries b
       on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01'
      and a.title = 'Engineer'
      and b.salary >= 40000
      and b.to_date = '9999-01-01'
    order by b.salary desc;
-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
   select b.title,
   		  a.salary
     from salaries a
     left join titles b
       on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01'
      and a.salary > 50000
    order by a.salary desc;
-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
   select avg(b.salary) as avg_sal,
          a.dept_no
     from dept_emp a
     join salaries b
       on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01'
      and b.to_date = '9999-01-01'
     group by a.dept_no
     order by avg(b.salary) desc;
-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
   select a.title, avg(b.salary) as avg_sal
     from titles a
     join salaries b
       on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01'
      and b.to_date = '9999-01-01'
    group by a.title
    order by  avg(b.salary) desc;
-- 예제5
-- 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
    select a.title,
   		  count(*) title_count,
          avg(b.salary) as salary
     from titles a
     left join salaries b
       on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01'
      and b.to_date = '9999-01-01'
    group by a.title
    having count(*) >= 100
    order by a.title;

-- 예제6
-- 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
   select d.dept_name,
          avg(c.salary) as salary
     from dept_emp a
     left join titles b
       on a.emp_no = b.emp_no
     left join salaries c
       on a.emp_no = c.emp_no
     join departments d
       on a.dept_no = d.dept_no
    where a.to_date = '9999-01-01'
      and b.to_date = '9999-01-01'
      and b.title = 'Engineer'
      and c.to_date = '9999-01-01'
    group by a.dept_no, d.dept_name
    order by d.dept_name;
 -- 에제7
 -- 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에
 -- 대해서 내림차순(DESC)로 정렬하세요
    select a.title,
           sum(b.salary) as salary_sum
      from titles a
      left join salaries b
        on a.emp_no = b.emp_no
      where a.title != 'Engineer'
      group by a.title
      having sum(b.salary) >= 2000000000
      order by sum(b.salary) desc;
