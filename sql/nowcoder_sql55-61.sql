-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL55 分页查询employees表，每5行一页，返回第2页的数据
SELECT *
FROM employees
LIMIT 5, 5;

-- SQL57 使用含有关键字exists查找未分配具体部门的员工的所有信息
SELECT *
FROM employees e
WHERE NOT EXISTS (SELECT dept_no
                  FROM dept_emp de
                  WHERE e.emp_no = de.emp_no);

-- SQL59 获取有奖金的员工相关信息
--       给出emp_no、first_name、last_name、奖金类型btype、对应的当前薪水情况salary
--       以及奖金金额bonus。bonus类型btype为1其奖金为薪水salary的10%，btype为2其奖金为薪水的20%，
--       其他类型均为薪水的30%。 当前薪水表示to_date='9999-01-01'
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       eb.btype,
       s.salary,
       CASE WHEN eb.btype = 1 THEN s.salary * 0.1
            WHEN eb.btype = 2 THEN s.salary * 0.2
            ELSE s.salary * 0.3
       END AS bonus
FROM employees e
JOIN emp_bonus eb ON e.emp_no = eb.emp_no
JOIN salaries  s  ON e.emp_no = s.emp_no
WHERE s.to_date='9999-01-01';

-- SQL60 统计salary的累计和running_total
SELECT emp_no,
       salary,
       SUM(salary) OVER (ORDER BY emp_no) AS running_total
FROM salaries
WHERE to_date = '9999-01-01';

-- SQL61 对于employees表中，给出奇数行的first_name(按first_name升序排序, 且输出时不需排序)
SELECT e.first_name
FROM employees e,
     (SELECT first_name,
             ROW_NUMBER() OVER (ORDER BY first_name) AS row_num
      FROM employees) AS r
WHERE e.first_name = r.first_name
  AND r.row_num % 2 = 1;