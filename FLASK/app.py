# dependencies
import requests
import json
import sqlalchemy
import os
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, inspect, func
from sqlalchemy import and_, or_, not_
from flask import Flask, render_template, redirect, send_from_directory

# Password and user for postgreSQL DB
from config import postgreSQL_User, postgreSQL_Pass

# establish connection to database
rds_connection_string = f"postgresql://{postgreSQL_User}:{postgreSQL_Pass}@localhost:5432/FAOSTAT"
engine = create_engine(rds_connection_string)

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# We can view all of the classes that automap found
Base.classes.keys()

# use inspector to get table_names
inspector = inspect(engine)
inspector.get_table_names()

# show columns
columns = inspector.get_columns('complete_merge_table')
print("""complete_merge_table
------------------------""")
for c in columns:
    print(c['name'], c["type"])
print("------------------------")

# Save reference to table
Total = Base.classes.complete_merge_table

# Create our session (link) from Python to the DB
session = Session(engine)

# get a list of area names in complete_merge_table
count_names = session.query(Total.area).all()

# iterate through the list of tuples and append to list
areas = [x[0] for x in count_names]
output = []
for y in areas:
    if y not in output:
        output.append(y)

# get a list of known countries
# https://github.com/Miguel-Frazao/world-data
req = requests.get('https://raw.githubusercontent.com/Miguel-Frazao/world-data/master/countries.json').json()
countries = (i['name'] for i in req)
country_list = list(countries)

# Return a list that is identical to both output and country_list
country_verified = list(set(country_list) & set(output))
country_verified.sort()

# Return a list that is the difference between the two
not_country = list(set(output) - set(country_list))
not_country.sort()

# Use a dictionary to hold all results
dictionary = {
    "database": output,
    "verified_country": country_verified,
    "Not_a_country": not_country
}
dict_json = json.dumps(dictionary, sort_keys=True)
print(dict_json)

# Create an instance of Flask
app = Flask(__name__)

@app.route("/")
def home():

    # Return template and data
    return render_template(\
        "index.html", dict_json=dict_json)

@app.route('/js/<path:filename>')
def serve_static(filename):
    root_dir = os.path.dirname(os.getcwd())
    return send_from_directory(os.path.join(root_dir, 'static', 'js'), filename)

if __name__ == "__main__":
    app.run(debug=True)










