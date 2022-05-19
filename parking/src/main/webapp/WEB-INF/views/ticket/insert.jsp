<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="container mt-3">
<h3>정기권 재고등록(사장님)</h3>

<form action="/ticket/insert" method="post">
	<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId}" />
	<input type="hidden" name="ticketId" id="ticketId" value="${ticket.ticketId}" />
	
	<table border="1">
		<tr>
			<td>주차장명</td>
			<td>${parkinglot.parkingName}</td>
		</tr>
		<tr>
			<td colspan="3">판매수량</td>
		</tr>
		<tr>
			<td>1일주차권</td><td>7일주차권</td><td>30일주차권</td>
		</tr>
		<tr>
			<td>
				<input type="hidden" name="dayFee" value="${parkinglot.dayFee}"/>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee}" var="dayFee"/>
				${dayFee}
			</td>
			<td>
				<input type="hidden" name="weekFee" value="${parkinglot.dayFee*7}"/>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee*7}" var="weekFee"/>
				${weekFee}
			</td>
			<td>
				<input type="hidden" name="monthFee" value="${parkinglot.monthFee}"/>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.monthFee}" var="monthFee"/>
				${monthFee}
			</td>
		</tr><tr>
		<c:if test="${empty ticket}">
				<td><input type="text" name="dayStock" id="dayStock" value="0"/> 매</td>
				<td><input type="text" name="weekStock" id="weekStock" value="0"/> 매</td>
				<td><input type="text" name="monthStock" id="monthStock" value="0"/> 매</td>
		</c:if>
		<c:if test="${not empty ticket}">
				<td><input type="text" name="dayStock" id="dayStock" value="${ticket.dayStock}"/> 매</td>
				<td><input type="text" name="weekStock" id="weekStock" value="${ticket.weekStock}"/> 매</td>
				<td><input type="text" name="monthStock" id="monthStock" value="${ticket.monthStock}"/> 매</td>
		</c:if>
		</tr>
		<tr>
		<td colspan="3">
		<button type="button" class="btn btn-primary" id="btnSell">등록하기</button>
		</tr>
	</table>
	</form>
</div>
<script>
$("#btnSell").click(function(){
	if($("#dayStock").val()==""){
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
	if($("#weekStock").val()==""){
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
	if($("#monthStock").val()==""){
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
	
	if($("#dayStock").val()==0 && $("#weekStock").val()==0 && $("#monthStock").val()==0 ){
		if(confirm("판매재고를 등록하지 않았습니다. 리스트로 돌아가시겠습니까?")) {
			location.href="/parkinglot/list";
		}
		$("#dayStock").focus();
		return;
	}
	
	$("form").submit();		
})

</script>
</body>
</html>