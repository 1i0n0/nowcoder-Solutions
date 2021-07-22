-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL87 最差是第几名(一)
SELECT grade,
       SUM(number) OVER (ORDER BY grade) AS t_rank
FROM class_grade;

-- SQL88 最差是第几名(二)
SELECT DISTINCT grade
FROM (SELECT grade,
             number,
             total / 2 AS mid1,
             CASE WHEN total % 2 = 0 THEN (total / 2) + 1
                  ELSE total / 2
             END AS mid2,
             SUM(number) OVER (ORDER BY grade) AS subtot
      FROM class_grade,
           (SELECT SUM(number) AS total FROM class_grade) num) new_grade
WHERE (subtot >= mid1 AND subtot - number <= mid1)
   OR (subtot >= mid2 AND subtot - number < mid2)
ORDER BY grade;

-- SQL89 获得积分最多的人(一)
SELECT u.name,
       SUM(if(type = 'add', 1, -1) * g.grade_num) AS grade_sum
FROM grade_info g
JOIN user u ON g.user_id = u.id
GROUP BY g.user_id
ORDER BY grade_sum DESC
LIMIT 1;

-- SQL90 获得积分最多的人(二)
WITH total_grade AS (
   SELECT u.id AS id,
          u.name AS name,
          SUM(if(type = 'add', 1, -1) * g.grade_num) AS grade_sum
   FROM grade_info g
   JOIN user u ON g.user_id = u.id
   GROUP BY g.user_id
)
SELECT *
FROM total_grade
WHERE grade_sum = (SELECT MAX(grade_sum) FROM total_grade)
ORDER BY id;

-- SQL91 获得积分最多的人(三)
WITH total_grade AS (
   SELECT u.id AS id,
          u.name AS name,
          SUM(if(type = 'add', 1, -1) * g.grade_num) AS grade_sum
   FROM grade_info g
   JOIN user u ON g.user_id = u.id
   GROUP BY g.user_id
)
SELECT *
FROM total_grade
WHERE grade_sum = (SELECT MAX(grade_sum) FROM total_grade)
ORDER BY id;