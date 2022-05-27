<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/admin.js"></script>

        <body>
            <div class="container mt-5 d-flex justify-content-center">
                <div class="mr-5" style="width:400px;">

                    <input type="hidden" id="gubun" value="${member.gubun}">
                    <div class="form-group">
                        <label for="username">아이디:</label> <input type="text" class="form-control" id="username"
                            name="username" value="${member.username}" readonly>
                    </div>


                    <div class="form-group">
                        <label for="name">email:</label> <input type="text" class="form-control" id="email" name="email"
                            value="${member.email}">
                    </div>

                    <div class="form-group">
                        <label for="name">이름:</label> <input type="name" class="form-control" id="name" name="name"
                            value="${member.name}">
                    </div>

                    <div class="form-group">
                        <label for="tel">전화번호:</label> <input type="tel" class="form-control" id="tel" name="tel"
                            value="${member.tel}">
                    </div>

                    <c:if test="${member.gubun == 'owner'}">
                        <div class="form-group">
                            <label for="bizNum">사업자번호 :</label> <input type="text" class="form-control" id="bizNum"
                                name="bizNum" value="${member.bizNum}">
                        </div>
                    </c:if>
                    <button type="button" class="btn btn-success" id="btnUpdateMemberByAdmin">update
                        account</button>

                </div>

        </body>