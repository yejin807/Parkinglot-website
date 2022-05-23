<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>
        <style>
            .map_wrap,
            .map_wrap * {
                margin: 0;
                padding: 0;
                font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
                font-size: 12px;
            }

            .map_wrap a,
            .map_wrap a:hover,
            .map_wrap a:active {
                color: #000;
                text-decoration: none;
            }

            .map_wrap {
                position: relative;
                width: 100%;
                height: 500px;
            }

            #menu_wrap {
                position: absolute;
                top: 0;
                left: 0;
                bottom: 0;
                width: 250px;
                margin: 10px 0 30px 10px;
                padding: 5px;
                overflow-y: auto;
                background: rgba(255, 255, 255, 0.7);
                z-index: 1;
                font-size: 12px;
                border-radius: 10px;
            }

            .bg_white {
                background: #fff;
            }

            #menu_wrap hr {
                display: block;
                height: 1px;
                border: 0;
                border-top: 2px solid #5F5F5F;
                margin: 3px 0;
            }

            #menu_wrap .option {
                text-align: center;
            }

            #menu_wrap .option p {
                margin: 10px 0;
            }

            #menu_wrap .option button {
                margin-left: 5px;
            }

            #placesList li {
                list-style: none;
            }

            #placesList .item {
                position: relative;
                border-bottom: 1px solid #888;
                overflow: hidden;
                cursor: pointer;
                min-height: 65px;
            }

            #placesList .item span {
                display: block;
                margin-top: 4px;
            }

            #placesList .item h5,
            #placesList .item .info {
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            #placesList .item .info {
                padding: 10px 0 10px 55px;
            }

            #placesList .info .gray {
                color: #8a8a8a;
            }

            #placesList .info .jibun {
                padding-left: 26px;
                background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
            }

            #placesList .info .tel {
                color: #009900;
            }

            #placesList .item .markerbg {
                float: left;
                position: absolute;
                width: 36px;
                height: 37px;
                margin: 10px 0 0 10px;
                background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
            }

            #placesList .item .markerbg {
                float: left;
                position: absolute;
                width: 36px;
                height: 37px;
                margin: 10px 0 0 10px;
                background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
            }

            #placesList .item .marker_1 {
                background-position: 0 -10px;
            }

            #placesList .item .marker_2 {
                background-position: 0 -56px;
            }

            #placesList .item .marker_3 {
                background-position: 0 -102px
            }

            #placesList .item .marker_4 {
                background-position: 0 -148px;
            }

            #placesList .item .marker_5 {
                background-position: 0 -194px;
            }

            #placesList .item .marker_6 {
                background-position: 0 -240px;
            }

            #placesList .item .marker_7 {
                background-position: 0 -286px;
            }

            #placesList .item .marker_8 {
                background-position: 0 -332px;
            }

            #placesList .item .marker_9 {
                background-position: 0 -378px;
            }

            #placesList .item .marker_10 {
                background-position: 0 -423px;
            }

            #placesList .item .marker_11 {
                background-position: 0 -470px;
            }

            #placesList .item .marker_12 {
                background-position: 0 -516px;
            }

            #placesList .item .marker_13 {
                background-position: 0 -562px;
            }

            #placesList .item .marker_14 {
                background-position: 0 -608px;
            }

            #placesList .item .marker_15 {
                background-position: 0 -654px;
            }
        </style>

        <body>
            <div id="map" style="width: 500px; height: 400px;"></div>

            <div id="menu_wrap" class="bg_white">
                <div class="option">
                    <div>
                        <form onsubmit="searchPlaces(); return false;">
                            검색 : <input type="text" id="keyword" size="15">
                            <button type="submit">검색하기</button>
                        </form>
                    </div>
                </div>
                <hr>
                <ul id="placesList"></ul>
                <div id="pagination"></div>
            </div>

            <!-- <div class="container">
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
            </div> -->

        </body>


        <script
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f76d9772b2d3161123b4305bff3000b7&libraries=services"></script>

        <script>

            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            // 마커를 담을 배열입니다
            var markers = [];

            //지도를 생성할 때 필요한 기본 옵션
            var options = {
                center: new daum.maps.LatLng(35.1795543, 129.0756416), // 지도의 중심좌표
                level: 10
                //지도의 레벨(확대, 축소 정도)
            };

            var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

            // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
            var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

            // ( 검색 ) 목록 요청
            searchPlaces();

            // 키워드( 주소, 주차장 이름)로 장소를 검색합니다
            // 검색을 요청하는 함수입니다
            function searchPlaces() {

                // 검색 값을 가져온다.
                var keyword = document.getElementById('keyword').value;


                if (keyword == "") {
                    keyword = "부산";
                } else if (!keyword.replace(/^\s+|\s+$/g, '')) {
                    alert('키워드를 입력해주세요!');
                    return false;
                }

                keywordSearch(keyword)

            }

            // 키워드 검색 결과를 요청합니다.
            function keywordSearch(keyword) {
                $.ajax({
                    type: "get",
                    url: "/member/list",
                    data: {
                        "keyword": keyword,
                    }
                }).done(function (resp) {

                    var places = resp.content,
                        respPagination = resp
                    console.log(resp)
                    displayPlaces(places)
                    displayPagination(keyword, respPagination)
                })
            }

            // 검색 결과 목록과 마커를 표출하는 함수입니다
            function displayPlaces(places) {
                var listEl = document.getElementById('placesList')
                var menuEl = document.getElementById('menu_wrap')
                var fragment = document.createDocumentFragment()

                // 검색 결과 목록에 추가된 항목들을 제거합니다
                removeAllChildNods(listEl);

                // 지도에 표시되고 있는 마커를 제거합니다
                removeMarker();

                for (var i = 0; i < Object.keys(places).length; i++) {
                    // console.log(places[i].wido)
                    // 마커를 생성하고 지도에 표시합니다
                    var placePosition = new kakao.maps.LatLng(places[i].wido, places[i].gyeongdo)
                    marker = addMarker(placePosition, i)
                    itemEl = getListItem(i, places[i]);

                    // 마커와 검색결과 항목에 mouseover 했을때
                    // 해당 장소에 인포윈도우에 장소명을 표시합니다
                    // mouseout 했을 때는 인포윈도우를 닫습니다
                    (function (marker, parkinglotInfo) {
                        kakao.maps.event.addListener(marker, 'mouseover', function () {
                            displayInfowindow(marker, parkinglotInfo);
                        });

                        kakao.maps.event.addListener(marker, 'mouseout', function () {
                            infowindow.close();
                        });

                        itemEl.onmouseover = function () {
                            displayInfowindow(marker, parkinglotInfo);
                        };

                        itemEl.onmouseout = function () {
                            infowindow.close();
                        };
                    })(marker, places[i]);

                    fragment.appendChild(itemEl);
                }
                listEl.appendChild(fragment);
            }

            // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
            function addMarker(position, idx) {
                var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                    imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
                    imgOptions = {
                        spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                        spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(13, 37)
                        // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
                        imgOptions),
                    marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage
                    });

                marker.setMap(map); // 지도 위에 마커를 표출합니다
                markers.push(marker); // 배열에 생성된 마커를 추가합니다

                return marker;
            }

            // 검색결과 항목을 Element로 반환하는 함수입니다
            function getListItem(index, places) {

                var el = document.createElement('li'),
                    itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                        '<div class="info">' +
                        '   <h5>' + places.parkingName + '</h5>';


                itemStr += '    <span>' + places.addr + '</span>';


                itemStr += '  <span class="tel">' + places.parkinglotTel + '</span>' +
                    '</div>';

                el.innerHTML = itemStr;
                el.className = 'item';

                return el;
            }


            // 지도 위에 표시되고 있는 마커를 모두 제거합니다
            function removeMarker() {
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(null);
                }
                markers = [];
            }

            // 검색결과 목록의 자식 Element를 제거하는 함수입니다
            function removeAllChildNods(el) {
                while (el.hasChildNodes()) {
                    el.removeChild(el.lastChild);
                }
            }

            // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
            function displayPagination(keyword, respPagination) {
                var paginationEl = document.getElementById('pagination'),
                    fragment = document.createDocumentFragment(),
                    i;

                // 기존에 추가된 페이지번호를 삭제합니다
                // 자식노드 확인 후 삭제
                while (paginationEl.hasChildNodes()) {
                    paginationEl.removeChild(paginationEl.lastChild);
                }

                for (i = 1; i <= respPagination.totalPages; i++) {
                    var el = document.createElement('a');
                    el.href = "#";
                    el.innerHTML = i;

                    if (i === respPagination.number - 1) {
                        el.className = 'on';
                    } else {
                        el.onclick = (function (i) {
                            return function () {
                                gotoPage(keyword, i)
                            }
                        })(i);
                    }

                    fragment.appendChild(el);
                }
                paginationEl.appendChild(fragment);
            }

            // 페이지 번호 클릭시 발생 이벤트
            function gotoPage(keyword, i) {

                $.ajax({
                    type: "get",
                    url: "/member/list?keyword=" + keyword + "&page=" + (i - 1)
                }).done(function (resp) {

                    var places = resp.content,
                        pagination = resp

                    displayPlaces(places)
                    displayPagination(keyword, pagination)
                })

            }

            // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
            // 인포윈도우에 장소명을 표시합니다
            function displayInfowindow(marker, parkinglotInfo) {
                var content = '<div style="padding:5px;z-index:1;">' + parkinglotInfo.parkingName + '</div>'
                    + '<div style="padding:5px;z-index:1;"> 위치 :' + parkinglotInfo.addr + '</div>'
                    + '<div style="padding:5px;z-index:1;"> 기본 요금: ' + parkinglotInfo.basicFee + '</div>'
                    + '<div style="padding:5px;z-index:1;"> 시작 시간: ' + parkinglotInfo.openTime + '</div>'
                    + '<div style="padding:5px;z-index:1;"> 오픈 시간: ' + parkinglotInfo.closeTime + '</div>';

                infowindow.setContent(content);
                infowindow.open(map, marker);
            }
        </script>