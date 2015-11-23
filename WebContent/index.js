var main = function(){
	$("#about").click(function(){
		window.location.href = "about.html";
	});

	$("#signup").click(function(){
		window.location.href = "CreateAccount.html";
	});

	// $.get('../src/HomePageServlet',{},function(responseJson) {   
 //        $.each(responseJson, function(key, value) {               
 //          	$('<li>').text(value).appendTo($("#popular_ul"));      
 //        });
 //    });
	
	/* Get Most Popular Quiz Data from Database */
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
        }
    }
    xhr.open('POST', 'IndexServlet', true);
    xhr.send(null);
};

$(document).ready(main);