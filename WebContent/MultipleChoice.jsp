<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a Free Response Question</title>
</head>
<body>
<%
ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
if(questions != null){
	System.out.println("question list passed");
	request.getSession().setAttribute("QuestionList" , questions);
}
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
<form name="submitQuestion" method="POST" action="AddMCToDB.jsp">
	Please enter the question here
	<INPUT TYPE="TEXT" NAME="question" value=""><BR>
	Please enter the picture url here
	<INPUT TYPE="TEXT" NAME="picture" value=""><BR>
	Please enter the time limit in seconds, if untimed, left it 0
	<INPUT TYPE="TEXT" NAME="time" value="0"><BR>
	please enter the choices here(if two solution means the same thing, enter in the same line and seperate with #)
	<input type="hidden" value="0" id="theValue" /> 

	<p><input type='button' onclick='addInputBox();' value='Add Choice'/></p> 

	<div id="myDiv"> </div> 
	<script> 

	var counter=0;
	var divIdName;
	function addInputBox() { 
		var ni = document.getElementById('myDiv'); 
		var numi = document.getElementById('theValue'); 
		//var num = (document.getElementById('theValue').value -1)+ 2; 
		numi.value = counter; 
		counter++;
		var newdiv = document.createElement('input'); 
		divIdName = 'Choice '+String.fromCharCode(counter+64); 
		newdiv.name = divIdName;
		newdiv.id = divIdName;
		newdiv.type = "text";
		newdiv.placeholder = String.fromCharCode(counter+64);
		//newdiv.innerHTML ="<input />"+divIdName;//<input type=\"button\" onclick=\"removeInputBox(\'"+divIdName+"\')\" value='Remove'/>"+divIdName; 
		ni.appendChild(newdiv); 
	} 

	function removeInputBox(divNum) { 
		var d = document.getElementById('myDiv'); 
		var olddiv = document.getElementById(divNum); 
		d.removeChild(olddiv); 
		counter--;
	} 
	function updateName(){
		divIdName = 'Choice '+counter; 
	}
	</script>
	please enter the solution here, if multiple choices are correct, seperate with","
	<INPUT TYPE="TEXT" NAME="solution" value=""><BR>
	<p><input type='button' onclick='removeInputBox(divIdName);updateName()' NAME= 'remove solution' value='remove Choice'/></p> 
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	 <a href="javascript:document.submitQuestion.submit()">Finish</a>
</form>
<form name="cancel" method="POST" action="CreateQuiz.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<a href="javascript:document.cancel.submit()">Cancel</a>
</form>
</body>
</html>
