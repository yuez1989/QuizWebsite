<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a Matching Question</title>
</head>
<body>
<%
ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
if(questions != null){
	System.out.println("question list passed");
	request.getSession().setAttribute("QuestionList" , questions);
}
%>
<form name="submitQuestion" method="POST" action="AddMatchToDB.jsp">
	Please enter the question here
	<INPUT TYPE="TEXT" NAME="question" value=""><BR>
	Please enter the picture url here
	<INPUT TYPE="TEXT" NAME="picture" value=""><BR>
	Please enter the time limit in seconds, if untimed, left it blank
	<INPUT TYPE="TEXT" NAME="time" value="0"><BR>
	please enter the matches here(if two solution means the same thing, enter in the same line and seperate with #)
	
	<input type="hidden" value="0" id="theValue" /> 
	<p><input type='button' onclick='addInputBox();' NAME= 'Add Left side' value='Add Left side'/></p> 
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
		divIdName = 'Left '+counter; 
		//newdiv.setAttribute('id',divIdName); 
		newdiv.name = divIdName;
		newdiv.id = divIdName;
		newdiv.type = "text";
		newdiv.placeholder = counter;
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
		divIdName = 'Left '+counter; 
	}
	
	</script>
	<p><input type='button' onclick='removeInputBox(divIdName);updateName()' NAME= 'Remove Left side' value='Remove Left side'/></p> 
	
	
	
	<input type="hidden" value="0" id="theValue1" /> 
	<p><input type='button' onclick='addInputBox1();' NAME= 'Add Right side' value='Add Right side'/></p> 
	<div id="myDiv1"> </div> 
	<script> 
	var counter1=0;
	var divIdName1;
	function addInputBox1() { 
		var ni = document.getElementById('myDiv1'); 
		var numi = document.getElementById('theValue1'); 
		//var num = (document.getElementById('theValue').value -1)+ 2; 
		numi.value = counter1; 
		counter1++;
		var newdiv = document.createElement('input'); 
		divIdName1 = 'Right '+String.fromCharCode(counter1+64); 
		//newdiv.setAttribute('id',divIdName); 
		newdiv.name = divIdName1;
		newdiv.id = divIdName1;
		newdiv.type = "text";
		newdiv.placeholder = String.fromCharCode(counter1+64);
		//document.write(divIdName);
		//newdiv.innerHTML ="<input type=\"text\"/>"+divIdName;//<input type=\"button\" onclick=\"removeInputBox(\'"+divIdName+"\')\" value='Remove'/>"+divIdName; 
		//console.log("*********" + newdiv.innerHTML);
		ni.appendChild(newdiv); 
	} 

	function removeInputBox1(divNum) { 
		var d = document.getElementById('myDiv1'); 
		var olddiv = document.getElementById(divNum); 
		d.removeChild(olddiv); 
		counter1--;
	} 
	function updateName1(){
		divIdName1 = 'Right '+String.fromCharCode(counter1+64); 
	}
	
	</script>
	<p><input type='button' onclick='removeInputBox1(divIdName1);updateName1()' NAME= 'Remove Right side' value='Remove Right side'/></p> 
	
	
	
	<input type="hidden" value="0" id="theValue2" /> 
	<p><input type='button' onclick='addInputBox2();' NAME= 'Add Left Solution' value='Add Left Solution'/></p> 
	<div id="myDiv2"> </div> 
	<script> 
	var counter2=0;
	var divIdName2;
	function addInputBox2() { 
		var ni = document.getElementById('myDiv2'); 
		var numi = document.getElementById('theValue2'); 
		//var num = (document.getElementById('theValue').value -1)+ 2; 
		numi.value = counter1; 
		counter2++;
		var newdiv = document.createElement('input'); 
		divIdName2 = 'Solution '+counter2; 
		//newdiv.setAttribute('id',divIdName); 
		newdiv.name = divIdName2;
		newdiv.id = divIdName2;
		newdiv.type = "text";
		newdiv.placeholder = counter2;
		//document.write(divIdName);
		//newdiv.innerHTML ="<input type=\"text\"/>"+divIdName;//<input type=\"button\" onclick=\"removeInputBox(\'"+divIdName+"\')\" value='Remove'/>"+divIdName; 
		//console.log("*********" + newdiv.innerHTML);
		ni.appendChild(newdiv); 
	} 

	function removeInputBox2(divNum) { 
		var d = document.getElementById('myDiv2'); 
		var olddiv = document.getElementById(divNum); 
		d.removeChild(olddiv); 
		counter2--;
	} 
	function updateName2(){
		divIdName2 = 'Solution '+counter2; 
	}
	
	</script>
	
	<p><input type='button' onclick='removeInputBox2(divIdName2);updateName2()' NAME= 'Remove Left Solution' value='Remove Left Solution'/></p> 
	<a href="javascript:document.submitQuestion.submit()">Finish</a>
</form>
<%
//	probList =probList.substring(0,probList.indexOf("#"+p.getProbID()));
//	System.out.println("in free response, problem list is: "+probList);
	%>
<form name="cancel" method="POST" action="CreateQuiz.jsp">
	<input type="hidden" name="QuestionList" value="">
	 <a href="javascript:document.cancel.submit()">Cancel</a>
</form>
</body>
</html>
