<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="entity.Appointment" %>
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
    private static String doctorLabel(String name) {
        if (name == null || name.trim().isEmpty()) return "Doctor not found";
        String n = name.trim();
        String low = n.toLowerCase();
        return (low.startsWith("dr.") || low.startsWith("dr ")) ? n : "Dr. " + n;
    }
    private static String statusClass(String s) {
        if (s == null) return "appt-st-other";
        switch (s) {
            case "Completed": return "appt-st-done";
            case "Pending":   return "appt-st-pending";
            case "Confirmed": return "appt-st-confirmed";
            case "Cancelled": return "appt-st-cancel";
            default:          return "appt-st-other";
        }
    }
%>
<%
    @SuppressWarnings("unchecked")
    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    if (appointments == null) {
        appointments = Collections.emptyList();
    }
    Appointment editAppointment = (Appointment) request.getAttribute("editAppointment");
    Appointment formAppointment = (Appointment) request.getAttribute("formAppointment");
    Integer cpObj = (Integer) request.getAttribute("currentPage");
    Integer tpObj = (Integer) request.getAttribute("totalPages");
    int currentPage = (cpObj == null) ? 1 : cpObj;
    int totalPages = (tpObj == null) ? 1 : tpObj;
    String q = (String) request.getAttribute("searchQuery");
    if (q == null) q = "";
    String apMessage = (String) request.getAttribute("message");
    String apError = (String) request.getAttribute("errorMessage");
    String ctx = request.getContextPath();
    String qEnc = URLEncoder.encode(q, StandardCharsets.UTF_8);
    String pageBase = ctx + "/AppointmentServlet?q=" + qEnc + "&amp;page=";
    String[] statuses = {"Pending", "Confirmed", "Completed", "Cancelled"};
