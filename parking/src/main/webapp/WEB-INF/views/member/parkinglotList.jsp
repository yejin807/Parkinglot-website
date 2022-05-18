<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/header.jsp"%>
<body>
	<div id="map" style="width: 500px; height: 400px;"></div>


	<div class="container">
		<h3>주차장 리스트(전체)</h3>
		<div>
			<a href="/parkinglot/insert">주차장등록</a>
		</div>
		<table class="table table-hover">
			<thead>
				<th>주차장명</th>
				<th>주소</th>
			</thead>
			<tbody></tbody>
		</table>
	</div>

</body>


<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f76d9772b2d3161123b4305bff3000b7&libraries=services"></script>

<script>
	var places

	$.ajax({
		type : "post",
		url : "/member/parkinglotList",
	}).done(function(resp) {
		places = resp
		console.log(places)
		var str = ""
		$.each(resp, function(index, val) {
			str += "<tr>"
			str += "<td>" + val.parkingName + "</td>"
			str += "<td>" + val.addr + "</td>"
			str += "</tr>"
		})

		$("tbody").html(str)
	})
	console.log(places)
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	// 마커를 담을 배열입니다
	var markers = [];

	//지도를 생성할 때 필요한 기본 옵션
	var options = {
		center : new daum.maps.LatLng(35.1795543, 129.0756416), // 지도의 중심좌표
		level : 3
	//지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
		// 		console.log(Object.keys(places).length)
		for (var i = 0; i < Object.keys(places); i++) {
			console.log(places[i].wido)
			// 마커를 생성하고 지도에 표시합니다
			var placePosition = new kakao.maps.LatLng(places[i].wido,
					places[i].gyeongdo), marker = addMarker(placePosition, i)
		}
	}

	function addMarker(position, idx, title) {
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
		imgOptions = {
			spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			offset : new kakao.maps.Point(13, 37)
		// 마커 좌표에 일치시킬 이미지 내에서의 좌표
		}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imgOptions), marker = new kakao.maps.Marker({
			position : position, // 마커의 위치
			image : markerImage
		});

		marker.setMap(map); // 지도 위에 마커를 표출합니다
		markers.push(marker); // 배열에 생성된 마커를 추가합니다

		return marker;
	}
</script>