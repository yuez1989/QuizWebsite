<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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

	// Fix get blank bug
	String quizID = request.getParameter("quizID");
	if (quizID.lastIndexOf('_') >= 0) {
		quizID = quizID.substring(0, quizID.indexOf("_")) + " " + quizID.substring(quizID.indexOf("_") + 1);
	}

	Quiz quiz;
	//Detect whether the search is valid
	ArrayList<String> searchRes = Utilities.searchQuizzes(quizID);
	if (searchRes.size() == 0) { // if there is a search result
		quizID = "xinhuiwu2015-11-18 16:19:13";
		out.println(
				"<h3>The quiz you searched does not exist. We will redirect you to the list of quizzes we have...</h3>");
		response.setHeader("Refresh", "2;Quizzes.jsp");
	} else {
		quiz = new Quiz(searchRes.get(0));
%>
<title>Quiz <%=quiz.getQuizName()%>, by <%=quiz.getCreator()%></title>

</head>
<body>
	<div class="body-section">
		<div class='col-md-2'></div>
		<div class='col-md-8 body-part-wrapper'>
			<div class='body-part'>
			
			
			<div class="column-name">QUIZ SUMMARY PAGE</div>
			<div class="column-name">Name</div>
			<span><%= quiz.getQuizName() %></span>
				
			<div class="column-name">Description</div>
			<span><%= quiz.getDescription() %></span>

			<div class="column-name">Tags</div>
			<%
				for(String tagi:quiz.getTags()){
				out.print("<span><b>"+tagi+"&nbsp;&nbsp;&nbsp;&nbsp;</b></span>");
				}
				if(quiz.getTags().isEmpty())
				out.print("<span>No Tags Currently</span>");
			%>

			<div class="column-name">Rating</div>
			<span><%=quiz.getRating() %></span>

			<div class="column-name">Recent Review</div>
			<%
				ArrayList<String> recentReview = Utilities.getRecentQuizReviews(quizID);
				for(String re : recentReview){
					if(!re.isEmpty())
					out.print("<span class='news-feed'>" + re + "</span>" );
				}

				ArrayList<History> recentActHist = Utilities.getRecentActivitiesOfQuiz(quizID);
				int countOverAll =0;
				int count1 = 0;
			%>

			<div class="column-name">Recent Activities</div>
			
			<%
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
			<a href=<%=formsubmit%>> <%=hist.getUsrID()%></a> played this quiz at <%=hist.getEndTime()%> and got score of <%=hist.getScore()%></p>
			</form>
			<%
			}
			ArrayList<History> highScores = Utilities.getHighRecordsOfQuiz(quizID);
			int count2 = 0;
			%>

			<div class="column-name">High Scores</div>

			<%
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
				<a href=<%=formsubmit%>> <%=hist.getUsrID()%></a> score: <%=hist.getScore()%></p>
				</form>
			<%
			}
			ArrayList<History> highScoresLastday = Utilities.getTopPerformanceOfLastDay(quizID, QuizSystem.generateCurrentTime());
			int count3 = 0;
			%>

			<div class="column-name">High Scores of last day</div>

			<%

			for(History hist : highScoresLastday){
				if(count3 == 10) break;
				count3++;
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
			%>

			<div class="column-name">Average Scores</div>
			<span><%=avgScore %></span>

			<%

			String userID = (String)session.getAttribute("user");

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
				%>
				<form name="ReportQuiz" method="POST" action="ReportQuiz.jsp">
				<input type="hidden" name="QuizID" value="<%=quizID%>"> <a
				href="javascript:document.ReportQuiz.submit()">Report Inappropriate</a>
				</form>
				<%
			}else {
				%>
				<br>
				<p>You cannot do or practice any quizzes if you are not logged in. Click <a href="CreateAccount.html">here</a> to sign up and <a href="index.jsp">here</a> to log in.</p>
				<%
			}
			out.println("<p><a href=UserHomePage.jsp>Go Back To Home Page</a> </p>");
			%>










			</div>
		</div>
		<div class='col-md-2'></div>
	</div>

	<%
		}
	%>

</body>
</html>
