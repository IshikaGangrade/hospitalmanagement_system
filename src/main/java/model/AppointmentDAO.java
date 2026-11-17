package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Appointment;

public class AppointmentDAO { 
    private static final String FROM_JOIN =
            "FROM appointment a "
          + "LEFT JOIN patient p ON a.patient_id = p.patient_id "
          + "LEFT JOIN doctors d ON a.doctor_id = d.id ";
    private static final String WHERE_SEARCH =
            "WHERE (? = '' OR p.name LIKE ? OR d.name LIKE ? "
          + "OR a.status LIKE ? OR CAST(a.id AS CHAR) = ?) ";
    public boolean addAppointment(Appointment ap) throws SQLException {
        String sql = "INSERT INTO appointment "
                + "(appointment_date, appointment_time, patient_id, doctor_id, status) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, ap.getAppointmentDate());
            ps.setString(2, ap.getAppointmentTime());
            ps.setInt(3, ap.getPatientId());
            ps.setInt(4, ap.getDoctorId());
            ps.setString(5, "Pending");

            return ps.executeUpdate() > 0;
        }
    }  
    public int countAppointments(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) " + FROM_JOIN + WHERE_SEARCH;
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            bindSearch(ps, keyword);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    } 
    public List<Appointment> getAppointments(String keyword, int page, int pageSize)
            throws SQLException {

        List<Appointment> list = new ArrayList<>();

        String sql = "SELECT a.id, a.appointment_date, a.appointment_time, "
                   + "a.patient_id, a.doctor_id, a.status, "
                   + "p.name AS patient_name, d.name AS doctor_name "
                   + FROM_JOIN + WHERE_SEARCH
                   + "ORDER BY a.id LIMIT ? OFFSET ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int next = bindSearch(ps, keyword);
            ps.setInt(next, pageSize);
            ps.setInt(next + 1, (Math.max(page, 1) - 1) * pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment ap = new Appointment();
                    ap.setId(rs.getInt("id"));
                    ap.setAppointmentDate(rs.getString("appointment_date"));
                    ap.setAppointmentTime(rs.getString("appointment_time"));
                    ap.setPatientId(rs.getInt("patient_id"));
                    ap.setDoctorId(rs.getInt("doctor_id"));
                    ap.setStatus(rs.getString("status"));
                    ap.setPatientName(rs.getString("patient_name"));
                    ap.setDoctorName(rs.getString("doctor_name"));
                    list.add(ap);
                }
            }
        }
        return list;
    }
    public Appointment getAppointmentById(int id) throws SQLException {
        String sql = "SELECT id, appointment_date, appointment_time, "
                   + "patient_id, doctor_id, status "
                   + "FROM appointment WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Appointment ap = new Appointment();
                    ap.setId(rs.getInt("id"));
                    ap.setAppointmentDate(rs.getString("appointment_date"));
                    ap.setAppointmentTime(rs.getString("appointment_time"));
                    ap.setPatientId(rs.getInt("patient_id"));
                    ap.setDoctorId(rs.getInt("doctor_id"));
                    ap.setStatus(rs.getString("status"));
                    return ap;
                }
            }
        }
        return null;
    }
    public boolean updateAppointment(Appointment ap) throws SQLException {
        String sql = "UPDATE appointment SET appointment_date = ?, appointment_time = ?, "
                   + "patient_id = ?, doctor_id = ?, status = ? WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, ap.getAppointmentDate());
            ps.setString(2, ap.getAppointmentTime());
            ps.setInt(3, ap.getPatientId());
            ps.setInt(4, ap.getDoctorId());
            ps.setString(5, ap.getStatus());
            ps.setInt(6, ap.getId());
            return ps.executeUpdate() > 0;
        }
    }
    public boolean deleteAppointment(int id) throws SQLException {
        String sql = "DELETE FROM appointment WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    private int bindSearch(PreparedStatement ps, String keyword) throws SQLException {
        String k = (keyword == null) ? "" : keyword.trim();
        String like = "%" + k + "%";
        ps.setString(1, k);
        ps.setString(2, like);
        ps.setString(3, like);
        ps.setString(4, like);
        ps.setString(5, k);
        return 6;
    }
}