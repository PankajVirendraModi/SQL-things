set search_path to shakra;

```sql
CREATE TABLE LeaveRecord (
  employee_id int not null,
  leave_date date,
  leave_type varchar(20)
);
```
```sql
INSERT INTO LeaveRecord (employee_id, leave_date, leave_type)
VALUES (1, '2022-01-10', 'Sick'),
       (1, '2022-01-12', 'Personal'),
       (1, '2022-01-15', 'Sick'),
       (2, '2022-01-11', 'Vacation'),
       (2, '2022-01-13', 'Sick'),
       (2, '2022-01-14', 'Vacation');
```
```sql   
SELECT * FROM LeaveRecord;
```

1. Write an SQL query to find the most common leave type for each employee.
In case of a tie, return all tied leave types. The result should be ordered by employee_id.
2. Why do we use CASE statement in SQL?


```sql
SELECT employee_id, leave_type
FROM ( SELECT employee_id, leave_type,
	 RANK() OVER(PARTITION BY employee_id ORDER BY COUNT(1) DESC) AS RNK
	 FROM LeaveRecord
	 GROUP BY employee_id,leave_type) AS ranked_leave_type
	 WHERE RNK=1
	 ORDER BY employee_id ;
  ```
	 
> [!important]
SQL query explanation
> Inner Query (Subquery - Aliased as "ranked_leaves"):
Grouping the LeaveRecord table by employee_id and leave_type.
Used the RANK() window function to assign a rank to each leave type for each employee based on the count of occurrences in descending order(count(1) desc).
> Outer Query:
Selecting the employee_id and leave_type columns from the result of the inner query.
The WHERE RNK=1 condition ensures that only the most common leave type(s) for each employee are selected.
The final result is ordered by employee_id in ascending order.


![image](https://github.com/PankajVirendraModi/SQL-things/assets/75255261/709135cc-71a0-4b72-adfc-a837bfb193f3)

> The CASE statement in SQL is often used for conditional logic and can be thought of as similar to the if...else construct in other programming languages. It allows you to perform different actions based on specified conditions within a SQL query.
