

$(document).ready(function(){

        // get all collapse elements
        var elements = $(".collapse");

        elements.each(function(){
            this.onclick(function(){
                var event_details = this.nextElementSibling;
                if (event_details.style.display === "block"){
                    event_details.style.display = "none";
                }else{
                    event_details.style.display = "block";
                }
            })
        })

});