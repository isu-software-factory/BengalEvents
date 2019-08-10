$(document).on('ready page:load turbolinks:load', function () {
    // turbolink ma hanley
    // $(".location-select").on("change", function () {
    // $('#selectTimeSlots').empty();
    // $('#selectDate').empty();
    //     const value = $("option:selected", this).text();
    const value = $("#location_name").val();
    Rails.ajax({
        url: `/slots/${value}`,
        type: 'GET',
        dataType: 'json',
        success: (function (res) {
            $('#selectStartTime').empty();
            $('#selectEndTime').empty();
            $('#selectDate').empty();
            console.log(res);
            $.each(res.results.dates, function (key, entry) {
                $('#selectDate').append($('<option></option>').attr('value', entry).text(entry));
            });
            $.each(res.results.times, function (key, entry) {
                $('#selectStartTime').append($('<option></option>').attr('value', entry).text(entry));
                $('#selectEndTime').append($('<option></option>').attr('value', entry).text(entry));
            });
        })
    });
});
//     });
// });

