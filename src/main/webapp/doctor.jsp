<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="entity.Doctor" %>
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
%>
<%
    @SuppressWarnings("unchecked")
    List<Doctor> doctorList = (List<Doctor>) request.getAttribute("doctorList");
    if (doctorList == null) {
        doctorList = Collections.emptyList();
    }
    Doctor editDoctor = (Doctor) request.getAttribute("editDoctor");
    boolean editing = editDoctor != null;

    String searchName = (String) request.getAttribute("searchName");
    if (searchName == null) {
        searchName = request.getParameter("searchName");
    }
    if (searchName == null) {
        searchName = "";
    }
    String message = (String) request.getAttribute("message");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<div class="doctor-page">
    <style>
        .doctor-page { width: 100%; padding: 24px; box-sizing: border-box; color: #243247; font-family: Arial, Helvetica, sans-serif; background: #f5f7fb; min-height: 100%; }
        .doctor-page * { box-sizing: border-box; }
        .doctor-page .doctor-heading { margin-bottom: 22px; }
        .doctor-page .doctor-heading h2 { margin: 0 0 7px; color:#1b2b78; font-size: 27px; font-weight: 700;  text-align:center }
        .doctor-page .doctor-alert { padding: 12px 15px; margin-bottom: 18px; border-radius: 7px; font-size: 14px; }
        .doctor-page .doctor-success { background: #e6f7ee; color: #167548; border: 1px solid #b9e8ce; }
        .doctor-page .doctor-error { background: #fff0f0; color: #b42318; border: 1px solid #ffd0d0; }
        .doctor-page .doctor-card { background: #fff; border: 1px solid #e6eaf1; border-radius: 12px; padding: 23px; margin-bottom: 24px; box-shadow: 0 3px 12px rgba(31, 51, 82, 0.05); }
        .doctor-page .doctor-card-title { margin: 0 0 21px; color: #243b64; font-size: 19px; font-weight: 700; }
        .doctor-page .doctor-form-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 18px 20px; }
        .doctor-page .doctor-field { min-width: 0; }
        .doctor-page .doctor-field label { display: block; margin-bottom: 8px; color: #35445c; font-size: 13px; font-weight: 600; }
        .doctor-page .doctor-field input, .doctor-page .doctor-field select { display: block; width: 100%; height: 43px; padding: 10px 12px; border: 1px solid #d9e0eb; border-radius: 7px; outline: none; background: #fff; color: #27364d; font-size: 14px; }
        .doctor-page .doctor-field input:focus, .doctor-page .doctor-field select:focus { border-color: #4268d5; box-shadow: 0 0 0 3px rgba(66, 104, 213, 0.10); }
        .doctor-page .doctor-form-actions { display: flex; gap: 10px; flex-wrap: wrap; margin-top: 22px; }
        .doctor-page .doctor-btn { display: inline-flex; align-items: center; justify-content: center; min-height: 40px; padding: 10px 17px; border: none; border-radius: 7px; text-decoration: none; cursor: pointer; font-size: 13px; font-weight: 600; transition: 0.2s ease; }
        .doctor-page .doctor-btn-primary { background: #315bd6; color: #fff; }
        .doctor-page .doctor-btn-primary:hover { background: #2449b5; color: #fff; }
        .doctor-page .doctor-btn-light { background: #edf1f7; color: #35445c; }
        .doctor-page .doctor-btn-light:hover { background: #dfe6f0; color: #243247; }
        .doctor-page .doctor-btn-edit { background: #eaf1ff; color: #2452bb; }
        .doctor-page .doctor-btn-delete { background: #fff0f0; color: #c62828; }
        .doctor-page .doctor-btn-edit:hover { background: #dbe7ff; }
        .doctor-page .doctor-btn-delete:hover { background: #ffe0e0; }
        .doctor-page .doctor-list-top { display: flex; align-items: center; justify-content: space-between; gap: 18px; flex-wrap: wrap; margin-bottom: 20px; }
        .doctor-page .doctor-list-top .doctor-card-title { margin: 0; }
        .doctor-page .doctor-search-form { display: flex; align-items: center; gap: 9px; flex-wrap: wrap; }
        .doctor-page .doctor-search-form input { width: 230px; max-width: 100%; height: 40px; padding: 9px 12px; border: 1px solid #d9e0eb; border-radius: 7px; font-size: 13px; outline: none; }
        .doctor-page .doctor-search-form input:focus { border-color: #4268d5; }
        .doctor-page .doctor-table-wrap { width: 100%; overflow-x: auto; }
        .doctor-page .doctor-table { width: 100%; border-collapse: collapse; min-width: 850px; }
        .doctor-page .doctor-table thead { background: #f0f4fb; }
        .doctor-page .doctor-table th { padding: 14px 12px; color: #52627a; text-align: left; font-size: 12px; font-weight: 700; white-space: nowrap; border-bottom: 1px solid #e1e7f0; }
        .doctor-page .doctor-table td { padding: 14px 12px; color: #445269; font-size: 13px; border-bottom: 1px solid #edf0f5; vertical-align: middle; }
        .doctor-page .doctor-table tbody tr:hover { background: #fafbfe; }
        .doctor-page .doctor-table tbody tr:last-child td { border-bottom: none; }
        .doctor-page .doctor-id { color: #315bd6; font-weight: 700; }
        .doctor-page .doctor-actions { display: flex; align-items: center; gap: 7px; flex-wrap: wrap; }
        .doctor-page .doctor-actions .doctor-btn { min-height: 32px; padding: 7px 10px; font-size: 12px; }
        .doctor-page .doctor-inline-form { display: inline; margin: 0; }
        .doctor-page .doctor-empty { padding: 30px 15px !important; text-align: center; color: #7a879a !important; }
        .doctor-page .doctor-count { margin-top: 15px; color: #748197; font-size: 12px; }
        @media (max-width: 1000px) { .doctor-page .doctor-form-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
        @media (max-width: 600px) {
            .doctor-page { padding: 14px; }
            .doctor-page .doctor-card { padding: 16px; }
            .doctor-page .doctor-form-grid { grid-template-columns: 1fr; }
            .doctor-page .doctor-list-top { align-items: stretch; }
            .doctor-page .doctor-search-form { width: 100%; }
            .doctor-page .doctor-search-form input { width: 100%; flex: 1 1 150px; }
        }
    </style>
    <div class="doctor-heading">
        <h2>Doctor Management</h2>   
    </div>
    <% if (message != null && !message.trim().isEmpty()) { %>
        <div class="doctor-alert doctor-success"><%= h(message) %></div>
    <% } %>
    <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
        <div class="doctor-alert doctor-error"><%= h(errorMessage) %></div>
    <% } %>
    <div class="doctor-card">
        <h3 class="doctor-card-title">
            <%= editing ? "Update Doctor Details" : "Add  Doctor" %>
        </h3>
        <form action="<%= request.getContextPath() %>/DoctorServlet" method="post">
            <input type="hidden" name="action" value="<%= editing ? "update" : "add" %>">
            <% if (editing) { %>
                <input type="hidden" name="id" value="<%= editDoctor.getId() %>">
            <% } %>
            <div class="doctor-form-grid">
                <div class="doctor-field">
                    <label for="doctorName">Doctor Name</label>
                    <input type="text" id="doctorName" name="name"
                           placeholder="Enter doctor name"
                           value="<%= editing ? h(editDoctor.getName()) : "" %>" required>
                </div>
                <div class="doctor-field">
                    <label for="doctorEmail">Email Address</label>
                    <input type="email" id="doctorEmail" name="email"
                           placeholder="Enter email address"
                           value="<%= editing ? h(editDoctor.getEmail()) : "" %>" required>
                </div>
                <div class="doctor-field">
                    <label for="doctorPhone">Phone Number</label>
                    <input type="tel" id="doctorPhone" name="phone"
                           placeholder="Enter phone number"
                           value="<%= editing ? h(editDoctor.getPhone()) : "" %>" required>
                </div>
                <div class="doctor-field">
                    <label for="doctorSpecialization">Specialization</label>
                    <input type="text" id="doctorSpecialization" name="specialization"
                           placeholder="e.g. Cardiologist"
                           value="<%= editing ? h(editDoctor.getSpecialization()) : "" %>" required>
                </div>
                <div class="doctor-field">
                    <label for="doctorExperience">Experience (Years)</label>
                    <input type="number" id="doctorExperience" name="experience"
                           placeholder="Enter years of experience" min="0"
                           value="<%= editing ? String.valueOf(editDoctor.getExperience()) : "" %>" required>
                </div>
                <div class="doctor-field">
                    <label for="doctorDepartment">Department ID</label>
                    <input type="number" id="doctorDepartment" name="departmentId"
                           placeholder="Enter department ID" min="1"
                           value="<%= editing ? String.valueOf(editDoctor.getDepartmentId()) : "" %>" required>
                </div>
            </div>
            <div class="doctor-form-actions">
                <button type="submit" class="doctor-btn doctor-btn-primary">
                    <%= editing ? "Update Doctor" : "Add Doctor" %>
                </button>
                <% if (editing) { %>
                    <a class="doctor-btn doctor-btn-light"
                       href="<%= request.getContextPath() %>/DoctorServlet">Cancel</a>
                <% } else { %>
                    <button type="reset" class="doctor-btn doctor-btn-light">Clear Form</button>
                <% } %>
            </div>
        </form>
    </div>

    <div class="doctor-card">
        <div class="doctor-list-top">
            <h3 class="doctor-card-title">Doctor List</h3>
            <form class="doctor-search-form"
                  action="<%= request.getContextPath() %>/DoctorServlet" method="get">
                <input type="hidden" name="action" value="search">
                <input type="text" name="searchName"
                       placeholder="Search by doctor name..."
                       value="<%= h(searchName) %>">
                <button type="submit" class="doctor-btn doctor-btn-primary">Search</button>
                <a class="doctor-btn doctor-btn-light"
                   href="<%= request.getContextPath() %>/DoctorServlet">View All</a>
            </form>
        </div>
        <div class="doctor-table-wrap">
            <table class="doctor-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Doctor Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Specialization</th>
                        <th>Experience</th>
                        <th>Department ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (doctorList.isEmpty()) { %>
                        <tr>
                            <td colspan="8" class="doctor-empty">No doctor records found.</td>
                        </tr>
                    <% } else { %>
                        <% for (Doctor doctor : doctorList) { %>
                            <tr>
                                <td class="doctor-id"><%= doctor.getId() %></td>
                                <td><%= h(doctor.getName()) %></td>
                                <td><%= h(doctor.getEmail()) %></td>
                                <td><%= h(doctor.getPhone()) %></td>
                                <td><%= h(doctor.getSpecialization()) %></td>
                                <td><%= doctor.getExperience() %> years</td>
                                <td><%= doctor.getDepartmentId() %></td>
                                <td>
                                    <div class="doctor-actions">
                                        <a class="doctor-btn doctor-btn-edit"
                                           href="<%= request.getContextPath() %>/DoctorServlet?action=edit&id=<%= doctor.getId() %>">
                                            Edit
                                        </a>
                                        <form class="doctor-inline-form"
                                              action="<%= request.getContextPath() %>/DoctorServlet"
                                              method="post"
                                              onsubmit="return confirm('Are you sure you want to delete this doctor?');">

                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<%= doctor.getId() %>">

                                            <button type="submit" class="doctor-btn doctor-btn-delete">Delete</button>
                                        </form>
                                    </div>
                                </td>
                           </tr>
                        <% } %>
                    <% } %>
                </tbody>
            </table>
        </div>
        <div class="doctor-count">
            Total doctors displayed: <strong><%= doctorList.size() %></strong>
        </div>
    </div>
</div>