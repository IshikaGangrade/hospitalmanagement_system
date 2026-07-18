<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
 <div class="container-fluid p-0">
<div class="d-flex">

<div class="sidebar">
<div class="logo">
<h2>LifeCare MS</h2>
<p>General Hospital</p>
</div>

<ul>
 <li>
<a href="index.jsp">
<i class="bi bi-grid"></i>Dashboard</a>
</li>

<li>
<a href="patient.jsp">
<i class="bi bi-person"></i>Patients</a>
</li>

<li>
<a href="doctor.jsp">
<i class="bi bi-person-badge"></i>Doctors</a>     
</li>    
 <li>
<a href="department.jsp">
<i class="bi bi-building"></i>Departments</a>
</li>

<li>
<a href="appointment.jsp">
<i class="bi bi-calendar-check"></i>Appointments</a>
</li>

<li>
<a href="billing.jsp">
<i class="bi bi-wallet2"></i>Billing</a>
</li>
<li>
<a href="LogoutServlet">
<i class="bi bi-box-arrow-right"></i>Logout</a>
</li>
</ul>
</div>

<div class="main">
 <div class="topbar">
    <h2>Hospital Management</h2>
    <div class="nav-menu">
    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="#">About us</a>
        <a href="#">Doctors</a>
        <div class="user">
            <i class="fa-solid fa-user"></i>
            <span>ISHIKA GANGRADE</span>
        </div>
    </div>
</div>
 

<div class="hero">
<div class="left">

<h1>Making life Health Care Better Together</h1>
<p>Welcome to LifeCare MS, a smart and efficient Hospital Management System designed to simplify healthcare services
 Our platform helps manage patient records, doctor information, appointments, departments, and billing with accuracy and ease. 
 We are committed to delivering a secure, user-friendly, and reliable solution that improves hospital operations and enhances
  the overall patient experience.
</p>
<button class="btn btn-primary">Make Appointment</button>
<button class="btn btn-outline-primary">View Doctors</button>

</div>
<div class="right">

<img src="img/doctor.png"
class="img" alt="Doctor">
</div>
</div>


<section class="services">
    <h2>Our Services</h2>
    <p class="sub-title">We provide complete healthcare management solutions.</p>

    <div class="service-container">

        <div class="service-card">
            <i class="fa-solid fa-user-doctor service-icon"></i>
            <h3>Patient Management</h3>
            <p>Manage patient records and medical history efficiently.</p>
        </div>

        <div class="service-card">
            <i class="fa-solid fa-user-nurse service-icon"></i>
            <h3>Doctor Management</h3>
            <p>Maintain doctor profiles, schedules and information.</p>
        </div>

        <div class="service-card">
            <i class="fa-solid fa-calendar-check service-icon"></i>
            <h3>Appointments</h3>
            <p>Book and manage appointments quickly and easily.</p>
        </div>

        <div class="service-card">
            <i class="fa-solid fa-file-invoice-dollar service-icon"></i>
            <h3>Billing</h3>
            <p>Generate bills and manage payments efficiently.</p>
        </div>
    </div>
</section>

<footer class="footer">
<div class="footer-box">
<div class="footer-col">
<p>
Providing efficient hospital management solutions for better healthcare services.
</p>
</div>

<div class="footer-col">
<h4>Quick Links</h4>
<a href="index.jsp">Home</a>
<a href="#">About Us</a>
<a href="#">Doctors</a>
<a href="#">Contact</a>
</div>
<div class="footer-col">
<h4>Contact</h4>
<p><i class="fa-solid fa-phone"></i> +91 7999640721</p>
<p><i class="fa-solid fa-envelope"></i> lifecare@gmail.com</p>
<p><i class="fa-solid fa-location-dot"></i>Indore,India</p>
</div>
</div>
<hr>
<p class="copy">
© 2026 Hospital Management System | All Rights Reserved health care
</p>
</footer>
</div>
</div>
</div>

</body>
</html>