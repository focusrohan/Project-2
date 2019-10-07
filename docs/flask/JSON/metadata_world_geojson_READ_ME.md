# Metadata for world.geojson

## References for this data set can be found below
1. <https://github.com/johan/world.geo.json>
2. <http://www.fao.org/faostat/en/#home>
3. <http://www.fao.org/faostat/en/#data/OA>
4. <http://www.fao.org/faostat/en/#data/GL>
5. <http://www.fao.org/faostat/en/#data/GT>
6. <http://www.fao.org/faostat/en/#data/QC>

## world.geojson is in the form of an object containing objects and list of objects and lists.  Keys in the object correspond to table headers

## world.geojson structure. geojson taken from Reference 1.
{
  "type": "FeatureCollection",
  "features": {
    "type": "Feature",
    "coordinates": []
  },
  "properties": {
    "ADMIN": "Aruba",
    "ISO_A3": "ABW",
    "dict": {
            "population": 2068.8269999999998,
            "land_co2": 0.0,
            "agri_ch4": 0.0,
            "agri_n2o": 0.0,
            "agri_co2": 0.0,
            "production": 0.0,
            "harvest": 0.0,
            "yields": 0.0,
            "area": "Aruba"
        }
  }
}


## FAOSTAT Database group by on area
dict: {
        "population": 2068.8269999999998,
        "land_co2": 0.0,
        "agri_ch4": 0.0,
        "agri_n2o": 0.0,
        "agri_co2": 0.0,
        "production": 0.0,
        "harvest": 0.0,
        "yields": 0.0,
        "area": "Aruba"
    }

## The Keys and their units are listed below


### Key 8 - "area"
- #### area key houses strings (<255 characters).
- #### area key is a list of countries, administrative regions, parts of continents, continents and other geographic areas.


### Key 0 - "population"
- #### population key contains a floating point numbers which represents the total population (males and females) for a given area and sum of 1997-2017 years in the unit of 1000 persons.
- #### See Reference #2 for more information


### Key 1 - "land_co2"
- #### land_co2 key contains floating point numbers and nulls which represent total emissions from land use.  Specifically "Net emissions/removals (CO2eq)" which corresponds to the sum of 1997-2017 years net emission of equivalent carbon dioxide in the unit of gigagrams.
- #### See Reference #3 for more information


### Key 2 - "agri_ch4"
- #### agri_ch4 key contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (CH4)" which corresponds to the sum of 1997-2017 years net emission of methane in the unit of gigagrams.
- #### See Reference #4 for more information


### Key 3 - "agri_n2o"
- #### agri_n2o key contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (N2O)" which corresponds to the sum of 1997-2017 years net emission of nitrous oxide in the unit of gigagrams.
- #### See Reference #4 for more information


### Key 4 - "agri_co2"
- #### agri_co2 key contains floating point numbers and nulls which represent total emissions from agricultural use.  Specifically "Emissions (CO2eq)" which corresponds to the sum of 1997-2017 years net emission of equivalent carbon dioxide in the unit of gigagrams.
- #### See Reference #4 for more information


### Key 5 - "production"
- #### production key contains floating point numbers and nulls which represent total production of crops.  Specifically "Production Quantity" which corresponds to the sum of 1997-2017 years amount of crops produced in the unit of tonnes.
- #### See Reference #5 for more information


### Key 6 - "harvest"
- #### harvest key contains floating point numbers and nulls which represent total area harvest of crops.  Specifically "Area harvested" which corresponds to the sum of 1997-2017 years area in which crops are grown has the unit of hectares(ha).
- #### See Reference #5 for more information


### Key 7 - "yield"
- #### yield key contains floating point numbers and nulls which represent the total yield of crops.  Specifically "Yield" which corresponds to the sum of 1997-2017 years amount of crops produced in a given area in the unit of hectogramme(hg/ha).  Or unit is represented as 100 grammes per hectare(100g/ha)
- #### See Reference #5 for more information