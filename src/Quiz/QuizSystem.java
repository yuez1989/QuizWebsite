package Quiz;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

public class QuizSystem {
	static public QuizSystem qzsys;
	static public DataBase db;
	private QuizSystem(){
		 db = DataBase.getDataBase();
	}
	public QuizSystem getQuizSystem(){
		if(qzsys == null){
			qzsys = new QuizSystem();
		}
		return qzsys;
	}

	static public String generateCurrentTime(){
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");

		return sdf.format(d);
	}
}
