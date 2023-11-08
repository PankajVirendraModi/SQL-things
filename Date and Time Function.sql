CREATE TABLE date_time_table (
    id SERIAL PRIMARY KEY,
    event_datetime TIMESTAMP
);
truncate table date_time_table;
INSERT INTO date_time_table (event_datetime)
VALUES 
    ('2023-11-27 14:30:45'),
    ('2023-11-28 09:15:00'),
    ('2023-11-09 18:45:30'),
	('2023-11-15 12:00:00'),
    ('2023-11-18 20:30:15');
				
SELECT CURRENT_DATE;	-- Returns the current date.
SELECT CURRENT_TIME;	-- Returns the current time without the date.
SELECT CURRENT_TIMESTAMP;	-- Returns the current date and time.
SELECT NOW()			-- Returns the current date and time.


-- EXTRACT() function extract a specific component in INTEGER format
SELECT event_datetime, EXTRACT(DAY FROM event_datetime) FROM date_time_table;
SELECT event_datetime, EXTRACT(MONTH FROM event_datetime) FROM date_time_table;
SELECT event_datetime, EXTRACT(YEAR FROM event_datetime) FROM date_time_table;
SELECT event_datetime, EXTRACT(SECOND FROM event_datetime) FROM date_time_table;
SELECT event_datetime, EXTRACT(MINUTE FROM event_datetime) FROM date_time_table;
SELECT event_datetime, EXTRACT(HOUR FROM event_datetime) FROM date_time_table;

-- DATE_TRUNC() Function rounds down a date or timestamp to a specified unit of time.
-- i.e. beginning of the month,day,hour,minute...etc
SELECT event_datetime, DATE_TRUNC('Month', event_datetime) FROM date_time_table;
SELECT event_datetime, DATE_TRUNC('Day', event_datetime) FROM date_time_table;
SELECT event_datetime, DATE_TRUNC('Hour',event_datetime) FROM date_time_table;
SELECT event_datetime, DATE_TRUNC('Minute',event_datetime) FROM date_time_table;

-- (+/-) INTERVAL
SELECT event_datetime, event_datetime + INTERVAL '2 Months' AS add_2_months FROM date_time_table;
SELECT event_datetime, event_datetime - INTERVAL '3 Month' AS minus_3_months FROM date_time_table;
SELECT event_datetime, event_datetime + INTERVAL '4 days' AS add_4_days FROM date_time_table;
SELECT event_datetime, event_datetime - INTERVAL '4 hours' AS minus_4_hours FROM date_time_table;

-- TO_CHAR()
SELECT event_datetime, TO_CHAR(event_datetime, 'Day') AS day_name FROM date_time_table;
SELECT event_datetime, TO_CHAR(event_datetime, 'Month') AS day_name FROM date_time_table;
