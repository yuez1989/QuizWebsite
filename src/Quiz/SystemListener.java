package Quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


/**
 * Application Lifecycle Listener implementation class SystemListener
 *
 */
@WebListener
public class SystemListener implements ServletContextListener {

	/**
	 * Default constructor. 
	 */
	public SystemListener() {


		// TODO Auto-generated constructor stub
	}

	/**
	 * @see ServletContextListener#contextDestroyed(ServletContextEvent)
	 */
	public void contextDestroyed(ServletContextEvent arg0)  { 
		// TODO Auto-generated method stub
		QuizSystem mysystem = (QuizSystem)arg0.getServletContext().getAttribute("quizsystem");
		mysystem.destroySystem();
		arg0.getServletContext().removeAttribute("quizsystem");
	}

	/**
	 * @see ServletContextListener#contextInitialized(ServletContextEvent)
	 */
	public void contextInitialized(ServletContextEvent arg0)  { 
		QuizSystem mysystem = QuizSystem.getQuizSystem();
		arg0.getServletContext().setAttribute("quizsystem", mysystem);
		// TODO Auto-generated method stub
	}

}
