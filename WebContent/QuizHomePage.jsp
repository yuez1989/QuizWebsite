<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%String quizID =  request.getParameter("quizID");%>
<% quizID = "xiaotihu2015-11-23 19:12:15";%>
<%Quiz quiz = new Quiz(quizID);%>

<title> Quiz <%=quiz.getQuizName() %>, by <%= quiz.getCreator()%></title>
</head>
<body>
<p>
<%
	out.print("<p>Description: "+ quiz.getDescription()+"</p>");
	out.print("<p>Rating: "+quiz.getRating()+"</p>");
	ArrayList<String> recentReview = Utilities.getRecentQuizReviews(quizID);
	for(String re : recentReview){
		out.print("Recent review:\" " + re + "\"" );
	}

	ArrayList<History> recentActHist = Utilities.getRecentActivitiesOfQuiz(quizID);
	int count1 = 0;
	out.print("Recent Activities:");
	for(History hist : recentActHist){
		if(count1 == 5) break;
		count1++;
		out.print("User "+hist.getUsrID()+" played this quiz at "+hist.getEndTime()+
				" and got score of "+hist.getScore());
	}

	ArrayList<History> highScores = Utilities.getHighRecordsOfQuiz(quizID);
	int count2 = 0;
	out.print("High Scores:");
	for(History hist : highScores){
		if(count2 == 10) break;
		count2++;
		out.print("User: "+hist.getUsrID()+", score: "+hist.getScore());
	}
	
	double avgScore = Utilities.getQuizAverageScore(quizID);
	out.print("The average score of this quiz is currently: "+avgScore);	
	
	out.println("<p><a href=Quiz.jsp>Start Quiz</a> </p>");
	out.println("<p><a href=Quiz.jsp>Start Quiz in Practice Mode</a> </p>");
	//TODO realization of editing the quiz
	out.println("<p><a href=homepage.jsp>Go Back To Home Page</a> </p>");
	
%>

</p>
</body>
</html>
