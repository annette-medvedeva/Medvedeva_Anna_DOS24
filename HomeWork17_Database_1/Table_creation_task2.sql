CREATE DATABASE Students_db;
USE Students_db;

CREATE TABLE `Students` (
    st_id INT PRIMARY KEY,
    st_name VARCHAR(20)
);

CREATE TABLE `Courses` (
    crs_id INT PRIMARY KEY,
    crs_name VARCHAR(100)
);

CREATE TABLE `Learning` (
    st_id INT,
    crs_id INT,
    PRIMARY KEY (st_id, crs_id),
    FOREIGN KEY (st_id) REFERENCES Students(st_id),
    FOREIGN KEY (crs_id) REFERENCES COURSES(crs_id)
);

INSERT INTO `Students` (st_id, st_name)
VALUES 
    (1, 'Jon Snow'),
    (2, 'Arya Stark'),
    (3, 'Daenerys Targaryen'),
    (4, 'Tyrion Lannister');

INSERT INTO `Courses` (crs_id, crs_name)
VALUES 
    (1, 'Mathematics'),
    (2, 'Physics'),
    (3, 'History'),
    (4, 'Economy');

INSERT INTO `Learning` (st_id, crs_id)
VALUES 
    (2, 2),
    (2, 3),
    (3, 1),
    (4, 4),
    (4, 3);

SELECT * FROM Students;
+-------+--------------------+
| st_id | st_name            |
+-------+--------------------+
|     1 | Jon Snow           |
|     2 | Arya Stark         |
|     3 | Daenerys Targaryen |
|     4 | Tyrion Lannister   |
+-------+--------------------+

SELECT * FROM Courses;
+--------+-------------+
| crs_id | crs_name    |
+--------+-------------+
|      1 | Mathematics |
|      2 | Physics     |
|      3 | History     |
|      4 | Economy     |
+--------+-------------+