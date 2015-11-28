package Quiz;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class User {
	public String usrID;
	public String password;
	public String time;
	public int permission;
	public char privacy;
	public UserInfo info; // not in db
	/*
	public ArrayList<String> imagePaths;
	public ArrayList<Friend> friends;
	public ArrayList<Message> Messages; // sort it according to time?
	public ArrayList<Achievement> achievements; // Only administrators can see
	public ArrayList<History> histories; // 
	 */

	/**
	 * Constructor: first create an user
	 * @param usrID
	 * @param password, this is the raw version
	 * @param permission
	 * @param privacy
	 * @param imagePaths
	 */
	public User(String usrID, String password, boolean permission, char privacy) {
		this.usrID = usrID;
		this.password = encryptPW(password);

		DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
		Date dateobj = new Date();
		time = df.format(dateobj.getTime()).toString();
		if (permission) {
			this.permission = 1;
		}
		else {
			this.permission = 0;
		}
		this.privacy = privacy;

		/* Supporting info */
		info = new UserInfo(usrID); // all other table ivars are initialized and filled
	}

	// ANOTHER CONSTRUCTOR FROM DATABASE
	/**
	 * Constructor: extract an user from DB. It is used after a user entered the correct login information.
	 * @param usrID
	 */
	public User(String usrID) throws ClassNotFoundException {
		this.usrID = usrID;
		// get instance variables in user table
		// get other ivars loaded in info
		extractpermissionFromDB();
		extractPrivacyFromDB();
		extractTimeFromDB();
		info = new UserInfo(usrID);
	}

	/* "Extract" methods: get information from DB */
	/**
	 * Extract permission information from DB
	 */
	public void extractpermissionFromDB() {
		permission = 0;
		String command = "SELECT permission FROM Users WHERE usrID = \"" + usrID + "\";";		System.out.println(command);
		try{
			ResultSet rs = QuizSystem.db.executeQuery(command);
			if(rs.next()){
				String str = rs. getString("permission");
				if (str.equals("true")) {
					permission = 1;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * Extract time information from DB
	 */
	public void extractTimeFromDB() {
		String command = "SELECT createTime FROM Users WHERE usrID = \"" + usrID + "\"";
		try{
			ResultSet rs = QuizSystem.db.executeQuery(command);
			if(rs.next()){
				time = rs. getString("createTime");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * Extract privacy information from DB
	 */
	public void extractPrivacyFromDB() {
		String command = "SELECT privacy FROM Users WHERE usrID =\"" + usrID + "\"";
		try{
			ResultSet rs = QuizSystem.db.executeQuery(command);
			if(rs.next()){
				String str = rs.getString("privacy");
				if (str.length() > 0) {
					privacy = str.charAt(0); // take out the first char
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/* "Add" methods: note that they do not save the change into database. You should invoke saveToDB() to do that! */
	/**
	 * Update header image path. 
	 * This is quiet different from pure add methods because it is in User table and only needs update not insert operation.
	 * @param imagePath
	 * @throws SQLException 
	 */
	public void updateImage(String imagePath) throws SQLException {
		String checkStmt = "SELECT * FROM Users WHERE usrID = \"" + usrID + "\"";
		ResultSet rs = QuizSystem.db.executeQuery(checkStmt);
		if (rs.next()) { // if user exists
			String updateStmt = "UPDATE Users SET imagePath =\"" + imagePath + "\" WHERE usrID = \"" + usrID + "\"";
			QuizSystem.db.executeUpdate(updateStmt);
		}
		else { // if not exist, report error
			System.out.println("User does not exist!");
			System.exit(0);
		}
		info.update();
	}

	/**
	 * Add a friend
	 * @param friend
	 * @throws SQLException 
	 */
	public void addFriend(Friend friend) throws SQLException {  //HOW TO ADD friend relationship to BOTH friends?
		// db command to add a new row of friend info
		// info.extractFriendsFromDB()
		friend.saveToDB();
		info.update();
	}

	/**
	 * Add a Message
	 * @param Message
	 * @throws SQLException 
	 */
	public void addMessage(Message Message) throws SQLException {
		Message.saveToDB();
		info.update();
	}

	/**
	 * Add an achievement
	 * @param achievement object
	 * @throws SQLException 
	 */
	public void addAchievement(Achievement ach) throws SQLException {
		ach.saveToDB();
		info.update();
	}

	/**
	 * Add a piece of history
	 * @param history
	 * @throws SQLException 
	 */
	public void addHistory(History history) throws SQLException {
		history.saveToDB();
		info.update();
	}

	/* REMOVE METHODS */

	/**
	 * Save the user object into database: ONLY FOR USER TABLE. 
	 * Other table would not be changed if no add methods are called.
	 * NOTE: this method saves the User table only. Other support info is not affected.
	 * @throws SQLException 
	 */
	public boolean saveToDB() throws SQLException {
		// Into User table only.
		// Check for duplicate
		String checkStmt = "SELECT * FROM Users WHERE usrID = \"" + usrID + "\"";
		ResultSet rs = QuizSystem.db.executeQuery(checkStmt);
		if (rs.next()) { // is duplicate, clear all existing duplicates (should be only 1)
			String deleteStmt = "DELETE FROM Users WHERE usrID = \"" + usrID +"\";";
			QuizSystem.db.executeUpdate(deleteStmt);
		}
		// after clear or is not duplicate, execute the insert
		String saveValue = "\"" + usrID + "\",\"" + password + "\",\"" + time + "\",\"" + permission + "\",\"\",\"" + privacy + "\"";
		String saveStmt = "INSERT INTO Users VALUES(" + saveValue + ");";		
		System.out.println(saveStmt);
		return QuizSystem.db.executeUpdate(saveStmt); // if insert is failed, return false
	}

	/**
	 * Remove everything relevant to this user from database.
	 * NOTE: this method deletes all info, including support info. IT IS NOT THE DIRECT OPPOSITE OF saveToDB()
	 * @return
	 */
	public boolean removeFromDB() {
		for (Friend friend : info.friends) {
			friend.removeFromDB();
		}
		for (Message msg : info.messages) {
			msg.removeFromDB();
		}
		for (AchievementRecord ach : info.achievementRecords) {
			ach.removeFromDB();
		}
		for (History hist : info.histories) {
			hist.removeFromDB();
		}
		
		String stmt = "DELETE FROM Users WHERE usrID = \"" + usrID + "\";"; //NOTE: this might be problematic because we do not know whether this object exist in the DB
		boolean res = QuizSystem.db.executeUpdate(stmt);
		// Remove all information
		info.update();
		
		return res;
	}

	/**
	 * Users: usrID, password, creation time, access permission, privacy,images, 
	 * maybe we can get an extension like plain text tweeter...
	 */
	public static String encryptPW(String password) {
		try {
			MessageDigest mdConverter = MessageDigest.getInstance("SHA1");
			// Convert string input to bytes[] depending on its type -- password or hashcode
			mdConverter.update(password.getBytes());
			return hexToString(mdConverter.digest());
		}
		catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}

	/*
	 Given a byte[] array, produces a hex String,
	 such as "234a6f". with 2 chars for each byte in the array.
	 (provided code)
	 */
	private static String hexToString(byte[] bytes) {
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<bytes.length; i++) {
			int val = bytes[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}
}
