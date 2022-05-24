<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            
                <!DOCTYPE html>
                <html>
                <sec:authorize access="isAuthenticated()">
                	<sec:authentication property="principal" var ="principal"/>
                </sec:authorize>
                
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
                <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <nav class="navbar navbar-expand-sm bg-success navbar-dark mb-5">
	                <div class="container">
                        <!-- Links -->
                        <ul class="navbar-nav mr-between">
                            <li class="nav-item">
                            	<a class="navbar-brand" href="/parkinglot/listAll">주차장리스트(전체)</a>
                            	<sec:authorize access="hasRole('ROLE_USER')">
                                <a class="navbar-brand" href="/member/carRegister">차량등록</a>
                                <a class="navbar-brand" href="/orderticket/list">정기권구매리스트</a>
                                </sec:authorize>
                               	<sec:authorize access="hasRole('ROLE_OWNER')">
                                <a class="navbar-brand" href="/parkinglot/list">주차장리스트(사장님)</a>
                                </sec:authorize>
                            </li>
                            
                        </ul>
                         <ul class="navbar-nav">
                            <li class="nav-item">
                            <c:if test="${empty principal}">                           
                                <a class="navbar-brand" href="/register/join">회원가입</a>
                                <a class="navbar-brand" href="/register/login">로그인</a>
                            </c:if>
                            <c:if test="${not empty principal}">
                                <a class="navbar-brand" href="/member/update">${principal.username}님(회원변경)</a>
                                <a class="navbar-brand" href="/register/logout">로그아웃</a>
                            </c:if>
                            </li>
                        </ul>
                        </div>
                </nav>
                