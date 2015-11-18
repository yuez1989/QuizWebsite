package Quiz;

import java.sql.SQLException;
import java.util.ArrayList;

public class AddProb {
	public static void main(String[] arg) throws SQLException{
		String context = "Name the first five presidents in US?";
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
		Question q1 = new Question(context, picutreUrl, solutions, 
				timed, "ABC123", order,problemType);
		try {
			q1.saveProb();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		context = "3+5=?";
		System.out.println(context);
		picutreUrl="";
		solutions = new ArrayList<ArrayList<String>>();
		p1 = new ArrayList<String>();
		p1.add("8");
//		p1.add("Washington");
		solutions.add(p1);
//		p2 = new ArrayList<String>();
//		p2.add("John Adams");
//		p2.add("Adams");
//		solutions.add(p2);
//		p3 = new ArrayList<String>();
//		p3.add("Thomas Jefferson");
//		p3.add("Jefferson");
//		solutions.add(p3);
//		p4 = new ArrayList<String>();
//		p4.add("James Madison");
//		p4.add("Madison");
//		solutions.add(p4);
//		p5 = new ArrayList<String>();
//		p5.add("James Monroe");
//		p5.add("Monroe");
//		solutions.add(p5);
		timed = 0;
		order = 0;
		problemType = "FREERESPONSE";
//		Question(String context, String url, ArrayList<ArrayList<String>> solutions, long timed,
//				Statement sql_command, String userID, int order,String type)
		Question q2 = new Question(context, picutreUrl, solutions, 
				timed, "ABC123", order,problemType);
		try {
			q2.saveProb();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		context = "Who won the super bowl in 2015?";
		System.out.println(context);
		picutreUrl="";
		solutions = new ArrayList<ArrayList<String>>();
		p1 = new ArrayList<String>();
		p1.add("New England Patriots");
		p1.add("Patriots");
		p1.add("New England");
		solutions.add(p1);
//		p2 = new ArrayList<String>();
//		p2.add("John Adams");
//		p2.add("Adams");
//		solutions.add(p2);
//		p3 = new ArrayList<String>();
//		p3.add("Thomas Jefferson");
//		p3.add("Jefferson");
//		solutions.add(p3);
//		p4 = new ArrayList<String>();
//		p4.add("James Madison");
//		p4.add("Madison");
//		solutions.add(p4);
//		p5 = new ArrayList<String>();
//		p5.add("James Monroe");
//		p5.add("Monroe");
//		solutions.add(p5);
		timed = 0;
		order = 0;
		problemType = "FREERESPONSE";
//		Question(String context, String url, ArrayList<ArrayList<String>> solutions, long timed,
//				Statement sql_command, String userID, int order,String type)
		Question q3 = new Question(context, picutreUrl, solutions, 
				timed, "ABC123", order,problemType);
		try {
			q3.saveProb();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		context = "List first three letter in order";
		System.out.println(context);
		picutreUrl="";
		solutions = new ArrayList<ArrayList<String>>();
		p1 = new ArrayList<String>();
		p1.add("A");
		p1.add("a");
		solutions.add(p1);
		p2 = new ArrayList<String>();
		p2.add("b");
		p2.add("B");
		solutions.add(p2);
		p3 = new ArrayList<String>();
		p3.add("C");
		p3.add("c");
		solutions.add(p3);
//		p4 = new ArrayList<String>();
//		p4.add("James Madison");
//		p4.add("Madison");
//		solutions.add(p4);
//		p5 = new ArrayList<String>();
//		p5.add("James Monroe");
//		p5.add("Monroe");
//		solutions.add(p5);
		timed = 0;
		order = 1;
		problemType = "FREERESPONSE";
//		Question(String context, String url, ArrayList<ArrayList<String>> solutions, long timed,
//				Statement sql_command, String userID, int order,String type)
		Question q4 = new Question(context, picutreUrl, solutions, 
				timed, "ABC123", order,problemType);
		try {
			q4.saveProb();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		context = "List last three letter in order";
		System.out.println(context);
		picutreUrl="";
		solutions = new ArrayList<ArrayList<String>>();
		p1 = new ArrayList<String>();
		p1.add("X");
		p1.add("x");
		solutions.add(p1);
		p2 = new ArrayList<String>();
		p2.add("Y");
		p2.add("y");
		solutions.add(p2);
		p3 = new ArrayList<String>();
		p3.add("Z");
		p3.add("z");
		solutions.add(p3);
//		p4 = new ArrayList<String>();
//		p4.add("James Madison");
//		p4.add("Madison");
//		solutions.add(p4);
//		p5 = new ArrayList<String>();
//		p5.add("James Monroe");
//		p5.add("Monroe");
//		solutions.add(p5);
		timed = 0;
		order = 1;
		problemType = "FREERESPONSE";
//		Question(String context, String url, ArrayList<ArrayList<String>> solutions, long timed,
//				Statement sql_command, String userID, int order,String type)
		Question q5 = new Question(context, picutreUrl, solutions, 
				timed, "ABC123", order,problemType);
		try {
			q5.saveProb();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
