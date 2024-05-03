package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.UserDAOImpl;
import com.DB.DBConnect;
import com.entity.User;

import res.SendEmail;

@WebServlet("/forgot_password")
public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			String email = req.getParameter("email");

			String password = req.getParameter("password");

			User us = new User();
			us.setEmail(email);
			us.setPassword(password);

			HttpSession session = req.getSession();

			UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
			
			boolean f=dao.changePassword(email, password);
			
			
			if (f) {
				session.setAttribute("succMsg", "Updated Successfully..");
				resp.sendRedirect("register.jsp");
			} else {
				session.setAttribute("failedMsg", "User Already Exist Try Another Email Id");
				resp.sendRedirect("register.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
