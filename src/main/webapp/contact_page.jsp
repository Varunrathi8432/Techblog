<!-- contact_page.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Us</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="css/profile.css" rel="stylesheet" type="text/css">
<style>
body {
	background-color: #f0f2f5;
}

.contact-container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	padding: 40px;
}

.contact-header h2 {
	color: #007bff;
	margin-bottom: 20px;
}

.contact-form .form-control {
	border-radius: 8px;
}

.contact-form .btn-primary {
	background-color: #007bff;
	border: none;
	border-radius: 8px;
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
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<div class="container">
			<a class="navbar-brand" href="index.jsp">TechBlog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a>
					</li>
					<li class="nav-item"><a class="nav-link active"
						href="contact_page.jsp">Contact</a></li>
					<li class="nav-item"><a class="nav-link" href="login_page.jsp">Login</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="register_page.jsp">Sign up</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container mt-5">
		<div class="contact-container">
			<div class="contact-header text-center">
				<h2>Get in Touch with Us!</h2>
			</div>
			<form action="ContactServlet" method="post" class="contact-form">
				<div class="mb-3">
					<label for="name" class="form-label">Name</label> <input
						type="text" class="form-control" id="name" name="name"
						placeholder="Your Name" required>
				</div>
				<div class="mb-3">
					<label for="email" class="form-label">Email Address</label> <input
						type="email" class="form-control" id="email" name="email"
						placeholder="Your Email" required>
				</div>
				<div class="mb-3">
					<label for="message" class="form-label">Message</label>
					<textarea class="form-control" id="message" name="message" rows="5"
						placeholder="Your Message" required></textarea>
				</div>
				<button type="submit" class="btn btn-primary">Send Message</button>
			</form>
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
</body>
</html>
