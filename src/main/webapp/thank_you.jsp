<!-- thank_you.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thank You!</title>
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

.thank-you-container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	padding: 40px;
	text-align: center;
	margin-top: 50px;
}

.thank-you-container h1 {
	color: #28a745;
	font-size: 2.5rem;
	margin-bottom: 20px;
}

.thank-you-container p {
	font-size: 1.2rem;
}

.thank-you-container a {
	color: #007bff;
	text-decoration: none;
}

.thank-you-container a:hover {
	text-decoration: underline;
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
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
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
					<li class="nav-item"><a class="nav-link"
						href="contact_page.jsp">Contact</a></li>
					<li class="nav-item"><a class="nav-link" href="login_page.jsp">Login</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="register_page.jsp">Sign up</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="thank-you-container">
			<h1>Thank You!</h1>
			<p>Your message has been successfully sent. We appreciate your
				reaching out to us.</p>
			<p>
				We will get back to you soon. Meanwhile, feel free to <a
					href="index.jsp">return to the homepage</a> or <a
					href="contact_page.jsp">contact us again</a>.
			</p>
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
