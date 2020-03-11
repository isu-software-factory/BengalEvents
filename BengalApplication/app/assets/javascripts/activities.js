$(document).on('ready page:load turbolinks:load', function () {
    getLocations();
    $(".start_time").timepicker();
    $("#locationselect").change(function () {
        getRooms(getName(this));
    });


    $(".new-session").click(function () {
        newSession($(this));
    });

});

function getName(selector) {
    let name = $(selector).children("option:selected").val().split("(");
    return name[0];
}

$(document).ready(function () {
    getRooms(getName("#locationselect"));
});


let sessionCount = 1;

// add new session
function newSession(button) {
    sessionCount += 1;
    // create text boxes
    let start_date = document.createElement("input");
    $(start_date).attr("type", "text-box");
    $(start_date).timepicker();
    addAttributes(start_date, "start_date_" + sessionCount, "form-control");

    let rooms = document.createElement("select");
    addAttributes(rooms, "rooms_select_" + sessionCount, "form-control roomselect");

    let capacity = document.createElement("input");
    $(capacity).attr("type", "text-box");
    addAttributes(capacity, "capacity_" + sessionCount, "form-control");

    // create button
    let btn = createButton();

    // create containers
    // create row
    let row = createRow();

    // create columns
    let col1 = createColumn();
    let col2 = createColumn();
    let col3 = createColumn();
    let col4 = createColumn();

    // add elements to column
    addElementsToColumn(start_date, col1);
    addElementsToColumn(rooms, col2);
    addElementsToColumn(capacity, col3);
    addElementsToColumn(btn, col4);

    // add columns to row
    addElementsToRow(col1, col2, col3, col4, row);

    // add row to the dom
    addElements(row, button);
}


// adds attributes to the elements
function addAttributes(element, name, classes) {
    $(element).attr("name", name);
    $(element).attr("class", classes);
}


// adds elements to the column passed
function addElementsToColumn(element, column) {
    $(column).append(element);
}

// adds columns to the row
function addElementsToRow(col1, col2, col3, col4, row) {
    $(row).append(col1);
    $(row).append(col2);
    $(row).append(col3);
    $(row).append(col4);
}

// adds the elements to the container of button
function addElements(row, button) {
    let container = $(button).parent().parent().parent();
    // add rwo to container
    $(container).append(row);
}


// create a div with class col-lg
function createColumn() {
    let col = document.createElement("div");
    $(col).attr("class", "col-lg-3");
    return col;
}

// create a div with class row
function createRow() {
    let row = document.createElement("div");
    $(row).attr("class", "row top-indent");
    return row;
}

// create a button
function createButton() {
    let button = document.createElement("button");
    $(button).attr("class", "button-small glyphicon glyphicon-plus new-session");
    $(button).attr("title", "Add New Session");
    $(button).attr("type", "button");
    $(button).click(function () {
        newSession($(this));
    });
    return button;
}


// get the rooms for the location
function getRooms(location) {
    removeRooms();
    Rails.ajax({
        url: `get_rooms/${location}`,
        type: 'GET',
        dataType: "json",
        success: function (data) {
            for (index = 0; index < data.results.rooms.length; index++) {
                $(".roomselect").append(createOption(data.results.rooms[index].room_number, data.results.rooms[index].room_name));
            }
        }
    })
}

// removes all rooms
function removeRooms() {
    $(".roomselect").children().remove();
}


// get all locations
function getLocations() {
    Rails.ajax({
        url: `get_locations`,
        type: 'GET',
        dataType: "json",
        success: function (data) {
            for (index = 0; index < data.results.locations.length; index++) {
                $("#locationselect").append(createOption(data.results.locations[index].location_name, data.results.locations[index].address));
            }
        }
    })
}

// create an option element
function createOption(name1, name2) {
    let option = document.createElement("option");
    $(option).text(name1 + " (" + name2 + ")");
    return option;
}