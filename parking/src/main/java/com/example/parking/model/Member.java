package com.example.parking.model;


import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Entity
@Data
//@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
//@DiscriminatorColumn(name = "DTYPE")
public class Member {
	
	@Id
//	@NotNull(message = "아이디는 필수 값입니다.")
	private String username; //아이디
	
//	@NotNull(message = "비밀번호는 필수 값입니다.")
//	@Size(min = 4, max = 16, message = "길이는 4 ~ 16자 사이어야 합니다.")
//	@Pattern(regexp = "^([A-Za-z])+([0-9])+$", message = "대소문자와 숫자의 조합이어야 합니다.")
	private String password; // 비밀번호

	private String  name; // 이름
	
//	@NotNull(message = "전화번호는 필수 값입니다.")
//	@Pattern(regexp = "^01(?:0|1|[6-9])[.-]?(\\d{3}|\\d{4})[.-]?(\\d{4})$", message = "10 ~ 11 자리의 숫자만 입력 가능합니다.")
	private String tel; // 연락처
	
//	@NotNull(message = "이메일은 필수 값입니다.")
//	@Pattern(regexp = "[a-zA-z0-9]+@[a-zA-z]+[.]+[a-zA-z.]+", message="example@example.com 형식으로 입력해야합니다.")
	private String email;
	
	private String bizNum; // 사업자번호(사업자인경우)
	
	private String gubun; // 구분 : 사업자, 개인
	private String role; // 권한
}

