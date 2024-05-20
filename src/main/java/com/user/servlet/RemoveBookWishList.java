package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.CartDAOImpl;
import com.DAO.WishListDAOImpl;
import com.DB.DBConnect;

@WebServlet("/remove_book_wishlist")
public class RemoveBookWishList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int bid = Integer.parseInt(req.getParameter("bid"));
		int uid = Integer.parseInt(req.getParameter("uid"));
		int wid = Integer.parseInt(req.getParameter("wid"));

		WishListDAOImpl dao = new WishListDAOImpl(DBConnect.getConn());
		boolean f = dao.deleteBook(bid, uid, wid);

		HttpSession session = req.getSession();

		if (f) {
			session.setAttribute("succMsg", "Book Removed from WishList");
			resp.sendRedirect("wishlist.jsp");
		} else {
			session.setAttribute("failedMsg", "Something wrong on server");
			resp.sendRedirect("wishlist.jsp");
		}

	
	}

}
