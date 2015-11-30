<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="QuizWebsite.css">
<title>Quizzzz <%
	String usrID = request.getParameter("usrID");
	out.println(usrID);
%>
</title>
</head>
<body>
	<%
		User user = new User(usrID);

		UserInfo info = user.info;
		ArrayList<Message> msgs = info.messages;
		ArrayList<Message> unreadMsgs = Utilities.unreadMessages(user);
	%>
	<div class="msg-heading"><%=usrID%>'s Messages
	</div>
	<div class="msg-container">
		<table>
			<tr>
				<th>From</th>
				<th>To</th>
				<th>Type</th>
				<th>Time</th>
				<th>Read</th>
			</tr>
			<%
				for (Message msg : msgs) {
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
					
					String readText = "Y";
					if (msg.isRead == 1)
						readText = "N";
					
					out.println("<tr>");
					out.println("<td>" + msg.fromID + "</td>");
					out.println("<td>" + msg.toID + "</td>");
					out.println("<td>" + typeText + "</td>");
					out.println("<td>" + msg.time + "</td>");
					out.println("<td>" + readText + "</td>");
					out.println("</tr>");
				}
			%>
		</table>
	</div>
</body>
</html>