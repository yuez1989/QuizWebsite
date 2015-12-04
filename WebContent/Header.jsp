<%@ page import="Quiz.*,java.util.*, java.lang.*, java.text.*"
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="QuizWebsite.css">
<script src='UserHomePage.js'></script>
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
		User user = new User(usrID);
		UserInfo info = user.info;
		ArrayList<Message> unreadMsgAll = Utilities.unreadMessages(user);

		ArrayList<Message> unreadMsg = new ArrayList<Message>(); //(All messages that are received)
		for (Message msg : unreadMsgAll) {
			if ((msg.fromID).equals(usrID))
				continue;
			unreadMsg.add(msg);
		}

		ArrayList<History> histories = Utilities.getRecentActivitiesOfUser(usrID);
		ArrayList<History> frdHistories = Utilities.getRecentFriendActivities(usrID);
		ArrayList<Quiz> popQuizzes = Utilities.getPopularQuiz();
	%>
			<div class="header-line">
			<div class="logo-header">
				<div class="logo-header-large">
					<a href="UserHomePage.jsp">Quizzzz</a>
				</div>
				<div class="logo-header-small">Only fun learning wakes us up</div>
			</div>
			<div class="personal-header">
				<div class="inline-part">
					<form method="POST" action="Person.jsp" target="_blank">
						<input type="search" name="person" placeholder="search by user ID"
							style="color: black;" size="25"> <input type="submit"
							value="Submit" style="color: black;">
					</form>
				</div>
				<div class="inline-part">
					<span> Welcome, <%=usrID%></span>
				</div>
				<div class="inline-part" id="popup-parent">
					<form name="submitFormMsg" method="POST" action="Messages.jsp"
						target="_blank">
						<input type="hidden" name="usrID" value="<%=usrID%>"> <a
							href="javascript:document.submitFormMsg.submit()" target="_blank">Messages
							<%
 	if (unreadMsg.size() > 0) {
 		out.print("(" + unreadMsg.size() + ")");
 	}
 %>
						</a>
					</form>
				</div>
				<div id="popup-child">
					<%
						// Calculate different kinds of messages.
						int newFriendRequests = 0, newChallenges = 0, newTextMessages = 0;
						for (Message msg : unreadMsg) {
							if ((msg.fromID).equals(usrID))
								continue;
							char type = msg.type.charAt(0);
							switch (type) {
							case 'f':
								newFriendRequests++;
								break;
							case 'c':
								newChallenges++;
								break;
							case 't':
								newTextMessages++;
								break;
							default:
								newTextMessages++;
								break;
							}
						}
					%>
					<p>
						New friend request:
						<%=newFriendRequests%></p>
					<p>
						New challenges:
						<%=newChallenges%></p>
					<p>
						New text messages:
						<%=newTextMessages%></p>
				</div>
				<div class="inline-part">
					<a href="logout.jsp">Log Out</a>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
</body>
</html>