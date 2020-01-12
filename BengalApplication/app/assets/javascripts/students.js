

$(document).on('ready page:load turbolinks:load', function (){
    var element = document.getElementById("student-schedule");
   if (element != null){
       print(this);
   }
});

function addNewStudent(){
    // text field
    var nameField = document.createElement('input');
    nameField.setAttribute("type", "text");
    nameField.setAttribute("placeholder", "Name");

    var emailField = document.createElement("input");
    emailField.setAttribute("type", "text");
    emailField.setAttribute("placeholder", "Student Email");

    // icon
    var nIcon = createSpan("user");

    var eIcon = createSpan("envelope");

    // set row
    var row = newRow();

    // set elements
    setToDiv(nameField, nIcon, row);
    setToDiv(emailField, eIcon, row);


}

function createSpan(type){
    var span = document.createElement("span");
    span.setAttribute("class", "input-group-addon");

    var icon = document.createElement("i");
    icon.setAttribute("class", "glyphicon glyphicon-"+type);

    span.appendChild(icon);
    return span;
}

function setToDiv(element, icon, row){
    var div = newDivInputGroup(row);

    div.appendChild(icon);
    div.appendChild(element);
}

function newRow(){
    // new div with class row
    var row = document.createElement('div');
    row.setAttribute("class", "row");

    return setRow(row);

}

function setRow(element){
    var container = document.getElementById("student-form");
    return container.insertBefore(element, container.lastChild);
}


function newDivInputGroup(row){
    var div = document.createElement('div');
    div.setAttribute("class", "input-group");

    var col = document.createElement('div');
    col.setAttribute("class", "col-lg-4");

    // append child's
    col.appendChild(div);

    return div;
}


function removeStudent(){

}