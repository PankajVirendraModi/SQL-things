Tomorrow, I have an interview where I was asked the following questions:
1. Can you explain the various types of functions in SQL?
2. What distinguishes the ETL (Extract, Transform, Load) process from Visualization tools?

So, there are two types of functions in SQl
### Built-in functions:
`Definition`: User-Defined Functions are functions that are created and defined by the user or the developer. These functions allow users to encapsulate a sequence of SQL statements into a reusable and modular unit.
a.	Scalar functions
CONCAT, SUBSTRING, UPPER, LOWER, GETDATE, DATEDIFF
b.	Aggregation functions
COUNT, MIN, MAX, SUM, AVG
c.	Windows functions
ROW_NUMER, RANK, DENSE_RANK, LEAD, LAG, LAST_VALUE, FIRST_VALUE, NTH_VALUE, CUME_DIST, PERCENT_RANK, CUME_DIST
d.	Other pre-defined functions
ABS, ROUND, AND, OR, NOT, =, <>, LIKE


### User-defined functions:
`Definition`: Built-In Functions, also known as Intrinsic Functions or System Functions, are functions that come pre-defined with a programming language or a database management system (DBMS). These functions are part of the standard functionality provided by the system.

``` PostgreSQL
CREATE OR REPLACE FUNCTION add_two_numbers(num1 INT, num2 INT)
RETURNS INT
AS $$
BEGIN
    RETURN num1 + num2;
END;
$$ LANGUAGE plpgsql;
```

`MySQL`
``` MySQL
DELIMITER //
CREATE FUNCTION add_two_numbers(num1 INT, num2 INT)
RETURNS INT
BEGIN
    RETURN num1 + num2;
END;
//
DELIMITER ;
```
