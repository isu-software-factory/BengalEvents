// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require bootstrap-sprockets
//= require rails-ujs
//= require jquery-ui
//= require activestorage
//= require turbolinks
//= require jquery-ui/widgets/datepicker
//= require jquery.timepicker.js


$('document').ready(function () {
    // setTimeout(function () {
    //     $('.alert-success').slideUp();
    // }, 3000);
    // $(function(){
    //     $('[data-toggle="tooltip"]').tooltip();
    // })


    // setSettings();
});


function setSettings(){
    Rails.ajax({
        url: `/load_settings`,
        type: 'GET',
        dataType: 'json',
        success: (function (res) {
            $(".primary").css("background-color", res.settings.primary);
        })
    });
}


function stickyHeader() {
    var header = document.getElementById("header");
    var sticky = header.offsetTop;
    if (window.pageYOffset > sticky) {
        header.classList.add("sticky");
    } else {
        header.classList.remove("sticky");
    }
}

function remove_fields(link) {
    $(link).previous("input[type=hidden]").value = "1";
    $(link).up("fields").hide();
}

