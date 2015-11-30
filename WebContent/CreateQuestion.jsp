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
System.out.println("in create question, problem list is: "+questions);

%>

<form name="AddFreeResponse" method="POST" action="FreeResponse.jsp">
	<a href="javascript:document.AddFreeResponse.submit()">Add Free Response Problem</a>
</form>


<form name="AddMultipleChoices" method="POST" action="MultipleChoice.jsp">
	<a href="javascript:document.AddMultipleChoices.submit()">Add Multiple ChoicesProblem</a>
</form>


<form name="AddMatching" method="POST" action="Matching.jsp">
	<a href="javascript:document.AddMatching.submit()">Add Matching Problem</a>
</form>
</body>
</html>
