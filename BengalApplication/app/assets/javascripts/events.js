$(document).on('ready page:load turbolinks:load', function () {
  // assign datepicker
    $("#start_date").datepicker({
        dateFormat: "yy-mm-dd"
    });

    // assign all checkbox with function
    $("input[type='checkbox']").change(function () {
        register_check_box(this);
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

    $(".remove-button").click(function () {
        remove_activity(this);
    });


    function register_check_box(checkBox) {
        const event_id = parseInt($(checkBox).val());
        const user_id = $(checkBox).attr("user_id");
        const role = $(checkBox).attr("role");
        const checkboxs = checkBox;
        var parent = $(checkBox).parent();
        // use ajax to send back info
        Rails.ajax({
            url: `/register/${role}/${event_id}/${user_id}`,
            type: 'GET',
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data.data.registered) {
                    parent.addClass("registered");
                    parent.text("Registered");
                    checkboxs.remove();
                    button = $("<button class='button-small glyphicon glyphicon-remove left-indent remove-button'></button>");
                    button.attr("user_id", user_id);
                    button.attr("session_id", event_id);
                    button.attr("role", role);
                    button.click(function () {
                        remove_activity(this)
                    });
                    parent.next().append(button);
                } else if (!data.data.registered) {
                    $(".content p").last().append(data.data.error);
                }
            }
        })
    }

    // drop an activity in user
    function remove_activity(button) {
        const user_id = $(button).attr("user_id");
        const event_id = $(button).attr("session_id");
        const role = $(button).attr("role");
        Rails.ajax({
            url: `/drop_activity/${role}/${event_id}/${user_id}`,
            type: 'GET',
            dataType: "json",
            success: function (data) {
                parent = $(button).parent();
                parent.prev().text("");
                let check_box = $("<input type='checkbox' name='register'>");
                check_box.attr("value", event_id);
                check_box.attr("role", role);
                check_box.attr("user_id", user_id);
                check_box.attr("title", "Register for activity");
                check_box.click(function () {
                    register_check_box(this);
                });
                $(".container p").first().append(data.data.message);
                parent.prev().append(check_box);
                $(button).remove();
            }
        })
    }

    // location number
    locationCount = 1;
    roomCount = 1;

    $("button").each(function () {
        // check to see that the div is a room
        if ($(this).parent().parent().parent().attr("class") == "Room") {
            // add function to button
            $(this).click(function () {
                addNewRoom($(this).parent().parent().parent(), $(this));
            })
        } else if($(this).parent().parent().parent().attr("class") == "Location") {
            // add function to button
            $(this).click(function () {
                addNewLocation($(this));
            })
        }
    })
});

function addNewLocation(button) {
    locationCount = parseInt(locationCount) + 1;

    // remove the previous add button
    removePreviousButton(button);

    // Text fields
    var locationName = document.createElement("input");
    setAttributes(locationName, "Location Name", "Location Name", "", locationCount, "left-indent-more");

    var locationAddress = document.createElement("input");
    setAttributes(locationAddress, "Address (optional)", "Address", "", locationCount, "");

    // buttons
    var minusButton = createButton("minus", "Location");
    var addButton = createButton("plus", "Location");

    // set new container for elements
    var row = newRow();
    var container = newContainer();


    setRow(container, row, true, true);
    // set elements
    setToDiv(locationName, row);
    setToDiv(locationAddress, row);
    setButtonsToDiv(minusButton, addButton, row, "Location");

    // add room below
    // new room container
    var row2 = newRow();
    var room = newRoomContainer();
    setRow(room, row2, true, true);
    addNewRoom($(room), null, "_New_");
}

