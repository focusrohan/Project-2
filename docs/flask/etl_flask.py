# dependencies
# import pandas to display the database as a dataframe
import pandas as pd
# access list of country names json from a website
import requests
# import json to turn dictionaries to json files
import json
# sqlalchemy dependencies in order to access FAOSTAT database
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
# Password and user for postgreSQL DB
from config import postgreSQL_User, postgreSQL_Pass

def etl_country_date():

    # establish connection to database
    rds_connection_string = f"postgresql://{postgreSQL_User}:{postgreSQL_Pass}@localhost:5432/FAOSTAT"
    engine = create_engine(rds_connection_string)

    # reflect an existing database into a new model
    Base = automap_base()
    # reflect the tables
    Base.prepare(engine, reflect=True)

    # We can view all of the classes that automap found
    Base.classes.keys()

    # Save reference to table
    Total = Base.classes.complete_merge_table

    # Create our session (link) from Python to the DB
    session = Session(engine)

    # count_names holds a list of tuples
    count_names = session.query(Total.area).all()

    # Append to list the first element in the list of tuples
    areas = [x[0] for x in count_names]

    # initialize empty list
    output = []

    # for the list of areas, check to see if there are any distinct
    # values and append it to a new list
    for y in areas:
        if y not in output:
            output.append(y)

    # Get a list of known countries in the world
    # https://github.com/Miguel-Frazao/world-data
    # req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries_data.json').json()
    req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries.json').json()
    countries = (i['name'] for i in req)
    country_list = list(countries)

    # use set and & to get a new list of compared country values
    country_verified = list(set(country_list) & set(output))
    country_verified.sort()

    # Get a list of known countries in the world
    # https://github.com/Miguel-Frazao/world-data
    # req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries_data.json').json()
    req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries.json').json()
    countries = (i['name'] for i in req)
    country_list = list(countries)

    # use set and & to get a new list of compared country values
    country_verified = list(set(country_list) & set(output))
    country_verified.sort()

    return country_verified

def etl_faostat():

    # establish connection to database
    rds_connection_string = f"postgresql://{postgreSQL_User}:{postgreSQL_Pass}@localhost:5432/FAOSTAT"
    engine = create_engine(rds_connection_string)

    # reflect an existing database into a new model
    Base = automap_base()
    # reflect the tables
    Base.prepare(engine, reflect=True)

    # We can view all of the classes that automap found
    Base.classes.keys()

    # Save reference to table
    Total = Base.classes.complete_merge_table

    # Create our session (link) from Python to the DB
    session = Session(engine)

    # count_names holds a list of tuples
    count_names = session.query(Total.area).all()

    # Append to list the first element in the list of tuples
    areas = [x[0] for x in count_names]

    # initialize empty list
    output = []

    # for the list of areas, check to see if there are any distinct
    # values and append it to a new list
    for y in areas:
        if y not in output:
            output.append(y)

    # Get a list of known countries in the world
    # https://github.com/Miguel-Frazao/world-data
    # req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries_data.json').json()
    req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries.json').json()
    countries = (i['name'] for i in req)
    country_list = list(countries)

    # use set and & to get a new list of compared country values
    country_verified = list(set(country_list) & set(output))
    country_verified.sort()

    # use set and - to get a list of areas which are not countries
    not_country = list(set(output) - set(country_list))
    not_country.sort()

    # use pd.read_sql_query() to create a dataframe from the SQL query
    # .copy() make a copy of the dataframe so that it can be made into a dictionary
    total_df = pd.read_sql_query('select * from complete_merge_table', con=engine)
    
    # Initialize an empty list
    index_list = []

    # fill the index_list with a list of indexes for non-countries
    for y in not_country:
        index_list += total_df.index[total_df['area'] == y].tolist()

    # Delete these row indexes from dataFrame
    total_df.drop(index_list, inplace=True)

    # Get a dataframe with just area, year and population
    # remove all NaN values from the dataframe
    total_df = total_df.loc[(total_df['year'] >= 1995) &\
                            (total_df['year'] <= 2015)]
    total_df.fillna(0, inplace = True)
    total_dict = total_df.to_dict(orient="records")

    # Group by year with the sum aggregate function
    # Limit the year range between 1997 till 2017
    # drop columns which contain no useful information
    groupby_year_df = total_df.groupby("year").sum()
    groupby_year_df['year'] = groupby_year_df.index
    groupby_year_df = groupby_year_df.loc[(groupby_year_df['year'] >= 1995) &\
                                        (groupby_year_df['year'] <= 2015)]
    groupby_year_df.drop(["area_code", "id"], axis=1, inplace=True)

    # Group by area name with the sum aggregate function
    # Limit the year range between 1997 till 2017
    # drop columns which contain no useful information
    total_df = total_df.loc[(total_df['year'] >= 1995) &\
                            (total_df['year'] <= 2015)]
    groupby_area_df = total_df.groupby("area").sum()
    groupby_area_df['area'] = groupby_area_df.index
    groupby_area_df.drop(["area_code", "id", "year"], axis=1, inplace=True)

    # Get group by by year and area into dictionaries
    year_dict = groupby_year_df.to_dict(orient="records")
    area_dict = groupby_area_df.to_dict(orient="records")

    # make an overall dictionary containing a list of countries,
    # not countries, groupby by year and country and the total dataframe
    master_dict = {
        "Areas": {
            "Country": country_verified
        },
        "Groupby": {
            "Years": year_dict,
            "Countries": area_dict
        },
        "Total_Country": total_dict
    }

    # write the dataframe as a json file to a local file
    with open('./JSON/final.json', 'w', encoding="latin-1") as outfile:
        json.dump(master_dict, outfile)

    return master_dict

