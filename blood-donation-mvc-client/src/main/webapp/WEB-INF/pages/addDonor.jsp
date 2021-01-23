<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>  
  
<!DOCTYPE html>
<html>
<head>
<title>New Donor</title>

<link rel="shortcut icon" href="assets/favicon.ico" type="image/x-icon">
<link rel="icon" href="assets/favicon.ico" type="image/x-icon">

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/formstyle.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous">
    </script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous">
    </script>
	
<script type="text/javascript">
$(document).ready(
		function(){
				$("#dateOfBirth").change(function(){
					var dateOfBirthVal = $("#dateOfBirth").val();
					var dateOfBirth = new Date(dateOfBirthVal);
					var currentAge = Math.floor((Date.now() - dateOfBirth)/(31557600000));
					$("#donorAge").val(currentAge);
					});
			}
		);

</script>	



</head>
<body>

<div class="container px-0">
	<header class="head my-0 ">
		<nav
			class="navbar  navbar-expand-xl navbar-light head__custom-nav py-0 px-0"
			style="background-color: #fff;">
			<a class="navbar-brand d-flex align-items-center" href="/"> <img
				src="assets/images/logo.png" alt="website logo">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav">
				<span><img src="assets/images/menubutton.png" alt=""></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarNav">
				<ul class="navbar-nav mr-1">
					<li class="nav-item"><a class="nav-link" href="/">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#">About
							Us</a></li>
					<li class="nav-item"><a class="nav-link" href="/donors">Blood-Donors</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="/camps"
						>Blood-Donation Camps</a></li>
					<li class="nav-item"><a class="nav-link text-danger" href="#">Contact
							us</a></li>
				</ul>
			</div>
		</nav>
	</header>
</div>

<section class="newFormSection">
	<h2 class="title">I want to be a Donor!</h2>
	<small class="mb-1" style="display: block; text-align: center;">Provide the details to register as a Blood-Donor</small>
	<div class="container">
			
			<form:form action="submitNewDonor" method="POST" modelAttribute="newDonorObject">
			<div class="newForm row">
			<div style="display:none;">
				<form:input path="donorId" type="hidden" value="" name="donorId" />
				<label for="donorId">Donor ID</label>
			</div>
			<div class="form-field col-lg-12">
				<form:input path="donorName" class="input-text" type="text" name="donorName"/>
				<label for="donorName" class="label">Donor Name</label>
			</div>
			<div class="form-field col-lg-5">
				<form:input path="dateOfBirth" class="input-text" type="date" id="dateOfBirth"/>
				<label for="dateOfBirth" class="label">Date of Birth</label>
			</div>
			<div class="form-field col-lg-3">
				<form:input path="donorAge" class="input-text" id="donorAge"/>
				<label for="donorAge" class="label">Age</label>
			</div>
			<div class="form-field col-lg-4">
				<form:select path="donorGender" class="input-text" >
					<option value="Male" selected>Male</option>
					<option value="Female">Female</option>
					<option value="X">Others</option>
				</form:select> 
				<label for="donorGender" class="label">Gender</label>
			</div>
			<div class="form-field col-lg-6">
				<form:select path="bloodGroup" id="bloodGroup" class="input-text" >
					<option value="APOS" selected>A-Positive</option>
					<option value="ANEG">A-Negative</option>
					<option value="BPOS">B-Positive</option>
					<option value="BNEG">B-Negative</option>
					<option value="ABPOS">AB-Positive</option>
					<option value="ABNEG">AB-Negative</option>
					<option value="OPOS">O-Positive</option>
					<option value="ONEG">O-Negative</option>
				</form:select>
				<label for="bloodGroup" class="label">Blood-Group</label>
			</div>
			<div class="form-field col-lg-6">
				<form:input path="location" class="input-text"  name="location"/>
				<label for="location" class="label">Location</label>
			</div>
			<div class="form-field col-lg-5">
				<form:input path="phoneNumber" class="input-text" name="phoneNumber"/>
				<label for="phoneNumber" class="label">Phone Number</label>
			</div>
			<div class="form-field col-lg-7">
				<form:input path="emailAddr" class="input-text" name="emailAddr"/>
				<label for="emailAddr" class="label">Email Address</label>
			</div>
			<div class="form-field col-lg-12" title="Approximate Date of Previous Blood Donation">
				<form:input path="lastDonated" class="input-text"  type="date" name="lastDonated"/>
				<label for="lastDonated" class="label">Date of Last Donation</label>
			</div>
			
			<div style="display:none;">
				<label for="">Donation Camp </label>
				<form:input path="donationCampName" type="hidden" value="UNREGISTERED"/>
			</div>
			
			<div class="form-field col-lg-12">
				<input class="submit-btn mx-auto" type="submit" value="Add Donor" />
			</div>
			</div>
			</form:form>
		
	</div>
</section>
</body>
</html>