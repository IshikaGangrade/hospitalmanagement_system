package model;
    import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.util.ArrayList;
	import java.util.List;
	import entity.Patient;
	public class PatientDAO {
	    public boolean addPatient(Patient p) {
	        try {
	            Connection con = DBUtil.makeConnection();
	            String sql = "INSERT INTO patient " +
	                    "(name,email,phone,gender,age,address,disease,blood) " +
	                    "VALUES (?,?,?,?,?,?,?,?)";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, p.getName());
	            ps.setString(2, p.getEmail());
	            ps.setString(3, p.getPhone());
	            ps.setString(4, p.getGender());
	            ps.setInt(5, p.getAge());
	            ps.setString(6, p.getAddress());
	            ps.setString(7, p.getDisease());
	            ps.setString(8, p.getBlood());
	            int i = ps.executeUpdate();
	            return i > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	    public List<Patient> getAllPatients() {
	        List<Patient> list = new ArrayList<>();
	        try {
	            Connection con = DBUtil.makeConnection();
	            String sql = "SELECT * FROM patient";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	               Patient p = new Patient();
	                p.setPatientId(rs.getInt("patient_id"));
	                p.setName(rs.getString("name"));
	                p.setEmail(rs.getString("email"));
	                p.setPhone(rs.getString("phone"));
	                p.setGender(rs.getString("gender"));
	                p.setAge(rs.getInt("age"));
	                p.setAddress(rs.getString("address"));
	                p.setDisease(rs.getString("disease"));
	                p.setBlood(rs.getString("blood"));
	                list.add(p);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return list;
	    }
	    public List<Patient> searchPatient(String name) {
	        List<Patient> list = new ArrayList<>();
	        try {
	            Connection con = DBUtil.makeConnection();
	            String sql = "SELECT * FROM patient WHERE name LIKE ?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, "%" + name + "%");
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                Patient p = new Patient();
	                p.setPatientId(rs.getInt("patient_id"));
	                p.setName(rs.getString("name"));
	                p.setEmail(rs.getString("email"));
	                p.setPhone(rs.getString("phone"));
	                p.setGender(rs.getString("gender"));
	                p.setAge(rs.getInt("age"));
	                p.setAddress(rs.getString("address"));
	                p.setDisease(rs.getString("disease"));
	                p.setBlood(rs.getString("blood"));
	                list.add(p);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    }
	    public boolean deletePatient(int id) {
	        try {
	            Connection con = DBUtil.makeConnection();
	            String sql = "DELETE FROM patient WHERE patient_id=?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setInt(1, id);
	            int i = ps.executeUpdate();
	            return i > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	    public Patient getPatientById(int id) {
	        Patient p = null;
	        try {
	            Connection con = DBUtil.makeConnection();
	           String sql = "SELECT * FROM patient WHERE patient_id=?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setInt(1, id);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next()) {
	                p = new Patient();
	                p.setPatientId(rs.getInt("patient_id"));
	                p.setName(rs.getString("name"));
	                p.setEmail(rs.getString("email"));
	                p.setPhone(rs.getString("phone"));
	                p.setGender(rs.getString("gender"));
	                p.setAge(rs.getInt("age"));
	                p.setAddress(rs.getString("address"));
	                p.setDisease(rs.getString("disease"));
	                p.setBlood(rs.getString("blood"));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return p;
	    }
	    public boolean updatePatient(Patient p) {
	        try {
	            Connection con = DBUtil.makeConnection();

	            String sql = "UPDATE patient SET name=?, email=?, phone=?, " +
	                         "gender=?, age=?, address=?, disease=?, blood=? " +
	                         "WHERE patient_id=?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, p.getName());
	            ps.setString(2, p.getEmail());
	            ps.setString(3, p.getPhone());
	            ps.setString(4, p.getGender());
	            ps.setInt(5, p.getAge());
	            ps.setString(6, p.getAddress());
	            ps.setString(7, p.getDisease());
	            ps.setString(8, p.getBlood());
	            ps.setInt(9, p.getPatientId());
	            int i = ps.executeUpdate();
	            return i > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    } 
	}

