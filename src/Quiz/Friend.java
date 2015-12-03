package Quiz;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Friend implements Comparable{
	String usr1ID;
	String usr2ID;
	String time;

	/**
	 * Constructor of Friend
	 * @param usr1ID
	 * @param usr2ID
	 */
	public Friend(String usr1ID, String usr2ID) {
		if(usr1ID.equals(usr2ID)) return;
		this.usr1ID = usr1ID;
		this.usr2ID = usr2ID;
		DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
		Date dateobj = new Date();
		time = df.format(dateobj.getTime()).toString();
	}
	
	/**
	 * Constructor of Friend
	 * @param usr1ID
	 * @param usr2ID
	 * @param time
	 */
	public Friend(String usr1ID, String usr2ID, String time) {
		if(usr1ID.equals(usr2ID)) return;
		this.usr1ID = usr1ID;
		this.usr2ID = usr2ID;
		this.time = time;
	}

	public boolean saveToDB() throws SQLException {
		removeFromDB();// removing any existing friend object that is equal to this one
		// after clear or is not duplicate, execute the insert
		String saveValue = "\"" + usr1ID + "\",\"" + usr2ID + "\",\"" + time + "\"";
		String saveStmt = "INSERT INTO Friends VALUES(" + saveValue + ");";	
		System.out.println(saveStmt);
		return QuizSystem.db.executeUpdate(saveStmt); // if insert is failed, return false
	}

	public boolean removeFromDB() {
		String stmt1 = "DELETE FROM Friends WHERE usr1ID = \"" + usr1ID + "\" AND usr2ID = \"" + usr2ID + "\";";
		String stmt2 = "DELETE FROM Friends WHERE usr1ID = \"" + usr2ID + "\" AND usr2ID = \"" + usr1ID + "\";";

		return (QuizSystem.db.executeUpdate(stmt1) && QuizSystem.db.executeUpdate(stmt2));
	}
	
	public static boolean removeByUserID(String usrID) {
		String stmt = "DELETE FROM Friends WHERE usr1ID = \"" + usrID  + "\" OR usr2ID = \"" + usrID + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	public String getFriend(String id){
		if(id.equals(usr1ID))
			return usr2ID;
		else
			return usr1ID;
	}
	
	@Override
	public int compareTo(Object o) {
		Date timeDate = QuizSystem.convertToDate(time);
		if (o instanceof Friend) {
			Date otherDate = QuizSystem.convertToDate(((Friend)o).time);
			return -timeDate.compareTo(otherDate);
		}
		return 0;
	}
}
