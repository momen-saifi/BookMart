package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DAO.WishListDAOImpl;
import com.DB.BookDtls;
import com.DB.DBConnect;
import com.entity.WishList;

@WebServlet("/wish_list")
public class WishListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int bid = Integer.parseInt(req.getParameter("bid"));
            int uid = Integer.parseInt(req.getParameter("uid"));
            
            

            // Check if the book is already in the wishlist for the user
            WishListDAOImpl wishListDAO = new WishListDAOImpl(DBConnect.getConn());
            boolean isBookInWishlist = wishListDAO.isBookInWishlist(bid, uid);

            if (isBookInWishlist) {
                // Book is already in the wishlist, set session attribute and redirect
                HttpSession session = req.getSession();
                session.setAttribute("addWishList", "Book is already in your wishlist");
                resp.sendRedirect("all_new_book.jsp");
                return; // Stop further execution
            }

            // Book is not in the wishlist, proceed with adding it
            BookDAOImpl bookDAO = new BookDAOImpl(DBConnect.getConn());
            BookDtls book = bookDAO.getBookById(bid);

            WishList wishList = new WishList();
            wishList.setBid(bid);
            wishList.setUserId(uid);
            wishList.setBookName(book.getBookName());
            wishList.setAuthor(book.getAuthor());
            wishList.setPrice(Double.parseDouble(book.getPrice()));
            wishList.setPhotoName(book.getPhotoName());

            boolean isSuccess = wishListDAO.addWishList(wishList);

            HttpSession session = req.getSession();

            if (isSuccess) {
                session.setAttribute("addWishList", "Book added to wishlist successfully");
            } else {
                session.setAttribute("failed", "Something went wrong on the server");
            }

            resp.sendRedirect("all_new_book.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
