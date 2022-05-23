package com.example.parking.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import com.example.parking.exception.ValidationSequence;
import com.example.parking.model.Member;
import com.example.parking.model.ParkingLot;
import com.example.parking.repository.MemberRepository;
import com.example.parking.repository.ParkingLotRepository;

@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;

    @Autowired
    ParkingLotRepository parkingLotRepository;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

    @Autowired
    AuthenticationManager authenticationManager;

    public void join(@Validated(ValidationSequence.class) Member member) {

        String rawPassword = member.getPassword();
        String encPassword = bcryptPasswordEncoder.encode(rawPassword);
        member.setPassword(encPassword);

        memberRepository.save(member);
    }

    public boolean checkUsernameDuplication(String username) {
        return memberRepository.existsById(username);
    }

    public Member findById(String username) {
        return memberRepository.findById(username).get();
    }

    // 비밀번호 제외 update
    @Transactional
    public void update(Member member) {
        // System.out.println("1>>" + SecurityContextHolder.getContext());
        Member contextMember = memberRepository.findById(member.getUsername()).get();

        contextMember.setEmail(member.getEmail());
        contextMember.setName(member.getName());
        contextMember.setBizNum(member.getBizNum());
        contextMember.setTel(member.getTel());

        // /* 변경된 세션 등록 */
        // // 이거 안하니까 수정 된다
        // Authentication authentication = authenticationManager.authenticate(
        // new UsernamePasswordAuthenticationToken(member.getUsername(),
        // member.getPassword()));
        // SecurityContextHolder.getContext().setAuthentication(authentication);
        // System.out.println("service update member" +
        // SecurityContextHolder.getContext());

    }

    // 비밀번호 수정
    @Transactional
    public void updatePwd(Member member) {

        Member contextMember = memberRepository.findById(member.getUsername()).get();
        String rawPassword = member.getPassword();
        String encPassword = bcryptPasswordEncoder.encode(rawPassword);
        contextMember.setPassword(encPassword);

        /* 변경된 세션 등록 */
        // 이거 안적으면 암호화가 안된 상태로 들어가 있다??
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(member.getUsername(),
                        member.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);

        System.out.println("service updatepwd >>" + SecurityContextHolder.getContext());
    }

    public void delete(String username) {
        memberRepository.deleteById(username);
        SecurityContextHolder.clearContext();
    }

    public Page<ParkingLot> listTotal(String keyword, Pageable pageable) {

        if (keyword != "") {
            System.out.println("search");
            return parkingLotRepository.findByAddrContainingOrParkingNameContaining(keyword, keyword, pageable);
        }
        System.out.println("palin");
        return parkingLotRepository.findAll(pageable);
    }

}
