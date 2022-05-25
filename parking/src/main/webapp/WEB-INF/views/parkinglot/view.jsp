<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="jumbotron jumbotron-fluid">
	<div class="container">
		<h3>주차장 상세보기</h3>
	</div>
</div>

<div class="container">
	<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId}" />
	<table class="table">
		<tr>
			<th>주차장명</th>
			<td colspan="3">${parkinglot.parkingName}</td>
		</tr>
		<tr>
			<th>주차장주소</th>
			<td colspan="3">${parkinglot.addr}</td>
		</tr>
		<tr>
			<th>주차장사진</th>
			<td><img alt="주차장사진" width="200px" height="200px" src="/${parkinglot.files}"/></td>
			<th>위치(지도)</th>
			<td>
				<div id="map" style="width: 200px; height: 200px; display: none"></div>
			</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td colspan="3">${parkinglot.parkinglotTel}</td>
		</tr>
		<tr>
			<th>운영방식</th>
			<td>${parkinglot.operatingType}</td>
			<th>운영시간</th>
			<td>${parkinglot.openTime} ~ ${parkinglot.closeTime}</td>
		</tr>
		<tr>
			<th>전체주차면수</th>
			<td>${parkinglot.maxCnt}</td>
			<th>현재주차가능대수</th>
			<td>${parkinglot.currentCnt}</td>
		</tr>
		<tr>
			<th>기본요금(10분당)</th>
			<td colspan="3">
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.basicFee}" var="basicFee"/>
				${basicFee}원
			</td>
		</tr>
		<tr>
			<th>일주차요금</th>
			<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee}" var="dayFee"/>
				${dayFee}원
			</td>
			<th>월주차요금</th>
			<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.monthFee}" var="monthFee"/>
				${monthFee}원
			</td>
		</tr>
		<!-- 수정권한 -->
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<tr>
				<td colspan="4">
	  				<button type="button" class="btn btn-primary" onclick="location.href='/parkinglot/update/${parkinglot.parkinglotId}'">수정하기</button>
	  			</td>
			</tr>
		</sec:authorize>
		<c:if test="${principal.username == parkinglot.username}">
			<tr>
				<td colspan="4">
	  				<button type="button" class="btn btn-primary" onclick="location.href='/parkinglot/update/${parkinglot.parkinglotId}'">수정하기</button>
	  				<button type="button" class="btn btn-danger" onclick="funDel(${parkinglot.parkinglotId})")>삭제</button>
	  			</td>
			</tr>
		</c:if>
		<!-- 정기권구매 -->
		<sec:authorize access="hasRole('ROLE_USER')">
		<tr>
			<td colspan="4">
			<button type="button" class="btn btn-info" onclick="location.href='/orderticket/buy/${parkinglot.parkinglotId}'">정기권구매</button>
			</td>
		</tr>
		</sec:authorize>
	</table>
</div>

<script>
function funDel(id){
	if(!confirm("정말로 삭제하시겠습니까?")) return;
	
	$.ajax({
		type : "delete",
		url : "/parkinglot/delete/"+id,
		success : function(resp) {
			if (resp == "success") {
				alert("삭제성공");
				location.href = "/parkinglot/list";
			}
		},
		error : function(e) {
			alert("error:" + e);
		}
	})
}

</script>

<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f76d9772b2d3161123b4305bff3000b7&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center : new daum.maps.LatLng(${parkinglot.wido}, ${parkinglot.gyeongdo}), // 지도의 중심좌표
		level : 4 // 지도의 확대 레벨 
	};

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
	position : new daum.maps.LatLng(${parkinglot.wido}, ${parkinglot.gyeongdo}),
	map : map
});

//해당 주소에 대한 좌표를 받아서
var coords = new daum.maps.LatLng(${parkinglot.wido}, ${parkinglot.gyeongdo});
//지도를 보여준다.
mapContainer.style.display = "block";
map.relayout();
// 지도 중심을 변경한다.
map.setCenter(coords);
// 마커를 결과값으로 받은 위치로 옮긴다.
marker.setPosition(coords)
</script>

</body>
</html>