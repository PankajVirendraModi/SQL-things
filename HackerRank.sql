# Weather Observation Station 20
/*
Q. A median is defined as a number separating the higher half of a data set from the lower half.
   Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.
*/
1. SELECT ROUND(LAT_N,4)
      FROM (
          SELECT ROW_NUMBER() OVER(ORDER BY LAT_N) AS NUM, LAT_N
          FROM STATION
      ) AS z
      WHERE NUM=(SELECT ROUND(COUNT(*)/2) FROM STATION);
      
      
2. SELECT ROUND(LAT_N, 4) AS MiddleLatitude
      FROM (
          SELECT LAT_N, ROW_NUMBER() OVER (ORDER BY LAT_N) AS NUM
          FROM STATION
      ) AS z
      WHERE NUM = (SELECT CEIL(COUNT(*) / 2.0) FROM STATION);
---------------------------------------------------------------------------------------------------
# Placements (Advanced Join)
/*
Q. You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name.
   Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend).
   Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
   Write a query to output the names of those students whose best friends got offered a higher salary than them.
   Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
*/

SELECT S.Name
FROM Students S JOIN Friends F on S.ID = F.ID
                JOIN Packages P1 on S.ID = P1.ID
                JOIN Packages P2 on F.Friend_ID = P2.ID
        WHERE P1.Salary<P2.Salary
        ORDER BY P2.Salary;
