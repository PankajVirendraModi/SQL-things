set search_path to shakra;
/*
write a query to identify employees, who have been with the company for at least 2 years and their performance rating must be in the top 20% within their department.
*/

CREATE TABLE employee_performance(
employee_id INT PRIMARY KEY,
performance_rating INT NOT NULL,
department VARCHAR(50) NOT NULL,
tenure INT
);


INSERT INTO employee_performance (employee_id, performance_rating, department, tenure)
VALUES
(101, 85, 'Engineering', 3),
(102, 90, 'Engineering', 4),
(103, 75, 'Marketing', 2),
(104, 88, 'Marketing', 3),
(105, 82, 'Sales', 4),
(106, 70, 'Sales', 3),
(107, 78, 'Sales', 2),
(108, 91, 'Engineering', 4);

SELECT * FROM employee_performance;

-- I just added few more records, for better understanding the query and output. As I am going to use NTILE window function
INSERT INTO employee_performance (employee_id, performance_rating, department, tenure)
VALUES(112, 57, 'Engineering', 2),
(122, 56, 'Engineering', 4),
(132, 96, 'Engineering', 3),
(142, 92, 'Engineering', 4),
(115, 81, 'Sales', 4),
(116, 79, 'Sales', 3),
(117, 68, 'Sales', 2),

-- partitioning the department into 5 buckets as I have to get the top 20%(1:5) within their department according to performance rating
select *,
ntile(5) over(partition by department order by performance_rating desc) as five_buskets
from employee_performance ep
where tenure>=2; 

-- performance rating in the top 20% within their department
select * from(
select *,
ntile(5) over(partition by department order by performance_rating desc) as five_buskets
from employee_performance) as x
where tenure>=2 and x.five_buskets=1;