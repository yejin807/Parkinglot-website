<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/includes/links.jsp" %>

        <section class="sub-header">
            <nav class="nav-container ">
                <div class="nav-container-links d-flex justify-content-between align-content-center">
                    <a href="/"><img src="/images/parking-lot.png" style="height:67px;width:67px;"></a>
                    <ul>
                        <li><a href="/member/parkinglotList">주차장 찾기</a></li>
                        <!-- 일반회원 -->
                        <sec:authorize access="hasRole('ROLE_USER')">
                            <li><a href="/member/carRegister">차량등록</a></li>
                            <li><a href="/orderticket/list">정기권 리스트</a></li>
                        </sec:authorize>
                        
						<!-- 사장님 -->
                        <sec:authorize access="hasRole('ROLE_OWNER')">
                            <li><a href="/parkinglot/list">주차장 관리</a></li>
                            <li><a href="/parkinglot/insert">주차장 등록</a></li>
                            <li><a href="/ticket/list">정기권 재고현황</a></li>
                        </sec:authorize>
                        
                        <!-- 관리자 -->
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <li><a href="/parkinglot/listAll">주차장 관리</a></li>
                            <li><a href="/orderticket/listAll">구매티켓관리</a></li>
                            <li><a href="/member/listAll">회원관리</a></li>
                        </sec:authorize>
                    </ul>
                    <ul>
                    	<!-- 일반접속 -->
                        <sec:authorize access="isAnonymous()">
                            <li><a href="/register/login">로그인</a></li>
                        </sec:authorize>
						
						<!-- 로그인상태 -->
                        <sec:authorize access="isAuthenticated()">
                            <li><a href="/member/mypage">마이페이지</a></li>
                            <li><a href="/register/logout">로그아웃</a></li>
                        </sec:authorize>
                    </ul>
                </div>
            </nav>
        </section>