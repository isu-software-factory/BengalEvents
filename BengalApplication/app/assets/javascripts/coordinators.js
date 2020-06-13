
function accordion_collapse() {

    $(".accordion").hide();
    $(".accordion").parent().parent().prev().click(function () {
        const accordion = $(this).next().children().first().children().first();
        down_icon = "glyphicon glyphicon-menu-down";
        up_icon = "glyphicon glyphicon-menu-up";
        if (accordion.hasClass("Down")) {
            accordion.slideUp();
            accordion.removeClass("Down");
            $(this).children().last().children().first().removeClass(up_icon).addClass(down_icon);
        } else {
            accordion.slideDown();
            accordion.addClass("Down");
            $(this).children().last().children().first().removeClass(down_icon).addClass(up_icon);
        }
    });
}