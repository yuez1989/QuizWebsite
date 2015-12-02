<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to <%=request.getParameter("quizName") %></title>
</head>
<body>
<form class='mp_form' action="QuizMPScore.jsp" method="post">
<%
	String quizID = request.getParameter("quizID");
	String quizName = request.getParameter("quizName");
	
	ArrayList<Question> questions = (ArrayList<Question>)session.getAttribute(quizID+"questions");
	
	if(quizID==null || quizName == null || questions == null )
		response.setHeader("Refresh", "0;UserHomePage.jsp");
	
	if(questions.isEmpty()){
		out.print("<h3>Error. You are taking this quiz simultaneously</h3>");
		response.setHeader("Refresh", "0;QuizHomePage.jsp?quizID="+quizID);
	}


	Question q = questions.get(questions.size()-1);
	
	out.print("<div>");
	if(Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType())){
		out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
		if(!q.getPic().isEmpty())
			out.print("<img src=\'"+q.getPic()+"\' class=\'question_image\'>");
		for (int i = 1; i <= q.getsolNum(); i++){
			out.print("<input type=\'text\' name=\'qans"+i+"\' placeholder=\'enter here\'>");				
		}
	}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
		out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
		ArrayList<String> options = q.parseOption();
		int optcnt = 0;
		for(String opt: options){
			optcnt++;
			char chopt =(char)( 'A'+optcnt - 1);
			if(optcnt == 1){
				out.print("<input type=\'radio\' name = \'qans1\' value = \'"+chopt+"\' checked=\'checked\'>"+opt+"</input>");							
			}else{
				out.print("<input type=\'radio\' name = \'qans1\' value = \'"+chopt+"\'>"+opt+"</input>");							
			}
		}
	}else if(Question.TYPE_MATCHING.equals(q.getType())){
		out.print("<p class=\'question_description\'>"+ q.getText()+"</p>");
		ArrayList<String> optionsleft = q.parseOptionleft();
		ArrayList<String> optionsright = q.parseOptionright();
		int optcnt=1;
		for(String opt: optionsleft){
			out.print("<input type=\'text\' name = \'qans"+optcnt+"\'></input>");
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
			out.print("<input type = \'text\' name =\'qans"+i+"\'>");
		}
		out.print(contents[contents.length-1]);
		out.print("</p>");
	}
	
	if(questions.size() == 1){
%>
	<div id="rating_review">
		<div id="rating">
			<label>Rating</label> 
			<label for="1star">1</label> 
			<input type="radio" name="rating" value="1" id="1star">
			<label for="2star">2</label> 
			<input type="radio" name="rating" value="2" id="2star"> 
			<label for="3star">3</label> 
			<input type="radio" name="rating" value="3" id="3star"> 
			<label for="4star">4</label> 
			<input type="radio" name="rating" value="4" id="4star"> 
			<label for="5star">5</label> 
			<input type="radio" name="rating" value="5" id="5star" checked="checked">
		</div>

		<div>
		<p><label for="review">Submit Review</label></p>

		<textarea rows="3" cols="50" name="review" id="review" placeholder="Love the quiz? Add a review now!"></textarea>
		</div>
	</div>
	
<%		
	}
%>
	
	</div>
	
	<input type = 'hidden' name = 'quizID' value = '<%=quizID %>'>
	<input type = 'hidden' name = 'quizName' value = '<%=quizName %>'>
	<input type = 'submit' class = 'question_submit' value = 'submit multiple pages'>
	
</form>

<div>
	<form class='cancel_form' action="QuizCancel.jsp" method="get">
		<input type="hidden" name="quizID" value="<%=quizID %>">
		<input type="submit" class = 'total_cancel' value='cancel'> 
	</form>
</div>
</body>
</html>