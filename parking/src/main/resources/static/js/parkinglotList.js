
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
// 마커를 담을 배열입니다
var markers = [];

//지도를 생성할 때 필요한 기본 옵션
var options = {
    center: new daum.maps.LatLng(35.1795543, 129.0756416), // 지도의 중심좌표
    level: 4
    //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴


// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

// ( 검색 ) 목록 요청
searchPlaces();
resizeMap();

function resizeMap() {
    var mapContainer = document.getElementById('map');
    mapContainer.style.width = '1140px';
    mapContainer.style.height = '650px';
}

// 키워드( 주소, 주차장 이름)로 장소를 검색합니다
// 검색을 요청하는 함수입니다
function searchPlaces() {

    // 검색 값을 가져온다.
    var keyword = document.getElementById('keyword').value;
    console.log("keyword >> " + keyword)

    if (keyword == "") {
        keyword = "부산";
    } else
        if (!keyword.replace(/^\s+|\s+$/g, '')) {
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

        var places = resp.parkingLot,
            respPagination = resp.parkingLotPagenation
        displayPlaces(places)
        displayPagination(keyword, respPagination)
    })
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList');
    var menuEl = document.getElementById('menu_wrap');
    var fragment = document.createDocumentFragment();
    var bounds = new kakao.maps.LatLngBounds();
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

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

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
                var coords = new daum.maps.LatLng(parkinglotInfo.wido, parkinglotInfo.gyeongdo)
                map.setCenter(coords);
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
            '   <h5><a href="/parkinglot/view/' + places.parkinglotId + '">' + places.parkingName + '</a></h5>';
    itemStr += '    <span>' + places.addr + '</span>';
    itemStr += '  <span class="tel">' + places.parkinglotTel + '</span>' + '</div>';

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
    // 이전 페이지 리스트로 이동
    //console.log(respPagination.startPage() + respPagination.endPage)
    if (respPagination.startPage > respPagination.pageSize) {
        var el2 = document.createElement('a');
        el2.href = "#";
        el2.innerHTML = '<';
        el2.onclick = (function (i) {
            return function () {
                gotoPage(keyword, i)
            }
        })(respPagination.startPage - respPagination.pageSize);
        fragment.appendChild(el2);
    }

    for (i = respPagination.startPage; i <= respPagination.endPage; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i === respPagination.currentPage) {
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

    // 다음 페이지 리스트 이동
    if (respPagination.endPage < respPagination.totalPages) {
        var el3 = document.createElement('a');
        el3.href = "#";
        el3.innerHTML = '>';
        el3.onclick = (function (i) {
            return function () {
                gotoPage(keyword, i)
            }
        })(respPagination.endPage + 1);
        fragment.appendChild(el3);
    }


    paginationEl.appendChild(fragment);
}

// 페이지 번호 클릭시 발생 이벤트
function gotoPage(keyword, i) {

    $.ajax({
        type: "get",
        url: "/member/list?keyword=" + keyword + "&page=" + (i - 1)
    }).done(function (resp) {

        var places = resp.parkingLot,
            respPagination = resp.parkingLotPagenation
        // console.log(places)
        displayPlaces(places)
        displayPagination(keyword, respPagination)
    })

}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, parkinglotInfo) {
    var content = '<div style="padding:5px;z-index:1;">' + parkinglotInfo.parkingName + '</div>'
        + '<div style="padding:5px;z-index:1;"> 기본 요금: ' + parkinglotInfo.basicFee + '</div>'
        + '<div style="padding:5px;z-index:1;"> 주차가능대수: ' + parkinglotInfo.currentCnt + '</div>'
        + '<div style="padding:5px;z-index:1;"> 종료 시간: ' + parkinglotInfo.closeTime + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}
