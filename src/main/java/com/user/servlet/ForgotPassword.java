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



@WebServlet("/forgot_password")
public class ForgotPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            User user = new User();
            user.setEmail(email);
            user.setPassword(password);

            HttpSession session = req.getSession();

            UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
            boolean isPasswordChanged = dao.changePassword(email, password);

            if (isPasswordChanged) {
                session.setAttribute("succMsg", "Password updated successfully.");
                resp.sendRedirect("login.jsp");
            } else {
                session.setAttribute("errorMsg", "Failed to update password. Please try again.");
                resp.sendRedirect("forgot_pass.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
