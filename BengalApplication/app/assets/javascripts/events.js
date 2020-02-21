
$(document).on('ready page:load turbolinks:load', function() {
// assign all checkbox with function
    $("input[type='checkbox']").change(function () {
        register_check_box(this);
    });

    $(".accordion").hide();

    $(".accordion").parent().parent().prev().click(function(){
        const accordion = $(this).next().children().first().children().first();
        down_icon = "glyphicon glyphicon-menu-down";
        up_icon = "glyphicon glyphicon-menu-up";
        if (accordion.hasClass("Down")){
            accordion.slideUp();
            accordion.removeClass("Down");
            $(this).children().last().children().first().removeClass(up_icon).addClass(down_icon);
        }else {
            accordion.slideDown();
            accordion.addClass("Down");
            $(this).children().last().children().first().removeClass(down_icon).addClass(up_icon);
        }
    });

    $(".remove-button").click(function(){
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
                    button.click(function(){remove_activity(this)});
                    parent.next().append(button);
                } else if (!data.data.registered) {
                    alert("false");
                }
            }
        })
    }

    function remove_activity (button){
        const user_id = $(button).attr("user_id");
        const event_id = $(button).attr("session_id");
        const role = $(button).attr("role");
        Rails.ajax({
            url: `/drop_activity/${role}/${event_id}/${user_id}`,
            type: 'GET',
            dataType: "json",
            success: function(data){
                parent = $(button).parent();
                parent.prev().text("");
                check_box = $("<input type='checkbox' name='register'>");
                check_box.attr("value", event_id);
                check_box.attr("role", role);
                check_box.attr("user_id", user_id);
                check_box.attr("title", "Register for activity");
                check_box.click(function(){register_check_box(this);});
                parent.prev().append(check_box);
                $(button).remove();
            }
        })
    }

    // location number
    locationCount = 1;
    roomCount = 1;

    // creating a new event
    // $("button").click(function(){
    //     // add plus button
    //
    //         $(this).parent().parent().parent().prev().children().last().children().last().append(createButton("plus"));
    //
    //     // remove row
    //     $(this).parent().parent().parent().remove();
    // })


});

function addNewLocation(){
    locationCount = parseInt(locationCount) + 1;

    // Text fields
    var locationName = document.createElement("input");
    setAttributes(locationName, "Location Name", locationCount, 1);

    var locationAddress = document.createElement("input");
    setAttributes(locationAddress, "Address (optional)", locationCount, 2);

    // buttons
    var minusButton = createButton("minus", "Location");
    var addButton = createButton("plus", "Location");

    // set row
    var row = newRow("Location");

    // set elements
    setToDiv(locationName, row);
    setToDiv(locationAddress, row);
    setButtonsToDiv(minusButton, addButton, row);
}

function addNewRoom(){
    roomCount = parseInt(roomCount) + 1;

    // Text fields
    var roomNumber = document.createElement("input");
    setAttributes(roomNumber, "Room Number", roomCount, 1);

    var roomName = document.createElement("input");
    setAttributes(roomName, "Room Name (optional)", roomCount, 2);

    // buttons
    var minusButton = createButton("minus", "Room");
    var addButton = createButton("plus", "Room");

    // set row
    var row = newRow("Room");

    // set elements
    setToDiv(roomNumber, row);
    setToDiv(roomName, row);
    setButtonsToDiv(minusButton, addButton, row);
}


function setToDiv(element, row){
    var div = newDivGroup(row);
    div.appendChild(element);
}

function newDivGroup(row){
    var div = document.createElement("div");
    div.setAttribute("class", "col-lg-4");

    // append child to row
    row.appendChild(div);
    return div;
}

function setButtonsToDiv(mButton, aButton, row){
    var div = newDivGroup(row);
    div.appendChild(mButton);
    div.appendChild(aButton);
}

// create a new div with class row
function newRow(page) {
    // new div with class row
    var row = document.createElement('div');
    row.setAttribute("class", "row");

    if (page === "Location") {
        // new container for row
        var pageLocation = document.createElement("div");
        pageLocation.setAttribute("class", "Location");
        return setRow(pageLocation, row, "Room");
    }
    else {
        return setRow($(".Room").last(), row, "Location");
    }
}

function setRoomRow(element){

}

// set row in location or room div
function setRow(container, element, location){
    // insert container
    $(container).insertAfter($("." + location).last());

    // create hr element
    var hr = document.createElement("hr");
    $(hr).insertAfter("." + location).last();

    container.appendChild(element);
    alert("It worked");
    return element;
}


// set attributes to the text fields
function setAttributes(element, names, count, order){
    element.setAttribute("type", "text");
    element.setAttribute("placeholder", names);
    element.setAttribute("id", names.toLowerCase());
    element.setAttribute("name", names.toLowerCase() + "_" + count);
    if (order == 1)
        element.setAttribute("class", "form-control left-indent-more");
    else
        element.setAttribute("class", "form-control");
}


function createButton(type, location){
    var button = document.createElement("button");
    button.setAttribute("type", "button");

    if (type === "minus"){
        // set attributes
        button.setAttribute("title", "Remove This " + location);
        button.setAttribute("class", "button-small glyphicon glyphicon-minus");
        // remove fields and add plus button before this element
        $(button).click(function() {
            if (($("#student-form").find("button").last().prev()[0] === $(this)[0]))
                $(this).parent().parent().parent().prev().children().last().children().last().append(createButton("plus"));
            $(this).parent().parent().parent().remove();
        });
    }else{
        // set attributes
        if (location === "Location")
            button.setAttribute("onClick", "addNewLocation()");
        else
            button.setAttribute("onClick", "addNewRoom()");
        button.setAttribute("class", "button-small left-indent glyphicon glyphicon-plus");
        button.setAttribute("title", "Add New " + location);
    }

    return button;
}

