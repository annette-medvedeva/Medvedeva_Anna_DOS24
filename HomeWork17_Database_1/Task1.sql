SELECT Analysis.an_name, Analysis.an_price
FROM Orders
JOIN Analysis ON Orders.ord_an=Analysis.an_id
WHERE Orders.ord_datetime BETWEEN '2020-02-05 00:00:01' AND '2020-02-12 23:59:59';

+----------+----------+
|  an_name   | an_price |
+----------+----------+
| Analysis01 |   30.000 |
| Analysis03 |  150.000 |
| Analysis02 |   75.000 |
| Analysis01 |   30.000 |
+----------+----------+