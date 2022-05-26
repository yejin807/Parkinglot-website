package com.example.parking.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;

@Data
@Entity
public class Car {
    @Id
    private String carNum; // 차량번호
    private String carName; // 차량이름
    //private String carType; // 차량타입(소형,대형)

    @ManyToOne
    @JoinColumn(name = "username")
    private Member member;
}
