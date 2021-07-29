-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL62 出现三次以上相同积分的情况
SELECT number 
FROM grade
GROUP BY number 
HAVING COUNT(number) >= 3;

-- SQL63 刷题通过的题目排名
SELECT id,
       number,
       DENSE_RANK() OVER (ORDER BY number DESC) AS t_rank
FROM passing_number
ORDER BY t_rank, id;

--
SELECT a.id, 
       a.number, 
       COUNT(DISTINCT b.number) AS t_rank
FROM passing_number a, passing_number b
WHERE a.number <= b.number
GROUP BY a.id, a.number
ORDER BY t_rank, a.id;

-- SQL64 找到每个人的任务
SELECT p.id,
       p.name,
       t.content
FROM person p
LEFT JOIN task t
ON p.id = t.person_id
ORDER BY p.id;

-- SQL65 异常的邮件概率
SELECT e.date,
       ROUND(SUM(CASE WHEN e.type = 'completed' THEN 0
                       ELSE 1
                  END) / COUNT(e.date), 3) AS p
FROM email e
JOIN user u1 ON e.send_id = u1.id
JOIN user u2 ON e.receive_id = u2.id
WHERE u1.is_blacklist = 0
  AND u2.is_blacklist = 0
GROUP BY e.date
ORDER BY e.date;

-- SQL66 牛客每个人最近的登录日期(一)
SELECT user_id,
       MAX(date) AS d
FROM login
GROUP BY user_id
ORDER BY user_id;
