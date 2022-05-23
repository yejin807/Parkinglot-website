package com.example.parking.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import com.example.parking.exception.ValidationGroups;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class Member {

    @Id
    @NotBlank(message = "아이디를 입력하세요.", groups = ValidationGroups.NotEmptyGroup.class)
    private String username; // 아이디

    @NotBlank(message = "비밀번호를 입력하세요.", groups = ValidationGroups.NotEmptyGroup.class)
    @Pattern(regexp = "^(?=.*\\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}", message = "비밀번호는 영문과 숫자 조합으로 8 ~ 16자리까지 가능합니다.", groups = ValidationGroups.PatternCheckGroup.class)
    private String password; // 비밀번호

    @NotBlank(message = "이름을 입력하세요", groups = { ValidationGroups.NotEmptyGroup.class,
            ValidationGroups.UpdateCheckGroup.class })
    private String name; // 이름

    @NotBlank(message = "전화번호를 입력하세요.", groups = { ValidationGroups.NotEmptyGroup.class,
            ValidationGroups.UpdateCheckGroup.class })
    @Pattern(regexp = "^01(?:0|1|[6-9])[.-]?(\\d{3}|\\d{4})[.-]?(\\d{4})$", message = "10 ~ 11 자리의 숫자만 입력 가능합니다.", groups = {
            ValidationGroups.PatternCheckGroup.class, ValidationGroups.UpdateCheckGroup.class })
    private String tel; // 연락처

    @NotBlank(message = "이메일을 입력하세요.", groups = { ValidationGroups.NotEmptyGroup.class,
            ValidationGroups.UpdateCheckGroup.class })
    @Pattern(regexp = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}", message = "올바르지 않은 이메일 형식입니다.", groups = {
            ValidationGroups.PatternCheckGroup.class, ValidationGroups.UpdateCheckGroup.class })
    private String email;

    // 패턴만 적용?
    private String bizNum; // 사업자번호(사업자인경우)

    private String gubun; // 구분 : 사업자, 개인
    private String role; // 권한

    @OneToMany(mappedBy = "member")
    private List<Car> car;
}
