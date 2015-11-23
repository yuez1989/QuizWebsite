<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Quiz.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String user = (String)session.getAttribute("user");
	//String person = (String)request.getAttribute("person");
	String person = "xiaotihu";
	if(user!=null && user.equals(person)){
		RequestDispatcher dispatcher = request.getRequestDispatcher("UserHomePage.jsp");
		dispatcher.forward(request, response);
	}
	UserInfo userinfo = new UserInfo(person); 
%>
<title><%=person%>'s Home Page</title>
<link rel="stylesheet" type="text/css" href="Person.css">
</head>
<body>

	<div class='menubar'>
		<ul id='menu_ul'>
			<li class='leftmenu'>Home Page: <%=person%></li>
			<li class='rightmenu'><img src='#'></li>
			<li class='rightmenu'><%=user %></li>
		</ul>
	</div>
	<%
		//can not access the homepage.
		if(userinfo.privacy == 'd'){
			out.print("<h2>Sorry, you don't have access to "+person+"\'s Homepage</h2>");
		}else{
			userinfo.update();
	%>
	<div class='friends'>
		<p><%=person %>'s Friends</p>
		<ul id='friends_ul'>
			<%
				for(Friend frd:userinfo.friends){
					out.print("<li>"+frd.getFriend(person)+"</li>");
				}
			%>
		</ul>
	</div>

	<div class='achievements'>
		<p><%=person %> has achieved</p>
		<ul id='achievements_ul'>
			<%
				for(AchievementRecord ach:userinfo.achievementRecords){
					out.print("<li>"+ach.achID+" at "+ach.time+"</li>");
				}
			%>		
		</ul>
	</div>	
	<div class='history'>
		<p><%=person %> played:</p>
		<ul id='history_ul'>
			<%
				for(History history:userinfo.histories){
					out.print("<li>"+history.quizID+" at "+history.start+"</li>");
				}
			%>
		</ul>
	</div>
	<%	
		}
	%>

</body>
</html>