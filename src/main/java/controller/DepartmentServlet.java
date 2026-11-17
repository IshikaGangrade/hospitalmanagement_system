package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collections;
import java.util.List;
import entity.Department;
import model.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DepartmentDAO departmentDAO;
    @Override
    public void init() throws ServletException {
        departmentDAO = new DepartmentDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }
        List<Department> departments = null;
        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Department department = departmentDAO.getDepartmentById(id);
                if (department != null) {
                    request.setAttribute("editDepartment", department);
                } else {
                    request.setAttribute("errorMessage", "Department not found.");
                }
            } else if ("search".equals(action)) {
                String name = request.getParameter("searchName");
                name = (name == null) ? "" : name.trim();
                request.setAttribute("searchName", name);
                departments = departmentDAO.searchDepartments(name);
            }
            if (departments == null) {
                departments = departmentDAO.getAllDepartments();
            }
            String message = request.getParameter("message");
            if ("added".equals(message)) {
                request.setAttribute("message", "Department added successfully.");
            } else if ("updated".equals(message)) {
                request.setAttribute("message", "Department updated successfully.");
            } else if ("deleted".equals(message)) {
                request.setAttribute("message", "Department deleted successfully.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Department ID.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Department page could not load. Check Eclipse Console.");
        }
        if (departments == null) {
            departments = Collections.emptyList();
        }
        request.setAttribute("departmentList", departments);
        request.setAttribute("showDepartment", Boolean.TRUE);
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
                Department department = readDepartment(request);
                request.setAttribute("formDepartment", department);
                if (departmentDAO.addDepartment(department)) {
                    response.sendRedirect(contextPath + "/DepartmentServlet?message=added");
                    return;
                }
                request.setAttribute("errorMessage", "Department could not be added.");
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Department department = readDepartment(request);
                department.setId(id);
                request.setAttribute("editDepartment", department);
                if (departmentDAO.updateDepartment(department)) {
                    response.sendRedirect(contextPath + "/DepartmentServlet?message=updated");
                    return;
                }
                request.setAttribute("errorMessage", "Department could not be updated.");

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                if (departmentDAO.deleteDepartment(id)) {
                    response.sendRedirect(contextPath + "/DepartmentServlet?message=deleted");
                    return;
                }
                request.setAttribute("errorMessage", "Department could not be deleted.");

            } else {
                request.setAttribute("errorMessage", "Invalid Department action.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Department ID.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Ye department delete/save nahi ho sakta: isse doctors jude hue hain "
                + "ya same naam pehle se maujood hai.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                "Department operation failed. Check Eclipse Console.");
        }
       
        List<Department> departments;
        try {
            departments = departmentDAO.getAllDepartments();
        } catch (SQLException e) {
            e.printStackTrace();
            departments = Collections.emptyList();
            if (request.getAttribute("errorMessage") == null) {
                request.setAttribute("errorMessage", "Could not load departments.");
            }
        }
        request.setAttribute("departmentList", departments);
        request.setAttribute("showDepartment", Boolean.TRUE);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    private Department readDepartment(HttpServletRequest request) {

        String name = request.getParameter("name");
        String description = request.getParameter("description");

        Department department = new Department();
        department.setName(name == null ? "" : name.trim());
        department.setDescription(description == null ? "" : description.trim());

        if (department.getName().isEmpty()) {
            // formDepartment set karne ke liye caller ko object chahiye, isliye pehle attribute
            request.setAttribute("formDepartment", department);
            throw new IllegalArgumentException("Department name is required.");
        }
        return department;
    }
}