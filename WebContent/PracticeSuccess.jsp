<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
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
<title>Practice Success</title>
</head>
<body>
<%
	Quiz quiz = (Quiz)session.getAttribute("pract_quiz");
	session.removeAttribute("pract_quiz");
	session.removeAttribute("correct_map");
	session.removeAttribute("cursor");
	
	if(!Utilities.hasAchievement("Practice makes perfect", (String)session.getAttribute("user"))){
		AchievementRecord achRec = new AchievementRecord((String)session.getAttribute("user"), "Practice makes perfect");
		achRec.saveToDB();	
		out.println("<h3>You have just won a new Achievement: Quizzzz University Alumni!</h3>");
	}
%>
<h3>Congratulations, you have went through practice for <%=quiz.getQuizName() %></h3>
<p>Redirecting to Quiz Page...</p>

<% response.setHeader("Refresh", "2;url=QuizHomePage.jsp?quizID="+quiz.getQuizID());
%>
<p><a href = 'UserHomePage.jsp'>Click here to return to homepage</a></p>
</body>
</html>
