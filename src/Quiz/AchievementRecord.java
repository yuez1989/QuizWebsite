package Quiz;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class AchievementRecord implements Comparable{
	public String usrID;
	public String achID;
	public String time;
	
	public AchievementRecord(String usrID, String achID) {
		this.usrID = usrID;
		this.achID = achID;
		DateFormat df = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
		Date dateobj = new Date();
		time = df.format(dateobj.getTime()).toString();
	}
	
	public boolean saveToDB() throws SQLException {
		removeFromDB(); // removing any existing friend object that is equal to this one
		// after clear or is not duplicate, execute the insert
		String saveValue = "\"" + usrID + "\",\"" + achID + "\",\"" + time + "\"";
		String saveStmt = "INSERT INTO AchievementRecords VALUES(" + saveValue + ");";		
		return QuizSystem.db.executeUpdate(saveStmt); // if insert is failed, return false
	}
	
	public boolean removeFromDB() {
		String stmt = "DELETE FROM AchievementRecords WHERE usrID = \"" + usrID + "\" AND \"" + achID + "\" AND \"" + time + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	public static boolean removeByUserID(String usrID) {
		String stmt = "DELETE FROM AchievementRecords WHERE usrID = \"" + usrID + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	public static boolean removeByAchID(String achID) {
		String stmt = "DELETE FROM AchievementRecords WHERE achID = \"" + achID + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	@Override
	public int compareTo(Object o) {
		Date timeDate = QuizSystem.convertToDate(time);
		if (o instanceof AchievementRecord) {
			Date otherDate = QuizSystem.convertToDate(((AchievementRecord)o).time);
			return -timeDate.compareTo(otherDate);
		}
		return 0;
	}
}
