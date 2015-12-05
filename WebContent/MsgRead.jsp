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
		String friendID = fromID;
		if (fromID.equals(usrID))
			friendID = toID;
		Message msg = new Message(fromID, toID, time);
		String messageShown = msg.msg;
		String url = "";
		// Translate type
		String typeText = "";
		char typeCh = msg.type.charAt(0);
		switch (typeCh) {
		case 'f':
			typeText = "Friend Request";
			break;
		case 'c':
			int start = msg.msg.indexOf("Quiz.jsp?quizID=");
			if (start == -1) {
				start = msg.msg.length();
			}
			url = msg.msg.substring(start);
			messageShown = msg.msg.substring(0, start - 1);
			typeText = "Challenge";
			break;
		case 't':
			typeText = "Text";
			break;
		default:
			typeText = "Text";
			break;
		}

		msg.setAsRead(); // set this message as read
	%>
	<div class="body-section">
		<div class='body-part-wrapper col-md-2'></div>
		<div class='body-part-wrapper col-md-6'>
			<div class='body-part'>
				<div class='section-name'>MESSAGE</div>
				<div class="msg-read-box">
					<div class="msg-read-header"><%=msg.fromID%>
						to
						<%=msg.toID%></div>
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
								<td><%=messageShown%> <%
 	if (!url.equals("")) { // if there is an url here
 		out.println("<a href='" + url + "'>Click to take the Quiz.</a>");
 	}
 %></td>
							</tr>
						</table>
					</div>
					<br>
					<div class="msg-read-option">
						<%
							switch (typeCh) {
							case 'f':
								if (toID.equals(usrID)) {
									String strAgree = "<div><div class='msg-read-option-abreast'><form name='addFriendForm' method='POST' action='AddFriend.jsp'><input type='hidden' name='friendID' value='"
											+ friendID
											+ "'><a href='javascript:document.addFriendForm.submit()'>Agree</a></form></div>";
									String strDecline = "<div class='msg-read-option-abreast'><a href = 'Messages.jsp'>Decline</a></div></div>";
									out.println(strAgree);
									out.println(strDecline);
								}
								break;
							case 'c':
								out.println();
								break;
							case 't':
								break;
							default:
								break;
							}
						%>
						<br>
						<a href="Messages.jsp">Go back</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>