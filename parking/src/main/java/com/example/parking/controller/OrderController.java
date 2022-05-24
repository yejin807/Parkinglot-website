package com.example.parking.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.parking.config.auth.PrincipalDetails;
import com.example.parking.model.OrderTicket;
import com.example.parking.repository.CarRepository;
import com.example.parking.service.OrderTicketService;
import com.example.parking.service.TicketService;

@Controller
@RequestMapping("/orderticket/*")
public class OrderController {
	
	@Autowired
	private OrderTicketService oService;
	
	@Autowired
	private TicketService tService;
	
	@Autowired
	private CarRepository carRepository;

	//정기권 구매
	@GetMapping("buy/{id}")
	public String insert(@PathVariable Long id, @AuthenticationPrincipal PrincipalDetails principal, Model model) {
		if(principal==null) return "redirect:/register/login";
		model.addAttribute("carlist", carRepository.findByUsername(principal.getUsername()));
		model.addAttribute("ticket", tService.findByParkinglotId(id));
		return "/orderticket/buy";
	}
	
	@PostMapping("buy")
	public String insert(@AuthenticationPrincipal PrincipalDetails principal, OrderTicket orderticket) {
		if(principal==null) return "redirect:/register/login";
		if(oService.findTicket(orderticket)==0) {
			oService.insert(orderticket);
		}
		return "redirect:/orderticket/list";
	}
	
	//티켓구매리스트(일반)
	@GetMapping("list")
	public String list(@AuthenticationPrincipal PrincipalDetails principal, Model model) {
		if(principal==null) return "redirect:/register/login";
		model.addAttribute("orderTicketList", oService.list(principal.getUsername()));
		return "/orderticket/list";
	}
	
	//티켓구매리스트(전체)
	@GetMapping("listAll")
	public String listAll(Model model) {
		model.addAttribute("orderTicketList", oService.listAll());
		return "/orderticket/listAll";
	}
	
	//티켓구매정보수정폼
	@GetMapping("update/{ticketId}")
	public String update(@PathVariable Long ticketId, Model model) {
		model.addAttribute("orderticket", oService.findById(ticketId));
		return "/orderticket/update";
	}
	
	//티켓구매정보수정
	@PostMapping("update")
	public String update(OrderTicket orderticket) {
		oService.update(orderticket);
		return "redirect:/orderticket/listAll";
	}
	
	//삭제하기
	@GetMapping("delete/{ticketId}")
	public String delete(@PathVariable Long ticketId) {
		oService.delete(ticketId);
		return "redirect:/orderticket/listAll";
	}
}
