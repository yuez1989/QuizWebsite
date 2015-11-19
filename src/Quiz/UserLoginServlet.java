package Quiz;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User)request.getAttribute("user");
		
		if(user == null){
			String account = (String)request.getParameter("account");
			String password = (String)request.getParameter("password");
			MessageDigest msgdigest= ((QuizSystem)request.getServletContext().getAttribute("quizsystem")).md;
			DataBase db = ((QuizSystem)request.getServletContext().getAttribute("quizsystem")).db;
			msgdigest.reset();
			msgdigest.update(password.getBytes());
			byte[] inputpw = msgdigest.digest();
			
			// Database has the user
			ResultSet rs = db.executeQuery("select * from Users where usrID = \""+account+"\";");
			try {
				if(rs.next()){
					byte[] databasepw = rs.getBytes("password");
					if(Arrays.equals(inputpw, databasepw)){
						RequestDispatcher dispatcher = request.getRequestDispatcher("UserHomePage.jsp");
						dispatcher.forward(request, response);
						return;						
					}
				}
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("LoginError.html");
				dispatcher.forward(request, response);
				return;	
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
