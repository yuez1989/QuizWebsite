package Quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class QuizRemoved
 */
@WebServlet("/QuizRemoved")
public class QuizRemoved extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizRemoved() {
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
		String inputquizID = request.getParameter("attempted_quizID");
		ArrayList<String> similarids = Utilities.searchQuizzes(inputquizID);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(similarids.isEmpty()){
			out.println("<h3>No quiz found.</h3>");
		}else if(similarids.size() == 1){
			out.print("<h3>One quiz found</h3>");
			Administrator admin = (Administrator)request.getSession().getAttribute("admin");
			admin.deleteQuiz(similarids.get(0));
			out.print("<p> You have Deleted "+similarids.get(0)+"</p>");
		}else{
			out.print("<h3>Do you mean...<h3>");
			out.print("<ul>");
			for(String str:similarids){
				out.print("<li>"+str+"</li>");
			}
			out.print("</ul>");
		}
		out.println("<p><a href = \'AdminHomePage.jsp\'>return to homepage...</p>");
	}

}