def etl_geojson():

    # establish connection to database
    rds_connection_string = f"postgresql://{postgreSQL_User}:{postgreSQL_Pass}@localhost:5432/FAOSTAT"
    engine = create_engine(rds_connection_string)

    # reflect an existing database into a new model
    Base = automap_base()
    # reflect the tables
    Base.prepare(engine, reflect=True)

    # We can view all of the classes that automap found
    Base.classes.keys()

    # Save reference to table
    Total = Base.classes.complete_merge_table

    # Create our session (link) from Python to the DB
    session = Session(engine)

    # count_names holds a list of tuples
    count_names = session.query(Total.area).all()

    # Append to list the first element in the list of tuples
    areas = [x[0] for x in count_names]

    # initialize empty list
    output = []

    # for the list of areas, check to see if there are any distinct
    # values and append it to a new list
    for y in areas:
        if y not in output:
            output.append(y)

    # Get a list of known countries in the world
    # https://github.com/Miguel-Frazao/world-data
    # req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries_data.json').json()
    req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries.json').json()
    countries = (i['name'] for i in req)
    country_list = list(countries)

    # use set and & to get a new list of compared country values
    country_verified = list(set(country_list) & set(output))
    country_verified.sort()

    # use set and - to get a list of areas which are not countries
    not_country = list(set(output) - set(country_list))
    not_country.sort()

    # use pd.read_sql_query() to create a dataframe from the SQL query
    total_df = pd.read_sql_query('select * from complete_merge_table', con=engine)

    # Initialize an empty list
    index_list = []

    # fill the index_list with a list of indexes for non-countries
    for y in not_country:
        index_list += total_df.index[total_df['area'] == y].tolist()

    # Delete these row indexes from dataFrame
    total_df.drop(index_list, inplace=True)
    total_df = total_df.loc[(total_df['year'] >= 1995) &\
                            (total_df['year'] <= 2015)]
    total_df.fillna(0, inplace = True)


    # Group by area name with the sum aggregate function
    # Limit the year range between 1997 till 2017
    # drop columns which contain no useful information
    total_df = total_df.loc[(total_df['year'] >= 1995) &\
                            (total_df['year'] <= 2015)]
    groupby_area_df = total_df.groupby("area").sum()
    groupby_area_df['area'] = groupby_area_df.index
    groupby_area_df.drop(["area_code", "id", "year"], axis=1, inplace=True)

    # get area group by into a dictionary
    area_dict = groupby_area_df.to_dict(orient="records")

    # open a file containing geojson data about the countries of the world
    with open('./JSON/countries.geojson') as json_file:
        geojson = json.load(json_file)

    # check for country name in geojson matched in groupby area data and
    # append to geojson the groupby data for later binding to
    # tooltips and popups
    for x in range(len(geojson["features"])):
        for y in range(len(area_dict)):
            if area_dict[y]["area"].lower() == geojson["features"][x]["properties"]["ADMIN"].lower():
                geojson["features"][x]["properties"]["dict"] = area_dict[y]

    # write the dataframe as a geojson file to a local file
    with open('./JSON/world.geojson', 'w', encoding="latin-1") as outfile:
        json.dump(geojson, outfile)

    return geojson

def etl_dynamic(country, start_year, end_year):

    # make sure inputs are appropriate data types
    country = str(country)
    start_year = int(start_year)
    end_year = int(end_year)

    # establish connection to database
    rds_connection_string = f"postgresql://{postgreSQL_User}:{postgreSQL_Pass}@localhost:5432/FAOSTAT"
    engine = create_engine(rds_connection_string)

    # make into a dataframe, use .loc() to parse out the area and year,
    # have return it as a dict
    df = pd.read_sql_query('select * from complete_merge_table', con=engine)
    df = df.loc[(df['year'] >= 1995) &\
                (df['year'] <= 2015)]
    df.fillna(0, inplace = True)
    select_df = df.loc[(df['area'] == country) & (df['year'] >= start_year) & (df['year'] <= end_year)]
    dynamic_dict = select_df.to_dict(orient="records")

    return dynamic_dict