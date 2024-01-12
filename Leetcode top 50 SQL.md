1757. Recyclable and Low Fat Products

![day12](https://github.com/PankajVirendraModi/SQL-things/assets/75255261/3710df61-2481-496c-9d2e-500538913b07)

--
SELECT * FROM PRODUCTS;	
--
SELECT * FROM employee_performance;
--
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
--
select *,

ntile(5) over(partition by department order by performance_rating desc) as five_buskets

from employee_performance ep

where tenure>=2; 

-
-- performance rating in the top 20% within their department
select * from(
select *,
ntile(5) over(partition by department order by performance_rating desc) as five_buskets
from employee_performance) as x
where tenure>=2 and x.five_buskets=1;
