<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="entity.Bill" %>
<%!    
    private static String h(Object o) {
        if (o == null) return "";
        return o.toString()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    private static String statusClass(String s) {
        if ("Paid".equals(s)) return "bill-paid";
        if ("Pending".equals(s)) return "bill-pending";
        return "bill-other";
    }
%>
<%
    @SuppressWarnings("unchecked")
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    if (bills == null) {
        bills = Collections.emptyList();
    }

    @SuppressWarnings("unchecked")
    List<String[]> patientOptions = (List<String[]>) request.getAttribute("patientOptions");
    if (patientOptions == null) {
        patientOptions = Collections.emptyList();
    }

    Bill editBill = (Bill) request.getAttribute("editBill");
    Bill formBill = (Bill) request.getAttribute("formBill");
    boolean editing = editBill != null;

    Bill shown = editing ? editBill : formBill;
    int shownPatientId = (shown != null) ? shown.getPatientId() : 0;
    String shownAmount = (shown != null) ? String.valueOf(shown.getAmount()) : "";
    String shownStatus = (shown != null && shown.getStatus() != null) ? shown.getStatus() : "Pending";

    Integer cpObj = (Integer) request.getAttribute("currentPage");
    Integer tpObj = (Integer) request.getAttribute("totalPages");
    int currentPage = (cpObj == null) ? 1 : cpObj;
    int totalPages = (tpObj == null) ? 1 : tpObj;

    String search = (String) request.getAttribute("searchQuery");
    if (search == null) search = "";

    String billMessage = (String) request.getAttribute("message");
    String billError = (String) request.getAttribute("errorMessage");

    String ctx = request.getContextPath();
    String searchEnc = URLEncoder.encode(search, StandardCharsets.UTF_8);
    String pageBase = ctx + "/BillServlet?search=" + searchEnc + "&amp;page=";
%>
<div class="bill-page">
    <style>
        .bill-page { width: 96%; margin: 6px auto 30px; font-family: Arial, Helvetica, sans-serif; color: #243247; box-sizing: border-box; }
        .bill-page * { box-sizing: border-box; }
        .bill-page h1 { text-align: center; margin: 14px 0 22px; color: #1b2b78; font-size: 30px; }

        .bill-page .bill-alert { padding: 12px 15px; margin-bottom: 18px; border-radius: 7px; font-size: 14px; }
        .bill-page .bill-success { background: #e6f7ee; color: #167548; border: 1px solid #b9e8ce; }
        .bill-page .bill-error { background: #fff0f0; color: #b42318; border: 1px solid #ffd0d0; }

        .bill-page .bill-card { background: #fff; border-left: 4px solid #1b2b78; border-radius: 10px; padding: 20px 22px; margin-bottom: 22px; box-shadow: 0 3px 12px rgba(31, 51, 82, 0.10); }
        .bill-page .bill-card h3 { margin: 0 0 14px; color: #1b2b78; font-size: 18px; }

        .bill-page label { display: block; margin: 12px 0 6px; font-size: 14px; color: #243247; }
        .bill-page select, .bill-page input[type=number], .bill-page input[type=text] { width: 100%; padding: 10px 12px; border: 1px solid #d3d9e6; border-radius: 6px; font-size: 13px; background: #fbfbf4; outline: none; }
        .bill-page select:focus, .bill-page input:focus { border-color: #1b2b78; }

        .bill-page .bill-btnrow { display: flex; gap: 10px; margin-top: 16px; }
        .bill-page .bill-btn { padding: 9px 18px; border: none; border-radius: 5px; background: #1b2b78; color: #fff; font-size: 13px; cursor: pointer; text-decoration: none; display: inline-block; }
        .bill-page .bill-btn:hover { background: #14205e; color: #fff; }
        .bill-page .bill-btn-gray { background: #4b5a8a; }
        .bill-page .bill-btn-gray:hover { background: #3a4773; }

        .bill-page .bill-searchrow { display: flex; gap: 10px; }
        .bill-page .bill-searchrow input { flex: 1; background: #fbfbf4; }
        .bill-page .bill-searchrow .bill-btn { padding: 10px 22px; }

        .bill-page .bill-table-wrap { width: 100%; overflow-x: auto; }
        .bill-page .bill-table { width: 100%; border-collapse: collapse; min-width: 640px; }
        .bill-page .bill-table th { background: #1b2b78; color: #fff; padding: 12px 14px; font-size: 13px; text-align: left; }
        .bill-page .bill-table th:first-child { border-radius: 6px 0 0 0; }
        .bill-page .bill-table th:last-child { border-radius: 0 6px 0 0; }
        .bill-page .bill-table td { padding: 13px 14px; border-bottom: 1px solid #e3e7ef; font-size: 14px; color: #34435c; }
        .bill-page .bill-table tbody tr:hover { background: #fafbfe; }

        .bill-page .bill-paid { color: #2e7d32; font-weight: 600; }
        .bill-page .bill-pending { color: #e07b00; font-weight: 600; }
        .bill-page .bill-other { color: #55627a; }

        .bill-page .bill-actions { display: inline-flex; align-items: center; gap: 14px; }
        .bill-page .bill-edit { color: #1b2b78; font-size: 17px; text-decoration: none; }
        .bill-page .bill-edit:hover { color: #0d1850; }
        .bill-page .bill-del-form { margin: 0; display: inline; }
        .bill-page .bill-del { border: none; background: none; color: #1b2b78; font-size: 17px; cursor: pointer; padding: 0; }
        .bill-page .bill-del:hover { color: #d32020; }

        .bill-page .bill-pager { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 20px; flex-wrap: wrap; }
        .bill-page .bill-pager a, .bill-page .bill-pager span { min-width: 34px; padding: 7px 12px; border-radius: 5px; font-size: 13px; text-align: center; text-decoration: none; color: #1b2b78; }
        .bill-page .bill-pager a:hover { background: #eef1fb; }
        .bill-page .bill-pager .bill-active { background: #1b2b78; color: #fff; }
    </style>

    <h1>Bill Info</h1>

    <% if (billMessage != null && !billMessage.trim().isEmpty()) { %>
        <div class="bill-alert bill-success"><%= h(billMessage) %></div>
    <% } %>

    <% if (billError != null && !billError.trim().isEmpty()) { %>
        <div class="bill-alert bill-error"><%= h(billError) %></div>
    <% } %> 
    <div class="bill-card">
        <h3><i class="bi bi-receipt"></i> <%= editing ? "Update Bill" : "Add Bill" %></h3>

        <form action="<%= ctx %>/BillServlet" method="post">
            <input type="hidden" name="action" value="<%= editing ? "update" : "add" %>">
            <% if (editing) { %>
                <input type="hidden" name="id" value="<%= editBill.getId() %>">
            <% } %>

            <label for="billPatient">Patient</label>
            <select id="billPatient" name="patientId" required>
                <option value="">Select Patient</option>
                <% for (String[] p : patientOptions) { %>
                    <option value="<%= h(p[0]) %>"
                        <%= String.valueOf(shownPatientId).equals(p[0]) ? "selected" : "" %>>P-<%= h(p[0]) %> | <%= h(p[1]) %></option>
                <% } %>
            </select>

            <label for="billAmount">Amount</label>
            <input type="number" id="billAmount" name="amount" step="0.01" min="0"
                   value="<%= h(shownAmount) %>" required>

            <label for="billStatus">Status</label>
            <select id="billStatus" name="status">
                <option value="Pending" <%= "Pending".equals(shownStatus) ? "selected" : "" %>>Pending</option>
                <option value="Paid" <%= "Paid".equals(shownStatus) ? "selected" : "" %>>Paid</option>
            </select>

            <div class="bill-btnrow">
                <button type="submit" class="bill-btn">
                    <i class="bi bi-save"></i> <%= editing ? "Update" : "Save" %>
                </button>

                <% if (editing) { %>
                    <a class="bill-btn bill-btn-gray" href="<%= ctx %>/BillServlet">Cancel</a>
                <% } else { %>
                    <button type="reset" class="bill-btn bill-btn-gray">Reset</button>
                <% } %>
            </div>
        </form>
    </div>
    <div class="bill-card">
        <form class="bill-searchrow" action="<%= ctx %>/BillServlet" method="get">
            <input type="text" name="search" placeholder="Search by patient name..."
                   value="<%= h(search) %>">
            <button type="submit" class="bill-btn">Search</button>
        </form>
    </div>   
    <div class="bill-card">
        <h3>Bill List</h3>

        <div class="bill-table-wrap">
            <table class="bill-table">
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Patient ID</th>
                        <th>Patient Name</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% if (bills.isEmpty()) { %>

                    <tr>
                        <td colspan="6" style="text-align:center;color:#7a879a;">No bills found.</td>
                    </tr>

                <% } else { %>
                    <% for (Bill b : bills) { %>

                    <tr>
                        <td><%= h(b.getBillCode()) %></td>
                        <td><%= b.getPatientId() %></td>
                        <td><%= b.getPatientName() != null ? h(b.getPatientName()) : "Patient not found" %></td>
                        <td>&#8377;<%= b.getAmount() %></td>
                        <td><span class="<%= statusClass(b.getStatus()) %>"><%= h(b.getStatus()) %></span></td>
                        <td>
                            <div class="bill-actions">
                                <a class="bill-edit" title="Edit"
                                   href="<%= ctx %>/BillServlet?action=edit&amp;id=<%= b.getId() %>&amp;search=<%= searchEnc %>&amp;page=<%= currentPage %>">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <form class="bill-del-form"
                                      action="<%= ctx %>/BillServlet" method="post"
                                      onsubmit="return confirm('Are you sure you want to delete this bill?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= b.getId() %>">
                                    <button type="submit" class="bill-del" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                <% } %>
                </tbody>
            </table>
        </div> 
        <% if (totalPages > 1) { %>
            <div class="bill-pager">

                <% if (currentPage > 1) { %>
                    <a href="<%= pageBase + (currentPage - 1) %>">Prev</a>
                <% } %>

                <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                        <span class="bill-active"><%= i %></span>
                    <% } else { %>
                        <a href="<%= pageBase + i %>"><%= i %></a>
                    <% } %>
                <% } %>
                <% if (currentPage < totalPages) { %>
                    <a href="<%= pageBase + (currentPage + 1) %>">Next</a>
                <% } %>
            </div>
        <% } %>
    </div>
</div>