var main = function(){
	$("#create_announcement_form").hide();
	$(".test").hide();
	$("#create_announcement_tag").click(function(){
		$("create_announcement_form").toggle();
	});
}

$(document).ready(main);