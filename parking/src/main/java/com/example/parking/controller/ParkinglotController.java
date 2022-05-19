package com.example.parking.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.parking.model.ParkingLot;
import com.example.parking.service.ParkingLotService;

@RequestMapping("/parkinglot/*")
@Controller
public class ParkinglotController {
	
	@Autowired
	private ParkingLotService pService;
	
	//주차장등록폼(사장님)
	@GetMapping("insert")
	public String insert() {
		return "/parkinglot/insert";
	}
	
	//주차장등록(사장님)
	@PostMapping("insert")
	public String insert(ParkingLot parkinglot, HttpSession session) {
		
		//String uploadFolder = session.getServletContext().getRealPath("/")+"\\resources\\img";
		String uploadFolder = session.getServletContext().getRealPath("/");
		pService.insert(parkinglot, uploadFolder);
		return "redirect:/parkinglot/list";
	}
	
	//주차장리스트(사장님)
	@GetMapping("list")
	public String list(Model model) {
		model.addAttribute("parkinglotlist", pService.list());
		return "/parkinglot/list";
	}
	
	//주차장상세보기(사장님)
	@GetMapping("view/{id}")
	public String view(@PathVariable Long id, Model model) {
		model.addAttribute("parkinglot", pService.view(id));
		return "/parkinglot/view";
	}
	
	//주차장수정폼(사장님)
	@GetMapping("update/{id}")
	public String update(@PathVariable Long id, Model model) {
		model.addAttribute("parkinglot", pService.view(id));
		return "/parkinglot/update";
	}
	
	//주차장수정하기(사장님)
	@PostMapping("update")
	public String update(ParkingLot parkinglot, HttpSession session) {
		//String uploadFolder = session.getServletContext().getRealPath("/")+"\\resources\\img";
		String uploadFolder = session.getServletContext().getRealPath("/");
		pService.update(parkinglot, uploadFolder);
		return "redirect:/parkinglot/list";
	}
	
	
	//주차장삭제하기(사장님)
	@DeleteMapping("delete/{id}")
	@ResponseBody
	public String delete(@PathVariable Long id) {
		pService.delete(id);
		return "success";
	}
}
