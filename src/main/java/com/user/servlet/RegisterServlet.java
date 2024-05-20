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
import com.entity.SendEmail;
import com.entity.User;



@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			String name = req.getParameter("fname");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			String password = req.getParameter("password");
			String check = req.getParameter("check");

			User user = new User();
			user.setName(name);
			user.setEmail(email);
			user.setPhno(phno);
			user.setPassword(password);
			//System.out.print(phno);
			HttpSession session = req.getSession();

			if (check != null) {

				UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
				boolean f2 = dao.checkUser(email);
				if (f2) {
					SendEmail sm = new SendEmail();
					String code = sm.getRandom();

					User cod = new User(name, email, code);

					String message = "Registration successful. Please verify your account using this code: " + code
							+ ".";
					boolean test = sm.sendEmail(message, cod);

					if (test) {
						session.setAttribute("usercod", cod);
						session.setAttribute("userdata", user);
						resp.sendRedirect("verify.jsp");
					} else {
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
