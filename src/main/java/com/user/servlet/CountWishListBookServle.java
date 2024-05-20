package com.user.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.CartDAOImpl;
import com.DAO.WishListDAOImpl;
import com.DB.DBConnect;


@WebServlet("/count_wishlist_book")
public class CountWishListBookServle extends HttpServlet {
	private static final long serialVersionUID = 1L;
 

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			PrintWriter out = resp.getWriter();
			int uid = Integer.parseInt(req.getParameter("uid"));

			WishListDAOImpl dao = new WishListDAOImpl(DBConnect.getConn());
			int f = dao.getBookCountByUser(uid);

			out.println(f);
			System.out.println(f);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
