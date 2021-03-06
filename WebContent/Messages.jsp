<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="Header.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

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
<script src='Background.js'></script>
<script type="text/javascript"
	src="bg-switcher/Source/js/jquery.bcat.bgswitcher.js"></script>
<%
	// Identify current session
	String usrID = "default";
	usrID = (String) session.getAttribute("user");
	if (usrID == null) {
		usrID = "default";
	}
	User user = new User(usrID);

	user.info.update();
	UserInfo info = user.info;
	ArrayList<Message> msgs = info.messages;
	Collections.sort(msgs);
%>
<title>Quizzzz Messages</title>

</head>
<body>
	<div class="body-section">
		<div class='body-part-wrapper col-md-4'>
			<div class='body-part'>
				<div class="column-name">MESSAGE OPTIONS</div>
				<div class="news-feed">
					<a href="MsgWrite.jsp" target="_blank" class='important-option'>Write A New Message</a>
				</div>
				<div class='news-feed'>
					<a href="MsgDeleteAll.jsp" class='dangerous-option'>Delete All
						Messages</a>
				</div>
			</div>
		</div>
		<div class='body-part-wrapper col-md-8'>
			<div class='body-part' style="min-height:200px!important;">
				<div class="column-name">INBOX</div>
				<div class="msg-container">
					<table>
						<tr>
							<th>From</th>
							<th>To</th>
							<th>Type</th>
							<th>Time</th>
							<th>Read</th>
							<th>Delete</th>
						</tr>
						<%
							for (int i = 0; i < msgs.size(); i++) {
								Message msg = msgs.get(i);
								// Remove all the messages the user sent -- we cannot see them
								if (!msg.toID.equals(usrID))
									continue;
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

								String readText = "Read";
								if (msg.isRead == 1 && msg.toID.equals(usrID))
									readText = "Unread";

								out.println("<tr>");
								out.println("<td><a href='Person.jsp?person=" + msg.fromID + "' target='_blank'>" + msg.fromID
										+ "</a></td>");
								out.println(
										"<td><a href='Person.jsp?person=" + msg.toID + "' target='_blank'>" + msg.toID + "</a></td>");
								out.println("<td>" + typeText + "</td>");
								out.println("<td>" + msg.time + "</td>");
								out.println("<td><a href='MsgRead.jsp?fromID=" + msg.fromID + "&toID=" + msg.toID + "&time=" + msg.time
										+ " ' target='_blank'>" + readText + "</a></td>");
								//<a href = "QuizHomePage.jsp?quizID=xiaotihu2015-11-23 19:12:15">Quiz HomePage</a
								out.println("<td>"); // COME BACK HERE! FOR DELETING MESSAGE 
								String formName = "DeleteMsgForm" + i;
								String formHrefName = "javascript:document." + formName + ".submit()";
								String msgTime = msg.time.replaceAll("\\s+", "");
								System.out.println("msgTime:" + msgTime);
						%>

						<form name=<%=formName%> method="POST" action="MsgDelete.jsp">
							<input type="hidden" name="fromIDDelete" value=<%=msg.fromID%>>
							<input type="hidden" name="toIDDelete" value=<%=msg.toID%>>
							<input type="hidden" name="timeDelete" value=<%=msgTime%>>
							<a href=<%=formHrefName%>>Delete</a>
						</form>

						<%
							out.println("</td>");
								out.println("</tr>");
							}
						%>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>