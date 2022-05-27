<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/includes/links.jsp" %>

        <head>
            <meta charset="EUC-KR">
            <title>Insert title here</title>
            <link rel="stylesheet" href="/css/style.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.1.1/css/fontawesome.min.css">

        </head>

        <body>
            <section class="header">
                <nav class="nav-container ">
                    <div class="nav-container-links d-flex justify-content-between align-content-center">
                        <a href="/"><img src="/images/parking-lot.png" style="height:67px;width:67px;"></a>
                        <ul>
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
                                <li><a href="/member/admin/listAll">회원관리</a></li>
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

                <div class="text-box">
                    <h1>지금 사용 가능한 주차장은 어디?</h1>
                    <br>
                    <p>주차장 정보를 조회하고 주차가능한 주차장을 찾아보세요! </p>
                    <P>장기주차가 필요하신 분이라면 정기권 구매까지!</p>
                    <P>주차장 관리자라면 입차관리와 요금 정산을 해보세요</P>
                    <a href="/member/parkinglotList" class="hero-btn">주차장 찾기</a>
                </div>
            </section>

        </body>

        </html>