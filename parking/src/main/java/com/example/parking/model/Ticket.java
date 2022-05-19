package com.example.parking.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;

@Data
@Entity
public class Ticket {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ticketId;
	@ManyToOne
	@JoinColumn(name = "parkinglotId")
	private ParkingLot parkLot;
	private int dayFee;
	private int dayStock;
	private int weekFee;
	private int weekStock;
	private int monthFee;
	private int monthStock;
}
