<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.DashboardData,java.util.List,java.util.Map,java.text.SimpleDateFormat" %>

<%
    DashboardData data = (DashboardData) request.getAttribute("dashboardData");
    if (data == null) {
        out.println("<h3>Dashboard data not loaded. Open DashboardServlet.</h3>");
        return;
    }
    List<Map<String,Object>> recent = data.getRecentAppointments();
    List<Map<String,Object>> workload = data.getDoctorWorkload();
    List<Map<String,Object>> visits = data.getPatientVisitHistory();

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
%>
<style>
.lc-dashboard {
    padding:25px;
    background:#f5f6fc;
    color:#202944;
    font-family:Arial,sans-serif;
    min-height:100%;
}

.lc-head {
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:22px;
}

.lc-head h2 {
    font-size:27px;
    font-weight:bold;
}

.lc-cards {
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:17px;
    margin-bottom:22px;
}

.lc-stat {
    background:white;
    padding:22px;
    border-radius:12px;
    box-shadow:0 4px 15px rgba(0,0,0,.05);
}

.lc-stat-label {
    color:#777;
    font-size:14px;
    font-weight:bold;
}

.lc-stat-value {
    font-size:29px;
    font-weight:bold;
    margin-top:12px;
    color:#27375c;
}

.lc-grid {
    display:grid;
    grid-template-columns:1fr;
    gap:18px;
}

.lc-panel {
    background:white;
    padding:20px;
    border-radius:12px;
    margin-bottom:20px;
    box-shadow:0 4px 15px rgba(0,0,0,.05);
    min-width:0;
}

.lc-panel h3 {
    font-size:19px;
    font-weight:bold;
    margin-bottom:18px;
}

.lc-table {
    width:100%;
    border-collapse:collapse;
    min-width:500px;
}

.lc-table th {
    background:#26334a;
    color:white;
    padding:13px;
    text-align:left;
    font-size:13px;
}

.lc-table td {
    padding:13px;
    border-bottom:1px solid #eee;
    font-size:13px;
}

.lc-table-wrap {
    overflow-x:auto;
}

.lc-person {
    font-weight:bold;
}

.lc-status {
    padding:5px 10px;
    border-radius:20px;
    background:#fff1d6;
    color:#a66b0a;
    font-size:12px;
}

.lc-status.completed,
.lc-status.paid {
    background:#e3f7ed;
    color:green;
}

.lc-status.cancelled {
    background:#ffe5e5;
    color:red;
}

.lc-empty {
    text-align:center;
    padding:20px;
    color:#888;
}


.lc-workload-table {
    width:100%;
    border-collapse:collapse;
    min-width:400px;
}

.lc-workload-table th {
    background:#252525;
    color:white;
    padding:13px 15px;
    text-align:left;
    font-size:13px;
}

.lc-workload-table td {
    padding:13px 15px;
    border-bottom:1px solid #eee;
    font-size:13px;
    color:#26334a;
}

.lc-workload-table tbody tr:hover {
    background:#f5f7fc;
}

@media(max-width:1000px) {
    .lc-cards {
        grid-template-columns:repeat(2,1fr);
    }
    .lc-grid {
        grid-template-columns:1fr;
    }
}

@media(max-width:550px) {
    .lc-cards {
        grid-template-columns:1fr;
    }
}
</style>

