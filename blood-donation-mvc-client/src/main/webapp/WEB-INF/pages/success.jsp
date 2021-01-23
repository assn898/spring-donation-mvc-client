<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<link rel="shortcut icon" href="assets/favicon.ico" type="image/x-icon">
<link rel="icon" href="assets/favicon.ico" type="image/x-icon">

<title>You are a DONor!</title>
<meta http-equiv="refresh" content="15;url=/camps"/>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/style.css">

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
$(document).ready(function(){

	var counter = 15;
	$(".donorDetails").css("font-weight","700");	
	$("#countdown").html("15");
	$("#countdown").css("color","green");
	var interval = setInterval(function() {
	    counter--;
	    $("#countdown").html(counter);
	    if (counter < 6){
	    	$("#countdown").css("color","red");		
		}
	    if (counter == 1) {
	        clearInterval(interval);
	    }
	}, 1000);
	
});

</script>
</head>
<body>
	<div class="container">
		<div class="row custom-section d-flex align-items-center py-0 mx-0">
			<div class="col-12 col-lg-7">
				<div class="row">
					<div class="col-12">
						<h5>New Donor Details:</h5>
						<p>Donor ID: <span class="donorDetails">${added.donorId}</span></p>
						<p>Donor Name: <span class="donorDetails">${added.donorName}</span></p>
						<p>Date Of Birth: <span class="donorDetails">${added.dateOfBirth}</span></p>
						<p>Gender: <span class="donorDetails">${added.donorGender}</span></p>
						<p>Blood-Group: <span class="donorDetails">${added.bloodGroup}</span></p>
						<p>Location: <span class="donorDetails">${added.location}</span></p>
						<p>Phone Number: <span class="donorDetails">${added.phoneNumber}</span></p>
						<p>Email Address: <span class="donorDetails">${added.emailAddr}</span></p>
						<p>Date of Last Donation (approx.): <span class="donorDetails">${added.lastDonated}</span></p>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<h4>Congratulations! You're one step closer to saving a life.</h4>
						<p>You will be redirected to our Donation Camps page in <span id="countdown" style="font-weight: 600; font-size: 1.3rem;"></span> seconds.</p>
						<p>If you want to update any changes to your details, <a href="/updateDonor?id=${added.donorId}">Click here!</a></p>
						<p>If you do not want to wait, visit our <a href="/camps">Donation Camps</a> page to register to a camp.</p>
						<p>If you want to check the list of blood-donors, visit our <a href="/donors">Blood-Donors</a> page.</p>
						<p>Or you can choose to register to a camp later, and go back <a href="/">Home</a></p>
					</div>
				</div>
			</div>
			<div class="col-12 col-lg-5">
				<img src="assets/images/blood-donor-nurse.jpg" style="object-fit:cover;" alt="You are now a donor!" class="img-fluid">
			</div>
		</div>
	</div>
</body>
</html>