package Quiz;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CreateAccountServlet
 */
@WebServlet("/CreateAccountServlet")
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAccountServlet() {
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
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		String accountname = (String)request.getParameter("account");
		String password = (String)request.getParameter("password");
		String passwordcopy = (String) request.getParameter("passwordcopy");
	
		DataBase db = ((QuizSystem)request.getServletContext().getAttribute("quizsystem")).db;
		// Database has the user
		ResultSet rs = db.executeQuery("select * from Users where usrID = \""+accountname+"\";");
		try {
			if(rs.next()){
				RequestDispatcher dispatcher = request.getRequestDispatcher("NameInUse.html");
				dispatcher.forward(request, response);
				return;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		// two password does not match
		if(!password.equals(passwordcopy)){
			RequestDispatcher dispatcher = request.getRequestDispatcher("PasswordMismatch.jsp");
			dispatcher.forward(request, response);
			return;
		}
		
		request.getSession().removeAttribute("user");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("UserLogin.jsp");
		dispatcher.forward(request, response);		
	}

}
