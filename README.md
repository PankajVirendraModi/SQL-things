# SQL-things
INTERVIEW QUESTIONS
   
1. https://techtfq.com/blog/top-20-sql-interview-questions

2. https://www.edureka.co/blog/interview-questions/sql-interview-questions?utm_source=youtube&utm_medium=description&utm_campaign=sql-int-video-09072019

When SQL executes a query, it follows a specific order of operations.
This order is important for optimizing queries, especially large and complex ones. Here’s the typical order of operations in an SQL query:

FROM clause: This is the first clause that is processed. It defines the table that the query will use.
ON clause: This clause is used in JOIN operations to specify the condition for the join.
OUTER clause: This clause is used in OUTER JOIN operations.
WHERE clause: This clause filters the records based on a condition.
GROUP BY clause: This clause groups records with identical data in specified columns into aggregated data, like sum, average, or count.
HAVING clause: This clause filters the records resulting from the GROUP BY clause.
SELECT clause: This clause specifies the columns that will be included in the final result set.
DISTINCT clause: This clause removes duplicate rows from the result set.
ORDER BY clause: This clause sorts the result set by one or more columns.
TOP clause: This clause limits the number of rows returned in the result set.
NOTE:- this is the logical order of operations, not necessarily the physical execution order. 
The actual physical execution of an SQL statement is determined by the database’s query processor and can vary in different DBMS. 
Also, aliases created in the SELECT list cannot be used by earlier steps.
