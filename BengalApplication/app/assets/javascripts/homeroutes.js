
$(document).on('ready page:load turbolinks:load', function() {
// assign all checkbox with function
    $("input[type='checkbox']").change(function () {
        const event_id = parseInt($(this).val());
        
        const checkbox = this;
        var parent = $(this).parent();
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
                    checkbox.remove();
                } else if (!data.data.registered) {
                    alert("false");
                }
            }
        })
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

});