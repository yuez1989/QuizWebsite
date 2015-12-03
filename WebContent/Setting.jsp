<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="QuizWebsite.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
	integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ=="
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"
	integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX"
	crossorigin="anonymous">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"
	integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ=="
	crossorigin="anonymous"></script>
<title>Quizzzz <%
	String usrID = "default";
	usrID = (String) session.getAttribute("user");
	if (usrID == null)
		usrID = "default";
	out.println(usrID);
%>
</title>
<script>
	window.onload = function() {
		if (document.getElementById("privacy-indicator").innerHTML == "p") {
			document.getElementById("private-radio").checked = true;
		} else if (document.getElementById("privacy-indicator").innerHTML == "f") {
			document.getElementById("friend-radio").checked = true;
		} else if (document.getElementById("privacy-indicator").innerHTML == "d") {
			document.getElementById("default-radio").checked = true;
		} 
	};
</script>
</head>
<body>
	<%
		User user = new User(usrID);
		UserInfo info = user.info;
		// Let javascript control what options are grayed
		if (user.privacy == 'f') { // see if a valid quizID is passed here
			out.println("<div id='privacy-indicator' style='display:none;'>f</div>");
		} else if (user.privacy == 'd'){
			out.println("<div id='privacy-indicator' style='display:none;'>d</div>");
		} else if (user.privacy == 'p') {
			out.println("<div id='privacy-indicator' style='display:none;'>p</div>");
		}
	%>
	<div>
		<form name="submitMsgForm" action="PrivacySend.jsp" method="POST">
			<input id="private-radio" type="radio" name="privacy" value='p'>&nbsp;Private: only you could see your profile&nbsp;&nbsp; 
			<input id="default-radio" type="radio" name="privacy" value='d'>&nbsp;Default: everybody could see your profile&nbsp;&nbsp; 
			<input id="friend-radio" type="radio" name="privacy" value='f'>&nbsp;Friend: only you and your friend could see your profile&nbsp;&nbsp;
			<input type="submit" value="Submit">
		</form>
	</div>
</body>
</html>