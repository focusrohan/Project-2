var totalData = new Object();  //lets keep it simple and let Dan's data be public
var countryArray = [];  //code to get array of dictionaries
var countryList = [];  //array of unique countries
var dropDownValue = ""; //user selected country
var yearsArray = [];  //array of years for a given country
var filteredCountries = []; //array of filtered counties based on the dropdown menu
var populationArray = [];  //array of population for a given country
var productionArray = []; //array of crop production for a given country
var co2Array = []; //array of CO2 emission for a given country

init();

//Init
function init(){
    getData();
    updatePlotly();
};


//Read in JSON
function getData(){
    console.log("start")
    d3.json("./static/js/total.json").then(data => {
        //console.log('data',data[0].area);
        //console.log('data',data.area);
        totalData = data;
        //console.log("total data", totalData)
        getCountryList();
        getDropDownMenu();


        // Call updatePlotly() when a change takes place to the DOM
        d3.selectAll("#selDataset").on("change", updatePlotly);  
    });
};



//populate and create the dropdown menu
function getDropDownMenu(){
    console.log("Country List",countryList);
    //binding data
    //This populates the dropdown list in html using dynamic D3 data binding
    // @wl - this code is working.  I am able to populate the dropdown
    d3.select("#selDataset").selectAll("option")
        .data(countryList)
        .enter()
        .append("option")
        .html(function(d){
            //console.log(d)
            return `<option value="${d}">${d}</option>`
        });
};

//populate the country list by looping through the data set and appending country name to countryList
function getCountryList(){
    countryArray = Object.values(totalData);  //code to get array of dictionaries
    countryList = countryArray.map(countryArray => countryArray.area);
    var uniqueCountryList = [...new Set(countryList)]  //use set() to get unique values of an array.
    countryList = uniqueCountryList;   //now set the countryList to an unique list
    
    //console.log("list of keys",totalData);
    //console.log("country list",countryList);
    //console.log("unique country list",uniqueCountryList);
};

//Control what happens when a country from the dropdown is selected
function updatePlotly() {
    // Use D3 to select the dropdown menu
    var dropdownMenu = d3.select("#selDataset");
    dropDownValue = dropdownMenu.property("value");
    filteredCountries = countryArray.filter(filterCountryData);  //select data based on dropdown menu
    yearsArray = filteredCountries.map(filteredCountries => filteredCountries.year);
    populationArray = filteredCountries.map(filteredCountries => filteredCountries.population);
    productionArray = filteredCountries.map(filteredCountries => filteredCountries.production);
    co2Array = filteredCountries.map(filteredCountries => filteredCountries.agri_co2);

    drawGraphs();

};


//Use filter to get records related to a country
function filterCountryData(country){
    //console.log("country",country);
    //console.log("info",country);
    return country.area == dropDownValue;
}

//draw a graph
//@param: x as years
//@param: y as population
function drawGraphs(){
    var trace1 = {
        x: yearsArray,
        y: populationArray,
        type:"bar"
    };

    var trace2 = {
        x: yearsArray,
        y: productionArray,
        type:"bar"
    };

    var trace3 = {
        x: yearsArray,
        y: co2Array,
        type:"bar"
    };

    var data1 = [trace1];
    var data2 = [trace2];
    var data3 = [trace3];

    var layout1 = {
        title: "Population over the years" ,
        yaxis: { title: "Population" },
        xaxis: { title: "Year" }
    };

    var layout2 = {
        title: "Production over the years" ,
        yaxis: { title: "Production" },
        xaxis: { title: "Year" }
    };

    var layout3 = {
        title: "CO2 emissions over the years" ,
        yaxis: { title: "CO2 emission" },
        xaxis: { title: "Year" }
    };

    Plotly.newPlot("bar1", data1, layout1);
    Plotly.newPlot("bar2", data2, layout2);
    Plotly.newPlot("bar3", data3, layout3);
};