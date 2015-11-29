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
<body>
	<%
		User user = new User(usrID);
		/*
	public History(String quizID, String usrID, String playmode, String start, 
			String end, long span, double score, String review, double rating)
	*/
	
		if (usrID.equals("yuez1989")) {
			History hist = new History("xiaotihu2015-11-23 19:12:15","yuez1989", "regular","2015-11-28 10:02:21","2015-11-28 10:02:22",1,100,"good", 5);
			user.addHistory(hist);
		}
		
		UserInfo info = user.info;
		ArrayList<Message> unreadMsg = Utilities.unreadMessages(user);
		ArrayList<History> histories = Utilities.getRecentActivitiesOfUser(usrID);
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
				<form name="submitFormMsg" method="POST" action="Messages.jsp">
					<input type="hidden" name="usrID" value="<%=usrID%>"> <a
						href="javascript:document.submitFormMsg.submit()">Messages <%
 	if (unreadMsg.size() > 0) {
 		out.print("(" + unreadMsg.size() + ")");
 	}
 %>
					</a>
				</form>
			</div>
			<div id="popup-child">
				<%
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
			<div>
				<form name="submitForm" method="POST" action="Person.jsp">
					<input type="hidden" name="person" value="<%=usrID%>"> <a
						href="javascript:document.submitForm.submit()"><%=usrID%>'s
						profile</a>
				</form>
			</div>
			<div>Setting</div>
			<div>Administration Settings</div>
			<div class="uhp-user-inner">
				<div>
					<span class="section-name">Achievements </span> 
					<span class="column-indent"> 
						<%
						 	ArrayList<AchievementRecord> achrs = info.achievementRecords;
						 	if (achrs.size() == 0) {
						 		out.println("No achievements yet.");
						 	}
						 	for (AchievementRecord achr : achrs) {
						 		out.println("<span class='column-indent'>" + achr.achID + "</span>");
						 	}
 						%>
					</span>
				</div>
				<div>
					<span class="section-name">Recent Quizzes</span>
					<span class="column-indent"> 
						<%
							Calendar cal = new GregorianCalendar();
							boolean hasRecent = false;
							for (History hist : histories) {
								Date endDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(hist.end);
								// calculate a date of 3 days ago
								cal.add(Calendar.DAY_OF_MONTH, -3);
								Date threeDaysAgo = cal.getTime();
								
								if (endDate.compareTo(threeDaysAgo) >= 0) {
									hasRecent = true;
									out.println("<span class='column-indent'>" + hist.quizID + "</span>");
								}
							}
							if (hasRecent == false) {
								out.println("No recent history.");
							}
 						%>
					</span>
				</div>
				<div>
					<span class="section-name">Recent Creation</span>
				</div>
				<div>
					<span class="section-name">Friends List</span> 
					<span class="column-indent"> 
						<%
						 	ArrayList<String> frdIDs = Utilities.getFriendList(usrID);
						 	if (frdIDs.size() == 0) {
						 		out.println("No friends yet.");
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
					</span>
				</div>
				<div style="clear: both;"></div>
			</div>
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
	</div>
</body>
</html>
