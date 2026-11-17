<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Collections, entity.Doctor" %>
<%!
    private static String h(Object o) {
        if (o == null) return "";
        return o.toString().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")
                .replace("\"","&quot;").replace("'","&#39;");
    }
%>
<%
    @SuppressWarnings("unchecked")
    List<Doctor> cardDoctors = (List<Doctor>) request.getAttribute("doctorList");
    if (cardDoctors == null) cardDoctors = Collections.emptyList();
%>
<div class="dl-page">
    <style>
        .dl-page { padding:24px 28px; font-family:Arial,Helvetica,sans-serif; color:#243247; }
        .dl-page .dl-title { text-align:center; margin:6px 0 28px; color:#243b64; font-size:28px; font-weight:700; }
        .dl-page .dl-card { position:relative; background:#fff; border-radius:14px; padding:22px 26px; margin-bottom:26px; border-left:4px solid #243b9a; box-shadow:0 4px 16px rgba(31,51,82,.08); }
        .dl-page .dl-name { margin:0 0 14px; color:#1d2b4f; font-size:19px; font-weight:700; }
        .dl-page .dl-id { position:absolute; top:20px; right:22px; background:#243b9a; color:#fff; font-size:11px; font-weight:700; padding:4px 10px; border-radius:20px; }
        .dl-page .dl-details { border-left:3px solid #243b9a; padding:4px 0 4px 18px; }
        .dl-page .dl-details p { margin:0 0 11px; font-size:14px; color:#55627a; }
        .dl-page .dl-details strong { color:#243247; }
    </style>
    <h2 class="dl-title">Our Doctors</h2>
    <% for (Doctor d : cardDoctors) { %>
        <div class="dl-card">
            <h3 class="dl-name">Dr. <%= h(d.getName()) %></h3>
            <span class="dl-id">ID <%= d.getId() %></span>
            <div class="dl-details">
                <p><strong>Specialization:</strong> <%= h(d.getSpecialization()) %></p>
                <p><strong>Email:</strong> <%= h(d.getEmail()) %></p>
                <p><strong>Phone:</strong> <%= h(d.getPhone()) %></p>
                <p><strong>Experience:</strong> <%= d.getExperience() %> years</p>
            </div>
        </div>
    <% } %>
</div>