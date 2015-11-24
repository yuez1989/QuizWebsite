<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="QuizWebsite.css">
<title>
	<%
		String usrID = "default";
		if (!session.isNew()) {
			usrID = (String) session.getAttribute("user");
			if (usrID == null)
				usrID = "default";
		}
		out.println(usrID);
	%>'s Homepage
</title>
</head>
<body>
<div id="header">
	<div id="personal-header">
		<p>Welcome, <%=usrID%></p>
	</div>
</div>
</body>
</html>