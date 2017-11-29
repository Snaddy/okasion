$(document).ready(function() {
 if ($('.pagination').length) {
    $('.pagination').hide();
    $('#load-more-posts').show().click(function() {
      var url = $('.pagination .next_page').attr('href');
      return $.getScript(url);
    });
  }
});
