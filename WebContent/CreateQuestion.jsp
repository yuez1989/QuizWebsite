<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a Question</title>
</head>
<body>
Please choose the question type:
<%
ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
if(questions == null){
	System.out.println("no question list passed in createQuestion");
	//request.setAttribute("QuestionList", questions);
}
//System.out.println("in create question, problem list is: "+questions);
	String[] result = request.getParameterValues("Quiz Name");
	String QuizName="";
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

<form name="AddFreeResponse" method="POST" action="FreeResponse.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<a href="javascript:document.AddFreeResponse.submit()">Add Free Response Problem</a>
</form>

<form name="AddBlank" method="POST" action="FreeResponse.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<a href="javascript:document.AddBlank.submit()">Add Fill in Blank Problem</a>
</form>

<form name="AddPicResponse" method="POST" action="FreeResponse.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<a href="javascript:document.AddPicResponse.submit()">Add Picture Response Problem</a>
</form>

<form name="AddMultipleChoices" method="POST" action="MultipleChoice.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<a href="javascript:document.AddMultipleChoices.submit()">Add Multiple ChoicesProblem</a>
</form>



<form name="AddMatching" method="POST" action="Matching.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<a href="javascript:document.AddMatching.submit()">Add Matching Problem</a>
</form>

<form name="cancel" method="POST" action="CreateQuiz.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	 <a href="javascript:document.cancel.submit()">Cancel</a>
</form>
<%
	if(questions.size()>0 && QuizName.length()>0 && QuizName.trim().length()>0){
		%>	
		<form name="AddQuiz" method="POST" action="AddQuizToDB.jsp">
		<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
		<input type="hidden" name="Description" value="<%=Description%>">
		<input type="hidden" name="Tags" value="<%=Tags%>">
		<input type="hidden" name="Spec" value="<%=Spec%>">
		<a href="javascript:document.AddQuiz.submit()">Create</a>
		</form>
		<%
	}
%>
</body>
</html>
