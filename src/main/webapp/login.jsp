<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

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
background:#f3f5ff;
}
.login-card{
width:430px;
background:#fff;
padding:40px;
border-radius:18px;
box-shadow:0 10px 35px rgba(0,0,0,.12);
}
.logo{
text-align:center;
font-size:42px;
color:#2f49d1;
margin-bottom:8px;
}
.title{
text-align:center;
font-size:46px;
font-weight:700;
color:red;
margin-bottom:30px;
}
.form-control{
height:52px;
border-radius:10px;
margin-bottom:18px;
font-size:17px;
}
.form-control:focus{
box-shadow:none;
border:2px solid #3b57e8;
}
.btn-login{
width:100%;
height:50px;
border:none;
border-radius:10px;
background:#2f49d1;
color:white;
font-size:20px;
font-weight:600;
transition:.3s;
}
.btn-login:hover{
background:#2238b6;
}
.create{
margin-top:18px;
font-size:18px;
}
.create a{
text-decoration:none;
font-weight:600;
color:#2f49d1;
}
.error{
color:red;
text-align:center;
margin-bottom:15px;
}

</style>
</head>
<body>
<div class="login-card">
<div class="logo">
<i class="bi bi-hospital-fill"></i>
</div>
<div class="title">Admin Login</div>
<%
if(request.getParameter("error")!=null){
%>
<div class="error">
Invalid Email or Password
</div>
<%
}
%>
<form action="AdminLoginServlet" method="post">
<input type="email" name="email" class="form-control" placeholder="Email Address" required>
<input type="password" name="password" class="form-control" placeholder="Password" required>

<button class="btn-login">Login</button>
</form>
<div class="create">
<a href="register.jsp">Create Account</a>
</div>
</div>

</body>
</html>