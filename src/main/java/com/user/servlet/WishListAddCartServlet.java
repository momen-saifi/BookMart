package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DAO.CartDAOImpl;
import com.DB.BookDtls;
import com.DB.DBConnect;
import com.entity.Cart;

@WebServlet("/wish_list_cart")
public class WishListAddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			int bid = Integer.parseInt(req.getParameter("bid"));

			int uid = Integer.parseInt(req.getParameter("uid"));

			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());

			BookDtls b = dao.getBookById(bid);
			System.out.println(b);
			Cart c = new Cart();
			c.setBid(bid);
			c.setUserId(uid);
			c.setBookName(b.getBookName());
			c.setAuthor(b.getAuthor());
			c.setPrice(Double.parseDouble(b.getPrice()));
			c.setTotal_price(Double.parseDouble(b.getPrice()));

			CartDAOImpl dao2 = new CartDAOImpl(DBConnect.getConn());
			boolean f = dao2.addCart(c);

			HttpSession session = req.getSession();

			if (f) {
				session.setAttribute("addCart", "Book Added to cart");
				resp.sendRedirect("wishlist.jsp");
				System.out.print("WishList added to cart"+c);
			} else {
				session.setAttribute("failed", "Somthing Wrong on server");
				resp.sendRedirect("wishlist.jsp");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
