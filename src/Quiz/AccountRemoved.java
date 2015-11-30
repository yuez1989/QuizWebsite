package Quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AccountRemoved
 */
@WebServlet("/AccountRemoved")
public class AccountRemoved extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountRemoved() {
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
		String inputaccount = request.getParameter("attempted_account");
		ResultSet rs = QuizSystem.db.executeQuery("Select usrID from Users where usrID like \'%" + inputaccount+"%\';");
		ArrayList<String> similarids = new ArrayList<String>();
		try {
			while(rs.next()){
				similarids.add(rs.getString("usrID"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(similarids.isEmpty()){
			out.println("<h3>No accounts found.</h3>");
		}else if(similarids.size() == 1){
			out.print("<h3>One accounts found</h3>");
			Administrator admin = (Administrator)request.getSession().getAttribute("admin");
			admin.deleteUser(similarids.get(0));
			out.print("<p> You have Deleted "+similarids.get(0)+"</p>");
		}else{
			out.print("<h3>Do you mean...<h3>");
			for(String str:similarids){
				out.print("<p>"+str+"</p>");
			}
		}
		out.println("<p><a href = \'AdminHomePage.jsp\'>return to homepage...</p>");	
	}

}
