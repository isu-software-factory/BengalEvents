$(document).ready(function () {
    $("select").on("change", function () {
        const value = $("option:selected", this).text();
        Rails.ajax({
            url: `/slots/${value}`,
            type: 'GET',
            dataType: 'json',
            success: (function (res) {
                $('#selectTimeSlots').empty();
                $.each(res, function (key, entry) {
                    console.log(entry);
                    $('#selectTimeSlots').append($('<option></option>').attr('value', entry).text(entry));
                    $('#selectEndTime').append($('<option></option>').attr('value', entry.end_time).text(entry.end_time));
                });
            })
        });
    });
});

