//= require jquery
//= require jquery.minicolors

$(document).on('ready page:load turbolinks:load', function () {
    // change colors
    $("#primary_color").minicolors();
    $("#secondary_color").minicolors();
    $("#additional_color").minicolors();
    $("#primary_color").change(function () {
        $(".primary-color").css("background-color", this.value);
    });
    $("#secondary_color").change(function () {
        $(".secondary-color").css("background-color", this.value);
    });
    $("#additional_color").change(function () {
        $("a, h1").css("color", this.value);
    });
    // fonts
    $("#font").children().each(function(){
        $(this).css("font-family", $(this).text());
    });

    // change logo
    $("#logo").change(function(){
        let reader = new FileReader();
        reader.onload = function(e){
            $("#logo-image").attr('src', e.target.result);
        };
        reader.readAsDataURL(this.files[0]);

    })



});
