<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springform"%>    
<!DOCTYPE html>
<html>
<head>
<title>Register - <c:out value="${campDetails.donationCampName}"></c:out> </title>

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

				$("#donationCampName").val("${campDetails.donationCampName}");
				$("#donationCampName").attr("readonly","readonly");	
				
				/* AJAX Call to get the Donor for registration */
				$("#findBtn").click(function(){
				var id = $("#inputDonorId").val();
				var config = {

						url : "http://localhost:2020/blood-donor-service/api/v1/donors?id="+id,
						method : 'GET',
						success : function(resp){ 	
							console.log(resp);
							$("#donorId").val(resp.donorId);
							$("#donorName").val(resp.donorName);
							$("#dateOfBirth").val(resp.dateOfBirth);
							$("#donorAge").val(resp.donorAge);
							$("#donorGender").val(resp.donorGender);
							$("#bloodGroup").val(resp.bloodGroup);
							$("#location").val(resp.location);
							$("#phoneNumber").val(resp.phoneNumber);
							$("#emailAddr").val(resp.emailAddr);
							$("#lastDonated").val(resp.lastDonated);					
							$("#registerBtn").attr("disabled","disabled");
							$("#registerBtn").css("cursor","not-allowed");
							
							var lastDonatedVal = $("#lastDonated").val();
							var lastDonatedDate = new Date(lastDonatedVal);
							var campDateVal = "${campDetails.campDate}";
							var campDate = new Date(campDateVal);
							var sixMonthDifference = Math.floor((campDate - lastDonatedDate) / (15778800000));
							console.log(sixMonthDifference);
							if(sixMonthDifference >= 1){
								$("#result").text("You are eligible to register!");
								$("#registerBtn").removeAttr("disabled");
								$("#registerBtn").css("cursor","pointer");
								$("#result").css("color","green");								
								}else {
								var message = "Cannot register as it won't be six months since last donation! ";
								message += "Click <a href='/camps'>here</a> to register to another camp";	
								$("#result").html(message);
								$("#result").css("color","red");								
								}							
							},
						failure : function(resp) {
							console.log(resp);
							alert("Failed!");
						}
					}

					$.ajax(config);

					
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

<div class="container">
	<div class="container">
		<h2>Camp Registration - ${campDetails.donationCampName}</h2>
		<form id="findDonorForm" class="form-inline justify-content-left mb-2">
			<div class="form-group pr-2">
				<label for="" class="pr-1">Provide the Donor ID for Registration: </label>
				<input type="text" id="inputDonorId" class="form-control-sm"/>
			</div>
			<button type="button" id="findBtn" class="btn btn-info btn-sm">Find Donor</button>
		</form>
	</div>
	
	
	<springform:form action="registerUpdate" method="POST" modelAttribute="registerUpdateObject">
		<div style="display:none;">
			<label for="">Donor ID</label>			
			<springform:input path="donorId" type="text" id="donorId"/>
		
			<label for="">Donor Name</label>
			<springform:input path="donorName" type="text" id="donorName"/>
		
			<label for="">Date of Birth</label>
			<springform:input path="dateOfBirth" type="date" id="dateOfBirth" />
		
			<label for="">Age</label>
			<springform:input path="donorAge" id="donorAge"/>
		
			<label for="">Gender</label>
			<springform:select path="donorGender" id="donorGender">
				<option value="Male" selected>Male</option>
				<option value="Female">Female</option>
				<option value="X">Others</option>
			</springform:select> 
		
			<label for="">Blood-Group</label>
			<springform:select path="bloodGroup" id="bloodGroup">
				<option value="APOS" selected>A-Positive</option>
				<option value="ANEG">A-Negative</option>
				<option value="BPOS">B-Positive</option>
				<option value="BNEG">B-Negative</option>
				<option value="ABPOS">AB-Positive</option>
				<option value="ABNEG">AB-Negative</option>
				<option value="OPOS">O-Positive</option>
				<option value="ONEG">O-Negative</option>
			</springform:select> 
		
			<label for="">Location</label>
			<springform:input path="location" type="text" id="location"/>
		
			<label for="">Phone Number</label>
			<springform:input path="phoneNumber" type="text" id="phoneNumber"/>
		
			<label for="">Email Address</label>
			<springform:input path="emailAddr" type="text" id="emailAddr"/>
		
			<label for="">Approx. Date of Last Donation</label>
			<springform:input path="lastDonated" type="date" id="lastDonated"/>
		</div>
		<div class="newFormSection">
			<div class="newForm row">
				<div class="form-field col-lg-12">
					<springform:input path="donationCampName" class="input-text" type="text" id="donationCampName" />
					<label for="donationCampName" class="label">Donation Camp </label>
				</div>
				<div class="col-lg-12 my-0 ">
					<p id="result" class="mx-auto"></p>
				</div>
				<div class="form-field col-lg-12"> 
					
					<input class="submit-btn mx-auto" type="submit" id="registerBtn" value="Register" />
				</div>
			</div>
		</div>
	</springform:form>
</div>
</body>
</html>