/**
 * 
 */
window.onload = function(){ 
	$("popup-parent").mouseover(function() {
	    $("#popup-child").show();
	}).mouseout(function() {
	    $("#popup-child").hide();
	});
};
