let sessionCount = 1;
let activityCount = 1;

$(document).on('ready page:load turbolinks:load', function () {
    getLocations();
    $(".start_time").timepicker();
    $(".end_time").timepicker();

    $(".new-session").click(function () {
        newSession($(this));
    });

    $(".glyphicon-minus").click(function(){
        removeSession(this);
    });

    $(".locationselect").change(function () {
        getRooms(getName(this), $(this).parent().parent().parent());
    });

    $("#same_room").click(function () {
        useSameRoom(this);
    });

    $(".competetion").click(function () {
        setSlider(this);
    });

    // check if checkbox is checked
    setSlider($(".competetion").first());

    $(".new-activity").click(function () {
        newActivity($(this));
    });

    $("#reports_start_date").datepicker({
        dateFormat: "yy-mm-dd"
    });

    $(".accordion").hide();

    $(".accordion").parent().parent().prev().click(function () {
        const accordion = $(this).next().children().first().children().first();
        down_icon = "glyphicon glyphicon-menu-down";
        up_icon = "glyphicon glyphicon-menu-up";
        if (accordion.hasClass("Down")) {
            accordion.slideUp();
            accordion.removeClass("Down");
            $(this).children().last().children().first().removeClass(up_icon).addClass(down_icon);
        } else {
            accordion.slideDown();
            accordion.addClass("Down");
            $(this).children().last().children().first().removeClass(down_icon).addClass(up_icon);
        }
    });
});


$(document).ready(function () {
    setTimeout(function () {
        setRooms($(".col-lg-4").last().children().last().children().last())
    }, 200);

    if (($("#name_New_1").attr("value") != undefined)) {
        setTimeout(function () {
            setEditRooms()
        }, 300);
    }
    sessionCount = parseInt($("#sessions_count").val());
});

// When editing activity, will set the rooms for the sessions
function setEditRooms() {
    let activity = $("#activity_id").val();
    Rails.ajax({
        url: `/get_session_rooms/${activity}`,
        type: 'GET',
        dataType: "json",
        success: function (data) {
            var i;
            for (i = 0; i < $(".roomselect").length; i++) {
                let room = $(".roomselect").get(i);
                $(room).val(data.results.rooms[i].room_number + " (" + data.results.rooms[i].room_name + ")").change();
            }
        }
    })
}

// disables all room select except the first
function useSameRoom(e) {
    if ($(e).is(":checked")) {
        $(".roomselect").each(function () {
            if ($(this).parent().parent().parent().children().first().children().last().is($(e).parent())) {
                if (!($(this).is($(e).parent().parent().next().children(".col-lg-3").first().children().first()))) {     // make sure that the selector is not the first selector
                    $(this).css("pointer-events", "none");
                } else {
                    $(this).parent().parent().parent().children().children().children(".roomselect").slice(1).val($(this).children("option:selected").val()).change();
                }
            }
        });
    } else {
        $(".roomselect").each(function () {
            if ($(this).parent().parent().parent().children().first().children().last().is($(e).parent())) {
                $(this).css("pointer-events", "auto");
            }
        });
    }
}


function getName(selector) {
    let name = $(selector).children("option:selected").val().split("(");
    return name[0];
}

function setRooms(locations) {
    getRooms(getName(locations), $(locations).parent().parent().parent());
}

function setNewRoom(locations, selector) {
    getNewRoom(getName(locations), selector);
}

function setSlider(e) {
    if ($(e).is(":checked")) {
        // create slider
        let container = createDiv("form-group  slider");
        let label = createLabel("Team Max Size: 4");
        let slider = createSlider(activityCount);
        createSliderEvent(slider, label, "#max_team_tag_" + activityCount);
        $(container).append(label);
        $(container).append(slider);
        $(container).insertAfter($(e).parent());

    } else {
        if ($(e).parent().next().hasClass("slider")) {
            $(e).parent().next().remove();
        }
    }
}


function removePreviousButton(button) {
    $(button).remove();
}

// creates a new session row and returns the row
function createSession(New) {
    if (New === undefined) {
        New = "";
    }

    // create text boxes
    let start_date = document.createElement("input");
    $(start_date).attr("type", "text-box");
    $(start_date).timepicker();
    addAttributes(start_date, "start_time_" + New + sessionCount, "form-control");

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

    return [row, rooms];
}


// add new session
function newSession(button) {

    sessionCount += 1;
    let elements = createSession();
    let row = elements[0];
    // add row to the dom
    addElements(row, button);

    // sets the rooms
    setNewRoom($(row).parent().prev().children().last().children().last(), elements[1]);

    // remove previous button
    removePreviousButton(button);
}


// adds attributes to the elements
function addAttributes(element, name, classes) {
    $(element).attr("name", name);
    $(element).attr("class", classes);
    $(element).attr("id", name);
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
    } else {
        $(button).click(function () {
            removeSession(this);
        })
    }
    return button;
}

function removeSession(button){
    if ($(button).is($(button).parent().parent().parent().children().last().children().last().children().first()))
        $(button).parent().parent().prev().children().last().append(createButton("plus", "new-session"));
    $(button).parent().parent().remove();
}

// get the rooms for one room select element
function getNewRoom(location, selector) {
    Rails.ajax({
        url: `/get_rooms/${location}`,
        type: 'GET',
        dataType: "json",
        success: function(data){
            for(index = 0; index < data.results.rooms.length; index++){
                $(selector).append(createOption(data.results.rooms[index].room_number, data.results.rooms[index].room_name));
            }
        }
    })
}

