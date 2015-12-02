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
		if (usrID == null) {
			usrID = "default";
			response.setHeader("Refresh", "0;index.jsp");
		}		
	}
	out.println(usrID);
%>
</title>
</head>
<body>
	<%
		User user = new User(usrID);
		user.info.update();
		UserInfo info = user.info;
		ArrayList<Message> msgs = info.messages;
		Collections.sort(msgs);
	%>
	<div class="msg-box">
		<div class="msg-left col-md-8">
			<div class="msg-header"><%=usrID%>'s Messages
			</div>
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
							if (!msg.toID.equals(usrID)) continue;
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

							String readText = "Yes, click to read again.";
							if (msg.isRead == 1 && msg.toID.equals(usrID))
								readText = "No, click to read it!";

							out.println("<tr>");
							out.println("<td>" + msg.fromID + "</td>");
							out.println("<td>" + msg.toID + "</td>");
							out.println("<td>" + typeText + "</td>");
							out.println("<td>" + msg.time + "</td>");
							out.println("<td><a href='MsgRead.jsp?fromID=" + msg.fromID + 
									"&toID=" + msg.toID + "&time=" + msg.time + " 'target='_blank'>" + readText + "</a></td>");
							//<a href = "QuizHomePage.jsp?quizID=xiaotihu2015-11-23 19:12:15">Quiz HomePage</a
							out.println("<td>"); // COME BACK HERE! FOR DELETING MESSAGE 
							String formName = "DeleteMsgForm" + i;
							String formHrefName = "javascript:document." + formName + ".submit()";
							String msgTime = msg.time.replaceAll("\\s+","");
							System.out.println("msgTime:" + msgTime);
							%>
							
					<form name=<%=formName%> method="POST" action="MsgDelete.jsp">
						<input type="hidden" name="fromIDDelete" value=<%=msg.fromID%>>
						<input type="hidden" name="toIDDelete" value=<%=msg.toID%>>
						<input type="hidden" name="timeDelete" value=<%=msgTime%>>
						<a href=<%=formHrefName%>>Delete this message</a>
					</form>
				
					<%							
							out.println("</td>");
							out.println("</tr>");
						}
					%>
				</table>
			</div>
		</div>
		<div class="msg-right col-md-4">
			<div class="msg-control">
				Control Panel
				<div class="msg-write">
					<a href="MsgWrite.jsp" target="_blank">Write A New Message</a>
				</div>
				<div class="msg-delete-all">
					<a href="MsgDeleteAll.jsp">Delete All Messages (USE WITH CAUTION!)</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>