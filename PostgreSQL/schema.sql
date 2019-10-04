---------------------------------------------------
-- DROP 3 primary TABLES
-- If they exist
DROP TABLE emissions_agriculture_total;
DROP TABLE emissions_land_total;
DROP TABLE production_crop;
DROP TABLE population_all;
DROP TABLE complete_merge_table;
---------------------------------------------------
-- CREATE TABLE SCHEMAS
-- Remember when importing to select the following
-- FORMAT: csv
-- ENCODING:  LATIN-1 (ISO/IEC 8859-1)
-- DELIMITER: ,
-- QUOTE: "
CREATE TABLE population_all(
    area_code INT,
    area VARCHAR(255),
    item_code INT,
    item VARCHAR(255),
    element_code INT,
    element VARCHAR(1023),
    year_code INT,
    year INT,
    unit VARCHAR(255),
    value FLOAT(24),
    flag VARCHAR(255),
    note VARCHAR(255)
);
CREATE TABLE emissions_agriculture_total(
    area_code INT,
    area VARCHAR(255),
    item_code INT,
    item VARCHAR(255),
    element_code INT,
    element VARCHAR(1023),
    year_code INT,
    year INT,
    unit VARCHAR(255),
    value FLOAT(24),
    flag VARCHAR(255),
    note VARCHAR(255)
);
CREATE TABLE production_crop(
    area_code INT,
    area VARCHAR(255),
    item_code INT,
    item VARCHAR(255),
    element_code INT,
    element VARCHAR(1023),
    year_code INT,
    year INT,
    unit VARCHAR(255),
    value FLOAT(24),
    flag VARCHAR(255)
);
CREATE TABLE emissions_land_total(
	area_code INT,
    area VARCHAR(255),
    item_code INT,
    item VARCHAR(255),
    element_code INT,
    element VARCHAR(1023),
    year_code INT,
    year INT,
    unit VARCHAR(255),
    value FLOAT(24),
    flag VARCHAR(255)
);
---------------------------------------------------
-- CREATE TABLE FOR complete_merge view
CREATE TABLE complete_merge_table(
	area_code INT,
    area VARCHAR(255),
    year INT,
    population FLOAT(24),
	land_co2 FLOAT(24),
	agri_ch4 FLOAT(24),
	agri_n2o FLOAT(24),
	agri_co2 FLOAT(24),
	production FLOAT(24),
	harvest FLOAT(24),
	yield FLOAT(24)
);
---------------------------------------------------