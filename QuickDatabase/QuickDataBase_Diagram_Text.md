# Modify this code to update the DB schema diagram.
# To reset the sample schema, replace everything with
# two dots ('..' - without quotes).

population_all
rel emissions_agriculture_total
rel production_crop
rel emissions_land_total
rel complete_merge_table
-
area_code INT
area VARCHAR(255)
item_code INT
item VARCHAR(255)
element_code INT
element VARCHAR(1023)
year_code INT
year INT
unit VARCHAR(255)
value FLOAT(24)
flag VARCHAR(255)
note VARCHAR(255)

emissions_agriculture_total
rel production_crop
rel emissions_land_total
rel complete_merge_table
-
area_code INT FK >-< population_all.area_code
area VARCHAR(255) FK >-< population_all.area
item_code INT
item VARCHAR(255)
element_code INT
element VARCHAR(1023)
year_code INT
year INT FK >-< population_all.year
unit VARCHAR(255)
value FLOAT(24)
flag VARCHAR(255)
note VARCHAR(255)

production_crop
rel emissions_land_total
rel complete_merge_table
-
area_code INT FK >-< population_all.area_code
area VARCHAR(255) FK >-< population_all.area
item_code INT
item VARCHAR(255)
element_code INT
element VARCHAR(1023)
year_code INT
year INT FK >-< population_all.year
unit VARCHAR(255)
value FLOAT(24)
flag VARCHAR(255)

emissions_land_total
rel complete_merge_table
-
area_code INT FK >-< population_all.area_code
area VARCHAR(255) FK >-< population_all.area
item_code INT
item VARCHAR(255)
element_code INT
element VARCHAR(1023)
year_code INT
year INT FK >-< population_all.year
unit VARCHAR(255)
value FLOAT(24)
flag VARCHAR(255)

complete_merge_table
-
area_code INT FK >-< population_all.area_code
area VARCHAR(255) FK >-< population_all.area
year INT FK >-< population_all.year
population FLOAT(24) FK >-< population_all.value
land_co2 FLOAT(24) FK >-< emissions_land_total.value
agri_ch4 FLOAT(24) FK >-< emissions_agriculture_total.value
agri_n2o FLOAT(24) FK >-< emissions_agriculture_total.value
agri_co2 FLOAT(24) FK >-< emissions_agriculture_total.value
production FLOAT(24) FK >-< production_crop.value
harvest FLOAT(24) FK >-< production_crop.value
yield FLOAT(24) FK >-< production_crop.value