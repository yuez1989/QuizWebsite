<%@ page import="Quiz.*,java.util.*, java.lang.*, java.text.*" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="QuizWebsite.css">
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
	
	
<title>Quizzzz <%
	String usrID = "default";
	if (!session.isNew()) {
		usrID = (String) session.getAttribute("user");
		if (usrID == null)
			usrID = "default";
	}
	out.println(usrID);
%>
</title>
</head>
<body>
	<div class="header-line">
		<div class="logo-header">
			<div class="logo-header-large"><a href="UserHomePage.jsp">Quizzzz</a></div>
			<div class="logo-header-small">Only fun learning wakes us up</div>
		</div>
		
		<div class="personal-header">
			<div class="inline-part">
				<span> Welcome, <%=usrID%></span>
			</div>
		
			<div class="inline-part">
				<a href="logout.jsp">Log Out</a>
			</div>
			
		</div>
	</div>
	<div class="uhp-content">
		<div class="uhp-user col-md-3">
		</div>
			<div class="uhp-news col-md-6">
				<div class="column-name">List Of Quizzes</div>
				<div>
				
					<%
						ArrayList<Quiz> quizzes = Utilities.getAllQuizzes();
						for (Quiz quiz : quizzes) {
					%>
					<div style="margin-top:30px; margin-left:0%;">
						<p>Name: <a href = "QuizHomePage.jsp?quizID=<%=quiz.getQuizID() %>"><%=quiz.getQuizName() %></a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Creator: <a href = "Person.jsp?person=<%=quiz.getCreator() %>"><%=quiz.getCreator() %></a></p>
						<p></p>
						<p>Description: <%=quiz.getDescription() %></p>
					</div>
					<%
							
						}
					%>
		
				</div>
	
			</div>
		
	</div>
		




</body>
</html>