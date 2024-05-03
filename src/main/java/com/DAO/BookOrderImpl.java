package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Book_Order;

public class BookOrderImpl implements BookOrderDAO {
	private Connection conn;

	public BookOrderImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	public int getOrderNo() {
		int i = 0;
		try {
			String sql = "SELECT MAX(id) AS max_id FROM book_order";
					
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				i=rs.getInt("max_id");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}

	public boolean saveOrder(List<Book_Order> blist) {
	    boolean f = false;
	    try {
	        String sql = "INSERT INTO book_order(order_id, user_name, email, address, phno, book_name, author, price, payment, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        String orderAddressSql = "INSERT INTO order_address(address, landmark, city, state, pincode, order_id) VALUES (?, ?, ?, ?, ?, ?)";

	        conn.setAutoCommit(false);
	        PreparedStatement psOrder = conn.prepareStatement(sql);
	        PreparedStatement psOrderAddress = conn.prepareStatement(orderAddressSql);

	        for (Book_Order b : blist) {
	            psOrder.setString(1, b.getOrderId());
	            psOrder.setString(2, b.getUserName());
	            psOrder.setString(3, b.getEmail());
	            psOrder.setString(4, b.getAddress()); // Access address directly from Book_Order object
	            psOrder.setString(5, b.getPhno());
	            psOrder.setString(6, b.getBookName());
	            psOrder.setString(7, b.getAuthor());
	            psOrder.setString(8, b.getPrice());
	            psOrder.setString(9, b.getPaymentType());
	            psOrder.setInt(10, b.getQuantity());
	            psOrder.addBatch();

	            // Set values for order_address table directly from Book_Order object
	            psOrderAddress.setString(1, b.getAddress());
	            psOrderAddress.setString(2, b.getLandmark());
	            psOrderAddress.setString(3, b.getCity());
	            psOrderAddress.setString(4, b.getState());
	            psOrderAddress.setString(5, b.getPincode());
	            psOrderAddress.setString(6, b.getOrderId());
	            psOrderAddress.addBatch();
	        }

	        // Execute batch for book_order table
	        psOrder.executeBatch();
	        // Execute batch for order_address table
	        psOrderAddress.executeBatch();

	        conn.commit();
	        f = true;
	        conn.setAutoCommit(true);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}
	public List<Book_Order> getBook(String email) {
	    List<Book_Order> list = new ArrayList<Book_Order>();
	    Book_Order o = null;

	    try {
	        String sql = "SELECT bo.*, " +
	                     "CASE WHEN oc.order_id IS NOT NULL THEN true ELSE false END AS is_cancelled, " +
	                     "CASE WHEN od.order_id IS NOT NULL THEN true ELSE false END AS is_dispatched, " +
	                     "CASE WHEN os.order_id IS NOT NULL THEN true ELSE false END AS is_shipped " +
	                     "FROM book_order bo " +
	                     "LEFT JOIN orders_cancel oc ON bo.order_id = oc.order_id AND bo.email = ? " +
	                     "LEFT JOIN orders_dispatched od ON bo.order_id = od.order_id AND bo.email = ? " +
	                     "LEFT JOIN orders_shipped os ON bo.order_id = os.order_id AND bo.email = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, email);
	        ps.setString(2, email);
	        ps.setString(3, email);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            o = new Book_Order();
	            o.setId(rs.getInt("id"));
	            o.setOrderId(rs.getString("order_id"));
	            o.setUserName(rs.getString("user_name"));
	            o.setEmail(rs.getString("email"));
	            o.setFulladd(rs.getString("address"));
	            o.setPhno(rs.getString("phno"));
	            o.setBookName(rs.getString("book_name"));
	            o.setAuthor(rs.getString("author"));
	            o.setPrice(rs.getString("price"));
	            o.setPaymentType(rs.getString("payment"));
	            // Determine the status of the order based on its presence in the related tables
	            boolean isCancelled = rs.getBoolean("is_cancelled");
	            boolean isDispatched = rs.getBoolean("is_dispatched");
	            boolean isShipped = rs.getBoolean("is_shipped");
	            // Set the status flags
	            o.setDispatched(isDispatched);
	            o.setShiped(isShipped);
	            o.setCancel(isCancelled);
	            o.setQuantity(rs.getInt("quantity"));
	            list.add(o);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public List<Book_Order> getAllOrder() {
	    List<Book_Order> list = new ArrayList<Book_Order>();
	    Book_Order o = null;

	    try {
	        String sql = "SELECT bo.*, " +
	                     "CASE WHEN oc.order_id IS NOT NULL THEN true ELSE false END AS is_cancelled, " +
	                     "CASE WHEN od.order_id IS NOT NULL THEN true ELSE false END AS is_dispatched, " +
	                     "CASE WHEN os.order_id IS NOT NULL THEN true ELSE false END AS is_shipped " +
	                     "FROM book_orders bo " +
	                     "LEFT JOIN orders_cancel oc ON bo.order_id = oc.order_id " +
	                     "LEFT JOIN orders_dispatched od ON bo.order_id = od.order_id " +
	                     "LEFT JOIN orders_shipped os ON bo.order_id = os.order_id";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            o = new Book_Order();
	            o.setId(rs.getInt("id"));
	            o.setOrderId(rs.getString("order_id"));
	            o.setUserName(rs.getString("user_name"));
	            o.setEmail(rs.getString("email"));
	            o.setFulladd(rs.getString("address"));
	            o.setPhno(rs.getString("phno"));
	            o.setBookName(rs.getString("book_name"));
	            o.setAuthor(rs.getString("author"));
	            o.setPrice(rs.getString("price"));
	            o.setPaymentType(rs.getString("payment"));
	            o.setDispatched(rs.getBoolean("is_dispatched"));
	            o.setShiped(rs.getBoolean("is_shipped"));
	            o.setCancel(rs.getBoolean("is_cancelled"));
	            o.setQuantity(rs.getInt("quantity"));
	            list.add(o);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public boolean cancelOrder(String oid) {

		boolean f = false;
		try {
//			String sql ="INSERT INTO order_cancel (order_id, user_name, email, address, phno, book_name, author, price, payment, dispatched, shiped) " +
//					"SELECT order_id, user_name, email, address, phno, book_name, author, price, payment, dispatched, shiped " +
//					"FROM book_order " +
//					"WHERE order_id = ?";
			
			String sql="INSERT INTO orders_cancel (order_id) VALUES (?)";


			PreparedStatement ps = conn.prepareStatement(sql);
			
			ps.setString(1, oid);

			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean deleteOrder(String oid) {
		boolean f = false;
		try {
			String sql ="delete from book_order where order_id=?";


			PreparedStatement ps = conn.prepareStatement(sql);
			
			ps.setString(1, oid);

			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;

	}





	public List<Book_Order> getCanceledOrder() {
	    List<Book_Order> list = new ArrayList<Book_Order>();
	    Book_Order o = null;

	    try {
	        String sql = "SELECT bo.*, oa.address, oa.landmark, oa.city, oa.state, oa.pincode " +
	                     "FROM book_order bo " +
	                     "INNER JOIN orders_cancel oc ON bo.order_id = oc.order_id " +
	                     "INNER JOIN order_address oa ON bo.order_id = oa.order_id";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            o = new Book_Order();
	            o.setId(rs.getInt("id"));
	            o.setOrderId(rs.getString("order_id"));
	            o.setUserName(rs.getString("user_name"));
	            o.setEmail(rs.getString("email"));
	            o.setAddress(rs.getString("address")); // Set address from order_address table
	            o.setLandmark(rs.getString("landmark")); // Set landmark from order_address table
	            o.setCity(rs.getString("city")); // Set city from order_address table
	            o.setState(rs.getString("state")); // Set state from order_address table
	            o.setPincode(rs.getString("pincode")); // Set pincode from order_address table
	            o.setPhno(rs.getString("phno"));
	            o.setBookName(rs.getString("book_name"));
	            o.setAuthor(rs.getString("author"));
	            o.setPrice(rs.getString("price"));
	            o.setPaymentType(rs.getString("payment"));
	            o.setDispatched(false); // Orders in orders_cancel table are always not dispatched
	            o.setShiped(false); // Orders in orders_cancel table are always not shipped
	            o.setCancel(true); 
	            o.setQuantity(rs.getInt("quantity"));
	            list.add(o);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public List<Book_Order> getDispatchedOrder() {
	    List<Book_Order> list = new ArrayList<Book_Order>();
	    Book_Order o = null;

	    try {
	        String sql = "SELECT bo.*, oa.address, oa.landmark, oa.city, oa.state, oa.pincode " +
	                     "FROM book_order bo " +
	                     "INNER JOIN orders_dispatched od ON bo.order_id = od.order_id " +
	                     "INNER JOIN order_address oa ON bo.order_id = oa.order_id";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            o = new Book_Order();
	            o.setId(rs.getInt("id"));
	            o.setOrderId(rs.getString("order_id"));
	            o.setUserName(rs.getString("user_name"));
	            o.setEmail(rs.getString("email"));
	            o.setFulladd(rs.getString("address")); // Set address from order_address table
	            o.setLandmark(rs.getString("landmark")); // Set landmark from order_address table
	            o.setCity(rs.getString("city")); // Set city from order_address table
	            o.setState(rs.getString("state")); // Set state from order_address table
	            o.setPincode(rs.getString("pincode")); // Set pincode from order_address table
	            o.setPhno(rs.getString("phno"));
	            o.setBookName(rs.getString("book_name"));
	            o.setAuthor(rs.getString("author"));
	            o.setPrice(rs.getString("price"));
	            o.setPaymentType(rs.getString("payment"));
	            o.setDispatched(true); // Set dispatched flag to true since it's a dispatched order
	            o.setShiped(false); // Orders in orders_dispatched table are not necessarily shipped yet
	            o.setCancel(false); // Set cancel flag to false since it's not a cancelled order
	            o.setQuantity(rs.getInt("quantity"));
	            list.add(o);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public List<Book_Order> getShippedOrder() {
	    List<Book_Order> list = new ArrayList<Book_Order>();
	    Book_Order o = null;

	    try {
	        String sql = "SELECT bo.*, oa.address, oa.landmark, oa.city, oa.state, oa.pincode " +
	                     "FROM book_order bo " +
	                     "INNER JOIN orders_shipped os ON bo.order_id = os.order_id " +
	                     "INNER JOIN order_address oa ON bo.order_id = oa.order_id";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            o = new Book_Order();
	            o.setId(rs.getInt("id"));
	            o.setOrderId(rs.getString("order_id"));
	            o.setUserName(rs.getString("user_name"));
	            o.setEmail(rs.getString("email"));
	            o.setFulladd(rs.getString("address")); // Set address from order_address table
	            o.setLandmark(rs.getString("landmark")); // Set landmark from order_address table
	            o.setCity(rs.getString("city")); // Set city from order_address table
	            o.setState(rs.getString("state")); // Set state from order_address table
	            o.setPincode(rs.getString("pincode")); // Set pincode from order_address table
	            o.setPhno(rs.getString("phno"));
	            o.setBookName(rs.getString("book_name"));
	            o.setAuthor(rs.getString("author"));
	            o.setPrice(rs.getString("price"));
	            o.setPaymentType(rs.getString("payment"));
	            o.setDispatched(false); // Orders in orders_shipped table are not necessarily dispatched
	            o.setShiped(true); // Set shipped flag to true since it's a shipped order
	            o.setCancel(false); // Set cancel flag to false since it's not a cancelled order
	            o.setQuantity(rs.getInt("quantity"));
	            list.add(o);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public List<Book_Order> getNewOrder() {
	    List<Book_Order> list = new ArrayList<Book_Order>();
	    Book_Order o = null;

	    try {
	        String sql = "SELECT bo.*, oa.address, oa.landmark, oa.city, oa.state, oa.pincode " +
	                     "FROM book_order bo " +
	                     "LEFT JOIN order_address oa ON bo.order_id = oa.order_id " +
	                     "LEFT JOIN orders_dispatched od ON bo.order_id = od.order_id " +
	                     "LEFT JOIN orders_shipped os ON bo.order_id = os.order_id " +
	                     "LEFT JOIN orders_cancel oc ON bo.order_id = oc.order_id " +
	                     "WHERE od.order_id IS NULL AND os.order_id IS NULL AND oc.order_id IS NULL";
	        PreparedStatement ps = conn.prepareStatement(sql);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            o = new Book_Order();
	            o.setId(rs.getInt("id"));
	            o.setOrderId(rs.getString("order_id"));
	            o.setUserName(rs.getString("user_name"));
	            o.setEmail(rs.getString("email"));
	            o.setFulladd(rs.getString("address"));
	            o.setLandmark(rs.getString("landmark"));
	            o.setCity(rs.getString("city"));
	            o.setState(rs.getString("state"));
	            o.setPincode(rs.getString("pincode"));
	            o.setPhno(rs.getString("phno"));
	            o.setBookName(rs.getString("book_name"));
	            o.setAuthor(rs.getString("author"));
	            o.setPrice(rs.getString("price"));
	            o.setPaymentType(rs.getString("payment"));
	            o.setDispatched(false); // New orders are not dispatched
	            o.setShiped(false); // New orders are not shipped
	            o.setCancel(false); // New orders are not cancelled
	            
	            o.setQuantity(rs.getInt("quantity"));
	            list.add(o);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public boolean dispatchOrder(String oid) {
		
		boolean f = false;
		try {
			
//			String sql = "UPDATE book_order " +
//		             "SET dispatched = true " +
//		             "WHERE order_id = ?";

			String sql="INSERT INTO orders_dispatched (order_id) VALUES (?)";

			PreparedStatement ps = conn.prepareStatement(sql);
			
			ps.setString(1, oid);

			int i = ps.executeUpdate();

			if (i == 1) {
				f = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;

	}

	public boolean cancelOrderAdmin(String oid) {
	    boolean f = false;
	    try {
	    	String sql="INSERT INTO orders_cancel (order_id) VALUES (?)";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, oid);

	        int i = ps.executeUpdate();

	        if (i == 1) {
	            f = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}

	public boolean orderShipping(String oid) {
	    boolean f = false;
	    try {
	        // Insert the order_id into the orders_shipped table to mark the order as shipped
	        String insertSql = "INSERT INTO orders_shipped (order_id) VALUES (?)";
	        PreparedStatement insertPs = conn.prepareStatement(insertSql);
	        insertPs.setString(1, oid);
	        int insertResult = insertPs.executeUpdate();

	        // Remove the order_id from the orders_dispatched table
	        String deleteSql = "DELETE FROM orders_dispatched WHERE order_id = ?";
	        PreparedStatement deletePs = conn.prepareStatement(deleteSql);
	        deletePs.setString(1, oid);
	        int deleteResult = deletePs.executeUpdate();

	        // Check if both insert and delete operations were successful
	        if (insertResult == 1 && deleteResult == 1) {
	            f = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}

	
	
	
	

}