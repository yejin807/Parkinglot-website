<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>

        <body>
            <div class="container mt-5">
                <input type="hidden" id="gubun" value="${member.gubun}">
                <div class="form-group">
                    <label for="username">아이디:</label> <input type="text" class="form-control" id="username"
                        placeholder="아이디" name="username">
                </div>
                <span class="error" id="errorId"></span>


                <div class="form-group">
                    <label for="password">비밀번호:</label> <input type="password" class="form-control" id="password"
                        placeholder="비밀번호" name="password">
                </div>
                <span class="error" id="errorPw"></span>

                <div class="form-group">
                    <label for="name">이름:</label> <input type="name" class="form-control" id="name" placeholder="이름"
                        name="name">
                </div>
                <span class="error" id="errorName"></span>

                <div class="form-group">
                    <label for="tel">전화번호:</label> <input type="tel" class="form-control" id="tel" placeholder="전화번호"
                        name="tel">
                </div>
                <span class="error" id="errorTel"></span>

                <c:if test="${member.gubun == 'owner'}">
                    <div class="form-group">
                        <label for="bizNum">사업자번호 :</label> <input type="text" class="form-control" id="bizNum"
                            placeholder="사업자번호" name="bizNum">
                    </div>
                    <span class="error" id="errorBizNum"></span>

                    <button type="button" class="btn btn-secondary" id="btnCheckBizNum">사업자
                        번호 확인</button>
                </c:if>

                <div class="form-group">
                    <label for="email">이메일:</label> <input type="email" class="form-control" id="email"
                        placeholder="이메일" name="email">
                </div>
                <span class="error" id="errorEmail"></span>
                <br>
                <button type="button" class="btn btn-secondary mt-5" id="btnJoin">create
                    account</button>

            </div>
        </body>