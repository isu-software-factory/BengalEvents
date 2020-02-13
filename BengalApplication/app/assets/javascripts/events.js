
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

        const checkboxs = checkBox;
        var parent = $(checkBox).parent();
        // use ajax to send back info
        Rails.ajax({
            url: `/register/${event_id}`,
            type: 'GET',
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data.data.registered) {
                    parent.addClass("registered");
                    parent.text("Registered");
                    checkboxs.remove();
                    button = $("<button class='button-small glyphicon glyphicon-remove left-indent remove-button'></button>");
                    button.attr("user_id", data.data.user);
                    button.attr("session_id", event_id);
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
        Rails.ajax({
            url: `/drop_activity/${event_id}/${user_id}`,
            type: 'GET',
            dataType: "json",
            success: function(data){
                parent = $(button).parent();
                parent.prev().text("");
                check_box = $("<input type='checkbox' name='register'>");
                check_box.attr("value", event_id);
                check_box.attr("title", "Register for activity");
                check_box.click(function(){register_check_box(this);});
                parent.prev().append(check_box);
                $(button).remove();
            }
        })
    }

});