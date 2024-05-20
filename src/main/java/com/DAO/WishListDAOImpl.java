package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Cart;
import com.entity.WishList;

public class WishListDAOImpl {

	private Connection conn;

	public WishListDAOImpl(Connection conn) {
		this.conn = conn;
	}

	public boolean addWishList(WishList p) {
		boolean f = false;
		try {

			String sql = "insert into wish_list(bid,uid,bookName,author,price,photo) values (?,?,?,?,?,?)";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, p.getBid());
			ps.setInt(2, p.getUserId());
			ps.setString(3, p.getBookName());
			ps.setString(4, p.getAuthor());
			ps.setDouble(5, p.getPrice());
			ps.setString(6, p.getPhotoName());

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}
	public List<WishList> getBookByUser(int userId) {
	    List<WishList> list = new ArrayList<WishList>();
	    WishList w = null;
	    
	    try {
	        String sql = "SELECT w.*, bd.quantity " +
	                     "FROM wish_list w " +
	                     "INNER JOIN book_dtls bd ON w.bid = bd.bookId " +
	                     "WHERE w.uid = ?";
	        
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, userId);
	        
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            w = new WishList();
	            w.setWid(rs.getInt(1));
	            w.setBid(rs.getInt(2));
	            w.setUserId(rs.getInt(3));
	            w.setBookName(rs.getString(4));
	            w.setAuthor(rs.getString(5));
	            w.setPrice(rs.getDouble(6));
	            w.setDate(rs.getTimestamp(7));
	            w.setPhotoName(rs.getString(8));
	            w.setQuantity(rs.getInt("quantity")); // Set the quantity
	            list.add(w);
	            System.out.println(w.getWid() + " " + w.getBid() + " " + w.getUserId());
	        }
	        
	        rs.close();
	        ps.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return list;
	}
	public boolean deleteBook(int bid, int uid, int wid) {
		boolean f = false;
		try {

			String sql = "delete from wish_list where bid=? and uid=? and wid=?";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, bid);
			ps.setInt(2, uid);
			ps.setInt(3, wid);

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
	public boolean isBookInWishlist(int bid, int uid) {
        boolean isBookInWishlist = false;
       
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
           
            String sql = "SELECT COUNT(*) AS count FROM wish_list WHERE bid = ? AND uid = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bid);
            ps.setInt(2, uid);
            rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("count");
                isBookInWishlist = count > 0;
            }
  
            } catch (Exception e) {
                e.printStackTrace();
            }
        

        return isBookInWishlist;
    }
	
	
	public int getBookCountByUser(int userId) {
		int count = 0;
		try {

			String sql = "SELECT count(*) AS total FROM wish_list WHERE uid = ?";

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

}

