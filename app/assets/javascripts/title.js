$(document).ready(function(){
	$('.title').each(function(){
		var height = $(this).height();
		$(this).css("bottom", height + "px");
	});
});