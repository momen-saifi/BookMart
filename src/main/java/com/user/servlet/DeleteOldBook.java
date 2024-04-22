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
import com.DB.DBConnect;

@WebServlet("/delete_old_book")
public class DeleteOldBook extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		String category = req.getParameter("category");
		int bid=Integer.parseInt(req.getParameter("bid"));
		
//		System.out.println(email+" "+category+" "+bid);

		BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
		boolean f = dao.oldBookDelete(email, category,bid);

		HttpSession session = req.getSession();

		if (f) {
			session.setAttribute("succMsg", "Old Book Delete Sucessfully");
			resp.sendRedirect("old_book.jsp");
		} else {
			session.setAttribute("failedMsg", "Something wrong on server");
			resp.sendRedirect("old_book.jsp");
		}

	}

	@Override
	public String toString() {
		return "DeleteOldBook [getInitParameterNames()=" + getInitParameterNames() + ", getServletConfig()="
				+ getServletConfig() + ", getServletContext()=" + getServletContext() + ", getServletInfo()="
				+ getServletInfo() + ", getServletName()=" + getServletName() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

}
