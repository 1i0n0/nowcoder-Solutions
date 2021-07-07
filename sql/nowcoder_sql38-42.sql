-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL38 针对actor表创建视图actor_name_view
CREATE VIEW actor_name_view AS
SELECT first_name AS first_name_v,
       last_name AS last_name_v
FROM actor;

-- SQL39 针对salaries表emp_no字段创建索引idx_emp_no，查询emp_no为10005，使用强制索引
SELECT * 
FROM salaries 
FORCE INDEX (idx_emp_no) 
WHERE emp_no = 10005;

-- SQL40 在last_update后面新增加一列名字为create_date
ALTER TABLE actor
ADD create_date DATETIME NOT NULL DEFAULT '2020-10-01 00:00:00';

-- SQL41 构造一个触发器audit_log，在向employees_test表中插入一条数据的时候，
--       触发插入相关的数据到audit中
CREATE TRIGGER audit_log 
AFTER INSERT ON employees_test 
FOR EACH ROW INSERT INTO audit VALUES(NEW.id, NEW.name);

--SQL42 删除emp_no重复的记录，只保留最小的id对应的记录
DELETE FROM titles_test
WHERE id NOT IN (SELECT * 
                 FROM (SELECT MIN(id) 
                       FROM titles_test 
                       GROUP BY emp_no) t
                );