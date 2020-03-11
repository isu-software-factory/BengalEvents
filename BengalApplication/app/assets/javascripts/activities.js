$(document).on('ready page:load turbolinks:load', function () {
  getLocations();
  $(".start_time").timepicker();
  $(".locationselect").change(function(){
      let name = $(this).children("option:selected").val().split("(");
      getRooms(name[0]);
  });

  $(".new-session").click(function(){
      newSession($(this));
  })


});
let sessionCount = 1;
let activityCounter = 1;

// add new session
function newSession(button){
    sessionCount += 1;
    // create text boxes
    let start_date = document.createElement("input");
    $(start_date).attr("type", "text-box");
    $(start_date).timepicker();
    addAttributes(start_date, "start_date" + sessionCount, "form-control");

    let rooms = document.createElement("select");
    addAttributes(rooms, "roomselect" + sessionCount, "form-control roomselect");

    let capacity = document.createElement("input");
    $(capacity).attr("type", "text-box" );
    addAttributes(capacity, "capacity" + sessionCount, "form-control");

    // create button
    let btn = createButton();
    let mbtn = createMinusButton();

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
    addElementsToColumn(mbtn, col4);
    addElementsToColumn(btn, col4);

    // add columns to row
    addElementsToRow(col1, col2, col3, col4, row);
    addElementsToRow(col3, col4, row);
    // add row to the dom
    addElements(row, button);

    // remove plus button
    $(button).remove();
}





// adds attributes to the elements
function addAttributes(element, name, classes){
    $(element).attr("name", name);
    $(element).attr("class", classes);
}



// adds elements to the column passed
function addElementsToColumn(element, column){
    $(column).append(element);
}

// adds columns to the row
function addElementsToRow(col1, col2, col3, col4, row) {
    $(row).append(col1);
    $(row).append(col2);
}

// adds the elements to the container of button
function addElements(row, button) {
    let container = $(button).parent().parent().parent();
    // add rwo to container
    $(container).append(row);
}


// create a div with class col-lg
function createColumn(){
    let col = document.createElement("div");
    $(col).attr("class", "col-lg-3");
    return col;
}

// create a div with class row
function createRow(){
    let row = document.createElement("div");
    $(row).attr("class", "row top-indent");
    return row;
}

// create a button
function createButton(){
    let button = document.createElement("button");
    $(button).attr("class", "button-small glyphicon glyphicon-plus new-session left-indent");
    $(button).attr("title", "Add New Session");
    $(button).attr("type", "button");
    $(button).click(function () {
        newSession($(this));
    });
    return button;
}

// create minus button
function createMinusButton(){
    let mButton = document.createElement("button");
    $(mButton).attr("class", "button-small glyphicon glyphicon-minus");
    $(mButton).attr("title", "Remove Session");
    $(mButton).attr("type", "button");
    $(mButton).click(function(){
        removeSession($(this));
    });
    return mButton;
}


// remove session elements
function removeSession(button){
    addPreviousButton(button);
    $(button).parent().parent().remove();
}

// adds button the previous row
function addPreviousButton(button){
    let btn = createButton();
    $(button).parent().parent().prev().children().last().append(btn);
}

























// get the rooms for the location
function getRooms(location){
    removeRooms();
    Rails.ajax({
        url: `get_rooms/${location}`,
        type: 'GET',
        dataType: "json",
        success: function (data){
            for(index = 0; index < data.results.rooms.length; index++){
                $(".roomselect").append(createOption(data.results.rooms[index].room_number, data.results.rooms[index].room_name));
            }
        }
    })
}

// removes all rooms
function removeRooms(){
    $(".roomselect").children().remove();
}


// get all locations
function getLocations(){
    Rails.ajax({
        url: `get_locations`,
        type: 'GET',
        dataType: "json",
        success: function (data) {
            for(index = 0; index < data.results.locations.length; index++) {
                $("#locationselect").append(createOption(data.results.locations[index].location_name, data.results.locations[index].address ));
            }
        }
    })
}

// create an option element
function createOption(name1, name2){
    let option = document.createElement("option");
    $(option).text(name1 + " (" + name2 + ")");
    return option;
}





// create a new element
function createTag(type, classes, name){
    let tag = document.createElement("input");
    $(tag).attr("type", type);
    $(tag).attr("class", classes);
    $(tag).attr("name", name);
    return tag;
}


// add a new activity
function newActivity(){
    activityCounter += 1;
    // new row
    let parentRow = createRow();
    let activityContainer = createContainer("col-lg-5 border-right");

    // labels and text fields
    let lName = createTag("label", "control-label", "");
    let tName = createTag("text", "form-control", "name" + activityCounter);
    let nContainer = createContainer("form-group");
    appendElements(nContainer, lName, tName);

    let lDescription = createTag("label", "control-label", "");
    let tDescription = createTag("text", "form-control", "name" + activityCounter);
    let dContainer = createContainer("form-group");
    appendElements(dContainer, lDescription, tDescription);

    let lMakeAhead = createTag("label", "control-label", "ismakeahead" + activityCounter);
    let checkBox = createTag("checkbox", "");
    let mContainer = createContainer("form-group");
    appendElements(mContainer, lMakeAhead, checkBox);


    let lCompetition = createTag("label", "control-label", "iscompetition" + activityCounter);
    let cCheckBox = createTag("checkbox", "");
    let cContainer = createContainer("form-group");
    appendElements(cContainer, lCompetition, cCheckBox);

    let lLocation = createTag("label", "control-label", "Choose Location of Activity");
    let lSelect = createSelect("form-control locationselect", "location" + activityCounter);
    let sContainer = createContainer("form-group");
    appendElements(sContainer, lLocation, lSelect);

    addElementsToContainer(activityContainer, parentRow, nContainer);
    addElementsToRow(dContainer, mContainer, activityContainer);
    addElementsToRow(cContainer, sContainer, activityContainer);


    appendToForm(parentRow);
}

function createSelect(classes, name){
    let select = document.createElement("select");
    $(select).attr("class", classes);
    $(select).attr("name", name + activityCounter);
}

// add row to form
function appendToForm(row){
    $("hr").insertAfter($("#activity-form").children().last().prev());
    $(row).insertAfter($("#activity-form").children().last().prev());
}

function addElementsToContainer(mainContainer, container, row){
    $(mainContainer).append(container);
    $(row).append(mainContainer);
}


// add elements to container
function appendElements(container, label, element){
    $(container).append(label);
    $(container).append(element);

}


// create a new container
function createContainer(classes){
    let div = document.createElement("div");
    $(div).attr("class", classes);
    return div;
}


























