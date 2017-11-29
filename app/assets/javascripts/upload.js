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
        }
        reader.readAsDataURL(input.files[0]);
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
 