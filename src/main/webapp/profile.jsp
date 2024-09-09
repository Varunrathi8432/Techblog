<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="css/profile.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
/* For making the navbar and left section fixed while scrolling */
body {
	display: flex;
	flex-direction: column;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

/* Sticky Navbar */
.navbar {
	position: sticky;
	top: 0;
	z-index: 1000;
}

.container-fluid {
	height: 100%;
}

.row {
	height: 100%;
}

.left-section {
	border-right: 1px solid #ddd;
	/* To visually separate the left and right sides */
	height: 100%;
 	min-height : 100vh;
	/* Ensure it spans the full height of the viewport */
	padding: 0;
	position: sticky;
}

#category-list {
	padding: 0;
	list-style: none;
	margin: 0;
}

#category-list li {
	padding: 10px;
}

#category-list li a {
	display: block;
	width: 100%;
	padding: 10px;
	text-decoration: none;
	color: #000;
}

#category-list li a:hover {
	background-color: #f8f9fa;
}

.right-section {
	padding-left: 20px; /* Optional for some padding between sections */
	overflow-y: auto;
}

.card-img-top {
	width: 100%; /* Set width to 100% of the card */
	height: 200px; /* Fixed height */
	object-fit: cover;
	/* Ensures the image fits nicely inside the card without stretching */
}

footer {
	background-color: #2196f3;
	/* Matches the background color of your banner */
	color: #fff;
}

footer a {
	color: #fff;
	text-decoration: none;
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

	<!-- Body section -->
	<main>
		<div class="container-fluid">
			<div class="row">
				<!-- Left Side - Categories -->
				<div class="col-md-2 left-section">
					<ul id="category-list">
						<!-- Dynamically load categories -->
						<li><a id="first" class="isactive" onclick="getPosts(0,this)"
							href="/Allpost">All Post</a></li>
						<li><a id="second" class="isactive" onclick="getPostsbyuid(<%=user.getId()%>,this)"
							href="/Mypost">My Post</a></li>
						<%
						PostDao d=new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> list = d.getAllCategories();
						for (Category c : list) {
						%>
						<li><a class="isactive"
							onclick="getPosts(<%=c.getCid()%>,this)"
							href="/<%=c.getCname()%>"><%=c.getCname()%></a></li>
						<%
						}
						%>
					</ul>
				</div>

				<!-- Right Side - Posts -->
				<div class="col-md-10 right-section">
					<div class="container text-center mt-3" id="loader">
						<i class="fa fa-refresh fa-3x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					<div class="container-fluid" id="post-container"></div>
				</div>
			</div>
		</div>
	</main>

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
									PostDao dao = new PostDao(ConnectionProvider.getConnection());
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
	<footer class="text-white text-center py-3 mt-5">
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
	function getPosts(catid,temp){
		
		const formData = new URLSearchParams();
		formData.append('cid', catid);
		
		document.querySelectorAll('.isactive').forEach(link => {
	       link.style.backgroundColor = ''; // Reset background color
	    });
		
		fetch("load_posts.jsp",{
			method: 'POST',
			headers: {
		        'Content-Type': 'application/x-www-form-urlencoded', // Set content type for form data
		    },
		    body: formData.toString() // Convert form data to a query string
		})
		.then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        return response.text();  // or response.json() if the server returns JSON
    	})
    	.then(data=>{
    		console.log("done");
			document.getElementById("loader").style.display = "none";
			document.getElementById("post-container").innerHTML=data;
			temp.style.backgroundColor = '#2196f3';
			
		})
		.catch(error => {
	        console.error('There was a problem with the fetch operation:', error);
	    });
	}
	
	function getPostsbyuid(uid,temp){
		const formData = new URLSearchParams();
		formData.append('uid', uid);
		
		document.querySelectorAll('.isactive').forEach(link => {
		       link.style.backgroundColor = ''; // Reset background color
	    });
		
		fetch("user_posts.jsp",{
			method: 'POST',
			headers: {
		        'Content-Type': 'application/x-www-form-urlencoded', // Set content type for form data
		    },
		    body: formData.toString() // Convert form data to a query string
		})
		.then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        return response.text();  // or response.json() if the server returns JSON
    	})
    	.then(data=>{
    		console.log("done");
			document.getElementById("loader").style.display = "none";
			document.getElementById("post-container").innerHTML=data;
			temp.style.backgroundColor = '#2196f3';
			
		})
		.catch(error => {
	        console.error('There was a problem with the fetch operation:', error);
	    });
	}
	
	document.addEventListener("DOMContentLoaded", function () {
		const allPostRef = document.querySelector('.isactive');
		document.querySelectorAll('.isactive').forEach(link=>{
			link.addEventListener("click",function(e){
				e.preventDefault();
			});
		});
		getPosts(0,allPostRef);
	});
	</script>

</body>
</html>