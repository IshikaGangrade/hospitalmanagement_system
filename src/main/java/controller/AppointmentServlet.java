package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import entity.Appointment;
import model.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 3;
    private static final Set<String> STATUSES =Set.of("Pending", "Confirmed", "Completed", "Cancelled");
    private AppointmentDAO dao;
    @Override
    public void init() throws ServletException {
        dao = new AppointmentDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String q = clean(request.getParameter("q"));
        int page = parsePage(request.getParameter("page"));
        String action = request.getParameter("action");
        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(clean(request.getParameter("id")));
                Appointment ap = dao.getAppointmentById(id);

                if (ap != null) {
                    request.setAttribute("editAppointment", ap);
                } else {
                    request.setAttribute("errorMessage", "Appointment not found.");
                }
            }
            String message = request.getParameter("message");
            if ("added".equals(message)) {
                request.setAttribute("message", "Appointment added successfully.");
            } else if ("updated".equals(message)) {
                request.setAttribute("message", "Appointment updated successfully.");
            } else if ("deleted".equals(message)) {
                request.setAttribute("message", "Appointment deleted successfully.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Appointment ID.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
        showPage(request, response, q, page);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();
        try {
            if ("add".equals(action)) {
                Appointment ap = readAppointment(request);
                request.setAttribute("formAppointment", ap);

                if (dao.addAppointment(ap)) {
                    response.sendRedirect(contextPath + "/AppointmentServlet?message=added");
                    return;
                }
                request.setAttribute("errorMessage", "Appointment could not be added.");
            } else if ("update".equals(action)) {

                int id = Integer.parseInt(clean(request.getParameter("id")));
                Appointment ap = readAppointment(request);
                ap.setId(id);

                String status = clean(request.getParameter("status"));
                if (!STATUSES.contains(status)) {
                    throw new IllegalArgumentException("Invalid status.");
                }
                ap.setStatus(status);

                request.setAttribute("editAppointment", ap);

                if (dao.updateAppointment(ap)) {
                    response.sendRedirect(contextPath + "/AppointmentServlet?message=updated");
                    return;
                }
                request.setAttribute("errorMessage", "Appointment could not be updated.");

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(clean(request.getParameter("id")));

                if (dao.deleteAppointment(id)) {
                    response.sendRedirect(contextPath + "/AppointmentServlet?message=deleted");
                    return;
                }
                request.setAttribute("errorMessage", "Appointment could not be deleted.");

            } else {
                request.setAttribute("errorMessage", "Invalid Appointment action.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage",
                "Patient ID, Doctor ID aur Appointment ID sahi numbers hone chahiye.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Patient ID ya Doctor ID database mein maujood nahi hai.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }

        showPage(request, response, "", 1);
    }

    private void showPage(HttpServletRequest request, HttpServletResponse response,
                          String q, int page)
            throws ServletException, IOException {

        List<Appointment> list = Collections.emptyList();
        int totalPages = 1;

        try {
            int total = dao.countAppointments(q);
            totalPages = Math.max(1, (int) Math.ceil(total / (double) PAGE_SIZE));
            page = Math.min(page, totalPages);

            list = dao.getAppointments(q, page, PAGE_SIZE);

        } catch (SQLException e) {
            e.printStackTrace();
            if (request.getAttribute("errorMessage") == null) {
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            }
        }
        request.setAttribute("appointments", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchQuery", q);
        request.setAttribute("showAppointment", Boolean.TRUE);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    private Appointment readAppointment(HttpServletRequest request) {
        String date = clean(request.getParameter("appointmentDate"));
        String time = clean(request.getParameter("appointmentTime"));
        if (date.isEmpty() || time.isEmpty()) {
            throw new IllegalArgumentException("Date aur Time dono zaroori hain.");
        }
        int patientId = Integer.parseInt(clean(request.getParameter("patientId")));
        int doctorId = Integer.parseInt(clean(request.getParameter("doctorId")));

        if (patientId <= 0 || doctorId <= 0) {
            throw new IllegalArgumentException("Patient ID aur Doctor ID 1 ya usse bade hone chahiye.");
        }
        return new Appointment(date, time, patientId, doctorId);
    }
    private static String clean(String s) {
        return s == null ? "" : s.trim();
    }

    private static int parsePage(String s) {
        try {
            return Math.max(1, Integer.parseInt(clean(s)));
        } catch (NumberFormatException e) {
            return 1;
        }
    }
}