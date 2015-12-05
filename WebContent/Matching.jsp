<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="QuizWebsite.css">
<script src='UserHomePage.js'></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
	integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ=="
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"
	integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX"
	crossorigin="anonymous">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"
	integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ=="
	crossorigin="anonymous"></script>
<title>Create a Matching Question</title>
</head>
<body>
	<div class="body-section">
		<div class='body-part-wrapper col-md-10'>
			<div class='body-part'>
<%
String[] result;
/*ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
if(questions != null){
	System.out.println("question list passed");
	request.getSession().setAttribute("QuestionList" , questions);
}*/

String QuestionIDList="";
result = request.getParameterValues("QuestionIDList");
if (result != null && result.length != 0) {
	QuestionIDList = result[0];
}
//TOTOTOTOTOTOTOTOTO
ArrayList<Question> questions = Utilities.stringToQuestionList(QuestionIDList);
//TOTOTOTOTOTOTOTOTO

result = request.getParameterValues("Quiz Name");
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

String select[] = request.getParameterValues("QuizOption"); 
if (select != null && select.length != 0) {
	Spec = "";
	for (int i = 0; i < select.length; i++) {
		Spec+=select[i]; 
	}
}

String context="";
String url="";
String time = "0";
ArrayList<ArrayList<String>> sol = new ArrayList<ArrayList<String>>();
String index = "";
String order = "N";
ArrayList<String> optionsL = new ArrayList<String>();
ArrayList<String> optionsR = new ArrayList<String>();

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
		optionsL = p.parseOptionleft();
		optionsR = p.parseOptionright();
		System.out.println("length of right options is "+optionsR.size());
	}
}
%>
<form name="submitQuestion" method="POST" action="CreateQuiz.jsp">
	Please enter the question here<BR>
	<textarea  NAME="question" cols="100" rows="5" ><%=context%></textarea><BR>
	Please enter the picture url here<BR>
	<INPUT TYPE="TEXT" NAME="picture" value="<%=url %>" style="width: 500px;"><BR>
	Please enter the time limit in second, if untimed, left it 0<BR>
	<INPUT TYPE="TEXT" NAME="time" value="<%=time%>"><BR>
	<input type="hidden" value="<%=sol.size()%>" id="solutionLength" /> 
	<input type="hidden" value="<%=optionsL.size()%>" id="optLSize" />
	<input type="hidden" value="<%=optionsR.size()%>" id="optRSize" />
	
	please enter the matches here<BR>
	<% 

	for(int i = 0; i<optionsL.size(); i++){
		%>
			<input type="hidden" value="<%=optionsL.get(i)%>" id="<%="optL"+i %>" /> 
		<%
	}
	for(int i = 0; i<optionsR.size(); i++){
		%>
			<input type="hidden" value="<%=optionsR.get(i)%>" id="<%="optR"+i %>" /> 
		<%
	}
	
	%>
	
	<input type="hidden" value="0" id="theValue" /> 
	<p><input type='button' onclick='addInputBox("");' NAME= 'Add Left side' value='Add Left side'/></p> 
	<div id="myDiv"> </div> 
	<script> 
	var counter=0;
	var n = document.getElementById("optLSize").value;
	for(i = 0; i<n; i++){
		addInputBox(document.getElementById('optL'+i).value);
	}
	var divIdName;
	function addInputBox(value) { 
		var ni = document.getElementById('myDiv'); 
		var numi = document.getElementById('theValue'); 
		//var num = (document.getElementById('theValue').value -1)+ 2; 
		numi.value = counter; 
		counter++;
		var newdiv = document.createElement('textarea'); 
		divIdName = 'Left '+counter; 
		//newdiv.setAttribute('id',divIdName); 
		newdiv.name = divIdName;
		newdiv.id = divIdName;
		//newdiv.type = "text";
		newdiv.cols = "40";
		newdiv.rows = "3";
		newdiv.value = value;
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
	<p><input type='button' onclick='addInputBox1("");' NAME= 'Add Right side' value='Add Right side'/></p> 
	<div id="myDiv1"> </div> 
	<script> 
	var counter1=0;
	var n1 = document.getElementById("optRSize").value;
	for(i = 0; i<n1; i++){
		addInputBox1(document.getElementById('optR'+i).value);
	}	
	var divIdName1;
	function addInputBox1(value) { 
		var ni = document.getElementById('myDiv1'); 
		var numi = document.getElementById('theValue1'); 
		//var num = (document.getElementById('theValue').value -1)+ 2; 
		numi.value = counter1; 
		counter1++;
		var newdiv = document.createElement('textarea'); 
		divIdName1 = 'Right '+String.fromCharCode(counter1+64); 
		//newdiv.setAttribute('id',divIdName); 
		newdiv.name = divIdName1;
		newdiv.id = divIdName1;
		newdiv.cols = "40";
		newdiv.rows = "3";
		//newdiv.type = "text";
		newdiv.value = value;
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
	<p><input type='button' onclick='addInputBox2("");' NAME= 'Add Left Solution' value='Add Left Solution'/></p> 
	<div id="myDiv2"> </div> 
	<% 
	ArrayList<String> soltobox = new ArrayList<String>();
	for(int i = 0; i<sol.size();i++){
		String s= "";
		for(int j = 0; j<sol.get(i).size();j++){
			s+=sol.get(i).get(j)+"#";
		}
		s = s.substring(0,s.length()-1);
		soltobox.add(s);
	}
	for(int i = 0; i<soltobox.size(); i++){
		%>
			<input type="hidden" value="<%=soltobox.get(i)%>" id="<%="sol"+i %>" /> 
		<%
	}
	
	%>
	<script> 
	var counter2=0;
	var n2 = document.getElementById("solutionLength").value;
	for(i = 0; i<n2; i++){
		addInputBox2(document.getElementById('sol'+i).value);
	}
	var divIdName2;
	function addInputBox2(value) { 
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
		newdiv.value = value;
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
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>"> 
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	<input type="hidden" name="indexInList" value="<%=index%>">
	<input type="hidden" name="questionType" value="MATCH">
	<a href="javascript:document.submitQuestion.submit()">Finish</a>
</form>
<%
//	probList =probList.substring(0,probList.indexOf("#"+p.getProbID()));
//	System.out.println("in free response, problem list is: "+probList);
	%>
<form name="cancel" method="POST" action="CreateQuiz.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	 <a href="javascript:document.cancel.submit()">Cancel</a>
</form>
</div>
</div>
</div>
</body>
</html>
