var yearStart = 1995;
var yearEnd = 2015;
var country = "Afghanistan";
country_year(country, yearStart, yearEnd);

// get the json from Flask
d3.json("http://127.0.0.1:5000/api/v1.0/country")
    .then(function (data) {
    // console.log() the data
    console.log(data);

    // initialize the <select> tag with <option> tags
    optionTag(data);

    var optionVal = d3.select("selDataset");
    optionVal.on("change", function() {
        var value = selectID.property("value");
        console.log(value);
    });
});


// get the json from Flask
d3.json("http://127.0.0.1:5000/api/v1.0/json")
    .then(function (data) {
    // console.log() the data
    console.log(data);


});

d3.json("http://127.0.0.1:5000/api/v1.0/geojson")
    .then(function (data) {
    // console.log() the data
    console.log(data);

});

function country_year(country, start, end) {
    d3.json(`http://127.0.0.1:5000/api/v1.0/country:${country}-start:${start}-end:${end}`)
    .then(function (data) {
    // console.log() the data
    console.log(data);

});
}

function optionTag(data) {
    var selectID = d3.select("#selDataset");

    selectID.selectAll("option")
    .data(data)
    .enter()
    .append("option")
    .html((d) => {
        var id = "id-"
        return `<option id=${id+d} value=${d}>${d}</option>`;
    });
}