function readURL(file) {
    var img = new Image();
    var reader = new FileReader();
    var fileName = $('#upload').val();
    var ext = fileName.split('.').pop();
    if($.inArray(ext, ['png','jpg','jpeg', 'PNG','JPG','JPEG']) == -1) {
      $('.image-error').empty();
      $('.image-error').append(
        "<div class='alert alert-danger'>Please upload an image (.png or .jpg)</div>"
        );
      $('.image-error').show("fast");
    } else if (file > 5242880 ) {
      $('.image-error').empty();
      $('.image-error').append(
        "<div class='alert alert-danger'>Cover image can't be larger than 5MB</div>"
        );
      $('.image-error').show("fast");
    } else {
      $('.image-error').hide("fast");
    if (file) {
        reader.onload = function (e) {

          img.onload = function () {
            $('#image').append('<img src="' + e.target.result + '"/>');
            $('.cover-image-container').css("height", img.height + "px");
          };
        }
        reader.readAsDataURL(file);
      $('.cover-image-container').css("border", "none");
      $('.cover-image-text').remove();
      $('.fa.fa-photo').remove();
    }
  }
}


$(document).ready(function() {
    $("#upload").change(function(){
      var file = this.files[0];
      readURL(file);
    });

  $('.cover-image-container').click(function(){
      $('#upload').click();
  })
});
 