-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
	select c.emp_no, d.salary
      from employees c
      join salaries d
        on c.emp_no = d.emp_no
     where d.to_date = '9999-01-01'
       and d.salary > (
						select avg(b.salary) as sal_avg
					      from employees a
					      join salaries b
					        on a.emp_no = b.emp_no
					     where b.to_date = '9999-01-01');
-- 문제2.
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.
    select a.emp_no,
           concat(a.first_name, ' ', a.last_name) as name,
           c.dept_name,
           d.salary
      from employees a
      join dept_emp b
        ON a.emp_no = b.emp_no
      join departments c
        on b.dept_no = c.dept_no
      join salaries d
        ON a.emp_no = d.emp_no
      join (select b.dept_no, max(c.salary) as sal_max
		      from employees a
		      join dept_emp b
		        ON a.emp_no = b.emp_no
		      join salaries c
		        ON a.emp_no = c.emp_no
		     where b.to_date = '9999-01-01'
		       and c.to_date = '9999-01-01'
		     group by b.dept_no) e
        on b.dept_no = e.dept_no
       and d.salary = e.sal_max
     where b.to_date = '9999-01-01'
       and d.to_date = '9999-01-01'
     order by d.salary desc;
-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요
   select a.emp_no,
   		  concat(a.first_name, ' ', a.last_name) as name,
          c.salary
     from employees a
     join dept_emp b ON a.emp_no = b.emp_no
     join salaries c ON a.emp_no = c.emp_no
     join (select b.dept_no,
		   		  avg(c.salary) as sal_avg
		     from employees a
		     join dept_emp b ON a.emp_no = b.emp_no
		     join salaries c ON a.emp_no = c.emp_no
		    where b.to_date = '9999-01-01'
		      and c.to_date = '9999-01-01'
		    group by b.dept_no) d on b.dept_no = d.dept_no
    where b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
      and c.salary  > d.sal_avg
    order by a.emp_no asc;
-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
   select a.emp_no,
   		  concat(a.first_name, ' ', a.last_name) as name,
          c.dept_name,
          (select concat(aa.first_name, ' ', aa.last_name)
          	 from employees aa
            where aa.emp_no = d.emp_no) as manager_name
     from employees a
     join dept_emp b ON a.emp_no = b.emp_no
     join departments c on b.dept_no = c.dept_no
     join dept_manager d on b.dept_no = d.dept_no
    where b.to_date = '9999-01-01'
      and d.to_date = '9999-01-01'
    order by a.emp_no;
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
   select a.emp_no,
   		  concat(a.first_name, ' ', a.last_name) as name,
          b.title,
          c.salary
     from employees a
     join titles b ON a.emp_no = b.emp_no
     join salaries c ON a.emp_no = c.emp_no
     join dept_emp d on a.emp_no = d.emp_no
     join (select b.dept_no,
		   		  avg(c.salary)
		     from employees a
		     join dept_emp b ON a.emp_no = b.emp_no
		     join salaries c ON a.emp_no = c.emp_no
		    where b.to_date = '9999-01-01'
		      and c.to_date = '9999-01-01'
		    group by b.dept_no
		    order by avg(c.salary) desc
		    limit 1) e on d.dept_no = e.dept_no
    where b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
      and d.to_date = '9999-01-01'
    order by c.salary;
-- 문제6.
-- 평균 연봉이 가장 높은 부서는?
   select a.dept_name, b.sal_avg
     from departments a
     join (select b.dept_no,
		   		  avg(c.salary) as sal_avg
		     from employees a
		     join dept_emp b on a.emp_no = b.emp_no
		     join salaries c ON a.emp_no = c.emp_no
		    where b.to_date = '9999-01-01'
		      and c.to_date = '9999-01-01'
		    group by b.dept_no) b on a.dept_no = b.dept_no
     order by sal_avg desc
     limit 1;
-- 문제7.
-- 평균 연봉이 가장 높은 직책?
   select b.title,
 		  avg(c.salary) as sal_avg
     from employees a
   	 join titles b on a.emp_no = b.emp_no
   	 join salaries c ON a.emp_no = c.emp_no
  	where b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
  	group by b.title
	order by avg(c.salary) desc
    limit 1;
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
   select d.dept_name,
   		  concat(a.first_name, ' ', a.last_name) as name,
          c.salary,
          e.manager_name,
          e.manager_salary
     from employees a
     join dept_emp b on a.emp_no = b.emp_no
     join salaries c ON a.emp_no = c.emp_no
     join departments d on b.dept_no = d.dept_no
     join (select a.emp_no,
     			  concat(a.first_name, ' ', a.last_name) as manager_name,
		   		  b.dept_no,
		          c.salary as manager_salary
		     from employees a
		     join dept_manager b ON a.emp_no = b.emp_no
		     join salaries c on a.emp_no = c.emp_no
		    where b.to_date = '9999-01-01'
		      and c.to_date = '9999-01-01') e on b.dept_no = e.dept_no
    where b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
      and c.salary  > e.manager_salary
    order by d.dept_name,
   			 concat(a.first_name, ' ', a.last_name),
          	 c.salary,
          	 e.manager_name,
          	 e.manager_salary
