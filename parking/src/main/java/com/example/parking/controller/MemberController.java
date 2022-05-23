package com.example.parking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.parking.config.auth.PrincipalDetails;
import com.example.parking.exception.ValidationGroups;
import com.example.parking.exception.ValidationSequence;
import com.example.parking.model.Car;
import com.example.parking.model.Member;
import com.example.parking.model.ParkingLot;
import com.example.parking.service.CarService;
import com.example.parking.service.MemberService;
import com.example.parking.service.ParkingLotService;

@RequestMapping("/member/*")
@Controller
public class MemberController {
    @Autowired
    MemberService memberService;

    @Autowired
    ParkingLotService parkingLotService;

    @Autowired
    CarService carService;

    @Autowired
    AuthenticationManager authenticationManager;

    // // 회원가입 구분 선택 페이지로 이동
    // @GetMapping("join")
    // public String join() {
    // return "/member/divideJoin";
    // }

    // // 일반 사용자 회원가입 페이지로 이동
    // @GetMapping("join/user")
    // public String joinUser(Model model) {
    // Member member = new Member();
    // member.setGubun("user");
    // model.addAttribute("member", member);
    // return "/member/join";
    // }

    // // 자동차 관리자 회원 가입 페이지로 이동
    // @GetMapping("join/owner")
    // public String joinOwner(Model model) {
    // Member member = new Member();
    // member.setGubun("owner");
    // model.addAttribute("member", member);
    // return "/member/join";
    // }

    // // 회원 가입 서비스 호출
    // // 아이디 중복검사, 입력 유효성 검사 실행
    // @PostMapping("join")
    // @ResponseBody
    // public ResponseEntity<Object> join(@Validated(ValidationSequence.class)
    // @RequestBody Member member) {
    // // Validated -> throws MethodArgumentNotValidException

    // boolean idExist =
    // memberService.checkUsernameDuplication(member.getUsername());
    // if (idExist == true)
    // throw new IllegalStateException();
    // else {

    // memberService.join(member);
    // return new ResponseEntity<>(HttpStatus.OK);
    // }
    // }

    // // 로그인 페이지 이동
    // @GetMapping("login")
    // public String login() {
    // return "/member/login";
    // }

    // // 로그인 실패
    // @GetMapping("fail")
    // public String login(Model model) {
    // model.addAttribute("errorMsg", "로그인 실패");
    // return "/member/login";
    // }

    // 마이페이지 이동
    // 로그인 ID 사용
    @GetMapping("mypage")
    public String mypage(Model model, @AuthenticationPrincipal PrincipalDetails principal) {

        Member member = memberService.findById(principal.getUsername());
        model.addAttribute("member", member);
        return "/member/mypage";
    }

    // 사용자 정보 수정 페이지 이동
    @GetMapping("update")
    public String updateForm(Model model, @AuthenticationPrincipal PrincipalDetails principal) {
        Member member = memberService.findById(principal.getUsername());
        model.addAttribute("member", member);
        return "/member/update";
    }

    // 사용자 정보 수정 서비스 호출
    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<Object> update(
            @Validated({
                    ValidationGroups.UpdateCheckGroup.class }) @RequestBody Member member) {

        memberService.update(member);

        return new ResponseEntity<>("success", HttpStatus.OK);

    }

    // 비밀번호 변경 페이지 이동
    @GetMapping("updatePwd")
    public String updatePwdForm() {
        // System.out.println("controller >>" + SecurityContextHolder.getContext());
        return "/member/updatePwd";
    }

    // 비밀번호 변경
    @PutMapping("updatePwd")
    public ResponseEntity<Object> updatePwd(@AuthenticationPrincipal PrincipalDetails principal, String password) {

        Member member = principal.getMember();
        member.setPassword(password);

        memberService.updatePwd(member);

        return new ResponseEntity<>(HttpStatus.OK);

    }

    @DeleteMapping("delete")
    public ResponseEntity<String> delete(String username) {
        memberService.delete(username);

        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    /////////////

    @GetMapping("parkinglotList")
    public String parkingList() {
        System.out.println("parkinglotList");
        return "/member/parkinglotList";
    }

    // 검색 적용
    @GetMapping("list")
    @ResponseBody
    public Page<ParkingLot> getparkingList(
            @PageableDefault(size = 3, sort = "parkinglotId", direction = Sort.Direction.DESC, page = 0) Pageable pageable,
            @RequestParam(required = false, defaultValue = "") String keyword) {
        System.out.println("AAA");
        return memberService.listTotal(keyword, pageable);
    }

    // 주차장 등록 페이지 이동
    @GetMapping("carRegister")
    public String carRegisterForm() {
        return "/member/carRegister";
    }

    @PostMapping("carRegister")
    public ResponseEntity carRegister(@RequestBody Car car, @AuthenticationPrincipal PrincipalDetails principal) {
        Member member = principal.getMember();
        car.setMember(member);
        carService.carRegister(car);
        return new ResponseEntity<>("success", HttpStatus.OK);

    }

}
