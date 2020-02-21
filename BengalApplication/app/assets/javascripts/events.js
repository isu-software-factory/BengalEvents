
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



    // creating a new event
    $("button").click(function(){
        // add plus button

            $(this).parent().parent().parent().prev().children().last().children().last().append(createButton("plus"));

        // remove row
        $(this).parent().parent().parent().remove();
    })


});

function createNewLoaction(){

}

function createNewRoom(){

}

function createButton(type){
    var button = document.createElement("button");
    button.setAttribute("type", "button");

    if (type === "minus"){
        // set attributes
        button.setAttribute("title", "Remove This Location");
        button.setAttribute("class", "button-small glyphicon glyphicon-minus");
        // remove fields and add plus button before this element
        $(button).click(function() {
            if (($("#student-form").find("button").last().prev()[0] === $(this)[0]))
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

