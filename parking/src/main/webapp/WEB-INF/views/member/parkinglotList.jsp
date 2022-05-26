<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@include file="/WEB-INF/views/includes/header.jsp" %>

<link rel="stylesheet" type="text/css" href="/css/parkinglotList.css" />

<div class="container mt-5 pl-0 d-flex flex-row justify-content-between">
  <div id="menu_wrap" class="bg_search">
    <div class="container ml-1 mr-1 mt-3">
      <div class="option">
        <div>
          <form onsubmit="searchPlaces(); return false;">
            검색 : <input type="text" id="keyword" size="15" />
            <button id="search" type="submit">검색하기</button>
          </form>
        </div>
      </div>
      <hr />
      <ul id="placesList"></ul>
      <div id="pagination" class="text-center"></div>
    </div>
  </div>
  <div id="map" style="width: 1000px; height: 800px"></div>
</div>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f76d9772b2d3161123b4305bff3000b7&libraries=services"></script>
<script src="/js/parkinglotList.js"></script>
