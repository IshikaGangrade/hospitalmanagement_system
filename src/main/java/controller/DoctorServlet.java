package controller;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collections;
import java.util.List;
import entity.Doctor;
import model.DoctorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/DoctorServlet")
public class DoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DoctorDAO doctorDAO;
    @Override
    public void init() throws ServletException {
        doctorDAO = new DoctorDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }
        List<Doctor> doctors = null;
        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Doctor doctor = doctorDAO.getDoctorById(id);
                if (doctor != null) {
                    request.setAttribute("editDoctor", doctor);
                } else {
                    request.setAttribute("errorMessage", "Doctor record not found.");
                }
            } else if ("search".equals(action)) {
                String name = request.getParameter("searchName");
                name = (name == null) ? "" : name.trim();
                request.setAttribute("searchName", name);
                doctors = doctorDAO.searchDoctors(name);
            }
            if (doctors == null) {
                doctors = doctorDAO.getAllDoctors();
            }
            String message = request.getParameter("message");
            if ("added".equals(message)) {
                request.setAttribute("message", "Doctor added successfully.");
            } else if ("updated".equals(message)) {
                request.setAttribute("message", "Doctor updated successfully.");
            } else if ("deleted".equals(message)) {
                request.setAttribute("message", "Doctor deleted successfully.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Please enter a valid Doctor ID.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Doctor Management could not load. Check Eclipse Console.");
        }
        if (doctors == null) {
            doctors = Collections.emptyList();
        }
        request.setAttribute("doctorList", doctors);
        if ("list".equals(request.getParameter("view"))) {
            request.setAttribute("showDoctorList", Boolean.TRUE);
        } else {
            request.setAttribute("showDoctor", Boolean.TRUE);
        }
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();
        try {
            if ("add".equals(action)) {

                Doctor doctor = readDoctor(request);

                if (doctorDAO.addDoctor(doctor)) {
                    response.sendRedirect(contextPath + "/DoctorServlet?message=added");
                    return;
                }
                request.setAttribute("errorMessage", "Doctor could not be added.");

            } else if ("update".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Doctor doctor = readDoctor(request);
                doctor.setId(id);

                if (doctorDAO.updateDoctor(doctor)) {
                    response.sendRedirect(contextPath + "/DoctorServlet?message=updated");
                    return;
                }
                request.setAttribute("errorMessage", "Doctor could not be updated.");
                request.setAttribute("editDoctor", doctor);

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                if (doctorDAO.deleteDoctor(id)) {
                    response.sendRedirect(contextPath + "/DoctorServlet?message=deleted");
                    return;
                }
                request.setAttribute("errorMessage", "Doctor could not be deleted.");

            } else {
                request.setAttribute("errorMessage", "Invalid Doctor action.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage",
                "Experience, Department ID and Doctor ID must be valid numbers.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Duplicate email, or the Department ID does not exist.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Doctor operation failed. Check Eclipse Console.");
        } 
        List<Doctor> doctors;
        try {
            doctors = doctorDAO.getAllDoctors();
        } catch (SQLException e) {
            e.printStackTrace();
            doctors = Collections.emptyList();
            if (request.getAttribute("errorMessage") == null) {
                request.setAttribute("errorMessage", "Could not load doctors.");
            }
        }
        request.setAttribute("doctorList", doctors);
        request.setAttribute("showDoctor", Boolean.TRUE);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    private Doctor readDoctor(HttpServletRequest request) {
        String name = request.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Name is required.");
        }
        int experience = Integer.parseInt(request.getParameter("experience").trim());
        if (experience < 0) {
            throw new IllegalArgumentException("Experience cannot be negative.");
        }
        int departmentId = Integer.parseInt(request.getParameter("departmentId").trim());
        Doctor doctor = new Doctor();
        doctor.setName(name.trim());
        doctor.setEmail(request.getParameter("email"));
        doctor.setPhone(request.getParameter("phone"));
        doctor.setSpecialization(request.getParameter("specialization"));
        doctor.setExperience(experience);
        doctor.setDepartmentId(departmentId);
        return doctor;
    }
}