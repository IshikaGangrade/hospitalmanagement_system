package controller;

import java.io.IOException;
import java.sql.SQLException;
import entity.DashboardData;
import model.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardDAO dashboardDAO;
    @Override
    public void init() {
        dashboardDAO = new DashboardDAO();
    }
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DashboardData data = dashboardDAO.getDashboardData();

            request.setAttribute("dashboardData", data);

            request.setAttribute("showDashboard", true);

            request.getRequestDispatcher("/index.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(
                "Dashboard Database Connection Failed", e
            );
        }
    }
}