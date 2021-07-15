-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL67 牛客每个人最近的登录日期(二) (每个用户最近登录日期及设备)
SELECT u.name AS u_n,
       c.name AS c_n,
       l1.date AS date
FROM login l1
JOIN user u ON l1.user_id = u.id
JOIN client c ON l1.client_id = c.id
WHERE l1.date = (SELECT MAX(date)
                 FROM login l2 
                 WHERE l1.user_id = l2.user_id)
ORDER BY u.name;

-- SQL68 牛客每个人最近的登录日期(三) (新登录用户的次日成功的留存率)
SELECT ROUND(SUM(CASE WHEN l1.date = DATE_ADD((SELECT MIN(l2.date) 
                                               FROM login l2 
                                               WHERE l1.user_id = l2.user_id), 
                                              INTERVAL 1 DAY) THEN 1
                      ELSE 0
                 END) / COUNT(DISTINCT l1.user_id), 3)
FROM login l1;

--
SELECT ROUND(COUNT(DISTINCT user_id) 
             / (SELECT COUNT(DISTINCT user_id) FROM login), 3)
FROM login
WHERE (user_id, date) IN (SELECT user_id,
                                 DATE_ADD(min(date), INTERVAL 1 DAY) 
                          FROM login 
                          GROUP BY user_id);

-- SQL69 牛客每个人最近的登录日期(四) (每个日期登录新用户个数)
SELECT l.date,
       IFNULL(t.new, 0) AS new
FROM login l
LEFT JOIN (SELECT l1.date AS date,
                  COUNT(l1.user_id) AS new
           FROM login l1
           WHERE l1.date = (SELECT MIN(date)
                            FROM login l2
                            WHERE l1.user_id = l2.user_id)
           GROUP BY l1.date) t 
ON l.date = t.date
GROUP BY l.date
ORDER BY l.date;

-- SQL70 牛客每个人最近的登录日期(五) (每个日期新用户的次日留存率)
SELECT l.date,
       IFNULL(ROUND(next_day.c / new_user.c, 3), 0) AS p
FROM login l
LEFT JOIN (SELECT l1.date AS date,
                  COUNT(user_id) AS c
           FROM login l1
           WHERE date = (SELECT MIN(date) FROM login l2 WHERE l1.user_id = l2.user_id)
           GROUP BY l1.date) new_user 
ON l.date = new_user.date
LEFT JOIN (SELECT DATE_SUB(date,INTERVAL 1 DAY) AS date,
                  COUNT(user_id) AS c
           FROM login
           WHERE (user_id, date) IN (SELECT user_id,
                                            DATE_ADD(min(date), INTERVAL 1 DAY) 
                                     FROM login 
                                     GROUP BY user_id)
           GROUP BY date) next_day 
ON new_user.date = next_day.date
GROUP BY l.date;

-- SQL71 牛客每个人最近的登录日期(六) (用户截止到某天，累计总共通过了多少题)
SELECT u.name AS u_n,
       date,
       SUM(number) OVER (PARTITION BY user_id ORDER BY date) AS ps_num
FROM user u
RIGHT JOIN passing_number p
ON u.id = p.user_id
ORDER BY date,  u_n;
