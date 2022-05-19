<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="container mt-3">
<h3>정기권등록(사장님)</h3>
<form action="/ticket/insert" method="post">
	<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId}" />
	
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
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee}" var="dayFee"/>
				${dayFee}
			</td>
			<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee*7}" var="weekFee"/>
				${weekFee}
			</td>
			<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.monthFee}" var="monthFee"/>
				${monthFee}
			</td>
		</tr>
		<tr>
			<td>
			
				<input type="text" name="dayStock" id="dayStock" value="0"/> 매
			</td>
			<td>
				<input type="text" name="weekStock" id="weekStock" value="0"/> 매
			</td>
			<td>
				<input type="text" name="monthStock" id="monthStock" value="0"/> 매
			</td>
		</tr>
		<tr>
		<td colspan="3">
		<button type="button" class="btn btn-primary" id="btnSell">판매하기</button>
		<button type="button" class="btn btn-secondary">삭제하기</button></td>
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
		
		var dayFee = $("#dayStock").val()*${parkinglot.dayFee}; 
		var weekFee = $("#weekStock").val()*${parkinglot.dayFee}*7; 
		var monthFee = $("#monthStock").val()*${parkinglot.monthFee};
		var str = "총구매요금\n"+"1일권\n" + dayFee + "\n7일권\n" + weekFee + "\n30일권\n" + monthFee +"\n";
		if(!confirm(str+"맞습니까?")) {
			$("#dayStock").focus();
			return;
		}
		
		$("form").submit();		
	})

</script>
</body>
</html>