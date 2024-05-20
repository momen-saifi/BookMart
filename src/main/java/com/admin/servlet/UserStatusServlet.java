package com.admin.servlet;

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

@WebServlet("/user_status")
public class UserStatusServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
		
		
			String email = req.getParameter("email");
			String status = req.getParameter("status");
			
			
			
			
			
			HttpSession session=req.getSession();
			UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
			boolean f = dao.upadteUserStatus(email,status);
			if (f) {
				
				if (status=="Active") {
					session.setAttribute("succMsg", "User Active Successfully");
					resp.sendRedirect("admin/users_list.jsp");
				} else {
					session.setAttribute("succMsg", "User Blocked Successfully");
					resp.sendRedirect("admin/users_list.jsp");
				}
			} else {
				session.setAttribute("failedMsg", "SomeThing went Wrong on server");
				resp.sendRedirect("admin/users_list.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
