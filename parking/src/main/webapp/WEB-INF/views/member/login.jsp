<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="container mt-5">

		<form action="login" method="post">
			<div class="form-group">
				<label for="id">���̵�:</label> <input type="text" class="form-control"
					id="username" placeholder="Enter ID" name="username">
			</div>

			<div class="form-group">
				<label for="pwd">��й�ȣ:</label> <input type="password"
					class="form-control" id="password" placeholder="Enter password"
					name="password">
			</div>

			<button class="btn btn-success" id="btnLogin">Login</button>
			<c:if test="${not empty errorMsg }">
				<b>${errorMsg}</b>
			</c:if>
		</form>
	</div>
</body>
</html>