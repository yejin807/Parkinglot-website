<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> -->
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/includes/header.jsp" %>

    <div class="pagename">
        <h1>회원가입</h1>
    </div>

    <section class="course">

        <div class="row mt-0">
            <div class="course-col container d-flex flex-column mt-5">
                <a href="/register/join/owner">
                    <h3 class="mt-5 mb-5">주차장 사장님 회원가입</h3>
                    <img src="/images/plane-tickets.png">
                    <!-- //<div class="layer"> -->
                    <!-- //</div> -->
                </a>
            </div>
            <div class="course-col container d-flex flex-column mt-5">
                <a href="/register/join/user">
                    <h3 class="mt-5 mb-5">주차장 이용자 회원가입</h3>
                    <img src="/images/car-key.png">
                    <!-- //<div class="layer"> -->
                    <!-- //</div> -->
                </a>
            </div>


        </div>
    </section>
    </body>

</html>