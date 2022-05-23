package com.example.parking.config.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.parking.model.Member;
import com.example.parking.repository.MemberRepository;

@Service
public class PrincipalDetailService implements UserDetailsService {
    @Autowired
    private MemberRepository memberRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("load user by username>>" + username);
        Member member = memberRepository.findById(username).get();

        if (member == null)
            return null;

        PrincipalDetails puser = new PrincipalDetails(member);
        System.out.println("puser" + puser);
        return puser;
    }
}
