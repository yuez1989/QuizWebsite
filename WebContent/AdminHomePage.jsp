<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="Quiz.*"%>
        <%@page import="java.util.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="Header.jsp" />

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
<script src='Background.js'></script>
<script type="text/javascript"
	src="bg-switcher/Source/js/jquery.bcat.bgswitcher.js"></script>
	
<%		
String usrID = (String) session.getAttribute("user");
Administrator admin = new Administrator(usrID);
session.setAttribute("admin", admin);
%>
<title>Welcome, administrator <%=admin.usrID %>!</title>


</head>
<body>

	<div class="body-section">
		<div class='col-md-3 body-part-wrapper'>
		<div class='body-part'>
			<div class = 'site_statistics'>
				<div class="column-name">Site Statistics</div>
				<span>Number Of Users: <%=Utilities.getTotalNumberOfUsers() %></span><br>
				<span>Number Of Quizzes: <%=Utilities.getTotalNumberOfQuizzes() %></span><br>
				<span>Quizzes Played: <%=Utilities.getTotalPlayedTimeOfQuizzes() %></span><br>
				<br>
			</div>
		</div>
		</div>
		<div class='col-md-9 body-part-wrapper'>
			<div class='body-part'>
			
			<div class="column-name">ADMIN HOMEPAGE</div>
			
			<div class = "search_account">
				<div class="column-name">Search Accounts</div>
				<form name = 'search_account_form' id = 'search_account_form' method ="post" action = "SearchAccountResult.jsp" target='_blank'>
				<input type='text' name = 'searched_account'>
				<a href="javascript:document.search_account_form.submit()">Search</a>
				</form>
				<br>
			</div>
			
			<div class = 'create_announcement'>
				<div class="column-name">Create Announcement</div>
				<form name="create_announcement_form" id="create_announcement_form" method="POST" action="AnnouncementSent">
				<textarea rows='4' cols='75' name = 'announcement_content' id = 'announcement_content' placeholder = 'Enter Message Here'></textarea>
				<a href="javascript:document.create_announcement_form.submit()">Send</a>
				</form>
				<br>
			</div>
			
			<div class = 'remove_account'>
				<div class="column-name">Remove Account</div>
				<form name = "remove_account_form" id = "remove_account_form" method="post" action="AccountRemoved.jsp">
				<input type='text' name = 'attempted_account'>
				<a href="javascript:document.remove_account_form.submit()">Remove</a>
				</form>
				<br>
			</div>


			<div class = 'search_quiz_name'>
				<div class="column-name">Search Quiz By Name</div>
				<form name = "search_quiz_name_form" id = "search_quiz_name_form" method="post" action="SearchQuizByNameResult.jsp">
				<input type='text' name = 'searched_quizName'>
				<a href="javascript:document.search_quiz_name_form.submit()">Search</a>
				</form>
				<br>
			</div>

			<div class = 'search_quiz'>
				<div class="column-name">Search Quiz By ID</div>
				<form name = "search_quiz_form" id = "search_quiz_form" method="post" action="SearchQuizResult.jsp">
				<input type='text' name = 'searched_quizID'>
				<a href="javascript:document.search_quiz_form.submit()">Search</a>
				</form>
				<br>
			</div>
			
			<div class = 'remove_quiz'>
				<div class="column-name">Remove Quiz By ID</div>
				<form name = "remove_quiz_form" id = "remove_quiz_form" method="post" action="QuizRemoved.jsp">
				<input type='text' name = 'attempted_quizID'>
				<a href="javascript:document.remove_quiz_form.submit()">Remove</a>
				</form>
				<br>
			</div>
			
			<div class='clear_quiz_history'>
				<div class="column-name">Clear Quiz History (Enter quiz ID)</div>
				<form name = "clear_quiz_history_form" id = "clear_quiz_history_form" method="post" action="QuizHistoryCleared.jsp">
				<input type='text' name = 'clear_hist_quizID'>
				<a href="javascript:document.clear_quiz_history_form.submit()">Clear</a>
				</form>
				<br>
			</div>
			
			<div class = 'promote_account'>
				<div class="column-name">Promote User to Administrator</div>
				<form name = 'promote_account_form' id = 'promote_account_form' method='post' action='AccountPromoted.jsp'>
				<input type = 'text' name = 'attempted_account'>
				<a href="javascript:document.promote_account_form.submit()">Promote</a>
				</form>
				<br>
			</div>
			<hr>
			<div class = 'delete_announcement'>
				<div class="column-name">Delete Announcement</div>
				<div id = "delete_announcement_content">
				
				<%
					ArrayList<String> announcelist = Utilities.getAllAnnouncements();
					ArrayList<String> announceIDList = new ArrayList<String>();
					ArrayList<String> announceContentList = new ArrayList<String>();
					
					for(String str:announcelist){
						String[] strs = str.split("##");
						announceIDList.add(strs[0]);
						announceContentList.add(strs[1]);
					}
					int N = announcelist.size();
					for(int i = 0; i< N; i++){
						%>
						
						<form id = 'delete_announcement_form' name = 'delete_announcement_form<%=i %>' method = 'post' action = 'AnnouncementRemoved'> 
						<input type = 'hidden' name = 'anid' value = '<%=announceIDList.get(i) %>'>
						<span><a href='javascript:document.delete_announcement_form<%=i %>.submit()'>Delete</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=announceContentList.get(i) %></span>
						</form>
						
						
					<%
						//out.print("<span>"+announceContentList.get(i)+"</span><br>");
						//out.print("<span><form id = 'delete_announcement_form' name = 'delete_announcement_form' method = 'post' action = 'AnnouncementRemoved'> <input type = 'hidden' name = 'anid' value = '"+announceIDList.get(i)+"'> <a href='javascript:document.delete_announcement_form.submit()'>Delete</a><form></span><br>");
						
					}
				
				%>
				</div>
			<br>
			</div>
			

		</div>
		
	</div>



</div>


</body>
</html>
