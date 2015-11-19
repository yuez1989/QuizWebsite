package Quiz;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class Utilities {

	static DataBase db = QuizSystem.db;

	public Utilities(){

	}

	/**
	 * Get the top ten scored history items for a specific quiz
	 * @param QuizID
	 * @return 
	 */
	public static ArrayList<History> getHighScoresOfQuiz(String QuizID) throws SQLException{
		ArrayList<History> highScores = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+QuizID+"\" ORDER BY score DESC;";
		ResultSet rs= db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		ArrayList<String> uids = new ArrayList<String>();
		ArrayList<String> endtimes = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
			uids.add(rs.getString("usrID"));
			endtimes.add(rs.getString("end"));
		}
		for(int i = 0; i<qids.size();i++){
			History hist = new History(qids.get(i),uids.get(i), endtimes.get(i));
			
			highScores.add(hist);
		}
		return highScores;
	}

	public static ArrayList<History> getHighScoresOfUser(String usrID) throws SQLException{
		ArrayList<History> highScores = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE usrID = "+"\""+usrID+"\" ORDER BY score DESC limit 1;";
		ResultSet rs= db.executeQuery(command);
		
		ArrayList<String> qids = new ArrayList<String>();
		ArrayList<String> endtimes = new ArrayList<String>();
		
		while(rs.next()){
			qids.add(rs.getString("quizID"));
			endtimes.add(rs.getString("end"));
		}
		
		for(int i = 0; i< qids.size();i++){
			History hist = new History(qids.get(i),usrID,endtimes.get(i));
			highScores.add(hist);
		}	
		
		return highScores;
	}


	
	/**
	 * Get recent activities from history for every friend of
	 * a specific user 
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentFriendActivities(String usrID) throws SQLException{
		ArrayList<History> friendAct = new ArrayList<History>();
		ArrayList<String> friendList = new ArrayList<String>();
		try {
			friendList = getFriendList(usrID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for(String frdID : friendList){
			ArrayList<History> act = getRecentActivitiesOfUser(frdID);
			friendAct.addAll(act);
		}
		return friendAct;		
	}

	/**
	 * Get the friend list of a specific user
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<String> getFriendList(String usrID) throws SQLException{
		ArrayList<String> friendIDs = new ArrayList<String>();
		String command1 = "SELECT * FROM Friends WHERE usr1ID = "+"\""+usrID+"\";";
		ResultSet rs1= db.executeQuery(command1);
		while(rs1.next()){
			String frdID = rs1.getString("usr2ID");
			friendIDs.add(frdID);
		}
		String command2 = "SELECT * FROM Friends WHERE usr2ID = "+"\""+usrID+"\";";
		ResultSet rs2= db.executeQuery(command2);
		while(rs2.next()){
			String frdID = rs2.getString("usr2ID");
			friendIDs.add(frdID);
		}
		return friendIDs;
	}

	/**
	 * 
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentActivitiesOfUser(String usrID) throws SQLException{
		ArrayList<History> recentActs = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE usrID = "+"\""+usrID+"\";";
		ResultSet rs = db.executeQuery(command);
		while(rs.next()){
			String quizID = rs.getString("quizID");
			String end = rs.getString("end");
			History hist = new History(quizID, usrID, end);
			recentActs.add(hist);		
		}
		return recentActs;
	}

	public static ArrayList<History> getRecentScoresOfUser(String usrID) throws SQLException{
		ArrayList<History> recentScores = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE usrID = "+"\""+usrID+"\" ORDER BY end DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		ArrayList<String> endtimes = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
			endtimes.add(rs.getString("end"));	
		}
		for(int i = 0; i<qids.size();i++){
			History hist = new History(qids.get(i), usrID , endtimes.get(i));
			recentScores.add(hist);
		}
		return recentScores;
	}

	public static double getUserAverageScore(String usrID) throws SQLException{
		double avg = 0;
		String command = "SELECT * FROM Histories WHERE usrID = "+"\""+usrID+"\";";
		ResultSet rs = db.executeQuery(command);
		int count = 0;
		double total = 0;
		while(rs.next()){
			double score = rs.getDouble("score");
			total += score;
			count++;
		}	
		avg = total / count;
		return avg;
	}

	public static ArrayList<History> getTopPerformanceOfLastDay(String time) throws SQLException{
		ArrayList<History> recentTopPerformance = new ArrayList<History>();
		String lastDay = QuizSystem.minusDay(time);
		String command = "SELECT * FROM Histories WHERE end > "+"\""+lastDay+"\" ORDER BY end DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		ArrayList<String> uids = new ArrayList<String>();
		ArrayList<String> endtimes = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
			uids.add(rs.getString("usrID"));
			endtimes.add(rs.getString("end"));
		}
		for(int i = 0; i<qids.size();i++){
			History hist = new History(qids.get(i),uids.get(i), endtimes.get(i));
			recentTopPerformance.add(hist);
		}
		return recentTopPerformance;
	}
	
}
