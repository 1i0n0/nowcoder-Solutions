-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL82 牛客的课程订单分析(六)
SELECT o.id,
       o.is_group_buy,
       IFNULL(c.name, 'None')
FROM order_info o
LEFT JOIN client c ON o.client_id = c.id
WHERE user_id IN (SELECT user_id
                  FROM order_info
                  WHERE date > '2025-10-15'
                    AND status = 'completed'
                    AND product_name IN ('C++', 'Java', 'Python')
                  GROUP BY user_id
                  HAVING COUNT(id) >= 2)
  AND o.date > '2025-10-15'
  AND o.status = 'completed'
  AND o.product_name IN ('C++', 'Java', 'Python')
ORDER BY o.id;

-- SQL83 牛客的课程订单分析(七)
SELECT IFNULL(c.name, 'GroupBuy') AS source,
       COUNT(o.id) AS cnt
FROM order_info o
LEFT JOIN client c ON o.client_id = c.id
WHERE user_id IN (SELECT user_id
                  FROM order_info
                  WHERE date > '2025-10-15'
                    AND status = 'completed'
                    AND product_name IN ('C++', 'Java', 'Python')
                  GROUP BY user_id
                  HAVING COUNT(id) >= 2)
  AND o.date > '2025-10-15'
  AND o.status = 'completed'
  AND o.product_name IN ('C++', 'Java', 'Python')
GROUP BY source
ORDER BY source;

-- SQL84 实习广场投递简历分析(一)
SELECT job,
       SUM(num) AS cnt
FROM resume_info
WHERE date LIKE '2025%'
GROUP BY job
ORDER BY cnt DESC;

-- SQL85 实习广场投递简历分析(二)
SELECT job,
       DATE_FORMAT(date,'%Y-%m') AS 'mon',
       SUM(num) AS cnt
FROM resume_info
WHERE date LIKE '2025%'
GROUP BY mon, job
ORDER BY mon DESC, cnt DESC;

-- SQL86 实习广场投递简历分析(三)
SELECT r1.job,
       DATE_FORMAT(r1.date,'%Y-%m') AS first_year_mon,
       SUM(r1.num) AS first_year_cnt,
       r2.mon AS second_year_mon,
       r2.cnt AS second_year_cnt
FROM resume_info r1,
     (SELECT r.job AS job,
             DATE_FORMAT(date,'%Y-%m') AS mon,
             SUM(r.num) AS cnt
      FROM resume_info r
      WHERE r.date LIKE '2026%'
      GROUP BY mon, r.job) r2
WHERE r1.date LIKE '2025%'
  AND r1.job = r2.job
  AND REPLACE(r2.mon,'2026','2025') = DATE_FORMAT(r1.date,'%Y-%m')
GROUP BY first_year_mon, job
ORDER BY first_year_mon DESC, job DESC;

--
SELECT r1.job,
       r1.mon AS first_year_mon,
       r1.cnt AS first_year_cnt,
       r2.mon AS second_year_mon,
       r2.cnt AS second_year_cnt
FROM (SELECT job,
             DATE_FORMAT(date,'%Y-%m') AS mon,
             SUM(num) AS cnt
      FROM resume_info
      WHERE date LIKE '2025%'
      GROUP BY mon, job) r1,
     (SELECT job,
             DATE_FORMAT(date,'%Y-%m') AS mon,
             SUM(num) AS cnt
      FROM resume_info
      WHERE date LIKE '2026%'
      GROUP BY mon, job) r2
WHERE r1.job = r2.job
  AND REPLACE(r2.mon,'2026','2025') = r1.mon
ORDER BY first_year_mon DESC, job DESC;