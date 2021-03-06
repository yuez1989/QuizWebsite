<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script type="text/javascript"
	src="bg-switcher/Source/js/jquery.bcat.bgswitcher.js"></script>
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
<script>
	window.onload = function() {
		if (document.getElementById("challenge-indicator").innerHTML == "YES") { // challenge mode
			document.getElementById("friend-radio").disabled = true;
			document.getElementById("text-radio").disabled = true;
			document.getElementById("challenge-radio").checked = true;
		} else if (document.getElementById("friend-indicator").innerHTML == "YES") {
			document.getElementById("challenge-radio").disabled = true;
			document.getElementById("text-radio").disabled = true;
			document.getElementById("friend-radio").checked = true;
		} else { // pure text mode
			document.getElementById("challenge-radio").disabled = true;
			document.getElementById("text-radio").checked = true;
		}
	};
</script>
</head>
<body style="background-image:url('images/aurora.jpeg');">
	<%
		User user = new User(usrID);
		UserInfo info = user.info;

		/* Detect which type this request is sent from other forms*/
		String quizID = request.getParameter("quizID");
		// Let javascript control what options are grayed
		if (quizID == null) { // see if a valid quizID is passed here
			out.println("<div id='challenge-indicator' style='display:none;'>NO</div>");
		} else {
			out.println("<div id='challenge-indicator' style='display:none;'>YES</div>");
		}
		String frdID = request.getParameter("frdID");
		if (frdID == null) { // see if a valid quizID is passed here
			out.println("<div id='friend-indicator' style='display:none;'>NO</div>");
		} else {
			out.println("<div id='friend-indicator' style='display:none;'>YES</div>");
		}

		String textToID = request.getParameter("textToID");
	%>
	<div class="body-section">
		<div class='body-part-wrapper col-md-2'></div>
		<div class='body-part-wrapper col-md-8'>
			<div class='body-part'>
				<div class="msg-write-box">
					<div class="msg-write-header">Write a New Message</div>
					<div class="msg-write-container">
						<form name="submitMsgForm" action="MsgSend.jsp" method="POST">
							<input type="hidden" name="fromID" value="<%=usrID%>"> <input
								type="hidden" name="quizID" value="<%=quizID%>">
							<%
								if (frdID == null) {
									if (textToID == null) {
							%>
							<input class="msg-write-input" type="text" name="toID"
								placeholder="Enter Receiver ID" required>
							<%
								} else {
							%>
							<input class="msg-write-input" type="text" name="toID"
								value=<%=textToID%> required>
							<%
								}
								} else {
							%>
							<input class="msg-write-input" type="text" name="toID"
								value=<%=frdID%> required>
							<%
								}
							%>
							<div class="msg-write-input">
								<input id="friend-radio" type="radio" name="type" value="f">&nbsp;Friend
								Request&nbsp;&nbsp; <input id="challenge-radio" type="radio"
									name="type" value="c">&nbsp;Challenge&nbsp;&nbsp; <input
									id="text-radio" type="radio" name="type" value="t">&nbsp;Pure
								Text&nbsp;&nbsp;
							</div>
							<%
								String placeText = "Enter text content.";
								if (quizID != null) {
									placeText = "Hi! I would like to challenge you on the quiz I have just taken. My best score is: "
											+ Utilities.getHighScoreOfUserInQuiz(quizID, usrID) + " Quiz.jsp?quizID=" + quizID + "";
								}
							%>
							<textarea id="msg-content" class="msg-write-input" name="msg"
								cols="50" rows="10"><%=placeText%></textarea>
							<br> <br> <input type="submit" value="Send"> <input
								type="reset" value="Reset">
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class='body-part-wrapper col-md-2'></div>
	</div>

</body>
</html>