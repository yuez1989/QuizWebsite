<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="Header.jsp" />
<html>
<head>
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
<script src='Background.js'></script>
<script type="text/javascript"
	src="bg-switcher/Source/js/jquery.bcat.bgswitcher.js"></script>
<%
	// Identify current session
	String usrID = "default";
	usrID = (String) session.getAttribute("user");
	if (usrID == null) {
		usrID = "default";
	}
	User user = new User(usrID);

	user.info.update();
	UserInfo info = user.info;
%>
<title>Welcome to <%=request.getParameter("quizName")%></title>
</head>
<body>
	<div class="body-section">
		<div class='body-part-wrapper col-md-2'></div>
		<div class='body-part-wrapper col-md-8'>
			<div class='body-part'>
				<form class='mp_form' action="QuizMPScore.jsp" method="post">
					<%
						String quizID = request.getParameter("quizID");
						String quizName = request.getParameter("quizName");

						ArrayList<Question> questions = (ArrayList<Question>) session.getAttribute(quizID + "questions");

						if (quizID == null || quizName == null || questions == null)
							response.setHeader("Refresh", "0;UserHomePage.jsp");

						if (questions.isEmpty()) {
							out.print("<h3>Error. You are taking this quiz simultaneously</h3>");
							response.setHeader("Refresh", "0;QuizHomePage.jsp?quizID=" + quizID);
						}

						Question q = questions.get(questions.size() - 1);

						out.print("<div>");
						if (Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType())) {
							out.print("<p class=\'question_description\'>" + q.getText() + "</p>");
							if (!q.getPic().isEmpty())
								out.print("<img src=\'" + q.getPic() + "\' class=\'question_image\'>");
							for (int i = 1; i <= q.getsolNum(); i++) {
								out.print("<input type=\'text\' name=\'qans" + i + "\' placeholder=\'enter here\'>");
							}
						} else if (Question.TYPE_MULTIPLECHOICE.equals(q.getType())) {
							out.print("<p class=\'question_description\'>" + q.getText() + "</p>");
							ArrayList<String> options = q.parseOption();
							int optcnt = 0;
							if (q.getsolNum() > 1) {

								for (String opt : options) {
									optcnt++;
									char chopt = (char) ('A' + optcnt - 1);
									out.print("<input type=\'checkbox\' name = \'qans" + optcnt + "\' value = \'true\' >" + opt
											+ "</input>");

								}

							} else {
								for (String opt : options) {
									optcnt++;
									char chopt = (char) ('A' + optcnt - 1);
									if (optcnt == 1) {
										out.print("<input type=\'radio\' name = \'qans1\' value = \'" + chopt
												+ "\' checked=\'checked\'>" + opt + "</input>");
									} else {
										out.print("<input type=\'radio\' name = \'qans1\' value = \'" + chopt + "\'>" + opt
												+ "</input>");
									}
								}
							}

						} else if (Question.TYPE_MATCHING.equals(q.getType())) {
							out.print("<p class=\'question_description\'>" + q.getText() + "</p>");
							ArrayList<String> optionsleft = q.parseOptionleft();
							ArrayList<String> optionsright = q.parseOptionright();
							int optcnt = 1;
							for (String opt : optionsleft) {
								out.println("<p>" + opt);
								out.print("<select name = \'qans" + optcnt + "\'>");
								char selectvalue = 'A';
								for (String optright : optionsright) {
									out.println(
											"<option value=\'" + Character.toString(selectvalue) + "\'>" + optright + "</option>");
									selectvalue = (char) (selectvalue + 1);
								}
								out.print("</select></p>");
								optcnt++;
							}
						} else if (Question.TYPE_BLANKFILL.equals(q.getType())) {
							String text = q.getText();
							String[] contents = text.split("<blank>");
							out.print("<p>");
							for (int i = 1; i < contents.length; i++) {
								out.print(contents[i - 1]);
								out.print("<input type = \'text\' name =\'qans" + i + "\'>");
							}
							out.print(contents[contents.length - 1]);
							out.print("</p>");
						}

						if (questions.size() == 1) {
					%>
					<div id="rating_review">
						<div id="rating">
							<label>Rating</label> <label for="1star">1</label> <input
								type="radio" name="rating" value="1" id="1star"> <label
								for="2star">2</label> <input type="radio" name="rating"
								value="2" id="2star"> <label for="3star">3</label> <input
								type="radio" name="rating" value="3" id="3star"> <label
								for="4star">4</label> <input type="radio" name="rating"
								value="4" id="4star"> <label for="5star">5</label> <input
								type="radio" name="rating" value="5" id="5star"
								checked="checked">
						</div>

						<div>
							<p>
								<label for="review">Submit Review</label>
							</p>

							<textarea rows="3" cols="50" name="review" id="review"
								placeholder="Love the quiz? Add a review now!"></textarea>
						</div>
					</div>

					<%
						}
					%>
				
			</div>

			<br>
	
			<input type='hidden' name='quizID' value='<%=quizID%>'> <input
				type='hidden' name='quizName' value='<%=quizName%>'><input
				type='submit' class='question_submit' value='continue'>
			</form>
			<br>
			<div>
				<form class='cancel_form' action="QuizCancel.jsp" method="get">
					<input type="hidden" name="quizID" value="<%=quizID%>"> <input
						type="submit" class='total_cancel' value='cancel'>
				</form>
			</div>

		</div>
	</div>
	<div class='body-part-wrapper col-md-2'></div>
	</div>

</body>
</html>