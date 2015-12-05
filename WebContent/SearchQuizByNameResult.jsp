<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="Header.jsp" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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

<title>Search Quiz Result</title>
</head>
<body>

<div class="body-section">
		<div class='col-md-2'></div>
		<div class='col-md-8 body-part-wrapper'>
			<div class='body-part'>
			<div class="column-name">SEARCH QUIZ RESULTS</div>
<%
	String inputquizName = request.getParameter("searched_quizName");
	ArrayList<String> list = Utilities.searchQuizzesByName(inputquizName);
	if(list.size() == 0){
		out.print("<span class = 'news-feed'>None...</span>");
	}else{
		for(String str:list){
			String[] spice = str.split("##");
			String quizurl = spice[0];
			String genstr = spice[0]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+spice[1];
			out.println("<span class= 'news-feed'><a href = \'QuizHomePage.jsp?quizID="+quizurl+"\' target='_blank'>"+genstr+"</a></span>");
		}
	}
%>

			<br><br><br>


			<span class = 'news-feed'><a href='AdminHomePage.jsp'>Return To Admin Page</a></span>
			</div>
		</div>

</div>




</body>
</html>
