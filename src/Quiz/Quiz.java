package Quiz;


import java.lang.reflect.Array;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
/*
 * get quiz from db then set all the variables;
 * 
 * save a quiz to db---> save each component; separate functions;
 * 
 * get all variables to present to user; separate getters
 * 
 * 
 * 
 */
public class Quiz {
	// quiz info variables
	protected String quizID; //user could supply
	protected String quizName; //user could supply
	protected String description; //user could supply
	protected double rating = 0;
	protected String creator; //user could supply
	protected String createTime;
	protected String updateTime;


	// internal info
	protected ArrayList<String> tags; //user could supply
	protected ArrayList<Question> questions; //user could supply
	protected ArrayList<String> rankList; // {"Abc123 93" "FGERW123  89"}

	// quiz options
	protected boolean random_questions = false;
	protected boolean multiple_pages = false;
	protected boolean immediate_correction = false;
	//protected boolean practice_mode = false;

	static DataBase db = DataBase.getDataBase();

	/**
	 * Constructor when created by a user
	 */
	public Quiz() {
		this.quizID= "";		
		this.quizName = "";
		this.description = "";
		this.rating = 0;
		this.creator = "";
		this.createTime = "";
		this.updateTime = "";

		this.tags = new ArrayList<String>();
		this.questions = new ArrayList<Question>();
		this.rankList = new ArrayList<String>();
	}
	
	public Quiz(String name, String descrip, String creator,
				ArrayList<String> tags, ArrayList<Question> questions, 
				String spec) throws SQLException {	
		this.quizID= "";
		this.quizName = name;
		this.description = descrip;
		getRatingFromDB();
		this.creator = creator;
		this.createTime = "";
		this.updateTime = QuizSystem.generateCurrentTime();;
		this.tags = tags;
		this.questions = questions;
		 if(spec.contains("R")){
			 random_questions = true;
		 }
		 if(spec.contains("M")){
			 multiple_pages = true;
		 }
		 if(spec.contains("I")){
			 immediate_correction = true;
		 }
		
	}


	
	
