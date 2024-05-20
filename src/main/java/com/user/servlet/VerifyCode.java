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

@WebServlet("/VerifyCode")
public class VerifyCode extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();

            // Retrieve the user data from the session
            User userdata = (User) session.getAttribute("userdata");

            // If user data exists in the session
            if (userdata != null) {
                UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
                boolean f = dao.userRegister(userdata);
                System.out.print(userdata.getPhno());
                session.removeAttribute("userdata");
                session.removeAttribute("usercod");
                
                if (f) {
                    session.setAttribute("succMsg", "Registration Successful.");
                    response.sendRedirect("login.jsp");
                } else {
                    session.setAttribute("failedMsg", "Something went wrong on the server.");
                    response.sendRedirect("register.jsp");
                }
            } else {
                session.setAttribute("failedMsg", "User data not found in session.");
                response.sendRedirect("register.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
