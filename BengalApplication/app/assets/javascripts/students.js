

$(document).on('ready page:load turbolinks:load', function (){
    var element = document.getElementById("student-schedule");
   if (element != null){
       print(this);
   }
});

function addNewStudent(){
    var nameField = document.createElement('input');
}