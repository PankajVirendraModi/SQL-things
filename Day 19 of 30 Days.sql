set search_path to shakra;

CREATE TABLE LeaveRecord (
  employee_id int not null,
  leave_date date,
  leave_type varchar(20)
);

INSERT INTO LeaveRecord (employee_id, leave_date, leave_type)
VALUES (1, '2022-01-10', 'Sick'),
       (1, '2022-01-12', 'Personal'),
       (1, '2022-01-15', 'Sick'),
       (2, '2022-01-11', 'Vacation'),
       (2, '2022-01-13', 'Sick'),
       (2, '2022-01-14', 'Vacation');
	   
SELECT * FROM LeaveRecord;

/*
Write an SQL query to find the most common leave type for each employee.
In case of a tie, return all tied leave types. The result should be ordered by employee_id.
*/

SELECT employee_id, leave_type
FROM ( SELECT employee_id, leave_type,
	 RANK() OVER(PARTITION BY employee_id ORDER BY COUNT(1) desc) AS RNK
	 FROM LeaveRecord
	 GROUP BY employee_id,leave_type) AS ranked_leave_type
	 WHERE RNK=1
	 ORDER BY employee_id ;
	 
/*
1. Inner Query (Subquery - Aliased as "ranked_leaves"):
Grouping the LeaveRecord table by employee_id and leave_type.
Used the RANK() window function to assign a rank to each leave type for each employee based on the count of occurrences in descending order.

2.Outer Query:
Selecting the employee_id and leave_type columns from the result of the inner query.
The WHERE RNK=1 condition ensures that only the most common leave type(s) for each employee are selected.
The final result is ordered by employee_id in ascending order.
*/