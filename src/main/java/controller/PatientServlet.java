package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PatientDAO;
import entity.Patient;
import java.io.IOException;
import java.util.List;
@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    PatientDAO dao = new PatientDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	String action = request.getParameter("action");
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Patient patient = dao.getPatientById(id);
                request.setAttribute("editPatient", patient);
            }
            List<Patient> patients = dao.getAllPatients();
            request.setAttribute("patients", patients);
            request.setAttribute("showPatient", true);
            request.getRequestDispatcher("index.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    protected void doPost(HttpServletRequest request,   HttpServletResponse response  )throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String gender = request.getParameter("gender");
                int age = Integer.parseInt(
                        request.getParameter("age")
                );
                String address = request.getParameter("address");
                String disease = request.getParameter("disease");
                String blood = request.getParameter("blood");
                Patient p = new Patient( name, email, phone, gender, age, address, disease, blood);

                dao.addPatient(p);
                response.sendRedirect("PatientServlet");
            }
            else if ("search".equals(action)) {
                String name = request.getParameter("name");
                List<Patient> result =
                        dao.searchPatient(name);
                request.setAttribute("result", result);
                request.setAttribute("showPatient", true);

                request.getRequestDispatcher("index.jsp")
                       .forward(request, response);
            }
            else if ("delete".equals(action)) {

                int id = Integer.parseInt(
                        request.getParameter("id")
                );
                dao.deletePatient(id);
                response.sendRedirect("PatientServlet");
            }
            else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String gender = request.getParameter("gender");
                int age = Integer.parseInt(request.getParameter("age"));
                String address = request.getParameter("address");
                String disease = request.getParameter("disease");
                String blood = request.getParameter("blood");
                Patient p = new Patient(
                    name, email, phone, gender, age,
                    address, disease, blood
                );
                p.setPatientId(id);
                dao.updatePatient(p);
                response.sendRedirect("PatientServlet");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}