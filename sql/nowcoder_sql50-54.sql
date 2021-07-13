-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL50 将employees表中的所有员工的last_name和first_name通过(')连接起来
SELECT CONCAT(last_name, '\'', first_name) AS name
FROM employees;

-- SQL51 查找字符串 10,A,B 中逗号,出现的次数cnt
SELECT LENGTH(REGEXP_REPLACE('10,A,B', '[^,]*', '')) AS cnt;

-- SQL52 获取Employees中的first_name，查询按照first_name最后两个字母，按照升序进行排列
SELECT first_name
FROM employees
ORDER BY SUBSTRING(first_name, -2);

-- SQL53 按照dept_no进行汇总，属于同一个部门的emp_no按照逗号进行连接，
--       结果给出dept_no以及连接出的结果employees
SELECT dept_no, GROUP_CONCAT(emp_no) AS employees
FROM dept_emp
GROUP BY dept_no;

-- SQL54 查找排除最大、最小salary之后的当前(to_date = '9999-01-01' )员工的平均工资avg_salary
SELECT AVG(salary) AS avg_salary
FROM salaries
WHERE to_date = '9999-01-01'
  AND salary NOT IN (SELECT MAX(salary) 
                     FROM salaries 
                     WHERE to_date = '9999-01-01')
  AND salary NOT IN (SELECT MIN(salary) 
                     FROM salaries 
                     WHERE to_date = '9999-01-01');
