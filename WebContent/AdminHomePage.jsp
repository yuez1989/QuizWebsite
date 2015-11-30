<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="Quiz.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%		
//String usrID = (String) session.getAttribute("user");
String usrID ="xiaotihu";
Administrator admin = new Administrator(usrID);
session.setAttribute("admin", admin);
%>
<title>Welcome, administrator <%=admin.usrID %>!</title>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.3.min.js">
</script>



<script>

var main = function(){
	$("#create_announcement_form").hide();
	$("#remove_account_form").hide();
	$("#search_account_form").hide();
	$("#search_quiz_form").hide();
	$("#remove_quiz_form").hide();
	$("#clear_quiz_history_form").hide();
	$("#promote_account_form").hide();
	
	
	$("#create_announcement_tag").click(function(){
		$("#create_announcement_form").toggle();
	});
	
	$("#remove_account_tag").click(function(){
		$("#remove_account_form").toggle();
	});
	
	$("#search_account_tag").click(function(){
		$("#search_account_form").toggle();
	});
	
	$("#remove_quiz_tag").click(function(){
		$("#remove_quiz_form").toggle();
	});
	
	$("#search_quiz_tag").click(function(){
		$("#search_quiz_form").toggle();
	});
	
	$("#clear_quiz_history_tag").click(function(){
		$("#clear_quiz_history_form").toggle();
	});


	$("#promote_account_tag").click(function(){
		$("#promote_account_form").toggle();
	});
	
}


$(document).ready(main);

</script>


</head>
<body>

<div class = "search_account">
	<p id = 'search_account_tag'>Search Accounts</p>
	<form name = 'search_account_form' id = 'search_account_form' method ="post" action = "SearchAccountResult">
	<input type='text' name = 'searched_account'>
	<a href="javascript:document.search_account_form.submit()">Search</a>
	</form>
</div>

<div class = 'create_announcement'>
	<p id = 'create_announcement_tag'>Create Announcement</p>
	<form name="create_announcement_form" id="create_announcement_form" method="POST" action="AnnouncementSent">
	<textarea rows='4' cols='100' name = 'announcement_content' id = 'announcement_content' placeholder = 'Enter Message Here'></textarea>

	<a href="javascript:document.create_announcement_form.submit()">Send</a>
	</form>
</div>

<div class = 'remove_account'>
	<p id = 'remove_account_tag'>Remove Account</p>
	<form name = "remove_account_form" id = "remove_account_form" method="post" action="AccountRemoved">
	<input type='text' name = 'attempted_account'>
	<a href="javascript:document.remove_account_form.submit()">Remove</a>
	</form>
</div>


<div class = 'search_quiz_name'>
	<p id = 'search_quiz_name_tag'>Search Quiz By Name</p>
	<form name = "search_quiz_name_form" id = "search_quiz_name_form" method="post" action="SearchQuizByNameResult">
	<input type='text' name = 'searched_quizName'>
	<a href="javascript:document.search_quiz_name_form.submit()">Search</a>
	</form>
</div>

<div class = 'search_quiz'>
	<p id = 'search_quiz_tag'>Search Quiz</p>
	<form name = "search_quiz_form" id = "search_quiz_form" method="post" action="SearchQuizResult">
	<input type='text' name = 'searched_quizID'>
	<a href="javascript:document.search_quiz_form.submit()">Search</a>
	</form>
</div>


<div class = 'remove_quiz'>
	<p id = 'remove_quiz_tag'>Remove Quiz</p>
	<form name = "remove_quiz_form" id = "remove_quiz_form" method="post" action="QuizRemoved">
	<input type='text' name = 'attempted_quizID'>
	<a href="javascript:document.remove_quiz_form.submit()">Remove</a>
	</form>
</div>


<div class='clear_quiz_history'>
	<p id = 'clear_quiz_history_tag'>Clear Quiz History</p>
	<form name = "clear_quiz_history_form" id = "clear_quiz_history_form" method="post" action="QuizHistoryCleared">
	<input type='text' name = 'clear_hist_quizID'>
	<a href="javascript:document.clear_quiz_history_form.submit()">Clear</a>
	</form>
</div>

<div class = 'promote_account'>
	<p id = 'promote_account_tag'>Promote Account to Administrator</p>
	<form name = 'promote_account_form' id = 'promote_account_form' method='post' action='AccountPromoted'>
	<input type = 'text' name = 'attempted_account'>
	<a href="javascript:document.promote_account_form.submit()">Promote</a>
	</form>
</div>

<div class = 'site_statistics'>
<p>Site Statistics</p>
<p>Total number of users: <%=Utilities.getTotalNumberOfUsers() %></p>
<p>Total number of quizzes: <%=Utilities.getTotalNumberOfQuizzes() %></p>
</div>
</body>
</html>
