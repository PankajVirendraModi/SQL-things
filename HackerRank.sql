# Weather Observation Station 20
A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.
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

