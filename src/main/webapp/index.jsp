<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TechBlog</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
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

.card-img-top {
	width: 100%; /* Set width to 100% of the card */
	height: 200px; /* Fixed height */
	object-fit: cover;
	/* Ensures the image fits nicely inside the card without stretching */
}

.home-background {
	background-color: #343a40;
	color: #fff;
	padding: 50px;
	text-align: center;
}

/* Custom style for buttons */
.left-btn {
	margin-right: auto; /* Pushes to the left */
	background-color: #2196f3;
	font-size: 1.1rem;
}

.right-btn {
	margin-left: auto; /* Pushes to the right */
	background-color: #2196f3;
	font-size: 1.1rem;
}

footer {
	background-color: #343a40;
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

	<!-- navbar -->
	<%@include file="normal_navbar.jsp"%>

	<!-- banner -->
	<div class="container-fluid p-0 m-0">
		<div class="home-background text-white py-4 px-3">
			<div class="container">
				<h3 class="display-3">Welcome to TechBlog</h3>
				<p>Welcome to technical blog, world of technology. A programming
					language is a system of notation for writing computer programs.</p>
				<p>Programming languages are described in terms of their syntax
					(form) and semantics (meaning), usually defined by a formal
					language. Languages usually provide features such as a type system,
					variables, and mechanisms for error handling.</p>
				<a href="register_page.jsp"
					class="btn primary-background text-white btn-lg"> <span
					class="fa fa-user-plus"></span> Start! its free
				</a> <a href="login_page.jsp"
					class="btn primary-background text-white btn-lg"> <span
					class="fa fa-user-circle fa-spin"></span> Login
				</a>
			</div>
		</div>
	</div>

	<br>

	<!-- cards -->
	<div class="container">
		<div class="row">
			<%
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			ArrayList<Post> list = dao.getAllPost();
			for (Post post : list) {
			%>
			<div class="col-md-4 mt-2">
				<div class="card">
					<img src="img/<%=post.getPimage()%>" class="card-img-top"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%=post.getPtitle()%></h5>
					</div>
					<div class="card-footer">
						<button class="btn primary-background text-white readMoreBtn">Read
							More</button>
					</div>
				</div>
			</div>
			<%
			}
			%>
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
	<script>
	document.addEventListener("DOMContentLoaded", function () {
		document.querySelectorAll('.readMoreBtn').forEach(btn=>{
			btn.addEventListener("click",function(){
				swal({
					title: "Please SignUp or Login first.",
	                buttons: {
	                    page1: {
	                        text: "Signup",
	                        value: "page1",
	                        className: "left-btn",
	                    },
	                    page2: {
	                        text: "Login",
	                        value: "page2",
	                        className: "right-btn",
	                    }
	                }
	            }).then((value) => {
	                if (value === "page1") {
	                    window.location = "register_page.jsp";  // Replace with your actual URL
	                } else if (value === "page2") {
	                    window.location = "login_page.jsp";  // Replace with your actual URL
	                }
	            });

	            // Use CSS to align the buttons
	            const swalButtons = document.querySelectorAll(".swal-button-container");
	            swalButtons.forEach(buttonContainer => {
	                buttonContainer.style.display = "inline-block"; // Ensure both buttons are inline
	            });

	            // Style the parent container of the buttons to arrange them on the same row
	            const parentContainer = document.querySelector(".swal-footer");
	            parentContainer.style.display = "flex";
	            parentContainer.style.justifyContent = "space-between"; // Align left and right
	        });
		});
	});
</script>
</body>
</html>