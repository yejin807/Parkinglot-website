<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/header.jsp"%>
<body>
	<div class="container mt-5">

		<div class="form-group">
			<label for="memberId">아이디:</label> <input type="text"
				class="form-control" id="memberId" placeholder="아이디" name="memberId">
		</div>
		<button type="button" class="btn btn-secondary" id="btnCheckId">아이디중복확인</button>


		<div class="form-group">
			<label for="password">비밀번호:</label> <input type="password"
				class="form-control" id="password" placeholder="비밀번호"
				name="password">
		</div>

		<div class="form-group">
			<label for="passwordcheck">비밀번호 재입력:</label> <input type="password"
				class="form-control" id="checkPassword" placeholder="비밀번호 재입력">
		</div>

		<c:if test="${member.gubun == 'owner'}">
			<div class="form-group">
				<label for="bizNum">사업자번호 :</label> <input type="text"
					class="form-control" id="bizNum" placeholder="사업자번호" name="bizNum">
			</div>

			<button type="button" class="btn btn-secondary"
				id="btnCheckBizNum">사업자 번호 확인</button>

		</c:if>
		<br>
		<button type="button" class="btn btn-secondary mt-5" id="btnJoin">create
			account</button>

	</div>
</body>
</html>