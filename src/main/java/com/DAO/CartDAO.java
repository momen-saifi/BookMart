package com.DAO;

import java.util.List;

import com.entity.Cart;

public interface CartDAO {

	public boolean addCart(Cart c);

	public List<Cart> getBookByUser(int userId);

	public boolean deleteBook(int bid, int uid, int cid);

	public boolean deleteBookByUser(int userId);

	public int getBookCountByUser(int userId);

	public void deleteBookCountNill();

	public boolean getBookByBUId(int userId, int bid);

	public boolean updatePieceCountByBUId(int userId, int bid);
	
	public boolean removePieceCountByBUId(int userId, int bid);
	
	
}
