SELECT Students.st_name, Courses.crs_name
FROM Students
LEFT JOIN Learning ON Students.st_id=Learning.st_id
LEFT JOIN Courses ON Learning.crs_id=Courses.crs_id;

+--------------------+-------------+
| st_name            | crs_name    |
+--------------------+-------------+
| Jon Snow           | NULL        |
| Arya Stark         | Physics     |
| Arya Stark         | History     |
| Daenerys Targaryen | Mathematics |
| Tyrion Lannister   | History     |
| Tyrion Lannister   | Economy     |
+--------------------+-------------+