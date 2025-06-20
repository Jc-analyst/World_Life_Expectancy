#PROJECT 1 part 1 
-- Check the data we got
SELECT * 
FROM world_life_expectancy;

-- CONCAT, COUNT, Count will help to see any repetition values 
SELECT Country, Year, CONCAT(Country, Year),  COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year);

-- ROW_NUMBER help to expose the repetitives numbers 
SELECT *
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
    ) AS Row_table
WHERE Row_Num > 1;

-- DELETE , to get rid of the repetitions
DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
	FROM (
		SELECT Row_ID,
		CONCAT(Country, Year),
		ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
		FROM world_life_expectancy
    ) AS Row_table
WHERE Row_Num > 1
)
;

-- Check the data that is empty
SELECT * 
FROM world_life_expectancy
WHERE Status = '';

-- DISTINCT, Check the different values we have in STATUS
SELECT DISTINCT (Status)
FROM world_life_expectancy
WHERE STATUS <> '';

-- Revise the Developing countries 
SELECT DISTINCT (Country)
FROM world_life_expectancy
WHERE Status = 'Developing';

-- UPDATE, JOIN ON SET, WHERE, AND, Populate the empty countries with the Developing value if tis corresponse
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

-- UPDATE, JOIN ON SET, WHERE, AND, Same process for the developed countries 
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

-- Check the data again
SELECT * 
FROM world_life_expectancy;

-- Check if there is any empty space in Life expectancy
SELECT  *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

-- Check for 0 or NULL values in life expectancy 
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = '' OR `Life expectancy` IS NULL;

-- Prepare the data to use to fill empty life expectncy values
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
;

-- JOIN ON, ROUND, to fill the gaps in life expectancy 
SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
t2.Country, t2.Year, t2.`Life expectancy`, 
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1) AS Average
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1 
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1 
WHERE t1.`Life expectancy` = ''
;

-- UPDATE the table with the new average values
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1 
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1 
SET 	t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

#PROJECT 1 part 2 

SELECT * 
FROM world_life_expectancy;
#Overal view of he data

#Having a look to the max and min values 
-- MIN, MAX
SELECT Country, MIN(`Life expectancy`),MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;

#Considering the increase in 15 years to see the diference from highest to lowest
-- MIN, MAX, ROUND
SELECT Country, 
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Country DESC
;

#Considering the increase in 15 years to see the diference from lowest to highest
-- MIN, MAX
SELECT Country, 
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Country ASC
;


#filtering and we can see we can increase 6-7 years overall
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;

#checking this i would like to find out about correlation 
SELECT * 
FROM world_life_expectancy
;


#Correlation between life expectancy and GDP
SELECT Country, `Life expectancy`, GDP
FROM world_life_expectancy
;

-- want to take the average per country, and round them to see the trend, group by country
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_exp, ROUND(AVG(GDP),1) AS GDP_avg
FROM world_life_expectancy
WHERE `Life expectancy` > 0
AND GDP > 0
GROUP BY Country
ORDER BY GDP_avg ASC
;
-- we can see that a low GDP the life expectancy is low too
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_exp, ROUND(AVG(GDP),1) AS GDP_avg
FROM world_life_expectancy
WHERE `Life expectancy` > 0
AND GDP > 0
GROUP BY Country
ORDER BY GDP_avg DESC
;
-- the same happens with high GDP

#CASE statement 
-- checking the data and chossing 1500 as middle of the table 
SELECT  
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy
FROM world_life_expectancy
;
-- I USE THE NULL INSTEAD OF 0 IF NOT IT WOULD COUNT IT FOR THE AVERGAGE WHICH IS WRONG 
-- we could do the same with every single column and visualize with any other tool

SELECT * 
FROM world_life_expectancy
;

# We want to check the status
SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;
-- we can see that the developed countries have a longer life expectancy
-- Its not a clear picture, as it could be just 1 developed countries 

SELECT Status, COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;
-- it can be seen that there is 32 developed and 161 developing countries 
-- So its a bit skewed for the developed beacuse there are few and its easy to keep the average high
-- we could combine it see it better
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

-- Each country have their own BMI, with life expectancy
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_exp_avg,ROUND(AVG(BMI),1) AS BMI_avg
FROM world_life_expectancy
GROUP BY Country
HAVING BMI_avg > 0
AND  Life_exp_avg > 0
ORDER BY BMI_avg DESC
;
-- after FROM i have to use WHERE with the respective column from t1
-- after GROUP BY i can use HAVING with the new alias t2
-- some countries can have very high BMI, high life expenctancy and high BMI, also low BMI also is low high expectancy

#Interesting Adult mortality , rolling over (accumulate sum)
SELECT Country, 
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;
-- So it can be seen the numbers of deaths after the 15 years per country 
-- Without the WHERE we see of everyone and we can filter for specific country
-- I could work whith the total population to compare 
