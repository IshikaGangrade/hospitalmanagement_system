package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.Doctor;
public class DoctorDAO {
    private static final String COLUMNS =
        "id, name, email, phone, specialization, experience, department_id";
    public boolean addDoctor(Doctor doctor) throws SQLException {
        String sql = "INSERT INTO doctors "
                + "(name, email, phone, specialization, experience, department_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getEmail());
            ps.setString(3, doctor.getPhone());
            ps.setString(4, doctor.getSpecialization());
            ps.setInt(5, doctor.getExperience());
            ps.setInt(6, doctor.getDepartmentId());
            return ps.executeUpdate() > 0;
        }
    }
    public List<Doctor> getAllDoctors() throws SQLException {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT " + COLUMNS + " FROM doctors ORDER BY id";

        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapDoctor(rs));
            }
        }
        return list;
    }
    public List<Doctor> searchDoctors(String name) throws SQLException {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT " + COLUMNS + " FROM doctors "
                + "WHERE name LIKE ? ORDER BY id";

        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + (name == null ? "" : name.trim()) + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapDoctor(rs));
                }
            }
        }
        return list;
    }
    public Doctor getDoctorById(int id) throws SQLException {
        String sql = "SELECT " + COLUMNS + " FROM doctors WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDoctor(rs);
                }
            }
        }
        return null;
    }
    public boolean updateDoctor(Doctor doctor) throws SQLException {
        String sql = "UPDATE doctors SET name = ?, email = ?, "
                + "phone = ?, specialization = ?, experience = ?, "
                + "department_id = ? WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getEmail());
            ps.setString(3, doctor.getPhone());
            ps.setString(4, doctor.getSpecialization());
            ps.setInt(5, doctor.getExperience());
            ps.setInt(6, doctor.getDepartmentId());
            ps.setInt(7, doctor.getId());
           return ps.executeUpdate() > 0;
        }
    }
    public boolean deleteDoctor(int id) throws SQLException {
        String sql = "DELETE FROM doctors WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    private Doctor mapDoctor(ResultSet rs) throws SQLException {
        Doctor doctor = new Doctor();
        doctor.setId(rs.getInt("id"));
        doctor.setName(rs.getString("name"));
        doctor.setEmail(rs.getString("email"));
        doctor.setPhone(rs.getString("phone"));
        doctor.setSpecialization(rs.getString("specialization"));
        doctor.setExperience(rs.getInt("experience"));
        doctor.setDepartmentId(rs.getInt("department_id"));
        return doctor;
    }
}