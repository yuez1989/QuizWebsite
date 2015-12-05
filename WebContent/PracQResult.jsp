<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript"
	src="bg-switcher/Source/js/jquery.bcat.bgswitcher.js"></script>
<title>Quizzzz:Result</title>
</head>
<body>
	<div class="body-section">
		<%
			Question q = new Question(request.getParameter("proID"));
			HashMap<String, Integer> correct_map = (HashMap<String, Integer>) session.getAttribute("correct_map");
			double questiongrade = 0;

			if (Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType())
					|| Question.TYPE_BLANKFILL.equals(q.getType())) {
				ArrayList<String> ans = new ArrayList<String>();
				for (int i = 1; i <= q.getsolNum(); i++) {
					ans.add(request.getParameter("qans" + i));
				}
				questiongrade = q.grade(ans);
			} else if (Question.TYPE_MULTIPLECHOICE.equals(q.getType())) {
				ArrayList<String> ans = new ArrayList<String>();
				if (q.getsolNum() > 1) {
					int N = q.parseOption().size();
					char A = 'A';
					for (int i = 1; i <= N; i++) {
						System.out.println(request.getParameter("qans" + i));
						if ("true".equals(request.getParameter("qans" + i)))
							ans.add(Character.toString((char) (A + i - 1)));
					}

				} else {
					char ch = request.getParameter("qans1").charAt(0);
					ans.add(Character.toString(ch));
				}

				questiongrade = q.grade(ans);

			} else if (Question.TYPE_MATCHING.equals(q.getType())) {
				ArrayList<String> optionsleft = q.parseOptionleft();
				ArrayList<String> ans = new ArrayList<String>();
				int optcnt = 1;
				for (String opt : optionsleft) {
					if (!request.getParameter("qans" + optcnt).isEmpty()) {
						ans.add(request.getParameter("qans" + optcnt));
						optcnt++;
					}
				}
				questiongrade = q.grade(ans);
			}

			if (questiongrade >= 1) {
				if (correct_map.get(q.getProbID()) < 2) {
					correct_map.put(q.getProbID(), correct_map.get(q.getProbID()) + 1);
				} else {
					correct_map.remove(q.getProbID());
				}
			} else {
				correct_map.put(q.getProbID(), 0);
			}

			if (correct_map.isEmpty()) {
				// went through practice mode for this quiz!
				//RequestDispatcher dispatch = request.getRequestDispatcher("PracticeSuccess.jsp");
				//dispatch.forward(request, response);
				response.setHeader("Refresh", "1;url=PracticeSuccess.jsp");

			} else {
				//RequestDispatcher dispatch = request.getRequestDispatcher("QuizPractice.jsp");
				//dispatch.forward(request, response);
				session.setAttribute("correct_map", correct_map);
				response.setHeader("Refresh", "1;url=QuizPractice.jsp");
			}

			if (questiongrade >= 1) {
		%>
		<h3>Yes! You are correct!</h3>

		<%
			} else if (questiongrade == 0) {
		%>
		<h3>Sorry. You are wrong.</h3>
		<div>
			<p>The correct answer should be:</p>
			<span><%=q.getSol()%></span>
		</div>
		<%
			}
		%>
	</div>
</body>
</html>
