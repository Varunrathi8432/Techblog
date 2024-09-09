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

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.UpdateImage;

@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		int catid=Integer.parseInt(request.getParameter("catid"));
		String ptitle=request.getParameter("ptitle");
		String pcontent=request.getParameter("pcontent");
		String pcode=request.getParameter("pcode");		
		Part pimage=request.getPart("pimage");
		String pimagename=pimage.getSubmittedFileName();
		
		HttpSession session = request.getSession();
		User user=(User)session.getAttribute("currentUser");
		
		Post post=new Post(ptitle, pcontent, pcode, pimagename, catid, user.getId());
		PostDao dao=new PostDao(ConnectionProvider.getConnection());
		
		if(dao.savePost(post)) {
			ServletContext context=request.getServletContext();
			String path=context.getRealPath("/")+"img"+File.separator+post.getPimage();
			UpdateImage.saveFile(pimage.getInputStream(), path);
			out.print("done");
			
		}else {
			out.print("error");			
		}
		
	}

}
