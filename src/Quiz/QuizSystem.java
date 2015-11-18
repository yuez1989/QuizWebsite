package Quiz;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class QuizSystem {
	static public QuizSystem qzsys;
	static public DataBase db;
	static public MessageDigest md = null;
	
	private QuizSystem(){
		 db = DataBase.getDataBase();
		 try {
			md = MessageDigest.getInstance("SHA");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	static public QuizSystem getQuizSystem(){
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
	static public String minusDay(Date in){

		LocalDateTime ldt = LocalDateTime.ofInstant(in.toInstant(), ZoneId.systemDefault());
		ldt.minusDays(1);
		Date out = Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
		return sdf.format(out);
	}
	static public void destroySystem(){
		db.disconnectDB();
	}
}
