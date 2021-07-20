-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL77 牛客的课程订单分析(一)
SELECT *
FROM order_info
WHERE date > '2025-10-15'
  AND status = 'completed'
  AND product_name IN ('C++', 'Java', 'Python')
ORDER BY id;

-- SQL78 牛客的课程订单分析(二)
SELECT user_id
FROM order_info
WHERE date > '2025-10-15'
  AND status = 'completed'
  AND product_name IN ('C++', 'Java', 'Python')
GROUP BY user_id
HAVING COUNT(id) >= 2
ORDER BY user_id;

-- SQL79 牛客的课程订单分析(三)
SELECT *
FROM order_info
WHERE user_id IN (SELECT user_id
                  FROM order_info
                  WHERE date > '2025-10-15'
                    AND status = 'completed'
                    AND product_name IN ('C++', 'Java', 'Python')
                  GROUP BY user_id
                  HAVING COUNT(id) >= 2)
  AND date > '2025-10-15'
  AND status = 'completed'
  AND product_name IN ('C++', 'Java', 'Python')
ORDER BY id;

-- SQL80 牛客的课程订单分析(四)
SELECT user_id,
       MIN(date) AS first_buy_date,
       COUNT(id) AS cnt
FROM order_info
WHERE date > '2025-10-15'
  AND status = 'completed'
  AND product_name IN ('C++', 'Java', 'Python')
GROUP BY user_id
HAVING COUNT(id) >= 2
ORDER BY user_id;

-- SQL81 牛客的课程订单分析(五)
SELECT user_id,
       min(date) as first_buy_date,
       max(date) as second_buy_date,
       cnt
FROM (SELECT user_id,
             date,
             ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date) AS times,
             COUNT(*) OVER (PARTITION BY user_id) AS cnt
      FROM order_info
      WHERE date >= '2025-10-16'
        AND status = 'completed'
        AND product_name IN ('C++','Java','Python')) buy
where times <= 2 and cnt >= 2
group by user_id
order by user_id;