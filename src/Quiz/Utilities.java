package Quiz;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.*;

public class Utilities {

	static DataBase db = QuizSystem.getQuizSystem().db;
	// Defines how many days ahead of current time is "recent" referring to in the system
	protected static int days_of_recent = 3;
	protected static double percentage_of_top = 0.05;
	
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
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+QuizID+"\" ORDER BY score DESC, span;";
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
	 * Get recent activities from history for every friend of a specific user 
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
	 * Get recent activities from history for every friend of a specific user, with recent number
	 * of days specified as daysRecent
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentFriendActivities(String usrID, int daysRecent) throws SQLException{
		ArrayList<History> friendAct = new ArrayList<History>();
		ArrayList<String> friendList = new ArrayList<String>();
		try {
			friendList = getFriendList(usrID);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for(String frdID : friendList){
			ArrayList<History> act = getRecentActivitiesOfUser(frdID, daysRecent);
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
			if(!frdID.equals(usrID) && !friendIDs.contains(frdID))
			friendIDs.add(frdID);
		}
		String command2 = "SELECT * FROM Friends WHERE usr2ID = "+"\""+usrID+"\";";
		ResultSet rs2= db.executeQuery(command2);
		while(rs2.next()){
			String frdID = rs2.getString("usr1ID");
			if(!frdID.equals(usrID) && !friendIDs.contains(frdID))
			friendIDs.add(frdID);
		}
		return friendIDs;
	}

	/**
	 * Given two user IDs, check if these two users are friends
	 * @param usr1
	 * @param usr2
	 * @return
	 * @throws SQLException 
	 */
	public static boolean isFriend(String usr1, String usr2) throws SQLException{
		ArrayList<String> friendList = getFriendList(usr1);
		return friendList.contains(usr2);
	}

	/**
	 * Get recent announcement of a specific quiz
	 * @param quizID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<String> getRecentAnnouncements() throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<String> recentAnnouncements = new ArrayList<String>();
		String command = "SELECT * FROM Announcements WHERE time > \""+time+"\" ORDER BY time DESC;";
		ResultSet rs = db.executeQuery(command);
		while(rs.next()){
			recentAnnouncements.add(rs.getString("content"));
		}
		return recentAnnouncements;
	}
	
	/**
	 * Get recent announcement of a specific quiz, with recent number of days specified as daysRecent
	 * @param quizID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<String> getRecentAnnouncements(int daysRecent) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, daysRecent);
		ArrayList<String> recentAnnouncements = new ArrayList<String>();
		String command = "SELECT * FROM Announcements WHERE time > \""+time+"\" ORDER BY time DESC;";
		ResultSet rs = db.executeQuery(command);
		while(rs.next()){
			recentAnnouncements.add(rs.getString("content"));
		}
		return recentAnnouncements;
	}

	/**
	 * Get recent review of a specific quiz
	 * @param quizID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<String> getRecentQuizReviews(String quizID) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<String> recentReviews = new ArrayList<String>();
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND quizID = "+"\""+quizID+"\" ORDER BY end DESC;";
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
	 * Get recent review of a specific quiz, with recent number of days specified as daysRecent
	 * @param quizID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<String> getRecentQuizReviews(String quizID, int daysRecent) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, daysRecent);
		ArrayList<String> recentReviews = new ArrayList<String>();
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND quizID = "+"\""+quizID+"\" ORDER BY end DESC;";
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
	 * Get recent activities(History) of a specific quiz
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentActivitiesOfQuiz(String quizID) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<History> recentActs = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND quizID = "+"\""+quizID+"\" ORDER BY end DESC;";
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
	 * Get recent activities(History) of a specific quiz, with recent number of days specified as daysRecent
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentActivitiesOfQuiz(String quizID, int daysRecent) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, daysRecent);
		ArrayList<History> recentActs = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND quizID = "+"\""+quizID+"\" ORDER BY end DESC;";
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
	 * Get recent user Histories
	 * TODO test
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentActivitiesOfUser(String usrID) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<History> recentActs = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND usrID = \""+usrID+"\" ORDER BY end DESC;";
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
	 * Get recent user Histories, with recent number of days specified as daysRecent
	 * TODO test
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentActivitiesOfUser(String usrID, int daysRecent) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<History> recentActs = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND usrID = \""+usrID+"\" ORDER BY end DESC;";
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
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		String command = "SELECT * FROM Quizzes WHERE createTime > \""+time+"\" AND creator = "+"\""+usrID+"\" ORDER BY createTime DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
		}
		for(int i = 0; i<qids.size();i++){
			Quiz q = new Quiz(qids.get(i));
			quizzes.add(q);
		}
		return quizzes;
	}
	
	/**
	 * Get quizzes recently created by specific user, with recent number of days specified as daysRecent
	 * @param usrID
	 * @return Arraylist of quizzes
	 * @throws SQLException
	 */
	public static ArrayList<Quiz> getRecentCreatedQuiz(String usrID, int daysRecent) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, daysRecent);
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		String command = "SELECT * FROM Quizzes WHERE createTime > \""+time+"\" AND creator = "+"\""+usrID+"\" ORDER BY createTime DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
		}
		for(int i = 0; i<qids.size();i++){
			Quiz q = new Quiz(qids.get(i));
			quizzes.add(q);
		}
		return quizzes;
	}

	/**
	 * Get recent achievements of specific user given his/her ID
	 * @param usrID
	 * @return Arraylist of achievement ID
	 * @throws SQLException 
	 */
	public static ArrayList<AchievementRecord> getRecentAchievements(String usrID) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<AchievementRecord> achRecs = new ArrayList<AchievementRecord>();
		ArrayList<String> achIDs = new ArrayList<String>();
		String command = "SELECT * FROM AchievementRecords WHERE time > \""+time+"\" AND usrID = "+"\""+usrID+"\" ORDER BY time DESC;";
		ResultSet rs1 = db.executeQuery(command);
		while(rs1.next()){
			achIDs.add(rs1.getString("achID"));
		}
		for(String achID : achIDs){
			AchievementRecord AR = new AchievementRecord(usrID, achID);
			achRecs.add(AR);
		}
		return achRecs;
	}
	
	/**
	 * Get recent achievements of specific user given his/her ID, with recent number of days specified as daysRecent
	 * @param usrID
	 * @return Arraylist of achievement ID
	 * @throws SQLException 
	 */
	public static ArrayList<AchievementRecord> getRecentAchievements(String usrID, int daysRecent) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, daysRecent);
		ArrayList<AchievementRecord> achRecs = new ArrayList<AchievementRecord>();
		ArrayList<String> achIDs = new ArrayList<String>();
		String command = "SELECT * FROM AchievementRecords WHERE time > \""+time+"\" AND usrID = "+"\""+usrID+"\" ORDER BY time DESC;";
		ResultSet rs1 = db.executeQuery(command);
		while(rs1.next()){
			achIDs.add(rs1.getString("achID"));
		}
		for(String achID : achIDs){
			AchievementRecord AR = new AchievementRecord(usrID, achID);
			achRecs.add(AR);
		}
		return achRecs;
	}

	/**
	 * Get recent scores of a specific user with userID
	 * @param usrID
	 * @return Arraylist of History related to the scores
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentScoresOfUser(String usrID) throws SQLException{
		ArrayList<History> recentScores = new ArrayList<History>();
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND usrID = "+"\""+usrID+"\" ORDER BY end DESC;";
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
	 * Get recent scores of a specific user with userID, with recent number of days specified as daysRecent
	 * @param usrID
	 * @return Arraylist of History related to the scores
	 * @throws SQLException
	 */
	public static ArrayList<History> getRecentScoresOfUser(String usrID, int daysRecent) throws SQLException{
		ArrayList<History> recentScores = new ArrayList<History>();
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, daysRecent);
		String command = "SELECT * FROM Histories WHERE end > \""+time+"\" AND usrID = "+"\""+usrID+"\" ORDER BY end DESC;";
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
	 * Get all quizzes 
	 * @param usrID
	 * @return Arraylist of quizzes
	 * @throws SQLException
	 */
	public static ArrayList<Quiz> getAllQuizzes() throws SQLException{
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		String command = "Select quizID from Quizzes Order by createTime;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
		}
		for(int i = 0; i<qids.size();i++){
			Quiz q = new Quiz(qids.get(i));
			quizzes.add(q);
		}
		return quizzes;	
	}

	/**
	 * Get recent created Quizzes
	 * @return Arraylist of recent created quizzes in order from newest to oldest
	 * @throws SQLException 
	 */
	static public ArrayList<Quiz> getRecentQuiz() throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, days_of_recent);
		ArrayList<Quiz> recentquiz = new ArrayList<Quiz>();
		String command = "Select quizID from Quizzes WHERE createTime > "+"\""+time+"\" Order by createTime DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
		}
		for(int i = 0; i<qids.size();i++){
			Quiz q = new Quiz(qids.get(i));
			recentquiz.add(q);
		}
		return recentquiz;	
	}

	/**
	 * Get recent created Quizzes, with specific days of recent defined
	 * @return Arraylist of recent created quizzes in order from newest to oldest
	 * @throws SQLException 
	 */
	static public ArrayList<Quiz> getRecentQuiz(int daysRecent) throws SQLException{
		String currentTime = QuizSystem.generateCurrentTime();
		String time = QuizSystem.minusDay(currentTime, daysRecent);
		ArrayList<Quiz> recentquiz = new ArrayList<Quiz>();
		String command = "Select quizID from Quizzes WHERE createTime > "+"\""+time+"\"Order by createTime DESC;";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> qids = new ArrayList<String>();
		while(rs.next()){
			qids.add(rs.getString("quizID"));
		}
		for(int i = 0; i<qids.size();i++){
			Quiz q = new Quiz(qids.get(i));
			recentquiz.add(q);
		}
		return recentquiz;	
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
		double factorOfPopular = 2*percentage_of_top;
		int limit = (int) (count * factorOfPopular );
		if(limit <= 3) limit = 3;
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

		int limit = (int) (count * percentage_of_top);
		if(limit <= 3) limit = 3;
		ResultSet rs = db.executeQuery("SELECT usrID FROM Histories GROUP BY usrID" +
				" ORDER BY count(quizID) DESC LIMIT " + limit+";");
		try {
			while(rs.next()){
				String usrID = rs.getString(1);
				usrIDs.add(usrID);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for(String usrid: usrIDs){
			topUser.add(new User(usrid));			
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
	public static String getHighestScoreOfQuiz(String quizID) throws SQLException{
		double hscore = 0;
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+quizID+"\" ORDER BY score DESC limit 1;";
		ResultSet rs = db.executeQuery(command);
		if(rs.next()){
			hscore = rs.getDouble("score");
		}	
		return new DecimalFormat("#0.00").format(hscore).toString() ;		
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
	 * return how many quizzes a user has played
	 * @param quizID
	 * @return
	 * @throws SQLException 
	 */
	public static int getQuizNumberPlayed(String usrID) throws SQLException{
		int count = 0;
		DataBase db = QuizSystem.getQuizSystem().db;
		ResultSet rsCount = db.executeQuery("SELECT COUNT(distinct quizID) FROM Histories where usrID =  \'" + usrID+"\' ;");
		if(rsCount.next()){
			count = rsCount.getInt(1);
		}
		return count;
	}

	/**
	 * Check whether a specific user has already got a specific achievement
	 * @param achID
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static boolean hasAchievement(String achID, String usrID) throws SQLException{
		DataBase db = QuizSystem.getQuizSystem().db;
		ResultSet rs = db.executeQuery("SELECT * FROM AchievementRecords WHERE usrID = \""+usrID+"\" AND achID = "+"\""+achID+"\";");
		return rs.next();
	}
	
	/**
	 * return how many quizzes a user has created
	 * @param quizID
	 * @return
	 * @throws SQLException 
	 */
	public static int getQuizNumberCreated(String usrID) throws SQLException{
		int count = 0;
		DataBase db = QuizSystem.getQuizSystem().db;
		ResultSet rsCount = db.executeQuery("SELECT COUNT(distinct quizID) FROM Quizzes where creator =  \'"+usrID+"\' ;");
		if(rsCount.next()){
			count = rsCount.getInt(1);
		}
		return count;
	}

	/**
	 * Get the highest score a user has achieved in a specific quiz
	 * @param quizID
	 * @param UserID
	 * @return
	 */
	public static double getHighScoreOfUserInQuiz(String quizID, String userID) throws SQLException{
		double score = 0 ;
		String command = "SELECT * FROM Histories WHERE quizID = "+"\""+quizID+"\" AND usrID = "+"\""+userID+"\" ORDER BY score DESC;";
		ResultSet rs = db.executeQuery(command);
		if(rs.next()){
			score = rs.getDouble("score");
		}
		return score;
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

	/**
	 * Get the account IDs given the partial string of desired user ID
	 * @param usrID
	 * @return
	 */
	public static ArrayList<String> searchAccounts(String usrID){
		ArrayList<String> list = new ArrayList<String>();
		ResultSet rs = QuizSystem.db.executeQuery("Select usrID from Users where usrID like \'%" + usrID+"%\';");

		try {
			while(rs.next()){
				list.add(rs.getString("usrID"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}


	/**
	 * Search by quizID ONLY (no exact match of quizID required)
	 * @param str
	 * @return Arraylist of quizID
	 */
	public static ArrayList<String> searchQuizzes(String str){
		ArrayList<String> list = new ArrayList<String>();
		ResultSet rs = QuizSystem.db.executeQuery("Select quizID from Quizzes where quizID like \'%" + str+"%\';");
		//		System.out.println("Select quizID from Quizzes where quizID like \'%" + quizID+"%\';");
		try {
			while(rs.next()){
				list.add(rs.getString("quizID"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * Search by quizID or quiz name 
	 * @param string
	 * @return Arraylist of quizID and quiz name divided by "##" 
	 */
	public static ArrayList<String> searchQuizzesByName(String string){
		ArrayList<String> list = new ArrayList<String>();
		ResultSet rs = QuizSystem.db.executeQuery("Select quizID, name from Quizzes where name like \'%" + string+"%\' OR quizID like \'%" + string+"%\';");
		try {
			while(rs.next()){
				String str = "";
				str += rs.getString("quizID");
				str += "##";
				str += rs.getString("name");
				list.add(str);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * Search  by part of quiz content 
	 * @param string
	 * @return Arraylist of quizID
	 */
	public static ArrayList<Quiz> searchQuizzesByText(String string){
		ArrayList<String> list = new ArrayList<String>();
		ResultSet rs = QuizSystem.db.executeQuery("Select quizID from Quizzes where quizID like \'%" + string+"%\' or name like \'%" + string+"%\' or creator like \'%" + string+"%\' ;");
		try {
			while(rs.next()){
				String qID = rs.getString("quizID");
				list.add(qID);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		ArrayList<Quiz> result = new ArrayList<Quiz>();
		
		for(String qid:list){
			try {
				result.add(new Quiz(qid));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	/**
	 * Search by quizID or quiz name, exact match ONLY
	 * @param string
	 * @return Arraylist of quizID
	 */
	public static ArrayList<String> searchQuizzesByExactName(String string){
		ArrayList<String> list = new ArrayList<String>();
		ResultSet rs = QuizSystem.db.executeQuery("Select quizID, name from Quizzes where name = \"" + string+"\" OR quizID = \"" + string+"\";");
		try {
			while(rs.next()){
				String qID = rs.getString("quizID");
				list.add(qID);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * Get the number of users in the system
	 * @return
	 * @throws SQLException 
	 */
	static public int getTotalNumberOfUsers() throws SQLException{
		int num = 0;
		ResultSet rs = db.executeQuery("select count(distinct usrID) from Users;");
		if(rs.next()){
			num = rs.getInt(1);
		}
		return num;
	}

	/**
	 * Get the total number of quizzes in the system
	 * @return
	 * @throws SQLException 
	 */
	static public int getTotalNumberOfQuizzes() throws SQLException{
		int num = 0;
		ResultSet rs = db.executeQuery("select count(distinct quizID) from Quizzes;");
		if(rs.next()){
			num = rs.getInt(1);
		}
		return num;
	}

	/**
	 * Get the total played times of all quizzes by all users in the system
	 * @return
	 * @throws SQLException 
	 */
	static public int getTotalPlayedTimeOfQuizzes() throws SQLException{
		int num = 0;
		ResultSet rs = db.executeQuery("select count(quizID) from Histories;");
		if(rs.next()){
			num = rs.getInt(1);
		}
		return num;
	}

	/**
	 * Update the user privacy status
	 * TODO test
	 * @param usrID 
	 * @param prv the String representation of privacy option
	 */
	public static void updateUserPrivacy(String usrID, char prv){
		String p = Character.toString(prv);
//		p = p.toLowerCase();
//		if(p.equals("p") || p.equals("d") || p.equals("f"))
			String cmd = "UPDATE Users SET privacy = \""+p+"\" WHERE usrID = \""+usrID+"\";";
			QuizSystem.db.executeUpdate(cmd);
	}

	/**
	 * Check if the user ID is already in database
	 * @param usrID
	 * @return
	 * @throws SQLException
	 */
	public static boolean ifUserExists(String usrID) throws SQLException{
		DataBase db = QuizSystem.getQuizSystem().db;
		ResultSet rs = db.executeQuery("select * from Users where usrID = \""+usrID+"\";");
		return rs.next();
	}

	static public void main(String[] args){
		DataBase db = QuizSystem.getQuizSystem().db;

		ArrayList<Quiz> quizlist = searchQuizzesByText("ha");
		for(Quiz quiz:quizlist){
			System.out.println(quiz.quizName);
		}
	}
}
