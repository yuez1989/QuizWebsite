<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
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
	
<title>Promote User</title>
</head>
<body>


<div class="body-section">
		<div class='col-md-2'></div>
		<div class='col-md-8 body-part-wrapper'>
			<div class='body-part'>
			<div class="column-name">PROMOTE USER TO ADMINISTRATOR</div>
			
			<%
			String inputaccount = request.getParameter("attempted_account");
			ArrayList<String> similarids = Utilities.searchAccounts(inputaccount);
			
			if(!Utilities.searchAccountsExact(inputaccount)){
				out.println("<span class='news-feed'>No Accounts Found.</span>");
				out.println("<br><br><span class='news-feed'>Redirect to administrator page in 2 seconds...</span>");
				response.setHeader("Refresh", "2;url=AdminHomePage.jsp");
				out.println("<span class='news-feed'><a href = \'AdminHomePage.jsp\'>click here to return immediately</span>");	
			}else{
				out.print("<span class = 'news-feed'>One Accounts Found</span>");
				Administrator admin = (Administrator)request.getSession().getAttribute("admin");
				admin.promoteAdmin(similarids.get(0));
				out.print("<span class = 'news-feed'> You Have Promoted "+similarids.get(0)+"</span>");
				
				out.println("<br><br><span class='news-feed'>Redirect to administrator page in 3 seconds...</span>");
				out.println("<span class = 'news-feed'><a href = \'AdminHomePage.jsp\'>click here to return immediately</span>");	
				response.setHeader("Refresh", "3;url=AdminHomePage.jsp");

			}

			
			%>
			</div>
		</div>
		<div class='col-md-2'></div>
</div>
</body>
</html>
