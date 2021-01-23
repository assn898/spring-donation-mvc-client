package com.example.demo.controllers;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.entity.BloodDonor;
import com.example.demo.entity.BloodDonorsList;
import com.example.demo.entity.DonationCamp;
import com.example.demo.entity.DonationCampList;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;


@Controller
@CrossOrigin(origins = "*")
public class ClientController {

	@Autowired
	private RestTemplate template;
	@Autowired
	private ModelAndView mdlView;
	@Autowired
	private BloodDonor bloodDonor;
	@Autowired
	private DonationCamp donationCamp;
	@Autowired
	private BloodDonorsList bloodDonorsList;
	@Autowired
	private DonationCampList donationCampList;
	
	private BloodDonor dummyDonor = new BloodDonor(0, "UNKNOWN", LocalDate.now(), 0 , "X", "UNKNOWN", "UNKNOWN" ,"UNKNOWN", "UNKNOWN", LocalDate.now(), "UNKNOWN", donationCamp);
	
	private final String donorBaseURL="http://API-GATEWAY/blood-donor-service/api/v1/donors";
	private final String campBaseURL="http://API-GATEWAY/donation-camp-service/api/v1/camps";
	
	@GetMapping(path = "/donors")
	@HystrixCommand(fallbackMethod = "getFallbackDonors")
	public ModelAndView donorsPage() {
		this.bloodDonorsList = this.template.getForObject(donorBaseURL+"/", BloodDonorsList.class);
		List<BloodDonor> donorsList = new ArrayList<>();
		donorsList = bloodDonorsList.getDonorsList();
		mdlView.setViewName("donors");
		mdlView.addObject("donorsList", donorsList);
		return mdlView;
	}
	
	public ModelAndView getFallbackDonors() {
		List<BloodDonor> donorsList = new ArrayList<>();
		donorsList.add(dummyDonor);
		mdlView.setViewName("donors");
		mdlView.addObject("donorsList", donorsList);
		return mdlView;
	}
	
	@GetMapping(path = "/newDonor")
	public ModelAndView addDonor() {
		mdlView.setViewName("addDonor");
		mdlView.addObject("newDonorObject", bloodDonor);
		return mdlView;
	}
	
	@GetMapping(path = "/updateDonor")
	@HystrixCommand(fallbackMethod = "getFallbackDonors")
	public ModelAndView updateDonor(@RequestParam(name = "id") int id) {
		mdlView.setViewName("updateDonor");
		this.bloodDonor = this.template.getForObject(donorBaseURL+"?id="+Integer.toString(id), BloodDonor.class);
		mdlView.addObject("updateDonorObject", bloodDonor);
		return mdlView;
	}
	
	@GetMapping(path = "/unregister")
	public String unregisterDonor(@RequestParam(name = "id") int id) {
		this.bloodDonor= this.template.getForObject(donorBaseURL+"?id="+Integer.toString(id), BloodDonor.class);
		bloodDonor.setDonationCampName("UNREGISTERED");
		this.template.put(donorBaseURL+"/updateDonor?donorId="+Integer.toString(bloodDonor.getDonorId()), bloodDonor);
		return "redirect:/donors";
	}
	
	@GetMapping(path = "/camps")
	public ModelAndView campsPage() {
		this.donationCampList = this.template.getForObject(campBaseURL+"/", DonationCampList.class);
		List<DonationCamp> campsList = new ArrayList<>();
		campsList = donationCampList.getCampsList();
		mdlView.setViewName("camps");
		mdlView.addObject("campsList", campsList);
		return mdlView;
	}
	
	@GetMapping(path = "/donors/")
	public ModelAndView donorsOfCampPage(@RequestParam(name = "campId") int id) {
		this.bloodDonorsList = this.template.getForObject(donorBaseURL+"/camps?campId="+id, BloodDonorsList.class);
		this.donationCamp = this.template.getForObject(campBaseURL+"?campId="+id, DonationCamp.class);
		List<BloodDonor> donorsList = bloodDonorsList.getDonorsList();
		mdlView.setViewName("donorsOfCamp");
		
		if(donorsList.isEmpty()) {
			mdlView.addObject("donorsOfCampList", null);
		}else {
			mdlView.addObject("donorsOfCampList", donorsList);
		}		
		mdlView.addObject("campDetails", donationCamp);
		return mdlView;
	}
	
	@GetMapping(path = "/register")
	public ModelAndView campRegistration(@RequestParam(name = "campId") int id) {
		this.donationCamp = this.template.getForObject(campBaseURL+"?campId="+id, DonationCamp.class);
		mdlView.setViewName("campRegister");
		mdlView.addObject("campDetails", donationCamp);
		mdlView.addObject("registerUpdateObject", bloodDonor);
		return mdlView;
	}
	
	@PostMapping(path = "/submitNewDonor")
	public ModelAndView submitDonor(@ModelAttribute("newDonorObject") BloodDonor newDonor) {
		this.bloodDonor = this.template.postForObject(donorBaseURL+"/newDonor", newDonor, BloodDonor.class);
		mdlView.setViewName("success");
		mdlView.addObject("added", bloodDonor);
		return mdlView;
	}
	
	
	@PostMapping(path = "/submitUpdate")
	public String submitUpdateDonor(@ModelAttribute("updateDonorObject") BloodDonor updateDonor) {
		this.template.put(donorBaseURL+"/updateDonor?donorId="+Integer.toString(updateDonor.getDonorId()), updateDonor);
		return "redirect:/donors";
	}
	
	@PostMapping(path ="/registerUpdate")
	public String registerUpdateDonor(@ModelAttribute("registerUpdateObject") BloodDonor registerDonor) {
		this.template.put(donorBaseURL+"/updateDonor?donorId="+Integer.toString(registerDonor.getDonorId()), registerDonor);
		return "redirect:/donors";
	}
	
	
	
	
}
