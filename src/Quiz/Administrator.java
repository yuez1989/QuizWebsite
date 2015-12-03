package Quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Administrator extends User{

	public Administrator(String usrID){
		super(usrID);
		// TODO Auto-generated constructor stub
	}
	
	public Administrator(String usrID, String password, char privacy) {
		super(usrID,password,true,privacy);
	}

	public void createAnnouncement(String content){
		String time = Long.toString(System.currentTimeMillis());
		String announceID = this.usrID + time;
		String createtime = QuizSystem.generateCurrentTime();
		
		QuizSystem.db.executeUpdate("INSERT INTO Announcements VALUES(\'"+announceID+"\',\'"+content+"\',\'"+usrID+"\',\'"+createtime+"\');");
		
	}
	
	public void deleteQuiz(String quizID){
		//remove histories related with this quiz
		clearHistory(quizID);
		//remove problem relationship
		QuizSystem.db.executeUpdate("DELETE FROM ProblemBelongto WHERE quizID = \'"+quizID+"\';");
		QuizSystem.db.executeUpdate("DELETE FROM TagAssign WHERE quizID = \'"+quizID +"\';");
		QuizSystem.db.executeUpdate("DELETE FROM Histories WHERE quizID = \'"+quizID +"\';");		
		QuizSystem.db.executeUpdate("DELETE FROM Quizzes WHERE quizID = \'"+quizID+"\';");
	}
	
	public void clearHistory(String quizID){
		QuizSystem.db.executeUpdate("DELETE FROM Histories WHERE quizID = \'"+quizID+"\';");
	}
	
	public void promoteAdmin(String usrID){	
		QuizSystem.db.executeUpdate("UPDATE Users set permission = 1 where usrID = \'"+usrID+"\';");
	}
	
	public void demoteAdmin(String usrID){
		QuizSystem.db.executeUpdate("UPDATE Users set permission = 0 where usrID = \'"+usrID+"\';");		
	} 
	
	public void deleteUser(String usrID){
		QuizSystem.db.executeUpdate("Delete from AchievementRecords WHERE usrID = \'"+usrID+"\';");
		QuizSystem.db.executeUpdate("Delete from Histories WHERE usrID = \'"+usrID+"\';");
		QuizSystem.db.executeUpdate("DELETE FROM Messages WHERE fromID = \'"+usrID+"\' or toID = \'"+usrID+"\';");
		QuizSystem.db.executeUpdate("DELETE FROM Friends WHERE usr1ID = \'"+usrID+"\' or usr2ID = \'"+usrID+"\';");
		QuizSystem.db.executeUpdate("delete from Announcements where creatorID = \'"+usrID+"\';");
		QuizSystem.db.executeUpdate("Update Quizzes set creator = \'default\' where creator = \'"+usrID+"\';");
		QuizSystem.db.executeUpdate("DELETE FROM Users WHERE usrID = \'"+usrID+"\';");
		
	}
	
	
	public static void main(String[] args){
		QuizSystem.getQuizSystem();
		
		Administrator usr = new Administrator("xiaotihu");
		usr.createAnnouncement("first announcement");
		
	}
//	static String account = MyDBInfo.MYSQL_USERNAME;
//	static String password = MyDBInfo.MYSQL_PASSWORD;
//	static String server = MyDBInfo.MYSQL_DATABASE_SERVER;
//	static String database = MyDBInfo.MYSQL_DATABASE_NAME;
//	
//	static Statement sql_command;
//	static Connection connect;
//	
//	public Administrator(){
//		try {
//			Class.forName("com.mysql.jdbc.Driver");
//
//			connect = DriverManager.getConnection
//				( "jdbc:mysql://" + server, account ,password);
//			
//			sql_command = connect.createStatement();
//			sql_command.executeQuery("USE " + database);
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} 
//		catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		}
//	}
	
	
	
}
