<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<html xmlns:th="http://www.thymeleaf.org">
<script src="/js/parkingtest.js"></script>


<div class="jumbotron jumbotron-fluid">
	<div class="container mb-5">
		<h1>입차 목록(${count })</h1>
	</div>
	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>차번호</th>
					<th>차종</th>
					<th><select id="field" onchange="javascript:fieldBtn(this);">
							<option value="전체보기">주차 유형 선택</option>
							<option value="전체보기">전체보기</option>
							<option value="자유주차">자유주차</option>
							<option value="월주차">월주차</option>
							<option value="주주차">주주차</option>
							<option value="일주차">일주차</option>
					</select></th>
					<th>이용시간</th>
					<th>요금</th>
					<th>출차</th>

				</tr>
			</thead>
			<tbody>



				<c:forEach items="${cars.content }" var="car" varStatus="st">
					<tr>
						<td><a href="/car/view/${car.carNum}">${car.carNum}</a> <input
							type="hidden" id="fee" value="${car.fee }"> <input
							type="hidden" id="intime" value="${car.intime }"></td>
						<td>${car.carName }</td>
						<td>${car.parkingType }</td>
						<c:choose>
							<c:when test="${car.parkingType eq '월주차' }">
								<td><span id='spanID1${st.index}'></span>
								<script>mleftdays('${car.intime }' ,'spanID1${st.index}')</script>
									일 남음</td>
								<td>월주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn(${car.carNum },'${car.parkingType }')">출차</button></td>
							</c:when>
							<c:when test="${car.parkingType eq '주주차' }">
								<td><span id='spanID2${st.index}'></span>
								<script>wleftdays('${car.intime }' ,'spanID2${st.index}')</script>
									일 남음</td>
								<td>주주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn(${car.carNum },'${car.parkingType }')">출차</button></td>
							</c:when>
							<c:when test="${car.parkingType eq '일주차' }">
								<td>일주차</td>
								<td>일주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn(${car.carNum },'${car.parkingType }')">출차</button></td>
							</c:when>
							<c:otherwise>
								<td><span id='spanID3${st.index}'></span>
								<script>minutes('${car.intime }' ,'spanID3${st.index}')</script>
									분</td>
								<td><span id='spanID4${st.index}'></span>
								<script>fee('${car.intime }' ,'spanID4${st.index}')</script> 원</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outBtn(${car.carNum },'${car.intime }')">출차</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-between mt-5 mr-auto">
			<c:choose>
				<c:when test="${cars.first }">
				[First]
				<a href="?page=${cars.number+1 }&word=${word}">다음</a>
				</c:when>
				<c:when test="${cars.last }">
					<a href="?page=${cars.number-1 }&word=${word}">이전</a>
				</c:when>
			</c:choose>



			<c:forEach var="pageNum" begin="1" end="${cars.totalPages}" step="1">
				<a href="?page=${pageNum-1}&word=${word}">${ pageNum}</a>
			</c:forEach>

			<div>
				<form class="form-inline" action="/car/list" method="get">
					<input type="hidden" name="word" value="${word }"> <input
						type="text" name="field" id="field" class="form-control"
						placeholder="차 번호 검색">
					<button class="btn btn-secondary">Search</button>

				</form>
			</div>
		</div>

	</div>
</div>