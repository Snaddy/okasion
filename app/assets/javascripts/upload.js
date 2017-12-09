function readURL(input) {
    var fileName = $('#upload').val();
    var ext = fileName.split('.').pop();
    if($.inArray(ext, ['png','jpg','jpeg']) == -1) {
      $('.image-error').empty();
      $('.image-error').append(
        "<div class='alert alert-danger'>Please upload an image (.png or .jpg)</div>"
        );
      $('.image-error').show("fast");
    } else if (input.files[0].size > 5242880 ) {
      $('.image-error').empty();
      $('.image-error').append(
        "<div class='alert alert-danger'>Cover image can't be larger than 5MB</div>"
        );
      $('.image-error').show("fast");
    } else {
      $('.image-error').hide("fast");
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#image').html("<img src=\"" + e.target.result + "\">");  
          var css;
          var img_ratio = $("#image img").width() / $("#image img").height();
          var container_ratio = $(".cover-image-container").width() / $(".cover-image-container").height();
          if (img_ratio < container_ratio) { 
            css = { width:'auto', height:'100%' };
          }
          else {
            css = { width:'100%', height:'auto' };
          }
          $("#image img").css(css);
        }
        reader.readAsDataURL(input.files[0]);
    $('.cover-image-container').css("border", "none");
    $('.cover-image-text').remove();
    $('.fa.fa-photo').remove();
    }
  }
}
var preview = function(){
  $("#upload").change(function(){
    readURL(this);
  })
  
  $(document).ready(function() {
    $('.cover-image-container').click(function(){
        $('#upload').click();
    })
  })
};

$(document).ready(preview);
$(document).on('page:load', preview);
 