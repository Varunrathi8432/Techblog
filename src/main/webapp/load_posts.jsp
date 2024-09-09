<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<div class="row">
	<%
	PostDao dao = new PostDao(ConnectionProvider.getConnection());
	ArrayList<Post> posts = null;
	int cid = Integer.parseInt(request.getParameter("cid"));
	if (cid == 0) {
		posts = dao.getAllPost();
	} else {
		posts = dao.getAllPostbycatid(cid);
	}
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
			<p>We're sorry, but there are no posts available in this category
				at the moment. Please explore other categories.</p>
			<hr>
		</div>
	</div>
	<%
	}
	%>

</div>