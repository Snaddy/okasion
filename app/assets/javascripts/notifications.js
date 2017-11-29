$(document).ready(function(){
	setTimeout(function(){
		$('.messages').slideUp("fast", function(){
			$(this).remove();
		});
	}, 2500);
});