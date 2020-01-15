
// printing page
$(document).on('ready page:load turbolinks:load', function (){
    var element = document.getElementById("student-schedule");
   if (element != null){
       print(this);
   }

    // new student page
    // assign function to all minus buttons
    $("button").click(function() {
        $(this).parent().parent().parent().prev().children().last().children().last().append(createButton("plus"));
        $(this).parent().parent().parent().remove();
    });

    // student number
    studentCount = $("#student-form").children().last().prev().children().last().prev().find("input").attr("id").split('_').pop();
});






// new students page
function addNewStudent(){
    studentCount = parseInt(studentCount) + 1;
    // remove the previous add button
    removePreviousButton();

    // text field
    var nameField = document.createElement('input');
    setAttributes(nameField, "Name", studentCount);

    var emailField = document.createElement("input");
    setAttributes(emailField, "Email", studentCount);

    // icon
    var nIcon = createSpan("user");

    var eIcon = createSpan("envelope");

    // buttons
    var minusButton = createButton("minus");
    var addButton = createButton("plus");

    // set row
    var row = newRow();

    // set elements
    setToDiv(nameField, nIcon, row);
    setToDiv(emailField, eIcon, row);
    setButtonsToDiv(minusButton, addButton, row);


}

// set attributes to the text fields
function setAttributes(element, names, count){
    element.setAttribute("type", "text");
    element.setAttribute("placeholder", "Student " + names);
    element.setAttribute("id", names.toLowerCase());
    element.setAttribute("name", names.toLowerCase() + "_" + count);
}


function removePreviousButton(){
    $("#student-form").find("button").last().remove();
}

function createButton(type){
    var button = document.createElement("button");
    button.setAttribute("type", "button");

    if (type === "minus"){
        // set attributes
        button.setAttribute("title", "Remove This Student");
        button.setAttribute("class", "button-small glyphicon glyphicon-minus");
        // remove fields and add plus button before this element
        $(button).click(function() {
            $(this).parent().parent().parent().prev().children().last().children().last().append(createButton("plus"));
            $(this).parent().parent().parent().remove();
        });
    }else{
        // set attributes
        button.setAttribute("title", "Add New Student");
        button.setAttribute("onClick", "addNewStudent()");
        button.setAttribute("class", "button-small left-indent glyphicon glyphicon-plus");
    }

    return button;
}

function setIconToButton(icon){
    var iElement = document.createElement("i");
    iElement.setAttribute("class", "glyphicon glyphicon-"+icon);
    return iElement;
}


// create a span element with icon
function createSpan(type){
    var span = document.createElement("span");
    span.setAttribute("class", "input-group-addon");

    var icon = document.createElement("i");
    icon.setAttribute("class", "glyphicon glyphicon-"+type);

    span.appendChild(icon);
    return span;
}

// set the elements to a div
function setToDiv(element, icon, row){
    var div = newDivInputGroup(row);

    div.appendChild(icon);
    div.appendChild(element);
}

function setButtonsToDiv(minusButton, addButton, row){
    var div = newDivInputGroup(row);

    div.appendChild(minusButton);
    div.appendChild(addButton);
}

// create a new div with class row
function newRow(){
    // new div with class row
    var row = document.createElement('div');
    row.setAttribute("class", "row");

    return setRow(row);

}

// insert row in DOM
function setRow(element){
    var container = document.getElementById("student-form");
    return container.insertBefore(element, container.childNodes.item(container.childElementCount - 1).nextSibling);
}

// creates div input group class for css
function newDivInputGroup(row){
    var div = document.createElement('div');
    div.setAttribute("class", "input-group bottom-indent");


    var col = document.createElement('div');
    col.setAttribute("class", "col-lg-4");

    // append child's
    col.appendChild(div);
    row.appendChild(col);
    return div;
}
