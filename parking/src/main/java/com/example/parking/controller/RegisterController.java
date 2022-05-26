package com.example.parking.controller;

import com.example.parking.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.parking.exception.ValidationSequence;
import com.example.parking.model.Member;

@RequestMapping("/register/*")
@Controller
public class RegisterController {
    @Autowired
    MemberService memberService;

    // 회원가입 구분 선택 페이지로 이동
    @GetMapping("join")
    public String join() {
        return "/register/divideJoin";
    }

    @GetMapping("choicejoin")
    public String choicejoin() {
        return "/register/choiceJoin";
    }

    // 일반 사용자 회원가입 페이지로 이동
    @GetMapping("join/user")
    public String joinUser(Model model) {
        Member member = new Member();
        member.setGubun("user");

        model.addAttribute("member", member);
        return "/register/join";
    }

    // 자동차 관리자 회원 가입 페이지로 이동
    @GetMapping("join/owner")
    public String joinOwner(Model model) {
        Member member = new Member();
        member.setGubun("owner");

        model.addAttribute("member", member);
        return "/register/join";
    }

    // 회원 가입 서비스 호출
    // 아이디 중복검사, 입력 유효성 검사 실행
    @PostMapping("join")
    @ResponseBody
    public ResponseEntity<Object> join(@Validated(ValidationSequence.class) @RequestBody Member member) {
        // Validated -> throws MethodArgumentNotValidException
        boolean idExist = memberService.checkUsernameDuplication(member.getUsername());
        if (idExist == true)
            throw new IllegalStateException();
        else {

            if (member.getGubun().equals("owner")) {
                // System.out.println("set role owner");
                member.setRole("ROLE_OWNER");
            } else if (member.getGubun().equals("user")) {
                member.setRole("ROLE_USER");
                // System.out.println("set role user");
            }

            memberService.join(member);
            return new ResponseEntity<>(HttpStatus.OK);
        }
    }

    // 로그인 페이지 이동
    @GetMapping("login")
    public String login() {
        return "/register/login";
    }

    // 로그인 실패
    @GetMapping("fail")
    public String login(Model model) {
        model.addAttribute("errorMsg", "로그인 실패");
        return "/register/login";
    }

    @PutMapping("login")
    public String loginn() {
        return "/member/mypage";
    }
}
