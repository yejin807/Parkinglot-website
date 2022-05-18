package com.example.parking.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.parking.model.ParkingLot;
import com.example.parking.service.ParkingLotService;

@RequestMapping("/parkinglot/*")
@Controller
public class ParkinglotController {
	
	@Autowired
	private ParkingLotService pService;
	
	//주차장등록폼
	@GetMapping("insert")
	public String insert() {
		return "/parkinglot/insert";
	}
	
	//주차장등록
	@PostMapping("insert")
	public void insert(ParkingLot parkinglot, HttpSession session) {
		
		//String uploadFolder = session.getServletContext().getRealPath("/")+"\\resources\\img";
		String uploadFolder = session.getServletContext().getRealPath("/");
		pService.insert(parkinglot, uploadFolder);
	}
	
	//주차장리스트(사장님용)
	@GetMapping("list")
	public String list(Model model) {
		model.addAttribute("parkinglotlist", pService.list());
		return "/parkinglot/list";
	}
	

}
