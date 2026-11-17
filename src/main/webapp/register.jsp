<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Admin Account</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}
body{
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:#f4f5ff;
}
.card{
width:430px;
padding:35px;
border-radius:18px;
box-shadow:0 10px 30px rgba(0,0,0,.15);
background:white;
}
.logo{
text-align:center;
font-size:42px;
color:#243fb5;
}
.title{
text-align:center;
font-size:42px;
font-weight:bold;
color:red;
margin-bottom:20px;
line-height:45px;
}
.form-control{
height:50px;
margin-bottom:18px;
border-radius:10px;
}
.btn-register{
width:100%;
height:50px;
background:yellow;
color:white;
border:none;
border-radius:10px;
font-size:18px;
font-weight:bold;
}
.btn-register:hover{
background:#1636b0;
}
.bottom{
text-align:center;
margin-top:18px;
}
.bottom a{
text-decoration:none;
font-weight:bold;
}
</style>
</head>

<body>
<div class="card">
<div class="logo">
<i class="bi bi-hospital-fill"></i>
</div>
<div class="title">Create Admin<br>Account</div>
<form action="AdminRegisterServlet" method="post">
<input type="text" name="name" class="form-control" placeholder="Enter Name" required>
<input type="email" name="email" class="form-control" placeholder="Enter Email" required>
<input type="password" name="password" class="form-control" placeholder="Enter Password" required>
<input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
<button class="btn-register">Register</button>
</form>
<div class="bottom">
Already have an account?
<a href="login.jsp">Login</a>
</div>
</div>

</body>
</html>