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

@WebServlet("/cancel_order_admin")
public class OrderCancelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			String oid = req.getParameter("oid");

			BookOrderImpl dao = new BookOrderImpl(DBConnect.getConn());
			boolean f = dao.cancelOrderAdmin(oid);
			System.out.println(oid);
//			boolean f2 = false;
//			if (f) {
//				f2 = dao.deleteOrder(oid);
//			}
			HttpSession session = req.getSession();

			if (f) {

				session.setAttribute("succMsg", "Order Cancled Successfully");
				resp.sendRedirect("admin/orders.jsp");
				System.out.print("Cancel ");
			} else {

				session.setAttribute("failedMsg", "Something wrong on server");
				resp.sendRedirect("admin/orders.jsp");
				System.out.print("Wrong");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
