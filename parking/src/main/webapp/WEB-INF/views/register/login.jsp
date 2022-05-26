<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/includes/links.jsp" %>

        <body class="bodybg">
<!-- <a href="/"><img src="/images/parking-lot.png" style="height:67px;width:67px;"></a> -->
            <div class="row justify-content-center">

                <div class="col-xl-10 col-lg-12 col-md-9">

                    <div class="card o-hidden border-0 shadow-lg my-5">
                        <div class="d-flex justify-content-center">
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">로그인</h1>
                                    </div>
                                    <form action="/register/login" method="post">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" name="username"
                                                id="username" placeholder="아이디">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="password" id="password" placeholder="비밀번호">
                                        </div>
                                        <c:if test="${not empty errorMsg }">
                                            <b class="mb-2">${errorMsg}</b>
                                        </c:if>
                                        <button class="btn btn-primary btn-user btn-block mt-3"
                                            id="btnLogin">Login</button>
                                    </form>
                                    <hr>

                                    <div class="text-center">
                                        <button class="btn btn-info btn-user btn-block" id="btnLogin"
                                            onclick="location.href='/register/choicejoin'">회원가입</button>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>

            </div>

            </div>