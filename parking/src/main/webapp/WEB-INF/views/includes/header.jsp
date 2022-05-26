<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/includes/links.jsp" %>

        <section class="sub-header">
            <nav class="nav-container ">
                <div class="nav-container-links d-flex justify-content-between align-content-center">
                    <a href="/"><img src="/images/parking-lot.png" style="height:67px;width:67px;"></a>
                    <ul>
                        <li><a href="/member/parkinglotList">주차장 찾기</a></li>
                        <sec:authorize access="hasRole('ROLE_USER')">
                            <li><a href="/member/carRegister">차량등록</a></li>
                            <li><a href="/orderticket/list">정기권 리스트</a></li>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ROLE_OWNER')">
                            <li><a href="/parkinglot/list">주차장 관리</a></li>
                            <li><a href="/parkinglot/insert">주차장 등록</a></li>
                            <li><a href="/ticket/list">정기권 재고현황</a></li>

                        </sec:authorize>
                    </ul>
                    <ul>
                        <sec:authorize access="isAnonymous()">
                            <li><a href="/register/login">로그인</a></li>
                        </sec:authorize>

                        <sec:authorize access="isAuthenticated()">
                            <li><a href="/member/update">${principal.username}님(회원변경)</a></li>
                            <li><a href="/register/logout">로그아웃</a></li>
                        </sec:authorize>
                    </ul>
                </div>
            </nav>
        </section>