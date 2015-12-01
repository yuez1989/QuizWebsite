<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
if(questions != null){
	System.out.println("question list passed");
	//request.setAttribute("QuestionList", questions);
}
%>
<%
String userID = (String)session.getAttribute("user");
String result[] = request.getParameterValues("question"); 
String questionText ="";
if (result != null && result.length != 0) {
	questionText = result[0];
}
int count =1;
String choice = "";
while((choice = request.getParameter("Right "+Character.toString ((char) (count+64))))!=null){
	System.out.println(choice);
	if(!choice.equals("")){
		questionText +="<option_right>"+choice+"</option_right>";
	}
	count++;
}

count =1;
choice = "";
while((choice = request.getParameter("Left "+count))!=null){
	System.out.println(choice);
	if(!choice.equals("")){
		questionText +="<option_left>"+choice+"</option_left>";
	}
	count++;
}


String pictureUrl ="";
result = request.getParameterValues("picture"); 
if (result != null && result.length != 0) {
	pictureUrl = result[0];
} 

long time =0;
result = request.getParameterValues("time"); 
if (result != null && result.length != 0) {
	time = Long.parseLong(result[0])*1000;
} 

count =1;
ArrayList<ArrayList<String>> solutions = new ArrayList<ArrayList<String>>();
String sol = "";
//sol = request.getParameter("Solution 1");
//System.out.println(sol);
while((sol = request.getParameter("Solution "+count))!=null){
	System.out.println(sol);
	String oneSol[] = sol.split("#");
	ArrayList<String> oneClass = new ArrayList<String>();
	for(int j = 0; j<oneSol.length; j++){
		oneClass.add(oneSol[j]);
	}
	solutions.add(oneClass);
	count++;
}

result = request.getParameterValues("order"); 
int order = 0;
if (result != null && result.length != 0) {
	order = 1;
} 


Question p = new Question(questionText, pictureUrl, solutions,time, userID,order, "MATCH");
%>
<form name="submitQuestion" method="POST" action="CreateQuiz.jsp">
<%
	p.saveProb();
	questions.add(p);
	request.getSession().setAttribute("QuestionList" , questions);
	%>
	 <a href="javascript:document.submitQuestion.submit()">Finish</a>
</form>
</body>
</html>