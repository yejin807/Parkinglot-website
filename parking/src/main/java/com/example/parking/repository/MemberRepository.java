package com.example.parking.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.parking.model.Member;

public interface MemberRepository extends JpaRepository<Member, String> {

}
