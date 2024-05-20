package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.User;

public class UserDAOImpl implements UserDAO {

	private Connection conn;

	public UserDAOImpl(Connection conn) {
		super();
		this.conn = conn;

	}

	public boolean userRegister(User us) {
		boolean f = false;

		try {
			String sql = "insert into user(name,email,phno,password) values(?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, us.getName());
			ps.setString(2, us.getEmail());
			ps.setString(3, us.getPhno());
			ps.setString(4, us.getPassword());

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

//	public User login(String email, String password) {
//
//		User us = null;
//
//		try {
//			String sql = "select * from user where email=? and password=?";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setString(1, email);
//			ps.setString(2, password);
//
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				us = new User();
//				us.setId(rs.getInt(1));
//				us.setName(rs.getString(2));
//				us.setEmail(rs.getString(3));
//				us.setPhno(rs.getString(4));
//				us.setPassword(rs.getString(5));
//				us.setUserType(rs.getString(6));
//				
//
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return us;
//	}

	
	public User login(String email, String password) {
	    User user = null;
	    try {
	        String sql = "SELECT u.*, a.address, a.landmark, a.city, a.state, a.pincode FROM user u LEFT JOIN user_address a ON u.id = a.userid WHERE u.email=? AND u.password=?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, email);
	        ps.setString(2, password);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            if (user == null) {
	                user = new User();
	                user.setId(rs.getInt("id"));
	                user.setName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhno(rs.getString("phno"));
	                user.setPassword(rs.getString("password"));
	                user.setStatus(rs.getString("status"));	               
	                user.setUserType(rs.getString("usertype"));
	                user.setAddress(rs.getString("address"));
	                user.setLandmark(rs.getString("landmark"));
	                user.setCity(rs.getString("city"));
	                user.setState(rs.getString("state"));
	                user.setPincode(rs.getString("pincode"));
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}

	public boolean checkPassword(int id, String password) {
		Boolean f = false;
		try {
			String sql = "select password from user where id=? and password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean upadteProfile(User us) {
		boolean f = false;

		try {
			String sql = "update user set name=? , password=?,phno=? where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, us.getName());
			ps.setString(2, us.getPassword());
			ps.setString(3, us.getPhno());
			ps.setInt(4, us.getId());
			System.out.println(us.getPassword());

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;

	}

	public boolean checkUser(String email) {
		boolean f = true;

		try {
			String sql = "select * from user where email=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				f = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;

	}

	public boolean changePassword(String email, String password) {

		try {
			PreparedStatement statement = conn.prepareStatement("UPDATE user SET password = ? WHERE email = ?");

			statement.setString(1, password);
			statement.setString(2, email);

			int rowsAffected = statement.executeUpdate();
			return rowsAffected > 0;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public User userProfile(String email) {

		User us = null;

		try {
			String sql = "SELECT * FROM user WHERE email=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,email); // Set the email parameter
			
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				us = new User();
				us.setId(rs.getInt(1));
				us.setName(rs.getString(2));
				us.setEmail(rs.getString(3));
				us.setPhno(rs.getString(4));
				us.setPassword(rs.getString(5));
				us.setUserType(rs.getString(6));
				
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return us;
	}

	public List<User> findUserlist() {
		List<User> ulist=new ArrayList<User>();
		User us=null;
		try {
			String sql = "select * from user where usertype ='normal'";
			PreparedStatement ps = conn.prepareStatement(sql);
			

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				us=new User();
				us.setId(rs.getInt("id"));
				us.setName(rs.getString("name"));
				us.setEmail(rs.getString("email"));
				us.setPhno(rs.getString("phno"));
				us.setStatus(rs.getString("status"));
				ulist.add(us);
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ulist;
	}
	public boolean upadteUserStatus(String email,String status) {
		boolean f = false;

		try {
			String sql = "update user set status=?  where email=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, status);
			ps.setString(2,email);
			

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;

	}

	public boolean addAddress(User user) {
	    try {
	        String sql = "INSERT INTO user_address (userid, address, landmark, city, state, pincode) "
	                   + "VALUES (?, ?, ?, ?, ?, ?) "
	                   + "ON DUPLICATE KEY UPDATE address = VALUES(address), "
	                   + "landmark = VALUES(landmark), city = VALUES(city), "
	                   + "state = VALUES(state), pincode = VALUES(pincode)";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, user.getId());
	        ps.setString(2, user.getAddress());
	        ps.setString(3, user.getLandmark());
	        ps.setString(4, user.getCity());
	        ps.setString(5, user.getState());
	        ps.setString(6, user.getPincode());

	        int rowsAffected = ps.executeUpdate();
	        return rowsAffected > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
}