<div class="lc-dashboard">
    <div class="lc-head">
        <div>
            <h2>Hospital Management</h2>
            <p>Welcome to LifeCare MS Dashboard</p>
        </div>
    </div>
    <div class="lc-cards">
        <div class="lc-stat">
            <div class="lc-stat-label">Total Patients</div>
            <div class="lc-stat-value">
                <%= data.getTotalPatients() %>
            </div>
        </div>

        <div class="lc-stat">
            <div class="lc-stat-label">Total Doctors</div>
            <div class="lc-stat-value">
                <%= data.getTotalDoctors() %>
            </div>
        </div>

        <div class="lc-stat">
            <div class="lc-stat-label">Total Appointments</div>
            <div class="lc-stat-value">
                <%= data.getTotalAppointments() %>
            </div>
        </div>

        <div class="lc-stat">
            <div class="lc-stat-label">Total Revenue</div>
            <div class="lc-stat-value">
                ₹ <%= data.getTotalRevenue() == null
                ? "0.00" : data.getTotalRevenue().toPlainString() %>
            </div>
        </div>

    </div>
    <div class="lc-grid">
        <div class="lc-panel">
            <h3>Recent Appointments</h3>
            <div class="lc-table-wrap">
            <table class="lc-table">
                <thead>
                    <tr>
                        <th>Patient</th>
                        <th>Doctor</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <% if(recent == null || recent.isEmpty()) { %>
                    <tr>
                        <td colspan="5" class="lc-empty">
                            No Appointments Found
                        </td>
                    </tr>
                <% } else {
                    for(Map<String,Object> row : recent) {
                        Object dt = row.get("appointment_date");
                        Object tm = row.get("appointment_time");
                %>
                    <tr>
                        <td class="lc-person">
                            <%= row.get("patient_name") %>
                        </td>

                        <td>
                            <%= row.get("doctor_name") %>
                        </td>

                        <td>
                            <%= dt instanceof java.util.Date
                            ? dateFormat.format((java.util.Date)dt) : dt %>
                        </td>

                        <td>
                            <%= tm instanceof java.util.Date
                            ? timeFormat.format((java.util.Date)tm) : tm %>
                        </td>

                        <td>
                            <span class="lc-status <%= String.valueOf(row.get("status")).toLowerCase() %>">
                                <%= row.get("status") %>
                            </span>
                        </td>
                    </tr>

                <% }} %>
                </tbody>
            </table>
            </div>
        </div>
        <div class="lc-panel">
            <h3>Doctor Workload Report</h3>
            <div class="lc-table-wrap">
                <table class="lc-workload-table">
                    <thead>
                        <tr>
                            <th>Doctor</th>
                            <th>Specialization</th>
                            <th>Total Appointments</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if(workload == null || workload.isEmpty()) { %>
                        <tr>
                            <td colspan="3" class="lc-empty">
                                No Doctors Found
                            </td>
                        </tr>

                    <% } else {

                        for(Map<String,Object> row : workload) {
                    %>

                        <tr>
                            <td class="lc-person">
                                <%= row.get("doctor_name") %>
                            </td>

                            <td>
                                <%= row.get("specialization") %>
                            </td>
                            <td>
                                <%= row.get("total_appointments") %>
                            </td>
                        </tr>

                    <% }} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="lc-panel">
        <h3>Patient Visit History</h3>
        <div class="lc-table-wrap">
        <table class="lc-table">
            <thead>
                <tr>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <% if(visits == null || visits.isEmpty()) { %>
                <tr>
                    <td colspan="5" class="lc-empty">
                        No Patient Visits Found
                    </td>
                </tr>
            <% } else {
                for(Map<String,Object> row : visits) {
                    Object dt = row.get("appointment_date");
                    Object tm = row.get("appointment_time");
            %>
                <tr>
                    <td class="lc-person">
                        <%= row.get("patient_name") %>
                    </td>
                    <td>
                        <%= row.get("doctor_name") %>
                    </td>
                    <td>
                        <%= dt instanceof java.util.Date
                        ? dateFormat.format((java.util.Date)dt) : dt %>
                    </td>
                    <td>
                        <%= tm instanceof java.util.Date
                        ? timeFormat.format((java.util.Date)tm) : tm %>
                    </td>
                    <td>
                        <span class="lc-status <%= String.valueOf(row.get("status")).toLowerCase() %>">
                            <%= row.get("status") %>
                        </span>
                    </td>
                </tr>
            <% }} %>
            </tbody>
        </table>
        </div>
    </div>
</div>