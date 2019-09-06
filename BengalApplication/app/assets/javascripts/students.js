

$(document).ready(function(){
    var element = document.getElementsByClassName("student-schedule");
    alert(element.tagName);
   if (!(element.tagName === 'undefined')){
       alert(element.tagName);
       print(this);
   }
});