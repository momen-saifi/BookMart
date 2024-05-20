package com.user.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DAO.BookOrderImpl;
import com.DAO.CartDAOImpl;
import com.DB.DBConnect;
import com.entity.Book_Order;
import com.entity.Cart;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			HttpSession session = req.getSession();

			int id = Integer.parseInt(req.getParameter("id"));
			String name = req.getParameter("username");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			String address = req.getParameter("address");
			String landmark = req.getParameter("landmark");
			String city = req.getParameter("city");
			String state = req.getParameter("state");
			String pincode = req.getParameter("pincode");
			String paymentType = req.getParameter("payment");
			System.out.print("pay" + paymentType);
			//String fullAdd = address + "," + landmark + "," + city + "," + state + "," + pincode;

			// System.out.println(name+" "+email+" "+phno+" "+fullAdd+" "+paymentType);

			CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());

			List<Cart> blist = dao.getBookByUser(id);
			
			

			if (blist.isEmpty()) {
				session.setAttribute("failedMsg", "Add Item");
				resp.sendRedirect("checkout.jsp");
			} else {
				BookOrderImpl dao2 = new BookOrderImpl(DBConnect.getConn());
				int i = dao2.getOrderNo();

				Book_Order o = null;
				ArrayList<Book_Order> orderList = new ArrayList<Book_Order>();
						String order_id="BOOK-ORD-00" + i;
						double totalPrice=0.0;
				for (Cart c : blist) {
					// System.out.println(c.getBookName()+" "+c.getAuthor()+ ""+c.getPrice());
					i++;
					o = new Book_Order();
					o.setOrderId(order_id);
					o.setBid(c.getBid());
					//System.out.println("BOOK-ORD-00" + i);
					o.setUserName(name);
					o.setEmail(email);
					o.setPhno(phno);
					o.setAddress(address);
					o.setLandmark(landmark);
					o.setCity(city);
					o.setState(state);
					o.setPincode(pincode);
					
					o.setBookName(c.getBookName());
					o.setAuthor(c.getAuthor());
					o.setPrice(c.getPrice()+"");
					
					o.setTotalPrice(c.getTotal_price() + "");
					o.setPaymentType(paymentType);
					o.setQuantity(c.getQuantity());
					orderList.add(o);

				}

				if ("noselect".equals(paymentType)) {
					session.setAttribute("failedMsg", "Please Choose Payment Method");
					resp.sendRedirect("checkout.jsp");

				} else {
					BookDAOImpl bdao = new BookDAOImpl(DBConnect.getConn());
					boolean flag = false;

					flag = bdao.updateQuantity(id);

					System.out.print("flag" + flag);
					if (flag) {
						Boolean f = dao2.saveOrder(orderList);
						System.out.println("Ordder update Success ");
						// System.out.print("flag"+flag);
						if (f) {

							dao.deleteBookByUser(id);
							resp.sendRedirect("order_success.jsp");

							System.out.println("Ordder Success");
						} else {
							session.setAttribute("failedMsg", "Your order could not be processed at the moment. Please try again later.");
							resp.sendRedirect("checkout.jsp");
							// System.out.println("Order failed");
						}
					} else {

						session.setAttribute("failedMsg", "The requested quantity is not available at the moment. Please choose a lower quantity or check back later.");
						resp.sendRedirect("checkout.jsp");
					}

				}

			}
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

}
