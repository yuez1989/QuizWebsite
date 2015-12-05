<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<%
String[] result;
String questionType = "";
result = request.getParameterValues("questionType");
if (result != null && result.length != 0) {
	questionType = result[0];
}
System.out.print("questionType is "+questionType);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a <%=questionType%> Question</title>
</head>
<body>
<%
/*ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
if(questions != null){
	//System.out.println("question list passed");
	request.getSession().setAttribute("QuestionList" , questions);
}else{
	System.out.println("NO question list passed");
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
String solnum = "";
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
		solnum = Integer.toString(p.getsolNum());
		questionType = p.getType(); 
		if(solnum.equals("0")){
			solnum="";
		}
		if(p.getOrder()!=0){
			order="Y";
		}
		
	}
}

%>
<form name="submitQuestion" method="POST" action="CreateQuiz.jsp">
	<p>Please enter the question here:
	<%if(questionType.equals("BLANK")){
		System.out.print(questionType);
		String s= "(place <blank> where you want a blank in your question)";
		%>
		<%=s%>
		<%
	} 	
	%></p>
	<textarea  NAME="question" cols="100" rows="5" ><%=context%></textarea><BR>
	Please enter the picture url here<BR>
	<INPUT TYPE="TEXT" NAME="picture" value="<%=url %>" style="width: 500px;"><BR>
	Please enter the time limit in second, if untimed, left it 0<BR>
	<INPUT TYPE="TEXT" NAME="time" value="<%=time %>"><BR>
	please enter the solution here(if two solution means the same thing, enter in the same line and seperate with #)<BR>
	<input type="hidden" value="<%=sol.size()%>" id="solutionLength" /> 
	<input type="hidden" value="0" id="theValue" /> 
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
	<p><input type='button' onclick='addInputBox("");' NAME= 'Add solution' value='Add solution'/></p> 

	<div id="myDiv"> </div> 
	<script> 
	var counter=0;
	var n = document.getElementById("solutionLength").value;
	for(i = 0; i<n; i++){
		addInputBox(document.getElementById('sol'+i).value);
	}
	var divIdName;
	function addInputBox(value) { 
		var ni = document.getElementById('myDiv'); 
		var numi = document.getElementById('theValue'); 
		//var num = (document.getElementById('theValue').value -1)+ 2; 
		numi.value = counter; 
		counter++;
		var newdiv = document.createElement('textarea'); 
		divIdName = 'Solution '+counter; 
		//newdiv.setAttribute('id',divIdName); 
		newdiv.name = divIdName;
		newdiv.id = divIdName;
		//newdiv.type = "text";
		newdiv.cols = "80";
		newdiv.rows = "5";
		newdiv.value = value;
		newdiv.placeholder = divIdName;
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
	Do solutions need to appear in this order?(Y/N)<BR>
	<input type="TEXT" name="order" value="<%=order%>"><BR>
	Please enter the number of solution needed if number of solution is different from the number of solutions you entered.
	<input type="TEXT" name="NumberOfSulution" value="<%=solnum%>"><BR>
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="questionType" value="<%=questionType%>">
	<input type="hidden" name="indexInList" value="<%=index%>">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	 <a href="javascript:document.submitQuestion.submit()">Finish</a>
</form>
<form name="cancel" method="POST" action="CreateQuiz.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	<input type="hidden" name="QuestionCancelled" value="CancelQuestion">
	 <a href="javascript:document.cancel.submit()">Cancel</a>
</form>

</body>
</html>
