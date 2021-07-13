-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL43 将所有to_date为9999-01-01的全部更新为NULL
UPDATE titles_test
SET to_date = NULL, from_date = '2001-01-01'
WHERE to_date = '9999-01-01';

-- SQL44 将id=5以及emp_no=10001的行数据替换成id=5以及emp_no=10005,
--       其他数据保持不变，使用replace实现，直接使用update会报错。
UPDATE titles_test
SET emp_no = REPLACE(emp_no, 10001, 10005)
WHERE id = 5
  AND emp_no = 10001;

-- SQL45 将titles_test表名修改为titles_2017
RENAME TABLE titles_test TO titles_2017;

-- SQL46 在audit表上创建外键约束，其emp_no对应employees_test表的主键id
ALTER TABLE audit
ADD FOREIGN KEY (EMP_no)
REFERENCES employees_test(id);

-- SQL48 将所有获取奖金的员工当前的薪水增加10%
UPDATE salaries
SET salaries.salary = salaries.salary * 1.1
WHERE salaries.to_date = '9999-01-01'
  AND salaries.emp_no IN (SELECT emp_no FROM emp_bonus);
