$(document).ready(function(){
    
  $("#submit_button").click(function(){
    event.preventDefault();

    var number = $('#user_input_telephone').val()

    if (number == "") {
        alert("Please enter you telephone number");
        return false;
    }
    // data validation

    var validation = /^\+?([0-9]{2})\)?([0-9]{10})/;
    
    if (number.match(validation))
    {
        // number is valid
    }
        else
    {
        alert("Your number must include +380. Example: +3801234567890");
        return false;
    }

    var artist = $('#user_input_artist').val()

    if (artist == "") {
        alert("Please enter name of your favourite artist. Example: Justin Bieber");
        return false;
    }

    $.ajax({
        type: "post",
        dataType: 'script',
        url: '/send_sms?number=' + encodeURIComponent(number) + '&artist=' + artist,
        success: function(data) {
            alert("Well done! Wait for a sms!");
        },
        error: function(requestObject){
            if (requestObject.status == 404) {
              alert("Please enter an existing artist!");
            } else {
              alert("Please enter a valid data!");
            }
        }
      });
  });
});