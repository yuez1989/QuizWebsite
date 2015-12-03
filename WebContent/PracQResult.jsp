<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Result</title>
</head>
<body>
<%
	Question q = new Question(request.getParameter("proID"));
	HashMap<String,Integer> correct_map = (HashMap<String,Integer>)session.getAttribute("correct_map");
	double questiongrade = 0;
	
if(Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType()) || Question.TYPE_BLANKFILL.equals(q.getType())){
	ArrayList<String> ans = new ArrayList<String>();
	for(int i = 1; i<= q.getsolNum();i++){
		ans.add(request.getParameter("qans"+i));
	}
	questiongrade = q.grade(ans);
}else if(Question.TYPE_MULTIPLECHOICE.equals(q.getType())){
	ArrayList<String> ans = new ArrayList<String>();
		if(q.getsolNum()>1){
			int N = q.parseOption().size();
			char A = 'A';
			for(int i = 1; i<= N; i++){
				System.out.println(request.getParameter("qans"+i));
				if("true".equals(request.getParameter("qans"+i)))
					ans.add(Character.toString((char)(A+i-1)));
			}
						
		}else{
			char ch =request.getParameter("qans1").charAt(0);
			ans.add(Character.toString(ch));
		}
		
		questiongrade = q.grade(ans);
		
}else if(Question.TYPE_MATCHING.equals(q.getType())){
	ArrayList<String> optionsleft = q.parseOptionleft();
	ArrayList<String> ans = new ArrayList<String>();
	int optcnt=1;
	for(String opt: optionsleft){
		if(!request.getParameter("qans"+optcnt).isEmpty()){
		ans.add(request.getParameter("qans"+optcnt));
		optcnt++;
		}
	}
	questiongrade = q.grade(ans);
}


if(questiongrade >= 1){
	if(correct_map.get(q.getProbID())<1){
		correct_map.put(q.getProbID(), correct_map.get(q.getProbID())+1);
	}else{
		correct_map.remove(q.getProbID());
	}
}else{
	correct_map.put(q.getProbID(), 0);
}


 if(correct_map.isEmpty()){
	// went through practice mode for this quiz!
	//RequestDispatcher dispatch = request.getRequestDispatcher("PracticeSuccess.jsp");
	//dispatch.forward(request, response);
	response.setHeader("Refresh", "1;url=PracticeSuccess.jsp");

}else{
	//RequestDispatcher dispatch = request.getRequestDispatcher("QuizPractice.jsp");
	//dispatch.forward(request, response);
	session.setAttribute("correct_map", correct_map);
	response.setHeader("Refresh", "1;url=QuizPractice.jsp");
} 

%>
<p> you get <%=questiongrade %></p>
</body>
</html>