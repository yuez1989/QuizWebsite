<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	//Quiz quiz = new Quiz(request.getParameter("quizID"));
	if(request.isRequestedSessionIdFromURL())
		System.out.println("get from url");
	else
		System.out.println("get from servlet?");
%>
<title>Insert title here</title>
</head>
<body>
<p>Practive Mode!</p>
</body>
</html>