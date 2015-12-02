<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Get Your Grade!</title>
</head>
<body>
<%
	String endTime = QuizSystem.generateCurrentTime();
	String startTime = request.getParameter("startTime");
	String quizID = request.getParameter("quizID");
	String quizName = request.getParameter("quizName");
	ArrayList<Question> questions = (ArrayList<Question>)session.getAttribute(quizID+"questions");
	
	if(startTime == null || quizID == null || quizName == null || questions == null)
		response.setHeader("Refresh", "0;UserHomePage.jsp");
	else {
	session.removeAttribute(quizID+"questions");
	double grade = 0;
	
	int count=0;
	for(Question q: questions){
		count++;
		if(Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType()) || Question.TYPE_BLANKFILL.equals(q.getType())){
			ArrayList<String> ans = new ArrayList<String>();
			for(int i = 1; i<= q.getsolNum();i++){
				ans.add(request.getParameter("q"+count+"ans"+i));
			}
			out.print(q.grade(ans));
			grade = grade + q.grade(ans);
		}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
			ArrayList<String> ans = new ArrayList<String>();
	
			char ch =request.getParameter("q"+count+"ans1").charAt(0);
			ans.add(Character.toString(ch));
			out.print(q.grade(ans));
			grade = grade + q.grade(ans);
	
		}else if(Question.TYPE_MATCHING.equals(q.getType())){
			ArrayList<String> optionsleft = q.parseOptionleft();
			ArrayList<String> ans = new ArrayList<String>();
			int optcnt=1;
			for(String opt: optionsleft){
				if(!request.getParameter("q"+count+"ans"+optcnt).isEmpty()){
				char ch =(request.getParameter("q"+count+"ans"+optcnt).charAt(0));
				ans.add(Character.toString(ch));
				optcnt++;
				}else{
					ans.add("-");
				}
			}
			out.print(q.grade(ans));
			grade = grade + q.grade(ans);
		} 		
	}
			
		
	String usrID = (String) session.getAttribute("user");

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
	History hst = new History(quizID, usrID, "Regular", startTime, endTime, grade,
	request.getParameter("review"), rating);
	hst.saveToDB();

		//get number of histories of current user ID and check what achievement is available
		//***************TODO: check and complete******************
		int quizPlayed = Utilities.getQuizNumberPlayed((String) session.getAttribute("user"));
			if(quizPlayed == 1){
				AchievementRecord achRec = new AchievementRecord(usrID, "Quiz Taker");
				achRec.saveToDB();
				out.println("<p>Congrats! You have just won a new Achievement: Quiz Taker</p>");
			}
			else if(quizPlayed == 5){
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
		<%=grade%>/<%=questions.size()%>
		in
		<%=quizName%></h3>



	<p>Quiz Statisics</p>
	<ul>
		<li>Highest Score: <%= Utilities.getHighestScoreOfQuiz(quizID) %></li>
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
				out.print("<li>" + rec.toStrinQHome() + "</li>");
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
	<%} %>
</body>
</html>
