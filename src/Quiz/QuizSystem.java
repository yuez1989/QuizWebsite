package Quiz;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

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
// Example:	
//	static public void main(String[] args){
//		String nowstr = generateCurrentTime();
//		System.out.println(nowstr);
//		System.out.println(minusDay(convertToDate(nowstr)));
//		
//	}

	static public String generateCurrentTime(){
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");

		return sdf.format(d);
	}
	
	static public String minusDay(String datestr){

		Date in = convertToDate(datestr);
		LocalDateTime ldt = LocalDateTime.ofInstant(in.toInstant(), ZoneId.systemDefault());
		LocalDateTime nldt = ldt.minusDays(1);
		Date out = Date.from(nldt.atZone(ZoneId.systemDefault()).toInstant());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
		return sdf.format(out);
	}
	
	static public String minusDay(String datestr,int num){

		Date in = convertToDate(datestr);
		LocalDateTime ldt = LocalDateTime.ofInstant(in.toInstant(), ZoneId.systemDefault());
		LocalDateTime nldt = ldt.minusDays(num);
		Date out = Date.from(nldt.atZone(ZoneId.systemDefault()).toInstant());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
		return sdf.format(out);
	}
	

	static public Date convertToDate(String datetime){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return sdf.parse(datetime);
		} catch (java.text.ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return null;
		}

	}
	
	static public long timeSpan(String dat1,String dat2){
		Date dt1 = convertToDate(dat1);
		Date dt2 = convertToDate(dat2);
		return dt2.getTime() - dt1.getTime();
	}
	
	static public void destroySystem(){
		db.disconnectDB();
	}
	
	static public long timeSpan(Date dat1,Date dat2){
		return dat2.getTime()-dat1.getTime();
	}

}

