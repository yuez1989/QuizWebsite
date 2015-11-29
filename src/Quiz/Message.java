package Quiz;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.*;

public class Message {
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
		
		DateFormat df = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
		Date dateobj = new Date();
		time = df.format(dateobj.getTime()).toString();
		
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
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	public static boolean removeByUserID(String usrID) {
		String stmt = "DELETE FROM Messages WHERE fromID = \"" + usrID  + "\" OR toID = \"" + usrID + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	public void setAsRead() {
		isRead = 0;
	}
	
	public void setAsUnread() {
		isRead = 1;
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
}