package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entity.Admin;

public class AdminDAO {
	public boolean login(String email, String password) {

		boolean status = false;
		try {
			Connection con = DBUtil.makeConnection();
			PreparedStatement ps = con.prepareStatement("select * from admin where email=? and password=?");
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				status = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public boolean register(Admin admin) {

		boolean status = false;

		try {
			Connection con = DBUtil.makeConnection();
			PreparedStatement ps = con.prepareStatement("insert into admin(name,email,password) values(?,?,?)");
			ps.setString(1, admin.getName());
			ps.setString(2, admin.getEmail());
			ps.setString(3, admin.getPassword());
			int i = ps.executeUpdate();
			if (i > 0) {
				status = true;
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return status;

	}
}
