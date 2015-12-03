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
		String userID = (String)session.getAttribute("user");
		
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

<form name="FinishQuiz" method="POST" action="UserHomePage.jsp">
	 <a href="javascript:document.FinishQuiz.submit()">Back to Homepage</a>
</form>

</body>
</html>
