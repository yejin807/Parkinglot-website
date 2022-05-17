package com.example.parking.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.parking.model.Member;
import com.example.parking.service.MemberService;

@RequestMapping("/member/*")
@Controller
public class MemberController {
	@Autowired
	MemberService memberService;
	

    @GetMapping("login")
    public String login() {
        return "/member/divideAccount";
    }
    
	@GetMapping("login/user")
	public String loginUser(Model model) {
		Member member = new Member();
		member.setGubun("user");
		model.addAttribute("member", member);
		return "/member/account";
	}
	
	@GetMapping("login/owner")
	public String loginOwner(Model model) {
		Member member = new Member();
		member.setGubun("owner");
		model.addAttribute("member", member);
		return "/member/account";
	}
	
	@PostMapping("join")
	public ResponseEntity join(@Valid @RequestBody Member member) {
		memberService.join(member);
		return new ResponseEntity("success", HttpStatus.OK);
	}
}
