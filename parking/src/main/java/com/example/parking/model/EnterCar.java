package com.example.parking.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Data;

@Data
@Entity
public class EnterCar {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long enterid;
	
	private Car car;
	
	@JoinColumn(name = "parkinglot_Id") 
	private ParkingLot pakingLot; // 주차장
	
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "intime")
	private Date intime;
	
	private String parkingType;
	
	private int fee;
}
