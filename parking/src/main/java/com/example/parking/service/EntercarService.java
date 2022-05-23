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
	
	
	public Page<EnterCar> findAll(String word,Pageable pageable){
		if(word.equals("전체보기"))
			return carRepository.findAll(pageable);		
			return carRepository.findByParkingTypeContaining(word,pageable);
		
	}
	
	public Page<EnterCar> findSearch(String word,String field,Pageable pageable){
		if(word.equals("전체보기"))
			return carRepository.findByCarNumContaining(field,pageable);
			return carRepository.bothSearch(word,field,pageable);		
	}
	
	public Long count(String word) {
		if(word.equals("전체보기"))
			return carRepository.count();
			return carRepository.cntParkingTypeSearch(word);	
	}
	
	public Long countSearch(String word,String field) {
		if(word.equals("전체보기")) {
			return carRepository.cntCarNumSearch(field);
		}
		if(word.isEmpty())
			return carRepository.cntCarNumSearch(field);
		return carRepository.cntbothSearch(word,field);	
	}
	
	@Transactional
	public void delete(String carNum,Long parkid) {
		ParkingLot p= pRepository.findById(parkid).get();
		p.setCurrentCnt(p.getCurrentCnt()+1);
		carRepository.deleteById(carNum);
	}

}
