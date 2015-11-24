<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<title>
	<%
		String usrID = "default";
		if (!session.isNew()) {
			usrID = (String) session.getAttribute("user");
			if (usrID == null)
				usrID = "default";
		}
		out.println(usrID);
	%>'s Homepage
</title>
<body>
	<div class="header-line">
		<div class="logo-header">
			<div class="logo-header-large">Quizzzz</div>
			<div class="logo-header-small">Only fun learning wakes us up</div>
		</div>
		<div class="personal-header">
			<p>
				Welcome,
				<%=usrID%></p>
			<a href="#">Messages</a> <a href="logout.jsp">Log Out</a>
		</div>
		<div style="clear: both;"></div>
	</div>
	<div class="uhp-content">
		<div class="uhp-user col-md-3">
			<div class="column-name">PROFILE</div>
			<div>
				<form name="submitForm" method="POST" action="Person.jsp">
					<input type="hidden" name="person" value="<%=usrID%>">
					<a href="javascript:document.submitForm.submit()"><%=usrID%>'s profile</a>
				</form>	
			</div>
			<div>Setting</div>
			<div>Administration Settings</div>
			<div class="uhp-user-inner column-name">
				<div>Achievements</div>
				<div>Recent Quizzes</div>
				<div>Recent Creation</div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div class="uhp-news col-md-6">
			<div class="column-name">NEWS</div>
			<ul class="uhp-news-inner">
			</ul>
			<div style="clear: both;"></div>
		</div>
		<div class="uhp-others col-md-3">
			<div class="column-name">OTHERS</div>
			<ul class="uhp-others-inner">
			</ul>
			<div style="clear: both;"></div>
		</div>
		<div style="clear: both;"></div>
	</div>
</body>
</html>