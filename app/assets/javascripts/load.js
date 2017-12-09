$("img").load(function(){
	var height = $("#image img").height();
	$('body').append("<div>" + height + "</div>");
});