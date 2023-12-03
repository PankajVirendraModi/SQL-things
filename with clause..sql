CREATE TABELE employee(
	emp_id int PRIMARY KEY,
	emp_name varchar(76),
	salary int
)

INSERT INTO employee
VALUES (101,'Mohan',40000),
		(102,'James',50000),
		(103,'Robin',60000),
		(104,'Carol',70000),
		(105,'Alice',80000),
		(106,'Jimmy',90000);
SELECT * FROM employee;
-------------------------------------------------------
-- Q. fetch employees who earn more than average salary of all employee

SELECT * FROM employee
where salary > (SELECT AVG(salary) as avg_sal
				FROM employee);

-- we can achieve the same result using with clause(CTE-Common Table Expression)
WITH averageCTE AS (
	SELECT CAST(AVG(salary) AS INT) AS avg_sal
	FROM employee )
SELECT * FROM employee e, averageCTE av
WHERE e.salary>av.avg_sal;
------------------------------------------------------
-- it is BEST PRACTICE to use column name inside table name
WITH average_salary(avg_sal) AS( 
	SELECT CAST(AVG(salary) AS int) FROM employee
) 

SELECT * FROM employee e, average_salary av
WHERE e.salary>av.avg_sal;
-------------------------------------------------------------------
-------------------------------------------------------------------
create table sales(
	store_id int not null,
	store_name varchar(75),
	product varchar(75),
	quantity int,
	cost int
);
insert into sales values
(1, 'Apple Originals 1', 'iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1', 'MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1', 'AirPods Pro', 2, 280),
(2, 'Apple Originals 2', 'iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3', 'iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3', 'MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3', 'MacBook Air', 4, 1100),
(3, 'Apple Originals 3', 'iPhone 12', 2, 1000),
(3, 'Apple Originals 3', 'AirPods Pro', 3, 280),
(4, 'Apple Originals 4', 'iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4', 'MacBook pro 13', 1, 2500);

select * from sales;
-- Q. Find stores who's sales where better than the average sales across all stores
-- 1. total sales per each store(total sales by each store seperately)
select s.store_id, sum(cost) as total_sales_per_store
from sales s
group by s.store_id;
-- 2. to find the average sales of all stores
select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_store
from (select s.store_id, sum(cost) as total_sales_per_store
	 from sales s
	 group by s.store_id) as x;
-- 3. to find the stores whose sales is greater than the average sales of all stores
SELECT *
FROM (select s.store_id, sum(cost) as total_sales_per_store
		from sales s
		group by s.store_id) total_sales
JOIN  (select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_store
		from (select s.store_id, sum(cost) as total_sales_per_store
				 from sales s
				 group by s.store_id) as x) avg_sales
	ON total_sales.total_sales_per_store>avg_sales.avg_sales_for_all_store;
	
-- this is not a good practice to use multiple subquery which is difficult to read
WITH total_sales(store_id,total_sales_per_store) AS
		(SELECT s.store_id, SUM(cost) AS total_sales_per_store
		FROM sales s
		GROUP BY s.store_id),
	avg_sales(avg_sales_for_all_store) AS
		 (SELECT CAST(AVG(total_sales_per_store) AS int) AS avg_sales_for_all_store
			FROM total_sales)
SELECT *
FROM total_sales AS ts JOIN avg_sales AS av
ON ts.total_sales_per_store > av.avg_sales_for_all_store;