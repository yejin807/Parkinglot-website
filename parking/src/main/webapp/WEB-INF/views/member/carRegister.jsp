<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>

        <!-- private String carNum; // 차량번호
        private String carName; // 차량이름
        private String carType; // 차량타입(소형,대형)
        
        @ManyToOne
        @JoinColumn(name = "username")
        private Member member; -->

        <label for="carNum">차량번호:</label><input type="text" name="carNum" id="carNum">
        <label for="carName">차량 이름:</label><input type="text" name="carName" id="carName">
        <label>차량 타입:</label>
        <input type="radio" name="carType" id="carSmall" value="Small">
        <label for="carSmall">소형</label>
        <input type="radio" name="carType" id="carMid" value="Mid">
        <label for="carMid">중형</label>
        <input type="radio" name="carType" id="carBig" value="Big">
        <label for="carBig">대형</label>
        <button id="btnCarRegister">등록하기</button>