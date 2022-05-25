<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="jumbotron jumbotron-fluid">
	<div class="container">
		<h3>주차장 정보수정</h3>
	</div>
</div>

<div class="container">
<form action="/parkinglot/update" method="post"	enctype="multipart/form-data">
<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId}" />
	<table class="table">
		<tr>
			<th>주차장명</th>
			<td colspan="3"><input class="form-control" type="text" name="parkingName" id="parkingName" value="${parkinglot.parkingName}"/></td>
		</tr>
		<tr>
			<th rowspan="2">주차장주소</th>
			<td colspan="3">
				<button class="btn btn-primary btn-sm" type="button" onclick="sample5_execDaumPostcode()">주소 검색</button>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<input class="form-control" type="text" name="addr" id="addr" value="${parkinglot.addr}" readonly>			
				<!-- 위도/경도 -->
				<input type="hidden" name="wido" id="wido" value="${parkinglot.wido}" readonly>
				<input type="hidden" name="gyeongdo" id="gyeongdo" value="${parkinglot.gyeongdo}" readonly>
			</td>
		</tr>
		<tr>
			<th>주차장사진</th>
			<td><img alt="주차장사진" width="200px" height="200px" src="/${parkinglot.files}"/>
				<input class="form-control" type="file" name="upload" id="upload"/>
			</td>
			<th>위치(지도)</th>
			<td>
				<div id="map" style="width: 250px; height: 250px; display: none"></div>
			</td>
		</tr>
		
		<tr>
			<th>연락처</th>
			<td colspan="3"><input class="form-control" type="text" name="parkinglotTel" id="parkinglotTel" value="${parkinglot.parkinglotTel}"/></td>
		</tr>
		<tr>
			<th>운영방식</th>
			<td colspan="3">
				<div class="form-inline">
				<select class="form-control" name="operatingType" id="operatingType">
					<option value="공영">공영</option>
					<option value="민간">민간</option>
				</select>
				</div>
			</td>
		</tr>

		<tr>
			<th>운영시간</th>
			<td colspan="3">
				<div class="form-inline">
				<label class="form-lable mr-1" for="openTime">시작시간</label>
				<select class="form-control mr-3" name="openTime" id="openTime">
				<option value="06:00">06:00</option>
				<option value="07:00">07:00</option>
				<option value="08:00">08:00</option>
				<option value="09:00">09:00</option>
				<option value="10:00">10:00</option>
				<option value="11:00">11:00</option>
				<option value="12:00">12:00</option>
				</select>
				<label class="form-lable mr-1" for="closeTime">종료시간</label>
				<select class="form-control mr-3" name="closeTime" id="closeTime">
				<option value="20:00">20:00</option>
				<option value="21:00">21:00</option>
				<option value="22:00">22:00</option>
				<option value="23:00">23:00</option>
				<option value="24:00">24:00</option>
				</select>
				</div>
			</td>
		</tr>
		<tr>
			<th>전체주차면수(대)</th>
			<td colspan="3"><input class="form-control" type="text" name="maxCnt" id="maxCnt" value="${parkinglot.maxCnt}" /></td>
		</tr>
		<tr>
			<th>기본요금(10분당/원)</th>
			<td colspan="3">
			<input class="form-control" type="text" name="basicFee" id="basicFee" value="${parkinglot.basicFee}" /></td>
		</tr>
		<tr>
			<th>일주차요금(원)</th>
			<td colspan="3">
			<input class="form-control" type="text" name="dayFee" id="dayFee" value="${parkinglot.dayFee}"/></td>
		</tr>
		<tr>
			<th>월주차요금(원)</th>
			<td colspan="3">
			<input class="form-control" type="text" name="monthFee" id="monthFee" value="${parkinglot.monthFee}"/></td>
		</tr>
		<tr>
		<td colspan="4">
		<button type="submit" class="btn btn-primary" id="btnUpdate" >수정</button>
		<button type="reset" class="btn btn-secondary">취소</button></td>
		</tr>
	</table>
</form>
</div><script>
$("#btnInsert").click(function(){
	if($("#parkingName").val()==""){
		alert("주차장명을 입력해주세요");
		$("#parkingName").focus();
		return;
	}
	if($("#addr").val()==""){
		alert("주소를 입력해주세요");
		$("#addr").focus();
		return;
	}
	if($("#parkinglotTel").val()==""){
		alert("휴대폰번호를 입력해주세요");
		$("#parkinglotTel").focus();
		return;
	} else {
		var text = $("#parkinglotTel").val();
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		if(!regPhone.test(text)){
			alert("휴대폰번호 형식이 올바르지 않습니다.");
			$("#parkinglotTel").val("")
			$("#parkinglotTel").focus();
			return;
		}
	}
	if($("#maxCnt").val()==""){
		alert("전체주차면수를 입력해주세요");
		$("#maxCnt").focus();
		return;
	} else {
		var check = /^[1-9]{1}[0-9]{1,2}/;
		if (!check.test($("#maxCnt").val())) {
			alert("전체주차면수를 숫자로 입력해 주세요");
			$("#maxCnt").val("");
			$("#maxCnt").focus();
			return;
		}
	}
	if($("#basicFee").val()==""){
		alert("기본요금을 입력해주세요");
		$("#basicFee").focus();
		return;
	} else {
		var check = /^[1-9]{1}[0-9]{2,5}/;
		if (!check.test($("#basicFee").val())) {
			alert("숫자(정수)형태로 입력해주세요");
			$("#basicFee").val("");
			$("#basicFee").focus();
			return;
		}
	}
	if($("#dayFee").val()==""){
		alert("일주차요금을 입력해주세요");
		$("#dayFee").focus();
		return;
	} else {
		var check = /^[1-9]{1}[0-9]{2,5}/;
		if (!check.test($("#dayFee").val())) {
			alert("숫자(정수)형태로 입력해주세요");
			$("#dayFee").val("");
			$("#dayFee").focus();
			return;
		}
	}
	if($("#monthFee").val()==""){
		alert("월주차요금을 입력해주세요");
		$("#monthFee").focus();
		return;
	} else {
		var check = /^[1-9]{1}[0-9]{2,5}/;
		if (!check.test($("#monthFee").val())) {
			alert("숫자(정수)형태로 입력해주세요");
			$("#monthFee").val("");
			$("#monthFee").focus();
			return;
		}
	}
	
	$("form").submit();
	
});
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

function sample5_execDaumPostcode() {
	new daum.Postcode(
		{
		oncomplete : function(data) {
			var addr = data.address; // 최종 주소 변수
			// 주소 정보를 해당 필드에 넣는다.
			document.getElementById("addr").value = addr;
			// 주소로 상세 정보를 검색
			geocoder.addressSearch(data.address, function(results, status) {
			// 정상적으로 검색이 완료됐으면
			if (status === daum.maps.services.Status.OK) {
				var result = results[0]; //첫번째 결과의 값을 활용
				// 해당 주소에 대한 좌표를 받아서
				var coords = new daum.maps.LatLng(result.y, result.x);
				//위도 경도 표시
				document.getElementById('wido').value = result.y;
				document.getElementById('gyeongdo').value = result.x;
				// 지도를 보여준다.
				mapContainer.style.display = "block";
				map.relayout();
				// 지도 중심을 변경한다.
				map.setCenter(coords);
				// 마커를 결과값으로 받은 위치로 옮긴다.
				marker.setPosition(coords)
			}
		});
	}
}).open();
}

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