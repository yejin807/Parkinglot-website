<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

        <script src="/js/admin.js"></script>
        <div class="pagename">
            <h1>회원 관리</h1>
        </div>

        <div class="page">
            <div class="container">
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th>구분</th>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>이메일</th>
                            <th>사업자번호</th>
                            <th>수정</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${memberList}" var="member">
                            <tr>
                                <td>${member.gubun}</td>
                                <td class="username">${member.username}</td>
                                <td>${member.name}</td>
                                <td>${member.tel}</td>
                                <td>${member.email}</td>
                                <c:if test="${empty member.bizNum}">
                                    <td>X</td>
                                </c:if>
                                <c:if test="${not empty member.bizNum}">
                                    <td> ${member.bizNum}</td>
                                </c:if>
                                <td>
                                    <form method="post" action="/member/admin/memberView">
                                        <button class="btn btn-primary btn-sm" value="${member.username}"
                                            id="bntAdminMemberUpdate" name="bntAdminMemberUpdate">수정</button>
                                    </form>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-secondary btn-sm" data-mid="${member.username}"
                                        id="bntAdminMemberDel">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/includes/footer.jsp" %>