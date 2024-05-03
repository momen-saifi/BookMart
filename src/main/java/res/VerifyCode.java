package res;

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

	public VerifyCode() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("authcode");
			String code = request.getParameter("authcode");
			User userdata=(User) session.getAttribute("userdata");

			if (code.equals(user.getCode())) {
				out.println("true");

				UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn()); // Assuming you have DBConnect class
				boolean f = dao.userRegister(userdata);
				session.removeAttribute("userdata");
				if (f) {
					session.setAttribute("succMsg", "Registration Successfully..");
					response.sendRedirect("register.jsp");
				} else {
					session.setAttribute("failedMsg", "Something wrong on server..");
					response.sendRedirect("register.jsp");
				}
				

			}else {
				out.println("Wrong OTP");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
