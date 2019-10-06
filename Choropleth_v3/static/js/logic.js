// Creating map object
var myMap = L.map("map", {
  center: [40.7128, -74.0059],
  zoom: 3
});

// Adding tile layer
L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
  attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
  maxZoom: 18,
  id: "mapbox.streets",
  accessToken: API_KEY
}).addTo(myMap);

// Link to GeoJSON
var APILink = "http://data.beta.nyc//dataset/d6ffa9a4-c598-4b18-8caf-14abde6a5755/resource/74cdcc33-512f-439c-" +
"a43e-c09588c4b391/download/60dbe69bcd3640d5bedde86d69ba7666geojsonmedianhouseholdincomecensustract.geojson";

var geodata = "static/js/world.geojson";
var geojson;
var info = L.control();
 //var countriesData = geodata.features;
// TODO:

function getColor(feature){
  //n = Math.floor(Math.random() * 10); 
  //console.log("random n",n);
  var dict = feature.properties.dict;
  var population =0;
  //wl - special code to handle case where dict is not provided.
  //wl - when dict is null, it throughs an error.  To fix this I set population to 0.
  if (dict){
    //console.log("population",dict.population);
    population = dict.population
  } else{
    population = 0;
    //console.log("population",population);
  };

  return population == 0 ? '#e5f5f9' : //white
         population <= 2000 ? '#f7fcf5' :
	       population <= 10000 ? '#e5f5e0' :
	       population <= 30000 ? '#c7e9c0' :
	       population <= 50000 ? '#a1d99b' :
	       population <= 100000 ? '#41ab5d' :
	       population <= 300000 ? '#238b45' :
         population <= 500000 ? '#006d2c' :
         population <= 700000 ? '#ffeda0' :
         population <= 900000 ? '#feb24c' :
         population <= 2000000 ? '#f03b20' :  //red
	               '#00441b' ;
};

function style(feature) {
 // console.log("random color",getColor());
  //console.log("population", feature.properties.dict.population)
  return {
    fillColor: getColor(feature),
    weight: 2,
    opacity: 1,
    color: 'white',
    dashArray: '3',
    fillOpacity: 0.7
  };
}

function highlightFeature(e) {
  var layer = e.target;
  var dict = layer.feature.properties.dict;
  var message = "";
  //console.log(layer.feature.properties.dict);

  //wl - code to handle missing dict
  if (dict){
    var population = dict.population;
    layer.bindTooltip("population " + population).openTooltip();
  } else{
    layer.bindTooltip("population undefined").openTooltip();
  };
  //console.log("layer",layer.bindPopup("test").openPopup())
	layer.setStyle({
		weight: 5,
		color: '#666',
		dashArray: '',
		fillOpacity: 0.7
	});

	if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
		layer.bringToFront();
  }
  info.update(layer.feature.properties);
}

function resetHighlight(e) {
  geojson.resetStyle(e.target);
  info.update();
}

function onEachFeature(feature, layer) {
	layer.on({
		mouseover: highlightFeature,
		mouseout: resetHighlight
		// click: zoomToFeature
	});
}

// Grab data with d3
d3.json(geodata, function(response){
  // Create a new choropleth layer
  //console.log(response.features);
 //L.geoJson(response).addTo(myMap);
    // Define what  property in the features to use

    // Set color scale

    // Number of breaks in step range

    
    geojson = L.geoJson(response, {
      style: style,
      onEachFeature: onEachFeature
    }).addTo(myMap);
    // q for quartile, e for equidistant, k for k-means

    // Binding a pop-up to each layer

  // Set up the legend

    // Add min & max

  // Adding legend to the map

  

  info.onAdd = function (myMap) {
    this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
    this.update();
    return this._div;
  };
  
  // method that we will use to update the control based on feature properties passed
  info.update = function (props) {
    var text  = '<h4>Country Name</h4>' + (props ?'<b>' + props.ADMIN + '</b><br />' : 'Hover over a country');
    //console.log("html",text)
    this._div.innerHTML = text;
    //+ '<b>' + props.features.ADMIN + '</b><br />' 



    //console.log("country object", props)
    //console.log("country name", props.ADMIN)
   
  };
  
  info.addTo(myMap);

});