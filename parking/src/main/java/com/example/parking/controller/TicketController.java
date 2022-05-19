package com.example.parking.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.parking.model.Ticket;
import com.example.parking.repository.ParkingLotRepository;
import com.example.parking.service.TicketService;

@Controller
@RequestMapping("/ticket/*")
public class TicketController {
	@Autowired
	private TicketService tService;
	
	@Autowired
	private ParkingLotRepository pRepository;
	
	//정기권판매폼
	@GetMapping("insert/{id}")
	public String insert(@PathVariable Long id, Model model) {
		model.addAttribute("parkinglot", pRepository.findById(id).get());
		model.addAttribute("ticket",tService.findByParkinglotId(id));
		return "/ticket/insert";
	}
	
	//정기권판매등록
	@PostMapping("insert")
	public String insert(Long parkinglotId, Ticket ticket) {
		
		ticket.setParkLot(pRepository.findById(parkinglotId).get());
		tService.insert(ticket);
				
		return "redirect:/parkinglot/list";
	}
	
	
	//전체주차장 재고리스트(사장님)
	@GetMapping("list/{id}")
	public String list(@PathVariable Long id, Model model) {
		model.addAttribute("ticketlist", tService.findByParkinglotId(id));
		return "/ticket/list";
	}
	
	//정기권 재고현황(전체)
	@GetMapping("list")
	public String list(Model model) {
		model.addAttribute("ticketlist", tService.list());
		return "/ticket/list";
	}

}
