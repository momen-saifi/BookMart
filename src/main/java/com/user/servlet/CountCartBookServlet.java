package com.user.servlet;

import java.io.IOException;
import java.io.PrintWriter;

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

@WebServlet("/count_book")
public class CountCartBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			PrintWriter out = resp.getWriter();
			int uid = Integer.parseInt(req.getParameter("uid"));

			CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
			int f = dao.getBookCountByUser(uid);

			out.println(f);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
