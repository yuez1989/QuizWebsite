<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
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
<script src='UserHomePage.js'></script>
</head>
<title>Quizzzz 
<%
	String usrID = "default";
	if (!session.isNew()) {
		usrID = (String) session.getAttribute("user");
		if (usrID == null)
			usrID = "default";
	}
	out.println(usrID);
%>
</title>
<body>
	<%
		User user = new User(usrID);
	
		/*
		if (usrID.equals("yuez1989")) {
			Message msg = new Message("xinhuiwu","yuez1989","hello","t");
			user.addMessage(msg);
		}
		*/
	
		UserInfo info = user.info;
		ArrayList<Message> unreadMsg = Utilities.unreadMessages(user);
		ArrayList<History> histories = Utilities.getRecentActivitiesOfUser(usrID);
		ArrayList<History> frdHistories = Utilities.getRecentFriendActivities(usrID);
		ArrayList<Quiz> popQuizzes = Utilities.getPopularQuiz();
	%>
	<div class="header-line">
		<div class="logo-header">
			<div class="logo-header-large">Quizzzz</div>
			<div class="logo-header-small">Only fun learning wakes us up</div>
		</div>
		<div class="personal-header">
			<div class="inline-part">
				<span> Welcome, <%=usrID%></span>
			</div>
			<div class="inline-part" id="popup-parent">
				<form name="submitFormMsg" method="POST" action="Messages.jsp" target="_blank">
					<input type="hidden" name="usrID" value="<%=usrID%>"> <a
						href="javascript:document.submitFormMsg.submit()" target="_blank">Messages <%
 	if (unreadMsg.size() > 0) {
 		out.print("(" + unreadMsg.size() + ")");
 	}
 %>
					</a>
				</form>
			</div>
			<div id="popup-child">
				<%
					// Calculate different kinds of messages.
					int newFriendRequests = 0, newChallenges = 0, newTextMessages = 0;
					for (Message msg : unreadMsg) {
						char type = msg.type.charAt(0);
						switch (type) {
						case 'f':
							newFriendRequests++;
							break;
						case 'c':
							newChallenges++;
							break;
						case 't':
							newTextMessages++;
							break;
						default:
							newTextMessages++;
							break;
						}
					}
				%>
				<p>
					New friend request:
					<%=newFriendRequests%></p>
				<p>
					New challenges:
					<%=newChallenges%></p>
				<p>
					New text messages:
					<%=newTextMessages%></p>
			</div>
			<div class="inline-part">
				<a href="logout.jsp">Log Out</a>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>
	<div class="uhp-content">
		<div class="uhp-user col-md-3">
			<div class="column-name">PROFILE</div>
			<div class="news-feed">
				<form name="submitForm" method="POST" action="Person.jsp" target="_blank">
					<input type="hidden" name="person" value="<%=usrID%>"> <a
						href="javascript:document.submitForm.submit()"><%=usrID%>'s
						profile</a>
				</form>
			</div>
			<div class="news-feed">Setting</div>
			<div class="news-feed">Administration Settings</div>
			<div class="uhp-user-inner">
				<div>
					<span class="section-name">Achievements </span>
					<%
						ArrayList<AchievementRecord> achrs = info.achievementRecords;
						if (achrs.size() == 0) {
							out.println("No achievements yet.");
						}
						for (AchievementRecord achr : achrs) {
							out.println("<span class='column-indent'>" + achr.achID + "</span>");
						}
					%>
				</div>
				<div>
					<span class="section-name">Recent Quizzes</span>
					<%
						Calendar cal = new GregorianCalendar();
						boolean hasRecent = false;
						for (History hist : histories) {
							// calculate a date of 3 days ago
							Date endDate = QuizSystem.convertToDate(hist.end);
							Date threeDaysAgo = QuizSystem.convertToDate(QuizSystem.minusDay(hist.end, 3));

							if (endDate.compareTo(threeDaysAgo) >= 0) {
								hasRecent = true;
								String quizName = new Quiz(hist.quizID).getQuizName();
								out.println("<span class='column-indent'>" + quizName + "</span>");
							}
						}
						if (hasRecent == false) {
							out.println("<span class='column-indent'>No recent history.</span>");
						}
					%>
				</div>
				<div>
					<span class="section-name">Recent Creation</span>
				</div>
				<div>
					<span class="section-name">Friends List</span>
					<%
						ArrayList<String> frdIDs = Utilities.getFriendList(usrID);
						if (frdIDs.size() == 0) {
							out.println("<span class='column-indent'>No friends yet.</span>");
						}
						int maxFrdsAppear = 0; // max number of friends shown
						for (String frdID : frdIDs) {
							out.println("<span class='column-indent'>" + frdID + "</span>");
							maxFrdsAppear++;
							if (maxFrdsAppear > 20) {
								out.println("...");
								break;
							}
						}
					%>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
		<div class="uhp-news col-md-6">
			<div class="column-name">NEWS</div>
			<div>
				<div class="column-name">Quizzes Taken</div>
				<%
					if (frdHistories.size() == 0) {
						out.println("No friend activities; Add more friend!");
					}
					for (History hist : frdHistories) {
						Quiz quiz = new Quiz(hist.quizID);
						String input = hist.usrID + " took quiz " + quiz.getQuizName() + " at " + hist.end + ", scoring "
								+ hist.score + ". Review: " + hist.review + ". Rating: " + hist.rating + ".";
						out.println("<span class='news-feed'>" + input + "</span>");
					}
				%>
			</div>
			<div>
				<div class="column-name">Quizzes Created</div>
				<%
					
				%>
			</div>
			<div>
				<div class="column-name">Achievements Earned</div>
				<%
					
				%>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div class="uhp-others col-md-3">
			<div class="column-name">OTHERS</div>
			<div>
				<div class="column-name">Announcement</div>
				<%
					
				%>
			</div>
			<div>
				<div class="column-name">Popular Quizzes</div>
				<%
					for (Quiz quiz : popQuizzes) {
						out.println("<span style='padding-left: 10px;'>" + quiz.getQuizName() + "</span>");
					}
				%>
			</div>
			<div>
				<div class="column-name">Recently Created Quizzes</div>
				<%
					
				%>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div style="clear: both;"></div>
	</div>
	</div>
</body>
</html>
