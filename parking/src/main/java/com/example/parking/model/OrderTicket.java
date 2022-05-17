package com.example.parking.model;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;

@Data
@Entity
public class OrderTicket { //티켓구매
	@Id
	private Long ticketId;
	@ManyToOne
	@JoinColumn(name = "parkinglotId")
	private ParkingLot parkLot;
	//1:1일권 2:7일권 3:30일권
	@ManyToOne
	@JoinColumn(name = "memberId")
	private Member member; //티켓구매자
	private int ticketType; 
	// 정기권 구매일
	private Date buyDate;
	//정기권 만료일
	private Date endDate;
}
