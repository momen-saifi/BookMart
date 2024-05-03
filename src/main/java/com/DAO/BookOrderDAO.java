package com.DAO;

import java.sql.Connection;
import java.util.List;

import com.entity.Book_Order;

public interface BookOrderDAO {

	public int getOrderNo();

	public boolean saveOrder(List<Book_Order> b);

	public List<Book_Order> getBook(String email);
	
	public List<Book_Order> getAllOrder();
	public List<Book_Order> getNewOrder();
	
	public boolean cancelOrder(String oid);
	
	public boolean deleteOrder(String oid);
	
	public List<Book_Order> getCanceledOrder();
	
	public List<Book_Order> getDispatchedOrder();
	
	public List<Book_Order> getShippedOrder();
	
	
	public boolean dispatchOrder(String oid);
	
	public boolean cancelOrderAdmin(String oid);
	
	public boolean orderShipping(String oid);
	
	
	
	
}
