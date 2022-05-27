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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.parking.config.auth.PrincipalDetails;
import com.example.parking.exception.ValidationGroups;
import com.example.parking.exception.ValidationSequence;
import com.example.parking.model.Car;
import com.example.parking.model.Member;
import com.example.parking.model.Pagenation;
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

    // 마이페이지 이동
    // 로그인 ID 사용
    @GetMapping("mypage")
    public String mypage(Model model, @AuthenticationPrincipal PrincipalDetails principal) {

        Member member = memberService.findById(principal.getUsername());
        List<Car> carList = carService.findAll(member.getUsername());
        model.addAttribute("member", member);
        model.addAttribute("carList", carList);
        return "/member/mypage";
    }

    @GetMapping("beforeUpdate")
    public String beforeupdateFor() {
        return "/member/beforeUpdate";
    }

    @PostMapping("beforeUpdate")
    public String beforeupdate(String password, Model model, RedirectAttributes rattr,
            @AuthenticationPrincipal PrincipalDetails principal) {

        if (!memberService.checkPassword(principal.getUsername(), password)) {
            rattr.addFlashAttribute("errorMsg", "비밀번호가 틀렸습니다");
            return "redirect:/member/beforeUpdate";
        }

        rattr.addFlashAttribute("password", password);
        return "redirect:/member/update";
    }

    // 사용자 정보 수정 페이지 이동
    @GetMapping("update")
    public String updateForm(Model model, @ModelAttribute("password") String password,
            @AuthenticationPrincipal PrincipalDetails principal) {
        Member member = memberService.findById(principal.getUsername());
        member.setPassword(password);
        model.addAttribute("member", member);
        return "/member/update";
    }

    // 사용자 정보 수정 서비스 호출
    @PutMapping("update")
    @ResponseBody
    public ResponseEntity<Object> update(
            @Validated({
                    ValidationGroups.UpdateCheckGroup.class }) @RequestBody Member member) {
        System.out.println(">>>" + member);
        memberService.update(member);
        // /* 변경된 세션 등록 */
        // // 이거 안적으면 암호화가 안된 상태로 들어가 있다??
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(member.getUsername(),
                        member.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);

        return new ResponseEntity<>("success", HttpStatus.OK);

    }

    // 비밀번호 변경 페이지 이동
    @GetMapping("updatePwd")
    public String updatePwdForm() {
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
        System.out.println(">>" + username);
        memberService.delete(username);
        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    /////////////

    @GetMapping("parkinglotList")
    public String parkingList() {
        // System.out.println("parkinglotList");
        return "/member/parkinglotList";
    }

    // 검색 적용
    @GetMapping("list")
    @ResponseBody
    public Map<String, Object> getparkingList(
            @PageableDefault(size = 6, sort = "parkinglotId", direction = Sort.Direction.DESC, page = 0) Pageable pageable,
            @RequestParam(required = false, defaultValue = "") String keyword) {

        Map<String, Object> parkingMap = new HashMap<>();
        Page<ParkingLot> parkinglotPage = memberService.listTotal(keyword, pageable);

        System.out.println("controller keyword >>" + keyword);
        Pagenation pagenation = new Pagenation(parkinglotPage);
        System.out.println("controller search content >>> " + parkinglotPage.getContent());
        parkingMap.put("parkingLot", parkinglotPage.getContent());
        parkingMap.put("parkingLotPagenation", pagenation);
        return parkingMap;
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

    ////// (관리자)

    // 회원 전체보기
    @GetMapping("/admin/listAll")
    public String memberList(Model model) {
        List<Member> memberList = memberService.findAll();
        model.addAttribute("memberList", memberList);
        return "/admin/memberList";
    }

    // 회원 삭제
    @DeleteMapping("/admin/delete")
    public ResponseEntity memberDelete(String username) {
        memberService.deleteByAdmin(username);
        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    @PostMapping("/admin/memberView")
    public String memberView(@RequestParam(value = "bntAdminMemberUpdate") String username, Model model) {
        System.out.println("@@@" + username);
        model.addAttribute("member", memberService.findById(username));
        return "/admin/memberView";
    }

    @PutMapping("/admin/memberUpdate")
    public ResponseEntity memberUpdate(@Validated({
            ValidationGroups.UpdateCheckGroup.class }) @RequestBody Member member) {
        memberService.update(member);
        return new ResponseEntity<>("success", HttpStatus.OK);

    }

}
