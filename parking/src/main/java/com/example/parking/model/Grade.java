package com.example.parking.model;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;

@Data
@Entity
public class Grade {
	@Id
	private Long gradeId;
	@ManyToOne
	@JoinColumn(name = "parkinglotId")
	private ParkingLot parkingLot;// 주차장 id
	@ManyToOne
	@JoinColumn(name = "memberId")
	private Member member;// 차번호
	private String comment;// 코멘트
	private int star;// 별점
	private Date regDate;// 등록일
}
