<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>


<div class="pagename">
	<h1>정기권 정보수정</h1>
</div>

<div class="page">
	<div class="container mt-3">
		<form action="/orderticket/update" method="post">
			<table class="table">
				<tr>
					<td>티켓ID</td>
					<td><input type="text" name="ticketId"
						value="${orderticket.ticketId}" readonly /></td>
				</tr>
				<tr>
					<td>주차장명</td>
					<td><input type="text" name="parkingName"
						value="${orderticket.parkLot.parkingName}" readonly /></td>
				</tr>
				<tr>
					<td>구매자(아이디)</td>
					<td><input type="text" name="username"
						value="${orderticket.member.username}" readonly /></td>
				</tr>
				<tr>
					<td colspan="2"><select name="ticketType" id="ticketType"
						onChange="changeEndDate()">
							<option value="1">1일권</option>
							<option value="2">7일권</option>
							<option value="3">30일권</option>
					</select> 시작일 <fmt:formatDate value="${orderticket.buyDate}"
							pattern="yyyy-MM-dd" var="buyDate" /> <input type="date"
						name="buyDate" id="buyDate" value="${buyDate}"
						onChange="changeEndDate()" /> / 만료일 <fmt:formatDate
							value="${orderticket.endDate}" pattern="yyyy-MM-dd" var="endDate" />
						<input type="date" name="endDate" id="endDate" value="${endDate}"
						readonly /></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" class="btn btn-primary" id="btnUpdate">수정하기</button>
						<button type="button" class="btn btn-danger"
							onclick="funDel(${orderticket.ticketId})">삭제하기</button>
						<button type="button" class="btn btn-secondary"
							onclick="location.href='/orderticket/listAll'">전체구매리스트</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

<script>

//티켓타입
$("#ticketType").val("${orderticket.ticketType}").prop("selected", true);

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


//수정하기
$("#btnUpdate").click(function(){
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
	
	$("form").submit();	
})

//삭제하기
function funDel(id){
	if(!confirm("정말로 삭제하시겠습니까?")) return;
	location.href="/orderticket/delete/"+id;	
}

</script>
</body>
</html>