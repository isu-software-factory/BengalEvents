//= require jquery
//= require jquery.minicolors

$(document).on('ready page:load turbolinks:load', function () {
    // change colors
    $("#primary-color").minicolors();
    $("#secondary-color").minicolors();
    $("#primary-color").change(function () {
        $(".header").css("background-color", this.value);
    });
    $("#secondary-color").change(function () {
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
