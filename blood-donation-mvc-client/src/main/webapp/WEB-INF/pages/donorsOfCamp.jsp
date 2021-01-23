<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Donors - <c:out value="${campDetails.donationCampName}"></c:out></title>


<link rel="shortcut icon" href='<c:url value="/assets/favicon.ico"></c:url>' type="image/x-icon">
<link rel="icon" href='<c:url value="/assets/favicon.ico"></c:url>' type="image/x-icon">

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

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
    
<!-- Custom CSS -->
<link rel="stylesheet" href='<c:url value="/css/style.css"></c:url>'>
    
</head>
<body>
<div class="container px-0">
	<header class="head my-0 ">
		<nav
			class="navbar  navbar-expand-xl navbar-light head__custom-nav py-0 px-0"
			style="background-color: #fff;">
			<a class="navbar-brand d-flex align-items-center" href="/"> <img
				src='<c:url value="/assets/images/logo.png"></c:url>' alt="website logo">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav">
				<span><img src='<c:url value="/assets/images/menubutton.png"></c:url>' alt=""></span>
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


<div class="container-lg">
	<h2>Donors - ${campDetails.donationCampName}</h2>
		<table class="table table-bordered mx-auto" id="displayTable">
			<tr class="thead-light">
				<th>Donor ID</th>
				<th>Name</th>
				<th>Age</th>
				<th>Gender</th>
				<th>Blood-Group</th>
				<th>Last Donated Date</th>
				<th>Donor Location</th>
				<th>Contact</th>
			</tr>
			
				<c:forEach items="${donorsOfCampList}" var="donor">
					<c:if test="${not empty donor}">
					<tr class="donor">
						<td>${donor.donorId}</td>
						<td>${donor.donorName}</td>
						<td>${donor.donorAge}</td>
						<td>${donor.donorGender}</td>
						<td>${donor.bloodGroup}</td>
						<td>${donor.lastDonated}</td>
						<td>${donor.location}</td>
						<td>${donor.phoneNumber}</td>					
					</tr>
					</c:if>
					<c:if test="${empty donor}">
				<tr class="donor">
					<td colspan="8" style="color:red; text-align:center;">No record found</td>
				</tr>
				
					</c:if>
				</c:forEach>
			
			
		</table>
		<hr />
		<a href="/camps">Back to Donation Camps</a>		
</div>
</body>
</html>