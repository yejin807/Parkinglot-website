<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>

        <body>
            <div class="container mt-5">
                <input type="hidden" id="gubun" value="${member.gubun}">
                <input type="hidden" id="password" value="${member.password}">
                <div class="form-group">
                    <label for="username">아이디:</label> <input type="text" class="form-control" id="username"
                        name="username" value="${member.username}" readonly>
                </div>

                <div class="form-group">
                    <label for="name">email:</label> <input type="text" class="form-control" id="email" name="email"
                        value="${member.email}">
                </div>
                <span class="error" id="errorEmail"></span>

                <div class="form-group">
                    <label for="name">이름:</label> <input type="name" class="form-control" id="name" name="name"
                        value="${member.name}">
                </div>
                <span class="error" id="errorName"></span>

                <div class="form-group">
                    <label for="tel">전화번호:</label> <input type="tel" class="form-control" id="tel" name="tel"
                        value="${member.tel}">
                </div>
                <span class="error" id="errorTel"></span>

                <c:if test="${member.gubun == 'owner'}">
                    <div class="form-group">
                        <label for="bizNum">사업자번호 :</label> <input type="text" class="form-control" id="bizNum"
                            name="bizNum" value="${member.bizNum}">
                    </div>
                    <span class="error" id="errorBizNum"></span>
                </c:if>

                <button type="button" class="btn btn-success" id="btnUpdateAcc">정보 수정</button>

                <button type="button" class="btn btn-success" id="btnUpdatePwdForm"
                    onclick="location.href='/member/updatePwd'">비밀번호 변경</button>

                <button type="button" class="btn btn-danger" id="btnDelAcc">계정 삭제</button>

                <button type="button" class="btn btn-dark" id="btnCancleUpdate"
                    onclick="location.href='/member/mypage'">수정
                    취소</button>


            </div>
        </body>