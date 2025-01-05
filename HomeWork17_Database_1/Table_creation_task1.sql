CREATE DATABASE Analysis_db;
USE Analysis_db;

CREATE TABLE `Groups` (
    gr_id INT PRIMARY KEY,
    gr_name VARCHAR(100),
    gr_temp VARCHAR(50)
);

CREATE TABLE `Analysis` (
    an_id INT PRIMARY KEY,
    an_name VARCHAR(100),
    an_cost DECIMAL(10,3),
    an_price DECIMAL(10,3),
    an_group INT,
    FOREIGN KEY (an_group) REFERENCES `Groups`(gr_id)
);

CREATE TABLE `Orders` (
    ord_id INT PRIMARY KEY,
    ord_datetime DATETIME,
    ord_an INT,
    FOREIGN KEY (ord_an) REFERENCES `Analysis`(an_id)
);

INSERT INTO `Groups` (gr_id, gr_name, gr_temp)
VALUES 
    (1, 'Group01', 4), 
    (2, 'Group02', 6), 
    (3, 'Group03', 8);

INSERT INTO `Analysis` (an_id, an_name, an_cost, an_price, an_group)
VALUES 
    (1, 'Analysis01', 15, 30, 1), 
    (2, 'Analysis02', 50, 75, 2), 
    (3, 'Analysis03', 100, 150, 1), 
    (4, 'Analysis04', 125, 175, 3);

INSERT INTO `Orders` (ord_id, ord_datetime, ord_an)
VALUES 
    (1, '2019-02-05 10:00:00', 2),
    (2, '2020-02-05 12:00:00', 1),
    (3, '2020-02-05 14:00:00', 3),
    (4, '2020-02-06 10:00:00', 2),
    (5, '2020-02-12 11:00:00', 1),
    (6, '2020-02-13 09:00:00', 2);

SELECT * FROM `Groups`;
+-------+---------+---------+
| gr_id | gr_name | gr_temp |
+-------+---------+---------+
|     1 | Group01 | 4       |
|     2 | Group02 | 6       |
|     3 | Group03 | 8       |
+-------+---------+---------+

SELECT * FROM `Analysis`;
+-------+----------+---------+----------+----------+
| an_id |  an_name   | an_cost | an_price | an_group |
+-------+----------+---------+----------+----------+
|     1 | Analysis01 |  15.000 |   30.000 |        1 |
|     2 | Analysis02 |  50.000 |   75.000 |        2 |
|     3 | Analysis03 | 100.000 |  150.000 |        1 |
|     4 | Analysis04 | 125.000 |  175.000 |        3 |
+-------+----------+---------+----------+----------+

SELECT * FROM `Orders`;
+--------+---------------------+--------+
| ord_id | ord_datetime        | ord_an |
+--------+---------------------+--------+
|      1 | 2019-02-05 10:00:00 |      2 |
|      2 | 2020-02-05 12:00:00 |      1 |
|      3 | 2020-02-05 14:00:00 |      3 |
|      4 | 2020-02-06 10:00:00 |      2 |
|      5 | 2020-02-12 11:00:00 |      1 |
|      6 | 2020-02-13 09:00:00 |      2 |
+--------+---------------------+--------+