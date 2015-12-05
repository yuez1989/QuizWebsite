<!DOCTYPE html>
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>


<html>
<head>
<meta charset="UTF-8">
<title>Quizzzz</title>

<link rel="stylesheet" href="cssslider_files/csss_engine1/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src='index.js'></script>
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
<%
	// Test if you have already logged in
	String usrID = "default";
	usrID = (String) session.getAttribute("user");
	if (usrID != null) {
		response.setHeader("Refresh", "0;UserHomePage.jsp");
	} else {
%>
</head>
<body style='background-color:#ffffff!important;background-image:none!important;'>
	<div class='index-wrapper'>
		<!-- slider -->
		<!--[if IE]><link rel="stylesheet" href="cssslider_files/csss_engine1/ie.css"><![endif]-->
		<!--[if lte IE 9]><script type="text/javascript" src="cssslider_files/csss_engine1/ie.js"></script><![endif]-->
		<div class='csslider1 autoplay '>
			<input name="cs_anchor1" id='cs_slide1_0' type="radio"
				class='cs_anchor slide'> <input name="cs_anchor1"
				id='cs_slide1_1' type="radio" class='cs_anchor slide'> <input
				name="cs_anchor1" id='cs_slide1_2' type="radio"
				class='cs_anchor slide'> <input name="cs_anchor1"
				id='cs_slide1_3' type="radio" class='cs_anchor slide'> <input
				name="cs_anchor1" id='cs_play1' type="radio" class='cs_anchor'
				checked> <input name="cs_anchor1" id='cs_pause1_0'
				type="radio" class='cs_anchor pause'> <input
				name="cs_anchor1" id='cs_pause1_1' type="radio"
				class='cs_anchor pause'> <input name="cs_anchor1"
				id='cs_pause1_2' type="radio" class='cs_anchor pause'> <input
				name="cs_anchor1" id='cs_pause1_3' type="radio"
				class='cs_anchor pause'>
			<ul>
				<li class="cs_skeleton"><img
					src="cssslider_files/csss_images1/gldgate.jpg" style="width: 100%;"></li>
				<li class='num0 img slide'><img
					src='cssslider_files/csss_images1/gldgate.jpg' alt='World'
					title='World' /></li>
				<li class='num1 img slide'><img
					src='cssslider_files/csss_images1/dome.jpg' alt='Depth'
					title='Depth' /></li>
				<li class='num2 img slide'><img
					src='cssslider_files/csss_images1/dog.jpg' alt='Fun' title='Fun' /></li>
				<li class='num3 img slide'><img
					src='cssslider_files/csss_images1/laptop.jpg' alt='Technology'
					title='Technology' /></li>
			</ul>
			<div class="cs_engine">
				<a href="http://cssslider.com">responsive slider</a> by
				cssSlider.com v2.1m
			</div>
			<div class='cs_description'>
				<label class='num0'><span class="cs_title"><span
						class="cs_wrapper">World</span></span><br /> <span class="cs_descr"><span
						class="cs_wrapper">Broading your horizon...</span></span></label> <label
					class='num1'><span class="cs_title"><span
						class="cs_wrapper">Depth</span></span><br /> <span class="cs_descr"><span
						class="cs_wrapper">Deepen your knowledge...</span></span></label> <label
					class='num2'><span class="cs_title"><span
						class="cs_wrapper">Fun</span></span><br /> <span class="cs_descr"><span
						class="cs_wrapper">Make it fun!</span></span></label> <label class='num3'><span
					class="cs_title"><span class="cs_wrapper">Technology</span></span><br />
					<span class="cs_descr"><span class="cs_wrapper">Connect
							with your fellows</span></span></label>
			</div>
			<div class='cs_arrowprev'>
				<label class='num0' for='cs_slide1_0'><span><i></i><b></b></span></label>
				<label class='num1' for='cs_slide1_1'><span><i></i><b></b></span></label>
				<label class='num2' for='cs_slide1_2'><span><i></i><b></b></span></label>
				<label class='num3' for='cs_slide1_3'><span><i></i><b></b></span></label>
			</div>
			<div class='cs_arrownext'>
				<label class='num0' for='cs_slide1_0'><span><i></i><b></b></span></label>
				<label class='num1' for='cs_slide1_1'><span><i></i><b></b></span></label>
				<label class='num2' for='cs_slide1_2'><span><i></i><b></b></span></label>
				<label class='num3' for='cs_slide1_3'><span><i></i><b></b></span></label>
			</div>
			<div class='cs_bullets'>
				<label class='num0' for='cs_slide1_0'> <span
					class='cs_point'></span> <span class='cs_thumb'><img
						src='cssslider_files/csss_tooltips1/gldgate.jpg' alt='World'
						title='World' /></span></label> <label class='num1' for='cs_slide1_1'> <span
					class='cs_point'></span> <span class='cs_thumb'><img
						src='cssslider_files/csss_tooltips1/dome.jpg' alt='Depth'
						title='Depth' /></span></label> <label class='num2' for='cs_slide1_2'> <span
					class='cs_point'></span> <span class='cs_thumb'><img
						src='cssslider_files/csss_tooltips1/dog.jpg' alt='Fun' title='Fun' /></span></label>
				<label class='num3' for='cs_slide1_3'> <span
					class='cs_point'></span> <span class='cs_thumb'><img
						src='cssslider_files/csss_tooltips1/laptop.jpg' alt='Technology'
						title='Technology' /></span></label>
			</div>
		</div>
		<!-- End cssSlider -->
		<div class='welcome-wrapper'>
			<div class='welcome-box'>
				<div class='welcome-msg' data-toggle="collapse"
					data-target=".browse-section" title='Click to see our prouds!'>Welcome to Quizzzz!</div>
			</div>
		</div>

		<div class='menubar'>
			<ul>
				<li id='login'>
					<form name='login_form' action="UserLoginServlet" method="post">
						<label for="account">Name: </label> <input type='text'
							name='account' id='account' /> <label for='password'>Password: </label>
						<input type='password' name='password' id='password' /> <input
							type='submit' value='Login' />
					</form>
				</li>
				<li>
					<form action="CreateAccount.html" method="post">
						<input type='submit' value='Sign Up' />
					</form>
				</li>
			</ul>
		</div>
		
		<div class='browse-section collapse' id='browse-id'>
			<div class='most_popular col-md-4'>
				<%
					ArrayList<Quiz> poplist = Utilities.getPopularQuiz();
						if (poplist != null) {
							out.print("<h3>Most Popular Quizzes</h3>");
							out.print("<ul>");
							for (Quiz quiz : poplist) {
								out.print("<li><a href = \'QuizHomePage.jsp?quizID=" + quiz.getQuizID() + "\'>"
										+ quiz.getQuizName() + "</a></li>");
							}
							out.print("</ul>");
						}
				%>
			</div>
			<div class='top_player col-md-4'>
				<%
					ArrayList<User> toplist = Utilities.getTopPlayer();
						if (toplist != null) {
							out.print("<h3>Top Players</h3>");
							out.print("<ul>");
							for (User player : toplist) {
								out.print("<li><a href = \'Person.jsp?person=" + player.usrID + "\'>" + player.usrID
										+ "</a></li>");
							}
							out.print("</ul>");
						}
				%>
			</div>
			<div class='recent_quiz col-md-4'>
				<%
					ArrayList<Quiz> recentlist = Utilities.getRecentQuiz();
						if (recentlist != null) {
							out.print("<h3>Recently Added Quizzes</h3>");
							out.print("<ul>");
							for (Quiz quiz : recentlist) {
								out.print("<li><a href = \'QuizHomePage.jsp?quizID=" + quiz.getQuizID() + "\'>"
										+ quiz.getQuizName() + "</li>");
							}
							out.print("</ul>");
						}
				%>
			</div>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>
