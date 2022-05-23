<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<html xmlns:th="http://www.thymeleaf.org">
<script src="/js/parkingtest.js"></script>


<div class="jumbotron jumbotron-fluid">
	<div class="container mb-5">
		<h1>입차 목록(${count})</h1>
		<h5>주차 가능 대수(${parkinglot.currentCnt})</h5>
	</div>
	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>차번호</th>
					<th><select id="word" onchange="javascript:wordBtn(this);">
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

				<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId}" />
				
				<c:forEach items="${cars.content }" var="car" varStatus="st">
					<tr>
						
						<td>${car.carNum}
							<input type="hidden" name="basicFee" id="basicFee" value="${parkinglot.basicFee }">
							<input type="hidden" name="dayFee" id="dayFee" value="${parkinglot.dayFee }">
							<input type="hidden" name="monthFee" id="monthFee" value="${parkinglot.monthFee }">
							</td>
						<td>${car.parkingType }</td>
						<c:choose>
							<c:when test="${car.parkingType eq '월주차' }">
								<td>
								<script>leftday(${parkinglot.parkinglotId },'${car.carNum }')</script>
								종료일: ${ticket.endDate } / <span id='spanID1${st.index}'></span> 
								<script>leftdays('${ticket.endDate }' ,'spanID1${st.index}')</script>일 남음</td>
								<td>월주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn(${car.carNum },'${car.parkingType }',${parkinglot.monthFee },${parkinglot.parkinglotId })">출차</button></td>
							</c:when>
							<c:when test="${car.parkingType eq '주주차' }">
								<td><script>leftday(${parkinglot.parkinglotId },'${car.carNum }')</script>
									종료일: ${ticket.endDate } / <span id='spanID2${st.index}'></span> 
									<script>wleftdays('${ticket.endDate }' ,'spanID2${st.index}')</script>일 남음</td>
								<td>주주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn(${car.carNum },'${car.parkingType }',${parkinglot.dayFee },${parkinglot.parkinglotId })">출차</button></td>
							</c:when>
							<c:when test="${car.parkingType eq '일주차' }">
								<td>일주차</td>
								<td>일주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn(${car.carNum },'${car.parkingType }',${parkinglot.dayFee },${parkinglot.parkinglotId })">출차</button></td>
							</c:when>
							<c:otherwise>
								<td><span id='spanID3${st.index}'></span>
								<script>minutes('${car.intime }' ,'spanID3${st.index}')</script>
									분</td>
								<td><span id='spanID4${st.index}'></span>
								<script>fee('${car.intime }' ,'spanID4${st.index}',${parkinglot.basicFee })</script> 원</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outBtn(${car.carNum },'${car.intime }',${parkinglot.basicFee },${parkinglot.parkinglotId })">출차</button></td>
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
				<a href="?page=${cars.totalPages }&word=${word}">다음</a>
				</c:when>
				<c:when test="${cars.last }">
					<a href="?page=${cars.totalPages }&word=${word}">이전</a>
				</c:when>
			</c:choose>



			<c:forEach var="pageNum" begin="1" end="${cars.totalPages}" step="1">
				<a href="?page=${pageNum-1}&word=${word}">${ pageNum}</a>
			</c:forEach>

			<div>
				<form class="form-inline" action="/car/listfield" method="get">
					<input type="hidden" name="parkid" value="${parkinglot.parkinglotId }">
					<input type="hidden" name="word" value="${word }"> <input
						type="text" name="field" id="field" class="form-control"
						placeholder="차 번호 검색">
					<button class="btn btn-secondary">Search</button>

				</form>
			</div>
		</div>

	</div>
</div>