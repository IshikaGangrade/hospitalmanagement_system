package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import entity.Bill;
import model.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; 
    private static final int PAGE_SIZE = 3;
    private static final Set<String> STATUSES = Set.of("Pending", "Paid");
    private BillDAO dao;
    @Override
    public void init() throws ServletException {
        dao = new BillDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String search = clean(request.getParameter("search"));
        int page = parsePage(request.getParameter("page"));
        String action = request.getParameter("action");
        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(clean(request.getParameter("id")));
                Bill bill = dao.getBillById(id);

                if (bill != null) {
                    request.setAttribute("editBill", bill);
                } else {
                    request.setAttribute("errorMessage", "Bill not found.");
                }
            }
            String message = request.getParameter("message");
            if ("added".equals(message)) {
                request.setAttribute("message", "Bill saved successfully.");
            } else if ("updated".equals(message)) {
                request.setAttribute("message", "Bill updated successfully.");
            } else if ("deleted".equals(message)) {
                request.setAttribute("message", "Bill deleted successfully.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Bill ID.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }

        showPage(request, response, search, page);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String contextPath = request.getContextPath();
        try {
            if ("add".equals(action)) {
                Bill bill = readBill(request); 
                request.setAttribute("formBill", bill);
                if (dao.addBill(bill)) {
                    response.sendRedirect(contextPath + "/BillServlet?message=added");
                    return;
                }
                request.setAttribute("errorMessage", "Bill could not be saved.");
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(clean(request.getParameter("id")));
                Bill bill = readBill(request);
                bill.setId(id);
                request.setAttribute("editBill", bill);
                if (dao.updateBill(bill)) {
                    response.sendRedirect(contextPath + "/BillServlet?message=updated");
                    return;
                }
                request.setAttribute("errorMessage", "Bill could not be updated.");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(clean(request.getParameter("id")));
                if (dao.deleteBill(id)) {
                    response.sendRedirect(contextPath + "/BillServlet?message=deleted");
                    return;
                }
                request.setAttribute("errorMessage", "Bill could not be deleted.");
            } else {
                request.setAttribute("errorMessage", "Invalid Bill action.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Patient aur Amount sahi tarah se bharo.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Ye patient database mein maujood nahi hai.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
        showPage(request, response, "", 1);
    }
 
    private void showPage(HttpServletRequest request, HttpServletResponse response,
                          String search, int page)
            throws ServletException, IOException {
        List<Bill> list = Collections.emptyList();
        List<String[]> patients = Collections.emptyList();
        int totalPages = 1;
        try {
            int total = dao.countBills(search);
            totalPages = Math.max(1, (int) Math.ceil(total / (double) PAGE_SIZE));
            page = Math.min(page, totalPages);
            list = dao.getBills(search, page, PAGE_SIZE);
            patients = dao.getPatientOptions();
        } catch (SQLException e) {
            e.printStackTrace();
            if (request.getAttribute("errorMessage") == null) {
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            }
        }
        request.setAttribute("bills", list);
        request.setAttribute("patientOptions", patients);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchQuery", search);
        request.setAttribute("showBill", Boolean.TRUE);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    private Bill readBill(HttpServletRequest request) {
        int patientId = Integer.parseInt(clean(request.getParameter("patientId")));
        if (patientId <= 0) {
            throw new IllegalArgumentException("Pehle Patient select karo.");
        }
        double amount = Double.parseDouble(clean(request.getParameter("amount")));
        if (Double.isNaN(amount) || Double.isInfinite(amount) || amount < 0) {
            throw new IllegalArgumentException("Amount 0 ya usse zyada hona chahiye.");
        }
        String status = clean(request.getParameter("status"));
        if (!STATUSES.contains(status)) {
            throw new IllegalArgumentException("Status Pending ya Paid hona chahiye.");
        }
        return new Bill(patientId, amount, status);
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