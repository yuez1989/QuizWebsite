<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz Website</title>
<link rel="stylesheet" type="text/css" href="indexstyle.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src='index.js'></script>
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
	<h1>
		You are
		<%
		String usrID = "default";
		if (!session.isNew()) {
			usrID = (String) session.getAttribute("user");
			if (usrID == null)
				usrID = "default";
		}
		out.println(usrID);
	%>
	</h1>
	<div class='most_popular'>
		<h3>Most Popular Quizzes</h3>
	</div>
	<div class='top_player'>
		<h3>Toppest Players</h3>
	</div>
	<div class=''>
</body>
</html>