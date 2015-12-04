<%@ page import="Quiz.*,java.util.*, java.text.*" language="java" contentType="text/html; charset=ISO-8859-1"
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
		<div class='col-md-3'></div>
		<div class='col-md-6 body-part-wrapper'>
			<div class='body-part'>
			Hello
			</div>
		</div>
		<div class='col-md-3'></div>
	</div>

	<%
		}
	%>
	</div>
	</div>
</body>
</html>
