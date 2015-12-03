<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	// Identify current session
	String usrID = "default";
	usrID = (String) session.getAttribute("user");
	if (usrID == null) {
		usrID = "default";
	}
	
	// Fix get blank bug
	String quizID =  request.getParameter("quizID");
	if (quizID.lastIndexOf('_') >= 0) {
		quizID = quizID.substring(0,quizID.indexOf("_"))+" "+quizID.substring(quizID.indexOf("_") + 1);
	}
	
	Quiz quiz = new Quiz(quizID);
	
	//Detect whether the search is valid
	ArrayList<String> searchRes = Utilities.searchQuizzes(quizID);
	if (searchRes.size() == 0) { // if there is a search result
		quizID = "xinhuiwu2015-11-18 16:19:13";
		out.println("<h3>The quiz you searched does not exist. We will redirect you to the list of quizzes we have...</h3>");
		response.setHeader("Refresh", "2;Quizzes.jsp");		
	}
	else {
%>

<title>Quiz <%=quiz.getQuizName() %>, by <%= quiz.getCreator()%></title>
</head>
<body>
	<div>
		<p>
			Name:
			<%= quiz.getQuizName() %></p>
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
			<p>
				User: <a href=<%=formsubmit%>> <%=hist.getUsrID()%></a> played this
				quiz at
				<%=hist.getEndTime()%>
				and got score of
				<%=hist.getScore()%></p>
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
			<p>
				User: <a href=<%=formsubmit%>> <%=hist.getUsrID()%></a> score:
				<%=hist.getScore()%></p>
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
			<input type="hidden" name="QuizID" value="<%=quizID%>"> <a
				href="javascript:document.EditQuiz.submit()">Edit</a>
		</form>
		<%
	}
	if (!usrID.equals("default")) {
		out.println("<p><a href=\'Quiz.jsp?quizID="+quizID+"\'>Start Quiz</a> </p>");
		out.println("<p><a href='QuizPractice.jsp?quizID="+quizID+"\'>Start Quiz in Practice Mode</a> </p>");
	}
	else {
	%>
	<br>
	<p>You cannot do or practice any quizzes if you are not logged in. Click <a href="CreateAccount.html">here</a> to sign up and <a href="index.jsp">here</a> to log in.</p>
	<%
	}
	out.println("<p><a href=homepage.jsp>Go Back To Home Page</a> </p>");
	}
%>

	</div>
</body>
</html>
