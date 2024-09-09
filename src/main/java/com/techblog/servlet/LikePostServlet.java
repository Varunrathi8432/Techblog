package com.techblog.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.techblog.dao.LikeDao;
import com.techblog.helper.ConnectionProvider;

public class LikePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String operation = request.getParameter("operation");
        int uid = Integer.parseInt(request.getParameter("uid"));
        int pid = Integer.parseInt(request.getParameter("pid"));
        
        LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
        if (operation.equals("like")) {
        	if(ldao.isLikedByUser(pid, uid)) {
        		boolean f=ldao.deleteLike(pid, uid);
            	out.print(f);
        	}else {
        		boolean f=ldao.insertLike(pid, uid);
        		out.print(f);        		
        	}
        }
	}

}