// get the rooms for the location
function getRooms(location, parent) {
    removeRooms(parent);
    Rails.ajax({
        url: `/get_rooms/${location}`,
        type: 'GET',
        dataType: "json",
        success: function (data) {
            for (index = 0; index < data.results.rooms.length; index++) {
                $(".roomselect").each(function () {
                    if ($(this).parent().parent().parent().parent().is($(parent))) {
                        $(this).append(createOption(data.results.rooms[index].room_number, data.results.rooms[index].room_name));
                    }
                });
            }
        }
    })
}

// removes all rooms
function removeRooms(parent) {
    $(".roomselect").each(function () {
        if ($(this).parent().parent().parent().parent().is($(parent))) {
            $(this).children().remove();
        }
    });
}


// get all locations
function getLocations() {
    Rails.ajax({
        url: `/get_locations`,
        type: 'GET',
        dataType: "json",
        success: function (data) {
            for (index = 0; index < data.results.locations.length; index++) {
                $(".locationselect").append(createOption(data.results.locations[index].location_name, data.results.locations[index].address));
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


function createDiv(classes) {
    let div = document.createElement("div");
    $(div).attr("class", classes);
    return div;
}

function createLabel(text) {
    let label = document.createElement("label");
    $(label).text(text);
    return label;
}

function createSlider(count) {
    let slider = document.createElement("div");
    $(slider).attr("class", "bengal-orange team_size_" + count);
    return slider;
}

function createSliderEvent(element, label, hiddenField) {
    $(function () {
        $(element).slider({
            range: "min",
            min: 2,
            max: 4,
            value: 4,
            slide: function (event, ui) {
                $(label).text("Team Max Size: " + ui.value);
                $(hiddenField).val(ui.value)
            }
        });
        $(label).text("Team Max Size: " + $(element).slider("value"));
        $(hiddenField).val($(element).slider("value"));
    })

}

function createInput(type) {
    let tbx = document.createElement("input");
    $(tbx).attr("type", type);
    return tbx;
}

function appendElements(container, element) {
    $(container).append(element);
}

// create a new activity
function newActivity() {
    activityCount += 1;
    sessionCount += 1;

    // create labels
    let lName = createLabel("Activity Name");
    let lDescription = createLabel("Activity Description");
    let lMakeAhead = createLabel("Is Make Ahead");
    let lCompetition = createLabel("Is Competition");
    let lLocation = createLabel("Choose Location of Activity");

    // create inputs
    let tName = createInput("text-box");
    addAttributes(tName, "name_New_" + activityCount, "form-control");
    let tDescription = createInput("text-box");
    addAttributes(tDescription, "description_" + activityCount, "form-control");
    let tMakeAhead = createInput("checkbox");
    addAttributes(tMakeAhead, "ismakeahead_" + activityCount, "");
    let tCompetition = createInput("checkbox");
    addAttributes(tCompetition, "iscompetetion_" + activityCount, "competition");
    let tLocation = document.createElement("select");
    addAttributes(tLocation, "location_select_" + activityCount, "form-control locationselect");
    let hidden = createInput("hidden");
    addAttributes(hidden, "max_team_tag_" + activityCount, "max_team_tag_" + activityCount);

    // append hidden field
    $("#activity-form").append(hidden);

    // create containers
    let con1 = createDiv("form-group");
    let con2 = createDiv("form-group");
    let con3 = createDiv("form-group");
    let con4 = createDiv("form-group");
    let con5 = createDiv("form-group");
    let container1 = createDiv("col-lg-4 border-right");
    let container2 = createDiv("col-lg-8");

    // append elements to containers
    appendElements(con1, lName);
    appendElements(con1, tName);
    appendElements(con2, lDescription);
    appendElements(con2, tDescription);
    appendElements(con3, tMakeAhead);
    appendElements(con3, lMakeAhead);
    appendElements(con4, tCompetition);
    appendElements(con4, lCompetition);
    appendElements(con5, lLocation);
    appendElements(con5, tLocation);

    // append containers
    $(container1).append(con1);
    $(container1).append(con2);
    $(container1).append(con3);
    $(container1).append(con4);
    $(container1).append(con5);

    let hr = document.createElement("hr");
    $(hr).insertAfter($(".row").last().prev());

    let row = createRow();
    $(row).append(container1);
    $(row).append(container2);
    $(row).insertAfter($(hr));

    getLocations();
    // competition slider
    $(tCompetition).click(function () {
        setSlider(this);
    });
    // change in location
    $(tLocation).change(function () {
        getRooms(getName(this), $(this).parent().parent().parent());
    });

    let elements = createSession("New_");
    let row2 = elements[0];
    let row3 = createSessionLabels();


    appendElements(container2, row3);
    appendElements(container2, row2);


    setTimeout(function () {
        setRooms("#location_select_" + activityCount)
    }, 200);

}

// creates all elements for a session
function createSessionLabels() {
    // create row and columns
    let row = createRow();
    let col1 = createDiv("col-lg-2");
    let col2 = createDiv("col-lg-2");
    let col3 = createDiv("col-lg-3");
    let col4 = createDiv("col-lg-2");
    let col5 = createDiv("col-lg-3 form-group");

    let lTime = createLabel("Start Time");
    let lETime = createLabel("End Time");
    let lRoom = createLabel("Room");
    let lCapacity = createLabel("Capacity");
    let tbx = createInput("checkbox");
    addAttributes(tbx, "same_room" + sessionCount, "");
    let lTbx = createLabel(" Same room");

    // append elements to columns
    appendElements(col1, lTime);
    appendElements(col2, lETime);
    appendElements(col3, lRoom);
    appendElements(col4, lCapacity);
    appendElements(col5, tbx);
    appendElements(col5, lTbx);

    // append columns to row
    appendElements(row, col1);
    appendElements(row, col2);
    appendElements(row, col3);
    appendElements(row, col4);
    appendElements(row, col5);

    $(tbx).click(function () {
        useSameRoom(this);
    });
    return row;
}


// view report page






