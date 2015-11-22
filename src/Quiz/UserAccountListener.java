package Quiz;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class UserAccountListener
 *
 */
@WebListener
public class UserAccountListener implements HttpSessionListener {

	/**
	 * Default constructor. 
	 */
	public UserAccountListener() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
	 */
	public void sessionCreated(HttpSessionEvent arg0)  { 
		// TODO Auto-generated method stub
		User user = null;
		arg0.getSession().setAttribute("user", user);
	}

	/**
	 * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
	 */
	public void sessionDestroyed(HttpSessionEvent arg0)  { 
		// TODO Auto-generated method stub
		arg0.getSession().removeAttribute("user");
	}

}
