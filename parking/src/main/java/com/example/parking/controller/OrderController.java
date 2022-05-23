package com.example.parking.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.parking.model.OrderTicket;
import com.example.parking.service.OrderTicketService;

@Controller
@RequestMapping("/orderticket/*")
public class OrderController {
	
	@Autowired
	private OrderTicketService oService;

	//정기권 구매
	@GetMapping("buy/{id}")
	public String insert(@PathVariable Long id, Model model) {		
		model.addAttribute("ticket", oService.findByParkinglotId(id));
		return "/orderticket/buy";
	}
	
	@PostMapping("buy")
	public String insert(OrderTicket orderticket) {	
		oService.insert(orderticket);
		return "redirect:/orderticket/list/";
	}
	
	//티켓구매리스트(일반)
	@GetMapping("list")
	public String list(HttpSession session, Model model) {
		//String username = session.getId()
		model.addAttribute("orderTicketList", oService.list("1"));
		return "/orderticket/list";
	}
	
	//티켓구매리스트(전체)
	@GetMapping("listAll")
	public String list(Model model) {
		model.addAttribute("orderTicketList", oService.list());
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
	
	//삭제히가
	@GetMapping("delete/{ticketId}")
	public String delete(@PathVariable Long ticketId) {
		oService.delete(ticketId);
		return "redirect:/orderticket/listAll";
	}
}
