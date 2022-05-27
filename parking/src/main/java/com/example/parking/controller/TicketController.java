package com.example.parking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.parking.config.auth.PrincipalDetails;
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

    // 정기권판매폼
    @PreAuthorize("hasRole('ROLE_OWNER') || hasRole('ROLE_ADMIN')")
    @GetMapping("sell/{id}")
    public String insert(@PathVariable Long id, Model model) {
        model.addAttribute("parkinglot", pRepository.findById(id).get());
        model.addAttribute("ticket", tService.findByParkinglotId(id));
        return "/ticket/sell";
    }

    // 정기권판매등록
    @PreAuthorize("hasRole('ROLE_OWNER') || hasRole('ROLE_ADMIN')")
    @PostMapping("sell")
    public String insert(@AuthenticationPrincipal PrincipalDetails principal, Long parkinglotId, Ticket ticket) {

        ticket.setParkLot(pRepository.findById(parkinglotId).get());
        tService.insert(ticket);
        if (principal.getMember().getRole().equals("ROLE_ADMIN")) {
            return "redirect:/ticket/listAll";
        }
        return "redirect:/parkinglot/list";
    }

    // 전체주차장 재고리스트(사장님)
    @PreAuthorize("hasRole('ROLE_OWNER')")
    @GetMapping("list")
    public String list(@AuthenticationPrincipal PrincipalDetails principal, Model model) {
        model.addAttribute("ticketlist", tService.list(principal.getUsername()));
        if (principal.getMember().getRole().equals("ROLE_ADMIN")) {
            return "redirect:/ticket/listAll";
        }
        return "/ticket/list";
    }

    // 정기권 재고현황(전체)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping("listAll")
    public String list(Model model) {
        model.addAttribute("ticketlist", tService.listAll());
        return "/ticket/listAll";
    }

}
