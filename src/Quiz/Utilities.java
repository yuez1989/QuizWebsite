package Quiz;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class Utilities {

	static DataBase db = QuizSystem.getQuizSystem().db;

	// ERROR method. Cannot call it all the time. Fixed in line 9.
	public Utilities(){
		QuizSystem sys = QuizSystem.getQuizSystem();
		db = sys.db;
	}

	/**
	 * Get the top ten scored history items for a specific quiz
	 * @param QuizID
	 * @return 
	 */
	public static ArrayList<History> getHighRecordsOfQuiz(String QuizID) throws SQLException{
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
	 * @param quizID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<String> getRecentQuizReviews(String quizID) throws SQLException{
		ArrayList<String> recentReviews = new ArrayList<String>();
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+quizID+"\" ORDER BY end DESC;";
		ResultSet rs = db.executeQuery(command);
		int count = 0; 
		while(rs.next()){
			if(count == 3) break;
			count++;
			recentReviews.add(rs.getString("review"));
		}
		return recentReviews;
	}

	/**
	 * 
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentActivitiesOfQuiz(String quizID) throws SQLException{
		ArrayList<History> recentActs = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+quizID+"\" ORDER BY end DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> uids = new ArrayList<String>();
		ArrayList<String> endtimes = new ArrayList<String>();
		while(rs.next()){
			uids.add(rs.getString("usrID"));
			endtimes.add(rs.getString("end"));	
		}
		for(int i = 0; i<uids.size();i++){
			History hist = new History(quizID , uids.get(i), endtimes.get(i));
			recentActs.add(hist);
		}
		return recentActs;
	}

	/**
	 * 
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentActivitiesOfUser(String usrID) throws SQLException{
		ArrayList<History> recentActs = new ArrayList<History>();
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
			recentActs.add(hist);
		}
		return recentActs;
	}

	/**
	 * Get quizzes recently created by specific user
	 * @param usrID
	 * @return Arraylist of quizzes
	 * @throws SQLException
	 */
public static ArrayList<Quiz> getRecentCreatedQuiz(String usrID) throws SQLException{
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		String command = "SELECT * FROM Quizzes WHERE creator = "+"\""+usrID+"\" ORDER BY createTime DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
		}
		for(int i = 0; i<qids.size();i++){
			Quiz q = new Quiz(qID);
			quizzes.add(q);
		}
		return quizzes;
	}

	/**
	 * Get recent achievements of specific user given his/her ID
	 * @param usrID
	 * @return Arraylist of achievement ID
	 */
	public static ArrayList<String> getRecentAchievements(String usrID){
		//		ArrayList<String> ach = new ArrayList<String>();
		String command = "SELECT * FROM AchievementRecords WHERE usrID = "+"\""+usrID+"\" ORDER BY time DESC;";
		ResultSet rs1 = db.executeQuery(command);
		ArrayList<String> achID = new ArrayList<String>();
		try {
			while(rs1.next()){
				achID.add(rs1.getString("achID"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//		for(String achID1 : achID){
		//			String cmd = "SELECT * FROM Achievements WHERE achID = "+"\""+achID1+"\" ;";
		//			ResultSet rs2 = db.executeQuery(cmd);
		//			try {
		//				if(rs2.next()){
		//					ach.add(rs2.getString("description"));
		//				}
		//			} catch (SQLException e) {
		//				e.printStackTrace();
		//			}
		//
		//		}
		return achID;
	}
			
	/**
	 * Get recent scores of a specific user with userID
	 * @param usrID
	 * @return Arraylist of History related to the scores
	 * @throws SQLException
	 */
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

	/**
	 * Get average score of a specific user for quizzes he/she has played
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
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

	/**
	 * Given a time, get the performance of all players in last 24 hours
	 * @param time
	 * @return
	 * @throws SQLException
	 */
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

	/**
	 * Get recent created Quizzes
	 * @return Arraylist of recent created quizzes in order from newest to oldest
	 */
	static public ArrayList<String> getRecentQuiz(){
		DataBase db = QuizSystem.getQuizSystem().db;
		ResultSet rs = db.executeQuery("Select name from Quizzes Order by createTime;");
		ArrayList<String> recentquiz = new ArrayList<String>();
		try {
			while(rs.next()){
				recentquiz.add(rs.getString("name"));
			}
			return recentquiz;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Get the top 5% of Quizzes in total played times 
	 * @return
	 */
	static public ArrayList<Quiz> getPopularQuiz(){
		int count = 0;
		DataBase db = QuizSystem.getQuizSystem().db;
		//		ResultSet rsCount = db.executeQuery("select COUNT distinct quizID FROM Histories GROUP BY quizID" +
		//				" ORDER BY count(usrID);");
		ResultSet rsCount = db.executeQuery("select count(distinct quizID) from Histories;");
		try {
			if(rsCount.next()){
				count = rsCount.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		System.out.println(count);
		ArrayList<Quiz> popuQuiz = new ArrayList<Quiz>();
		int limit = (int) (count * 0.05);
		if(limit <= 1) limit = 1;
		ResultSet rs = db.executeQuery("SELECT distinct quizID FROM Histories GROUP BY quizID" +
				" ORDER BY count(usrID) LIMIT " + limit+";");
		ArrayList<String> quizids = new ArrayList<String>();

		try {
			while(rs.next()){
				String qID = rs.getString(1);
				quizids.add(qID);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for(String qid : quizids){
			Quiz q;
			try {
				q = new Quiz(qid);
				popuQuiz.add(q);	
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return popuQuiz;
	}

	/**
	 * Get the top 5% of players in total played quiz numbers
	 * @return
	 * @throws ClassNotFoundException 
	 */
	static public ArrayList<User> getTopPlayer() throws ClassNotFoundException{
		int count = 0;
		DataBase db = QuizSystem.getQuizSystem().db;
		ResultSet rsCount = db.executeQuery("select count(distinct usrID) from Histories;");
		try {
			if(rsCount.next()){
				count = rsCount.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		ArrayList<User> topUser = new ArrayList<User>();
		ArrayList<String> usrIDs = new ArrayList<String>();

		int limit = (int) (count * 0.05);
		if(limit <= 1) limit = 1;
		ResultSet rs = db.executeQuery("SELECT distinct usrID FROM Histories GROUP BY usrID" +
				" ORDER BY count(quizID) LIMIT " + limit+";");
		try {
			while(rs.next()){
				String usrID = rs.getString(1);
				usrIDs.add(usrID);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return topUser;
	}

	/**
	 * Return average score for all players
	 * @param quizID
	 * @return
	 * @throws SQLException
	 */
	public static double getQuizAverageScore(String quizID) throws SQLException{
		double avg = 0;
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+quizID+"\";";
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

	/**
	 * Return the highest score for a specific quiz
	 * @param quizID
	 * @return score
	 * @throws SQLException 
	 */
	public static double getHighestScoreOfQuiz(String quizID) throws SQLException{
		double hscore = 0;
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+quizID+"\" ORDER BY score DESC limit 1;";
		ResultSet rs = db.executeQuery(command);
		if(rs.next()){
			hscore = rs.getDouble("score");
		}	
		return hscore;		
	}

	/**
	 * return how many times the quiz has been taken
	 * @param quizID
	 * @return
	 * @throws SQLException 
	 */
	public static int getPlayTimesOfQuiz(String quizID) throws SQLException{
		int count = 0;
		DataBase db = QuizSystem.getQuizSystem().db;
		ResultSet rsCount = db.executeQuery("SELECT COUNT(DISTINCT quizID) FROM Histories;");
		if(rsCount.next()){
			count = rsCount.getInt(1);
		}
		return count;
	}

	/**
	 * Returns list of unread messages of a user
	 * @param user
	 * @return list of unread messages of a user
	 */
	public static ArrayList<Message> unreadMessages(User user) {
		user.info.update();
		ArrayList<Message> msgs = user.info.messages;
		System.out.println("msgs:" + msgs.size());
		ArrayList<Message> newmsgs = new ArrayList<Message>();
		for (Message msg : msgs) {
			if (msg.isRead == 1) {
				newmsgs.add(msg);
			}
		}
		return newmsgs;
	}

	public static ArrayList<String> searchAccounts(String usrID){
		ArrayList<String> list = new ArrayList<String>();
		ResultSet rs = QuizSystem.db.executeQuery("Select usrID from Users where usrID like \'%" + usrID+"%\';");

		try {
			while(rs.next()){
				list.add(rs.getString("usrID"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public static ArrayList<String> searchQuizzes(String quizID){
		ArrayList<String> list = new ArrayList<String>();
		ResultSet rs = QuizSystem.db.executeQuery("Select quizID from Quizzes where quizID like \'%" + quizID+"%\';");

		try {
			while(rs.next()){
				list.add(rs.getString("quizID"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	static public void main(String[] args){
		DataBase db = QuizSystem.getQuizSystem().db;
		//		DROP TABLE IF EXISTS Quizzes;
		//		CREATE TABLE Quizzes(
		//			quizID VARCHAR(255),
		//			name VARCHAR(1023),
		//			creator VARCHAR(255),
		//			createTime DATETIME,
		//			updateTime DATETIME,
		//			description TEXT,
		//			spec TEXT,
		//			PRIMARY KEY (quizID),
		//			FOREIGN KEY (creator) REFERENCES Users(usrID)
		//		);

//		getRecentAchievements(String usrID)
//		ArrayList<String> rAch = new ArrayList<String>();
//		rAch = getRecentAchievements("xiaotihu");//getRecentQuiz();
		try {
			System.out.print(getHighestScoreOfQuiz("xiaotihu2015-11-23 19:12:15"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
//		try {
//			double s = getUserAverageScore("xinhuiwu");
//			System.out.print(s);
//
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}

		//		try {
		//			ResultSet rs=db.executeQuery("Select * from Quizzes;");
		//			while(rs.next()){
		//				System.out.println(rs.getString(1));
		//				System.out.println(rs.getString(2));
		//				
		//			}
		//		} catch (SQLException e) {
		//			// TODO Auto-generated catch block
		//			e.printStackTrace();
		//		}
	}

}
