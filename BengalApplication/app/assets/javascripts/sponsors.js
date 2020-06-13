$(document).ready(function () {
    var pdf = document.getElementById("printEventPdf");
    if (pdf.tagName != undefined) {
        print(this);
    }
});