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

@WebServlet("/update_profile")
public class UpdateProfileServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			int id = Integer.parseInt(req.getParameter("id"));
			String name = req.getParameter("fname");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			
			String password = req.getParameter("password");
			
			HttpSession session = req.getSession();
		
			User u = (User) session.getAttribute("userobj");
			
			String userType = req.getParameter("user_type");
			
			if(password==null) {
				password=u.getPassword();
			}
			System.out.println(id+" "+name+ " "+email+" "+phno+" "+password);

			User us = new User();
			us.setName(name);
			us.setPassword(password);
			us.setPhno(phno);
			us.setId(id);
			
			UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
			boolean f = dao.checkUser(email);
			if (!f) {
				boolean f2 = dao.upadteProfile(us);
				if (f2 ) {
					u.setName(name);
					u.setEmail(email);
					u.setPhno(phno);
					u.setPassword(password);
					if(userType.equals("admin")) {
						session.setAttribute("succMsg", "User Profile Update Successfully");
						resp.sendRedirect("admin/edit_profile.jsp");
						
					}else {
						session.setAttribute("succMsg", "User Profile Update Successfully");
						resp.sendRedirect("edit_profile.jsp");
					}
				
				} else {
					if(userType.equals("admin")) {
						session.setAttribute("failedMsg", "Somethig wrong on server");
						resp.sendRedirect("admin/edit_profile.jsp");
					}else {
						session.setAttribute("failedMsg", "Somethig wrong on server");
						resp.sendRedirect("edit_profile.jsp");
					}
					
				}
			} else {
				session.setAttribute("failedMsg", "Your Password is Incorrect");
				resp.sendRedirect("edit_profile.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
