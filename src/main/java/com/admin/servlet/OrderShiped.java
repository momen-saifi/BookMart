package com.admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookOrderImpl;
import com.DB.DBConnect;


@WebServlet("/order_ship")
public class OrderShiped extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			String oid=req.getParameter("oid");
				BookOrderImpl dao=new BookOrderImpl(DBConnect.getConn());
			
			boolean f=dao.orderShipping(oid);
			
			
			HttpSession session=req.getSession();
			if(f) {
					session.setAttribute("succMsg", "Order Dispatched Successfully..");
					resp.sendRedirect("admin/shipped_order.jsp");
					System.out.print("Order Shiped");
			}else {
				
				session.setAttribute("filedMsg", "Something wrong on server");
				resp.sendRedirect("admin/shipped_order.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	

}
