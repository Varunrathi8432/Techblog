package com.techblog.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String username=request.getParameter("user_name");
		String email=request.getParameter("email");
		String userpassword=request.getParameter("user_password");
		String gender=request.getParameter("gender");
		String about=request.getParameter("about");

		User user=new User(username,email,userpassword,gender,about);

		UserDao dao=new UserDao(ConnectionProvider.getConnection());

		if(dao.saveUser(user)) {
			out.print("done");
		} else {
			out.print("error");
		}
	}

}
