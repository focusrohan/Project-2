# Metadata for total.csv

## References for this data set can be found below
1. <http://www.fao.org/faostat/en/#home>
2. <http://www.fao.org/faostat/en/#data/OA>
3. <http://www.fao.org/faostat/en/#data/GL>
4. <http://www.fao.org/faostat/en/#data/GT>
5. <http://www.fao.org/faostat/en/#data/QC>

## total.csv is in the form of a table with "," delimiter and LATIN-1 encoding

## Ex.
area_code,area,year,population,land_co2,agri_ch4,agri_n2o,agri_co2,production,harvest,yield
1,Armenia,1992,3442.81,4.3864,56.4059,4.3444,3168.69,3338350.0,820988.0,3106020.0

## The Columns and their units are listed below

### Column 1 (area_code)
- #### area_code column houses integers which correspond to column 2.


### Column 2 (area)
- #### area column houses strings (<255 characters) which correspond to column 1.
- #### area column is a list of countries, administrative regions, parts of continents, continents and other geographic areas.


### Column 3 (year)
- #### year column contains a 4 digit integer representing the year from ~1950 to ~2100


### Column 4 (population)
- #### population column contains a floating point numbers which represents the total population (males and females) for a given area and year in the unit of 1000 persons.
- #### See Reference #2 for more information


### Column 5 (land_co2)
- #### land_co2 column contains floating point numbers and nulls which represent total emissions from land use.  Specifically "Net emissions/removals (CO2eq)" which corresponds to the net emission of equivalent carbon dioxide in the unit of gigagrams.
- #### See Reference #3 for more information


### Column 6 (agri_ch4)
- #### agri_ch4 column contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (CH4)" which corresponds to the net emission of methane in the unit of gigagrams.
- #### See Reference #4 for more information


### Column 7 (agri_n2o)
- #### agri_n2o column contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (N2O)" which corresponds to the net emission of nitrous oxide in the unit of gigagrams.
- #### See Reference #4 for more information


### Column 8 (agri_co2)
- #### agri_co2 column contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (CO2eq)" which corresponds to the emission of equivalent carbon dioxide in the unit of gigagrams.
- #### See Reference #4 for more information


### Column 9 (production)
- #### production column contains floating point numbers and nulls which represent total production of crops.  Specifically "Production Quantity" which corresponds to the amount of crops produced in the unit of tonnes.
- #### See Reference #5 for more information


### Column 10 (harvest)
- #### harvest column contains floating point numbers and nulls which represent total area harvest of crops.  Specifically "Area harvested" which corresponds to the area in which crops are grown has the unit of hectares(ha).
- #### See Reference #5 for more information


### Column 11 (yield)
- #### yield column contains floating point numbers and nulls which represent the total yield of crops.  Specifically "Yield" which corresponds to the amount of crops produced in a given area in the unit of hectogramme(hg/ha).  Or unit is represented as 100 grammes per hectare(100g/ha)
- #### See Reference #5 for more information