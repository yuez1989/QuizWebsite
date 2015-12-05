<%@ page import="Quiz.*,java.util.*, java.text.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="Header.jsp" />

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
<script src='BackgroundStatic.js'></script>
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

	String quizID = request.getParameter("quizID");
	if (quizID == null)
		response.setHeader("Refresh", "0;UserHomePage.jsp");
	Quiz quiz = null;
	ArrayList<String> searchRes = Utilities.searchQuizzes(quizID);
	if (searchRes.size() == 0) { // if there is NO search result
		quizID = "xinhuiwu2015-11-18 16:19:13";
		out.println(
				"<h3>The quiz you searched does not exist. We will redirect you to the list of quizzes we have...</h3>");
		response.setHeader("Refresh", "2;Quizzes.jsp");
	} else { // if there is search result
		quizID = searchRes.get(0);
		quiz = new Quiz(quizID);
		String startTime = QuizSystem.generateCurrentTime();
		if (quiz.isRandom()) {
			quiz.shuffleQuestion();
		}
%>
<title>Quizzzz Messages</title>

</head>
<body>
	<div class="body-section">
		<div class='body-part-wrapper col-md-2'></div>
		<div class='body-part-wrapper col-md-8'>
			<%
				if (quiz.isMultiplePages()) {
						if (session.getAttribute(request.getParameter("quizID") + "questions") != null) {
							//prevent from resuming
			%>
			<div class='body-part'>
				<span class='normal-option'>SORRY, YOU CANNOT TAKE ONE QUIZ
					SIMULTANEOUSLY.</span><br> <span>Click "Clear Paused Quiz" to
					clear quiz taking sessions.</span><br>
				<a href="Quizzes.jsp" class='dangerous-option'>Clear Paused
					Quiz And Go Back to Quiz List</a>
				<div>
					<%
						} else {
									if (quiz.isRandom()) {
										quiz.shuffleQuestion();
									}

									session.setAttribute(request.getParameter("quizID") + "questions", quiz.getQuestions());
									session.setAttribute(request.getParameter("quizID") + "startTime",
											QuizSystem.generateCurrentTime());
									session.setAttribute(request.getParameter("quizID") + "grade", "0");
									if (quiz.isImmediateCorrection()) {
										session.setAttribute(request.getParameter("quizID") + "correction", "true");
									} else {
										session.setAttribute(request.getParameter("quizID") + "correction", "false");
									}
									response.setHeader("Refresh", "0;url=QuizMultiPage.jsp?quizID=" + quiz.getQuizID()
											+ "&quizName=" + quiz.getQuizName());
								}
							} else { // if is not multiple page
								if (quiz.isRandom()) {
									quiz.shuffleQuestion();
								}
								if (session.getAttribute(request.getParameter("quizID") + "questions") != null) {
									//prevent from resuming
					%>
					<div class='body-part'>
						<span class='normal-option'>SORRY, YOU CANNOT TAKE ONE QUIZ
							SIMULTANEOUSLY.</span><br> <span>Click "Clear Paused Quiz"
							to clear quiz taking sessions.</span><br>
						<a href="Quizzes.jsp" class='dangerous-option'>Clear Paused
							Quiz</a>
						<div>
							<%
								} else {
											//start a new quiz in one page
											session.setAttribute(request.getParameter("quizID") + "questions", quiz.getQuestions());
							%>
							<div class='body-part'>
								<form class='total_form' action='QuizScore.jsp' method='post'>
									<%
												ArrayList<Question> questions = quiz.getQuestions();
												int count = 0;
												for (Question q : questions) {
													count++;
													out.print("<div class = question" + count + ">");
													out.print("<h3>Question " + count + "<h3>");
													if (Question.TYPE_FREERESPONCE.equals(q.getType())
															|| Question.TYPE_PICTURERESPONCE.equals(q.getType())) {
														out.print("<p class=\'question_description\'>" + q.getText() + "</p>");
														if (!q.getPic().isEmpty())
															out.print("<img src=\'" + q.getPic() + "\' class=\'question_image\'>");
														for (int i = 1; i <= q.getsolNum(); i++) {
															out.print("<input type=\'text\' name=\'q" + count + "ans" + i
																	+ "\' placeholder=\'enter here\'>");
														}
													} else if (Question.TYPE_MULTIPLECHOICE.equals(q.getType())) {
														out.print("<p class=\'question_description\'>" + q.getText() + "</p>");
														ArrayList<String> options = q.parseOption();
														int optcnt = 0;
														if (q.getsolNum() > 1) {
															for (String opt : options) {
																optcnt++;
																char chopt = (char) ('A' + optcnt - 1);
																out.print("<input type=\'checkbox\' name = \'q" + count + "ans" + optcnt
																		+ "\' value = \'true\' >" + opt + "</input>");

															}
														} else {
															for (String opt : options) {
																optcnt++;
																char chopt = (char) ('A' + optcnt - 1);
																if (optcnt == 1) {
																	out.print("<input type=\'radio\' name = \'q" + count + "ans1\' value = \'"
																			+ chopt + "\' checked=\'checked\'>" + opt + "</input>");
																} else {
																	out.print("<input type=\'radio\' name = \'q" + count + "ans1\' value = \'"
																			+ chopt + "\'>" + opt + "</input>");
																}
															}

														}
													} else if (Question.TYPE_MATCHING.equals(q.getType())) {
														out.print("<p class=\'question_description\'>" + q.getText() + "</p>");
														ArrayList<String> optionsleft = q.parseOptionleft();
														ArrayList<String> optionsright = q.parseOptionright();
														int optcnt = 1;
														for (String opt : optionsleft) {
															/* 							<select>
																						  <option value="volvo">Volvo</option>
																						  <option value="saab">Saab</option>
																						  <option value="opel">Opel</option>
																						  <option value="audi">Audi</option>
																						</select> */
															out.println("<p>" + opt);
															out.print("<select name = \'q" + count + "ans" + optcnt + "\'>");
															char selectvalue = 'A';
															for (String optright : optionsright) {
																out.println("<option value=\'" + Character.toString(selectvalue) + "\'>"
																		+ optright + "</option>");
																selectvalue = (char) (selectvalue + 1);
															}
															out.print("</select></p>");
															//out.print("<input type=\'text\' name = \'q"+count+"ans"+optcnt+"\'></input>");
															//out.print("<p>"+opt+"</p>");
															//out.print("<p>"+optionsright.get(optcnt-1)+"</p>");
															optcnt++;
														}
													} else if (Question.TYPE_BLANKFILL.equals(q.getType())) {
														String text = "-" + q.getText() + "-";
														String[] contents = text.split("<blank>");
														//contents[contents.length-1] = contents[contents.length-1].substring(0, contents[contents.length-1].length()-1);
														out.print("<p>");
														for (int i = 1; i < contents.length; i++) {
															if (i == 1) {
																out.print(contents[i - 1].substring(1));
															} else {
																out.print(contents[i - 1]);

															}
															out.print("<input type = \'text\' name =\'q" + count + "ans" + i + "\'>");
														}

														out.print(contents[contents.length - 1].substring(0,
																contents[contents.length - 1].length() - 1));
														out.print("</p>");
													}
													out.print("</div>");
												}
								%>
								
							</div>
							<div class='body-part'>
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
								<br>
								<input type="hidden" name="quizID" value="<%=quiz.getQuizID()%>">
								<input type="hidden" name="quizName"
									value="<%=quiz.getQuizName()%>"> <input type="hidden"
									name="startTime" value="<%=QuizSystem.generateCurrentTime()%>">
								<input type="submit" class='total_submit' value='submit now' />
								</form><br><br>
								<form class='cancel_form' action="QuizCancel.jsp" method="get">
									<input type="hidden" name="quizID"
										value="<%=quiz.getQuizID()%>"> <input type="submit"
										class='total_cancel' value='cancel'>
								</form>
							</div>
							<%
								}
									}
								}
							%>
						
</body>
</html>