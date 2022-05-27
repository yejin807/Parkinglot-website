<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>
        <div class="container mt-5 pt-5">
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <input type="hidden" v id="username" value="${username}" />
                <h3 class="mb-5">${username} 비밀번호 변경</h3>
            </sec:authorize>
            <div class="form-group">
                <label for="pwd">새 비밀번호 :</label> <input type="password" class="form-control" id="password"
                    placeholder="비밀번호는 영문과 숫자 조합으로 8 ~ 16자리까지 가능합니다." name="password">
            </div>


            <div class="form-group">
                <label for="passwordcheck">새 비밀번호 확인:</label> <input type="password" class="form-control"
                    id="passwordcheck" placeholder="비밀번호는 영문과 숫자 조합으로 8 ~ 16자리까지 가능합니다." name="passwordcheck">
            </div>


            <button class="btn btn-dark" id="btnUpdatePwd">비밀번호
                변경</button> <span class="error" id="errorPw"></span>
        </div>