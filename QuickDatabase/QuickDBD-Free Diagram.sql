-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/xMOau1
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "population_all" (
    "area_code" INT   NOT NULL,
    "area" VARCHAR(255)   NOT NULL,
    "item_code" INT   NOT NULL,
    "item" VARCHAR(255)   NOT NULL,
    "element_code" INT   NOT NULL,
    "element" VARCHAR(1023)   NOT NULL,
    "year_code" INT   NOT NULL,
    "year" INT   NOT NULL,
    "unit" VARCHAR(255)   NOT NULL,
    "value" FLOAT(24)   NOT NULL,
    "flag" VARCHAR(255)   NOT NULL,
    "note" VARCHAR(255)   NOT NULL
);

CREATE TABLE "emissions_agriculture_total" (
    "area_code" INT   NOT NULL,
    "area" VARCHAR(255)   NOT NULL,
    "item_code" INT   NOT NULL,
    "item" VARCHAR(255)   NOT NULL,
    "element_code" INT   NOT NULL,
    "element" VARCHAR(1023)   NOT NULL,
    "year_code" INT   NOT NULL,
    "year" INT   NOT NULL,
    "unit" VARCHAR(255)   NOT NULL,
    "value" FLOAT(24)   NOT NULL,
    "flag" VARCHAR(255)   NOT NULL,
    "note" VARCHAR(255)   NOT NULL
);

CREATE TABLE "production_crop" (
    "area_code" INT   NOT NULL,
    "area" VARCHAR(255)   NOT NULL,
    "item_code" INT   NOT NULL,
    "item" VARCHAR(255)   NOT NULL,
    "element_code" INT   NOT NULL,
    "element" VARCHAR(1023)   NOT NULL,
    "year_code" INT   NOT NULL,
    "year" INT   NOT NULL,
    "unit" VARCHAR(255)   NOT NULL,
    "value" FLOAT(24)   NOT NULL,
    "flag" VARCHAR(255)   NOT NULL
);

CREATE TABLE "emissions_land_total" (
    "area_code" INT   NOT NULL,
    "area" VARCHAR(255)   NOT NULL,
    "item_code" INT   NOT NULL,
    "item" VARCHAR(255)   NOT NULL,
    "element_code" INT   NOT NULL,
    "element" VARCHAR(1023)   NOT NULL,
    "year_code" INT   NOT NULL,
    "year" INT   NOT NULL,
    "unit" VARCHAR(255)   NOT NULL,
    "value" FLOAT(24)   NOT NULL,
    "flag" VARCHAR(255)   NOT NULL
);

CREATE TABLE "complete_merge_table" (
    "area_code" INT   NOT NULL,
    "area" VARCHAR(255)   NOT NULL,
    "year" INT   NOT NULL,
    "population" FLOAT(24)   NOT NULL,
    "land_co2" FLOAT(24)   NOT NULL,
    "agri_ch4" FLOAT(24)   NOT NULL,
    "agri_n2o" FLOAT(24)   NOT NULL,
    "agri_co2" FLOAT(24)   NOT NULL,
    "production" FLOAT(24)   NOT NULL,
    "harvest" FLOAT(24)   NOT NULL,
    "yield" FLOAT(24)   NOT NULL
);

ALTER TABLE "emissions_agriculture_total" ADD CONSTRAINT "fk_emissions_agriculture_total_area_code_area_year" FOREIGN KEY("area_code", "area", "year")
REFERENCES "population_all" ("area_code", "area", "year");

ALTER TABLE "production_crop" ADD CONSTRAINT "fk_production_crop_area_code_area_year" FOREIGN KEY("area_code", "area", "year")
REFERENCES "population_all" ("area_code", "area", "year");

ALTER TABLE "emissions_land_total" ADD CONSTRAINT "fk_emissions_land_total_area_code_area_year" FOREIGN KEY("area_code", "area", "year")
REFERENCES "population_all" ("area_code", "area", "year");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_area_code_area_year_population" FOREIGN KEY("area_code", "area", "year", "population")
REFERENCES "population_all" ("area_code", "area", "year", "value");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_land_co2" FOREIGN KEY("land_co2")
REFERENCES "emissions_land_total" ("value");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_agri_ch4" FOREIGN KEY("agri_ch4")
REFERENCES "emissions_agriculture_total" ("value");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_agri_n2o" FOREIGN KEY("agri_n2o")
REFERENCES "emissions_agriculture_total" ("value");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_agri_co2" FOREIGN KEY("agri_co2")
REFERENCES "emissions_agriculture_total" ("value");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_production" FOREIGN KEY("production")
REFERENCES "production_crop" ("value");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_harvest" FOREIGN KEY("harvest")
REFERENCES "production_crop" ("value");

ALTER TABLE "complete_merge_table" ADD CONSTRAINT "fk_complete_merge_table_yield" FOREIGN KEY("yield")
REFERENCES "production_crop" ("value");

