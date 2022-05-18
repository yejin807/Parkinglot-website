<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="container mt-3">
<h3>주차장 상세보기(사장님)</h3>
	<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId}" />
	<table border="1">
		<tr>
			<td>주차장명</td>
			<td colspan="2">${parkinglot.parkingName}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${parkinglot.addr}</td>
			<td style="width: 300px; height: 300px"><div id="map" style="width: 300px; height: 300px; display: none"></div></td>
		</tr>
		<tr>
			<td>연락처</td>
			<td colspan="2">${parkinglot.parkinglotTel}</td>
		</tr>
		<tr>
			<td>운영방식</td>
			<td colspan="2">${parkinglot.operatingType}</td>
		</tr>

		<tr>
			<td>운영시간</td>
			<td colspan="2">${parkinglot.openTime} ~ ${parkinglot.closeTime}</td>
		</tr>
		<tr>
			<td>전체주차면수</td>
			<td colspan="2">${parkinglot.maxCnt}</td>
		</tr>
		<tr>
			<td>현재주차면수</td>
			<td colspan="2">${parkinglot.currentCnt}</td>
		</tr>
		<tr>
			<td>기본요금(10분당)</td>
			<td colspan="2">
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.basicFee}" var="basicFee"/>
				${basicFee}원
			</td>
		</tr>
		<tr>
			<td>일주차요금</td>
			<td colspan="2">
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.dayFee}" var="dayFee"/>
				${dayFee}원
			</td>
		</tr>
		<tr>
			<td>월주차요금</td>
			<td colspan="2">
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${parkinglot.monthFee}" var="monthFee"/>
				${monthFee}원
			</td>
		</tr>
		<tr>
			<td>주차장사진</td>
			<td colspan="2"><img alt="주차장사진" width="300px" height="300px" src="/${parkinglot.files}"/></td>
		</tr>
		<tr>
		<td colspan="3">
		<button type="button" class="btn btn-primary" onclick="javascript:location.href='/parkinglot/update/${parkinglot.parkinglotId}'">수정하기</button>
		<button type="button" class="btn btn-secondary">삭제하기</button></td>
		</tr>
	</table>
</div>
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