function addNewRoom(room, button, eClass) {
    if (button != null)
        removePreviousButton(button);

    roomCount = parseInt(roomCount) + 1;
    room = room[0];

    if (eClass == null) eClass = "";
    // Text fields
    var roomNumber = document.createElement("input");
    setAttributes(roomNumber, "Room #", "Room Number", eClass, roomCount, "");

    var roomName = document.createElement("input");
    setAttributes(roomName, "Room Name (optional)", "Room Name", eClass, roomCount, "");

    // buttons
    var minusButton = createButton("minus", "Room");
    var addButton = createButton("plus", "Room");

    // new row within room div
    row = newRow();
    setRow(room, row, false, false);


    // set elements
    setToDiv(roomNumber, row, "Room", "left-indent-more");
    setToDiv(roomName, row, "Room");
    setButtonsToDiv(minusButton, addButton, row, "Room");
}


function setToDiv(element, row, type, eClass) {

    var div = newDivGroup(row, type, eClass);
    div.appendChild(element);
}

function newDivGroup(row, type, eClass) {
    var div = document.createElement("div");
    if (type == "Room") {
        div.setAttribute("class", "col-lg-3 sub-section " + eClass);
    } else {
        div.setAttribute("class", "col-lg-4");
    }
    // append child to row
    row.appendChild(div);
    return div;
}

function setButtonsToDiv(mButton, aButton, row, type) {
    var div = newDivGroup(row, type);
    div.appendChild(mButton);
    div.appendChild(aButton);
}

// create a new div with class row
function newRow() {
    // new div with class row
    var row = document.createElement('div');
    row.setAttribute("class", "row");

    return row;
}

// creates a location container
function newContainer() {
    // new container for row
    var pageLocation = document.createElement("div");
    pageLocation.setAttribute("class", "Location");
    return pageLocation;
}

// creates a new room container
function newRoomContainer() {
    // new container for room
    var room = document.createElement("div");
    room.setAttribute("class", "Room");
    return room;
}

// set row in location or room div
function setRow(container, element, setHr, insertContainer) {

    if (setHr) {
        // create hr element
        var hr = document.createElement("hr");
        $(hr).insertAfter($("#event-form").children().last().prev());
    }
    if (insertContainer)
    // insert container
        $(container).insertAfter($("#event-form").children().last().prev());

    container.appendChild(element);
    return element;
}


// set attributes to the text fields
function setAttributes(element, placeholder, names, eName, count, eClass) {
    element.setAttribute("type", "text");
    element.setAttribute("placeholder", placeholder);
    element.setAttribute("name", names.toLowerCase() + "_" + eName + count);
    element.setAttribute("class", "form-control " + eClass);
}


function createButton(type, location) {
    var button = document.createElement("button");
    button.setAttribute("type", "button");

    if (type === "minus") {
        // set attributes
        button.setAttribute("title", "Remove This " + location);
        button.setAttribute("class", "button-small glyphicon glyphicon-minus");
        // remove fields and add plus button before this element
        $(button).click(function () {
            // add plus button back to the previous row
            if ($(this).parent().parent().parent().find("button").last().prev().is($(this))){
                if ($(this).parent().parent().parent().attr("class") == "Room")
                    $(this).parent().parent().prev().children().last().append(createButton("plus", location));
                else

                    $(".Location").last().prev().prev().prev().prev().children().last().children().last().append(createButton("plus", location));
            }

            if (location == "Location") {
                // remove location and rooms
                $(this).parent().parent().parent().prev().remove(); // previous hr
                $(this).parent().parent().parent().next().remove(); // next hr
                $(this).parent().parent().parent().next().remove();  // Room
                $(this).parent().parent().parent().remove(); // Location
            }
            else {
                $(this).parent().parent().remove();
            }

        });
    } else {
        // set attributes
        if (location === "Location")
            $(button).click(function () {
                addNewLocation($(this));
            });
        else
            $(button).click(function () {
                addNewRoom($(this).parent().parent().parent(), $(this));
            });
        button.setAttribute("class", "button-small left-indent glyphicon glyphicon-plus");
        button.setAttribute("title", "Add New " + location);
    }

    return button;
}

function removePreviousButton(button) {
    button.remove();
}
