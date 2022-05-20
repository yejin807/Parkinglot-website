package com.example.parking.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    public void join(Member member) {

        String rawPassword = member.getPassword();
        String encPassword = bcryptPasswordEncoder.encode(rawPassword);
        member.setPassword(encPassword);

        memberRepository.save(member);
    }

    public Member findById(String username) {
        return memberRepository.findById(username).get();
    }

    @Transactional
    public void update(Member member) {

        Member contextMember = memberRepository.findById(member.getUsername()).get();

        String rawPassword = member.getPassword();
        String encPassword = bcryptPasswordEncoder.encode(rawPassword);
        contextMember.setPassword(encPassword);
        contextMember.setEmail(member.getEmail());
        contextMember.setName(member.getName());
        contextMember.setBizNum(member.getBizNum());
        contextMember.setTel(member.getTel());

    }

    public void delete(String username) {
        memberRepository.deleteById(username);
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
