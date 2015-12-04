<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search Quiz Result</title>
</head>
<body>
<%
String quizID = request.getParameter("quizID");
if(quizID == null){
	out.print("<h3>No such quiz exists.</h3>");
}else{
	ArrayList<String> quizStrList = Utilities.searchQuizzesByName(quizID);
	if(quizStrList.isEmpty()){
		out.print("<h3>No such quiz exists.</h3>");
	}else{
		
		ArrayList<String> quizIDList = new ArrayList<String>();
		ArrayList<String> quizNameList = new ArrayList<String>();

		for(String quizstr:quizStrList){
			String[] id_name = quizstr.split("##");
			quizIDList.add(id_name[0]);
			if(id_name.length == 1){
				quizNameList.add("");
			}else{
				quizNameList.add(id_name[1]);
			}
		}
		out.println("<ul>");		
		for(int i=0; i<quizIDList.size(); i++){
		%>
		<li><a href = 'QuizHomePage.jsp?quizID=<%=quizIDList.get(i) %>'><%=quizNameList.get(i) %></a></li>
		<%
		}
		out.println("</ul>");
	}
}

%>
<a href = 'UserHomePage.jsp'>return</a>
</body>
</html>