package com.techblog.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.UpdateImage;

@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String name=request.getParameter("user_name");
		String email=request.getParameter("user_email");
		String password=request.getParameter("user_password");
		String about=request.getParameter("user_about");
		Part profile=request.getPart("user_profile");
		String profile_name=profile.getSubmittedFileName();
		
		HttpSession session=request.getSession();
		User user = (User) session.getAttribute("currentUser");
		
		user.setUsername(name);
		user.setEmail(email);
		user.setUserpassword(password);
		user.setAbout(about);
		String oldProfile=user.getProfile();
		if(profile_name.isEmpty()) {
			user.setProfile(oldProfile);
		}else {
			user.setProfile(profile_name);			
		}
		
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		if(dao.updateUser(user)) {
			
			ServletContext context=request.getServletContext();
			String path=context.getRealPath("/")+"img"+File.separator+user.getProfile();
			String oldPath=context.getRealPath("/")+"img"+File.separator+oldProfile;
			
			if(!oldProfile.equals("default.png")) {
				UpdateImage.deleteFile(oldPath);
			}
			
			if(UpdateImage.saveFile(profile.getInputStream(), path)) {
				Message msg = new Message("Profile details updated...", "success", "alert-success");
                session.setAttribute("msg", msg);
			}else {
				Message msg = new Message("Something went wrong...", "error", "alert-danger");
				session.setAttribute("msg", msg);				
			}
		}else {
			Message msg = new Message("Something went wrong...", "error", "alert-danger");
			session.setAttribute("msg", msg);				
		}
		
		response.sendRedirect("profile.jsp");
	}

}
