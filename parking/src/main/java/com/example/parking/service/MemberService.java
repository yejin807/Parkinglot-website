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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.parking.exception.ValidationSequence;
import com.example.parking.model.Member;
import com.example.parking.model.Pagenation;
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

    public boolean checkPassword(String username, String rawPassword) {
        Member member = memberRepository.findById(username).get();
        String encPassword = member.getPassword();

        if (bcryptPasswordEncoder.matches(rawPassword, encPassword)) {
            return true;
        }

        return false;
    }

    public Member findById(String username) {
        return memberRepository.findById(username).get();
    }

    // 비밀번호 제외 update
    @Transactional
    public void update(Member member) {

        Member contextMember = memberRepository.findById(member.getUsername()).get();
        contextMember.setEmail(member.getEmail());
        contextMember.setName(member.getName());
        contextMember.setBizNum(member.getBizNum());
        contextMember.setTel(member.getTel());

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

    @Transactional
    public void deleteByAdmin(String username) {
        memberRepository.deleteByUsername(username);
        System.out.println(memberRepository.deleteByUsername(username));
    }

    public Page<ParkingLot> listTotal(String keyword, Pageable pageable) {
        // Map<Page<ParkingLot>, Pagenation> mparking = new HashMap<>();
        // Page<ParkingLot> parkinglotPage;
        // Pagenation pagenation;
        if (keyword != "") {
            System.out.println("search");
            // parkinglotPage =
            // parkingLotRepository.findByAddrContainingOrParkingNameContaining(keyword,
            // keyword,
            // pageable);
            // pagenation = new Pagenation(parkinglotPage.getNumberOfElements(),
            // parkinglotPage.getNumber(),
            // parkinglotPage.getSize());
            // mparking.put(parkinglotPage, pagenation);
            return parkingLotRepository.findByAddrContainingOrParkingNameContaining(keyword, keyword,
                    pageable);
        }
        System.out.println("palin");
        return parkingLotRepository.findAll(pageable);
    }

    //// 관리자
    public List<Member> findAll() {
        return memberRepository.findAll();
    }

    public void delete(String username) {
        memberRepository.deleteById(username);
        SecurityContextHolder.clearContext();
    }

}
