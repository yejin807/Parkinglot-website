package com.example.parking.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.parking.model.EnterCar;
import com.example.parking.model.OrderTicket;
import com.example.parking.model.ParkingLot;
import com.example.parking.repository.EntercarRepository;
import com.example.parking.repository.OrderTicketRepository;
import com.example.parking.repository.ParkingLotRepository;
import com.example.parking.service.EntercarService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/car/*")
public class EntercarController {
	@Autowired
	private EntercarService carService;
	
	private final ParkingLotRepository pRepository;
	private final OrderTicketRepository oRepository;
	
	

	@GetMapping("/insert/{parkid}")
	public String insert(@PathVariable Long parkid, Model model) {
		model.addAttribute("parkinglot", pRepository.findById(parkid).get());
		return "/car/insertCar";
	}
	
	@PostMapping("/insert/{parkid}")
	@ResponseBody
	public String insert(@PathVariable Long parkid,@RequestBody EnterCar entercar) {
		//ParkingLot p = pRepository.findById(car.getParkingId()).get();
		carService.save(entercar);
		carService.parkingFeeset(parkid,entercar);
		return "success";
	}
	
	@GetMapping("/list/{parkid}")
	public String list(Model model,@PathVariable Long parkid,
			@PageableDefault(size = 5,sort = "intime",direction = Direction.DESC) Pageable pageable,
			@RequestParam(required = false,defaultValue = "")String field,
			@RequestParam(required = false,defaultValue = "")String word) {
		System.out.println("word : " + word);
			
			Page<EnterCar> cars = carService.findAll(word,pageable);
			Long count = carService.count(word);
			model.addAttribute("cars", cars);
			model.addAttribute("count", count);
			model.addAttribute("word", word);
			model.addAttribute("parkinglot", pRepository.findById(parkid).get());

		return "/car/listCar";
		
	}
	
	@GetMapping("/listfield")
	public String listfield(Model model,
			@PageableDefault(size = 5,sort = "intime",direction = Direction.DESC) Pageable pageable,
			@RequestParam(required = false,defaultValue = "")String field,
			@RequestParam(required = false,defaultValue = "")String word,
			@RequestParam(required = false,defaultValue = "")Long parkid) {
		System.out.println("word : " + word);
		System.out.println("field : " + field);
		System.out.println("parkid : " + parkid);
			Page<EnterCar> cars = carService.findSearch(word,field,pageable);
			Long count = carService.countSearch(word,field);
			model.addAttribute("cars", cars);
			model.addAttribute("count", count);
			model.addAttribute("word", word);
			model.addAttribute("parkinglot", pRepository.findById(parkid).get());
			
		
		return "/car/listCar";
		
	}
	
	@DeleteMapping("delete/{carNum}/{parkid}")
	@ResponseBody
	public String delete(@PathVariable String carNum,@PathVariable Long parkid) {
		carService.delete(carNum,parkid);
		return "success";
	}
	
	
	@GetMapping("ticketendcheck/{carNum}/{parkid}")
	public String ticketendcheck(@PathVariable String carNum,@PathVariable Long parkid,Model model) {
	
		model.addAttribute("ticket",oRepository.findByParkinglotIdAndCarNum(parkid,carNum));
		return "/car/listCar";
		
	}

	@PostMapping("ticketcheck/{parkid}/{carNum}")
	@ResponseBody
	public String ticketcheck(@PathVariable String carNum,@PathVariable Long parkid,Model model) {
		OrderTicket oTicket = oRepository.findByParkinglotIdAndCarNum(parkid,carNum);
		if(oTicket==null){
			return "1";
		}else{
			model.addAttribute("ticket",oRepository.findByParkinglotIdAndCarNum(parkid,carNum));
			return "2";
		}		
	}
	
}
