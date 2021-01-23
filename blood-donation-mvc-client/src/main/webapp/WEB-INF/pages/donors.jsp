<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>

<title>Blood Donors</title>

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
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous">
    </script>	
	
<script type="text/javascript">

$(document).ready(
	function(){		
		/* Initial AJAX Call to get locations */
		var config = {

				url : "http://localhost:2020/blood-donor-service/api/v1/donors/locations",
				method : 'GET',
				success : function(resp){ 

					var options = new String();
					$.each(resp, function(index, value){
						
							options+="<option value='"+value+"'>"+value+"</option>";
						
					});

					$("#location").append(options);

					},
				failure : function(resp) {
					console.log(resp);
					alert("Failed!");
				}
			};

			$.ajax(config);

		/* function to toggle filters display */
		$(".filter-container").hide();
		$("#filterToggle").click(function(){
   		 $(".filter-container").toggle(800,"swing");
		});
			
		/* function to display donor data obtained from filtering */
		function displayDonors(data){
			$.each(data, function(key,value){
				   var row =$('<tr class="donor"/>');
				  				  					   
				  var column ="<td>"+value.donorId+"</td>"+
				              "<td>"+value.donorName+"</td>"+
				              "<td>"+value.donorAge+"</td>"+
				              "<td>"+value.donorGender+"</td>"+
				              "<td>"+value.bloodGroup+"</td>"+
				              "<td>"+value.lastDonated+"</td>"+
				              "<td>"+value.location+"</td>"+
				              "<td>"+value.phoneNumber+"</td>"+
							  "<td>" + value.donationCampName + "</td>"+
							  "<td><a href='/updateDonor?id="+value.donorId+"'>Update</a></td>";

							if(value.donationCampName!="UNREGISTERED"){
								column+="<td><a href='/unregister?id="+value.donorId+"'>Unregister</a></td>"
								}	
							var markup = row.append(column);
							$("#displayTable").append(markup);

						})

					}

	/* AJAX Call to get filtered Donor data */			
	$("#filterbtn").click(function(){

				
			var URL = "http://localhost:2020/blood-donor-service/api/v1/donors/?";
			var filterDate = $("#filterDate").val();
			var location = $("#location").val();
			var bloodGroup = $("#bloodGroup").val();

			$("#displayTable tr").slice(1).remove();

			
			
						var config = {

							url : URL + "date=" + filterDate + "&bg="
									+ bloodGroup + "&loc=" + location,
							method : 'POST',
							success : function(resp){ displayDonors(resp);},
							failure : function(resp) {
								console.log(resp);
								alert("Failed!");
							}
						};

						$.ajax(config);
					});
	});	
</script>	

<!-- Custom CSS -->
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="container px-0">
        <header class="head my-0 ">
            <nav class="navbar  navbar-expand-xl navbar-light head__custom-nav py-0 px-0" style="background-color: #fff;">
                <a class="navbar-brand d-flex align-items-center" href="/">
                    <img src="assets/images/logo.png" alt="website logo">                    
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                    <span><img src="assets/images/menubutton.png" alt=""></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav mr-1">
                        <li class="nav-item">
                            <a class="nav-link" href="/">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">About Us</a>
                        </li>
                        <li class="nav-item" >
                            <a class="nav-link" href="/donors" id="currentPage">Blood-Donors</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/camps">Blood-Donation Camps</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-danger" href="#">Contact us</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
    </div>
	<div class="container-lg">
		<h2>Blood Donors</h2>
		<p id="filterToggle" style="text-decoration: underline; cursor: pointer; color: #007bff;">Filter results</p>
		<div class="filter-container">
			<h6>Choose filters for donors:</h6>
			
			<form id="filterForm" class="form-inline justify-content-left mb-2">
			<div class="form-group pr-2">
				<label for="filterDate" class="pr-1">Donation Eligibility on Date: </label> 
				<input type="date" class="form-control-sm" id="filterDate" name="filterDate" />
			</div>

			<div class="form-group pr-2">
				<label for="location" class="pr-1">Location: </label> 
				<select name="location"	class="form-control-sm" id="location">
					<option value="_" selected>Any City</option>
					<!-- Options will be added by AJAX Call -->
				</select>
			</div>

			<div class="form-group pr-2">
				<label for="bloodGroup" class="pr-1">Blood-Group: </label> <select
					name="bloodGroup" class="form-control-sm" id="bloodGroup">
					<option value="_" selected>Any Blood-Group</option>
					<option value="APOS">A-Positive</option>
					<option value="ANEG">A-Negative</option>
					<option value="BPOS">B-Positive</option>
					<option value="BNEG">B-Negative</option>
					<option value="ABPOS">AB-Positive</option>
					<option value="ABNEG">AB-Negative</option>
					<option value="OPOS">O-Positive</option>
					<option value="ONEG">O-Negative</option>
				</select>
			</div>
			<button type="button" id="filterbtn" class="btn btn-info btn-sm">Filter</button>

		</form>
		</div>

		<table class="table table-bordered table-responsive-md" id="displayTable">
			<tr class="thead-light">
				<th>Donor ID</th>
				<th>Name</th>
				<th>Age</th>
				<th>Gender</th>
				<th>Blood-Group</th>
				<th>Last Donated Date</th>
				<th>Donor Location</th>
				<th>Contact</th>
				<th>Donation Camp</th>
				<th>Update</th>
				<th title="Unregister option available on registering to a Donation Camp. Head to 'Blood-Donation Camps' to register to a camp of your choice">Unregister<span style="color:red;">*</span></th>
			</tr>
			<c:forEach items="${donorsList}" var="donor">
				<tr class="donor">
					<td>${donor.donorId}</td>
					<td>${donor.donorName}</td>
					<td>${donor.donorAge}</td>
					<td>${donor.donorGender}</td>
					<td>${donor.bloodGroup}</td>
					<td>${donor.lastDonated}</td>
					<td>${donor.location}</td>
					<td>${donor.phoneNumber}</td>
					<td>${donor.donationCampName}</td>					
					<td><a href="/updateDonor?id=${donor.donorId}">Update</a></td>
					<c:if test="${donor.donationCampName ne 'UNREGISTERED'}">
					<td><a href="/unregister?id=${donor.donorId}">Unregister</a></td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
		<p class="text-danger" style="font-size:0.85rem;">*Unregister option available on registering to a Donation Camp. Head to "Blood-Donation Camps" to register to a camp of your choice</p>
	</div>
	

</body>
</html>