$(document).on('ready page:load turbolinks:load', function () {
    getLocations();
    $(".start_time").timepicker();
    $(".end_time").timepicker();

    $(".new-session").click(function () {
        newSession($(this));
    });

    $("#locationselect").change(function () {
        getRooms(getName(this));
    });

    $("#same_room").click(function(){
        if($(this).is(":checked")){
            $(".roomselect").prop("disabled", "disabled");
            $(".roomselect").first().prop("disabled", false);
            $(".roomselect").first().change(function(){
                $(".roomselect").slice(1).val($(this).children("option:selected").val()).change();
            })
        }else{
            $(".roomselect").prop("disabled", false);
        }
    });
});

$(document).ready(function () {
    setRooms();
});

function getName(selector) {
    let name = $(selector).children("option:selected").val().split("(");
    return name[0];
}

function setRooms(){
    getRooms(getName("#locationselect"));
}



let sessionCount = 1;

function removePreviousButton(button){
    $(button).remove();
}

// add new session
function newSession(button) {

    sessionCount += 1;
    // create text boxes
    let start_date = document.createElement("input");
    $(start_date).attr("type", "text-box");
    $(start_date).timepicker();
    addAttributes(start_date, "start_time_" + sessionCount, "form-control");

    let end_time = document.createElement("input");
    $(end_time).attr("type", "text-box");
    $(end_time).timepicker();
    addAttributes(end_time, "end_time_" + sessionCount, "form-control");

    let rooms = document.createElement("select");
    addAttributes(rooms, "room_select_" + sessionCount, "form-control roomselect");

    let capacity = document.createElement("input");
    $(capacity).attr("type", "text-box");
    addAttributes(capacity, "capacity_" + sessionCount, "form-control");

    // create button
    let btn = createButton("plus", "new-session");
    let mBtn = createButton("minus", "");

    // create containers
    // create row
    let row = createRow();

    // create columns
    let col1 = createColumn("col-lg-2");
    let col2 = createColumn("col-lg-2");
    let col3 = createColumn("col-lg-3");
    let col4 = createColumn("col-lg-2");
    let col5 = createColumn("col-lg-3");

    // add elements to column
    addElementsToColumn(start_date, col1);
    addElementsToColumn(end_time, col2);
    addElementsToColumn(rooms, col3);
    addElementsToColumn(capacity, col4);
    addElementsToColumn(mBtn, col5);
    addElementsToColumn(btn, col5);

    // add columns to row
    addElementsToRow(col1, col2, col3, col4, col5, row);

    // add row to the dom
    addElements(row, button);

    // sets the rooms
    setRooms();

    // remove previous button
    removePreviousButton(button);
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
function addElementsToRow(col1, col2, col3, col4, col5, row) {
    $(row).append(col1);
    $(row).append(col2);
    $(row).append(col3);
    $(row).append(col4);
    $(row).append(col5);

}

// adds the elements to the container of button
function addElements(row, button) {
    let container = $(button).parent().parent().parent();
    // add rwo to container
    $(container).append(row);
}


// create a div with class col-lg
function createColumn(size) {
    let col = document.createElement("div");
    $(col).attr("class", size);
    return col;
}

// create a div with class row
function createRow() {
    let row = document.createElement("div");
    $(row).attr("class", "row top-indent");
    return row;
}

// create a button
function createButton(type, sessionType) {
    let button = document.createElement("button");
    $(button).attr("class", "button-small glyphicon glyphicon-" + type + " left-indent " + sessionType);
    $(button).attr("title", "Add New Session");
    $(button).attr("type", "button");
    if (type == "plus") {
        $(button).click(function () {
            newSession($(this));
        });
    }else{
        $(button).click(function(){
            $(this).parent().parent().prev().children().last().append(createButton("plus", "new-session"));
            $(this).parent().parent().remove();
        })
    }
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
    let insideText = name1 + " (" + name2 + ")";
    $(option).text(insideText);
    $(option).attr("value", insideText);
    return option;
}