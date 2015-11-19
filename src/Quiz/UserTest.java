package Quiz;

import java.sql.SQLException;

public class UserTest {
	public static void main(String[] arg) throws SQLException {
		QuizSystem.getQuizSystem();
		System.out.println("getQuizSystem");

		/*
		User usr1 = new User("yuezhang", "passwordoriginal", false, 'a');
		User usr2 = new User("xiaotihu", "passwordoriginal2", true, 'a');
		Friend friend = new Friend(usr1.usrID, usr2.usrID);
		Friend friend2 = new Friend("yuezhang", "xinhuiwu");

		Friend.removeByUserID(usr1.usrID);
		usr1.saveToDB();
		usr2.saveToDB();
		usr1.addFriend(friend);
		usr2.addFriend(friend2);
		System.out.println("usr and friend finished");

		Message msg = new Message("yuezhang","xiaotihu","hello","Note");
		Message msg2 = new Message("xiaotihu","xinhuiwu","hi","Note");
		msg.saveToDB();
		msg2.saveToDB();
		//Message extract = new Message("yuezhang","xiaotihu","hello","Note","18/11/15 15:33:22");
		msg.removeFromDB();
		Message.removeByUserID("yuezhang");
		System.out.println("Message success.");

		Achievement achID = new Achievement("champion", "champion description");
		//achID.saveToDB();
		AchievementRecord achRec = new AchievementRecord("yuezhang", "champion");
		achRec.saveToDB();
		AchievementRecord achRec2 = new AchievementRecord("xinhuiwu", "champion");
		achRec2.saveToDB();
		AchievementRecord.removeByAchID("champion");
		
		//achRec.removeFromDB();
		//achID.removeFromDB();
		System.out.println("Achievement success.");
		System.out.println("All done.");
		//usr1.removeFromDB();
		//usr2.removeFromDB();
		//friend.removeFromDB();
		 *
		 */
	}
}