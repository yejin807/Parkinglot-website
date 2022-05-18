package com.example.parking.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.parking.model.ParkingLot;

public interface ParkingLotRepository extends JpaRepository<ParkingLot, Long>{

}
