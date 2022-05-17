package com.example.parking.model;


import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class ParkingLot {
	@Id
	private Long parkinglotId;//주차장 id
	private String parkingName; //주차장명
	private String addr;//주차장 주소
	private String wido;//위도
	private String geongdo;//경도
	private String parkinglotTel;//주차장 전화번호
	private int maxCnt;//전체 주차수
	private int currentCnt;//현재 주차수
	private int basicFee;//기본요금
	private int dayFee;//일간 요금
	private int monthFee;//월간 요금
	private String operatingType;//유형(공영,민영)
	private String files;//사진파일
	private String openTime;//오픈 시간
	private String closeTime;//종료 시간

}
