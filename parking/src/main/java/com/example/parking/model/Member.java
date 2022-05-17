package com.example.parking.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import lombok.Data;

@Data
@Entity
public class Member {
	@Id
	private Long memberId; //아이디
	private String password; // 비밀번호
	private String  name; // 이름
	private String addr; // 주소
	private String tel; // 연락처
	private String gubun; // 구분 : 사업자, 개인
	private String bizNum; // 사업자번호(사업자인경우)
	private String role; // 권한
}
