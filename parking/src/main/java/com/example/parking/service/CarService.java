package com.example.parking.service;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.parking.model.Car;
import com.example.parking.repository.CarRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CarService {

	private final CarRepository carRepository;
	
	@Transactional
	public void save(Car car) {
		carRepository.save(car);		
	}
	@Transactional
	public void parkingtypeset(Car car) {
		Car c= carRepository.findById(car.getCarNum()).get();
		if(c.getFee()==300000) {
			c.setParkingType("월주차");
		}
		else if(c.getFee()==100000) {
			c.setParkingType("주주차");
		}
		else if(c.getFee()==20000) {
			c.setParkingType("일주차");
		}
		else{
			c.setParkingType("자유주차");
		} 
	}
	
	public Page<Car> findAll(String word,Pageable pageable){
		if(word.equals("전체보기"))
			return carRepository.findAll(pageable);		
			return carRepository.findByParkingTypeContaining(word,pageable);
		
	}
	
	public Page<Car> findSearch(String word,String field,Pageable pageable){
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
	public void delete(String carNum) {
		carRepository.deleteById(carNum);
	}
	
	@Transactional
	public Car view(String carNum) {
		Car car = carRepository.findById(carNum).get();
		return car;
	}

	@Transactional
	public void update(String carNum,Car car) {
		Car c = carRepository.findById(carNum).get();

		c.setCarName(car.getCarName());
		c.setCarType(car.getCarType());
		c.setFee(car.getFee());
	}

}
