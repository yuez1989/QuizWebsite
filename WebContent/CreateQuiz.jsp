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

<form ACTION="CreateQuiz.jsp">
Please enter Quiz name:
<INPUT TYPE="TEXT" NAME="" value="Quiz Name"><BR>
Please enter Quiz description:
<INPUT TYPE="TEXT" NAME="" value="Description"><BR>
Please enter Quiz tags, separate by space:
<INPUT TYPE="TEXT" NAME="" value="Tags"><BR>
<input type="checkbox" name="quizopt" value="R"> Question appear in random order<BR>
<input type="checkbox" name="quizopt" value="M"> Question appear on multiple pages<BR>
<input type="checkbox" name="quizopt" value="I"> provide immediate correction<BR>
</form>

<%
String result[] = request.getParameterValues("Quiz Name"); 
String quizName = "";
if (result != null && result.length != 0) {
	quizName = result[0];
} 
String description ="";
result = request.getParameterValues("Description"); 
if (result != null && result.length != 0) {
	description = result[0];
} 

ArrayList<String> tags = new ArrayList<String>();
result = request.getParameterValues("Tags");
if (result != null && result.length != 0) {
	tags = new ArrayList<String>(Arrays.asList(result[0].split(" ")));
}
String userID = (String)session.getAttribute("user");
String spec = "";
String select[] = request.getParameterValues("quizopt"); 
if (select != null && select.length != 0) {
	//out.println("You have selected: ");
	for (int i = 0; i < select.length; i++) {
		spec+=select[i];
	}
}
%>
<%	
	ArrayList<Question> questions =  new ArrayList<Question>();	
//	String questionIDs = "";
//	String questionText="";
	if(request.getSession().getAttribute("QuestionList") == null){
		request.getSession().setAttribute("QuestionList" , questions);	
	}
	Quiz q = new Quiz(quizName, description, userID, tags, questions, spec);
	questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
%>
Current questions in the Quiz
<%	
	int count = 1;
//	if((String) request.getParameter("QuestionList")!=null){
//		questionIDs = (String) request.getParameter("QuestionList");
//	}
//	if(questionIDs!=null){
//		for(int i = 0; i<questionIDs.split("#").length; i++){
//			Question p = new Question(questionIDs.split("#")[i]);
//			questions.add(p);
//		}
//	}
	if(questions != null){
		for(Question p:questions){
			out.println(p.getProbID());
			count++;
		}
	}
	//System.out.println("in quiz level, problem list is: "+questionIDs);
%>

<form name="AddQuestion" method="POST" action="CreateQuestion.jsp">
	 <a href="javascript:document.AddQuestion.submit()">Add Problem</a>
</form>
<input type="submit" name = "Submit Quiz" value="Submit Quiz">
<%
	result = request.getParameterValues("Submit Quiz"); 
	if (select != null && select.length != 0){
		q = new Quiz(quizName, description, userID, tags, questions, spec);
		q.saveToDB();
	}
	
	
%>
</body>
</html>
