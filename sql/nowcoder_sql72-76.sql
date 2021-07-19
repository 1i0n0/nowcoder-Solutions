-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL72 考试分数(一)
SELECT job,
       ROUND(AVG(score), 3) AS avg
FROM grade
GROUP BY job
ORDER BY avg DESC;

-- SQL73 考试分数(二)
SELECT g1.id,
       g1.job,
       g1.score
FROM grade g1
WHERE g1.score > (SELECT AVG(g2.score)
                  FROM grade g2
                  WHERE g1.job = g2.job)
ORDER BY g1.id;

-- SQL74 考试分数(三)
SELECT grade_rank.id,
       l.name,
       grade_rank.score
FROM (SELECT id,
             language_id,
             score,
             DENSE_RANK() OVER (PARTITION BY language_id ORDER BY score DESC) AS `rank`
      FROM grade) grade_rank
JOIN language l ON grade_rank.language_id = l.id
WHERE grade_rank.rank <= 2
ORDER BY l.name, grade_rank.score DESC, grade_rank.id;

-- SQL75 考试分数(四)
SELECT job,
       FLOOR((COUNT(job)+1) / 2) AS start,
       CEILING((COUNT(job)+1) / 2) AS end
FROM grade
GROUP BY job
ORDER BY job;

-- SQL76 考试分数(五)
/* reference: https://zhuanlan.zhihu.com/p/162089174 */
SELECT id,
       job,
       score,
       t_rank
FROM (SELECT id,
             job,
             score,
             CAST(ROW_NUMBER() OVER (PARTITION BY job ORDER BY score DESC) AS SIGNED) AS t_rank,
             CAST(ROW_NUMBER() OVER (PARTITION BY job ORDER BY score ASC) AS SIGNED) AS tr_rank
      FROM grade) new_grade
WHERE t_rank = tr_rank
   OR ABS(t_rank - tr_rank) = 1
ORDER BY id;