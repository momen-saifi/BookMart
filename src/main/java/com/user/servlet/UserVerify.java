package com.user.servlet;

import java.io.IOException;
import java.io.PrintWriter;

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

@WebServlet("/user_verify")
public class UserVerify extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			String email = req.getParameter("email");

			PrintWriter out = resp.getWriter();
			HttpSession session = req.getSession();

			if (true) {

				UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
				boolean f2 = dao.checkUser(email);
				if (!f2) {
					SendEmail sm = new SendEmail();
					String code = sm.getRandom();

					User user = new User();
					user.setEmail(email);
					user.setCode(code);

					boolean test = sm.sendEmail(user);

					if (test) {
						session.setAttribute("user", user);
						//session.setAttribute("userdata", us);
						resp.sendRedirect("user_verification.jsp");

					//	out.println(code);
						
					}

					else {
						session.setAttribute("failedMsg", "Email is not sended");
						resp.sendRedirect("register.jsp");
					}
				} else {
					session.setAttribute("failedMsg", "User Already Exist Try Another Email Id");
					resp.sendRedirect("register.jsp");
				}
			} else {
				session.setAttribute("failedMsg", "Please Check and Agree & Term Condition");
				resp.sendRedirect("register.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

