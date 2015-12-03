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
	int countOverAll =0;
	int count1 = 0;
	out.print("<p>Recent Activities:</p>");
	for(History hist : recentActHist){
		if(count1 == 5) break;
		count1++;
		countOverAll++;
		String formname = "AccessPerson"+hist.getUsrID()+countOverAll;
		String formsubmit = "javascript:document."+formname+".submit()";
		%>
			<form name=<%=formname%> method="POST" action="Person.jsp">
				<input type="hidden" name="person" value="<%=hist.getUsrID()%>">
			 	<p>User: <a href=<%=formsubmit%>> <%=hist.getUsrID()%></a> played this quiz at <%=hist.getEndTime()%>
				 and got score of <%=hist.getScore()%></p>
			</form>
		<%
	}
	
	ArrayList<History> highScores = Utilities.getHighRecordsOfQuiz(quizID);
	int count2 = 0;
	out.print("<p>High Scores:</p>");
	for(History hist : highScores){
		if(count2 == 10) break;
		count2++;
		countOverAll++;
		String formname = "AccessPerson"+hist.getUsrID()+countOverAll;
		String formsubmit = "javascript:document."+formname+".submit()";
		%>
			<form name=<%=formname%> method="POST" action="Person.jsp">
				<input type="hidden" name="person" value="<%=hist.getUsrID()%>">
			 	<p>User: <a href=<%=formsubmit%>> <%=hist.getUsrID()%></a> score: <%=hist.getScore()%></p>
			</form>
		<%
	}
	
	double avgScore = Utilities.getQuizAverageScore(quizID);
	out.print("<p>The average score of this quiz is currently: "+avgScore+"</p>");	
	String userID = (String)session.getAttribute("user");
//	if(userID==null) userID = "jinzhiwang";
	if(quiz.getCreator().equals(userID)){
		%>
			<form name="EditQuiz" method="POST" action="CreateQuiz.jsp">
			<input type="hidden" name="QuizID" value="<%=quizID%>">
			 <a href="javascript:document.EditQuiz.submit()">Edit</a>
			</form>
		<%
	}
	out.println("<p><a href=\'Quiz.jsp?quizID="+quizID+"\'>Start Quiz</a> </p>");
	out.println("<p><a href='QuizPractice.jsp?quizID="+quizID+"\'>Start Quiz in Practice Mode</a> </p>");
	//TODO realization of editing the quiz
	out.println("<p><a href=homepage.jsp>Go Back To Home Page</a> </p>");
	
%>

</p>
</body>
</html>
