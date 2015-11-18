package Quiz;

import java.sql.ResultSet;
import java.sql.SQLException;

//TODO in QuizSystem.db, score and rating is INT, should be double in this case, action needed

public class History {
	protected String quizID;
	protected String usrID;
	protected String playmode;
	protected String start;
	protected String end;
	protected long span;
	protected double score;
	protected String review;
	protected double rating;

	/**
	 * Constructor of history - as creating a new history 
	 */
	public History(String quizID, String usrID, String playmode, String start, 
			String end, long span, double score, String review, double rating) {
		this.quizID = quizID;
		this.usrID = usrID;
		this.playmode = "";
		// start time should be set by calling method setStartQuizTime() at 
		// the time user start taking quiz
		this.end = end;
		this.span = span;
		this.score = score;
		this.review = review;
		this.rating = rating;
	}

	/**
	 * Constructor of history - given a history ID, get all information from QuizSystem.db
	 * @param historyID
	 */
	public History(int historyID) {		
		String command = "SELECT * FROM Histories WHERE historyID = " + "\""
				+ historyID + "\";";
		ResultSet rs = QuizSystem.db.executeQuery(command);
		try {
			if (rs.next()) {
				String quizID = rs.getString("quizID");
				String usrID = rs.getString("usrID");
				String playmode = rs.getString("playmode");
				String start = rs.getString("start");
				String end = rs.getString("end");
				long span = rs.getLong("span");
				double score = rs.getDouble("score");
				String review = rs.getString("review");
				double rating = rs.getDouble("rating");

				this.quizID = quizID;
				this.usrID = usrID;
				this.playmode = playmode;
				this.start = start;
				this.end = end;
				this.span = span;
				this.score = score;
				this.review = review;
				this.rating = rating;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	/****** Setters of the class, all changes are not final until update the changes to QuizSystem.db ******/
	/**
	 * Set the start time of taking the quiz, should be called when a user
	 * starts to take the quiz

	private void setStartQuizTime(){
		this.start = System.currentTimeMillis();
	}

	private void setPlayMode(String mode){
		this.playmode = mode;
	}

	private void setEndQuizTime(){
		this.end = System.currentTimeMillis();
	}

	private void setEndQuizTime(long endTime){
		this.end = endTime;
	}

	private void setReview(String re){
		this.review = re;
	}

	private void setScore(double s){
		this.score = s;
	}

	private void setRating(double r){
		this.rating = r;
	}
	 */

	/**
	 * Save history object to database, one save action will save all 
	 * information (all ivars) at the same time, to database
	 * @return whether save is successful
	 * @throws SQLException
	 */
	public boolean saveToDB() throws SQLException {
		removeFromDB(); // removing any existing friend object that is equal to this one
		// after clear or is not duplicate, execute the insert
		String saveValue = "\"" + quizID + "\",\"" + usrID + "\",\"" + playmode 
				+ "\",\"" + start + "\",\"" + end + "\",\"" + score + "\",\"" + review + "\",\""
				+ rating + "\",\"" + span + "\"";
		String saveStmt = "INSERT INTO Users VALUES(" + saveValue + ");";		
		return QuizSystem.db.executeUpdate(saveStmt); // if insert is failed, return false
	}

	/**
	 * Remove this piece of history from database
	 * @return whether removal is successful
	 */
	public boolean removeFromDB() {
		String stmt = "DELETE FROM Friends WHERE quizID = \"" + quizID + "\" AND usrID = \"" + usrID + "\" AND start = \"" + start + "\" AND end = \"" + end +  "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
}
