

$(document).on('ready page:load turbolinks:load', function (){
    var element = document.getElementById("student-schedule");
   if (element.tagName !== undefined){
       print(this);
   }
});