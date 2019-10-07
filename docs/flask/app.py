# dependencies
from flask import Flask, jsonify
from flask_cors import CORS
import etl_flask

# Create an instance of Flask
app = Flask(__name__)

# ensure that flask server enables CORS
CORS(app)

@app.route("/")
def home():
    """List all available api routes."""
    return (
        f"Available Routes: <br/>"
        f"<a href='/api/v1.0/country'>http://127.0.0.1:5000/api/v1.0/country</a><br/>"
        f"<a href='/api/v1.0/json'>http://127.0.0.1:5000/api/v1.0/json</a><br/>"
        f"<a href='/api/v1.0/geojson'>http://127.0.0.1:5000/api/v1.0/geojson</a><br/>"
        f"<a href='/api/v1.0/country:<country>-start:<start_year>-end:<end_year>'>http://127.0.0.1:5000//api/v1.0/country:<country>-start:<start_year>-end:<end_year></a>"
    )

@app.route("/api/v1.0/country")
def json_country():
    data = etl_flask.etl_country_date()
    return jsonify(data)


@app.route("/api/v1.0/json")
def json_data():
    data = etl_flask.etl_faostat()
    return jsonify(data)

@app.route("/api/v1.0/geojson")
def geojson_data():
    data = etl_flask.etl_geojson()
    return jsonify(data)

@app.route("/api/v1.0/country:<country>-start:<start_year>-end:<end_year>")
def json_dynamic(country, start_year, end_year):
    data = etl_flask.etl_dynamic(country, start_year, end_year)
    return jsonify(data)

if __name__ == "__main__":
    app.run(debug=True)