console.log("Look I got flask to work");

function init() {
    var selectID1 = d3.select("#selDataset1");
    var selectID2 = d3.select("#selDataset2");

    var country_array = countries["verified_country"];
    var not_country_array = countries["Not_a_country"];

    selectID1.selectAll("option")
    .data(country_array)
    .enter()
    .append("option")
    .html((d) => {
        var id = "id-"
        return `<option id=${id+d} value=${d}>${d}</option>`;
    });

    selectID2.selectAll("option")
    .data(not_country_array)
    .enter()
    .append("option")
    .html((d) => {
        var id = "id-"
        return `<option id=${id+d} value=${d}>${d}</option>`;
    });

}

init();