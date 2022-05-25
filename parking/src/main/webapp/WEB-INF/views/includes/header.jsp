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
                <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
                <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
                <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
                <link
                    href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
                    rel="stylesheet">


                <link href="/css/sb-admin-2.min.css" rel="stylesheet">
                <nav class="navbar navbar-expand-sm bg-success navbar-dark">
                    <div class="container">

                        <ul class="navbar-nav mr-between">
                            <li class="nav-item">
                                <a class="navbar-brand" href="/parkinglot/listAll">주차장 전체리스트</a>
                                <sec:authorize access="hasRole('ROLE_USER')">
                                    <a class="navbar-brand" href="/member/carRegister">차량등록</a>
                                    <a class="navbar-brand" href="/orderticket/list">정기권 리스트</a>
                                </sec:authorize>
                                <sec:authorize access="hasRole('ROLE_OWNER')">
                                    <a class="navbar-brand" href="/parkinglot/list">주차장 현황</a>
                                    <a class="navbar-brand" href="/parkinglot/insert">주차장 등록</a>
                                    <a class="navbar-brand" href="/ticket/list">정기권 재고현황</a>
                                </sec:authorize>
                            </li>

                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <sec:authorize access="isAnonymous()">
                                    <a class="navbar-brand" href="/register/join">회원가입</a>
                                    <a class="navbar-brand" href="/register/login">로그인</a>
                                </sec:authorize>
                                <sec:authorize access="isAuthenticated()">
                                    <a class="navbar-brand" href="/member/update">${principal.username}님(회원변경)</a>
                                    <a class="navbar-brand" href="/register/logout">로그아웃</a>
                                </sec:authorize>
                            </li>
                        </ul>
                    </div>
                </nav>
                <!--
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
                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                
                                <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
                                <link
                                    href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
                                    rel="stylesheet">
                
                             
                                <link href="/css/sb-admin-2.min.css" rel="stylesheet">
                                <header>
                                    <nav class="navbar navbar-expand-md navbar-dark bg-dark" id="mainNav">
                                        <div class="container">
                                            <a class="navbar-brand" href="#">#주차장#</a>
                                            <div class="collapse navbar-collapse">
                                                <ul class="navbar-nav ml-auto">
                                                    <li class="nav-item"><a class="navbar-link" href="/parkinglot/listAll">주차장
                                                            전체리스트</a></li>
                                                    <sec:authorize access="hasRole('ROLE_USER')">
                                                        <li class="nav-item">
                                                            <a class="navbar-link" href="/member/carRegister">차량등록</a>
                                                        </li>
                                                        <li class="nav-item">
                                                            <a class="navbar-link" href="/orderticket/list">정기권 리스트</a>
                                                        </li>
                                                    </sec:authorize>
                                                    <sec:authorize access="hasRole('ROLE_OWNER')">
                                                        <li class="nav-item">
                                                            <a class="navbar-link" href="/parkinglot/list">주차장 현황</a>
                                                        </li>
                                                        <li class="nav-item">
                                                            <a class="navbar-link" href="/parkinglot/insert">주차장 등록</a>
                                                        </li>
                                                        <li class="nav-item">
                                                            <a class="navbar-link" href="/ticket/list">정기권 재고현황</a>
                                                        </li>
                                                    </sec:authorize>
                
                
                                                    <sec:authorize access="isAnonymous()">
                                                        <li class="nav-item">
                                                            <a class="navbar-link" href="/register/login">로그인</a>
                                                        </li>
                                                    </sec:authorize>
                                                    <sec:authorize access="isAuthenticated()">
                                                        <li class="nav-item">
                                                            <a class="navbar-link"
                                                                href="/member/update">${principal.username}님(회원변경)</a>
                                                        </li>
                                                        <li class="nav-item">
                                                            <a class="navbar-link" href="/register/logout">로그아웃</a>
                                                        </li>
                                                    </sec:authorize>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </nav>
                                </header> -->