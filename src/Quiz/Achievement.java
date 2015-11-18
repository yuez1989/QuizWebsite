package Quiz;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Achievement {
	String achID;
	String description;
	
	public Achievement(String id, String description) {
		this.achID = id;
		this.description = description;
	}
	
	public boolean saveToDB() throws SQLException {
		removeFromDB(); // removing any existing friend object that is equal to this one
		// after clear or is not duplicate, execute the insert
		String saveValue = "\"" + achID + "\",\"" + description + "\"";
		String saveStmt = "INSERT INTO Achievements VALUES(" + saveValue + ");";		
		return QuizSystem.db.executeUpdate(saveStmt); // if insert is failed, return false
	}
	
	public boolean removeFromDB() {
		String stmt = "DELETE FROM Achievements WHERE achID = \"" + achID + "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
}