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

@WebServlet("/user_address")
public class AddAddressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String address = request.getParameter("address");
        String landmark = request.getParameter("landmark");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        User user = (User) request.getSession().getAttribute("userobj");
        user.setAddress(address);
        user.setLandmark(landmark);
        user.setCity(city);
        user.setState(state);
        user.setPincode(pincode);
        
        UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
        boolean success = dao.addAddress(user);
        
        HttpSession session = request.getSession();
        if (success) {
            session.setAttribute("succMsg", "Address added successfully.");
        } else {
            session.setAttribute("failedMsg ", "Failed to add address. Please try again.");
        }
        
        response.sendRedirect("user_address.jsp"); // Redirect to the page where the form is located
    }
}
