package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.DB.BookDtls;

public class BookDAOImpl implements BookDAO {

	private Connection conn;

	public BookDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean addBooks(BookDtls b) {

		boolean f = false;

		try {

			String sql = "insert into book_dtls(bookname,author,price,bookCategory,status,photo,email,quantity) values(?,?,?,?,?,?,?,?)";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, b.getBookName());
			ps.setString(2, b.getAuthor());
			ps.setString(3, b.getPrice());
			ps.setString(4, b.getBookCategory());
			ps.setString(5, b.getStatus());
			ps.setString(6, b.getPhotoName());
			ps.setString(7, b.getEmail());
			ps.setInt(8, b.getQuantity());

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		return f;
	}

	public List<BookDtls> getAllBooks() {

		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;
		try {
			String sql = "select  * from book_dtls";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt(9));
				list.add(b);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public BookDtls getBookById(int id) {

		BookDtls b = null;

		try {
			String sql = "select  * from book_dtls where bookId=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt(9));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return b;
	}

	public boolean updateEditBooks(BookDtls b) {

		boolean f = false;
		try {

			String sql = "update book_dtls set bookname=?,author=?,price=?,status=?,quantity=? where bookId=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, b.getBookName());
			ps.setString(2, b.getAuthor());
			ps.setString(3, b.getPrice());
			ps.setString(4, b.getStatus());
			ps.setInt(5, b.getQuantity());
			ps.setInt(6, b.getBookId());

			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteBooks(int id) {
		boolean f = false;

		try {
			String sql = "delete from book_dtls where bookId=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setInt(1, id);

			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public List<BookDtls> getNewBook() {

		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "select  * from book_dtls where bookCategory=? and status=? order by bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, "New");
			ps.setString(2, "Active");

			ResultSet rs = ps.executeQuery();

			int i = 1;
			while (rs.next() && i <= 4) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt(9));

				list.add(b);
				i++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<BookDtls> getRecentBooks() {

		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "select  * from book_dtls where  status=? order by bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, "Active");

			ResultSet rs = ps.executeQuery();

			int i = 1;
			while (rs.next() && i <= 4) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt(9));

				list.add(b);
				i++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<BookDtls> getOldBooks() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "select  * from book_dtls where bookCategory=? and status=? order by bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, "Old");
			ps.setString(2, "Active");

			ResultSet rs = ps.executeQuery();

			int i = 1;
			while (rs.next() && i <= 4) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));

				list.add(b);
				i++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<BookDtls> getAllRecentBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "select  * from book_dtls where  status=? order by bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, "Active");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt(9));

				list.add(b);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<BookDtls> getAllNewBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "select  * from book_dtls where bookCategory=? and status=? order by bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, "New");
			ps.setString(2, "Active");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt(9));

				list.add(b);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<BookDtls> getAllOldBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "select  * from book_dtls where bookCategory=? and status=? order by bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, "Old");
			ps.setString(2, "Active");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));

				list.add(b);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;

	}

	public List<BookDtls> getBookByOld(String email, String category) {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;
		try {
			String sql = "select * from book_dtls where email=? and bookCategory=?";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, email);
			ps.setString(2, category);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt("quantity"));

				list.add(b);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean oldBookDelete(String email, String category, int bid) {
		boolean f = false;

		try {
			String sql = "delete from book_dtls where email=? and bookCategory=? and bookId=? ";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, email);
			ps.setString(2, category);
			ps.setInt(3, bid);

			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;

	}

	public List<BookDtls> getBookBySearch(String ch) {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "select  * from book_dtls where bookname like ? or author like ? or bookCategory like ? and status=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, "%" + ch + "%");
			ps.setString(2, "%" + ch + "%");
			ps.setString(3, "%" + ch + "%");
			ps.setString(4, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();

				b.setBookId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setQuantity(rs.getInt(9));

				list.add(b);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;

	}
	public boolean updateQuantity(int uid) {
	    boolean f = false;
	   
	    try {
	     
	        conn.setAutoCommit(false); // Start transaction

	        String sqlCart = "SELECT bid, COUNT(*) AS cart_count FROM cart WHERE uid = ? GROUP BY bid";
	        PreparedStatement psCart = conn.prepareStatement(sqlCart);
	        psCart.setInt(1, uid);
	        ResultSet rsCart = psCart.executeQuery();

	        while (rsCart.next()) {
	            int bookId = rsCart.getInt("bid");
	            int cartCount = rsCart.getInt("cart_count");

	            String sqlUpdate = "UPDATE book_dtls SET quantity = quantity - ? WHERE bookId = ?";
	            PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
	            psUpdate.setInt(1, cartCount);
	            psUpdate.setInt(2, bookId);

	            int rowsAffected = psUpdate.executeUpdate();
	            if (rowsAffected > 0) {
	                System.out.println("Quantity updated successfully for book ID: " + bookId);
	            } else {
	                System.out.println("No rows updated for book ID: " + bookId);
	            }

	            psUpdate.close();
	        }

	        conn.commit(); // Commit transaction if all updates are successful
	        f = true; // Set flag to true since transaction was successful
	        psCart.close();
	    } catch (Exception e) {
	        try {
	            if (conn != null) {
	                conn.rollback(); // Roll back transaction if an exception occurs
	            }
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	        e.printStackTrace();
	    } finally {
	        try {
	            if (conn != null) {
	                conn.setAutoCommit(true); // Reset auto-commit mode
	                conn.close(); // Close connection
	            }
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	    }
	    return f;
	}
	
	public int getQuantityByBookId(int bookId) {
        int quantity = 0;
         PreparedStatement ps = null;
        ResultSet rs = null;

        try {
          
            String sql = "SELECT quantity FROM book_dtls WHERE bookId = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookId);
            rs = ps.executeQuery();

            if (rs.next()) {
               
                quantity = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return quantity;
    }

}
