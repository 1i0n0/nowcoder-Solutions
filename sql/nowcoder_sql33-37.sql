-- ----------------------------
--  https://www.nowcoder.com/activity/oj?tab=1
-- ----------------------------

-- SQL33 创建一个actor表
CREATE TABLE IF NOT EXISTS actor(
    actor_id    SMALLINT(5) NOT NULL COMMENT '主键id',
    first_name  VARCHAR(45) NOT NULL COMMENT '名字',
    last_name   VARCHAR(45) NOT NULL COMMENT '姓氏',
    last_update DATE        NOT NULL COMMENT '日期',
    PRIMARY KEY (actor_id)
);

-- SQL34 批量插入数据
--       不能有2条insert语句
/*
   1 PENELOPE GUINESS   2006-02-15 12:34:33
   2 NICK     WAHLBERG  2006-02-15 12:34:33
*/
INSERT INTO actor 
VALUES ('1', 'PENELOPE', 'GUINESS',  '2006-02-15 12:34:33'),
       ('2', 'NICK',     'WAHLBERG', '2006-02-15 12:34:33');

-- SQL35 批量插入数据，不使用replace操作
--       已存在('3', 'WD', 'GUINESS', '2006-02-15 12:34:33')
--       插入('3', 'ED', 'CHASE', '2006-02-15 12:34:33')
INSERT IGNORE INTO actor
VALUES ('3', 'ED', 'CHASE', '2006-02-15 12:34:33');

-- SQL36 创建一个actor_name表，并且将actor表中的所有first_name以及last_name导入该表
CREATE TABLE IF NOT EXISTS actor_name AS
SELECT first_name, last_name
FROM actor;

--SQL37 对first_name创建唯一索引uniq_idx_firstname
--      对last_name创建普通索引idx_lastname
CREATE UNIQUE INDEX uniq_idx_firstname ON actor (first_name);
CREATE INDEX idx_lastname ON actor (last_name);