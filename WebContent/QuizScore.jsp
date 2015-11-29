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
	String quizID = request.getParameter("quizID");
	Quiz quiz = new Quiz(quizID);
	double grade = 0;

	ArrayList<Question> questions = quiz.getQuestions();
	
	int count=0;
	for(Question q: questions){
		count++;
	if(Question.TYPE_FREERESPONCE.equals(q.getType())){
		ArrayList<String> ans = new ArrayList<String>();
		ans.add(request.getParameter("q"+count+"ans"));
		out.print(q.grade(ans));
		grade = grade + q.grade(ans);
	}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
		ArrayList<String> ans = new ArrayList<String>();
		char ch =(char)((int)(request.getParameter("q"+count+"ans").charAt(0) - '1')+'A');
		ans.add(Character.toString(ch));
		
		out.print(q.grade(ans));
		grade = grade + q.grade(ans);
	}else if(Question.TYPE_MATCHING.equals(q.getType())){
		ArrayList<String> optionsleft = q.parseOptionleft();
		ArrayList<String> ans = new ArrayList<String>();

		int optcnt=1;
		for(String opt: optionsleft){
			char ch =(char)((int)(request.getParameter("q"+count+"ans"+optcnt).charAt(0) - '1')+'A');
			ans.add(Character.toString(ch));
			optcnt++;
		}
		out.print(q.grade(ans));
		grade = grade + q.grade(ans);
	}
	
	out.print("</div>");
}
new Utilities();
%>
<h3>Congratulations!</h3>
<h3>You get <%=grade %>/<%=quiz.getQuestions().size() %> in <%=quiz.getQuizName() %></h3>



<p>Quiz Statisics</p>
<ul>
<li>Highest Score: <%=Utilities.getHighRecordsOfQuiz(quiz.getQuizID()) %></li>
<li>Average Score: <%=Utilities.getQuizAverageScore(quiz.getQuizID()) %></li>
<li>Play Times: </li>
<li>You have played: <%=0 %> times</li>
</ul>

<p>Toppest Records for <%=quiz.getQuizName() %>:</p>
<ul>
<%
	ArrayList<History> highrecords = Utilities.getHighRecordsOfQuiz(quiz.getQuizID());
	for(History rec:highrecords){
		out.print("<li>"+rec.toString()+"</li>");
	}
%>
</ul>

<p>HomePage</p>
<p>Other quizzes</p>

</body>
</html>