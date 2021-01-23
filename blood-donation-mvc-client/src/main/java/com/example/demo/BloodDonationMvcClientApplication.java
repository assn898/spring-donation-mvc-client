package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.entity.BloodDonor;
import com.example.demo.entity.BloodDonorsList;
import com.example.demo.entity.DonationCamp;
import com.example.demo.entity.DonationCampList;


@SpringBootApplication
@EnableDiscoveryClient
@EnableCircuitBreaker
public class BloodDonationMvcClientApplication {

	public static void main(String[] args) {
		SpringApplication.run(BloodDonationMvcClientApplication.class, args);
	}
	
	@Bean
	@LoadBalanced
	public RestTemplate template() {
		return new RestTemplate();
	}
	
	@Bean 
	public ModelAndView modelAndView() {
		return new ModelAndView();
	}
	
	@Bean
	public BloodDonor bloodDonor() {
		return new BloodDonor();
	}
	
	@Bean
	public DonationCamp donationCamp() {
		return new DonationCamp();
	}
	
	@Bean 
	public BloodDonorsList bloodDonorList() {
		return new BloodDonorsList();
	}
	
	@Bean 
	public DonationCampList donationCampList() {
		return new DonationCampList();
	}
	

}
