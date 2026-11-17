package entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DashboardData {
    private int totalPatients;
    private int totalDoctors;
    private int totalAppointments;
    private BigDecimal totalRevenue = BigDecimal.ZERO;
    private List<Map<String, Object>> recentAppointments = new ArrayList<>();
    private List<Map<String, Object>> doctorWorkload = new ArrayList<>();
    private List<Map<String, Object>> patientVisitHistory = new ArrayList<>();
    public int getTotalPatients() {
        return totalPatients;
    }
    public void setTotalPatients(int totalPatients) {
        this.totalPatients = totalPatients;
    }

    public int getTotalDoctors() {
        return totalDoctors;
    }

    public void setTotalDoctors(int totalDoctors) {
        this.totalDoctors = totalDoctors;
    }

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public List<Map<String, Object>> getRecentAppointments() {
        return recentAppointments;
    }

    public void setRecentAppointments(List<Map<String, Object>> recentAppointments) {
        this.recentAppointments = recentAppointments;
    }

    public List<Map<String, Object>> getDoctorWorkload() {
        return doctorWorkload;
    }

    public void setDoctorWorkload(List<Map<String, Object>> doctorWorkload) {
        this.doctorWorkload = doctorWorkload;
    }

    public List<Map<String, Object>> getPatientVisitHistory() {
        return patientVisitHistory;
    }

    public void setPatientVisitHistory(List<Map<String, Object>> patientVisitHistory) {
        this.patientVisitHistory = patientVisitHistory;
    }
}