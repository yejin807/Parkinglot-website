<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>

        <div class="form-group">
            <label for="pwd">새 비밀번호 :</label> <input type="password" class="form-control" id="password"
                placeholder="Enter new spassword" name="password">
        </div>


        <div class="form-group">
            <label for="passwordcheck">새 비밀번호 확인:</label> <input type="password" class="form-control" id="passwordcheck"
                placeholder="Enter new password check" name="passwordcheck">
        </div>
        <span class="error" id="errorPw"></span>

        <button class="btn btn-dark" id="btnUpdatePwd">비밀번호
            변경</button>