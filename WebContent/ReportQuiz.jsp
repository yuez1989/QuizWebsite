<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Report Inappropriate Quiz</title>
</head>
<body>
<%
	String usrID = (String) session.getAttribute("user");
	String quizID =  request.getParameter("QuizID");
	Quiz QuizToReport = new Quiz(quizID);
	ArrayList<String> Admins = new ArrayList<String>();
	Admins = Utilities.getAllAdminIDs();
	for(String admin:Admins){
		String report = "Quiz with Quiz ID "+quizID+" is Inappropriate";
		Message m = new Message(usrID, admin, report,"t");
		m.saveToDB();
	}
%>
<p>We have submitted your report to administrator. Thank you for support us providing better service!</p>
<%
	response.setHeader("Refresh", "2;UserHomePage.jsp");
%>
<p><a href=UserHomePage.jsp>Go Back To Home Page</a> </p>
</body>
</html>
