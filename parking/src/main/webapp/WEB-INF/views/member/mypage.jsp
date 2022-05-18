<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/header.jsp"%>
<script src="/js/member.js"></script>
<body>
	<div class="container mt-5">
		<input type="hidden" id="gubun" value="${member.gubun}">
		<div class="form-group">
			<label for="username">아이디:</label> <input type="text"
				class="form-control" id="username" name="username"
				value="${member.username}">
		</div>


		<div class="form-group">
			<label for="pwd">비밀번호 :</label> <input type="password"
				class="form-control" id="password" placeholder="Enter password"
				name="password">
		</div>

		<div class="form-group">
			<label for="passwordcheck">비밀번호 확인:</label> <input type="password"
				class="form-control" id="passwordcheck"
				placeholder="Enter password check" name="passwordcheck">
		</div>


		<div class="form-group">
			<label for="name">email:</label> <input type="text"
				class="form-control" id="email" name="email" value="${member.email}">
		</div>

		<div class="form-group">
			<label for="name">이름:</label> <input type="name" class="form-control"
				id="name" name="name" value="${member.name}">
		</div>

		<div class="form-group">
			<label for="tel">전화번호:</label> <input type="tel" class="form-control"
				id="tel" name="tel" value="${member.tel}">
		</div>

		<c:if test="${member.gubun == 'owner'}">
			<div class="form-group">
				<label for="bizNum">사업자번호 :</label> <input type="text"
					class="form-control" id="bizNum" name="bizNum"
					value="${member.bizNum}">
			</div>
		</c:if>

		<button type="button" class="btn btn-dark" id="btnParkinglotList"
			onclick="location.href='/member/parkinglotList'">주차장 조회</button>

		<button type="button" class="btn btn-success" id="btnUpdateAcc">update
			account</button>
		<button type="button" class="btn btn-danger" id="btnDelAcc">delete
			account</button>
		<button type="button" class="btn btn-dark" id="btnCancle"
			onclick="location.href='/'">cancle</button>

		<button type="button" class="btn btn-dark" id="btnLogout"
			onclick="location.href='/member/logout'">로그아웃</button>

	</div>
</body>