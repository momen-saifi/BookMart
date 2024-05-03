package com.admin.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.DAO.BookDAOImpl;
import com.DAO.UserDAOImpl;
import com.DB.BookDtls;
import com.DB.DBConnect;
import com.entity.User;

@WebServlet("/add_books")
@MultipartConfig
public class BooksAdd extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			String bookName = req.getParameter("bname");
			String author = req.getParameter("author");
			String price = req.getParameter("price");
			String categories = req.getParameter("categories");
			String status = req.getParameter("status");
			
			Part part = req.getPart("bimg");
			String fileName = part.getSubmittedFileName();
			int quantity=Integer.parseInt(req.getParameter("quantity"));

			BookDtls b = new BookDtls(bookName, author, price, categories, status, fileName, "admin",quantity);
			
			BookDAOImpl dao=new BookDAOImpl(DBConnect.getConn());
			
			boolean f=dao.addBooks(b);
			
			HttpSession session=req.getSession();
			
			if(f)
			{
				
				
				String path=getServletContext().getRealPath("")+"book";
				
				File file=new File(path);
				
				part.write(path + File.separator + fileName );
				
				System.out.println(path);
				
				session.setAttribute("succMsg", "Book Add Successfully");
				resp.sendRedirect("admin/add_books.jsp");
			}
			else {

				session.setAttribute("failedMsg", "Something wrong on server");
				resp.sendRedirect("admin/add_books.jsp");	
			}
			

			System.out.println(b);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
