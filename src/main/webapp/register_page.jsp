<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	<!-- navbar -->
	<%@include file="normal_navbar.jsp"%>

	<main class="primary-background pb-3">
		<div class="container">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-header primary-background text-white text-center">
						<span class="fa fa-user-plus fa-3x"></span> <br> Register
						here
					</div>
					<div class="card-body">
						<form id="reg-form" action="RegisterServlet" method="post">
							<div class="mb-3">
								<label for="user_name" class="form-label">User Name</label> 
								<input name="user_name" type="text" class="form-control"
									id="user_name" aria-describedby="emailHelp" placeholder="Enter name" required="required">
							</div>
							
							<div class="mb-3">
								<label for="exampleInputEmail1" class="form-label">Email
									address</label> <input name="email" type="email" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"  placeholder="Enter email" required="required">
							</div>
							
							<div class="mb-3">
								<label for="gender" class="form-label">Select Gender</label>
								<br>
								<input type="radio" class="gender" name="gender" value="male">Male
								<input type="radio" class="gender" name="gender" value="female">Female								
							</div>
							
							<div class="mb-3">
								<textarea name="about" class="form-control" rows="5" placeholder="Enter something about yourself"></textarea>
							</div>
							
							<div class="mb-3">
								<label for="exampleInputPassword1" class="form-label">Password</label>
								<input name="user_password" type="password" class="form-control"
									id="exampleInputPassword1"  placeholder="Password" required="required">
							</div>
							
							<div class="mb-3 form-check">
								<input type="checkbox" class="form-check-input"
									id="exampleCheck1" required="required"> <label class="form-check-label"
									for="exampleCheck1">agree terms and conditions</label>
							</div>
							<div class="container text-center" id="loader" style="display: none">
								<span class="fa fa-refresh fa-spin fa-4x"></span>
								<h4>Please wait..</h4>
							</div>
							<button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    console.log("loaded........");

	    document.getElementById('reg-form').addEventListener('submit', function (event) {
	        event.preventDefault();

	        let form = new FormData(this);

	        document.getElementById("submit-btn").style.display = "none";
	        document.getElementById("loader").style.display = "block";

	        //send register servlet:
	        fetch("RegisterServlet", {
	            method: 'POST',
	            body: form
	        })
	        .then(response => response.text())
	        .then(data => {
	            console.log(data);

	            document.getElementById("submit-btn").style.display = "block";
	            document.getElementById("loader").style.display = "none";

	            if (data.trim() === 'done') {
	                swal("Registered successfully..We are going to redirect to login page")
	                .then((value) => {
	                    window.location = "login_page.jsp";
	                });
	            } else {
	                swal(data);
	            }
	        })
	        .catch(error => {
	            document.getElementById("submit-btn").style.display = "block";
	            document.getElementById("loader").style.display = "none";
	            swal("something went wrong..try again");
	            console.error('Error:', error);
	        });
	    });
	});
	</script>
	</body>
</html>