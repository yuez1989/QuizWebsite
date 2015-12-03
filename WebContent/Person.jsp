<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="Quiz.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String usrID = "default";
	if (!session.isNew()) {
		usrID = (String) session.getAttribute("user");
		if (usrID == null) {
			usrID = "default";
			out.println("<h3>You have not logged in yet. Please login before visiting the page!</h3>");
			response.setHeader("Refresh", "2;index.jsp");
		}
		else {
%>
<%
	String person = (String) request.getParameter("person");
	User user = new User(person);
	person = Utilities.searchAccounts(person).get(0);
	//person = "xinhuiwu";
	UserInfo UserInfo = new UserInfo(person);
%>
<title>Quizzzz: Homepage of <%=person%>
</title>
<link rel="stylesheet" type="text/css" href="Person.css">
</head>
<body>
	<h1>
		Quizzzz: Homepage of
		<%=person%></h1>
	<div class="add-remove-friends">
		<%
		if (!person.equals(usrID)) {	
		
		if (Utilities.isFriend(usrID, person)) {
			String removeStr = "RemoveFriend.jsp?friendID=" + person;
		%>
		<a href=<%=removeStr%> target="_blank">Remove this friend</a>
		<%
		}
		else {
			String addStr = "AddFriend.jsp?friendID=" + person;
		%>
		<form name='addFriendForm' action="MsgWrite.jsp" method="post">
			<input type="hidden" name="frdID" value="<%=person%>"> 
			<a href="javascript:document.addFriendForm.submit()">Send a friend request</a>
		</form>
		<%	
			}
		}
	%>
	</div>
	<%
	//can not access the homepage.
	if ((!usrID.equals(person)) && (user.privacy == 'p' || (user.privacy == 'f' && !Utilities.isFriend(usrID, person)))) {
		out.print("<h2>Sorry, you don't have access to " + person
				+ "\'s Homepage</h2>");
	} else {
		int countOverAll =0;
		
		UserInfo.update();
%>
	<div class='friends'>
		<p><%=person%>'s Friends
		</p>
		<ul id='friends_ul'>
			<%
				for (Friend frd : UserInfo.friends) {
					countOverAll++;
					String formname = "AccessPerson"+frd.getFriend(person)+countOverAll;
					String formsubmit = "javascript:document."+formname+".submit()";
					%>
			<form name=<%=formname%> method="POST" action="Person.jsp">
				<input type="hidden" name="person"
					value="<%=frd.getFriend(person)%>"> <a href=<%=formsubmit%>>
					<%=frd.getFriend(person)%></a>
			</form>
			<%
						//out.print("<li>" + frd.getFriend(person) + "</li>");
					}
			%>
		</ul>
	</div>

	<div class='achievements'>
		<p><%=person%>
			has achieved
		</p>
		<ul id='achievements_ul'>
			<%
				for (AchievementRecord ach : UserInfo.achievementRecords) {
						out.print("<li>" + ach.achID + " at " + ach.time + "</li>");
					}
			%>
		</ul>
	</div>
	<div class='history'>
		<p><%=person%>
			played:
		</p>
		<ul id='history_ul'>
			<%
				for (History history : UserInfo.histories) {
						out.print("<li>" + history.quizID + " at " + history.start
								+ "</li>");
					}
			%>
		</ul>
	</div>
	<%
		}
		}
	}
	%>

</body>
</html>