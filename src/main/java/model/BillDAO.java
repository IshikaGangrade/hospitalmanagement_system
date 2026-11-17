package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.Bill;
public class BillDAO {
    private static final String FROM_JOIN =
            "FROM bill b LEFT JOIN patient p ON b.patient_id = p.patient_id ";
    private static final String WHERE_SEARCH = "WHERE (? = '' OR p.name LIKE ?) ";
    public boolean addBill(Bill bill) throws SQLException {
        String sql = "INSERT INTO bill (patient_id, amount, status) VALUES (?, ?, ?)";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bill.getPatientId());
            ps.setDouble(2, bill.getAmount());
           ps.setString(3, bill.getStatus());
            return ps.executeUpdate() > 0;
        }
    }
    public int countBills(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) " + FROM_JOIN + WHERE_SEARCH;
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            bindSearch(ps, keyword);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }
    public List<Bill> getBills(String keyword, int page, int pageSize) throws SQLException {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT b.id, b.patient_id, p.name AS patient_name, b.amount, b.status "
                   + FROM_JOIN + WHERE_SEARCH
                   + "ORDER BY b.id DESC LIMIT ? OFFSET ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int next = bindSearch(ps, keyword);
            ps.setInt(next, pageSize);
            ps.setInt(next + 1, (Math.max(page, 1) - 1) * pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bill bill = new Bill();
                    bill.setId(rs.getInt("id"));
                    bill.setPatientId(rs.getInt("patient_id"));
                    bill.setPatientName(rs.getString("patient_name"));
                    bill.setAmount(rs.getDouble("amount"));
                    bill.setStatus(rs.getString("status"));
                    list.add(bill);
                }
            }
        }
        return list;
    }
    public Bill getBillById(int id) throws SQLException {
        String sql = "SELECT id, patient_id, amount, status FROM bill WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Bill bill = new Bill();
                    bill.setId(rs.getInt("id"));
                    bill.setPatientId(rs.getInt("patient_id"));
                    bill.setAmount(rs.getDouble("amount"));
                    bill.setStatus(rs.getString("status"));
                    return bill;
                }
            }
        }
        return null;
    }
    public boolean updateBill(Bill bill) throws SQLException {
        String sql = "UPDATE bill SET patient_id = ?, amount = ?, status = ? WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bill.getPatientId());
            ps.setDouble(2, bill.getAmount());
            ps.setString(3, bill.getStatus());
            ps.setInt(4, bill.getId());
            return ps.executeUpdate() > 0;
        }
    }
    public boolean deleteBill(int id) throws SQLException {
        String sql = "DELETE FROM bill WHERE id = ?";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    public List<String[]> getPatientOptions() throws SQLException {
        List<String[]> list = new ArrayList<>();
        String sql = "SELECT patient_id, name FROM patient ORDER BY patient_id";
        try (Connection con = DBUtil.makeConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new String[] { String.valueOf(rs.getInt("patient_id")),
                                        rs.getString("name") });
            }
        }
        return list;
    }
    private int bindSearch(PreparedStatement ps, String keyword) throws SQLException {
        String k = (keyword == null) ? "" : keyword.trim();
        ps.setString(1, k);
        ps.setString(2, "%" + k + "%");
        return 3;
    }
}