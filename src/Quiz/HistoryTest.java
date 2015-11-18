package Quiz;

import java.sql.SQLException;

public class HistoryTest {
	public static void main(String[] arg) throws SQLException{
		 QuizSystem.getQuizSystem();
		 String quizID = "xinhuiwu2015-11-18 15:17:30";
		 String usrID = "xinhuiwu";
		 String playmode = "Regular";
		 String starttime ="2015-11-18 15:05:21";
		 String endtime = "2015-11-18 15:15:21";
		long span = 600000;
		double score = 4;
		History h = new History( quizID,  usrID,  playmode,  starttime, endtime,  span,  score, "dope", 4);
		System.out.println("starting time is: "+h.start);
		h.saveToDB();
//		h.removeFromDB();
	}
}
