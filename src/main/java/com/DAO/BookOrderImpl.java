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
				i = rs.getInt("max_id");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}

//	public boolean saveOrder(List<Book_Order> blist) {
//	    boolean f = false;
//	    try {
//	        String sql = "INSERT INTO book_order(order_id, user_name, email, address, phno, book_name, author, price, payment, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//	        String orderAddressSql = "INSERT INTO order_address(address, landmark, city, state, pincode, order_id) VALUES (?, ?, ?, ?, ?, ?)";
//
//	        conn.setAutoCommit(false);
//	        PreparedStatement psOrder = conn.prepareStatement(sql);
//	        PreparedStatement psOrderAddress = conn.prepareStatement(orderAddressSql);
//
//	        for (Book_Order b : blist) {
//	            psOrder.setString(1, b.getOrderId());
//	            psOrder.setString(2, b.getUserName());
//	            psOrder.setString(3, b.getEmail());
//	            psOrder.setString(4, b.getAddress()); // Access address directly from Book_Order object
//	            psOrder.setString(5, b.getPhno());
//	            psOrder.setString(6, b.getBookName());
//	            psOrder.setString(7, b.getAuthor());
//	            psOrder.setString(8, b.getPrice());
//	            psOrder.setString(9, b.getPaymentType());
//	            psOrder.setInt(10, b.getQuantity());
//	            psOrder.addBatch();
//
//	            // Set values for order_address table directly from Book_Order object
//	            psOrderAddress.setString(1, b.getAddress());
//	            psOrderAddress.setString(2, b.getLandmark());
//	            psOrderAddress.setString(3, b.getCity());
//	            psOrderAddress.setString(4, b.getState());
//	            psOrderAddress.setString(5, b.getPincode());
//	            psOrderAddress.setString(6, b.getOrderId());
//	            psOrderAddress.addBatch();
//	        }
//
//	        // Execute batch for book_order table
//	        psOrder.executeBatch();
//	        // Execute batch for order_address table
//	        psOrderAddress.executeBatch();
//
//	        conn.commit();
//	        f = true;
//	        conn.setAutoCommit(true);
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    return f;
//	}

	public boolean saveOrder(List<Book_Order> blist) {
		boolean f = false;
		try {
			String bookOrderSql = "INSERT INTO book_order(order_id, user_name, email,  phno,  price, payment) VALUES (?, ?, ?, ?, ?, ?)";
			String orderAddressSql = "INSERT INTO order_address(address, landmark, city, state, pincode, order_id) VALUES (?, ?, ?, ?, ?, ?)";
			String bookOrderDetailsSql = "INSERT INTO book_order_details(bid,book_name, author, price, order_id,quantity) VALUES (?,?,?, ?, ?, ?)";

			conn.setAutoCommit(false);
			PreparedStatement psBookOrder = conn.prepareStatement(bookOrderSql);
			PreparedStatement psOrderAddress = conn.prepareStatement(orderAddressSql);
			PreparedStatement psBookOrderDetails = conn.prepareStatement(bookOrderDetailsSql);

			// Execute batch for book_order and order_address tables only once with data
			// from the first book object
			if (!blist.isEmpty()) {
				Book_Order firstBook = blist.get(blist.size()-1);

				psBookOrder.setString(1, firstBook.getOrderId());
				psBookOrder.setString(2, firstBook.getUserName());
				psBookOrder.setString(3, firstBook.getEmail());
				psBookOrder.setString(4, firstBook.getPhno());

				psBookOrder.setString(5, firstBook.getTotalPrice());
			//	System.out.print("in order impl"+firstBook.getTotalPrice());
				psBookOrder.setString(6, firstBook.getPaymentType());

				psBookOrder.executeUpdate();

				psOrderAddress.setString(1, firstBook.getAddress());
				psOrderAddress.setString(2, firstBook.getLandmark());
				psOrderAddress.setString(3, firstBook.getCity());
				psOrderAddress.setString(4, firstBook.getState());
				psOrderAddress.setString(5, firstBook.getPincode());
				psOrderAddress.setString(6, firstBook.getOrderId());
				psOrderAddress.executeUpdate();

				// Add all books from the list to the batch for book_order_details table
				for (Book_Order b : blist) {

					psBookOrderDetails.setInt(1, b.getBid());

					psBookOrderDetails.setString(2, b.getBookName());
					psBookOrderDetails.setString(3, b.getAuthor());
					psBookOrderDetails.setString(4, Double.parseDouble(b.getPrice())*Double.parseDouble(b.getQuantity()+"")+"");
					psBookOrderDetails.setString(5, b.getOrderId());
					psBookOrderDetails.setInt(6, b.getQuantity());
					psBookOrderDetails.addBatch();
				}

				// Execute batch for book_order_details table
				psBookOrderDetails.executeBatch();
			}

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
			String sql = "SELECT bo.order_id, bo.payment, bo.price, bo.order_timestamp, "
					+ "CASE WHEN os.order_id IS NOT NULL THEN true ELSE false END AS is_shipped, "
					+ "CASE WHEN od.order_id IS NOT NULL THEN true ELSE false END AS is_dispatched, "
					+ "CASE WHEN oc.order_id IS NOT NULL THEN true ELSE false END AS is_cancelled "
					+ "FROM book_order bo " + "LEFT JOIN orders_shipped os ON bo.order_id = os.order_id "
					+ "LEFT JOIN orders_dispatched od ON bo.order_id = od.order_id "
					+ "LEFT JOIN orders_cancel oc ON bo.order_id = oc.order_id " + "WHERE bo.email = ?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				o = new Book_Order();
				o.setOrderId(rs.getString("order_id"));
				o.setPaymentType(rs.getString("payment"));
				o.setPrice(rs.getString("price"));
				o.setDate(rs.getTimestamp("order_timestamp"));

				o.setShipped(rs.getBoolean("is_shipped"));
				o.setDispatched(rs.getBoolean("is_dispatched"));
				o.setCancle(rs.getBoolean("is_cancelled"));
				
				list.add(o);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Book_Order> getBookByOrderId(String order_id) {
		List<Book_Order> list = new ArrayList<Book_Order>();
		Book_Order o = null;

		try {
			String sql = "SELECT bod.*, " + "bod.bid AS bid, " + "bod.book_name AS book_name, "
					+ "bod.author AS author, " + "bod.price AS price, " + "bod.quantity AS quantity, "
					+ "oa.address AS order_address, " + "oa.landmark AS landmark, " + "oa.city AS city, "
					+ "oa.state AS state, " + "oa.pincode AS pincode, "
					+ "CASE WHEN oc.order_id IS NOT NULL THEN true ELSE false END AS is_cancelled, "
					+ "CASE WHEN od.order_id IS NOT NULL THEN true ELSE false END AS is_dispatched, "
					+ "CASE WHEN os.order_id IS NOT NULL THEN true ELSE false END AS is_shipped "
					+ "FROM book_order_details bod " + "LEFT JOIN order_address oa ON bod.order_id = oa.order_id "
					+ "LEFT JOIN orders_cancel oc ON bod.order_id = oc.order_id "
					+ "LEFT JOIN orders_dispatched od ON bod.order_id = od.order_id "
					+ "LEFT JOIN orders_shipped os ON bod.order_id = os.order_id " + "WHERE bod.order_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, order_id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				o.setId(rs.getInt("id"));
				o.setOrderId(rs.getString("order_id"));
				o.setFulladd(rs.getString("order_address"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));
				o.setBookName(rs.getString("book_name"));
				o.setAuthor(rs.getString("author"));
				o.setPrice(rs.getString("price"));
				boolean isCancelled = rs.getBoolean("is_cancelled");
				boolean isDispatched = rs.getBoolean("is_dispatched");
				boolean isShipped = rs.getBoolean("is_shipped");
				o.setDispatched(isDispatched);
				o.setShipped(isShipped);
				o.setCancle(isCancelled);
				o.setQuantity(rs.getInt("quantity"));
				o.setBid(rs.getInt("bid"));
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
			String sql = "SELECT bo.*, "
					+ "CASE WHEN oc.order_id IS NOT NULL THEN true ELSE false END AS is_cancelled, "
					+ "CASE WHEN od.order_id IS NOT NULL THEN true ELSE false END AS is_dispatched, "
					+ "CASE WHEN os.order_id IS NOT NULL THEN true ELSE false END AS is_shipped "
					+ "FROM book_orders bo " + "LEFT JOIN orders_cancel oc ON bo.order_id = oc.order_id "
					+ "LEFT JOIN orders_dispatched od ON bo.order_id = od.order_id "
					+ "LEFT JOIN orders_shipped os ON bo.order_id = os.order_id";
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
				o.setShipped(rs.getBoolean("is_shipped"));
				o.setCancle(rs.getBoolean("is_cancelled"));
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

			String sql = "INSERT INTO orders_cancel (order_id) VALUES (?)";

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
			String sql = "delete from book_order where order_id=?";

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
			String sql = "SELECT bo.id, bo.order_id, bo.user_name, bo.email, bo.phno, bo.price, bo.payment, oc.cancel_timestamp,"
					+ "oa.address, oa.landmark, oa.city, oa.state, oa.pincode " + "FROM book_order bo "
					+ "INNER JOIN orders_cancel oc ON bo.order_id = oc.order_id "
					+ "INNER JOIN order_address oa ON bo.order_id = oa.order_id";
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				o.setId(rs.getInt("id"));
				o.setOrderId(rs.getString("order_id"));
				o.setUserName(rs.getString("user_name"));
				o.setEmail(rs.getString("email"));
				o.setPhno(rs.getString("phno"));
				o.setTotalPrice(rs.getString("price"));
				o.setPaymentType(rs.getString("payment"));
				// Set columns from order_address table
				o.setAddress(rs.getString("address"));
				o.setDate(rs.getTimestamp("cancel_timestamp"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));
				// Set default values for dispatched, shipped, and cancelled
				o.setDispatched(false);
				o.setShipped(false);
				o.setCancle(false);
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
			String sql = "SELECT bo.id, bo.order_id, bo.user_name, bo.email, bo.phno, bo.price, bo.payment, od.dispatched_timestamp,"
					+ "oa.address, oa.landmark, oa.city, oa.state, oa.pincode " + "FROM book_order bo "

					+ "INNER JOIN orders_dispatched od ON bo.order_id = od.order_id "
					+ "INNER JOIN order_address oa ON bo.order_id = oa.order_id";
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				// Set columns from book_order table
				o.setId(rs.getInt("id"));
				o.setOrderId(rs.getString("order_id"));
				o.setUserName(rs.getString("user_name"));
				o.setEmail(rs.getString("email"));
				o.setPhno(rs.getString("phno"));
				o.setTotalPrice(rs.getString("price"));
				o.setPaymentType(rs.getString("payment"));
				// Set columns from order_address table
				o.setAddress(rs.getString("address"));
				o.setDate(rs.getTimestamp("dispatched_timestamp"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));
				// Set default values for dispatched, shipped, and cancelled
				o.setDispatched(false);
				o.setShipped(false);
				o.setCancle(false);
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
			String sql = "SELECT bo.id, bo.order_id, bo.user_name, bo.email, bo.phno, bo.price, bo.payment, os.shipped_timestamp,"
					+ "oa.address, oa.landmark, oa.city, oa.state, oa.pincode  " + "FROM book_order bo "
					+ "INNER JOIN orders_shipped os ON bo.order_id = os.order_id "
					+ "INNER JOIN order_address oa ON bo.order_id = oa.order_id";

			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				// Set columns from book_order table
				o.setId(rs.getInt("id"));
				o.setOrderId(rs.getString("order_id"));
				o.setUserName(rs.getString("user_name"));
				o.setEmail(rs.getString("email"));
				o.setPhno(rs.getString("phno"));
				o.setTotalPrice(rs.getString("price"));
				o.setPaymentType(rs.getString("payment"));
				// Set columns from order_address table
				o.setFulladd(rs.getString("address"));
				o.setDate(rs.getTimestamp("shipped_timestamp"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));
				// Set default values for dispatched, shipped, and cancelled
				o.setDispatched(false);
				o.setShipped(false);
				o.setCancle(false);
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
			String sql = "SELECT bo.id, bo.order_id, bo.user_name, bo.email, bo.phno, bo.price, bo.payment, bo.order_timestamp ,"
					+ "oa.address, oa.landmark, oa.city, oa.state, oa.pincode " + "FROM book_order bo "
					+ "LEFT JOIN order_address oa ON bo.order_id = oa.order_id "
					+ "LEFT JOIN orders_dispatched od ON bo.order_id = od.order_id "
					+ "LEFT JOIN orders_shipped os ON bo.order_id = os.order_id "
					+ "LEFT JOIN orders_cancel oc ON bo.order_id = oc.order_id "
					+ "WHERE od.order_id IS NULL AND os.order_id IS NULL AND oc.order_id IS NULL";
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				// Set columns from book_order table
				o.setId(rs.getInt("id"));
				o.setOrderId(rs.getString("order_id"));
				o.setUserName(rs.getString("user_name")); // Assuming there is a "name" column in the book_order table
				o.setEmail(rs.getString("email"));
				o.setPhno(rs.getString("phno"));
				o.setTotalPrice(rs.getString("price"));
				o.setPaymentType(rs.getString("payment"));
				// Set columns from order_address table
				// o.setFulladd(rs.getString("address"));
				o.setAddress(rs.getString("address"));
				o.setDate(rs.getTimestamp("order_timestamp"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));
				// Set default values for dispatched, shipped, and cancelled
				o.setDispatched(false);
				o.setShipped(false);
				o.setCancle(false);

				list.add(o);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Book_Order> getNewOrderDetails(String order_id) {
		List<Book_Order> list = new ArrayList<Book_Order>();
		Book_Order o = null;

		try {
			String sql = "SELECT bod.bid, bod.book_name, bod.author, bod.price, bod.quantity, "
					+ "oa.address, oa.landmark, oa.city, oa.state, oa.pincode " + "FROM book_order bo "
					+ "LEFT JOIN order_address oa ON bo.order_id = oa.order_id "
					+ "LEFT JOIN book_order_details bod ON bo.order_id = bod.order_id " + "WHERE bo.order_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, order_id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				o.setBid(rs.getInt("bid"));
				o.setBookName(rs.getString("book_name"));
				o.setAuthor(rs.getString("author"));
				o.setPrice(rs.getString("price"));
				o.setDispatched(false); // New orders are not dispatched
				o.setShipped(false); // New orders are not shipped
				o.setCancle(false); // New orders are not cancelled
				o.setQuantity(rs.getInt("quantity"));
				o.setFulladd(rs.getString("address"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));

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

			String sql = "INSERT INTO orders_dispatched (order_id) VALUES (?)";

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
			String sql = "INSERT INTO orders_cancel (order_id) VALUES (?)";
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
			// Insert the order_id into the orders_shipped table to mark the order as
			// shipped
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

	public List<Book_Order> getDispatchedOrderDetails(String order_id) {
		List<Book_Order> list = new ArrayList<Book_Order>();
		Book_Order o = null;

		try {
			String sql = "SELECT bod.bid, bod.book_name, bod.author, bod.price, bod.quantity, "
					+ "oa.address, oa.landmark, oa.city, oa.state, oa.pincode " + "FROM book_order bo "
					+ "LEFT JOIN order_address oa ON bo.order_id = oa.order_id "
					+ "LEFT JOIN book_order_details bod ON bo.order_id = bod.order_id " + "WHERE bo.order_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, order_id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				o.setBid(rs.getInt("bid"));
				o.setBookName(rs.getString("book_name"));
				o.setAuthor(rs.getString("author"));
				o.setPrice(rs.getString("price"));
				o.setDispatched(false); // New orders are not dispatched
				o.setShipped(false); // New orders are not shipped
				o.setCancle(false); // New orders are not cancelled
				o.setQuantity(rs.getInt("quantity"));
				o.setFulladd(rs.getString("address"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));

				list.add(o);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Book_Order> getShippedOrderDetails(String order_id) {
		List<Book_Order> list = new ArrayList<Book_Order>();
		Book_Order o = null;

		try {
			String sql =  "SELECT bod.bid, bod.book_name, bod.author, bod.price, bod.quantity, "
					+ "oa.address, oa.landmark, oa.city, oa.state, oa.pincode " + "FROM book_order bo "
					+ "LEFT JOIN order_address oa ON bo.order_id = oa.order_id "
					+ "LEFT JOIN book_order_details bod ON bo.order_id = bod.order_id " + "WHERE bo.order_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, order_id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				o = new Book_Order();
				o.setBid(rs.getInt("bid"));
				o.setBookName(rs.getString("book_name"));
				o.setAuthor(rs.getString("author"));
				o.setPrice(rs.getString("price"));
				o.setDispatched(false); // New orders are not dispatched
				o.setShipped(false); // New orders are not shipped
				o.setCancle(false); // New orders are not cancelled
				o.setQuantity(rs.getInt("quantity"));
				o.setFulladd(rs.getString("address"));
				o.setLandmark(rs.getString("landmark"));
				o.setCity(rs.getString("city"));
				o.setState(rs.getString("state"));
				o.setPincode(rs.getString("pincode"));
				list.add(o);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Book_Order> getCancelOrderDetails(String order_id) {
	    List<Book_Order> list = new ArrayList<Book_Order>();
	    Book_Order o = null;

	    try {
	        String sql = "SELECT bo.*, oa.address, oa.landmark, oa.city, oa.state, oa.pincode, " +
	                     "bod.book_name, bod.author, bod.price, bod.quantity ,bod.bid " +
	                     "FROM book_order bo " +
	                     "LEFT JOIN order_address oa ON bo.order_id = oa.order_id " +
	                     "LEFT JOIN book_order_details bod ON bo.order_id = bod.order_id " +
	                     "LEFT JOIN orders_cancel oc ON bo.order_id = oc.order_id " +
	                     "WHERE bo.order_id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, order_id);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            o = new Book_Order();
	            o.setId(rs.getInt("id"));
	            o.setBid(rs.getInt("bid"));
	           
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
	            // No need to fetch payment type, as it's not relevant for cancelled orders
	            // Set dispatched flag to false since it's not a dispatched order
	            o.setDispatched(false);
	            // Set shipped flag to false since it's not a shipped order
	            o.setShipped(false);
	            // Set cancel flag to true since it's a cancelled order
	            o.setCancle(true);
	            o.setQuantity(rs.getInt("quantity"));
	            list.add(o);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

}