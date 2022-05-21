package com.example.parking.controller;

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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.parking.model.Car;
import com.example.parking.model.ParkingLot;
import com.example.parking.repository.CarRepository;
import com.example.parking.repository.ParkingLotRepository;
import com.example.parking.service.CarService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/car/*")
public class CarController {
	@Autowired
	private CarService carService;
	
	private final CarRepository carRepository;
	
	private final ParkingLotRepository pRepository;
	
	

	@GetMapping("/insert/{parkid}")
	public String insert(@PathVariable Long parkid, Model model) {
		model.addAttribute("parkinglot", pRepository.findById(parkid));
		return "/car/insertCar";
	}
	
	@PostMapping("/insert")
	@ResponseBody
	public String insert(@RequestBody Car car) {
		//ParkingLot p = pRepository.findById(car.getParkingId()).get();
		carService.save(car);
		carService.parkingtypeset(car);
		return "success";
	}
	
	@GetMapping("/list")
	public String list(Model model,
			@PageableDefault(size = 5,sort = "intime",direction = Direction.DESC) Pageable pageable,
			@RequestParam(required = false,defaultValue = "")String field,
			@RequestParam(required = false,defaultValue = "")String word) {
		System.out.println("word : " + word);
		if(field.isEmpty()) {			
			Page<Car> cars = carService.findAll(word,pageable);
			Long count = carService.count(word);
			model.addAttribute("cars", cars);
			model.addAttribute("count", count);
			model.addAttribute("word", word);
		}else {
			Page<Car> cars = carService.findSearch(word,field,pageable);
			Long count = carService.countSearch(word,field);
			model.addAttribute("cars", cars);
			model.addAttribute("count", count);
			model.addAttribute("word", word);
		}
		return "/car/listCar";
		
	}
	
	@DeleteMapping("delete/{carNum}")
	@ResponseBody
	public String delete(@PathVariable String carNum) {
		carService.delete(carNum);
		return "success";
	}
	
	@GetMapping("view/{carNum}")
	public String view(@PathVariable String carNum,Model model) {
		model.addAttribute("car", carService.view(carNum));
		return "/car/viewCar";
		
	}
	
	@PutMapping("update/{carNum}")
	@ResponseBody
	public String update(@PathVariable String carNum,@RequestBody Car car) {
		System.out.println(car.getCarName());
		carService.update(carNum,car);
		carService.parkingtypeset(car);
		return carNum;
	}
	
	@GetMapping("search")
	public String search(@RequestBody C)
	
}
