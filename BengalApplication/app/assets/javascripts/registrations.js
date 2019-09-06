

$(document).on('ready page:load turbolinks:load', function(){


    // get all collapse elements
    $(".event-collapse").click(function(event){
        var target = event.currentTarget;
        var children = target.nextSibling.nextSibling.childNodes;
        var collpaseEvent = children[1].childNodes;
        var collpaseEventElement = collpaseEvent[1];

        if (collpaseEventElement.className == "show"){
            collpaseEventElement.className = "hide";
        }
        else{
            collpaseEventElement.className = "show";
        }

    });



});