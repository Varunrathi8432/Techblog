<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.techblog.dao.UserDao"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.entities.User"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>
<%
int pid = Integer.parseInt(request.getParameter("post_id"));
PostDao dao = new PostDao(ConnectionProvider.getConnection());
Post post = dao.getPostbyPid(pid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=post.getPtitle()%></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
/* Custom Styling */
body {
	background-color: #f7f7f7;
	font-family: 'Roboto', sans-serif;
}
/* Sticky Navbar */
.navbar {
	position: sticky;
	top: 0;
	z-index: 1000;
}

.blog-header {
	background-color: #343a40;
	color: #fff;
	padding: 50px;
	text-align: center;
}

.blog-header h1 {
	font-size: 3rem;
}

.blog-header p {
	font-size: 1.2rem;
}

.card {
	border: none;
	margin-top: -50px;
}

.card-body {
	padding: 30px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.blog-content {
	line-height: 1.8;
	margin-bottom: 20px;
}

.blog-image {
	max-width: 100%;
	border-radius: 10px;
	margin-bottom: 20px;
	object-fit: cover;
	max-height: 400px;
}

.blog-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
}

.blog-footer .btn {
	padding: 10px 30px;
	border-radius: 30px;
}

.blog-footer .btn:hover {
	color: #007bff;
}

pre {
	background-color: #f4f4f4;
	padding: 15px;
	border-radius: 5px;
	font-size: 1rem;
	line-height: 1.5;
	overflow-x: auto;
}

code {
	color: #d63384;
	font-family: 'Courier New', Courier, monospace;
}
</style>
</head>
<body>
	<!-- navbar starts -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<div class="container-fluid">
			<a class="navbar-brand" href="profile.jsp">TechBlog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="profile.jsp"><span class="fa fa-home"></span>
							Home</a></li>
					<li class="nav-item"><a class="nav-link" href="contact_page_login.jsp"><span
							class="fa fa-phone"></span> Contact</a></li>
					<li class="nav-item"><a class="nav-link"
						data-bs-toggle="modal" data-bs-target="#add-post-modal" href="#"><span
							class="fa fa-plus-square"></span> Do Post</a></li>
				</ul>
				<ul class="navbar-nav me-right">
					<li class="nav-item"><a class="nav-link" href="#!"
						data-bs-toggle="modal" data-bs-target="#profile-modal"><span
							class="fa fa-user-circle"></span> <%=user.getUsername()%></a></li>
					<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
							class="fa fa-sign-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- navbar ends -->

	<!-- Message -->
	<%
	Message msg = (Message) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div class="alert <%=msg.getCssClass()%>" role="alert"><%=msg.getContent()%></div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<!-- main body section -->
	<div class="blog-header">
		<h1><%=post.getPtitle()%></h1>
	</div>
	<!-- Blog Content -->
	<div class="container">
		<div class="card">
			<div class="card-body">
				<p class='text-muted'>
					<%
					UserDao ud = new UserDao(ConnectionProvider.getConnection());
					%>
					<i>By <%=ud.getUserByid(post.getUid()).getUsername()%> on <%=DateFormat.getDateTimeInstance().format(post.getPdate())%></i>
				</p>
				<img src="img/<%=post.getPimage()%>" class='blog-image'
					alt='Blog Image'>
				<div class='blog-content'><%=post.getPcontent()%></div>
				<h5>Code :</h5>
				<pre><code><%=post.getPcode()%></code>
				</pre>
				<!-- Blog Footer -->
				<div class="blog-footer">
					<!-- Like Button -->
					<%
					LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
					%>
					<a href="#" onclick="doLike(<%=post.getPid()%>,<%=user.getId()%>)"
						class="btn primary-background text-white"> <i
						class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ld.countLikeOnPost(post.getPid())%></span>
					</a>
				</div>
			</div>
		</div>
	</div>

	<!-- profile modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<h5 class="modal-title" id="exampleModalLabel">Techblog</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<div id="img-div">
							<img id="profile-picture" src="img/<%=user.getProfile()%>"
								class="img-fluid" style="border-radius: 50%; max-width: 100px;">
							<h5 class="modal-title" id="profile-head"><%=user.getUsername()%></h5>
						</div>

						<!-- profile-detail -->
						<div id="profile-detail">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">Id :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getRdate().toString()%></td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- profile-edit -->
						<div id="profile-edit" style="display: none;">
							<h3 class="mt-2">Edit Details</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tbody>
										<tr>
											<th scope="row"><label for="name">Name :</label></th>
											<td><input type="text" class="form-control" id="name"
												name="user_name" value="<%=user.getUsername()%>"></td>
										</tr>
										<tr>
											<th scope="row"><label for="email">Email :</label></th>
											<td><input type="email" class="form-control" id="email"
												name="user_email" value="<%=user.getEmail()%>"></td>
										</tr>
										<tr>
											<th scope="row"><label for="password">Password :</label></th>
											<td><input type="password" class="form-control"
												id="password" name="user_password"
												value="<%=user.getUserpassword()%>"></td>
										</tr>
										<tr>
											<th scope="row"><label for="profile">New
													Profile:</label></th>
											<td><input type="file" class="form-control" id="profile"
												name="user_profile"></td>
										</tr>
										<tr>
											<th scope="row"><label for="status">Status :</label></th>
											<td><textarea rows="3" class="form-control" id="status"
													name="user_about"><%=user.getAbout()%></textarea></td>
										</tr>
									</tbody>
								</table>
								<div class="container">
									<button type="submit" class="btn btn-primary">Save</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button id="profile-edit-btn" type="button" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- post-modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<h5 class="modal-title" id="exampleModalLabel">Techblog</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<h3 class="mb-3">Provide Post details</h3>
						<form id="add-post-form" action="AddPostServlet" method="post"
							enctype="multipart/form-data">
							<div class="mb-3">
								<select class="form-select" name="catid">
									<option selected disabled="disabled">--Select
										Catogory--</option>
									<%
									ArrayList<Category> clist = dao.getAllCategories();
									for (Category c : clist) {
									%>
									<option value="<%=c.getCid()%>"><%=c.getCname()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="input-group mb-3">
								<input name="ptitle" type="text" placeholder="Enter Post Title"
									class="form-control">
							</div>
							<div class="mb-3">
								<textarea name="pcontent" rows="3" class="form-control"
									placeholder="Enter your content"></textarea>
							</div>
							<div class="mb-3">
								<textarea name="pcode" rows="3" class="form-control"
									placeholder="Enter your program (if any)"></textarea>
							</div>
							<div class="row g-2 align-items-center mb-3">
								<div class="col-auto">
									<label for="inputfile" class="col-form-label">Select
										Image :</label>
								</div>
								<div class="col-sm-7">
									<input name="pimage" type="file" id="inputfile"
										class="form-control">
								</div>
							</div>
							<div class="container text-center">
								<button type="submit" class="btn primary-background text-white">Post</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<footer class="bg-dark text-white text-center py-3 mt-5">
		<div class="container">
			<p class="mb-0">© 2024 TechBlog. All Rights Reserved.</p>
			<p class="mb-0">
				<a href="privacy_policy.jsp" class="text-white">Privacy Policy</a> |
				<a href="terms_of_service.jsp" class="text-white">Terms of Service</a>
			</p>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="js/profile.js" type="text/javascript"></script>
	<script>
		document.addEventListener("DOMContentLoaded", () => {
		    // Select the form
		    const form = document.getElementById("add-post-form");
	
		    // Listen for the form submission
		    form.addEventListener("submit", async (event) => {
		        // Prevent the default form submission behavior
		        event.preventDefault();
		        console.log("You have clicked on submit...");
	
		        // Create a new FormData object from the form
		        const formData = new FormData(form);
	
		        try {
		            // Send the form data using the fetch API
		            const response = await fetch("AddPostServlet", {
		                method: 'POST',
		                body: formData,
		            });
	
		            // Process the response
		            const data = await response.text();
	
		            if (data.trim() === 'done') {
		                swal("Good job!", "Saved successfully", "success")
				        .then((value) => {
				        	window.location="profile.jsp";
				        });
		            } else {
		                swal("Error!!", "Something went wrong, try again...", "error");
		            }
		        } catch (error) {
		            // Handle any errors
		            swal("Error!!", "Something went wrong, try again...", "error");
		        }
		    });
		});
	</script>
	<script>
		function doLike(pid, uid) {
		    console.log(pid + "," + uid);
		    
		    // Prepare the data to be sent
		    const data = new URLSearchParams({
		        uid: uid,
		        pid: pid,
		        operation: 'like'
		    });
	
		    // Send the request using Fetch API
		    fetch('LikePostServlet', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/x-www-form-urlencoded' // Same as a form submission
		        },
		        body: data.toString() // Send the data as URL-encoded string
		    })
		    .then(response => {
		        // Check if the response status is OK (200-299)
		        if (!response.ok) {
		            throw new Error(`Server error: ${response.status}`);
		        }
		        return response.text(); // Convert the response to text
		    })
		    .then(data => {
		        console.log(data);
	            let likeCounterElement = document.querySelector('.like-counter');
	            let currentCount = parseInt(likeCounterElement.innerHTML, 10) || 0;
		        if (data.trim() === 'true') {
		            // Find the like-counter element and update it
		            likeCounterElement.innerHTML = currentCount + 1;
		        }else{
		            likeCounterElement.innerHTML = currentCount - 1;	        	
		        }
		    })
		    .catch(error => {
		        console.error('Error:', error);
		    });
		}
	</script>
</body>
</html>