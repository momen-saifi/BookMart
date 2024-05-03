package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Cart;

public class CartDAOImpl implements CartDAO {

	private Connection conn;

	public CartDAOImpl(Connection conn) {
		this.conn = conn;
	}

	public boolean addCart(Cart c) {
		boolean f = false;
		try {

			String sql = "insert into cart(bid,uid,bookName,author,price,total_price) values (?,?,?,?,?,?)";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, c.getBid());
			ps.setInt(2, c.getUserId());
			ps.setString(3, c.getBookName());
			ps.setString(4, c.getAuthor());
			ps.setDouble(5, c.getPrice());
			ps.setDouble(6, c.getTotal_price());

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public List<Cart> getBookByUser(int userId) {
		List<Cart> list = new ArrayList<Cart>();
		Cart c = null;
		double totalPrice = 0;
		try {

			String sql = "select * from cart where uid=?";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				c = new Cart();
				c.setCid(rs.getInt(1));
				c.setBid(rs.getInt(2));
				c.setUserId(rs.getInt(3));
				c.setBookName(rs.getString(4));
				c.setAuthor(rs.getString(5));
				c.setPrice(rs.getDouble(6));
				c.setQuantity(rs.getInt(8));
				totalPrice += rs.getDouble(7)*rs.getInt(8);
				
				
				c.setTotal_price(totalPrice);
				list.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean deleteBook(int bid, int uid, int cid) {
		boolean f = false;
		try {

			String sql = "delete from cart where bid=? and uid=? and cid=?";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, bid);
			ps.setInt(2, uid);
			ps.setInt(3, cid);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;

	}

	public boolean deleteBookByUser(int userId) {
		boolean f = false;
		try {

			String sql = "delete from cart where uid=? ";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, userId);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public int getBookCountByUser(int userId) {
		int count = 0;
		try {

			String sql = "SELECT SUM(piece_count) AS total FROM cart WHERE uid = ?";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;

	}

	public void deleteBookCountNill() {

		try {

			String sql = "DELETE FROM cart WHERE bid IN (SELECT bookId FROM book_dtls WHERE quantity = 0)";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.executeUpdate();

			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public boolean getBookByBUId(int userId, int bid) {
		boolean isAvailable = false;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			String sql = "SELECT COUNT(*) AS count FROM cart WHERE uid = ? AND bid = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, bid);
			rs = ps.executeQuery();

			if (rs.next()) {
				int count = rs.getInt("count");
				isAvailable = count > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();

		}

		return isAvailable;
	}

	public boolean updatePieceCountByBUId(int userId, int bid) {
		boolean isSuccess = false;

		PreparedStatement ps = null;

		try {

			String sql = "UPDATE cart SET piece_count = piece_count+1 WHERE uid = ? AND bid = ?";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, userId);
			ps.setInt(2, bid);

			int rowsAffected = ps.executeUpdate();
			isSuccess = rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();

		}

		return isSuccess;
	}

	public int getQuantityByBUId(int userId, int bid) {
		int quantity = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			String sql = "SELECT piece_count FROM cart WHERE uid = ? AND bid = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, bid);
			rs = ps.executeQuery();

			if (rs.next()) {

				quantity = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return quantity;
	}
	
	
	public boolean removePieceCountByBUId(int userId, int bid) {
		boolean f = false;
		try {

			 String sql = "UPDATE cart SET piece_count = piece_count - 1 WHERE bid = ? AND uid = ? AND piece_count > 0";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setInt(1, bid);
		        ps.setInt(2, userId);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;

	}


}
