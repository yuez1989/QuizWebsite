package Quiz;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

public class QuizTest {
	public static void main(String[] arg) throws SQLException{
		
		 String quizName = "MC_quiz";
		 String description = "this quiz has MC for test!";
		 String creator = "xiaotihu";


		// internal info
		 ArrayList<String> tags = new  ArrayList<String>();
		 ArrayList<Question> questions = new ArrayList<Question>();
		 questions.add(new Question("xiaotihu1448331783449"));
		 questions.add(new Question("xiaotihu1448344148216"));
		 questions.add(new Question("xiaotihu1448346260149"));
		 questions.add(new Question("xiaotihu1448348595340"));
		 

		 Quiz quiz = new Quiz("xiaotihu2015-11-23 19:12:15");
		 quiz.updateQuestions(questions);
		 
//		DataBase db = QuizSystem.getQuizSystem().db;
//		ResultSet rs = db.executeQuery("select proID from Problems where proID like \'xiaotihu%\';");
//		while(rs.next()){
//			System.out.println(rs.getString(1));
//		}
		
//		Quiz.deleteQuiz("Abc1232015-11-18 11:50:00");
		
		
		
		
		
//		Quiz myquizUser = new Quiz("QUIZ ID");
		
		
		
		
		
		
		
		
		
//		
//		Quiz myquizDB = new Quiz("Abc1232015-11-17 01:14:07");
//		System.out.println("quiz name is "+ myquizDB.getQuizName());
//		System.out.println("quiz description is "+ myquizDB.getDescription());
//		System.out.println("quiz rating is "+ myquizDB.getRating());
//		System.out.println("quiz creator is "+ myquizDB.getCreator());
//		System.out.println("quiz creatTime is "+ myquizDB.getCreatTime());
//		System.out.println("quiz updateTime is "+ myquizDB.getUpdateTime());
//		System.out.println("quiz tags is "+ myquizDB.getTags());
//		System.out.println("quiz rankList is "+ myquizDB.getRankList());
//		System.out.println("quiz has following quizzes:");
//		for(Question q:myquizDB.getQuestions()){
//			System.out.println("Questoin ids: "+q.getProbID());
//		}
		
	}

}
