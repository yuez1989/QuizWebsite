package Quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Administrator {
	static String account = MyDBInfo.MYSQL_USERNAME;
	static String password = MyDBInfo.MYSQL_PASSWORD;
	static String server = MyDBInfo.MYSQL_DATABASE_SERVER;
	static String database = MyDBInfo.MYSQL_DATABASE_NAME;
	
	static Statement sql_command;
	static Connection connect;
	
	public Administrator(){
		try {
			Class.forName("com.mysql.jdbc.Driver");

			connect = DriverManager.getConnection
				( "jdbc:mysql://" + server, account ,password);
			
			sql_command = connect.createStatement();
			sql_command.executeQuery("USE " + database);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
}
