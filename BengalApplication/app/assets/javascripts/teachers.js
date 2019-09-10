

$(document).on('ready page:load turbolinks:load', function (){
    var element = document.getElementById("class-schedule");
    if (element.tagName !== undefined){
        print(this);
    }
});