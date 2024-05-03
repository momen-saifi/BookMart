package com.DAO;

import java.util.List;

import com.entity.Cart;

public interface WishListDAO {
	public boolean addWishList(Cart c);

	public List<Cart> getBookByUser(int userId);

	public boolean deleteBook(int bid, int uid, int cid);

	public boolean deleteBookByUser(int userId);
	
	public boolean isBookInWishlist(int bid, int uid);

}
