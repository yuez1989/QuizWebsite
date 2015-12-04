<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search User Result</title>
</head>
<body>

<%
String person = request.getParameter("person");
if(person == null){
	out.print("<h3>No such user exists.</h3>");
}else{
	ArrayList<String> personList = Utilities.searchAccounts(person);
	if(personList.isEmpty()){
		out.print("<h3>No such user exists.</h3>");
	}else{

		out.println("<ul>");		
		for(int i=0; i<personList.size(); i++){
		%>
		<li><a href = 'Person.jsp?person=<%=personList.get(i) %>'><%=personList.get(i) %></a></li>
		<%
		}
		out.println("</ul>");
	}
}

%>
<a href = 'UserHomePage.jsp'>return</a>




</body>
</html>