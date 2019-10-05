---------------------------------------------------
-- SELECT * FROM TABLE to make sure tables were
-- imported
SELECT * FROM emissions_agriculture_total;
SELECT * FROM emissions_land_total;
SELECT * FROM production_crop;
SELECT * FROM population_all;
---------------------------------------------------
-- SELECT DISTINCT COLUMN FROM TABLE to see
-- unique values in columns selected
SELECT DISTINCT element FROM population_all;
-- Only element considered is
-- 'Total Population - Both sexes'
-- Unit is '1000 persons'
SELECT DISTINCT element FROM emissions_agriculture_total;
-- Only 3 elements are considered
-- 'Emissions (CH4)', 'Emissions (N2O)', 'Emissions (CO2eq)'
-- The other 2 are summed to produce 'Emissions (CO2eq)'
-- Unit is 'gigagrams'
SELECT DISTINCT element FROM emissions_land_total;
-- Only 1 element is considered
-- 'Net emissions/removals (CO2eq)'
-- The other 3 are summed to produce 'Net emissions/removals (CO2eq)'
-- Unit is 'gigagrams'
SELECT DISTINCT element FROM production_crop;
-- All 3 elements are considered
-- 'Area harvested', 'Production', 'Yield'
-- Units are 'ha', 'tonnes', 'hg/ha'
---------------------------------------------------
-- Merge All Datasets
---------------------------------------------------
-- FIRST
-- turn all element types (found with SELECT DISTINCT)
-- into views
-- A - Lets Do population_all TABLE first
CREATE VIEW pop AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS population,
COUNT(a.value) AS count_population
FROM population_all AS a
WHERE a.element='Total Population - Both sexes'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- B - emissions_land_total TABLE second
CREATE VIEW land_emis AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS land_co2,
COUNT(a.value) AS count_land_co2
FROM emissions_land_total AS a
WHERE a.element='Net emissions/removals (CO2eq)'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- C - emissions_agriculture_total third
-- this is a little more complicated as 3 views will need
-- to be created then merged together
-- 1st view
CREATE VIEW first_agri_emis AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS agri_ch4,
COUNT(a.value) AS count_agri_ch4
FROM emissions_agriculture_total AS a
WHERE a.element='Emissions (CH4)'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- 2nd view
CREATE VIEW second_agri_emis AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS agri_n2o,
COUNT(a.value) AS count_agri_n2o
FROM emissions_agriculture_total AS a
WHERE a.element='Emissions (N2O)'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- 3rd view
CREATE VIEW third_agri_emis AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS agri_co2,
COUNT(a.value) AS count_agri_co2
FROM emissions_agriculture_total AS a
WHERE a.element='Emissions (CO2eq)'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- merge the 3 views together
CREATE VIEW merged_agr_emiss AS
SELECT a.area_code, a.area, a.year, a.agri_ch4,
b.agri_n2o, c.agri_co2
FROM first_agri_emis AS a
LEFT JOIN second_agri_emis AS b
ON a.area_code=b.area_code AND a.area=b.area AND a.year=b.year
LEFT JOIN third_agri_emis AS c
ON a.area_code=c.area_code AND a.area=c.area AND a.year=c.year
ORDER BY a.area_code, a.area, a.year ASC;
-- D - production_crop fourth
-- this is a little more complicated as 3 views will need
-- to be created then merged together
-- 'Area harvested', 'Production', 'Yield'
-- 1st view
CREATE VIEW first_crop AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS production,
COUNT(a.value) AS count_production
FROM production_crop AS a
WHERE a.element='Production'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- 2nd view
CREATE VIEW second_crop AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS harvest,
COUNT(a.value) AS count_harvest
FROM production_crop AS a
WHERE a.element='Area harvested'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- 3rd view
CREATE VIEW third_crop AS
SELECT a.area_code, a.area, a.year, SUM(a.value) AS yield,
COUNT(a.value) AS count_yield
FROM production_crop AS a
WHERE a.element='Yield'
GROUP BY a.area_code, a.area, a.year
ORDER BY a.area_code, a.area, a.year ASC;
-- merge the 3 views together
CREATE VIEW merged_crop AS
SELECT a.area_code, a.area, a.year, a.production,
b.harvest, c.yield
FROM first_crop AS a
LEFT JOIN second_crop AS b
ON a.area_code=b.area_code AND a.area=b.area AND a.year=b.year
LEFT JOIN third_crop AS c
ON a.area_code=c.area_code AND a.area=c.area AND a.year=c.year
ORDER BY a.area_code, a.area, a.year ASC;
-- Now we all marge all 4 datasets
CREATE VIEW complete_merge AS
SELECT a.area_code, a.area, a.year, a.population,
b.land_co2, c.agri_ch4, c.agri_n2o, c.agri_co2,
d.production, d.harvest, d.yield
FROM pop AS a
LEFT JOIN land_emis AS b
ON a.area_code=b.area_code AND a.area=b.area AND a.year=b.year
LEFT JOIN merged_agr_emiss AS c
ON a.area_code=c.area_code AND a.area=c.area AND a.year=c.year
LEFT JOIN merged_crop AS d
ON a.area_code=d.area_code AND a.area=d.area AND a.year=d.year
ORDER BY a.area_code, a.area, a.year ASC;
---------------------------------------------------
-- SELECT * FROM VIEW to make sure all views were merged correctly
SELECT * FROM complete_merge;
---------------------------------------------------
-- INSERT INTO complete_merge_table VIEW complete_merge
INSERT INTO complete_merge_table
SELECT * FROM complete_merge;
---------------------------------------------------
-- SELECT * FROM TABLE to make sure table was inserted correctly
SELECT * FROM complete_merge_table;
---------------------------------------------------
-- DROP VIEWS CASCADE to remove all VIEWS
-- they are no longer needed
DROP VIEW complete_merge, first_agri_emis, second_agri_emis,
third_agri_emis, first_crop, second_crop, third_crop,
land_emis, merged_agr_emiss, merged_crop, pop
CASCADE;
---------------------------------------------------
-- Need to add primary key to complete_merge_table for SQLAlchemy
-- to use automap_base()
-- Need to also change a name in one column
ALTER TABLE complete_merge_table ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE complete_merge_table RENAME COLUMN yield TO yields;
---------------------------------------------------