	/**
	 * constructor from database
	 * 
	 * @throws SQLException
	 */
	public Quiz(String quizID) throws SQLException {
		this.quizID = quizID;
		try {
			getQuizfromDB();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private void getQuizfromDB() throws ClassNotFoundException, SQLException {
		String command = "SELECT * FROM Quizzes WHERE quizID = " + "\""
				+ quizID + "\";";
		ResultSet rs = db.executeQuery(command);
		if (rs.next()) {
			quizName = rs.getString("name");
			description = rs.getString("description");
			creator = rs.getString("creator");
			createTime = rs.getString("createTime");
			updateTime = rs.getString("updateTime");
			String spec = rs.getString("spec");
			 if(spec.contains("R")){
				 random_questions = true;
			 }
			 if(spec.contains("M")){
				 multiple_pages = true;
			 }
			 if(spec.contains("I")){
				 immediate_correction = true;
			 }
//			rs.close();
			getQuestionsFromDB();
			getRanksFromDB();
			getTagsFromDB();
			getRatingFromDB();
		}
	}
	private void getQuestionsFromDB() throws SQLException {
		questions = new ArrayList<Question>();
		String command = "SELECT * FROM ProblemBelongto WHERE quizID = " + "\""
				+ quizID + "\";";
		ResultSet rs = db.executeQuery(command);
		ArrayList<String> pids = new ArrayList<String>();
		while (rs.next()) {
			String pid = rs.getString("proID");
			pids.add(pid);
			System.out.println(pid);
//			questions.add(new Question(pid));
		}
		for(String pid:pids){
			questions.add(new Question(pid));
		}
		rs.close();
	}
	private void getRanksFromDB() throws SQLException {
		rankList = new ArrayList<String>();
		String command = "SELECT * FROM Histories WHERE quizID = " + "\""
				+ quizID + "\";";
		ResultSet rs = db.executeQuery(command);
		while (rs.next()) {
			String userid = rs.getString("usrID");
			double score = rs.getDouble("score");
			rankList.add(userid + " scored " + score);
		}
		rs.close();
	}
	private void getTagsFromDB() throws SQLException {
		tags = new ArrayList<String>();
		String command = "SELECT * FROM TagAssign WHERE quizID = " + "\""
				+ quizID + "\";";
		ResultSet rs = db.executeQuery(command);
		while (rs.next()) {
			String tag = rs.getString("tagsID");
			tags.add(tag);
		}
		rs.close();
	}
	private void getRatingFromDB() throws SQLException{
		rating = 0;
		int count = 0;
		String command = "SELECT * FROM Histories WHERE quizID = " + "\""
				+ quizID + "\";";
		ResultSet rs = db.executeQuery(command);
		while (rs.next()) {
			rating += rs.getInt("rating");
			count++;
		}
		if(count == 0) return;
		rating = rating/count;
		rs.close();
	}
	//getters
	public String getQuizID(){
		return quizID;
	}
	public String getQuizName(){
		return quizName;
	}
	public String getDescription(){
		return description;
	}
	public double getRating(){
		return rating;
	}
	public String getCreator(){
		return creator;
	}
	public String getCreatTime(){
		return createTime;
	}
	public String getUpdateTime(){
		return updateTime;
	}
	public ArrayList<String> getTags(){
		return tags;
	}
	public ArrayList<Question> getQuestions(){
		return questions;
	}
	public ArrayList<String> getRankList(){
		return 	rankList; 
	}	
	public String getSpec(){
		String spec = "";
		if(random_questions) spec+="R";
		if(multiple_pages) spec+="M";
		if(immediate_correction) spec+="I";
		return spec;
	}
	//setters
	public void updateQuizName(String name){
		quizName = name;
		String cmd = "UPDATE Quizzes SET name = \""+name
					+"\" WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
	}
	public void updateDescription(String description){
		this.description = description;
		String cmd = "UPDATE Quizzes SET description = \""+description
				+"\" WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
	}
	public void updateCreator(String userid){
		creator = userid;
		String cmd = "UPDATE Quizzes SET creator = \""+userid
				+"\" WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
	}
	public void updateCreateTime(String time){
		createTime = time;
		String cmd = "UPDATE Quizzes SET createTime = \""+time
				+"\" WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
	}
	public void updateUpdateTime(String time){
		updateTime = time;
		String cmd = "UPDATE Quizzes SET updateTime = \""+time
				+"\" WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
	}
	public void updatePlayType(String spec){
		 if(spec.contains("R")){
			 random_questions = true;
		 }else{
			 random_questions = false;
		 }
		 if(spec.contains("M")){
			 multiple_pages = true;
		 }else{
			 multiple_pages = false;
		 }
		 if(spec.contains("I")){
			 immediate_correction = true;
		 }else{
			 immediate_correction = false;
		 }
		String cmd = "UPDATE Quizzes SET spec = \""+spec
				+"\" WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
	}
	public void updateTags(ArrayList<String> newTags) throws SQLException{
		tags = newTags;
		String cmd = "DELETE FROM TagAssign WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
		for(String tag:newTags){
			cmd = "SELECT * from Tags WHERE tagsID = \""+tag+"\";";
			ResultSet rs = db.executeQuery(cmd);
			if(!rs.next()){
				cmd = "INSERT INTO Tags VALUES(\""+tag+"\");";
				db.executeUpdate(cmd);
			}
			rs.close();
			cmd = "INSERT TagAssign VALUES(\""+tag+"\",\""+quizID+"\");";
			db.executeUpdate(cmd);
		}
	}
	public void updateQuestions(ArrayList<Question> newQuest) throws SQLException{
		for(Question q:newQuest){
			q.saveProb();
		}
		questions = newQuest;
		String cmd = "DELETE FROM ProblemBelongto WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
		for(Question q:newQuest){
			cmd = "INSERT ProblemBelongto VALUES(\""+q.getProbID()+"\",\""+quizID+"\");";
			db.executeUpdate(cmd);
		}
	}
	public void saveToDB() throws SQLException{
		if(createTime.equals("")) createTime = QuizSystem.generateCurrentTime();
		if(updateTime.equals("")) updateTime = QuizSystem.generateCurrentTime();
		if(quizID.equals("")){
			quizID = creator+createTime;
		}
		String cmd = "REPLACE INTO Quizzes VALUE(\""+quizID+"\",\""+quizName+"\",\""+
				creator+"\",\""+createTime+"\",\""+updateTime+"\",\""+description+"\",\""+
				getSpec()+"\");";
			db.executeUpdate(cmd);
		updateTags(tags);
		updateQuestions(questions);
	}
	//randomlize question order
	public void shuffleQuestion(){
		Collections.shuffle(questions);
	}
	//
	private double gradeQuiz(ArrayList<ArrayList<String>> userQuizInput) {
		double score = 0;
		for (int i = 0; i < questions.size(); i++) {
			score += questions.get(i).grade(userQuizInput.get(i));
		}
		return score;
	}
	/**
	 * Remove all contents in quiz
	 */
	private void deleteQuiz() {
		String cmd = "DELETE FROM TagAssign WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
		cmd = "DELETE FROM ProblemBelongto WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
		cmd = "DELETE FROM Histories WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
		cmd = "DELETE FROM Quizzes WHERE quizID = \""+quizID+"\";";
		db.executeUpdate(cmd);
	}
	public static void deleteQuiz(String id) {
		String cmd = "DELETE FROM TagAssign WHERE quizID = \""+id+"\";";
		db.executeUpdate(cmd);
		cmd = "DELETE FROM ProblemBelongto WHERE quizID = \""+id+"\";";
		db.executeUpdate(cmd);
		cmd = "DELETE FROM Histories WHERE quizID = \""+id+"\";";
		db.executeUpdate(cmd);
		cmd = "DELETE FROM Quizzes WHERE quizID = \""+id+"\";";
		db.executeUpdate(cmd);
	}

}
