<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>

        <body>
            <div class="container mt-5">
                <input type="hidden" id="gubun" value="${member.gubun}">
                <div class="form-group">
                    <label for="username">아이디:</label> <span class="error" id="errorId"></span>              
                    <form class="row mt-0">
                        <div class="col">
                        <input type="text" class="form-control" id="username"  placeholder="아이디" name="username">  
                    <!-- </div>
                        <div class="col">
                         <button type="submit" class="btn btn-primary " id="btnJoin">아이디 중복 확인</button>
                    </div> -->
                    </form>
                </div>
               


                <div class="form-group">
                    <label for="password">비밀번호:</label> <span class="error" id="errorPw"></span>
                    <input type="password" class="form-control" id="password"
                        placeholder="비밀번호" name="password">
                </div>
                

                <div class="form-group">
                    <label for="name">이름:</label> <span class="error" id="errorName"></span>
                    <input type="name" class="form-control" id="name" placeholder="이름"
                        name="name">
                </div>
                

                <div class="form-group">
                    <label for="tel">전화번호:</label>  <span class="error" id="errorTel"></span>
                    <input type="tel" class="form-control" id="tel" placeholder="전화번호"
                        name="tel">
                </div>
               

                <c:if test="${member.gubun == 'owner'}">
                    <div class="form-group">
                        <label for="bizNum">사업자번호 :</label> <span class="error" id="errorBizNum"></span>
                        <input type="text" class="form-control" id="bizNum"
                            placeholder="사업자번호" name="bizNum">
                    </div>
                    

                    <button type="button" class="btn btn-secondary" id="btnCheckBizNum">사업자
                        번호 확인</button>
                </c:if>

                <div class="form-group">
                    <label for="email">이메일:</label>  <span class="error" id="errorEmail"></span>
                    <input type="email" class="form-control" id="email"
                        placeholder="이메일" name="email">
                </div>
               
                <button type="button" class="btn btn-primary" id="btnJoin">create
                    account</button>

            </div>
        </body>