<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Quiz quiz = new Quiz(request.getParameter("quizID"));
	if(quiz.isRandom()){
		quiz.shuffleQuestion();
	}
%>
<title>Welcome to <%=quiz.getQuizName() %></title>
</head>
<body>
<%
	if(quiz.isMultiplePages()){
		
	}else{	
%>
	<form class='total_form'>
		<%
			ArrayList<Question> questions = quiz.getQuestions();
			int count=0;
			for(Question q: questions){
				count++;
				out.print("<div class = question"+count+">");
				out.print("<h3>Question "+count+"<h3>");
				out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
				if(!q.getPic().isEmpty())
					out.print("<img src=\'"+q.getPic()+"\' class=\'question_image\'>");
				
				out.print("</div>");
			}
		%>
		<input type="submit" class='total_submit'/>
	</form>
<%		
		
	}
%>
</body>
</html>