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
<script src='Background.js'></script>
<script type="text/javascript"
	src="bg-switcher/Source/js/jquery.bcat.bgswitcher.js"></script>
<link type="text/css" rel="stylesheet"
	href="bg-switcher/Source/css/style.css" media="all" />
</head>
<title>Quizzzz <%
	String usrID = "default";
	if (!session.isNew()) {
		usrID = (String) session.getAttribute("user");
		if (usrID == null) {
			usrID = "default";
			response.setHeader("Refresh", "0;index.jsp");
		}
	}
	out.println(usrID);
%>
</title>
<body>
	<%
		User user = new User(usrID);

		UserInfo info = user.info;
		ArrayList<Message> unreadMsgAll = Utilities.unreadMessages(user);
		ArrayList<Message> unreadMsg = new ArrayList<Message>(); //(All messages that are received)
		for (Message msg : unreadMsgAll) {
			if ((msg.fromID).equals(usrID))
				continue;
			unreadMsg.add(msg);
		}
		ArrayList<History> histories = Utilities.getRecentActivitiesOfUser(usrID);
		ArrayList<History> frdHistories = Utilities.getRecentFriendActivities(usrID);
		ArrayList<Quiz> popQuizzes = Utilities.getPopularQuiz();
	%>
	<div class='webpage-wrapper'>
		<div class="header-line">
			<div class="logo-header">
				<div class="logo-header-large">
					<a href="UserHomePage.jsp">Quizzzz</a>
				</div>
				<div class="logo-header-small">Only fun learning wakes us up</div>
			</div>
			<div class="personal-header">
				<div class="inline-part">
					<form method="POST" action="AccountSearchByName.jsp"
						target="_blank">
						<input type="search" name="person" placeholder="search by user ID"
							style="color: black;" size="25"> <input type="submit"
							value="Submit" style="color: black;">
					</form>
				</div>
				<div class="inline-part">
					<span> Welcome, <%=usrID%></span>
				</div>
				<div class="inline-part" id="popup-parent">
					<form name="submitFormMsg" method="POST" action="Messages.jsp"
						target="_blank">
						<input type="hidden" name="usrID" value="<%=usrID%>"> <a
							href="javascript:document.submitFormMsg.submit()" target="_blank">Messages
							<%
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
							if ((msg.fromID).equals(usrID))
								continue;
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
		<div class="body-section">
			<div class='col-md-3 body-part-wrapper'>
				<div class='body-part'>
					<div class="column-name">PROFILE</div>
					<div class="news-feed">
						<form name="submitForm" method="POST" action="Person.jsp"
							target="_blank">
							<input type="hidden" name="person" value="<%=usrID%>"> <a
								href="javascript:document.submitForm.submit()"><%=usrID%>'s
								profile</a>
						</form>
					</div>
					<%
						String settingStr = "Setting.jsp?usrID=" + usrID;
					%>
					<div class="news-feed">
						<a href=<%=settingStr%> target="_blank">Setting</a>
					</div>
					<%
						if (user.permission == 1) {
					%>
					<div class="news-feed">
						<a href="AdminHomePage.jsp" target="_blank">Administration
							Settings</a>
					</div>
					<%
						}
					%>
					<br>
					<div>
						<span class="section-name">Achievements </span>
						<%
							ArrayList<AchievementRecord> achrs = info.achievementRecords;
							if (achrs.size() == 0) {
								out.println("No achievements yet.");
							}
							for (AchievementRecord achr : achrs) {
								Achievement ach = new Achievement(achr.achID);
						%>
						<div>
							<span class='column-indent' title='<%=ach.description%>'><%=achr.achID%></span>
						</div>
						<%
							}
						%>
					</div>
					<br>
					<div>
						<span class="section-name">Recent Quizzes Done</span><br>
						<%
							Calendar cal = new GregorianCalendar();
							boolean hasRecent = false;
							int counter = 0;
							for (History hist : histories) {
								counter++;
								if (counter == 10)
									break;
								// calculate a date of 3 days ago
								Date endDate = QuizSystem.convertToDate(hist.end);
								Date threeDaysAgo = QuizSystem.convertToDate(QuizSystem.minusDay(hist.end, 3));
						%>
						<%							
									if (endDate.compareTo(threeDaysAgo) >= 0) {
									hasRecent = true;
									String quizName = new Quiz(hist.quizID).getQuizName();
									String quizStr = "QuizHomePage.jsp?quizID=" + hist.quizID;
									quizStr = quizStr.substring(0, quizStr.indexOf(" ")) + "_"
											+ quizStr.substring(quizStr.indexOf(" ") + 1);
						%>
						<span class='column-indent'><a href=<%=quizStr%>
							target="_blank"><%=quizName%></a></span><br>
						<%
							}
							}
							if (hasRecent == false) {
								out.println("<span class='column-indent'>No recent history.</span>");
							}
						%>
					</div>
					<br>
					<div>
						<span class="section-name">Recent Creation</span><br>
						<%
							ArrayList<Quiz> createSelf = Utilities.getRecentCreatedQuiz(usrID);
							if (createSelf.size() == 0) {
								out.println("<span class='column-indent'>You did not created any quizzes yet.</span>");
							}
							for (Quiz quiz : createSelf) {
								String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
								quizStr = quizStr.substring(0, quizStr.indexOf(" ")) + "_"
										+ quizStr.substring(quizStr.indexOf(" ") + 1);
						%>
						<span class='column-indent'><a href=<%=quizStr%>
							target="_blank"><%=quiz.getQuizName()%></a></span><br>
						<%
							}
						%>
					</div>
					<br>
					<div>
						<span class="section-name">Friends List</span><br>
						<%
							ArrayList<String> frdIDs = Utilities.getFriendList(usrID);
							if (frdIDs.size() == 0) {
								out.println("<span class='column-indent'>No friends yet.</span>");
							}
							int maxFrdsAppear = 0; // max number of friends shown
							for (String frdID : frdIDs) {
								String frdLink = "Person.jsp?person=" + frdID;
						%>
						<span class='column-indent'><a href=<%=frdLink%>
							target="_blank"><%=frdID%></a></span><br>
						<%
							maxFrdsAppear++;
								if (maxFrdsAppear > 20) {
									break;
								}
							}
							String personLink = "Person.jsp?person=" + usrID;
						%>
						<span class='column-indent'><a href=<%=personLink%>
							target="_blank">...Go to profile to see all</a> </span>
					</div>
					<%
						String deleteStr = "RemoveSelfAccount.jsp?selfID=" + usrID;
					%>
					<div class="delete-account">
						<br> <a href=<%=deleteStr%> class='dangerous-option'>Delete
							Account</a>
					</div>
					<div class="write-to-admin">
						<a href="AdminList.jsp" class='normal-option' target='_blank'>Contact us</a>
					</div>
				</div>
				<div class='body-part'>
					<div class="column-name">Quiz Creation and Search</div>
					<div class="news-feed">
						<a href="CreateQuiz.jsp" target="_blank" class='important-option'>Create New Quiz</a>
					</div>
					<div class="news-feed">
						<a href="Quizzes.jsp" target="_blank">See all Quizzes</a>
					</div>
					<div class="news-feed create-quiz-button">
						<form name='searchQuizForm' method="POST"
							action="QuizSearchByName.jsp" target="_blank">
							<input type="search" name="quizID" placeholder="Enter quiz name or tag" value=""><br> <input
								type="submit" value="Search Quiz" style='margin-top: 10px;'>
						</form>
					</div>
				</div>
			</div>
			<div class='col-md-6 body-part-wrapper'>
				<div class='body-part'>
					<div class="column-name">NEWS OF FRIENDS</div>
					<div class="column-name">Quizzes Taken Recent</div>
					<%
						if (frdHistories.size() == 0) {
							out.println("No recent friend activities; Add more friend!");
						}
						int counterHist = 0;
						for (History hist : frdHistories) {
							counterHist++;
							if (counterHist > 10)
								break;
							Quiz quiz = new Quiz(hist.quizID);
							String histPersonStr = "Person.jsp?person=" + hist.usrID;
							String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
							quizStr = quizStr.substring(0, quizStr.indexOf(" ")) + "_"
									+ quizStr.substring(quizStr.indexOf(" ") + 1);
					%>
					<span class='news-feed'> <a href=<%=histPersonStr%>
						target="_blank"><%=hist.usrID%></a> took quiz <a href=<%=quizStr%>
						target="_blank"><%=quiz.getQuizName()%></a> at <%=hist.end%>,
						scoring <%=hist.score%>. Review: <%=hist.review%>; Rating: <%=hist.rating%>.
					</span>
					<%
						}
					%>
					<br>
					<div class="column-name">Quizzes Created</div>
					<%
						ArrayList<Quiz> recentCreatedQuizzesFrd = new ArrayList<Quiz>();
						for (String frdID : frdIDs) {
							ArrayList<Quiz> recents = Utilities.getRecentCreatedQuiz(frdID,1);
							recentCreatedQuizzesFrd.addAll(recents);
						}
						Collections.sort(recentCreatedQuizzesFrd);
						for (Quiz quiz : recentCreatedQuizzesFrd) {
							String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
							quizStr = quizStr.substring(0, quizStr.indexOf(" ")) + "_"
									+ quizStr.substring(quizStr.indexOf(" ") + 1);
					%>
					<span class='news-feed'><a href=<%=quizStr%> target="_blank"><%=quiz.getQuizName()%></a></span>
					<%
						}
					%>
					<div>
						<br>
						<div class="column-name">Achievements Earned</div>
						<%
							ArrayList<AchievementRecord> achrFrd = new ArrayList<AchievementRecord>();
							for (String frdID : frdIDs) {
								ArrayList<AchievementRecord> recents = Utilities.getRecentAchievements(frdID);
								achrFrd.addAll(recents);
							}
							Collections.sort(achrFrd);
							for (AchievementRecord achr : achrFrd) {
								String achUsrStr = "Person.jsp?person=" + achr.usrID;
								Achievement ach = new Achievement(achr.achID);
						%>
						<span class='news-feed'><a href=<%=achUsrStr%>><%=achr.usrID%></a>
							achieved <span title='<%=ach.description%>'><%=achr.achID%></span>
							at <%=achr.time%></span>
						<%
							}
						%>
					</div>
				</div>
			</div>
			<div class='col-md-3 body-part-wrapper'>
				<div class='body-part'>
					<div class="column-name">OTHERS</div>
					<div>
						<div class="column-name">Announcements</div>
						<%
							ArrayList<String> announcements = new ArrayList<String>();
							announcements = Utilities.getRecentAnnouncements(10);
							if (announcements != null) {
								if (announcements.size() != 0) {
									for (String s : announcements) {
						%>
						<span style='padding-left: 20px;'><%=s%></span><br>
						<%
							}
								} else {
						%>
						<span style='padding-left: 20px;'>No Announcement</span><br>
						<%
							}
							} else {
						%>
						<span style='padding-left: 20px;'>No Announcement</span><br>
						<%
							}
						%>
					</div>
				</div>
				<div class='body-part'>
					<div class="column-name">PUBLIC QUIZ UPDATES</div>
					<div>
						<div>
							<div class="column-name">Popular Quizzes</div>
							<%
								for (Quiz quiz : popQuizzes) {
									String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
									quizStr = quizStr.substring(0, quizStr.indexOf(" ")) + "_"
											+ quizStr.substring(quizStr.indexOf(" ") + 1);
							%>
							<span style='padding-left: 5px;'><a href=<%=quizStr%>
								target="_blank"><%=quiz.getQuizName()%></a></span><br>
							<%
								}
							%>
						</div><br>
						<div>
							<div class="column-name">Recently Created Quizzes</div>
							<%
								ArrayList<Quiz> recentQuizzesPublic = Utilities.getRecentQuiz(3);
								Collections.sort(recentQuizzesPublic);
								for (Quiz quiz : recentQuizzesPublic) {
									String quizStr = "QuizHomePage.jsp?quizID=" + quiz.getQuizID();
									quizStr = quizStr.substring(0, quizStr.indexOf(" ")) + "_"
											+ quizStr.substring(quizStr.indexOf(" ") + 1);
							%>
							<span style='padding-left: 5px;'><a href=<%=quizStr%>
								target="_blank"><%=quiz.getQuizName()%></a></span><br>
							<%
								}
							%>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
