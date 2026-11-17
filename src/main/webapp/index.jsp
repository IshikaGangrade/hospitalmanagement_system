<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="64kb" autoFlush="true"%>
<%
boolean showDashboardSection =request.getAttribute("showDashboard") != null;
boolean showDoctorSection = Boolean.TRUE.equals(request.getAttribute("showDoctor"));
boolean showDoctorListSection = Boolean.TRUE.equals(request.getAttribute("showDoctorList"));
boolean showDepartmentSection = Boolean.TRUE.equals(request.getAttribute("showDepartment"));
boolean showBillSection = Boolean.TRUE.equals(request.getAttribute("showBill"));
boolean showPatientSection = request.getAttribute("showPatient") != null;
boolean showAppointmentSection = request.getAttribute("showAppointment") != null;
boolean showAboutSection = request.getAttribute("showAbout") != null;
boolean anySection = showDashboardSection ||showDoctorSection || showDoctorListSection ||showDepartmentSection|| showBillSection ||showPatientSection
                         || showAppointmentSection || showAboutSection;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
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
            <li><a href="${pageContext.request.contextPath}/DashboardServlet"><i class="bi bi-grid"></i>Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/PatientServlet"><i class="bi bi-person"></i> Patients</a></li>
            <li><a href="${pageContext.request.contextPath}/DoctorServlet"><i class="bi bi-person-badge"></i> <span>Doctors</span></a></li>
            <li><a href="${pageContext.request.contextPath}/DepartmentServlet"><i class="bi bi-building"></i> Departments</a></li>
            <li><a href="${pageContext.request.contextPath}/AppointmentServlet"><i class="fa fa-calendar"></i> Appointments</a></li>
            <li><a href="${pageContext.request.contextPath}/BillServlet"><i class="bi bi-wallet2"></i> Billing</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </div>
    <div class="main">
        <div class="topbar">
            <h2>Hospital Management System</h2>

            <div class="nav-menu">
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="#" onclick="showAbout(); return false;">About</a>
                <a href="${pageContext.request.contextPath}/DoctorServlet?view=list">Doctors</a>
                <div class="user">
                    <i class="fa-solid fa-user"></i>
                    <span>ISHIKA GANGRADE</span>
                </div>
            </div>
        </div>
<div id="dashboardSection"
     style="<%= showDashboardSection ? "display:block;" : "display:none;" %>">

    <% if (showDashboardSection) { %>

        <jsp:include page="/dashboard.jsp" />

    <% } %>

