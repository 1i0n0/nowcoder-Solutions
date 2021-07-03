-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL15 查找employees表emp_no与last_name的员工信息
SELECT *
FROM employees
WHERE emp_no % 2 = 1
  AND last_name <> 'Mary'
ORDER BY hire_date DESC;

-- SQL16 统计出当前各个title类型对应的员工当前薪水对应的平均工资avg
SELECT titles.title,
       AVG(s.salary)
FROM titles
JOIN salaries s
ON titles.emp_no = s.emp_no
WHERE titles.to_date = '9999-01-01'
  AND      s.to_date = '9999-01-01'
GROUP BY titles.title
ORDER BY 2;

-- 
SELECT titles.title,
       AVG(s.salary)
FROM titles, salaries AS s
WHERE titles.emp_no = s.emp_no
  AND titles.to_date = '9999-01-01'
  AND      s.to_date = '9999-01-01'
GROUP BY titles.title
ORDER BY AVG(s.salary);

-- SQL17 获取当前薪水第二多的员工的emp_no以及其对应的薪水salary
SELECT emp_no, salary
FROM salaries
WHERE to_date = '9999-01-01'
ORDER BY salary DESC
LIMIT 1, 1;

--
SELECT emp_no, salary
FROM (SELECT emp_no,
             salary,
             DENSE_RANK() OVER (ORDER BY salary DESC) AS r
      FROM salaries
      WHERE to_date = '9999-01-01') AS salary_rank
WHERE r = 2;

--
SELECT s1.emp_no AS emp_no,
       s1.salary AS salary
FROM salaries s1, (SELECT DISTINCT salary 
                   FROM salaries
                   WHERE to_date = '9999-01-01') s2
WHERE s1.to_date = '9999-01-01'
GROUP BY emp_no
HAVING  1 = SUM(CASE WHEN s1.salary < s2.salary THEN 1
                     ELSE 0
                END);

-- SQL18 查找薪水排名第二多的员工编号emp_no、薪水salary、last_name以及first_name，
--       不能使用order by完成
SELECT e.emp_no,
       s.salary,
       e.last_name,
       e.first_name
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
  AND s.salary = (SELECT MAX(salary)
                  FROM salaries
                  WHERE to_date = '9999-01-01'
                    AND salary NOT IN (SELECT MAX(salary) 
                                       FROM salaries
                                       WHERE to_date = '9999-01-01'));

--
SELECT e.emp_no,
       s.salary,
       e.last_name,
       e.first_name
FROM employees e
JOIN (SELECT s1.emp_no AS emp_no,
             s1.salary AS salary,
             SUM(CASE WHEN s1.salary < s2.salary THEN 1
                      ELSE 0
                 END) AS num_greater
      FROM salaries s1, (SELECT DISTINCT salary 
                         FROM salaries
                         WHERE to_date = '9999-01-01') s2
      WHERE s1.to_date = '9999-01-01'
      GROUP BY emp_no) as s
ON e.emp_no = s.emp_no
WHERE s.num_greater = 1;
                
-- SQL19 查找所有员工的last_name和first_name以及对应的dept_name，也包括暂时没有分配部门的员工
SELECT e.last_name AS last_name,
       e.first_name AS first_name,
       d.dept_name
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no;
  
