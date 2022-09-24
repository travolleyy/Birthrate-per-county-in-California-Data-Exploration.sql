/*
California Births Per County from 2008 to 2016

Skills used: Joins, CTE's, Temp Tables, Aggregated functions, Windows Functions,Creating Views

*/

--Looking at the data by year
    SELECT*
    FROM inhospitalbirthsbyagegroup
    ORDER BY year
    DESC
--Creating a table for Total Births by county in 2008
    SELECT patcnty, count AS totalbirths2008
    INTO total2008births
    FROM inhospitalbirthsbyagegroup
    WHERE year=2008 and agegrp IN ('Total Births')
    ORDER BY count
    DESC
--Creating 2008 age 15 to 19 birthing mothers table
    SELECT year, patcnty, MAX(count AS mothers15to19in08)
    FROM inhospitalbirthsbyagegroup
    WHERE year=2008 and agegrp IN ('Teen Mothers (15 years old to 19 years old)')
    ORDER BY COUNT
    DESC
--Creating 2008 age 20 to 34 birthing mothers table
    SELECT year, patcnty, count AS mothers20to34in08
    INTO mothers20to34in08
    FROM inhospitalbirthsbyagegroup
    WHERE year=2008 and agegrp IN ('Typical Aged Mothers (20 years old to 34 years old)')
    ORDER BY COUNT
    DESC
--Creating 2008 age 35 and up birthing mothers table
    SELECT year, patcnty, count AS mothers35upin08
    INTO mothers35upin08
    FROM inhospitalbirthsbyagegroup
    WHERE year=2008 and agegrp IN ('Older Mothers (35 years old or older)')
    ORDER BY COUNT
    DESC
--Joining the 2008 tables together
    SELECT mothers15to19in08.year,mothers15to19in08.patcnty,mothers15to19in08, mothers20to34in08,mothers35upin08,totalbirths2008
    INTO allbirths2008
    FROM mothers15to19in08
    INNER JOIN mothers20to34in08
    ON mothers15to19in08.patcnty=mothers20to34in08.patcnty
    INNER JOIN mothers35upin08
    ON mothers15to19in08.patcnty=mothers35upin08.patcnty
    INNER JOIN total2008births
    ON mothers15to19in08.patcnty=total2008births.patcnty
--Creating a table for Total Births by county in 2016
    SELECT patcnty, count AS totalbirths2016
    INTO total2016births
    FROM inhospitalbirthsbyagegroup
    WHERE year=2016 and agegrp IN ('Total Births')
    ORDER BY COUNT
    DESC
--Creating 2016 age 15 to 19 birthing mothers table
    SELECT year, patcnty, count AS mothers15to19in16
    INTO mothers15to19in16
    FROM inhospitalbirthsbyagegroup
    WHERE year=2016 and agegrp IN ('Teen Mothers (15 years old to 19 years old)')
    ORDER BY COUNT
    DESC
--Creating 2016 age 20 to 34 birthing mothers table
    SELECT year, patcnty, count AS mothers20to34in16
    INTO mothers20to34in16
    FROM inhospitalbirthsbyagegroup
    WHERE year=2008 and agegrp IN ('Typical Aged Mothers (20 years old to 34 years old)')
    ORDER BY COUNT
    DESC
--Creating 2016 age 35 and up birthing mothers table
    SELECT year, patcnty, count AS mothers35upin16
    INTO mothers35upin16
    FROM inhospitalbirthsbyagegroup
    WHERE year=2016 and agegrp IN ('Older Mothers (35 years old or older)')
    ORDER BY COUNT
    DESC
--Joining the 2016 tables together
    SELECT mothers15to19in16.year,mothers15to19in16.patcnty,mothers15to19in16,mothers20to34in16,mothers35upin16,totalbirths2016
    INTO allbirths2016
    FROM mothers15to19in16
    INNER JOIN mothers20to34in16
    ON mothers15to19in16.patcnty=mothers20to34in16.patcnty
    INNER JOIN mothers35upin16
    ON mothers15to19in16.patcnty=mothers35upin16.patcnty
    INNER JOIN total2016births
    ON mothers15to19in16.patcnty=total2016births.patcnty
--2008 percentage of mothers 
    SELECT year, patcnty,(CONVERT(FLOAT, mothers15to19in08)/CONVERT(FLOAT,totalbirths2008)*100) AS mothers15to19, (CONVERT(FLOAT, mothers20to34in08)/CONVERT(FLOAT,totalbirths2008)*100) AS mothers20to34, (CONVERT(FLOAT, mothers35upin08)/CONVERT(FLOAT,totalbirths2008)*100) AS mothers35up
    FROM allbirths2008
--2016 percentage of mothers
    SELECT year, patcnty,(CONVERT(FLOAT, mothers15to19in16)/CONVERT(FLOAT,totalbirths2016)*100) AS mothers15to19, (CONVERT(FLOAT, mothers20to34in16)/CONVERT(FLOAT,totalbirths2016)*100) AS mothers20to34, (CONVERT(FLOAT, mothers35upin16)/CONVERT(FLOAT,totalbirths2016)*100) AS mothers35up
    FROM allbirths2016