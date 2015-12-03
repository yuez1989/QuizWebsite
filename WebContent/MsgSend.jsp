<%@ page import="Quiz.*,java.util.*, java.lang.*, java.text.*"
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<body>
	<%
		String fromID = usrID;
		String toID = request.getParameter("toID");
		User receiver = new User(toID);
		if (fromID.equals(toID)) {
			out.println("<h3>You are trying to send a message to yourself! Redirecting back...</h3>");
			response.setHeader("Refresh", "2;Messages.jsp");
		} else if (!Utilities.ifUserExists(toID)) {
			out.println("<h3>The user you send message to does not exist! Redirecting back...</h3>");
			response.setHeader("Refresh", "2;Messages.jsp");
		}
		else { // normal sending situation
	%>
	<h3>Message Sent, redirecting back...</h3>
	<%
			String type = request.getParameter("type");
			String quizID = request.getParameter("quizID");
			String msg = request.getParameter("msg");
			Message message = new Message(fromID, toID, msg, type);
			message.saveToDB();
			response.setHeader("Refresh", "0;Messages.jsp");
		}
	%>
</body>
</html>