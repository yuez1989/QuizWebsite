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

String context="";
String url="";
String time = "0";
ArrayList<ArrayList<String>> sol = new ArrayList<ArrayList<String>>();
String index = "";
String order = "N";
ArrayList<String> options = new ArrayList<String>();
result = request.getParameterValues("indexInList");
if (result != null && result.length != 0) {
	index = result[0];
	System.out.println("This is question #"+index);
}
if(index!=""){
	Question p = questions.get(Integer.parseInt(index)-1);
	if(p!=null){
		System.out.println("edit a old problem:)");
		context = p.getText();
		url = p.getPic();
		time = Long.toString(p.getTime()/1000);
		sol = p.getAllSol();
		if(p.getOrder()!=0){
			order="Y";
		}
		options = p.parseOption();
	}
}
%>
<form name="submitQuestion" method="POST" action="CreateQuiz.jsp">
	Please enter the question here
	<INPUT TYPE="TEXT" NAME="question" value="<%=context%>"><BR>
	Please enter the picture url here
	<INPUT TYPE="TEXT" NAME="picture" value="<%=url %>"><BR>
	Please enter the time limit in seconds, if untimed, left it 0
	<INPUT TYPE="TEXT" NAME="time" value="<%=time %>"><BR>
	<input type="hidden" value="<%=sol.size()%>" id="solutionLength" /> 
	<input type="hidden" value="<%=options.size()%>" id="optLength" />
	please enter the choices here(if two solution means the same thing, enter in the same line and seperate with #)
	<input type="hidden" value="0" id="theValue" /> 
	<% 
	ArrayList<String> soltobox = new ArrayList<String>();

	for(int i = 0; i<sol.size();i++){
		String s= "";
		for(int j = 0; j<sol.get(i).size();j++){
			s+=sol.get(i).get(j)+",";
		}
		s = s.substring(0,s.length()-1);
		soltobox.add(s);
	}
	if(soltobox.size()==0){
		String s= "";
		soltobox.add(s);
	}
	for(int i = 0; i<options.size(); i++){
		%>
			<input type="hidden" value="<%=options.get(i)%>" id="<%="choice"+i %>" /> 
		<%
	}
	
	%>


	<p><input type='button' onclick='addInputBox("");' value='Add Choice'/></p> 

	<div id="myDiv"> </div> 
	<script> 
	var counter=0;
	var n = document.getElementById("optLength").value;
	for(i = 0; i<n; i++){
		addInputBox(document.getElementById('choice'+i).value);
	}
	var divIdName;
	function addInputBox(value) { 
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
		newdiv.value = value;
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
	<INPUT TYPE="TEXT" NAME="solution" value="<%=soltobox.get(0) %>"><BR>
	<p><input type='button' onclick='removeInputBox(divIdName);updateName()' NAME= 'remove solution' value='remove Choice'/></p> 
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="questionType" value="MC">
	<input type="hidden" name="indexInList" value="<%=index%>">
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
