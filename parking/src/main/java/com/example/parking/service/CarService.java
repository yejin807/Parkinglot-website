package com.example.parking.service;

import com.example.parking.model.Car;
import com.example.parking.repository.CarRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CarService {
    @Autowired
    CarRepository carRepository;

    public void carRegister(Car car) {
        carRepository.save(car);
    }
}
