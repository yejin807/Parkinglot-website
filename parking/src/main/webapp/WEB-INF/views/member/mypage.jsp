<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>


        <div class="container mt-5">
            <input type="hidden" id="gubun" value="${member.gubun}">
            <div class="form-group">
                <label for="username">아이디:</label> <input type="text" class="form-control" id="username" name="username"
                    value="${member.username}" readonly>
            </div>


            <div class="form-group">
                <label for="name">email:</label> <input type="text" class="form-control" id="email" name="email"
                    value="${member.email}" readonly>
            </div>

            <div class="form-group">
                <label for="name">이름:</label> <input type="name" class="form-control" id="name" name="name"
                    value="${member.name}" readonly>
            </div>

            <div class="form-group">
                <label for="tel">전화번호:</label> <input type="tel" class="form-control" id="tel" name="tel"
                    value="${member.tel}" readonly>
            </div>

            <c:if test="${member.gubun == 'owner'}">
                <div class="form-group">
                    <label for="bizNum">사업자번호 :</label> <input type="text" class="form-control" id="bizNum"
                        name="bizNum" value="${member.bizNum}" readonly>
                </div>
            </c:if>

            <button type="button" class="btn btn-dark" id="btnParkinglotList"
                onclick="location.href='/member/parkinglotList'">주차장 조회</button>

            <button type="button" class="btn btn-success" id="btnUpdateAccForm"
                onclick="location.href='/member/update'">update
                account</button>

            <button type="button" class="btn btn-success" id="btnCarRegisterForm"
                onclick="location.href='/member/carRegister'">자동차 등록</button>
            <button type="button" class="btn btn-dark" id="btnLogout"
                onclick="location.href='/register/logout'">로그아웃</button>

        </div>
        </body>