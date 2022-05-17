package com.example.parking.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;

@Data
@Entity
public class Ticket {
	@Id
	private Long ticketId;
	@ManyToOne
	@JoinColumn(name = "parkinglotId")
	private ParkingLot parkLot;
	//1:1일권 2:7일권 3:30일권
	private int ticketType;
	private int stock;

}
