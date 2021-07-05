-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL26 汇总各个部门当前员工的title类型的分配数目
SELECT de.dept_no,
       d.dept_name,
       t.title,
       COUNT(t.emp_no) AS 'count'
FROM dept_emp de
JOIN departments d ON de.dept_no = d.dept_no
JOIN titles t ON de.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
  AND  t.to_date = '9999-01-01'
GROUP BY d.dept_no, t.title
ORDER BY d.dept_no;

-- SQL28 查找描述信息中包含robot的电影对应的分类名称以以及电影数目，而且还需要该分类包含电影总数量>=5部
SELECT c.name AS name,
       COUNT(f.film_id)
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE description LIKE '%robot%'
  AND c.category_id IN (SELECT category_id
                        FROM film_category
                        GROUP BY category_id
                        HAVING COUNT(*) >= 5);

-- SQL29 使用join查询方式找出没有分类的电影id以及名称
SELECT f.film_id,
       f.title
FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id IS NULL;

-- SQL30 使用子查询的方式找出属于Action分类的所有电影对应的title,description
SELECT f.title,
       f.description
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = (SELECT category_id
                        FROM category
                        WHERE name = 'Action');

-- SQL32 将employees表的所有员工的last_name和first_name拼接起来作为Name，中间以一个空格区分
SELECT CONCAT(last_name, ' ', first_name)
FROM employees;
  