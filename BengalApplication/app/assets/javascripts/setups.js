//= require jquery
//= require jquery.minicolors

$(document).on('ready page:load turbolinks:load', function () {
    // change colors
    $("#primary-colors").minicolors();
    $("#secondary-colors").minicolors();
    $("#primary-colors").change(function () {
        $(".header").css("background-color", this.value);
    });
    $("#secondary-colors").change(function () {
        $(".navigation").css("background-color", this.value);
    });

    $("#logo").change(function(){
        let reader = new FileReader();
        reader.onload = function(e){
            $("#logo-image").attr('src', e.target.result);
        };
        reader.readAsDataURL(this.files[0]);

    })
});
