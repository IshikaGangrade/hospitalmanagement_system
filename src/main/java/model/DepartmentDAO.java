package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Department;

public class DepartmentDAO {
    private static final String COLUMNS = "id, name, description";
    public boolean addDepartment(Department department) throws SQLException {
        String sql = "INSERT INTO departments (name, description) VALUES (?, ?)";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            return ps.executeUpdate() > 0;
        }
    }
    public List<Department> getAllDepartments() throws SQLException {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT " + COLUMNS + " FROM departments ORDER BY id";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapDepartment(rs));
            }
        }
        return list;
    }
    public List<Department> searchDepartments(String name) throws SQLException {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT " + COLUMNS + " FROM departments "
                + "WHERE name LIKE ? ORDER BY id";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + (name == null ? "" : name.trim()) + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapDepartment(rs));
                }
            }
        }
        return list;
    }

    public Department getDepartmentById(int id) throws SQLException {
        String sql = "SELECT " + COLUMNS + " FROM departments WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDepartment(rs);
                }
            }
        }
        return null;
    }

    public boolean updateDepartment(Department department) throws SQLException {
        String sql = "UPDATE departments SET name = ?, description = ? WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            ps.setInt(3, department.getId());
            return ps.executeUpdate() > 0;
        }
    }
    public boolean deleteDepartment(int id) throws SQLException {
        String sql = "DELETE FROM departments WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    private Department mapDepartment(ResultSet rs) throws SQLException {
        Department department = new Department();
        department.setId(rs.getInt("id"));
        department.setName(rs.getString("name"));
        department.setDescription(rs.getString("description"));
        return department;
    }
}