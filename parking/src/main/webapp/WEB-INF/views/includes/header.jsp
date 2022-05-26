<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html>

                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal" var="principal" />
                </sec:authorize>

                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
                <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <link rel="stylesheet" href="/css/style.css">
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

                <section class="sub-header">
                    <nav class="nav-container">
                        <a href="/"><img src="/images/parking-lot.png"></a>
                        <div class="nav-container-links">
                            <ul>
                                <li><a href="/parkinglot/listAll">주차장 전체리스트</a></li>
                                <sec:authorize access="hasRole('ROLE_USER')">
                                    <li><a href="/member/carRegister">차량등록</a></li>
                                    <li><a href="/orderticket/list">정기권 리스트</a></li>
                                </sec:authorize>

                                <sec:authorize access="hasRole('ROLE_OWNER')">
                                    <li><a href="/parkinglot/list">주차장 현황</a></li>
                                    <li><a href="/parkinglot/insert">주차장 등록</a></li>
                                    <li><a href="/ticket/list">정기권 재고현황</a></li>

                                </sec:authorize>

                                <sec:authorize access="isAnonymous()">
                                    <li><a href="/register/choicejoin">회원가입</a></li>
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