<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Practice Sucess</title>
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