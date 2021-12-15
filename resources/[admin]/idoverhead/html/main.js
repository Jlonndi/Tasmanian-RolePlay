$('document').ready(function() {
    $(".container").hide();

    window.addEventListener("message", function (event) {
        
        if (event.data.action !== undefined) {
            event.x = (event.data.x * 100) + '%';
            event.y = (event.data.y * 100) + '%';

            if (event.data.action == 'display') {
                $('.container').fadeIn('fast', function() {
                    

            $('.text').html(event.data.text);
            $('.text').css({ "left": event.x, "top": event.y });
                })
            } else {
                $('.container').fadeOut('fast', function() {
                    $('.text').html('');
                });
            }
        }
    })
});