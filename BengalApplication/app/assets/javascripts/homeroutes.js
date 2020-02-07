
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


});