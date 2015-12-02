<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new Quiz!!</title>
</head>
<body>

<h2>Create a new Quiz:</h2>
<%	
	String QuizName = "";
	String[] result = request.getParameterValues("Quiz Name");
	if (result != null && result.length != 0) {
		QuizName = result[0];
	}
	
	String Description = "";
	result = request.getParameterValues("Description");
	if (result != null && result.length != 0) {
		Description = result[0];
	}
	
	String Tags = "";
	result = request.getParameterValues("Tags");
	if (result != null && result.length != 0) {
		Tags = result[0];
	}
	
	String Spec = "";
	result = request.getParameterValues("Spec");
	if (result != null && result.length != 0) {
		Spec = result[0];
	}
	
%>


<form name="AddQuestion" method="POST" action="CreateQuestion.jsp">
Please enter Quiz name:
<INPUT TYPE="TEXT" NAME="Quiz Name" value="<%=QuizName%>"><BR>
Please enter Quiz description:
<INPUT TYPE="TEXT" NAME="Description" value="<%=Description%>"><BR>
Please enter Quiz tags, separate by space:
<INPUT TYPE="TEXT" NAME="Tags" value="<%=Tags%>"><BR>
Please enter Quiz option:
If you want question appear in random order, enter "R".
If you want question appear on multiple pages, enter "M".
If you want provide immediate correction, enter "I".
You can have multiple options, order does not matter.
<INPUT TYPE="TEXT" NAME="Spec" value="<%=Spec%>"><BR>


<%	
	ArrayList<Question> questions =  new ArrayList<Question>();	
	if(request.getSession().getAttribute("QuestionList") == null){
		request.getSession().setAttribute("QuestionList" , questions);	
	}else{
		questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
	}
	
	
%>
Current questions in the Quiz
<%	
	int count = 1;
	if(questions != null){
		for(Question p:questions){
			out.println("<p> Question "+count+"</p>");
			count++;
		}
	}
%>
	 <a href="javascript:document.AddQuestion.submit()">Add Problem</a>
</form>
<form name="AddQuiz" method="POST" action="AddQuizToDB.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	 <a href="javascript:document.AddQuiz.submit()">Create</a>
</form>
<form name="CancelQuiz" method="POST" action="UserHomePage.jsp">
	 <a href="javascript:document.CancelQuiz.submit()">Discard</a>
</form>
</body>
</html>
