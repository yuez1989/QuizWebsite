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
<title>Create a Question</title>
</head>
<body>
	<div class="body-section">
		<div class='body-part-wrapper col-md-2'></div>
		<div class='body-part-wrapper col-md-6'>
			<div class='body-part'>
Please choose the question type:
<%
String[] result;
String QuestionIDList="";
result = request.getParameterValues("QuestionIDList");
if (result != null && result.length != 0) {
	QuestionIDList = result[0];
}
System.out.println("QuestionIDList in createQueston.jsp is"+QuestionIDList);
//TOTOTOTOTOTOTOTOTO
ArrayList<Question> questions = Utilities.stringToQuestionList(QuestionIDList);
//TOTOTOTOTOTOTOTOTO
/*
ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
if(questions == null){
	System.out.println("no question list passed in createQuestion");
	//request.setAttribute("QuestionList", questions);
}*/
//System.out.println("in create question, problem list is: "+questions);
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
	
%>

<form name="AddFreeResponse" method="POST" action="FreeResponse.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="questionType" value="FREERESPONSE">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	<a href="javascript:document.AddFreeResponse.submit()">Add Free Response Problem</a>
</form>

<form name="AddBlank" method="POST" action="FreeResponse.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="questionType" value="BLANK">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	<a href="javascript:document.AddBlank.submit()">Add Fill in Blank Problem</a>
</form>

<form name="AddPicResponse" method="POST" action="FreeResponse.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="questionType" value="PICTURERESPONCE">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	<a href="javascript:document.AddPicResponse.submit()">Add Picture Response Problem</a>
</form>

<form name="AddMultipleChoices" method="POST" action="MultipleChoice.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	<a href="javascript:document.AddMultipleChoices.submit()">Add Multiple ChoicesProblem</a>
</form>



<form name="AddMatching" method="POST" action="Matching.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	<a href="javascript:document.AddMatching.submit()">Add Matching Problem</a>
</form>

<form name="cancel" method="POST" action="CreateQuiz.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	 <a href="javascript:document.cancel.submit()">Edit General Quiz Information</a>
</form>
Current questions in the Quiz
<%
	int count = 1;
	System.out.println("questions length() at line 298 in CreateQuiz.jsp is "+questions.size());
	if(questions != null){
		if(questions.size()==0){
			%>
				<p>There is currently no question in this quiz!</p>
			<%
		}
		//for(Question p:questions){
		for(int i=0; i<questions.size();i++){
			Question p = questions.get(i);
			//session.setAttribute("Question "+Integer.toString(count), p);
			if(p==null){System.out.println("p is null at line 308 in CreateQuiz.jsp");}
			if(p.getType()==null){System.out.println("p is null at line 298 in CreateQuiz.jsp");}
			if(p.getType().equals("MC")){
				String formName = "AddMultipleChoices" + count;
				String jsCommand = "javascript:document.AddMultipleChoices" + count + ".submit()";
				%>
				<form name=<%=formName%> method="POST" action="MultipleChoice.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
					<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
					<input type="hidden" name="indexInList" value="<%=count%>">
					<a href= <%=jsCommand%>>Question <%=count %></a>
				</form>
				<%
			}
			else if(p.getType().equals("MATCH")){
				String formName = "AddMatching" + count;
				String jsCommand = "javascript:document.AddMatching" + count + ".submit()";
				%>
				<form name=<%=formName%> method="POST" action="Matching.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
					<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
					<input type="hidden" name="indexInList" value="<%=count%>">
					<a href= <%=jsCommand%>>Question <%=count %></a>
				</form>
				<%
			}else{
				String formName = "AddFreeResponse" + count;
				String jsCommand = "javascript:document.AddFreeResponse" + count + ".submit()";
				%>
				<form name=<%=formName%> method="POST" action="FreeResponse.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
					<input type="hidden" name="questionType" value=<%=p.getType()%>>
					<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
					<input type="hidden" name="indexInList" value="<%=count%>">
					<a href= <%=jsCommand%>>Question <%=count %></a>
				</form>
				<%
			}
			String formName = "DeleteQuestion" + count;
			String jsCommand = "javascript:document.DeleteQuestion" + count + ".submit()";
			%>
			<form name=<%=formName%> method="POST" action="CreateQuiz.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
					<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
					<input type="hidden" name="indexToDelete" value="<%=count%>">
					<a href= <%=jsCommand%>>Delete Question <%=count %></a>
			</form>
			<%
			count++;
		}
	}
%>
<%
	ArrayList<Integer> probWithNoSol = new ArrayList<Integer>();
	for(int i= 0; i< questions.size(); i++){
		int numSolExist = questions.get(i).getAllSol().size();
		if(numSolExist==0 || numSolExist<questions.get(i).getsolNum()){
			probWithNoSol.add(i+1);
		}
	}
	if(probWithNoSol.size()!=0){
		%>
		<p> Not enough solution provided in the following questions:
		<%
		count=1;
		for(int index:probWithNoSol){
			if(questions.get(index-1).getType().equals("MC")){
				String formName = "AddMultipleChoices" + count+"A";
				String jsCommand = "javascript:document.AddMultipleChoices" + count +"A"+ ".submit()";
				%>
				<form name=<%=formName%> method="POST" action="MultipleChoice.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
					<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
					<input type="hidden" name="indexInList" value="<%=index%>">
					<a href= <%=jsCommand%>>Question <%=index %></a>
				</form>
				<%
			}
			else if(questions.get(index-1).getType().equals("MATCH")){
				String formName = "AddMatching" + count +"A";
				String jsCommand = "javascript:document.AddMatching" + count +"A"+ ".submit()";
				%>
				<form name=<%=formName%> method="POST" action="Matching.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
					<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
					<input type="hidden" name="indexInList" value="<%=index%>">
					<a href= <%=jsCommand%>>Question <%=index %></a>
				</form>
				<%
			}else{
				String formName = "AddFreeResponse" + count+"A";
				String jsCommand = "javascript:document.AddFreeResponse" + count +"A"+ ".submit()";
				%>
				<form name=<%=formName%> method="POST" action="FreeResponse.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
					<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
					<input type="hidden" name="indexInList" value="<%=index%>">
					<a href= <%=jsCommand%>>Question <%=index %></a>
				</form>
				<%
			}
			count++;
		}
		%>
		</p>
		<%
	}
	if(questions.size()>0 && QuizName.length()>0 && QuizName.trim().length()>0 && probWithNoSol.size()==0){
		%>	
		<form name="AddQuiz" method="POST" action="AddQuizToDB.jsp">
		<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
		<input type="hidden" name="Description" value="<%=Description%>">
		<input type="hidden" name="Tags" value="<%=Tags%>">
		<input type="hidden" name="Spec" value="<%=Spec%>">
		<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
		<a href="javascript:document.AddQuiz.submit()">Create</a>
		</form>
		<%
	}
%>
<form name="CancelQuiz" method="POST" action="AddQuizToDB.jsp">
	<input type="hidden" name="Discard" value="Discard">
	<input type="hidden" name="QuestionIDList" value="<%=QuestionIDList%>">
	 <a href="javascript:document.CancelQuiz.submit()">Discard</a>
</form>
</div>
</div>
</div>
</body>
</html>
