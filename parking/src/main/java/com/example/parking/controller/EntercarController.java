package com.example.parking.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
    public String insert(@PathVariable Long parkid, @RequestBody EnterCar entercar) {
  
    	   carService.save(entercar);
    	   carService.parkingFeeset(parkid, entercar);
    	   return "success";

    }

    //주차 타입만 있을 때 
    @GetMapping("/list/{parkid}")
    public String list(Model model, @PathVariable Long parkid,
            @PageableDefault(size = 5, sort = "intime", direction = Direction.DESC) Pageable pageable,
            @RequestParam(required = false, defaultValue = "") String field,
            @RequestParam(required = false, defaultValue = "") String word) {
        System.out.println("word : " + word);

        Page<EnterCar> cars = carService.findByParkingId(parkid,word, pageable);
        Long count = carService.allcount(parkid,word);
        model.addAttribute("cars", cars);
        model.addAttribute("count", count);
        model.addAttribute("word", word);
        model.addAttribute("parkinglot", pRepository.findById(parkid).get());

        return "/car/listCar";

    }

    //차번호 검색도 있을 때
    @GetMapping("/listfield")
    public String listfield(Model model,
            @PageableDefault(size = 5, sort = "intime", direction = Direction.DESC) Pageable pageable,
            @RequestParam(required = false, defaultValue = "") String field,
            @RequestParam(required = false, defaultValue = "") String word,
            @RequestParam(required = false, defaultValue = "") Long parkid) {
        System.out.println("word : " + word);
        System.out.println("field : " + field);
        System.out.println("parkid : " + parkid);
        Page<EnterCar> cars = carService.findSearch(parkid,word, field, pageable);
        Long count = carService.countSearch(parkid,word, field);
        model.addAttribute("cars", cars);
        model.addAttribute("count", count);
        model.addAttribute("word", word);
        model.addAttribute("parkinglot", pRepository.findById(parkid).get());

        return "/car/listCar";

    }

    @DeleteMapping("delete/{carNum}/{parkid}")
    @ResponseBody
    public String delete(@PathVariable String carNum, @PathVariable Long parkid) {
        carService.delete(carNum, parkid);
        return "success";
    }

    @GetMapping("ticketendcheck/{carNum}/{parkid}")
    @ResponseBody
    public String ticketendcheck(@PathVariable String carNum, @PathVariable Long parkid, Model model) {

        	 List<OrderTicket> oTicket = oRepository.findByParkinglotIdAndCarNum(parkid, carNum);
          	
    	     SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	     Date now = new Date();
    	     String date = dateFormat.format(now);
    	     String day = null;
    	     
        	 if (oTicket.isEmpty()) {
        		 
                 return "non";
             } else {
             	for(OrderTicket orderTicket :oTicket) {
                 	Date enddate = orderTicket.getEndDate();
                 	Date startdate = orderTicket.getBuyDate();
                 	Date today = null;
     				try {
     					today = dateFormat.parse(date);
     				} catch (ParseException e) {
     					e.printStackTrace();
     				}
                 	 
                 	//compareTo메서드를 통한 날짜비교
                 	int endcompare = enddate.compareTo(today); 
                 	int startcompare = startdate.compareTo(today); 
                 	//조건문
                 	if(endcompare >= 0 && startcompare <= 0) {
                 		Date check = orderTicket.getEndDate();
                 		System.out.println(check);
                 		day = dateFormat.format(check);
                 		System.out.println(day);
                 	}
             	}
             	System.out.println(day);
             	return day;
             }
    }

    @PostMapping("ticketcheck/{parkid}/{carNum}")
    @ResponseBody
    public int ticketcheck(@PathVariable String carNum, @PathVariable Long parkid, Model model) {
    	
    	String checking = carService.carNumcheck(parkid,carNum);
    	
    	 
    	 if(checking.equals("fail")) {
      	   return -1;
         }
         else {
        	 List<OrderTicket> oTicket = oRepository.findByParkinglotIdAndCarNum(parkid, carNum);
          	
        	 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
         	Date now = new Date();
         	String date = dateFormat.format(now);
         	int check=0;
    	     
         	if (oTicket == null) {
                return 0;
            }else {
            	for(OrderTicket orderTicket :oTicket) {
            		//비교할 date와 today를데이터 포맷으로 변경
                	Date enddate = orderTicket.getEndDate();
                	Date startdate = orderTicket.getBuyDate();
                	Date today = null;
    				try {
    					today = dateFormat.parse(date);
    				} catch (ParseException e) {
    					e.printStackTrace();
    				}
                	 
                	//compareTo메서드를 통한 날짜비교
                	int endcompare = enddate.compareTo(today); 
                	int startcompare = startdate.compareTo(today); 
                	System.out.println("end:"+endcompare);
                	System.out.println("start:"+startcompare);
                	//조건문
                	if(endcompare >= 0 && startcompare <= 0) {
                	  check = orderTicket.getTicketType();
                	  break;
                	}else if(endcompare < 0 || startcompare > 0) {
                		check = 5;
                		
                	}else {
                		check = 4;
                		
                	}
            
            	}
            }
         	return check;
         }
    }
}
