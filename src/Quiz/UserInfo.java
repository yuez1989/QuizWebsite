package Quiz;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserInfo {
	public String usrID;
	/*
	protected String password;
	public String time;
	public int permission;
	public char privacy;*/
	public String imagePath;
	public ArrayList<Friend> friends;
	public ArrayList<Message> messages; // sort it according to time?
	public ArrayList<AchievementRecord> achievementRecords; // Only administrators can see
	public ArrayList<History> histories; // 

	public UserInfo(String usrID) {
		this.usrID = usrID;
		/* Initialize all supporting info */
		imagePath = "";
		friends = new ArrayList<Friend>();
		messages = new ArrayList<Message>();
		achievementRecords = new ArrayList<AchievementRecord>();
		histories = new ArrayList<History>();

		update();
	}

	public void update() {
		extractFriendsFromDB();
		extractMessagesFromDB();
		extractAchievementRecordsFromDB();
		extractHistoriesFromDB();
	}
	
	public void extractFriendsFromDB() {
		// use usrID to query the db and fill the friends list.
		String command = "SELECT * FROM Friends WHERE usr1ID =\"" + usrID + "\" OR usr2ID = \"" + usrID + "\";";
		friends = new ArrayList<Friend>();
		try{
			ResultSet rs = QuizSystem.getQuizSystem().db.executeQuery(command);
			while (rs.next()){
				String usr1ID = rs.getString("usr1ID");
				String usr2ID = rs.getString("usr2ID");
				String time = rs.getString("time");
				friends.add(new Friend(usr1ID, usr2ID, time));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void extractMessagesFromDB() {
		String command = "SELECT * FROM Messages WHERE fromID =\"" + usrID + "\" OR toID = \"" + usrID + "\";";
		messages = new ArrayList<Message>();
		try{
			ResultSet rs = QuizSystem.db.executeQuery(command);
			while (rs.next()){
				String fromID = rs.getString("fromID");
				String toID = rs.getString("toID");
				String msg = rs.getString("msg");
				String type = rs.getString("type");
				String time = rs.getString("time");
				int isRead = rs.getInt("isRead");
				messages.add(new Message(fromID, toID, msg, type, time, isRead));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void extractAchievementRecordsFromDB() {
		String command = "SELECT * FROM AchievementRecords WHERE usrID =\"" + usrID + "\";";
		achievementRecords = new ArrayList<AchievementRecord>();

		try {
			ResultSet rs = QuizSystem.db.executeQuery(command);
			while (rs.next()) {
				String achID = rs.getString("achID");	
				achievementRecords.add(new AchievementRecord(usrID, achID));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void extractHistoriesFromDB() {
		histories = new ArrayList<History>();
		String command = "SELECT * FROM Histories WHERE usrID =\"" + usrID + "\";";
		try {
			ResultSet rs = QuizSystem.db.executeQuery(command);
			while (rs.next()) {
				//String achID = rs.getString("achID");
				String quizID = rs.getString("quizID");
				String playmode = rs.getString("playmode");
				String start = rs.getString("start");
				String end = rs.getString("end");
				long span = rs.getLong("span");
				double score = rs.getDouble("score");
				String review = rs.getString("review");
				int rating = rs.getInt("rating");

				histories.add(new History(quizID, usrID, playmode, start, end, span, score, review, rating));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}