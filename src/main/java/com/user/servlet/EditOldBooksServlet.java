package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DB.BookDtls;
import com.DB.DBConnect;

@WebServlet("/edit_old_books")
public class EditOldBooksServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			int id=Integer.parseInt(req.getParameter("id"));
			String bookName = req.getParameter("bname");
			String author = req.getParameter("author");
			String price = req.getParameter("price");
			int quantity= Integer.parseInt(req.getParameter("quantity"));
			String status = "Active";
			
			
			BookDtls b=new BookDtls();
			b.setBookId(id);
			b.setBookName(bookName);
			b.setAuthor(author);
			b.setPrice(price);
			b.setQuantity(quantity);
			b.setStatus(status);
			
		
		
			BookDAOImpl dao=new BookDAOImpl(DBConnect.getConn());
			
			boolean f=dao.updateEditBooks(b);
			
			
			HttpSession session=req.getSession();
			if(f) {
					session.setAttribute("succMsg", "Book Update Successfully..");
					resp.sendRedirect("old_book.jsp");
			}else {
				
				session.setAttribute("filedMsg", "Something wrong on server");
				resp.sendRedirect("old_book.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	

}
