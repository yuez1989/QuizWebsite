package Quiz;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.sql.*;

public class Question{
	public static final String TYPE_MULTIPLECHOICE = "MC";
	public static final String TYPE_FREERESPONCE = "FREERESPONSE";
	public static final String TYPE_PICTURERESPONCE = "PICTURERESPONCE";
	public static final String TYPE_MATCHING = "MATCH";
	public static final String TYPE_BLANKFILL = "BLANK";
	public static final String TYPE_BLANKOPT = "BLANKOPT";
	
	protected String problemID;
	protected String context;
	protected String picutreUrl;
	protected ArrayList<ArrayList<String>> solutions;
	protected int numberOfSolutions;
	protected long timed;
	protected int order;
	protected String problemType;
	
	protected Statement sql_command;
	protected final String ANS_START = "<ans>";
	protected final String ANS_END = "</ans>";
	protected final String EC_START = "<ans-list>";
	protected final String EC_END = "</ans-list>";
	
	static final String OPT_START = "<option>";
	static final String OPT_END = "</option>";
	static final String OPTLEFT_START = "<option_left>";
	static final String OPTLEFT_END = "</option_left>";
	static final String OPTRIGHT_START = "<option_right>";
	static final String OPTRIGHT_END = "</option_right>";
	static final String BLANK = "<blank>";
	
	static String account = MyDBInfo.MYSQL_USERNAME;
	static String password = MyDBInfo.MYSQL_PASSWORD;
	static String server = MyDBInfo.MYSQL_DATABASE_SERVER;
	static String database = MyDBInfo.MYSQL_DATABASE_NAME;
	
	static DataBase db = DataBase.getDataBase();
		
