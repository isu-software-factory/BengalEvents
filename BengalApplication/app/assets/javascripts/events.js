$(document).ready(function () {
    // turbolink ma hanley
    $(".location-select").on("change", function () {
        $('#selectTimeSlots').empty();
        $('#selectDate').empty();
        const value = $("option:selected", this).text();
        Rails.ajax({
            url: `/slots/${value}`,
            type: 'GET',
            dataType: 'json',
            success: (function (res) {
                $('#selectTimeSlots').empty();
                $('#selectDate').empty();
                console.log(res);
                $.each(res.results.dates, function (key, entry) {
                    $('#selectDate').append($('<option></option>').attr('value', entry).text(entry));
                });
                $.each(res.results.times, function (key, entry) {
                    $('#selectTimeSlots').append($('<option></option>').attr('value', entry).text(entry));
                    $('#selectEndTime').append($('<option></option>').attr('value', entry).text(entry));
                });
            })
        });
    });
});

