<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<div class="row">
	<%
	int uid = Integer.parseInt(request.getParameter("uid"));
	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	ArrayList<Post> posts = dao.getAllPostbyuid(uid);
	for (Post post : posts) {
	%>
	<div class="col-md-4 mt-2">
		<div class="card">
			<img src="img/<%=post.getPimage()%>" class="card-img-top"
				alt="Card image cap">
			<div class="card-body">
				<h5 class="card-title"><%=post.getPtitle()%></h5>
			</div>
			<div class="card-footer">
				<a href="show_blog_page.jsp?post_id=<%=post.getPid()%>"
					class="btn primary-background text-white">Read More</a>
			</div>
		</div>
	</div>
	<%
	}
	%>
	<%
	if (posts.size() == 0) {
	%>
	<div class="col-12 text-center mt-5">
		<div class="alert alert-warning" role="alert">
			<h4 class="alert-heading">No Posts Available</h4>
			<p>Sorry, you haven't posted anything yet. Why not share your first post? It's easy and a great way to get started!</p>
			<hr>
		</div>
	</div>
	<%
	}
	%>

</div>