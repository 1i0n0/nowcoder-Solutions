-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL21 查找在职员工自入职以来的薪水涨幅情况
SELECT current.emp_no, 
       current.salary - hire.salary AS growth
FROM (SELECT emp_no, salary
      FROM salaries
      WHERE to_date = '9999-01-01') AS current
JOIN (SELECT e.emp_no, s.salary
      FROM salaries s, employees e
      WHERE s.from_date = e.hire_date) AS hire
ON current.emp_no = hire.emp_no
ORDER BY growth;

-- SQL22 统计各个部门的工资记录数
SELECT d.dept_no,
       d.dept_name,
       COUNT(salary) AS 'sum'
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_no
ORDER BY d.dept_no;

-- SQL23 对所有员工的薪水按照salary降序进行1-N的排名
SELECT emp_no, salary, 
       DENSE_RANK() OVER (ORDER BY salary DESC) AS t_rank
FROM salaries
ORDER BY t_rank, emp_no;

--
SELECT s1.emp_no, 
       s1.salary, 
       SUM(CASE WHEN s1.salary <= s2.salary THEN 1
                  ELSE 0
             END) AS t_rank
FROM salaries s1,
     (SELECT DISTINCT salary FROM salaries) s2
GROUP BY s1.emp_no
ORDER BY t_rank, emp_no;

--
SELECT s1.emp_no, 
       s1.salary, 
       COUNT(DISTINCT s2.salary) AS t_rank
FROM salaries s1, salaries s2
WHERE s1.salary <= s2.salary
GROUP BY s1.emp_no
ORDER BY t_rank, emp_no;

-- SQL24 获取所有非manager员工当前的薪水情况
SELECT de.dept_no,
       e.emp_no,
       s.salary
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no NOT IN (SELECT emp_no FROM dept_manager)
  AND s.to_date = '9999-01-01';
  
--
SELECT de.dept_no,
       e.emp_no,
       s.salary
FROM employees e,
     dept_emp de,
     dept_manager dm,
     salaries s
WHERE e.emp_no = de.emp_no
  AND de.dept_no = dm.dept_no
  AND e.emp_no <> dm.emp_no
  AND e.emp_no = s.emp_no
  AND s.to_date = '9999-01-01';

-- SQL25 获取员工其当前的薪水比其manager当前薪水还高的相关信息
SELECT dept_emp.emp_no,
       dept_manager.emp_no AS manager_no,
       es.salary AS emp_salary,
       ms.salary AS manager_salary
FROM dept_emp
JOIN dept_manager ON dept_emp.dept_no = dept_manager.dept_no
JOIN salaries es ON dept_emp.emp_no = es.emp_no
JOIN salaries ms ON dept_manager.emp_no = ms.emp_no
WHERE es.to_date = '9999-01-01'
  AND ms.to_date = '9999-01-01'
  AND es.salary > ms.salary;
  