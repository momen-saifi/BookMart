package com.user.servlet;

import java.io.IOException;
import java.sql.PreparedStatement;

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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			int bid = Integer.parseInt(req.getParameter("bid"));

			int uid = Integer.parseInt(req.getParameter("uid"));

			String location = req.getParameter("loc");
			if(location==null) {
				location="notcart";
			}

			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
			CartDAOImpl dao2 = new CartDAOImpl(DBConnect.getConn());
			HttpSession session = req.getSession();
			int isAvailableBook = 0;
			isAvailableBook = dao.getQuantityByBookId(bid);

			boolean f = false;
			boolean flag = dao2.getBookByBUId(uid, bid);

			if (flag) {
				int cartQuantity = dao2.getQuantityByBUId(uid, bid);
				if (isAvailableBook > cartQuantity) {
					System.out.println(isAvailableBook + " " + cartQuantity);
					f = dao2.updatePieceCountByBUId(uid, bid);
					System.out.println(" Added");

				} else {
					session.setAttribute("failedMsg", "Your Out Of Stock");
					if (location.equals("cart")) {
						resp.sendRedirect("checkout.jsp");
						System.out.println("Not Added");
					} else {
						resp.sendRedirect("all_new_book.jsp");
						System.out.println("Not Added");
					}

					return;
				}

			} else {
				BookDtls b = dao.getBookById(bid);

				Cart c = new Cart();
				c.setBid(bid);
				c.setUserId(uid);
				c.setBookName(b.getBookName());
				c.setAuthor(b.getAuthor());
				c.setPrice(Double.parseDouble(b.getPrice()));
				c.setTotal_price(Double.parseDouble(b.getPrice()));

				f = dao2.addCart(c);

			}

			if (f) {
				session.setAttribute("addCart", "Book Added to cart");
				if (location.equals("cart")) {
					resp.sendRedirect("checkout.jsp");
				} else {
					resp.sendRedirect("all_new_book.jsp");
				}

			} else {
				session.setAttribute("failed", "Somthing Wrong on server");
				if (location.equals("cart")) {
					resp.sendRedirect("checkout.jsp");
				} else {
					resp.sendRedirect("all_new_book.jsp");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
