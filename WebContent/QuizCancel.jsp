<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(request.getParameter("practice") != null){
		session.removeAttribute("pract_quiz");
		response.setHeader("Refresh", "0;url=QuizHomePage.jsp?quizID="+request.getParameter("quizID"));
	}else{
		session.removeAttribute(request.getParameter("quizID")+"questions");
		session.removeAttribute(request.getParameter("quizID")+"grade");
		session.removeAttribute(request.getParameter("quizID")+"startTime");
		response.setHeader("Refresh", "0;url=QuizHomePage.jsp?quizID="+request.getParameter("quizID"));
	}

%>
</body>
</html>