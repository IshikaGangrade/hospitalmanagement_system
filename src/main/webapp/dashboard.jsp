<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if(session.getAttribute("admin")==null){
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>

body{
    margin:0;
    background:#f4f6f9;
    font-family:Arial,sans-serif;
}

.sidebar{
    width:240px;
    height:100vh;
    position:fixed;
    background:#1e3a8a;
    color:white;
    padding-top:20px;
}

.sidebar h3{
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:15px 25px;
}

.sidebar a:hover{
    background:#3454d1;
}

.content{
    margin-left:240px;
    padding:30px;
}

.card{
    border:none;
    border-radius:15px;
    box-shadow:0 3px 10px rgba(0,0,0,.15);
}

</style>

</head>

<body>

<div class="sidebar">
<h3>Hospital HMS</h3>

<a href="dashboard.jsp">Dashboard</a>
<a href="doctor.jsp">Doctors</a>
<a href="patient.jsp">Patients</a>
<a href="appointment.jsp">Appointments</a>
<a href="department.jsp">Departments</a>
<a href="bill.jsp">Billing</a>
<a href="LogoutServlet">Logout</a>

</div>

<div class="content">

<h2>Welcome Admin</h2>

<div class="row mt-4">

<div class="col-md-3">
<div class="card p-4">
<h5>Total Doctors</h5>
<h2>10</h2>
</div>
</div>

<div class="col-md-3">
<div class="card p-4">
<h5>Total Patients</h5>
<h2>50</h2>
</div>
</div>

<div class="col-md-3">
<div class="card p-4">
<h5>Appointments</h5>
<h2>20</h2>
</div>
</div>

<div class="col-md-3">
<div class="card p-4">
<h5>Departments</h5>
<h2>8</h2>
</div>
</div>

</div>

</div>

</body>
</html>