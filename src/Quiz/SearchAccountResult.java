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
 * Servlet implementation class SearchAccountResult
 */
@WebServlet("/SearchAccountResult")
public class SearchAccountResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchAccountResult() {
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
		String inputaccount = request.getParameter("searched_account");
		ArrayList<String> list = Utilities.searchAccounts(inputaccount);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<h3>Search Results:</h3>");
		if(list.size() == 0){
			out.print("<p>None...</p>");
		}else{
			out.print("<ul>");
			for(String str:list){
				out.println("<li>"+str+"</li>");
			}
			out.print("</ul>");
		}
		out.println("<p><a href = \'AdminHomePage.jsp\'>return to homepage...</p>");	
	}

}
