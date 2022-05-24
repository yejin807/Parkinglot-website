package com.example.parking.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.parking.config.auth.PrincipalDetails;
import com.example.parking.model.ParkingLot;
import com.example.parking.service.ParkingLotService;

@RequestMapping("/parkinglot/*")
@Controller
public class ParkinglotController {

    @Autowired
    private ParkingLotService pService;
    
    // 주차장등록폼(사장님)
    @GetMapping("insert")
    public String insert() {
        return "/parkinglot/insert";
    }

    // 주차장등록(사장님)
    @PostMapping("insert")
    public String insert(ParkingLot parkinglot, HttpSession session) {

        //String uploadFolder = session.getServletContext().getRealPath("/") + "\\resources\\img";
        String uploadFolder = session.getServletContext().getRealPath("/");
        pService.insert(parkinglot, uploadFolder);
        return "redirect:/parkinglot/list";
    }

    // 주차장리스트(사장님)
    @GetMapping("list")
    public String list(@AuthenticationPrincipal PrincipalDetails principal, Model model) {
    	if(principal==null) return "redirect:/register/login";
    	//주차장 주차가능면수 업데이트
    	pService.currentCntUpdate();
    	
        model.addAttribute("parkinglotlist", pService.list(principal.getUsername()));
        return "/parkinglot/list";
    }
    
    // 주차장리스트(전체)
    @GetMapping("listAll")
    public String list(Model model) {
    	//주차장 주차가능면수 업데이트
    	pService.currentCntUpdate();
    	
        model.addAttribute("parkinglotlist", pService.listAll());
        return "/parkinglot/listAll";
    }

    // 주차장상세보기
    @GetMapping("view/{parkinglotId}")
    public String view(@PathVariable Long parkinglotId, Model model) {    	
        model.addAttribute("parkinglot", pService.view(parkinglotId));
        return "/parkinglot/view";
    }

    // 주차장수정폼(사장님)
    @GetMapping("update/{parkinglotId}")
    public String update(@PathVariable Long parkinglotId, Model model) {
        model.addAttribute("parkinglot", pService.view(parkinglotId));
        return "/parkinglot/update";
    }

    // 주차장수정하기(사장님)
    @PostMapping("update")
    public String update(ParkingLot parkinglot, HttpSession session) {
        //String uploadFolder = session.getServletContext().getRealPath("/")+"\\resources\\img";
        String uploadFolder = session.getServletContext().getRealPath("/");
        pService.update(parkinglot, uploadFolder);
        return "redirect:/parkinglot/list";
    }
}
