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
import com.entity.SendEmail;
import com.entity.User;

@WebServlet("/user_verify")
public class UserVerify extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            String email = req.getParameter("email");

            PrintWriter out = resp.getWriter();
            HttpSession session = req.getSession();

            if (true) { // This condition seems redundant, consider removing it

                UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
                boolean isUserRegistered = dao.checkUser(email);
                System.out.print(!isUserRegistered);
                if (!isUserRegistered) {
                    SendEmail sm = new SendEmail();
                    String code = sm.getRandom();

                    User user = new User();
                    user.setEmail(email);
                    user.setCode(code);

                    String message = "Your OTP for password reset is: " + code + ". Please use this OTP to verify your identity and reset your password.";

                    boolean isEmailSent = sm.sendEmail(message, user);
                    System.out.println(code);
                    
                    if (isEmailSent) {
                    	System.out.println(code);
                        
                    	session.setAttribute("user", user);
                        
                    	//session.setAttribute("userdata", us);
                        resp.sendRedirect("user_verification.jsp");
                    } else {
                        session.setAttribute("failedMsg", "Failed to send OTP. Please try again.");
                        resp.sendRedirect("forgot_pass.jsp");
                    }
                } else {
                	session.setAttribute("failedMsg", "The provided email address is not registered. Please make sure you have entered the correct email address or register for a new account.");

                    resp.sendRedirect("forgot_pass.jsp");
                }
            } else {
                session.setAttribute("failedMsg", "Something went wrong on the server side.");
                resp.sendRedirect("forgot_pass.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
