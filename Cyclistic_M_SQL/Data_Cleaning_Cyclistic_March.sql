-- A view of the existing table

SELECT *
FROM cyclistic.mar_21
LIMIT 15;



-- DATA CLEANING 
-- A look at the distinct or unique rides 

SELECT COUNT(DISTINCT ride_id)
FROM cyclistic.mar_21
LIMIT 15;


-- Change column name in table:

ALTER TABLE cyclistic.mar_21
RENAME COLUMN member_casual TO member_type;


-- Change value within a column: "member" to "annual"

UPDATE
   cyclistic.mar_21
SET 
  member_type = REPLACE(member_type, 'member', 'annual')
WHERE
   member_type  LIKE 'm%';
   
   
-- Check datatype of table

SHOW COLUMNS FROM cyclistic.mar_21;
DESCRIBE cyclistic.mar_21;


-- Change 'started_at' and 'ended_at' columns to datetime from text

UPDATE cyclistic.mar_21 

SET started_at = STR_TO_DATE(started_at,'%m/%d/%Y %H:%i');

UPDATE cyclistic.mar_21 
SET ended_at = STR_TO_DATE(ended_at,'%m/%d/%Y %H:%i');


-- Create column "ride_length" from "started_at" and "ended_at" columns
SELECT *, CAST(TIMEDIFF(ended_at, started_at) AS TIME) AS ride_length

FROM cyclistic.mar_21;


-- Create column "day_of_week" from "started_at" column

SELECT *, 
CAST(TIMEDIFF(ended_at, started_at) AS TIME) AS ride_length,  
DAYOFWEEK(DATE(started_at)) AS day_of_week

FROM cyclistic.mar_21;


-- Subquery application

SELECT ride_id
FROM (SELECT *, 
CAST(TIMEDIFF(ended_at, started_at) AS TIME) AS ride_length,  
DAYOFWEEK(DATE(started_at)) AS day_of_week

FROM cyclistic.mar_21
WHERE rideable_type != 'docked_bike') AS Min_March

WHERE HOUR(ride_length) >= 26;





-- Descriptive Statistics
-- Subquery application

SELECT COUNT(ride_length) AS Number_of_Rides,
	SUM(ride_length) AS Total_Time,
	AVG(ride_length) AS Average_Time,
	STDDEV_SAMP(ride_length) AS SD_TIme,
	VAR_SAMP(ride_length) AS Var_TIme,
	MIN(ride_length)  AS Minimum_Time,
	MAX(ride_length) AS maximum_Time
FROM (SELECT *, 
CAST(TIMEDIFF(ended_at, started_at) AS TIME) AS ride_length,  
DAYOFWEEK(DATE(started_at)) AS day_of_week

FROM cyclistic.mar_21) AS Min_March

WHERE rideable_type != 'docked_bike';