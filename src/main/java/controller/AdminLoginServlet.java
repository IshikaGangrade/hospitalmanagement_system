package controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AdminDAO;
import java.io.IOException;
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminLoginServlet() {
        super();   
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  response.sendRedirect("login.jsp");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		AdminDAO dao = new AdminDAO();
		boolean status = dao.login(email, password);
		if (status) {
			HttpSession session = request.getSession();
			session.setAttribute("admin", email);
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			//response.sendRedirect("index.jsp");
			return;
		} else {
			response.sendRedirect("login.jsp?error=1");
			return;
		}
	}
	}