%>
<div class="appt-page">
    <style>
        .appt-page { width: 96%; margin: 18px auto 30px; background: #fff; padding: 26px 28px; border-radius: 12px; box-shadow: 0 4px 16px rgba(31, 51, 82, 0.12); font-family: Arial, Helvetica, sans-serif; color: #243247; box-sizing: border-box; }
        .appt-page * { box-sizing: border-box; }
        .appt-page h1 { text-align: center; margin: 0 0 24px; color: #1b2b78; font-size: 28px; }
        .appt-page h3 { margin: 0 0 14px; color: #1b2b78; font-size: 18px; }
        .appt-page .appt-alert { padding: 12px 15px; margin-bottom: 18px; border-radius: 7px; font-size: 14px; }
        .appt-page .appt-success { background: #e6f7ee; color: #167548; border: 1px solid #b9e8ce; }
        .appt-page .appt-error { background: #fff0f0; color: #b42318; border: 1px solid #ffd0d0; }
        .appt-page .appt-row { display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 18px; align-items: center; }
        .appt-page .appt-row input, .appt-page .appt-row select { padding: 10px 12px; width: 180px; border: 1px solid #cfd6e3; border-radius: 6px; font-size: 13px; background: #fff; outline: none; }
        .appt-page .appt-row input:focus, .appt-page .appt-row select:focus { border-color: #1b2b78; }
        .appt-page .appt-btn { background: #1b2b78; color: #fff; border: none; padding: 10px 20px; border-radius: 6px; font-size: 13px; cursor: pointer; text-decoration: none; display: inline-block; }
        .appt-page .appt-btn:hover { background: #14205e; color: #fff; }
        .appt-page .appt-btn-light { background: #edf1f7; color: #35445c; }
        .appt-page .appt-btn-light:hover { background: #dfe6f0; color: #243247; }
        .appt-page .appt-update-box { background: #f5f7fb; padding: 20px; border-radius: 8px; margin-bottom: 26px; border-left: 4px solid #1b2b78; }
        .appt-page hr { border: none; border-top: 1px solid #d7dce6; margin: 22px 0; }
        .appt-page .appt-search { display: flex; justify-content: flex-end; margin-bottom: 8px; }
        .appt-page .appt-search form { display: flex; gap: 8px; flex-wrap: wrap; justify-content: flex-end; }
        .appt-page .appt-search input { padding: 10px 12px; width: 240px; max-width: 100%; border: 1px solid #cfd6e3; border-radius: 6px; font-size: 13px; outline: none; }
        .appt-page .appt-search input:focus { border-color: #1b2b78; }
        .appt-page .appt-table-wrap { width: 100%; overflow-x: auto; }
        .appt-page .appt-table { width: 100%; border-collapse: collapse; min-width: 720px; }
        .appt-page .appt-table th { background: #1b2b78; color: #fff; padding: 12px; font-size: 13px; text-align: center; }
        .appt-page .appt-table th:first-child { border-radius: 8px 0 0 0; }
        .appt-page .appt-table th:last-child { border-radius: 0 8px 0 0; }
        .appt-page .appt-table td { padding: 12px; text-align: center; border-bottom: 1px solid #e3e7ef; font-size: 13px; color: #34435c; }
        .appt-page .appt-table tbody tr:hover { background: #fafbfe; }
        .appt-page .appt-status { display: inline-block; min-width: 86px; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: 700; }
        .appt-page .appt-st-done { background: #e6f7ee; color: #167548; }
        .appt-page .appt-st-pending { background: #fff4e0; color: #b26a00; }
        .appt-page .appt-st-confirmed { background: #e8f0ff; color: #2452bb; }
        .appt-page .appt-st-cancel { background: #fff0f0; color: #b42318; }
        .appt-page .appt-st-other { background: #eef0f4; color: #55627a; }
        .appt-page .appt-actions { display: inline-flex; align-items: center; gap: 14px; }
        .appt-page .appt-edit { color: #1b2b78; font-size: 18px; text-decoration: none; }
        .appt-page .appt-edit:hover { color: #0d1850; }
        .appt-page .appt-del-form { margin: 0; display: inline; }
        .appt-page .appt-del { border: none; background: none; color: #d32020; font-size: 18px; cursor: pointer; padding: 0; }
        .appt-page .appt-del:hover { color: #9d1010; }
        .appt-page .appt-pager { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 22px; flex-wrap: wrap; }
        .appt-page .appt-pager a, .appt-page .appt-pager span { min-width: 36px; padding: 8px 13px; border-radius: 6px; font-size: 13px; text-align: center; text-decoration: none; border: 1px solid #cfd6e3; background: #fff; color: #1b2b78; }
        .appt-page .appt-pager a:hover { background: #eef1fb; }
        .appt-page .appt-pager .appt-active { background: #1b2b78; color: #fff; border-color: #1b2b78; }
        .appt-page .appt-pager .appt-disabled { color: #a3adbf; background: #f4f6fa; cursor: default; }
        @media (max-width: 640px) {
            .appt-page { padding: 16px 14px; }
            .appt-page .appt-row input, .appt-page .appt-row select { width: 100%; }
            .appt-page .appt-search { justify-content: stretch; }
        }
    </style>
    <h1>Appointment Management</h1>
    <% if (apMessage != null && !apMessage.trim().isEmpty()) { %>
        <div class="appt-alert appt-success"><%= h(apMessage) %></div>
    <% } %>

    <% if (apError != null && !apError.trim().isEmpty()) { %>
        <div class="appt-alert appt-error"><%= h(apError) %></div>
    <% } %>
    <% if (editAppointment != null) { %>
        <div class="appt-update-box">
            <h3>Update Appointment</h3>
            <form action="<%= ctx %>/AppointmentServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= editAppointment.getId() %>">

                <div class="appt-row">
                    <input type="date" name="appointmentDate"
                           value="<%= h(editAppointment.getAppointmentDate()) %>" required>

                    <input type="time" name="appointmentTime"
                           value="<%= h(editAppointment.getAppointmentTime()) %>" required>

                    <input type="number" name="patientId" min="1" placeholder="Patient ID"
                           value="<%= editAppointment.getPatientId() %>" required>

                    <input type="number" name="doctorId" min="1" placeholder="Doctor ID"
                           value="<%= editAppointment.getDoctorId() %>" required>

                    <select name="status">
                        <% for (String st : statuses) { %>
                            <option value="<%= st %>"
                                <%= st.equals(editAppointment.getStatus()) ? "selected" : "" %>><%= st %></option>
                        <% } %>
                    </select>

                    <button type="submit" class="appt-btn">Update Appointment</button>
                    <a class="appt-btn appt-btn-light" href="<%= ctx %>/AppointmentServlet">Cancel</a>
                </div>
            </form>
        </div>
    <% } %>
    <h3>Add Appointment</h3>
    <form action="<%= ctx %>/AppointmentServlet" method="post">
        <input type="hidden" name="action" value="add">
        <div class="appt-row">
            <input type="date" name="appointmentDate"
                   value="<%= formAppointment != null ? h(formAppointment.getAppointmentDate()) : "" %>" required>

            <input type="time" name="appointmentTime"
                   value="<%= formAppointment != null ? h(formAppointment.getAppointmentTime()) : "" %>" required>

            <input type="number" name="patientId" min="1" placeholder="Patient ID"
                   value="<%= formAppointment != null ? String.valueOf(formAppointment.getPatientId()) : "" %>" required>

            <input type="number" name="doctorId" min="1" placeholder="Doctor ID"
                   value="<%= formAppointment != null ? String.valueOf(formAppointment.getDoctorId()) : "" %>" required>

            <button type="submit" class="appt-btn">Add Appointment</button>
        </div>
    </form>
    <hr> 
    <div class="appt-search">
        <form action="<%= ctx %>/AppointmentServlet" method="get">
            <input type="text" name="q" placeholder="Search Appointment"
                   value="<%= h(q) %>">
            <button type="submit" class="appt-btn">Search</button>
            <% if (!q.isEmpty()) { %>
                <a class="appt-btn appt-btn-light" href="<%= ctx %>/AppointmentServlet">Clear</a>
            <% } %>
        </form>
    </div> 
    <h3>Appointment List</h3>
    <div class="appt-table-wrap">
        <table class="appt-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <% if (appointments.isEmpty()) { %>
                <tr>
                    <td colspan="7">No Appointment Found</td>
                </tr>

            <% } else { %>
                <% for (Appointment ap : appointments) { %>

                <tr>
                    <td><%= ap.getId() %></td>
                    <td><%= ap.getPatientName() != null ? h(ap.getPatientName()) : "Patient not found" %></td>
                    <td><%= h(doctorLabel(ap.getDoctorName())) %></td>
                    <td><%= h(ap.getAppointmentDate()) %></td>
                    <td><%= h(ap.getAppointmentTime()) %></td>
                    <td>
                        <span class="appt-status <%= statusClass(ap.getStatus()) %>"><%= h(ap.getStatus()) %></span>
                    </td>
                    <td>
                        <div class="appt-actions">
                            <a class="appt-edit" title="Edit"
                               href="<%= ctx %>/AppointmentServlet?action=edit&amp;id=<%= ap.getId() %>&amp;q=<%= qEnc %>&amp;page=<%= currentPage %>">
                                <i class="bi bi-pencil-square"></i>
                            </a>

                            <form class="appt-del-form"
                                  action="<%= ctx %>/AppointmentServlet" method="post"
                                  onsubmit="return confirm('Are you sure you want to delete this appointment?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= ap.getId() %>">
                                <button type="submit" class="appt-del" title="Delete">
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
        <div class="appt-pager">

            <% if (currentPage > 1) { %>
                <a href="<%= pageBase + (currentPage - 1) %>">Prev</a>
            <% } else { %>
                <span class="appt-disabled">Prev</span>
            <% } %>

            <% for (int i = 1; i <= totalPages; i++) { %>
                <% if (i == currentPage) { %>
                    <span class="appt-active"><%= i %></span>
                <% } else { %>
                    <a href="<%= pageBase + i %>"><%= i %></a>
                <% } %>
            <% } %>

            <% if (currentPage < totalPages) { %>
                <a href="<%= pageBase + (currentPage + 1) %>">Next</a>
            <% } else { %>
                <span class="appt-disabled">Next</span>
            <% } %>

        </div>
    <% } %>
</div>