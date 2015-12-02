<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Result</title>
</head>
<body>
<%
	String quizID = request.getParameter("quizID");
	String quizName = request.getParameter("quizName");
	ArrayList<Question> questions = (ArrayList<Question>) session.getAttribute(quizID+"questions");
	String strgrade = (String)session.getAttribute(quizID+"grade");
	
	if(quizID == null || quizName == null || questions== null || strgrade == null || session.getAttribute("user") == null){
		response.setHeader("Refresh", "0;UserHomePage.jsp");
	}else{
		
	double pregrade = Double.parseDouble((String)session.getAttribute(quizID+"grade"));

	Question q = questions.get(questions.size() - 1);
	
	double qgrade = 0;
	if(Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType()) || Question.TYPE_BLANKFILL.equals(q.getType())){
		ArrayList<String> ans = new ArrayList<String>();
		for(int i = 1; i<= q.getsolNum();i++){
			ans.add(request.getParameter("qans"+i));
		}
		qgrade = q.grade(ans);
	}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
		ArrayList<String> ans = new ArrayList<String>();

		char ch =request.getParameter("qans1").charAt(0);
		ans.add(Character.toString(ch));
		qgrade = q.grade(ans);
	}else if(Question.TYPE_MATCHING.equals(q.getType())){
		ArrayList<String> optionsleft = q.parseOptionleft();
		ArrayList<String> ans = new ArrayList<String>();
		int optcnt=1;
		for(String opt: optionsleft){
			if(!request.getParameter("qans"+optcnt).isEmpty()){
			char ch =(request.getParameter("qans"+optcnt).charAt(0));
			ans.add(Character.toString(ch));
			optcnt++;
			}else{
				ans.add("-");
			}
		}
		qgrade = q.grade(ans);
	}
	pregrade = pregrade + qgrade;
	questions.remove(questions.size()-1);
	
	if(questions.isEmpty()){
		
		String startTime = (String) session.getAttribute(quizID+"startTime");
		String endTime = QuizSystem.generateCurrentTime();
		
		
		char ratch = request.getParameter("rating").charAt(0);

		int rating = 5;

		switch (ratch) {
		case '1':
			rating = 1;
			break;
		case '2':
			rating = 2;
			break;
		case '3':
			rating = 3;
			break;
		case '4':
			rating = 4;
			break;
		}
		
		//warning this user should be user id not object
		History hst = new History(quizID, (String)session.getAttribute("user"), "Regular", startTime, endTime, pregrade,
				request.getParameter("review"), rating);
		
		hst.saveToDB();
				
		session.removeAttribute(quizID+"questions");
		session.removeAttribute(quizID+"grade");
		session.removeAttribute(quizID+"startTime");
		
		String usrID = (String) session.getAttribute("user");
		
		int quizPlayed = Utilities.getQuizNumberPlayed((String) session.getAttribute("user"),quizID);
			if(quizPlayed == 1){
				AchievementRecord achRec = new AchievementRecord(usrID, "Quiz Taker");
				achRec.saveToDB();
				out.println("<p>Congrats! You have just won a new Achievement: Quiz Taker</p>");
			}
			else if(quizPlayed == 2){
				AchievementRecord achRec = new AchievementRecord(usrID, "Kindergarten");
				achRec.saveToDB();	
				out.println("<p>Congrats! You have just won a new Achievement: Kindergarten</p>");

			}
			else if(quizPlayed == 10){
				AchievementRecord achRec = new AchievementRecord(usrID, "Primary School");
				achRec.saveToDB();	
				out.println("<p>Congrats! You have just won a new Achievement: Primary School</p>");

			}
			else if(quizPlayed == 30){
				AchievementRecord achRec = new AchievementRecord(usrID, "Middle School");
				achRec.saveToDB();	
				out.println("<p>Congrats! You have just won a new Achievement: Middle School</p>");
			}
			else if(quizPlayed == 50){
				AchievementRecord achRec = new AchievementRecord(usrID, "High School");
				achRec.saveToDB();	
				out.println("<p>Congrats! You have just won a new Achievement: High School</p>");

			}
			else if(quizPlayed == 100){
				AchievementRecord achRec = new AchievementRecord(usrID, "Quizzzz University Alumni");
				achRec.saveToDB();	
				out.println("<p>Congrats! You have just won a new Achievement: Quizzzz University Alumni</p>");

			} 
			
		%>
		
	<h3>Congratulations!</h3>
	<h3>
		You get
		<%=new DecimalFormat("#0.00").format(pregrade).toString()%>
		in
		<%=quizName%></h3>



	<p>Quiz Statisics</p>
	<ul>
		<li>Highest Score: <%=Utilities.getHighestScoreOfQuiz(quizID)%></li>
		<li>Average Score: <%=Utilities.getQuizAverageScore(quizID)%></li>
		<li>Play Times:You have played: <%=Utilities.getPlayTimesOfQuiz(quizID) %>		
			times</li>
	</ul>

	<p>
		Toppest Records for
		<%=quizName%>:
	</p>
	<ul>
		<%
			ArrayList<History> highrecords = Utilities.getHighRecordsOfQuiz(quizID);
			for (History rec : highrecords) {
				out.print("<li>" + rec.toString() + "</li>");
			}
		%>
	</ul>

	<p><a href = 'QuizHomePage.jsp?quizID=<%=quizID %>'>QuizHomePage</a></p>
	<p>TODO: User Home Page </p>
	<p>TODO: Other quizzes</p>
	
	<form name='challengeForm' action="MsgWrite.jsp" method="post">
		<input type="hidden" name="quizID" value="<%=quizID%>">
		<a href="javascript:document.challengeForm.submit()">Challenge your friend!</a>
	</form>
	
<%
						
	}else{
		if("true".equals(session.getAttribute(quizID+"correction"))){
			if(qgrade >=1)
				out.print("<h3>Congrats, it's correct!</h3>");
			else if(qgrade == 0){
				out.print("<h3>Sorry, you are wrong</h3>");
				out.print("<p>The answer should be "+q.getSol()+" </p>");
			}
			else{
				out.println("<h3>Partially Correct!</h3>");
				out.print("<p>The answer should be "+q.getSol()+" </p>");		
			}
			session.setAttribute(quizID+"questions",questions);
			session.setAttribute(quizID+"grade", Double.toString(pregrade));
			response.setHeader("Refresh", "2;url=QuizMultiPage.jsp?quizID="+quizID+"&quizName="+quizName);

		}else{
			response.setHeader("Refresh","0;url=QuizMultiPage.jsp?quizID="+quizID+"&quizName="+quizName);
		}
	}
}
%>
</body>
</html>