package com.example.parking.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
@Entity
public class ParkingLot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long parkinglotId;// 주차장 id
    // 사장님 id 넣어야함
    private String parkingName; // 주차장명
    private String addr;// 주차장 주소
    private String wido;// 위도
    private String gyeongdo;// 경도
    private String parkinglotTel;// 주차장 전화번호
    private int maxCnt;// 전체 주차수
    private int currentCnt;// 현재 주차수
    private int basicFee;// 기본요금
    private int dayFee;// 일간 요금
    private int monthFee;// 월간 요금
    private String operatingType;// 유형(공영,민영)
    private String files;// 사진파일
    private String openTime;// 오픈 시간
    private String closeTime;// 종료 시간
    @Transient // 테이블생성시 제외
    private MultipartFile upload; // 업로드할 파일

}
