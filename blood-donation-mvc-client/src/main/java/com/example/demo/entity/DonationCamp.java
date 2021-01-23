package com.example.demo.entity;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DonationCamp {

	private int id;	
	private String donationCampName;
	private String location;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate campDate;
	

}
