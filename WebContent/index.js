var main = function(){
	$("#login_form").hide();

	$("#about").click(function(){
		window.location.href = "about.html";
	});

	$("#login").click(function(){
		$("#login_form").toggle();
	});

	$("#signup").click(function(){
		window.location.href = "CreateAccount.html";
	});

	// $.get('../src/HomePageServlet',{},function(responseJson) {   
 //        $.each(responseJson, function(key, value) {               
 //          	$('<li>').text(value).appendTo($("#popular_ul"));      
 //        });
 //    });
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            alert(data);
        }
    }
    xhr.open('POST', 'HomePageServlet', true);
    xhr.send(null);

};

$(document).ready(main);