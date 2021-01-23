<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>

<title>Donation Camps</title>

<link rel="shortcut icon" href="assets/favicon.ico" type="image/x-icon">
<link rel="icon" href="assets/favicon.ico" type="image/x-icon">

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

<script type="text/javascript">
$(document).ready(
		function(){	

			var URL = "http://localhost:2020/donation-camp-service/api/v1/camps/";
			/* Initial AJAX Call to get locations */
			var config = {

					url : URL+"locations",
					method : 'GET',
					success : function(resp){ 

						var options = new String();
						$.each(resp, function(index, value){
							if(value!="UNKNOWN"){
								options+="<option value='"+value+"'>"+value+"</option>";
							}
						});

						$("#location").append(options);

						},
					failure : function(resp) {
						console.log(resp);
						alert("Failed!");
					}
				};

				$.ajax(config);

			/* AJAX Call to display filtered results */
				$("#filterbtn").click(function(){
						var loc = $("#location").val();

						function displayCamps(data){
							$.each(data, function(key,value){
								if(value.id != 1000){
								   var row =$('<tr class="camp"/>');
								  				  					   
								  var column ="<td>"+value.id+"</td>"+
								              "<td><a href='/donors/?campId="+value.id+"'>"+value.donationCampName+"</a></td>"+
								              "<td>"+value.campDate+"</td>"+
								              "<td>"+value.location+"</td>"+
								              "<td><a href='/register?campId="+value.id+"'>Register</a></td>";
								}          
											var markup = row.append(column);
											$("#displayTable").append(markup);

										})
							};

						$("#displayTable tr").slice(1).remove();
						
						var filterConfig = {

								url : URL + "location?loc=" + loc ,
								method : 'GET',
								success : function(resp){ displayCamps(resp);},
								failure : function(resp) {
									console.log(resp);
									alert("Failed!");
								}
							};

							$.ajax(filterConfig);		
					});
				
			});
</script>

<!-- Custom CSS -->
<link rel="stylesheet" href="css/style.css">

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
						id="currentPage">Blood-Donation Camps</a></li>
					<li class="nav-item"><a class="nav-link text-danger" href="#">Contact
							us</a></li>
				</ul>
			</div>
		</nav>
	</header>
</div>
	<div class="container-lg">
		<h2>Donation Camps</h2>
		<h5>Choose Filter for Camps:</h5>
		
		<form id="filterForm" class="form-inline justify-content-left mb-2">
			<div class="form-group pr-2">
				<label for="location" class="pr-1">Location of Camp:</label> 
					<select	name="location" id="location" class="form-control-sm">
						<option value="_" selected>Any location</option>
						<!-- Options will be added by AJAX Call -->
					</select> 
			</div>
			<button type="button" id="filterbtn" class="btn btn-info btn-sm">Filter</button>
		</form>
			<table class="table table-bordered mx-auto"
				id="displayTable">
				<tr class="thead-light">
					<th>Camp ID</th>
					<th>Camp Name</th>
					<th>Camp Date</th>
					<th>Location</th>
					<th>Register to Camp</th>
				</tr>
				<c:forEach items="${campsList}" var="eachCamp">
					<c:if test="${eachCamp.donationCampName ne 'UNREGISTERED'}">
						<tr class="camp">
							<td>${eachCamp.id}</td>
							<td><a href="/donors/?campId=${eachCamp.id}">${eachCamp.donationCampName}</a></td>
							<td>${eachCamp.campDate}</td>
							<td>${eachCamp.location}</td>
							<td><a href="/register?campId=${eachCamp.id}">Register</a></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
	</div>
</body>
</html>