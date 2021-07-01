-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL1 查找最晚入职员工的所有信息
SELECT *
FROM employees
ORDER BY hire_date DESC
LIMIT 1;

-- 
SELECT *
FROM employees
WHERE hire_date >= ALL (SELECT hire_date FROM employees);

--
SELECT *
FROM employees
WHERE hire_date = (SELECT MAX(hire_date) FROM employees);

-- SQL2 查找入职员工时间排名倒数第三的员工所有信息
SELECT *
FROM employees
ORDER BY hire_date DESC
LIMIT 2, 1;

--
SELECT *
FROM employees
WHERE hire_date = (SELECT DISTINCT hire_date
                   FROM employees
                   ORDER BY hire_date DESC
                   LIMIT 2, 1);

-- SQL3 查找当前薪水详情以及部门编号dept_no
SELECT salaries.emp_no,
       salaries.salary,
       salaries.from_date,
       salaries.to_date,
       dept_manager.dept_no
FROM dept_manager
JOIN salaries
ON dept_manager.emp_no = salaries.emp_no
ORDER BY salaries.emp_no;

--
SELECT salaries.emp_no,
       salaries.salary,
       salaries.from_date,
       salaries.to_date,
       dept_manager.dept_no
FROM dept_manager, salaries
WHERE dept_manager.emp_no = salaries.emp_no
ORDER BY salaries.emp_no;

-- SQL4 查找所有已经分配部门的员工的last_name和first_name
SELECT employees.last_name,
       employees.first_name,
       dept_emp.dept_no
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no;

-- 
SELECT employees.last_name,
       employees.first_name,
       dept_emp.dept_no
FROM employees, dept_emp
WHERE employees.emp_no = dept_emp.emp_no;
                
-- SQL5 查找所有员工的last_name和first_name以及dept_no，也包括暂时没有分配具体部门的员工
SELECT employees.last_name,
       employees.first_name,
       dept_emp.dept_no
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no;
