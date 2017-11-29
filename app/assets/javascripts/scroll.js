$(document).ready(function() {
  $(window).scroll(function(){
      if ($(window).scrollTop() > 800 ) {
        $('.back-to-top-button').show("fast");
      } else {
        $('.back-to-top-button').hide("fast")
      }
    });
    $('.back-to-top-button').on('click', function(event){
      event.preventDefault();
        $('body,html').animate({
          scrollTop: 0
        }
      );
  });
});