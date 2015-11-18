package Quiz;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.*;

public class DataBase {
	static private DataBase db;
	
	static String account = MyDBInfo.MYSQL_USERNAME; static String password = MyDBInfo.MYSQL_PASSWORD; static String server = MyDBInfo.MYSQL_DATABASE_SERVER; static String database = MyDBInfo.MYSQL_DATABASE_NAME;
	private Connection con;
	private Statement stmt;
	
	/**
	 * build connection with the database
	 * this should be built before any query method or getvalue method is called
	 */
	
	private DataBase(){
		try {
			Class.forName("com.mysql.jdbc.Driver"); 
			con = (Connection) DriverManager.getConnection("jdbc:mysql://" + server, account ,password);
			stmt = (Statement) con.createStatement();
			stmt.executeQuery("USE " + database);
		} catch (SQLException e) {
			e.printStackTrace();
	    } catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
	}

	static public DataBase getDataBase(){
		if(db == null){
			db = new DataBase();			
		}
		return db;
	}
	
	
	public ResultSet executeQuery(String cmd){
		try {
			return  stmt.executeQuery(cmd);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public boolean executeUpdate(String cmd){
		try {
			stmt.executeUpdate(cmd);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}		
	}
	
	
	/**
	 * disconnect from database
	 * This should be called when window is closed
	 */
	public void disconnectDB(){
		try{
			con.close();			
		} catch(SQLException e){
			e.printStackTrace();
		}	
	}
	
}
