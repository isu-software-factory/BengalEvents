//=require coordinators.js

// printing page
$(document).on('ready page:load turbolinks:load', function () {

    // new student page
    // assign function to all minus buttons
    if ($("#student-form").length) {
        $("button").click(function () {
            if ($("#student-form").find("button").last().prev()[0] === $(this)[0])
                $(this).parent().parent().parent().prev().children().last().children().last().append(createButton("plus"));

            $(this).parent().parent().parent().remove();
        });
    }

    // student number
    if ($("#student-form").length)
        studentCount = parseInt($("#next_user").val());


    // reset student password
    $(".reset-password").click(function(e){
        let userId = $(this).attr("user");

        e.preventDefault();
        // reset password
        Rails.ajax({
            url: `/homeroutes/reset_password/${userId}`,
            type: 'POST',
            data: "",
            success: function(result){
                if (result.data.success)
                    $(".content p").first().append("Successfully Reset Password. New password has been sent to you by email.")
            }
        })

    });

    // if coordinator page
    if ($("#coordinator_page").length)
        accordion_collapse();

});



// print the page
function print_this(){
    $(".navigation").remove();
    $(".menu").remove();
    print(this)
}

// new students page
function addNewStudent() {
    studentCount = parseInt(studentCount) + 1;
    // remove the previous add button
    removePreviousButton();

    // text field
    var firstName = document.createElement('input');
    setAttributes(firstName, "First", studentCount);

    var lastName = document.createElement("input");
    setAttributes(lastName, "Last", studentCount);

    var emailField = document.createElement("input");
    setAttributes(emailField, "Email", studentCount);

    // icon
    var nIcon = createSpan("user");
    var nIcon2 = createSpan("user");

    var eIcon = createSpan("envelope");

    // buttons
    var minusButton = createButton("minus");
    var addButton = createButton("plus");

    // set row
    var row = newRow();

    // set elements
    setToDiv(firstName, nIcon2, row);
    setToDiv(lastName, nIcon, row);
    setToDiv(emailField, eIcon, row);
    setButtonsToDiv(minusButton, addButton, row);


}

// set attributes to the text fields
function setAttributes(element, names, count) {
    element.setAttribute("type", "text");
    if (names === "Email") {
        element.setAttribute("placeholder", "Student " + names + " or Username");
    } else {
        element.setAttribute("placeholder", names + " Name");
    }
    element.setAttribute("id", names.toLowerCase());
    element.setAttribute("name", names.toLowerCase() + "_" + count);
}


function removePreviousButton() {
    $("#student-form").find("button").last().remove();
}

function createButton(type) {
    var button = document.createElement("button");
    button.setAttribute("type", "button");

    if (type === "minus") {
        // set attributes
        button.setAttribute("title", "Remove This Student");
        button.setAttribute("class", "button-small glyphicon glyphicon-minus");
        // remove fields and add plus button before this element
        $(button).click(function () {
            if (($("#student-form").find("button").last().prev()[0] === $(this)[0]))
                $(this).parent().parent().parent().prev().children().last().children().last().append(createButton("plus"));
            $(this).parent().parent().parent().remove();
        });
    } else {
        // set attributes
        button.setAttribute("title", "Add New Student");
        button.setAttribute("onClick", "addNewStudent()");
        button.setAttribute("class", "button-small left-indent glyphicon glyphicon-plus");
    }

    return button;
}


// create a span element with icon
function createSpan(type) {
    var span = document.createElement("span");
    span.setAttribute("class", "input-group-addon");

    var icon = document.createElement("i");
    icon.setAttribute("class", "glyphicon glyphicon-" + type);

    span.appendChild(icon);
    return span;
}

// set the elements to a div
function setToDiv(element, icon, row) {
    var div = newDivInputGroup(row);

    div.appendChild(icon);
    div.appendChild(element);
}

function setButtonsToDiv(minusButton, addButton, row) {
    var div = newDivInputGroup(row);

    div.appendChild(minusButton);
    div.appendChild(addButton);
}

// create a new div with class row
function newRow() {
    // new div with class row
    var row = document.createElement('div');
    row.setAttribute("class", "row");

    return setRow(row);
}

// insert row in DOM
    function setRow(element) {
        $(element).insertAfter($("#student-form").children().last().prev());
        return element;
    }

// creates div input group class for css
    function newDivInputGroup(row) {
        var div = document.createElement('div');
        div.setAttribute("class", "input-group bottom-indent");


        var col = document.createElement('div');
        col.setAttribute("class", "col-lg-3");

        // append child's
        col.appendChild(div);
        row.appendChild(col);
        return div;
    }



