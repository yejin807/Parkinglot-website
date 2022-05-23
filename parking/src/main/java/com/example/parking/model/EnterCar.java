package com.example.parking.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Data;

@Data
@Entity
public class EnterCar {
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private Long enterid;
	
	@Id
	private String carNum;
	private String parkingType;
	
	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "intime")
	private Date intime;
		
	private int fee;
}