	/**
	 * constructor for generic problem object in the database
	 * 
	 * @param pid, the problem ID in the database
	 * @param solID, the solution ID in the database
	 * @param timed, the problem ID in the database
	 * @throws SQLException 
	 */
	public Question(String pid) throws SQLException{
//		this.sql_command = sql_command;
		this.problemID = pid;
		try {
			getInfofromDB();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	/**
	 * user created new problem
	 */
	public Question(String context, String url, ArrayList<ArrayList<String>> solutions,
			long timed,String userID, int order,String type){
		this.context = context;
		this.picutreUrl = url;
		this.solutions = solutions;
		for(int i = 0; i<solutions.size(); i++){
			System.out.println(solutions.get(i).get(0));
		}
		this.numberOfSolutions = this.solutions.size();
		this.timed = timed;
		String time = Long.toString(System.currentTimeMillis());
		this.problemID = userID+time;
		this.order = order;
		this.problemType = type;
	}
	
	/**
	 * Another constructor - user created new problem, with user specify number of solutions
	 */
	public Question(String context, String url, ArrayList<ArrayList<String>> solutions, int numSol,
			long timed,String userID, int order,String type){
		this.context = context;
		this.picutreUrl = url;
		this.solutions = solutions;
		for(int i = 0; i<solutions.size(); i++){
			System.out.println(solutions.get(i).get(0));
		}
		this.numberOfSolutions = numSol;
		this.timed = timed;
		String time = Long.toString(System.currentTimeMillis());
		this.problemID = userID+time;
		this.order = order;
		this.problemType = type;
	}
	
	private void getInfofromDB() throws ClassNotFoundException, SQLException{
		context = new String();
		String command = "SELECT * FROM Problems WHERE proID = "+"\""+problemID+"\";";
		ResultSet rs= db.executeQuery(command);
		if(rs.next()){
			context= rs.getString("description");
			picutreUrl = rs.getString("picURL");
			String solstring = rs.getString("solution");
			parseStringtoSol(solstring);
			timed = rs.getLong("timed");
			order = rs.getInt("solorder");
			problemType = rs.getString("Type");
		}
	}
	
	public String getProbID(){
		return problemID;
	}
	public int getsolNum(){
		return this.numberOfSolutions;
	}

	// get the problem text	
	public String getText(){
		// get from database

		return parseContext();
	}
	
	public String getPic(){
		// get from database
		return picutreUrl;	
	}
	
	public ArrayList<ArrayList<String>> getAllSol(){
		// get from database
		return solutions;	
	}
	
	// get the solutions
	public ArrayList<String> getSol(){
		ArrayList<String> result = new ArrayList<String>();
		for(ArrayList<String> sols: solutions){
			result.add(sols.get(0));
		}
		return result;
		
	}
	public long getTime(){
		return timed;
	}
	
	public int getOrder(){
		return order;
	}
	
	public String getType(){
		return problemType;
	}
	
	public String getCurrentTime(){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date dateobj = new Date();
		return df.format(dateobj.getTime()).toString();
	}

	public double grade(ArrayList<String> userInput) {
		double score = 0;
		int iter = Math.min(userInput.size(), solutions.size());
		if(order>0){
			for(int i = 0; i<iter; i++){
				if(solutions.get(i).contains(userInput.get(i))){
					score++;
				}
			}
		}else{
			HashSet<Integer> sol= new HashSet<Integer>();
			for(String s: userInput){
				for(int i = 0; i<solutions.size(); i++){
					if(solutions.get(i).contains(s)){
						sol.add(i);
					}
				}
				
			}
			score = sol.size();
		}
		score = score/numberOfSolutions;
		return score;
	}

	public void saveProb() throws SQLException{
		String command = "SELECT * FROM Problems WHERE proID = "+"\""+problemID+"\";";
		ResultSet rs = db.executeQuery(command);
		if(rs.next()){
			System.out.println("This problem is ID ="+problemID+" exist! going to remove");
			command = "DELETE FROM ProblemBelongto WHERE proID = \""+problemID+"\";";
			db.executeUpdate(command);
			command = "DELETE FROM Problems WHERE proID = "+"\""+problemID+"\";";
			db.executeUpdate(command);
			System.out.println("This problem is ID ="+problemID+" is removed");
		}
		command = "INSERT INTO Problems VALUES("+"\""+problemID+"\","+"\""+context+"\","+
				"\""+picutreUrl+"\","+"\""+problemType+"\","+"\""+QuizSystem.generateCurrentTime()
				+"\","+timed+","+"\""+parseInputintoDB()+"\","+order+");";
		System.out.println(command);
		db.executeUpdate(command);		
	}
	public  void displayProblem(){};
	public  void displayProblemEdit(){};
	
	public String parseInputintoDB(){
		String sol= "";
		for(ArrayList<String> answers: solutions){
			sol += EC_START;
			for(String ans: answers){
				sol+=ANS_START;
				sol+=ans;
				sol+=ANS_END;
			}
			sol += EC_END;
		}
		return sol;
	}
	
	public void parseStringtoSol(String result){
		solutions = new ArrayList<ArrayList<String>>();
		while(result.length()>0){
			int index = result.indexOf(EC_START);
			if (index<0) return;
			result = result.substring(EC_START.length());
			ArrayList<String> oneAns = new ArrayList<String>();
			while(result.indexOf(EC_END)!=0){
				index = result.indexOf(ANS_START);
				if(index <0) break;
				result = result.substring(ANS_START.length());
				index = result.indexOf(ANS_END);
				if(index <0) return;
				String s = result.substring(0, index);
				oneAns.add(s);
				result = result.substring(index+ANS_END.length());
			}
			result = result.substring(EC_END.length());
			solutions.add(oneAns); 
		}
	}
	/**
	 * if this question is a multiple choice, return an arraylist of text for options
	 * @return option description. if it is not MC, return null
	 */
	public ArrayList<String> parseOption(){
		if(!this.problemType.equals(TYPE_MULTIPLECHOICE)){
			return null;
		}
		String[] choices = this.context.split(OPT_START);
		ArrayList<String> options = new ArrayList<String>();
		for(int i=1; i<choices.length; i++){
			options.add(choices[i].substring(0, choices[i].indexOf(OPT_END)));
		}
		return options;
	}
	
	public ArrayList<String> parseOptionleft(){
		if(!this.problemType.equals(TYPE_MATCHING)){
			return null;
		}
		String[] choices = this.context.split(OPTLEFT_START);
		ArrayList<String> options = new ArrayList<String>();
		for(int i=1; i<choices.length; i++){
			options.add(choices[i].substring(0, choices[i].indexOf(OPTLEFT_END)));
		}
		return options;
		
	}
	public ArrayList<String> parseOptionright(){
		if(!this.problemType.equals(TYPE_MATCHING)){
			return null;
		}
		String[] choices = this.context.split(OPTRIGHT_START);
		ArrayList<String> options = new ArrayList<String>();
		for(int i=1; i<choices.length; i++){
			options.add(choices[i].substring(0, choices[i].indexOf(OPTRIGHT_END)));
		}
		return options;
	}
	public String parseContext(){
		int optindex = context.indexOf(OPT_START);
		int optleftindex = context.indexOf(OPTLEFT_START);
		if(optindex == -1)
			optindex = Integer.MAX_VALUE;
		if(optleftindex == -1)
			optleftindex = Integer.MAX_VALUE;
		if(Math.min(optindex, optleftindex)==Integer.MAX_VALUE)
			return context;
		return context.substring(0,Math.min(optindex, optleftindex));
	}
	
	public static void main(String[] arg) throws SQLException{
		String context = "Write down the category of fruit in picture";
		//System.out.println(context);
		String picutreUrl="http://globe-views.com/dcim/dreams/orange/orange-04.jpg";
		ArrayList<ArrayList<String>> solutions = new ArrayList<ArrayList<String>>();
		ArrayList<String> p1 = new ArrayList<String>();
		p1.add("Orange");
		p1.add("orange");
		solutions.add(p1);
		
		long timed = 0;
		int order = 0;
		String problemType = TYPE_MATCHING;
		Question q = new Question(context, picutreUrl, solutions, 
				timed, "xiaotihu", order,problemType);
		try {
			q.saveProb();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

//		Question q = new Question("xiaotihu1448344148216");
//		ArrayList<String> options = q.parseOption();
//		for(String str: options){
//			System.out.println(str);
//		}
//		ArrayList<String> list = new ArrayList<String>();
//		list.add("B");
//		System.out.println(q.grade(list));

	}
	/*
	
	
	public static void main(String[] arg) throws SQLException{
//		Question q = new Question("ABC1231447305985620");
		String context = "Who's the first five presidents in US?";
		System.out.println(context);
		String picutreUrl="";
		ArrayList<ArrayList<String>> solutions = new ArrayList<ArrayList<String>>();
		ArrayList<String> p1 = new ArrayList<String>();
		p1.add("George Washington");
		p1.add("Washington");
		solutions.add(p1);
		ArrayList<String> p2 = new ArrayList<String>();
		p2.add("John Adams");
		p2.add("Adams");
		solutions.add(p2);
		ArrayList<String> p3 = new ArrayList<String>();
		p3.add("Thomas Jefferson");
		p3.add("Jefferson");
		solutions.add(p3);
		ArrayList<String> p4 = new ArrayList<String>();
		p4.add("James Madison");
		p4.add("Madison");
		solutions.add(p4);
		ArrayList<String> p5 = new ArrayList<String>();
		p5.add("James Monroe");
		p5.add("Monroe");
		solutions.add(p5);
		long timed = 0;
		int order = 0;
		String problemType = "FREERESPONSE";
//		Question(String context, String url, ArrayList<ArrayList<String>> solutions, long timed,
//				Statement sql_command, String userID, int order,String type)
		Question q = new Question(context, picutreUrl, solutions, 
				timed, "ABC123", order,problemType);
		try {
			q.saveProb();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		ArrayList<String> mysol = new ArrayList<String>();
//		
//		mysol.add("George Washington");
//		mysol.add("Adams");
//		//mysol.add("Thomas Jefferson");
//		mysol.add("Madison");
//		mysol.add("James Monroe");
//		System.out.println("my sol is:");
//		for(int i = 0; i<mysol.size(); i++){
//			System.out.println(mysol.get(i));
//		}
//		System.out.println("my grade is:"+q.grade(mysol));
//		ArrayList<String> correct = q.getSol();
//		System.out.println("solution is");
//		for(int i = 0; i<correct.size(); i++){
//			System.out.println(correct.get(i));
//		}
	}
	*/
}
