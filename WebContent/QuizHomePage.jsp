<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%String quizID =  request.getParameter("quizID");%>

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
		out.print("<p>Recent review:\" " + re + "\"</p>" );
	}

	ArrayList<History> recentActHist = Utilities.getRecentActivitiesOfQuiz(quizID);
	int count1 = 0;
	out.print("<p>Recent Activities:</p>");
	for(History hist : recentActHist){
		if(count1 == 5) break;
		count1++;
		out.print("<p>User "+hist.getUsrID()+" played this quiz at "+hist.getEndTime()+
				" and got score of "+hist.getScore()+"</p>");
	}
	
	ArrayList<History> highScores = Utilities.getHighRecordsOfQuiz(quizID);
	int count2 = 0;
	out.print("<p>High Scores:</p>");
	for(History hist : highScores){
		if(count2 == 10) break;
		count2++;
		out.print("<p>User: "+hist.getUsrID()+", score: "+hist.getScore()+"</p>");
	}
	
	double avgScore = Utilities.getQuizAverageScore(quizID);
	out.print("<p>The average score of this quiz is currently: "+avgScore+"</p>");	
	
	out.println("<p><a href=\'Quiz.jsp?quizID="+quizID+"\'>Start Quiz</a> </p>");
	out.println("<p><a href='QuizPractice.jsp?quizID="+quizID+"\'>Start Quiz in Practice Mode</a> </p>");
	//TODO realization of editing the quiz
	out.println("<p><a href=homepage.jsp>Go Back To Home Page</a> </p>");
	
%>

</p>
</body>
</html>