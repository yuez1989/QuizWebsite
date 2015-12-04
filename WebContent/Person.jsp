<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="Quiz.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<%
	String usrID = "default";
	if (!session.isNew()) {
		usrID = (String) session.getAttribute("user");
		if (usrID == null) {
			usrID = "default";
			%>
			<title>Quizzzz: Homepage</title>
			<body>
			<div class="body-section">
			<div class='col-md-2'></div>
			<div class='col-md-8 body-part-wrapper'>
				<div class='body-part'>
				<h3>You have not logged in yet. Please login before visiting the page!</h3>"
				</div>
			</div>
			<div class='col-md-2'></div>
			</div>

			<%

			response.setHeader("Refresh", "2;index.jsp");
		}
		else {
%>
<%
	String person = (String) request.getParameter("person");
	User user = new User(person);
	person = Utilities.searchAccounts(person).get(0);
	UserInfo UserInfo = new UserInfo(person);
%>

<title>Quizzzz: Homepage of <%=person%></title>
</head>
<body>

	<div class="body-section">
		<div class='col-md-3 body-part-wrapper'>
			<div class='body-part'>
			<div class='column-name'>Friends Options</div>
			<div class='add-remove-friends'>
			<%
			if (!person.equals(usrID)) {	
		
			if (Utilities.isFriend(usrID, person)) {
				String removeStr = "RemoveFriend.jsp?friendID=" + person;
			%>
			<span class = 'news-feed'><a href=<%=removeStr%> target="_blank">Remove This friend</a></span>
			<%
			}
			else {
				String addStr = "AddFriend.jsp?friendID=" + person;
			%>
			<form name='addFriendForm' action="MsgWrite.jsp" method="post">
				<input type="hidden" name="frdID" value="<%=person%>"> 
				<span class='column-indent'><a href="javascript:document.addFriendForm.submit()">Send A Friend Request</a></span>
			</form>
			<%	
				}
			}
			%>
			</div>
			<div class='send-message-to-person'>
				<form name='sendMsgForm' action="MsgWrite.jsp" method="post">
					<input type="hidden" name="textToID" value="<%=person%>">
					<span class='column-indent'><a href="javascript:document.sendMsgForm.submit()">Send Him/Her A Message</a></span>
				</form>
			</div>
			</div>
		</div>
	

		<div class='col-md-9 body-part-wrapper'>
			<div class='body-part'>
				<div class = 'column-name'>Quizzzz: HOMEPAGE OF <%=person%></div>

				<%
				//can not access the homepage.
				if ((!usrID.equals(person)) && (user.privacy == 'p' || (user.privacy == 'f' && !Utilities.isFriend(usrID, person)))) {
					out.print("<span>Sorry, you don't have access to " + person
							+ "\'s Homepage</span>");
				} else {
					int countOverAll =0;
					
					UserInfo.update();
			%>

				<div class='friends'>
					<div class = 'column-name'><%=person%>'s Friends</div>

					<div id='friends_ul'>
						<%
							for (Friend frd : UserInfo.friends) {
								countOverAll++;
								String formname = "AccessPerson"+frd.getFriend(person)+countOverAll;
								String formsubmit = "javascript:document."+formname+".submit()";
								%>
						<form name='<%=formname%>' method="POST" action="Person.jsp">
							<input type="hidden" name="person"
								value="<%=frd.getFriend(person)%>"> <a href=<%=formsubmit%>>
								<%=frd.getFriend(person)%></a>
						</form>
						<%
									//out.print("<li>" + frd.getFriend(person) + "</li>");
								}
						%>
					</div>
				</div>

				<div class='achievements'>
					<div class = 'column-name'><%=person%> Has Achieved</div>
			
					<div class = 'achievements_imag'>
						<%
							for (AchievementRecord ach : UserInfo.achievementRecords) {
								out.print("<img src=\'"+Utilities.getImagePathOfAch(ach.achID)+"\' title = \'"+ach.achID+"\'style=\'width:250px;height:150px;\'>");
								}
						%>
					</div>
					<div id='achievements_ul'>
						<b>
						<%
							for (AchievementRecord ach : UserInfo.achievementRecords) {
									//out.print("<span class='news-feed'>" + ach.achID + " at " + ach.time + "</span>");
								out.print("<span class='news-feed'>" + ach.achID + "</span>");
							}
							if(UserInfo.achievementRecords.isEmpty()){
								out.println("<span class='news-feed'>No Acchievement Yet</span>");
							}
						%>
						</b>
					</div>
				</div>
				
				
				
				<div class='history'>
					<div class = 'column-name'><%=person%> Has Played:</div>

					<div id='history_ul'>
						<%
							int histcnt = 1;
							for (History history : UserInfo.histories) {
								if(histcnt>=5)
									break;
								
								String quizName = new Quiz(history.quizID).getQuizName();
								String quizStr = "QuizHomePage.jsp?quizID=" + history.quizID;
								quizStr = quizStr.substring(0, quizStr.indexOf(" ")) + "_"
										+ quizStr.substring(quizStr.indexOf(" ") + 1);
									out.print("<span class='column-indent'><a href=\'"+quizStr +"\' target='_blank'>"+quizName+"</a> at " + history.start
											+ " <br></span>");
								}
							if(UserInfo.histories.isEmpty()){
								out.print("<span class = 'column-indent'> No History Yet</span>");
							}
						%>
					</div>
				</div>
			</div>
		</div>
		</div>
	<%
		}
		}
	}
	%>










</body>
</html>
