package com.techblog.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		User user=dao.getUserByEmailAndPassword(email , password );
		
		if(user!=null){
			HttpSession session=request.getSession();
			session.setAttribute("currentUser", user);
			response.sendRedirect("profile.jsp");
			
		}else {
			Message msg=new Message("Invalid details... Try Again!", "error", "alert-danger");
			HttpSession sesssion=request.getSession();
			sesssion.setAttribute("msg", msg);
			response.sendRedirect("login_page.jsp");
		}
	}

}
