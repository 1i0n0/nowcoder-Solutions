-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL7 查找薪水记录超过15次的员工号emp_no以及其对应的记录次数t
SELECT emp_no, COUNT(emp_no) AS t
FROM salaries
GROUP BY emp_no
HAVING t > 15;

-- SQL8 找出所有员工具体的薪水salary情况，对于相同的薪水只显示一次，并按照逆序显示
SELECT DISTINCT salary
FROM salaries
WHERE to_date = '9999-01-01'
ORDER BY salary DESC;

-- 
SELECT salary
FROM salaries
WHERE to_date = '9999-01-01'
GROUP BY salary
ORDER BY salary DESC;

-- SQL10 获取所有非manager的员工emp_no
SELECT emp_no
FROM employees
WHERE emp_no NOT IN (SELECT emp_no FROM dept_manager);

--
SELECT employees.emp_no
FROM employees
LEFT JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.dept_no IS NULL;

-- SQL11 获取所有员工当前的manager
SELECT dept_emp.emp_no, 
       dept_manager.emp_no AS manager
FROM dept_emp
JOIN dept_manager
ON dept_emp.dept_no = dept_manager.dept_no
WHERE dept_emp.emp_no <> dept_manager.emp_no
  AND dept_emp.to_date     = '9999-01-01'
  AND dept_manager.to_date = '9999-01-01';

-- 
SELECT dept_emp.emp_no, 
       dept_manager.emp_no AS manager
FROM dept_emp, dept_manager
WHERE dept_emp.dept_no = dept_manager.dept_no
  AND dept_emp.emp_no <> dept_manager.emp_no
  AND dept_emp.to_date     = '9999-01-01'
  AND dept_manager.to_date = '9999-01-01';
                
-- SQL12 获取每个部门中当前员工薪水最高的相关信息
SELECT dept_no, emp_no, salary AS maxSalary
FROM (SELECT dept_no, salaries.emp_no, salary,
             RANK() OVER (PARTITION BY dept_no ORDER BY salary DESC) AS r
      FROM dept_emp
      JOIN salaries
      ON dept_emp.emp_no = salaries.emp_no
      WHERE salaries.to_date = '9999-01-01'
     ) AS salaries_rank
WHERE r = 1;

--
SELECT e1.dept_no,
       e1.emp_no,
       s1.salary
FROM dept_emp e1, salaries s1
WHERE e1.emp_no = s1.emp_no
  AND s1.to_date = '9999-01-01'
  AND s1.salary = (SELECT MAX(s2.salary)
                   FROM dept_emp e2, salaries s2
                   WHERE e2.emp_no = s2.emp_no
                     AND e1.dept_no = e2.dept_no
                     AND s2.to_date = '9999-01-01'
                  )
ORDER BY e1.dept_no;