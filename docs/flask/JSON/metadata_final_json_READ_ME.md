# Metadata for final.json

## References for this data set can be found below
1. <http://www.fao.org/faostat/en/#home>
2. <http://www.fao.org/faostat/en/#data/OA>
3. <http://www.fao.org/faostat/en/#data/GL>
4. <http://www.fao.org/faostat/en/#data/GT>
5. <http://www.fao.org/faostat/en/#data/QC>

## final.json is in the form of an object containing objects and list of objects and lists.  Keys in the object correspond to table headers

## Final.json structure.
{
    "Areas": {
        "Country": [],
        "Area": []
    },
    "Groupby": {
        "Years": [{}],
        "Countries": [{}]
    },
    "Total": [{dict}]
}


## FAOSTAT Database as a list of objects
dict = [
    {
        "area_code": 1,
        "area": "Armenia",
        "year": 1992,
        "population": 3442.81,
        "land_co2": 4.3864,
        "agri_ch4": 56.4059,
        "agri_n2o": 4.3444,
        "agri_co2": 3168.69,
        "production": 3338350.0,
        "harvest": 820988.0,
        "yields": 3106020.0
    },
]

## The Keys and their units are listed below

### Key 0 - "area_code"
- #### area_code key houses integers which correspond to key 1 - "area".


### Key 1 - "area"
- #### area key houses strings (<255 characters) which correspond to key 0 - "area_code".
- #### area key is a list of countries, administrative regions, parts of continents, continents and other geographic areas.


### Key 2 - "year"
- #### year key contains a 4 digit integer representing the year from ~1950 to ~2100


### Key 3 - "population"
- #### population key contains a floating point numbers which represents the total population (males and females) for a given area and year in the unit of 1000 persons.
- #### See Reference #2 for more information


### Key 4 - "land_co2"
- #### land_co2 key contains floating point numbers and nulls which represent total emissions from land use.  Specifically "Net emissions/removals (CO2eq)" which corresponds to the net emission of equivalent carbon dioxide in the unit of gigagrams.
- #### See Reference #3 for more information


### Key 5 - "agri_ch4"
- #### agri_ch4 key contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (CH4)" which corresponds to the net emission of methane in the unit of gigagrams.
- #### See Reference #4 for more information


### Key 6 - "agri_n2o"
- #### agri_n2o key contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (N2O)" which corresponds to the net emission of nitrous oxide in the unit of gigagrams.
- #### See Reference #4 for more information


### Key 7 - "agri_co2"
- #### agri_co2 key contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (CO2eq)" which corresponds to the emission of equivalent carbon dioxide in the unit of gigagrams.
- #### See Reference #4 for more information


### Key 8 - "production"
- #### production key contains floating point numbers and nulls which represent total production of crops.  Specifically "Production Quantity" which corresponds to the amount of crops produced in the unit of tonnes.
- #### See Reference #5 for more information


### Key 9 - "harvest"
- #### harvest key contains floating point numbers and nulls which represent total area harvest of crops.  Specifically "Area harvested" which corresponds to the area in which crops are grown has the unit of hectares(ha).
- #### See Reference #5 for more information


### Key 10 - "yield"
- #### yield key contains floating point numbers and nulls which represent the total yield of crops.  Specifically "Yield" which corresponds to the amount of crops produced in a given area in the unit of hectogramme(hg/ha).  Or unit is represented as 100 grammes per hectare(100g/ha)
- #### See Reference #5 for more information