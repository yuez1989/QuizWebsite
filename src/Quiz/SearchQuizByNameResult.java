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
 * Servlet implementation class SearchQuizByNameResult
 */
@WebServlet("/SearchQuizByNameResult")
public class SearchQuizByNameResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchQuizByNameResult() {
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
		String inputquizName = request.getParameter("searched_quizName");
		ArrayList<String> list = Utilities.searchQuizzesByName(inputquizName);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<h3>Search Results:</h3>");
		if(list.size() == 0){
			out.print("<p>None...</p>");
		}else{
			out.print("<ul>");
			for(String str:list){
				String[] spice = str.split("##");
				String quizurl = spice[0];
				String genstr = spice[0]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+spice[1];
				out.println("<li><a href = \'QuizHomePage.jsp?quizID="+quizurl+"\' target='_blank'>"+genstr+"</a></li>");
			}
			out.print("</ul>");
		}
		out.println("<p><a href = \'AdminHomePage.jsp\'>return to homepage...</p>");
	}

}
