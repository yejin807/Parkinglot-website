<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>


<div class="pagename">
	<h1>정기권 판매등록</h1>
</div>

<div class="page">

<div class="container">
	<form action="/ticket/sell" method="post">
		<input type="hidden" name="parkinglotId" id="parkinglotId"
			value="${parkinglot.parkinglotId}" /> <input type="hidden"
			name="ticketId" id="ticketId" value="${ticket.ticketId}" /> <input
			type="hidden" name="username" id="username"
			value="${parkinglot.username}" /> <input type="hidden" name="dayFee"
			value="${parkinglot.dayFee}" /> <input type="hidden" name="weekFee"
			value="${parkinglot.dayFee*7}" /> <input type="hidden"
			name="monthFee" value="${parkinglot.monthFee}" />

		<table class="table">
			<tr>
				<th >주차장명</th>
				<td colspan="3">
					${parkinglot.parkingName}
				</td>
			</tr>
			<tr>
				<th rowspan="2">판매가격(원)</th>
				<td>1일권</td>
				<td>7일권</td>
				<td>30일권</td>
			</tr>
			<tr>
				<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee}" var="dayFee" /> 
					${dayFee}
				</td>
				<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee*7}" var="weekFee" />
					${weekFee}
				</td>
				<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.monthFee}" var="monthFee" />
					${monthFee}
				</td>
			</tr>
			<tr>
				<th rowspan="2">판매수량(매)</th>	
				<td>1일권</td>
				<td>7일권</td>
				<td>30일권</td>
			</tr>
			<c:if test="${empty ticket}">
				<tr>
					<td><input class="form-control input-sm mr-3" type="text"
						name="dayStock" id="dayStock" value="0" /></td>
					<td><input class="form-control input-sm mr-3" type="text"
						name="weekStock" id="weekStock" value="0" /></td>
					<td><input class="form-control input-sm mr-3" type="text"
						name="monthStock" id="monthStock" value="0" /></td>
				</tr>
			</c:if>
			<c:if test="${not empty ticket}">
				<tr>
					<td><input class="form-control input-sm mr-3" type="text"
						name="dayStock" id="dayStock" value="${ticket.dayStock}" /></td>
					<td><input class="form-control input-sm mr-3" type="text"
						name="weekStock" id="weekStock" value="${ticket.weekStock}" /></td>
					<td><input class="form-control input-sm mr-3" type="text"
						name="monthStock" id="monthStock" value="${ticket.monthStock}" />
					</td>
				</tr>
			</c:if>
			<tr>
				<td colspan="4">
					<button type="button" class="btn btn-primary" id="btnSell">등록하기</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</div>

<script>
	$("#btnSell").click(
			function() {
				if ($("#dayStock").val() == "") {
					alert("1일권 판매수량을 입력해주세요");
					$("#dayStock").focus();
					return;
				} else {
					var check = /^[0-9]{1,3}/;
					if (!check.test($("#dayStock").val())) {
						alert("숫자로 입력해 주세요");
						$("#dayStock").val("");
						$("#dayStock").focus();
						return;
					}
				}
				if ($("#weekStock").val() == "") {
					alert("7일권 판매수량을 입력해주세요");
					$("#weekStock").focus();
					return;
				} else {
					var check = /^[0-9]{1,3}/;
					if (!check.test($("#weekStock").val())) {
						alert("숫자로 입력해 주세요");
						$("#weekStock").val("");
						$("#weekStock").focus();
						return;
					}
				}
				if ($("#monthStock").val() == "") {
					alert("30일권 판매수량을 입력해주세요");
					$("#monthStock").focus();
					return;
				} else {
					var check = /^[0-9]{1,3}/;
					if (!check.test($("#monthStock").val())) {
						alert("숫자로 입력해 주세요");
						$("#monthStock").val("");
						$("#monthStock").focus();
						return;
					}
				}

				if ($("#dayStock").val() == 0 && $("#weekStock").val() == 0
						&& $("#monthStock").val() == 0) {
					if (confirm("판매재고를 등록하지 않았습니다. 리스트로 돌아가시겠습니까?")) {
						location.href = "/parkinglot/list";
					}
					$("#dayStock").focus();
					return;
				}

				$("form").submit();
			})
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>