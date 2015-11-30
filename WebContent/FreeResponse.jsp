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
%>
<form name="submitQuestion" method="POST" action="AddFRToDB.jsp">
	Please enter the question here
	<INPUT TYPE="TEXT" NAME="question" value=""><BR>
	Please enter the picture url here
	<INPUT TYPE="TEXT" NAME="picture" value=""><BR>
	Please enter the time limit in seconds, if untimed, left it 0
	<INPUT TYPE="TEXT" NAME="time" value="0"><BR>
	please enter the solution here(if two solution means the same thing, enter in the same line and seperate with #)
	<input type="hidden" value="0" id="theValue" /> 

	<p><input type='button' onclick='addInputBox();' NAME= 'Add solution' value='Add solution'/></p> 

	<div id="myDiv"> </div> 
	<script> 
	<%
	int count = 0;
	%>
	var counter=0;
	var divIdName;
	function addInputBox() { 
		var ni = document.getElementById('myDiv'); 
		var numi = document.getElementById('theValue'); 
		//var num = (document.getElementById('theValue').value -1)+ 2; 
		numi.value = counter; 
		counter++;
		var newdiv = document.createElement('input'); 
		divIdName = 'Solution '+counter; 
		//newdiv.setAttribute('id',divIdName); 
		newdiv.name = divIdName;
		newdiv.id = divIdName;
		newdiv.type = "text";
		//document.write(divIdName);
		//newdiv.innerHTML ="<input type=\"text\"/>"+divIdName;//<input type=\"button\" onclick=\"removeInputBox(\'"+divIdName+"\')\" value='Remove'/>"+divIdName; 
		//console.log("*********" + newdiv.innerHTML);
		ni.appendChild(newdiv); 
	} 

	function removeInputBox(divNum) { 
		var d = document.getElementById('myDiv'); 
		var olddiv = document.getElementById(divNum); 
		d.removeChild(olddiv); 
		counter--;
	} 
	function updateName(){
		divIdName = 'Solution '+counter; 
	}
	
	
	</script>
	<p><input type='button' onclick='removeInputBox(divIdName);updateName()' NAME= 'remove solution' value='remove solution'/></p> 
	<input type="checkbox" name="order" value="order"> select if you the solution need to appear in this order<BR>
	<input type="hidden" name="SolutionCount" value="<%=count%>">

	 <a href="javascript:document.submitQuestion.submit()">Finish</a>
</form>
<form name="cancel" method="POST" action="CreateQuiz.jsp">
	<input type="hidden" name="QuestionList" value="">
	 <a href="javascript:document.cancel.submit()">Cancel</a>
</form>

</body>
</html>
