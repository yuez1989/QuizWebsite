<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a New Quiz</title>
</head>
<body>

<%
	String userID = (String)session.getAttribute("user");
	String[] result;
	String discard= "";
	
	result = request.getParameterValues("Discard");
	if (result != null && result.length != 0) {
		discard = result[0];
	}
	if(discard.equals("Discard")){
		%>
			<p>Quiz information discard, redirect to your homepage</p>
		<%
		request.getSession().removeAttribute("QuestionList");
		//response.setHeader("Refresh", "2:UserHomePage.jsp");
	}else{
		%>
			<p>Congratulation! You just creaeted a new Quiz!!</p>
		<%

		String QuizName = "";
		result = request.getParameterValues("Quiz Name");
		if (result != null && result.length != 0) {
			QuizName = result[0];
		}
		System.out.println("on save page, Quiz Name:"+QuizName);
			
		String Description = "";
		result = request.getParameterValues("Description");
		if (result != null && result.length != 0) {
			Description = result[0];
		}
		System.out.println("on save page, Description:"+Description);	
	
		String Tags = "";
		result = request.getParameterValues("Tags");
		if (result != null && result.length != 0) {
			Tags = result[0];
		}
		System.out.println("on save page, Tags:"+Tags);	
	
		String Spec = "";
		result = request.getParameterValues("Spec");
		if (result != null && result.length != 0) {
			Spec = result[0];
		}
		System.out.println("on save page, Spec:"+Spec);
		
		ArrayList<String> tags = new ArrayList<String>();
		if (result != null && result.length != 0) {
			tags = new ArrayList<String>(Arrays.asList(result[0].split(" ")));
		}
		
		ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
		if(request.getSession().getAttribute("QuestionList") == null){
			request.getSession().setAttribute("QuestionList" , questions);	
		}
		Quiz q = new Quiz(QuizName, Description, userID, tags, questions, Spec);	
	
		String oldQuizID = null;
		oldQuizID = (String)request.getSession().getAttribute("OldQuizID");
		if(oldQuizID!=null){
			if(oldQuizID.length()>0){
				Quiz.deleteQuiz(oldQuizID);
			}
		}
		q.saveToDB();
	}
%>
<%
	//String userID = (String)session.getAttribute("user");
	int quizCreated = Utilities.getQuizNumberCreated(userID);
	if(quizCreated == 1){
		if(!Utilities.hasAchievement("Amateur Author", userID)){
			AchievementRecord achRec = new AchievementRecord(userID, "Amateur Author");
			achRec.saveToDB();
			out.println("<p><b>Congrats! You have just won a new Achievement: Amateur Author by successfully creating one quiz.</b></p>");
		}
	}
	else if(quizCreated == 5){
		if(!Utilities.hasAchievement("Prolific Author", userID)){
			AchievementRecord achRec = new AchievementRecord(userID, "Prolific Author");
			achRec.saveToDB();	
			out.println("<p><b>Congrats! You have just won a new Achievement: Prolific Author by successfully creating five quizzes.</b></p>");
		}
	}
	else if(quizCreated == 10){
		if(!Utilities.hasAchievement("Prodigious Author", userID)){
	
		AchievementRecord achRec = new AchievementRecord(userID, "Prodigious Author");
		achRec.saveToDB();	
		out.println("<p><b>Congrats! You have created ten quizzes. You have just won a new Achievement: Prodigious Author</b></p>");
		}
	}
	else if(quizCreated == 30){
		if(!Utilities.hasAchievement("Phenomenal Author", userID)){
	
		AchievementRecord achRec = new AchievementRecord(userID, "Phenomenal Author");
		achRec.saveToDB();	
		out.println("<p><b>Amazing! You have just created thirty quizzes! You have just won a new Achievement: Phenomenal Author</b></p>");
		}
	}
	else if(quizCreated == 50){
		if(!Utilities.hasAchievement("Confucius", userID)){
	
		AchievementRecord achRec = new AchievementRecord(userID, "Confucius");
		achRec.saveToDB();	
		out.println("<p><b>You have just created fifty quizzes!!! You have just won the Achievement of Confucius. You are the king of quiz creators!</b></p>");
		}
	}
%>

<form name="FinishQuiz" method="POST" action="UserHomePage.jsp">
	 <a href="javascript:document.FinishQuiz.submit()">Back to Homepage</a>
</form>

</body>
</html>
