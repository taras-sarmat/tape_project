$(document).ready(function(){
    
  $("#submit_button").click(function(){
    event.preventDefault();

    number = $('#user_telephone').val()

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

    artist = $('#artist_name').val()

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
        }
      });
  });
});