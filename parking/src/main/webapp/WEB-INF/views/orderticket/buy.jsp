<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<script>
 if(${empty ticket}){
	 alert("정기권 판매등록이 되지 않았습니다.");
	 location.href="/parkinglot/listAll"; //주차장전체리스트로 이동
 }
 
 if(${empty carlist}){
	 alert("등록된 차량이 없습니다. 차량을 등록해 주세요");
	 location.href="/member/carRegister"; //차량등록 페이지로 이동
 }
</script>

<div class="container mt-3">
<h3>정기권 구매(일반)</h3>
<form action="/orderticket/buy" method="post">
	<input type="hidden" name="parkinglotId" id="parkinglotId" value="${ticket.parkLot.parkinglotId}" />
	<input type="text" name="username" id="username" value="${principal.username}" readonly />
	차량선택 
	<select name="carNum">
		<c:forEach items="${carlist}" var="car">
			<option value="${car.carNum}">${car.carNum}</option> 
		</c:forEach>
	</select>
	
	<table border="1">
		<tr>
			<td>주차장명</td>
			<td>${ticket.parkLot.parkingName}</td>
		</tr>
		<tr>
			<td colspan="3">재고수량</td>
		</tr>
		<tr>
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${ticket.dayFee}" var="dayFee"/>
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${ticket.weekFee}" var="weekFee"/>
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${ticket.monthFee}" var="monthFee"/>
			<td>1일권<br/>(${dayFee}원)</td><td>7일권<br/>(${weekFee}원)</td><td>30일권<br/>(${monthFee}원)</td>
		</tr>
		<tr>
			<td><input type="text" id="dayStock" value="${ticket.dayStock}" readonly/>매</td>
			<td><input type="text" id="weekStock" value="${ticket.weekStock}" readonly/>매</td>
			<td><input type="text" id="monthStock" value="${ticket.monthStock}" readonly/>매</td>
		</tr>
		<tr>
			<td colspan="3">구매신청</td>
		</tr>
		<tr>
			<td colspan="3">
				<select name="ticketType" id="ticketType" onChange="changeEndDate()">
					<option value="1">1일권</option>
					<option value="2">7일권</option>
					<option value="3">30일권</option>
				</select>
				시작일 <input type ="date" name="buyDate" id="buyDate" onChange="changeEndDate()"/> / 
				만료일 <input type ="date" name="endDate" id="endDate" readonly/>
			</td>
		</tr>
		<tr>
		<td colspan="3">
		<button type="button" class="btn btn-primary" id="btnBuy">구매하기</button>
		<button type="button" class="btn btn-secondary" onclick="location.href='/parkinglot/list'">주차장리스트로</button></td>
		</tr>
	</table>
	</form>
</div>
<script>

//날짜포맷 변환
function getFormatDate(date) {
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    	month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    	day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

function changeEndDate(){
	//정기권 종류
	var ticketType = $("#ticketType option:selected").val();
	//입력날짜
	var buyDate = $("#buyDate").val();
	
	var date = new Date(); //현재시간
	var minDate = getFormatDate(date); //오늘날짜
	
	if(ticketType=="1") {
		$("#endDate").val(buyDate);
	} else if(ticketType=="2") {
		date = new Date(buyDate); //선택날짜
		date.setDate(date.getDate() + 7);
		$("#endDate").val(getFormatDate(date)); //만료일 설정
	} else if(ticketType=="3"){
		date = new Date(buyDate); //선택날짜
		date.setMonth(date.getMonth() + 1);
		$("#endDate").val(getFormatDate(date)); //만료일 설정
	}
	
	if (buyDate < minDate) {
		alert("오늘 이후의 날짜를 선택해주세요");
		$("#buyDate").val(minDate);
		if(ticketType=="1") {
			$("#endDate").val(minDate);
			return;
		} else if(ticketType=="2") {
			date = new Date(minDate); //오늘날짜
			date.setDate(date.getDate() + 7);
			$("#endDate").val(getFormatDate(date)); //만료일 설정
		} else if(ticketType=="3") {
			date = new Date(minDate); //오늘날짜
			date.setMonth(date.getMonth() + 1);
			$("#endDate").val(getFormatDate(date)); //만료일 설정
		}
		return;
	}
}

$("#buyDate").val(getFormatDate(new Date()));

$("#btnBuy").click(function(){
	//정기권 종류
	var ticketType = $("#ticketType option:selected").val();
	//입력날짜
	var buyDate = $("#buyDate").val();
	
	var date = new Date(); //현재시간
	var minDate = getFormatDate(date); //오늘날짜
	
	if(ticketType=="1") {
		if($("#dayStock").val()==0) { //1일권 재고없음
			alert("1일권 구매가능수량이 없습니다.");
			return;
		}
		$("#endDate").val(buyDate);
	} else if(ticketType=="2") {
		if($("#weekStock").val()==0) { //7일권 재고없음
			alert("7일권 구매가능수량이 없습니다.");
			return;
		}
		date = new Date(buyDate); //선택날짜
		date.setDate(date.getDate() + 7);
		$("#endDate").val(getFormatDate(date)); //만료일 설정
	} else if(ticketType=="3"){
		if($("#monthStock").val()==0) { //30일권 재고없음
			alert("30일권 구매가능수량이 없습니다.");
			return;
		}
		date = new Date(buyDate); //선택날짜
		date.setMonth(date.getMonth() + 1);
		$("#endDate").val(getFormatDate(date)); //만료일 설정
	}
	
	if (buyDate < minDate) {
		alert("오늘 이후의 날짜를 선택해주세요");
		$("#buyDate").val(minDate);
		if(ticketType=="1") {
			$("#endDate").val(minDate);
			return;
		} else if(ticketType=="2") {
			date = new Date(minDate); //오늘날짜
			date.setDate(date.getDate() + 7);
			$("#endDate").val(getFormatDate(date)); //만료일 설정
		} else if(ticketType=="3") {
			date = new Date(minDate); //오늘날짜
			date.setMonth(date.getMonth() + 1);
			$("#endDate").val(getFormatDate(date)); //만료일 설정
		}
		return;
	}
	
	$("form").submit();	
})

</script>
</body>
</html>