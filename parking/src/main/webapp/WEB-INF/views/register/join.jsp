<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <script src="/js/member.js"></script>

        <body>
            <div>
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


        <body class="bg-gradient-primary">

            <div class="container">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">

                        <div class="row justify-content-center">

                            <div class="col-lg-7">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                                    </div>
                                    <form class="user">
                                        <div class="form-group row">
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <input type="text" class="form-control form-control-user"
                                                    id="exampleFirstName" placeholder="First Name">
                                            </div>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control form-control-user"
                                                    id="exampleLastName" placeholder="Last Name">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <input type="email" class="form-control form-control-user"
                                                id="exampleInputEmail" placeholder="Email Address">
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-6 mb-3 mb-sm-0">
                                                <input type="password" class="form-control form-control-user"
                                                    id="exampleInputPassword" placeholder="Password">
                                            </div>
                                            <div class="col-sm-6">
                                                <input type="password" class="form-control form-control-user"
                                                    id="exampleRepeatPassword" placeholder="Repeat Password">
                                            </div>
                                        </div>
                                        <a href="login.html" class="btn btn-primary btn-user btn-block">
                                            Register Account
                                        </a>
                                        <hr>
                                        <a href="index.html" class="btn btn-google btn-user btn-block">
                                            <i class="fab fa-google fa-fw"></i> Register with Google
                                        </a>
                                        <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                            <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                        </a>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="forgot-password.html">Forgot Password?</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="login.html">Already have an account? Login!</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </body>