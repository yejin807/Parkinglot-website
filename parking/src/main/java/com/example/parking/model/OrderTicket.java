package com.example.parking.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
@Entity
public class OrderTicket { //티켓구매
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ticketId;
	@ManyToOne
	@JoinColumn(name = "parkinglotId")
	private ParkingLot parkLot;
<<<<<<< Updated upstream
=======
	
>>>>>>> Stashed changes
	@ManyToOne
	@JoinColumn(name = "username")
	private Member member; //티켓구매자
<<<<<<< Updated upstream
	private int ticketType; //정기권 유형 1:1일권 2:7일권 3:30일권
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date buyDate; // 정기권 구매일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate; //정기권 만료일
=======
	private int ticketType; 
	// 정기권 구매일
	private Date buyDate;
	//정기권 만료일
	private Date endDate;
	
	@ManyToOne
	@JoinColumn(name = "carNum")
	private Car car;
>>>>>>> Stashed changes
}
