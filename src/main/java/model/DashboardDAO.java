package model;
import java.sql.*;
import java.util.*;
import entity.DashboardData;
public class DashboardDAO {
    public DashboardData getDashboardData() throws SQLException {
        DashboardData data = new DashboardData();
        try (Connection con = DBUtil.makeConnection()) {
            String patientSql = "SELECT COUNT(*) FROM patient";
            try (PreparedStatement ps = con.prepareStatement(patientSql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    data.setTotalPatients(rs.getInt(1));
                }
            }
            String doctorSql = "SELECT COUNT(*) FROM doctors";
            try (PreparedStatement ps = con.prepareStatement(doctorSql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    data.setTotalDoctors(rs.getInt(1));
                }
            }
            String appointmentSql = "SELECT COUNT(*) FROM appointment";
            try (PreparedStatement ps = con.prepareStatement(appointmentSql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    data.setTotalAppointments(rs.getInt(1));
                }
            }
            String revenueSql =
                "SELECT COALESCE(SUM(amount),0) FROM bill WHERE LOWER(status)='paid'";
            try (PreparedStatement ps = con.prepareStatement(revenueSql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    data.setTotalRevenue(rs.getBigDecimal(1));
                }
            }
            String recentSql =
                "SELECT p.name AS patient_name, " +
                "d.name AS doctor_name, " +
                "a.appointment_date, " +
                "a.appointment_time, " +
                "a.status " +
                "FROM appointment a " +
                "JOIN patient p ON a.patient_id=p.patient_id " +
                "JOIN doctors d ON a.doctor_id=d.id " +
                "ORDER BY a.appointment_date DESC, " +
                "a.appointment_time DESC LIMIT 5";
            data.setRecentAppointments(getRecords(con, recentSql));
            String workloadSql =
                "SELECT d.name AS doctor_name, " +
                "d.specialization, " +
                "COUNT(a.id) AS total_appointments " +
                "FROM doctors d " +
                "LEFT JOIN appointment a ON d.id=a.doctor_id " +
                "GROUP BY d.id,d.name,d.specialization " +
                "ORDER BY d.name";
            data.setDoctorWorkload(getRecords(con, workloadSql));
            String historySql =
                "SELECT p.name AS patient_name, " +
                "d.name AS doctor_name, " +
                "a.appointment_date, " +
                "a.appointment_time, " +
                "a.status " +
                "FROM appointment a " +
                "JOIN patient p ON a.patient_id=p.patient_id " +
                "JOIN doctors d ON a.doctor_id=d.id " +
                "ORDER BY a.appointment_date DESC, " +
                "a.appointment_time DESC LIMIT 10";
            data.setPatientVisitHistory(getRecords(con, historySql));

        }
        return data;
    }
    private List<Map<String, Object>> getRecords(
            Connection con, String sql) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            ResultSetMetaData meta = rs.getMetaData();
            int columns = meta.getColumnCount();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();

                for (int i = 1; i <= columns; i++) {

                    row.put(
                        meta.getColumnLabel(i),
                        rs.getObject(i)
                    );
                }
                list.add(row);
            }
        }
        return list;
    }
}