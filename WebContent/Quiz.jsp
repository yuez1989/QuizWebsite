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
	quiz = new Quiz("xiaotihu2015-11-23 19:12:15");

	if(quiz.isRandom()){
		quiz.shuffleQuestion();
	}
%>

<title>Welcome to <%=quiz.getQuizName() %></title>
</head>
<body>
<%
	if(quiz.isMultiplePages()){
		out.print("<p>hi</p>");
	}else{	
%>
	<form class='total_form' >
		<%
			ArrayList<Question> questions = quiz.getQuestions();
			int count=0;
			for(Question q: questions){
				count++;
				out.print("<div class = question"+count+">");
				out.print("<h3>Question "+count+"<h3>");
				if(Question.TYPE_FREERESPONCE.equals(q.getType())){
					out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
					if(!q.getPic().isEmpty())
						out.print("<img src=\'"+q.getPic()+"\' class=\'question_image\'>");
					out.print("<input type=\'text\' name=\'q"+count+"ans\' value=\'enter here\'>");
				}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
					out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
					ArrayList<String> options = q.parseOption();
					for(String opt: options){
						out.print("<input type=\'radio\' name = \'q"+count+"ans\'>"+opt+"</input>");
					}
				}else if(Question.TYPE_MATCHING.equals(q.getType())){
					out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
					ArrayList<String> optionsleft = q.parseOptionleft();
					ArrayList<String> optionsright = q.parseOptionright();
					int optcnt=1;
					for(String opt: optionsleft){
						out.print("<input type=\'text\' name = \'q"+count+"ans"+optcnt+"\'></input>");
						out.print("<p>"+opt+"</p>");
						out.print("<p>"+optionsright.get(optcnt-1)+"</p>");
						optcnt++;
					}
				}

				
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