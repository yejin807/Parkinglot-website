package com.example.parking.service;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.parking.model.EnterCar;
import com.example.parking.model.ParkingLot;
import com.example.parking.repository.EntercarRepository;
import com.example.parking.repository.ParkingLotRepository;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class EntercarService {

	private final EntercarRepository  carRepository;

	private final ParkingLotRepository pRepository;
	
	@Transactional
	public void save(EnterCar entercar) {
		carRepository.save(entercar);		
	}
	@Transactional
	public void parkingFeeset(Long parkid,EnterCar entercar) {
		EnterCar c= carRepository.findById(entercar.getCarNum()).get();
		ParkingLot p= pRepository.findById(parkid).get();
		
		if(c.getParkingType().equals("3")) {
			c.setParkingType("월주차");
			c.setFee(p.getMonthFee());
		}
		else if(c.getParkingType().equals("2")) {
			c.setParkingType("주주차");
			c.setFee(p.getDayFee()*7);
		}
		else if(c.getParkingType().equals("1")) {
			c.setParkingType("일주차");
			c.setFee(p.getDayFee());
		}
		else{
			c.setParkingType("자유주차");
			c.setFee(p.getBasicFee());
			p.setCurrentCnt(p.getCurrentCnt()-1);
		} 
	}
	
	
	public Page<EnterCar> findByParkingId(Long parkid,String word,Pageable pageable){
		if(word.equals("전체보기"))
			return carRepository.findByParkinglotId(parkid,pageable);		
			return carRepository.findByParkingType(parkid,word,pageable);
		
	}
	
	public Page<EnterCar> findSearch(Long parkid,String word,String field,Pageable pageable){
		if(word.equals("전체보기"))
			return carRepository.findByCarNum(parkid,field,pageable);
			return carRepository.bothSearch(parkid,word,field,pageable);		
	}
	
	public Long allcount(Long parkid,String word) {
		if(word.equals("전체보기"))
			return carRepository.allcount(parkid);
			return carRepository.cntParkingTypeSearch(parkid,word);	
	}
	
	public Long countSearch(Long parkid,String word,String field) {
		if(word.equals("전체보기")) {
			return carRepository.cntCarNumSearch(parkid,field);
		}
		if(word.isEmpty())
			return carRepository.cntCarNumSearch(parkid,field);
		return carRepository.cntbothSearch(parkid,word,field);	
	}
	
	@Transactional
	public void delete(String carNum,Long parkid) {
		ParkingLot p= pRepository.findById(parkid).get();
		p.setCurrentCnt(p.getCurrentCnt()+1);
		carRepository.deleteById(carNum);
	}
	public String carNumcheck(Long parkid, EnterCar entercar) {
		Long c = carRepository.carNumcheck(parkid,entercar.getCarNum());
		if(c==1) {
			return "fail"; 
		}
		return"success";
	}


}
