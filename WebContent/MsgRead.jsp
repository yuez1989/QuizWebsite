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
	if (!session.isNew()) {
		usrID = (String) session.getAttribute("user");
		if (usrID == null)
			usrID = "default";
	}
	out.println(usrID);
%>
</title>
</head>
<body>
	<%
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String time = request.getParameter("time");
		Message msg = new Message(fromID, toID, time);

		// Translate type
		String typeText = "";
		char typeCh = msg.type.charAt(0);
		switch (typeCh) {
		case 'f':
			typeText = "Friend Request";
			break;
		case 'c':
			typeText = "Challenge";
			break;
		case 't':
			typeText = "Text";
			break;
		default:
			typeText = "Text";
			break;
		}
	%>
	<div class="msg-read-box">
		<div class="msg-read-header"><%=msg.fromID%> to <%=msg.toID%></div>
		<div class="msg-read-body">
			<table>
				<tr>
					<th>Time</th>
					<td><%=msg.time%></td>
				</tr>
				<tr>
					<th>Type</th>
					<td><%=typeText%></td>
				</tr>
				<tr>
					<th>Message</th>
					<td><%=msg.msg%></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>