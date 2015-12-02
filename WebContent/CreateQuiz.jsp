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
<%	
	String[] result;
	String QuizID = "";
	String QuizName = "";
	String Description = "";
	String Tags = "";
	String Spec = "";
	String probCancel= "";
	
	ArrayList<Question> questions =  new ArrayList<Question>();	
	result = request.getParameterValues("QuizID");
	if (result != null && result.length != 0) {
		QuizID = result[0];
	}
	Quiz myquiz=null;
	if(QuizID!=null &&QuizID.length()>0){
		request.getSession().setAttribute("OldQuizID", QuizID);
		myquiz = new Quiz(QuizID);
	}
	if(myquiz!= null){
		questions = myquiz.getQuestions();
		request.getSession().setAttribute("QuestionList" , questions);
		QuizName = myquiz.getQuizName();
		Description = myquiz.getDescription();
		for(String s:myquiz.getTags()){
			Tags += s+" ";
		}
		Tags = Tags.substring(0,Tags.length()-1);
		Spec = myquiz.getSpec();
		myquiz = null;
		QuizID = "";
	}else{
		if(request.getSession().getAttribute("QuestionList") == null){
			request.getSession().setAttribute("QuestionList" , questions);	
		}else{
			questions = (ArrayList<Question>) request.getSession().getAttribute("QuestionList");
		}
		result = request.getParameterValues("Quiz Name");
		if (result != null && result.length != 0) {
			QuizName = result[0];
		}
		
		result = request.getParameterValues("Description");
		if (result != null && result.length != 0) {
			Description = result[0];
		}
		

		result = request.getParameterValues("Tags");
		if (result != null && result.length != 0) {
			Tags = result[0];
		}
		
		result = request.getParameterValues("Spec");
		if (result != null && result.length != 0) {
			Spec = result[0];
		}
		result = request.getParameterValues("QuestionCancelled");
		if (result != null && result.length != 0) {
			probCancel = result[0];
		}
	}
	
%>


<%
if(!probCancel.equals("CancelQuestion")){
	String userID = (String)session.getAttribute("user");
	result = request.getParameterValues("question"); 
	String questionText ="";
	if (result != null && result.length != 0) {
		questionText = result[0];
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
	
	int count =1;
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
	for(int i = 0; i<solutions.size();i++){
		for(int j = 0; j<solutions.get(i).size();j++){
			if(solutions.get(i).get(j).equals("")){
				solutions.get(i).remove(j);
			}
		}
		if(solutions.get(i).size()==0){
			solutions.remove(i);
			i--;
		}
	}

	result = request.getParameterValues("order"); 
	int order = 0;
	if (result != null && result.length != 0) {
		if(result[0].equals("Y")){
			order=1;
		}
	}
	String QuesType="";
	result = request.getParameterValues("questionType"); 
	if (result != null && result.length != 0) {
		QuesType = result[0];
	} 
	
	Question p = null;
	if(QuesType.equals("MC")){
		count =1;
		String choice = "";
		while((choice = request.getParameter("Choice "+Character.toString ((char) (count+64))))!=null){
			System.out.println(choice);
			if(!choice.equals("")){
				questionText +="<option>"+choice+"</option>";
			}
			count++;
		}
		p = new Question(questionText, pictureUrl, solutions,time, userID,order, "MC");
	}
	if(QuesType.equals("MATCH")){
		count =1;
		String choice = "";
		while((choice = request.getParameter("Left "+count))!=null){
			System.out.println(choice);
			if(!choice.equals("")){
				questionText +="<option_left>"+choice+"</option_left>";
			}
			count++;
		}
		count =1;
		choice = "";
		while((choice = request.getParameter("Right "+Character.toString ((char) (count+64))))!=null){
			System.out.println(choice);
			if(!choice.equals("")){
				questionText +="<option_right>"+choice+"</option_right>";
			}
			count++;
		}
		p = new Question(questionText, pictureUrl, solutions,time, userID,order, "MATCH");
	}else if(QuesType!=null){
		if(!QuesType.equals("")){
			p = new Question(questionText, pictureUrl, solutions,time, userID,order, QuesType);
		}
	}
	String index = "";
	result = request.getParameterValues("indexInList");
	if (result != null && result.length != 0) {
		index = result[0];
		System.out.println("This is question #"+index);
	}
	if(p!=null){
		if(index==""){
			questions.add(p);
		}else{
			System.out.println(p.getAllSol());
			questions.set(Integer.parseInt(index)-1,p);
		}
		request.getSession().setAttribute("QuestionList" , questions);
	}
}
%>

<form name="AddQuestion" method="POST" action="CreateQuestion.jsp">
Please enter Quiz name:
<INPUT TYPE="TEXT" NAME="Quiz Name" value="<%=QuizName%>"><BR>
Please enter Quiz description:
<INPUT TYPE="TEXT" NAME="Description" value="<%=Description%>"><BR>
Please enter Quiz tags, separate by space:
<INPUT TYPE="TEXT" NAME="Tags" value="<%=Tags%>"><BR>
Please enter Quiz option:
If you want question appear in random order, enter "R".
If you want question appear on multiple pages, enter "M".
If you want provide immediate correction, enter "I".
You can have multiple options, order does not matter.
<INPUT TYPE="TEXT" NAME="Spec" value="<%=Spec%>"><BR>
<a href="javascript:document.AddQuestion.submit()">Add Problem</a>
</form>

<%	
	String questionToBeRemoved = "";
	result = request.getParameterValues("indexToDelete");
	if (result != null && result.length != 0) {
		questionToBeRemoved = result[0];
	}
	if(questionToBeRemoved!=null){
		if(questionToBeRemoved!=""){
			int qindex = Integer.parseInt(questionToBeRemoved);
			if(qindex>=1 && qindex<=questions.size()){
				questions.remove(qindex-1);
			}
		}
	}
	
%>
Current questions in the Quiz

<%
	int count = 1;
	if(questions != null){
		for(Question p:questions){
			//session.setAttribute("Question "+Integer.toString(count), p);
			if(p.getType().equals("MC")){
				String formName = "AddMultipleChoices" + count;
				String jsCommand = "javascript:document.AddMultipleChoices" + count + ".submit()";
				%>
				<form name=<%=formName%> method="POST" action="MultipleChoice.jsp">
					<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
					<input type="hidden" name="Description" value="<%=Description%>">
					<input type="hidden" name="Tags" value="<%=Tags%>">
					<input type="hidden" name="Spec" value="<%=Spec%>">
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
					<input type="hidden" name="indexToDelete" value="<%=count%>">
					<a href= <%=jsCommand%>>Delete Question <%=count %></a>
			</form>
			<%
			count++;
		}
	}
%>

<form name="AddQuiz" method="POST" action="AddQuizToDB.jsp">
	<input type="hidden" name="Quiz Name" value="<%=QuizName%>">
	<input type="hidden" name="Description" value="<%=Description%>">
	<input type="hidden" name="Tags" value="<%=Tags%>">
	<input type="hidden" name="Spec" value="<%=Spec%>">
	 <a href="javascript:document.AddQuiz.submit()">Create</a>
</form>
<form name="CancelQuiz" method="POST" action="UserHomePage.jsp">
	 <a href="javascript:document.CancelQuiz.submit()">Discard</a>
</form>
</body>
</html>
