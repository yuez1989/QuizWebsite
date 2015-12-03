package Quiz;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.*;

public class Message implements Comparable{
	public String fromID;
	public String toID;
	public String type; // "f" or "c" or "t": friend request, challenge, text
	public String time;
	public String msg;
	public int isRead; // 0 to be read, 1 to be unread.

	public Message(String from, String to, String msg, String type) {
		fromID = from;
		toID = to;
		this.type = type;
		
		DateFormat df = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
		Date dateobj = new Date();
		time = df.format(dateobj);
		System.out.println("TIME IS: " + time);
		
		this.msg = msg;
		this.isRead = 1; // set to be unread;
	}
	
	public Message(String from, String to, String msg, String type, String time, int read) {
		fromID = from;
		toID = to;
		this.type = type;
	
		this.time = time;
		this.msg = msg;
		this.isRead = read;
	}
	
	// Extract from DB
	public Message (String from, String to, String time) {
		String command = "SELECT * FROM Messages WHERE fromID = \"" + from + 
				"\" AND toID = \"" + to + "\" AND time = \"" + time + "\";";
		ResultSet rs = QuizSystem.db.executeQuery(command);
		try {
			if (rs.next()) {
				fromID = rs.getString("fromID");
				toID = rs.getString("toID");
				this.msg = rs.getString("msg");
				this.type = rs.getString("type");
				this.time = rs.getString("time");
				this.isRead = rs.getInt("isRead");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Save current Message object to database
	 * @return if success, return true; otherwise return false.
	 * @throws SQLException 
	 */
	public boolean saveToDB() throws SQLException {
		removeFromDB(); // removing any existing friend object that is equal to this one
		// after clear or is not duplicate, execute the insert
		String saveValue = "\"" + fromID + "\",\"" + toID + "\",\"" + msg + "\",\"" + time + "\",\"" + type + "\",\"" + isRead + "\"";
		String saveStmt = "INSERT INTO Messages VALUES(" + saveValue + ");";
		return QuizSystem.db.executeUpdate(saveStmt); // if insert is failed, return false
	}
	
	public boolean removeFromDB() {
		String stmt = "DELETE FROM Messages WHERE fromID = \"" + fromID + 
				"\" AND toID = \"" + toID + "\" AND type = \"" + type + 
				"\" AND time = \"" + time + "\" AND msg = \"" + msg +
				"\";"; // no need to search for "read" property because it is already sufficient to identify the message
		System.out.println(stmt);
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	/**
	 * Remove all the messages of one user, sent or received. Used when user removing account.
	 * @param usrID
	 * @return
	 */
	public static boolean removeByUserID(String usrID) {
		String stmt = "DELETE FROM Messages WHERE fromID = \"" + usrID  + "\" OR toID = \"" + usrID + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	/**
	 * Remove all the messages one user has sent.
	 * @param usrID
	 * @return
	 */
	public static boolean removeByUserIDReceivedOnly(String usrID) {
		String stmt = "DELETE FROM Messages WHERE toID = \"" + usrID  + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	public void setAsRead() throws SQLException {
		isRead = 0;
		saveToDB();
	}
	
	public void setAsUnread() throws SQLException {
		isRead = 1;
		saveToDB();
	}
	
	/**
	 * Whether one Message equals to another. If object is not Message, return false.
	 * @return If equal, return true; if not equal or object other is not Message, return false.
	 */
	@Override
	public boolean equals(Object other) {
		if (other instanceof Message) {
			Message otherMessage = (Message) other;
			if (fromID.equals(otherMessage.fromID) && toID.equals(otherMessage.toID) 
					&& type.equals(otherMessage.type) && msg.equals(otherMessage.msg) && time == otherMessage.time) {
				return true;
			}
		}
		return false;
	}
	
	@Override
	public int compareTo(Object o) {
		Date timeDate = QuizSystem.convertToDate(time);
		if (o instanceof Message) {
			Date otherDate = QuizSystem.convertToDate(((Message)o).time);
			return -timeDate.compareTo(otherDate);
		}
		return 0;
	}
}
