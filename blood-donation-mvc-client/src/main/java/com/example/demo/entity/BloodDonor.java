package com.example.demo.entity;

import java.time.LocalDate;



import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;



@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BloodDonor {	
	
	private int donorId;
	private String donorName;
	
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate dateOfBirth;
	private int donorAge;
	private String donorGender;
	private String bloodGroup;
	private String location;
	private String phoneNumber;
	private String emailAddr;
	
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate lastDonated;
	private String donationCampName;

	@JsonIgnore
	private DonationCamp donationCamp;
	
	
}