package com.example.parking.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
@Entity
public class Member {
	
	@Id
	@NotNull(message = "아이디는 필수 값입니다.")
	private Long memberId; //아이디
	
	@NotNull(message = "비밀번호는 필수 값입니다.")
	@Size(min = 4, max = 16, message = "길이는 4 ~ 16자 사이어야 합니다.")
	@Pattern(regexp = "^([A-Za-z])+([0-9])+$", message = "대소문자와 숫자의 조합이어야 합니다.")
	private String password; // 비밀번호
	
	private String  name; // 이름
	private String addr; // 주소
	private String tel; // 연락처
	
	private String gubun; // 구분 : 사업자, 개인
	private String bizNum; // 사업자번호(사업자인경우)
	
	private String role; // 권한
}
