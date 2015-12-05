<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="Quiz.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
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
<script type="text/javascript"
	src="bg-switcher/Source/js/jquery.bcat.bgswitcher.js"></script>
<title>Quizzz: Multi-Page Question Result</title>
</head>
<body style="background-image:url('images/aurora.jpeg')!important;background-attachment:fixed;background-size:cover;">
	<div class="body-section">
		<div class='body-part-wrapper col-md-2'></div>
		<div class='body-part-wrapper col-md-8'>
			<div class='body-part'>
				<%
					String quizID = request.getParameter("quizID");
					String quizName = request.getParameter("quizName");
					ArrayList<Question> questions = (ArrayList<Question>) session.getAttribute(quizID + "questions");
					String strgrade = (String) session.getAttribute(quizID + "grade");

					if (quizID == null || quizName == null || questions == null || strgrade == null
							|| session.getAttribute("user") == null) {
						response.setHeader("Refresh", "0;UserHomePage.jsp");
					} else {

						double pregrade = Double.parseDouble((String) session.getAttribute(quizID + "grade"));

						Question q = questions.get(questions.size() - 1);

						double qgrade = 0;
						if (Question.TYPE_FREERESPONCE.equals(q.getType()) || Question.TYPE_PICTURERESPONCE.equals(q.getType())
								|| Question.TYPE_BLANKFILL.equals(q.getType())) {
							ArrayList<String> ans = new ArrayList<String>();
							for (int i = 1; i <= q.getsolNum(); i++) {
								ans.add(request.getParameter("qans" + i));
							}
							qgrade = q.grade(ans);
						} else if (Question.TYPE_MULTIPLECHOICE.equals(q.getType())) {
							ArrayList<String> ans = new ArrayList<String>();
							if (q.getsolNum() > 1) {
								int N = q.parseOption().size();
								for (int i = 1; i <= N; i++) {
									char A = 'A';
									if ("true".equals(request.getParameter("qans" + i))) {
										ans.add(Character.toString((char) (A + i - 1)));
									}
								}

							} else {
								char ch = request.getParameter("qans1").charAt(0);
								ans.add(Character.toString(ch));
							}

							qgrade = q.grade(ans);
						} else if (Question.TYPE_MATCHING.equals(q.getType())) {
							ArrayList<String> optionsleft = q.parseOptionleft();
							ArrayList<String> ans = new ArrayList<String>();
							int optcnt = 1;
							for (String opt : optionsleft) {
								if (!request.getParameter("qans" + optcnt).isEmpty()) {
									char ch = (request.getParameter("qans" + optcnt).charAt(0));
									ans.add(Character.toString(ch));
									optcnt++;
								} else {
									ans.add("-");
								}
							}
							qgrade = q.grade(ans);
						}
						pregrade = pregrade + qgrade;
						questions.remove(questions.size() - 1);

						if (questions.isEmpty()) {

							String startTime = (String) session.getAttribute(quizID + "startTime");
							String endTime = QuizSystem.generateCurrentTime();

							char ratch = request.getParameter("rating").charAt(0);

							int rating = 5;

							switch (ratch) {
							case '1':
								rating = 1;
								break;
							case '2':
								rating = 2;
								break;
							case '3':
								rating = 3;
								break;
							case '4':
								rating = 4;
								break;
							}

							//warning this user should be user id not object
							History hst = new History(quizID, (String) session.getAttribute("user"), "Regular", startTime,
									endTime, pregrade, request.getParameter("review"), rating);

							hst.saveToDB();

							session.removeAttribute(quizID + "questions");
							session.removeAttribute(quizID + "grade");
							session.removeAttribute(quizID + "startTime");

							String usrID = (String) session.getAttribute("user");

							int quizPlayed = Utilities.getQuizNumberPlayed(usrID);
							if (quizPlayed == 1) {
								if (!Utilities.hasAchievement("Quiz Taker", usrID)) {
									AchievementRecord achRec = new AchievementRecord(usrID, "Quiz Taker");
									achRec.saveToDB();
									out.print("<img src=\'" + Utilities.getImagePathOfAch("Quiz Taker")
											+ "\' style=\'width:250px;height:150px;\'>");
									out.println(
											"<p><b>Congrats! You have done your first quiz in Quizzzz, you now have a new Achievement: Quiz Taker</b></p>");
								}
							} else if (quizPlayed == 5) {
								if (!Utilities.hasAchievement("Kindergarten", usrID)) {
									AchievementRecord achRec = new AchievementRecord(usrID, "Kindergarten");
									achRec.saveToDB();
									out.print("<img src=\'" + Utilities.getImagePathOfAch("Kindergarten")
											+ "\' style=\'width:250px;height:150px;\'>");
									out.println(
											"<p><b>Congrats! You have just finished your fifth quiz, you have just won a new Achievement: Kindergarten</b></p>");
								}
							} else if (quizPlayed == 10) {
								if (!Utilities.hasAchievement("Primary School", usrID)) {

									AchievementRecord achRec = new AchievementRecord(usrID, "Primary School");
									achRec.saveToDB();
									out.println(
											"<p>Congrats! You have just finished your tenth quiz, you have just won a new Achievement: Primary School</p>");
								}
							} else if (quizPlayed == 30) {
								if (!Utilities.hasAchievement("Middle School", usrID)) {

									AchievementRecord achRec = new AchievementRecord(usrID, "Middle School");
									achRec.saveToDB();
									out.print("<img src=\'" + Utilities.getImagePathOfAch("Middle School")
											+ "\' style=\'width:250px;height:150px;\'>");
									out.println(
											"<p><b>Nice! You have just won the Achievement of Middle School, you have finished 30 quizzes!</b></p>");
								}
							} else if (quizPlayed == 50) {
								if (!Utilities.hasAchievement("High School", usrID)) {

									AchievementRecord achRec = new AchievementRecord(usrID, "High School");
									achRec.saveToDB();
									out.print("<img src=\'" + Utilities.getImagePathOfAch("High School")
											+ "\' style=\'width:250px;height:150px;\'>");
									out.println(
											"<p><b>Amazing! 50 quizzes have been taken by you, 50 more to go to graduate from Quizzzz University. Your new Achievement: High School</b></p>");
								}
							} else if (quizPlayed == 100) {
								if (!Utilities.hasAchievement("Quizzzz University Alumni", usrID)) {

									AchievementRecord achRec = new AchievementRecord(usrID, "Quizzzz University Alumni");
									achRec.saveToDB();
									out.print("<img src=\'" + Utilities.getImagePathOfAch("Quizzzz University Alumni")
											+ "\' style=\'width:250px;height:150px;\'>");
									out.println(
											"<p><b>You made it! Your new Achievement: Quizzzz University Alumni! You have graduated from Quizzzz University by finishing 100 quizzes</b></p>");
								}
							}
				%>

				<%
					double hiScore = Double.parseDouble(Utilities.getHighestScoreOfQuiz(quizID));
							if (pregrade >= hiScore && !Utilities.hasAchievement("I am the Greatest", usrID)) {
								AchievementRecord achRec = new AchievementRecord(usrID, "I am the Greatest");
								achRec.saveToDB();
								out.print("<img src=\'" + Utilities.getImagePathOfAch("I am the Greatest")
										+ "\' style=\'width:250px;height:150px;\'>");
								out.println(
										"<p><b>Guess What! You just broke the record of this quiz! We give you the Achievement of \"I am the Greatest\" as reward.</b></p>");
							}
				%>



				<h3>Congratulations!</h3>
				<h3>
					You get
					<%=new DecimalFormat("#0.00").format(pregrade).toString()%>
					in
					<%=quizName%></h3>



				<p>Quiz Statisics</p>
				<ul>
					<li>Highest Score: <%=Utilities.getHighestScoreOfQuiz(quizID)%></li>
					<li>Average Score: <%=Utilities.getQuizAverageScore(quizID)%></li>
					<li>Play Times:You have played: <%=Utilities.getPlayTimesOfQuiz(quizID)%>
						times
					</li>
				</ul>

				<p>
					Toppest Records for
					<%=quizName%>:
				</p>
				<ul>
					<%
						ArrayList<History> highrecords = Utilities.getHighRecordsOfQuiz(quizID);
								int countOverAll = 0;
								for (History rec : highrecords) {
									countOverAll++;
									String formname = "AccessPerson" + rec.getUsrID() + countOverAll;
									String formsubmit = "javascript:document." + formname + ".submit()";
					%>
					<form name=<%=formname%> method="POST" action="Person.jsp">
						<input type="hidden" name="person" value="<%=rec.getUsrID()%>">
						<p>
							<a href=<%=formsubmit%>> <%=rec.getUsrID()%></a> played this quiz
							at
							<%=rec.getEndTime()%>
							and got score of
							<%=rec.getScore()%></p>
					</form>
					<%
						}
					%>
				</ul>

				<p>
					<a href='QuizHomePage.jsp?quizID=<%=quizID%>'>QuizHomePage</a>
				</p>
				<p>TODO: User Home Page</p>
				<p>TODO: Other quizzes</p>

				<form name='challengeForm' action="MsgWrite.jsp" method="post">
					<input type="hidden" name="quizID" value="<%=quizID%>"> <a
						href="javascript:document.challengeForm.submit()">Challenge
						your friend!</a>
				</form>

				<%
					} else {
							if ("true".equals(session.getAttribute(quizID + "correction"))) {
								if (qgrade >= 1)
									out.print("<h3>Congrats, it's correct!</h3>");
								else if (qgrade == 0) {
									out.print("<h3>Sorry, you are wrong</h3>");
									out.print("<p>The answer should be " + q.getSol() + " </p>");
								} else {
									out.println("<h3>Partially Correct!</h3>");
									out.print("<p>The answer should be " + q.getSol() + " </p>");
								}
								session.setAttribute(quizID + "questions", questions);
								session.setAttribute(quizID + "grade", Double.toString(pregrade));
								response.setHeader("Refresh",
										"2;url=QuizMultiPage.jsp?quizID=" + quizID + "&quizName=" + quizName);

							} else {
								response.setHeader("Refresh",
										"0;url=QuizMultiPage.jsp?quizID=" + quizID + "&quizName=" + quizName);
							}
						}
					}
				%>
				<div class='body-part-wrapper col-md-2'></div>
			</div>
		</div>
	</div>
</body>
</html>
