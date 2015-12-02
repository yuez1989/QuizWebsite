<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Practice Quiz</title>
</head>
<body>
	<%
		
		//session.setAttribute("pract_quiz", new Quiz("xiaotihu2015-11-23 19:12:15"));
		Quiz pract_quiz;
		HashMap<String,Integer> correct_map = null;
		int cursor = 0;
		boolean flag = false;
		
		if(session.getAttribute("pract_quiz") != null){
			//some quiz is running in practice mode
			pract_quiz = (Quiz)session.getAttribute("pract_quiz");
			
			if(request.getParameter("quizID")!=null && !pract_quiz.getQuizID().equals(request.getParameter("quizID"))){
				//try to take another practice quiz. Not allowed. Redirect to quizhomepage
				String quizID = request.getParameter("quizID");
				out.print("<h3>Sorry, you can only practice one quiz per time. Focus on exercise makes progress!</h3>");
				out.println("<p>Redirect to Quiz Page in 2 seconds...</p>");
						
				out.println("<p><a href = \'QuizHomePage.jsp?quizID="+quizID+"\'>click here to return immediately</p>");
				out.print("<p><a href = \'QuizCancel.jsp?quizID="+quizID+"&practice=true\'>clear paused quiz</a></p>");

				response.setHeader("Refresh", "0;url=QuizHomePage.jsp?quizID="+quizID);
				flag = true;
				//out.close();
			}else{
				// resume the quiz in practice mode
				correct_map = (HashMap<String,Integer>)session.getAttribute("correct_map");
				cursor = (Integer)session.getAttribute("cursor");

			}
		}else{
			//starting a quiz in practice mode
			pract_quiz = new Quiz(request.getParameter("quizID"));
			correct_map = new LinkedHashMap<String,Integer>();
			ArrayList<Question> qlist = pract_quiz.getQuestions();
			if(pract_quiz.isRandom())
				pract_quiz.shuffleQuestion();
			for(Question questn:qlist){
				correct_map.put(questn.getProbID(), 0);
			}
			cursor = 0;
			session.setAttribute("pract_quiz", pract_quiz);
			session.setAttribute("correct_map", correct_map);
			session.setAttribute("cursor", 0);
		}
	if(!flag){
		if(pract_quiz.isRandom()){
			pract_quiz.shuffleQuestion();
			cursor = 0;
		}

		ArrayList<Question> questionlist = pract_quiz.getQuestions();
		for(; ;cursor = (cursor+1)%questionlist.size()){
			if(correct_map.containsKey(questionlist.get(cursor).getProbID()))
				break;
		}	

		Question q = questionlist.get(cursor);
		cursor = (cursor+1)%questionlist.size();
		session.setAttribute("cursor", cursor);
		
		// get current question q
		
		out.print("<form action=\'PracQResult.jsp\' method=\'post\'>");
		
		if(Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType())){
			out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
			if(!q.getPic().isEmpty())
				out.print("<img src=\'"+q.getPic()+"\' class=\'question_image\'>");
			for (int i = 1; i <= q.getsolNum(); i++){
				out.print("<input type=\'text\' name=\'q"+"ans"+i+"\' placeholder=\'enter here\'>");				
			}
		}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
			out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
			ArrayList<String> options = q.parseOption();
			int optcnt = 0;
			for(String opt: options){
				optcnt++;
				char chopt = (char)(optcnt-1+'A');
				if(optcnt == 1){
					out.print("<input type=\'radio\' name = \'q"+"ans1\' value = \'"+chopt+"\' checked=\'checked\'>"+opt+"</input>");							
				}else{
					out.print("<input type=\'radio\' name = \'q"+"ans1\' value = \'"+chopt+"\'>"+opt+"</input>");							
				}
			}
		}else if(Question.TYPE_MATCHING.equals(q.getType())){
			out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
			ArrayList<String> optionsleft = q.parseOptionleft();
			ArrayList<String> optionsright = q.parseOptionright();
			int optcnt=1;
			for(String opt: optionsleft){
				out.print("<input type=\'text\' name = \'q"+"ans"+optcnt+"\'></input>");
				out.print("<p>"+opt+"</p>");
				out.print("<p>"+optionsright.get(optcnt-1)+"</p>");
				optcnt++;
			}
		}else if(Question.TYPE_BLANKFILL.equals(q.getType())){
			String text = q.getText();
			String[] contents = text.split("<blank>");
			out.print("<p>");
			for(int i = 1; i< contents.length ; i++){
				out.print(contents[i-1]);
				out.print("<input type = \'text\' name =\'q"+"ans"+i+"\'>");
			}
			out.print(contents[contents.length-1]);
			out.print("</p>");
		}
	
	%>
	<input type = 'hidden' name = 'proID' value = <%=q.getProbID() %>>
	<p><input type = 'submit' value = 'Try'></p>
	</form>
	<div>
		<form class='cancel_form' action="QuizCancel.jsp" method="get">
		<input type="hidden" name="quizID" value="<%=pract_quiz.getQuizID() %>">
		<input type = "hidden" name = "practice" value='true'>
		<input type="submit" class = 'total_cancel' value='cancel'> 
		</form>
	</div>
	<% 
	}
	%>
</body>
</html>