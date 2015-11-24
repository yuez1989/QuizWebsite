package Quiz;

import java.sql.ResultSet;
import java.sql.SQLException;

//TODO in QuizSystem.db, score and rating is INT, should be double in this case, action needed

public class History {
	public String quizID;
	public String usrID;
	public String playmode;
	public String start;
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
		this.playmode = playmode;
		// start time should be set by calling method setStartQuizTime() at 
		// the time user start taking quiz
		this.start = start;
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
	public History(String quizID, String usrID, String end) {		
		String command = "SELECT * FROM Histories WHERE quizID = \"" + quizID + "\" AND usrID =\"" + usrID + "\" AND end = \"" + end + "\";";
		ResultSet rs = QuizSystem.db.executeQuery(command);
		try {
			if (rs.next()) {
				String playmode = rs.getString("playmode");
				String start = rs.getString("start");
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
	public String getQuizID(){
		return quizID;
	}
	public String getUsrID(){
		return usrID;
	}
	public String getPlaymode(){
		return playmode;
	}
	public String getStartTime(){
		return start;
	}
	public String getEndTime(){
		return end;
	}
	public long getsSpan(){
		return span;
	}
	public double getScore(){
		return score;
	}
	public String getReview(){
		return review;
	}
	public double getRating(){
		return rating;
	}

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
		String saveStmt = "INSERT INTO Histories VALUES(" + saveValue + ");";
		System.out.println(saveStmt);
		return QuizSystem.db.executeUpdate(saveStmt); // if insert is failed, return false
	}

	/**
	 * Remove this piece of history from database
	 * @return whether removal is successful
	 */
	public boolean removeFromDB() {
		String stmt = "DELETE FROM Histories WHERE quizID = \"" + quizID + "\" AND usrID = \"" + usrID + "\" AND start = \"" + start + "\" AND end = \"" + end +  "\";";
		return QuizSystem.db.executeUpdate(stmt);
	}
	
	public static boolean removeByUserID(String usrID){
		String cmd = "DELETE FROM Histories WHERE usrID = \""+usrID+"\";";
		return QuizSystem.db.executeUpdate(cmd);
	}
	
	public static boolean removeByQuizID(String quizID){
		String cmd = "DELETE FROM Histories WHERE quizID = \""+quizID+"\";";
		return QuizSystem.db.executeUpdate(cmd);
	}
	

	public String toString(){
		String str = "";
		str += this.quizID;
		str += " ";
		str += this.usrID;
		str += " ";
		str += this.playmode;
		str += " ";
		str += this.start;
		str += " ";
		str += this.end;
		str += " ";
		str += String.valueOf(this.score);
		str += " ";
		str += this.review;
		str += " ";
		str += String.valueOf(rating);
		str += " ";
		str += String.valueOf(span);
		return str;
	}
}