</div>
        <div id="heroSection" class="hero"
             style="<%= anySection ? "display:none;" : "display:flex;" %>">
            <div class="left">
                <h1>Making life Health Care Better Together</h1>

                <p>
                    Welcome to LifeCare MS, a smart and efficient Hospital
                    Management System designed to simplify healthcare services.
                    Our platform helps manage patient records, doctor information,
                    appointments, departments, and billing with accuracy and ease.
                    We are committed to delivering a secure, user-friendly,
                    and reliable solution that improves hospital operations
                    and enhances the overall patient experience.
                </p>

                 <a href="${pageContext.request.contextPath}/AppointmentServlet" class="btn btn-outline-primary">Make Appointment</a>
                <a href="${pageContext.request.contextPath}/DoctorServlet?view=list" class="btn btn-outline-primary">View Doctors</a>
            </div>

            <div class="right">
                <img src="${pageContext.request.contextPath}/img/doctor.png" class="img" alt="Doctor">
            </div>
        </div>
        <section id="servicesSection" class="services"
                 style="<%= anySection ? "display:none;" : "display:block;" %>">

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
        <div id="aboutSection" style="<%= showAboutSection ? "display:block;" : "display:none;" %>">
            <%
                try {
            %>
                <jsp:include page="/about.jsp" />
            <%
                } catch (Throwable t) {
                    out.println("<div style='color:red;padding:15px;'>about.jsp error: "
                        + t + "</div>");
                    t.printStackTrace();
                }
            %>
        </div>
        
        <div id="appointmentSection"
             style="<%= showAppointmentSection ? "display:block;" : "display:none;" %>">
            <% if (showAppointmentSection) {
                   try { %>
                <jsp:include page="/appointment.jsp" />
            <%     } catch (Throwable t) {
                       out.println("<div style='color:red;padding:15px;'>appointment.jsp error: "
                           + t + "</div>");
                       t.printStackTrace();
                   }
               } %>
        </div>
        
        <div id="patientSection"
             style="<%= showPatientSection ? "display:block;" : "display:none;" %>">
            <% if (showPatientSection) {
                   try { %>
                <jsp:include page="/patient.jsp" />
            <%     } catch (Throwable t) {
                       out.println("<div style='color:red;padding:15px;'>patient.jsp error: "
                           + t + "</div>");
                       t.printStackTrace();
                   }
               } %>
        </div>
        <div id="billSection"
             style="<%= showBillSection ? "display:block;" : "display:none;" %>">
            <% if (showBillSection) {
                   try { %>
                <jsp:include page="/bill.jsp" />
            <%     } catch (Throwable t) {
                       out.println("<div style='color:red;padding:15px;'>bill.jsp error: "
                           + t + "</div>");
                       t.printStackTrace();
                   }
               } %>
        </div>
        <div id="departmentSection"
             style="<%= showDepartmentSection ? "display:block;" : "display:none;" %>">
            <% if (showDepartmentSection) {
                   try { %>
                <jsp:include page="/department.jsp" />
            <%     } catch (Throwable t) {
                       out.println("<div style='color:red;padding:15px;'>department.jsp error: "
                           + t + "</div>");
                       t.printStackTrace();
                   }
               } %>
        </div>
        
      <div id="doctorListSection"
     style="<%= showDoctorListSection ? "display:block;" : "display:none;" %>">
    <% if (showDoctorListSection) { %>
        <jsp:include page="/doctor_list.jsp" />
    <% } %>
     </div>
 
        <div id="doctorSection"
             style="<%= showDoctorSection ? "display:block;" : "display:none;" %>">
            <% if (showDoctorSection) {
                   try { %>
                <jsp:include page="/doctor.jsp" />
            <%     } catch (Throwable t) {
                       out.println("<div style='color:red;padding:15px;'>doctor.jsp error: "
                           + t + "</div>");
                       t.printStackTrace();
                   }
               } %>
        </div>
        <script>
            function hideAllSections() {
                var ids = ["dashboardSection","heroSection", "servicesSection", "aboutSection",
                           "appointmentSection", "patientSection", "doctorSection", "doctorListSection" , "departmentSection", "billSection"
        ];
                ids.forEach(function (id) {
                    var s = document.getElementById(id);
                    if (s) s.style.display = "none";
                });
                var footer = document.getElementById("footerSection");
                if (footer) footer.style.display = "none";
            }

            function showAbout() {
                hideAllSections();
                var about = document.getElementById("aboutSection");
                if (about) about.style.display = "block";
            }
        </script>
        <footer id="footerSection" class="footer"
                style="<%= anySection ? "display:none;" : "display:block;" %>">
            <div class="footer-box">
                <div class="footer-col">
                    <p>Providing efficient hospital management solutions for better healthcare services.</p>
                </div>
                <div class="footer-col">
                    <h4>Quick Links</h4>
                    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <a href="#" onclick="showAbout(); return false;">About Us</a>
                    <a href="#">Doctors</a>
                    <a href="#">Contact</a>
                </div>

                <div class="footer-col">
                    <h4>Contact</h4>
                    <p><i class="fa-solid fa-phone"></i> +91 7999640721</p>
                    <p><i class="fa-solid fa-envelope"></i> lifecare@gmail.com</p>
                    <p><i class="fa-solid fa-location-dot"></i> Indore, India</p>
                </div>
            </div>
            <hr>
            <p class="copy">&copy; 2026 Hospital Management System | All Rights Reserved health care</p>
        </footer>

    </div>
</div>
</div>
</body>
</html>