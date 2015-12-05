<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>Report Inappropriate Quiz</title>
</head>
<body>
	<div class="body-section">
		<div class='body-part-wrapper col-md-4'></div>
		<div class='body-part-wrapper col-md-4'>
			<div class='body-part'>
<%
	String usrID = (String) session.getAttribute("user");
	String quizID =  request.getParameter("QuizID");
	Quiz QuizToReport = new Quiz(quizID);
	ArrayList<String> Admins = new ArrayList<String>();
	Admins = Utilities.getAllAdminIDs();
	for(String admin:Admins){
		String report = "Quiz with Quiz ID "+quizID+" is Inappropriate";
		Message m = new Message(usrID, admin, report,"t");
		m.saveToDB();
	}
%>
<p>We have submitted your report to administrator. Thank you for support us providing better service!</p>
<%
	response.setHeader("Refresh", "2;UserHomePage.jsp");
%>
<p><a href=UserHomePage.jsp>Go Back To Home Page</a> </p>
</div>
</div>
</div>
</body>
</html>
