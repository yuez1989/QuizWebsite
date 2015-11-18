package Quiz;

import java.sql.SQLException;

public class UserTest {
	public static void main(String[] arg) throws SQLException {
		QuizSystem.getQuizSystem();
		System.out.println("getQuizSystem");
		User usr1 = new User("yuezhang", "passwordoriginal", false, 'a');
		System.out.println("usr1");
		/*
		User usr2 = new User("xinhuiwu", "passwordoriginal2", true, 'a');
		System.out.println("usr2");
		Friend friend = new Friend(usr1.usrID, usr2.usrID);
		System.out.println("friend");
		usr1.addFriend(friend);
		*/
		usr1.saveToDB();
		//usr2.saveToDB();
		System.out.println("User and friend added");
		usr1.removeFromDB();
		//usr2.removeFromDB();
	}
}