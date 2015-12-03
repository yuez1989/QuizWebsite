<!DOCTYPE html>
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>


<html>
<head>
<meta charset="UTF-8">
<title>Quizzzz</title>
<link rel="stylesheet" type="text/css" href="indexstyle.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src='index.js'></script>
<%
// Test if you have already logged in
String usrID = "default";
if (!session.isNew() || session.isNew()) {
	usrID = (String) session.getAttribute("user");
	if (usrID != null) {
		response.setHeader("Refresh", "0;UserHomePage.jsp");
	}
	else {
%>
</head>
<body>
	<div class='menubar'>
		<ul>
			<li id='about' class='leftmenu'>About Us</li>
			<li id='explore' class='leftmenu'>Explore Quiz</li>
			<li id='login' class='rightmenu'>Log In
				<form id='login_form' action="UserLoginServlet" method="post">
					<label for="account">Name</label> <input type='text' name='account'
						id='account' /> <label for='password'>Password</label> <input
						type='password' name='password' id='password' /> <input
						type='submit' value='Login' />
				</form>
			</li>
			<li id='signup' class='rightmenu'>Sign Up</li>
		</ul>
	</div>
	<div class='most_popular'>
		<%
 			ArrayList<Quiz> poplist = Utilities.getPopularQuiz();
			if(poplist !=null){
				out.print("<h3>Most Popular Quizzes</h3>");
				out.print("<ul>");
				for(Quiz quiz:poplist){
					out.print("<li><a href = \'QuizHomePage.jsp?quizID="+quiz.getQuizID()+"\'>" + quiz.getQuizName() + "</a></li>");
				}
				out.print("</ul>");
			} 
		%>
	</div>
	<div class='top_player'>
		<%
 			ArrayList<User> toplist = Utilities.getTopPlayer();
			if(toplist != null){
				out.print("<h3>Toppest Player</h3>");
				out.print("<ul>");
				for(User player:toplist){
					out.print("<li><a href = \'Person.jsp?person="+player.usrID+"\'>"+ player.usrID + "</a></li>");
				}
				out.print("</ul>");
			} 
		%>
	</div>
	<div class='recent_quiz'>
		<%
 			ArrayList<Quiz> recentlist = Utilities.getRecentQuiz();
			if(recentlist!=null){
				out.print("<h3>Recent Added Quizzes</h3>");
				out.print("<ul>");
				for(Quiz quiz:recentlist){
					out.print("<li><a href = \'QuizHomePage.jsp?quizID="+quiz.getQuizID()+"\'>"+quiz.getQuizName()+"</li>");	
				}
				out.print("</ul>");
			} 
		%>
	</div>
<%
		
	}
}
%>
</body>
</html>