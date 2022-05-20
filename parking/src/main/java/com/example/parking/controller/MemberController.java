package com.example.parking.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
import com.example.parking.model.Member;
import com.example.parking.model.ParkingLot;
import com.example.parking.repository.MemberRepository;
import com.example.parking.service.MemberService;
import com.example.parking.service.ParkingLotService;

@RequestMapping("/member/*")
@Controller
public class MemberController {
    @Autowired
    MemberService memberService;

    @Autowired
    ParkingLotService parkingLotService;

    @GetMapping("join")
    public String join() {
        return "/member/divideAccount";
    }

    @GetMapping("join/user")
    public String joinUser(Model model) {
        Member member = new Member();
        member.setGubun("user");
        model.addAttribute("member", member);
        return "/member/account";
    }

    @GetMapping("join/owner")
    public String joinOwner(Model model) {
        Member member = new Member();
        member.setGubun("owner");
        model.addAttribute("member", member);
        return "/member/account";
    }

    @PostMapping("join")
    @ResponseBody
    public ResponseEntity join(@Valid @RequestBody Member member) {
        //
        // if (result.hasErrors()) {
        // System.out.println(result);
        // }
        memberService.join(member);
        return new ResponseEntity("success", HttpStatus.OK);
    }

    @GetMapping("login")
    public String login() {
        return "/member/login";
    }

    @GetMapping("fail")
    public String login(Model model) {
        model.addAttribute("errorMsg", "로그인 실패");
        return "/member/login";
    }

    @GetMapping("mypage")
    public String mypage(Model model, @AuthenticationPrincipal PrincipalDetails principal) {

        Member member = memberService.findById(principal.getUsername());
        model.addAttribute("member", member);
        return "/member/mypage";
    }

    @PutMapping("update")
    @ResponseBody
    public ResponseEntity update(@RequestBody Member member) {

        memberService.update(member);
        return new ResponseEntity("success", HttpStatus.OK);

    }

    @DeleteMapping("delete")
    public ResponseEntity<String> delete(String username) {
        memberService.delete(username);

        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    // ////////////

    @GetMapping("parkinglotList")
    public String parkingList() {
        System.out.println("parkinglotList");
        return "/member/parkinglotList";
    }

    // @PostMapping("parkinglotList")
    // @ResponseBody
    // public List<ParkingLot> getparkingList() {

    // return parkingLotService.list();
    // }

    // 검색 적용
    @GetMapping("list")
    @ResponseBody
    public Page<ParkingLot> getparkingList(
            @PageableDefault(size = 3, sort = "parkinglotId", direction = Sort.Direction.DESC, page = 0) Pageable pageable,
            @RequestParam(required = false, defaultValue = "") String keyword) {
        System.out.println("AAA");
        return memberService.listTotal(keyword, pageable);
    }

}
