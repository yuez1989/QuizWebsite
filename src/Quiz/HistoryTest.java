package Quiz;

import java.sql.SQLException;

public class HistoryTest {
	public static void main(String[] arg) throws SQLException{
		 QuizSystem.getQuizSystem();
//		 String quizID = "xinhuiwu2015-11-18 15:17:30";
//		 String usrID = "xinhuiwu";
//		 String playmode = "Regular";
//		 String starttime ="2015-11-18 15:05:21";
//		 String endtime = "2015-11-18 15:15:21";
//		long span = 600000;
//		double score = 4;
//		History h1 = new History( quizID,  usrID,  playmode,  starttime, endtime,  span,  score, "dope", 4);
//		h1.saveToDB();
//		
//		quizID = "xinhuiwu2015-11-18 15:17:30";
//		usrID = "xinhuiwu";
//		playmode = "Regular";
//		starttime ="2015-11-18 15:15:21";
//		endtime = "2015-11-18 15:25:21";
//		span = 600000;
//		score = 4;
//		History h2 = new History( quizID,  usrID,  playmode,  starttime, endtime,  span,  score, "nice", 3);
//		h2.saveToDB();
//		
//		
//		quizID = "xinhuiwu2015-11-18 16:19:13";
//		usrID = "xiaotihu";
//		playmode = "Regular";
//		starttime ="2015-11-18 17:05:21";
//		endtime = "2015-11-18 17:15:21";
//		span = 600000;
//		score = 4;
//		History h3 = new History( quizID,  usrID,  playmode,  starttime, endtime,  span,  score, "sucks", 1);
//		h3.saveToDB();
//		
//		quizID = "xinhuiwu2015-11-18 16:19:13";
//		usrID = "yuezhang";
//		playmode = "Regular";
//		starttime ="2015-11-18 17:05:21";
//		endtime = "2015-11-18 17:15:21";
//		span = 600000;
//		score = 4;
//		History h4 = new History( quizID,  usrID,  playmode,  starttime, endtime,  span,  score, "not bad", 4);
//		h4.saveToDB();
		History.removeByQuizID("xinhuiwu2015-11-18 16:19:13");
	}
}
