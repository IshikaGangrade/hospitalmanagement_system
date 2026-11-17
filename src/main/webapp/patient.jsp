<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="entity.Patient" %>
<style>
.patient-page {
    width: 100%;
}
.patient-title {
    text-align: center;
    color: #263b78;
    font-size: 30px;
    font-weight: bold;
    margin: 5px 0 40px 0;
}
.patient-add-section {
    padding: 0 0 30px 0;
    border-bottom: 1px solid #bfc3cc;
}

.patient-add-section h2 {
    color: #263b78;
    font-size: 18px;
    margin-bottom: 25px;
}


.patient-form-row {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    align-items: center;
}


.patient-form-row input {
    width: 150px;
    height: 34px;

    padding: 7px 10px;

    border: 1px solid #d4d4d4;
    border-radius: 5px;

    font-size: 12px;

    outline: none;
    background: white;
}


.patient-form-row input:focus {
    border-color: #263b78;
}
.patient-add-btn {
    height: 34px;

    padding: 0 18px;

    background: #263b78;
    color: white;

    border: none;
    border-radius: 5px;

    font-size: 12px;

    cursor: pointer;
}
.patient-add-btn:hover {
    background: #17265f;
}
.patient-search-section {
    padding: 18px 0 30px 0;
    border-bottom: 1px solid #bfc3cc;
    display: flex;
    justify-content: flex-end;
}
.patient-search-form {
    display: flex;
    gap: 10px;
}
.patient-search-form input {
    width: 190px;
    height: 34px;
    padding: 7px 10px;
    border: 1px solid #d4d4d4;
    border-radius: 5px;
    font-size: 12px;
    outline: none;
}
.patient-search-btn {
    height: 34px;
    padding: 0 18px;
    background: #263b78;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 12px;
    cursor: pointer;
}
.patient-search-btn:hover {
    background: #17265f;

}
.patient-list {
    background: white;
    margin-top: 40px;
    padding: 20px;
    border-radius: 6px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);

}
.patient-list h2 {
    color: #263b78;
    font-size: 18px;
    margin-bottom: 20px;
}
.patient-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 12px;
}
.patient-table th {
    background: #263b78;
    color: white;
    padding: 11px 8px;
    text-align: left;
    font-weight: 600;
}
.patient-table td {
    padding: 12px 8px;
    color: #3f4350;
    border-bottom: 1px solid #eeeeee;
    background: white;
}
.patient-table tr:hover td {
    background: #f8f9fd;

}
.patient-action {
    display: flex;
    align-items: center;
    gap: 12px;
}
.patient-edit {
    color: #263b78;
    font-size: 16px;
    cursor: pointer;
}
.patient-delete {
    background: none;
    border: none;
    color: #263b78;
    font-size: 16px;
    cursor: pointer;
    padding: 0;
}
.patient-delete:hover {
    color: #dc3545;

}
.no-patient {
    text-align: center;
    color: #777;
    padding: 20px !important;
}
@media(max-width:1200px) {

    .patient-form-row input {

        width: 130px;

    }
}
@media(max-width:900px) {
    .patient-form-row {
        gap: 10px;
    }
    .patient-form-row input {
        width: 140px;
    }
    .patient-table {
        min-width: 1000px;
    }
    .patient-list {

        overflow-x: auto;

    }
}
</style>
<div class="patient-page">
    <h1 class="patient-title">
        Patient Management
    </h1>
<div class="patient-add-section">
<%
    Patient editPatient =
        (Patient) request.getAttribute("editPatient");
%>

<% if (editPatient != null) { %>
    <h2>Edit Patient</h2>
    <form action="PatientServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id"
               value="<%= editPatient.getPatientId() %>">
        <div class="patient-form-row">
            <input type="text" name="name"
                   placeholder="Name"
                   value="<%= editPatient.getName() %>" required>

            <input type="email" name="email"
                   placeholder="Email"
                   value="<%= editPatient.getEmail() %>">

            <input type="text" name="phone"
                   placeholder="Phone"
                   value="<%= editPatient.getPhone() %>">

            <input type="text" name="gender"
                   placeholder="Gender"
                   value="<%= editPatient.getGender() %>">

            <input type="number" name="age"
                   placeholder="Age"
                   value="<%= editPatient.getAge() %>" required>

            <input type="text" name="address"
                   placeholder="Address"
                   value="<%= editPatient.getAddress() %>">

            <input type="text" name="disease"
                   placeholder="Disease"
                   value="<%= editPatient.getDisease() %>">

            <input type="text" name="blood"
                   placeholder="Blood"
                   value="<%= editPatient.getBlood() %>">

            <button type="submit" class="patient-add-btn">
                Update Patient
            </button>

            <a href="PatientServlet"
               style="color:#263b78; font-size:12px;">
                Cancel
            </a>

        </div>
    </form>
<% } else { %>
    <h2>Add Patient</h2>
    <form action="PatientServlet" method="post">
        <input type="hidden" name="action" value="add">
        <div class="patient-form-row">

            <input type="text" name="name"
                   placeholder="Name" required>

            <input type="email" name="email"
                   placeholder="Email">

            <input type="text" name="phone"
                   placeholder="Phone">

            <input type="text" name="gender"
                   placeholder="Gender">

            <input type="number" name="age"
                   placeholder="Age" required>

            <input type="text" name="address"
                   placeholder="Address">

            <input type="text" name="disease"
                   placeholder="Disease">

            <input type="text" name="blood"
                   placeholder="Blood">
            <button type="submit" class="patient-add-btn">
                Add Patient
            </button>
        </div>
    </form>
<% } %>
</div>
    <div class="patient-search-section">
        <form action="PatientServlet"
              method="post"
              class="patient-search-form">
         
            <input type="hidden"
                   name="action"
                   value="search">

            <input type="text"
                   name="name"
                   placeholder="Search Patient Name"
                   required>

            <button type="submit"
                    class="patient-search-btn">
                Search
            </button>
        </form>
    </div>
    <div class="patient-list">
        <h2>
            Patient List
        </h2>
        <table class="patient-table">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Gender</th>
                <th>Age</th>
                <th>Address</th>
                <th>Disease</th>
                <th>Blood</th>
                <th>Action</th>
            </tr>
<%
    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");
    List<Patient> result =
        (List<Patient>) request.getAttribute("result");
    List<Patient> displayList = patients;
    if (result != null) {
        displayList = result;
    }
    if (displayList != null && !displayList.isEmpty()) {
        for (Patient p : displayList) {
%>
<tr>
    <td><%= p.getPatientId() %></td>
    <td><%= p.getName() %></td>
    <td><%= p.getEmail() %></td>
    <td><%= p.getPhone() %></td>
    <td><%= p.getGender() %></td>
    <td><%= p.getAge() %></td>
    <td><%= p.getAddress() %></td>
    <td><%= p.getDisease() %></td>
    <td><%= p.getBlood() %></td>
    <td>
       <a href="PatientServlet?action=edit&id=<%= p.getPatientId() %>"
   title="Edit Patient"
   style="text-decoration:none;">
    <i class="bi bi-pencil-square patient-edit"></i>
</a>
        <form action="PatientServlet"
              method="post"
              style="display:inline;">
            <input type="hidden"
                   name="action"
                   value="delete">
            <input type="hidden"
                   name="id"
                   value="<%= p.getPatientId() %>">
            <button type="submit"
                    class="patient-delete">
                <i class="bi bi-trash"></i>
            </button>
        </form>
    </td>
</tr>
<%
        }

    } else {
%>
<tr>
    <td colspan="10" class="no-patient">
        No Patient Found
    </td>
</tr>
<%
    }
%>
