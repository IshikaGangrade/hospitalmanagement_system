<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="entity.Department" %>
<%!
    // HTML escape helper (XSS se bachata hai, null ko "" banata hai)
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
    List<Department> departmentList = (List<Department>) request.getAttribute("departmentList");
    if (departmentList == null) {
        departmentList = Collections.emptyList();
    }

    Department editDepartment = (Department) request.getAttribute("editDepartment");
    boolean editingDept = editDepartment != null;

    // Failed add ke baad user ka likha hua wapas dikhane ke liye
    Department formDepartment = (Department) request.getAttribute("formDepartment");

    String deptSearch = (String) request.getAttribute("searchName");
    if (deptSearch == null) {
        deptSearch = "";
    }

    String deptMessage = (String) request.getAttribute("message");
    String deptError = (String) request.getAttribute("errorMessage");

    String ctx = request.getContextPath();
%>
<div class="dept-page">

    <style>
        .dept-page { width: 100%; padding: 8px 4px 30px; box-sizing: border-box; font-family: Arial, Helvetica, sans-serif; color: #243247; }
        .dept-page * { box-sizing: border-box; }

        .dept-page .dept-searchbar { display: flex; justify-content: flex-end; padding: 6px 0 22px; border-bottom: 1px solid #d7dce6; margin-bottom: 26px; }
        .dept-page .dept-searchbar form { display: flex; gap: 0; width: 100%; max-width: 560px; }
        .dept-page .dept-searchbar input[type=text] { flex: 1; height: 38px; padding: 8px 12px; border: 1px solid #cfd6e3; border-right: none; border-radius: 6px 0 0 6px; font-size: 13px; outline: none; background: #fff; }
        .dept-page .dept-searchbar input[type=text]:focus { border-color: #243b9a; }
        .dept-page .dept-searchbar button { height: 38px; padding: 0 18px; border: none; border-radius: 0 6px 6px 0; background: #243b9a; color: #fff; font-size: 12px; cursor: pointer; }
        .dept-page .dept-searchbar button:hover { background: #1b2e7a; }

        .dept-page .dept-alert { padding: 12px 15px; margin-bottom: 18px; border-radius: 7px; font-size: 14px; }
        .dept-page .dept-success { background: #e6f7ee; color: #167548; border: 1px solid #b9e8ce; }
        .dept-page .dept-error { background: #fff0f0; color: #b42318; border: 1px solid #ffd0d0; }

        .dept-page .dept-heading { margin: 6px 0 20px; font-size: 26px; font-weight: 400; color: #243b64; }

        .dept-page .dept-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 22px; margin-bottom: 30px; }
        .dept-page .dept-card { position: relative; background: #fff; border-radius: 12px; padding: 20px 22px 16px; box-shadow: 0 4px 14px rgba(31, 51, 82, 0.10); display: flex; flex-direction: column; min-height: 190px; }
        .dept-page .dept-card-head { display: flex; align-items: center; justify-content: space-between; gap: 10px; margin-bottom: 10px; }
        .dept-page .dept-card-head h3 { margin: 0; font-size: 20px; color: #1d2b4f; font-weight: 700; word-break: break-word; }
        .dept-page .dept-id { background: #1d2b4f; color: #fff; font-size: 11px; padding: 4px 9px; border-radius: 20px; white-space: nowrap; }
        .dept-page .dept-desc { flex: 1; margin: 0 0 16px; font-size: 13px; line-height: 1.6; color: #44526b; }
        .dept-page .dept-actions { display: flex; align-items: center; justify-content: space-between; }
        .dept-page .dept-edit { display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; border: 1px solid #243b9a; border-radius: 5px; background: #fff; color: #243b9a; font-size: 12px; text-decoration: none; cursor: pointer; }
        .dept-page .dept-edit:hover { background: #243b9a; color: #fff; }
        .dept-page .dept-delete-form { margin: 0; }
        .dept-page .dept-delete { border: none; background: none; color: #b01030; font-size: 13px; font-weight: 700; cursor: pointer; padding: 6px 4px; }
        .dept-page .dept-delete:hover { text-decoration: underline; }

        .dept-page .dept-empty { grid-column: 1 / -1; text-align: center; padding: 40px 15px; color: #7a879a; background: #fff; border-radius: 12px; box-shadow: 0 4px 14px rgba(31, 51, 82, 0.08); }

        .dept-page .dept-formbox { border-top: 1px solid #d7dce6; padding-top: 22px; margin-bottom: 10px; }
        .dept-page .dept-formbox.dept-formtop { border-top: none; border-bottom: 1px solid #d7dce6; padding: 0 0 24px; margin-bottom: 26px; }
        .dept-page .dept-formbox h2 { margin: 0 0 16px; font-size: 26px; font-weight: 400; color: #243b64; }
        .dept-page .dept-formbox input[type=text], .dept-page .dept-formbox textarea { display: block; width: 100%; max-width: 560px; padding: 10px 12px; margin-bottom: 8px; border: 1px solid #d9e0eb; border-radius: 5px; font-size: 13px; font-family: inherit; background: #fff; outline: none; }
        .dept-page .dept-formbox textarea { min-height: 78px; resize: vertical; }
        .dept-page .dept-formbox input:focus, .dept-page .dept-formbox textarea:focus { border-color: #243b9a; }
        .dept-page .dept-btnrow { display: flex; gap: 10px; margin-top: 14px; }
        .dept-page .dept-btn { padding: 9px 18px; border: none; border-radius: 4px; background: #243b9a; color: #fff; font-size: 12px; cursor: pointer; text-decoration: none; display: inline-block; }
        .dept-page .dept-btn:hover { background: #1b2e7a; }
        .dept-page .dept-btn-light { background: #edf1f7; color: #35445c; }
        .dept-page .dept-btn-light:hover { background: #dfe6f0; }

        @media (max-width: 1000px) { .dept-page .dept-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
        @media (max-width: 620px) {
            .dept-page .dept-grid { grid-template-columns: 1fr; }
            .dept-page .dept-searchbar { justify-content: stretch; }
        }
    </style>

    <!-- SEARCH -->
    <div class="dept-searchbar">
        <form action="<%= ctx %>/DepartmentServlet" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="searchName" placeholder="Search Department"
                   value="<%= h(deptSearch) %>">
            <button type="submit">Search</button>
        </form>
    </div>

    <% if (deptMessage != null && !deptMessage.trim().isEmpty()) { %>
        <div class="dept-alert dept-success"><%= h(deptMessage) %></div>
    <% } %>

    <% if (deptError != null && !deptError.trim().isEmpty()) { %>
        <div class="dept-alert dept-error"><%= h(deptError) %></div>
    <% } %>

    <!-- UPDATE FORM (sirf Edit dabane par, upar dikhta hai) -->
    <% if (editingDept) { %>
        <div class="dept-formbox dept-formtop">
            <h2>Update Department</h2>

            <form action="<%= ctx %>/DepartmentServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= editDepartment.getId() %>">

                <input type="text" name="name" placeholder="Department Name"
                       value="<%= h(editDepartment.getName()) %>" required>

                <textarea name="description"
                          placeholder="Description"><%= h(editDepartment.getDescription()) %></textarea>

                <div class="dept-btnrow">
                    <button type="submit" class="dept-btn">Update</button>
                    <a class="dept-btn dept-btn-light" href="<%= ctx %>/DepartmentServlet">Cancel</a>
                </div>
            </form>
        </div>
    <% } %>

    <!-- DEPARTMENT CARDS -->
    <h2 class="dept-heading">Departments</h2>

    <div class="dept-grid">
        <% if (departmentList.isEmpty()) { %>

            <div class="dept-empty">No departments found.</div>

        <% } else { %>
            <% for (Department d : departmentList) { %>

                <div class="dept-card">
                    <div class="dept-card-head">
                        <h3><%= h(d.getName()) %></h3>
                        <span class="dept-id">ID : <%= d.getId() %></span>
                    </div>

                    <p class="dept-desc"><%= h(d.getDescription()) %></p>

                    <div class="dept-actions">
                        <a class="dept-edit"
                           href="<%= ctx %>/DepartmentServlet?action=edit&id=<%= d.getId() %>">
                            &#9998; Edit
                        </a>

                        <form class="dept-delete-form"
                              action="<%= ctx %>/DepartmentServlet" method="post"
                              onsubmit="return confirm('Are you sure you want to delete this department?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= d.getId() %>">
                            <button type="submit" class="dept-delete">Delete</button>
                        </form>
                    </div>
                </div>

            <% } %>
        <% } %>
    </div>

    <!-- ADD FORM (Edit mode mein chhup jata hai) -->
    <% if (!editingDept) { %>
        <div class="dept-formbox">
            <h2>Add Department</h2>

            <form action="<%= ctx %>/DepartmentServlet" method="post">
                <input type="hidden" name="action" value="add">

                <input type="text" name="name" placeholder="Department Name"
                       value="<%= formDepartment != null ? h(formDepartment.getName()) : "" %>" required>

                <textarea name="description"
                          placeholder="Description"><%= formDepartment != null ? h(formDepartment.getDescription()) : "" %></textarea>

                <div class="dept-btnrow">
                    <button type="submit" class="dept-btn">Add Department</button>
                </div>
            </form>
        </div>
    <% } %>

</div>