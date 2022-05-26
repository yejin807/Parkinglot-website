<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<script src="/js/parkingtest.js"></script>

<div class="pagename">
	<h1>입차 목록(${count}) / 주차 가능 대수(${parkinglot.currentCnt})</h1>
</div>
	

	<div class="page">
	
					    		<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId}" />
								<button type="button" class="btn btn-secondary mb-3"
									onclick="location.href='/car/insert/${parkinglot.parkinglotId}'">입차 등록</button>
						
		<table class="table table-hover">
			<thead>
				<tr>
					<th>차번호</th>
					<th>
					<select id="word" onchange="javascript:wordBtn(this);">
							<option value="전체보기">주차 유형 선택</option>
							<option value="전체보기">전체보기</option>
							<option value="자유주차">자유주차</option>
							<option value="월주차">월주차</option>
							<option value="주주차">주주차</option>
							<option value="일주차">일주차</option>
					</select>
					</th>
					<th>이용시간</th>
					<th>요금</th>
					<th>출차</th>

				</tr>
			</thead>
			<tbody>

				
				<c:forEach items="${cars.content }" var="car" varStatus="st">
					<tr>
						
						<td>${car.carNum}
							<input type="hidden" name="basicFee" id="basicFee" value="${parkinglot.basicFee }">
							<input type="hidden" name="dayFee" id="dayFee" value="${parkinglot.dayFee }">
							<input type="hidden" name="monthFee" id="monthFee" value="${parkinglot.monthFee }">
							<input type="hidden" name="intime" id="intime" value="${car.intime }">
							</td>
						<td>${car.parkingType }</td>
						<c:choose>
							<c:when test="${car.parkingType eq '월주차' }">
								<td>
								종료일: <span id='spanID00${st.index}'></span> / <span id='spanID1${st.index}'></span> 
								<script>mleftday(${parkinglot.parkinglotId },'${car.carNum }','spanID00${st.index}','spanID1${st.index}','${car.intime }')</script>일 남음</td>
								<td>월주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn('${car.carNum }','${car.parkingType }',${parkinglot.parkinglotId })">출차</button></td>
							</c:when>
							<c:when test="${car.parkingType eq '주주차' }">
								<td>종료일: <span id='spanID01${st.index}'></span>  / <span id='spanID2${st.index}'></span> 
								<script>wleftday(${parkinglot.parkinglotId },'${car.carNum }','spanID01${st.index}','spanID2${st.index}','${car.intime }')</script>일 남음</td>
								<td>주주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn('${car.carNum }','${car.parkingType }',${parkinglot.parkinglotId })">출차</button></td>
							</c:when>
							<c:when test="${car.parkingType eq '일주차' }">
								<td>일주차</td>
								<td>일주차</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outticketBtn('${car.carNum }','${car.parkingType }',${parkinglot.parkinglotId })">출차</button></td>
							</c:when>
							<c:otherwise>
								<td><span id='spanID3${st.index}'></span>
								<script>minutes('${car.intime }' ,'spanID3${st.index}')</script>
									분</td>
								<td><span id='spanID4${st.index}'></span>
								<script>fee('${car.intime }' ,'spanID4${st.index}',${parkinglot.basicFee })</script> 원</td>
								<td><button type="button" class="btn btn-danger"
										onclick="outBtn('${car.carNum }','${car.intime }',${parkinglot.basicFee },${parkinglot.parkinglotId })">출차</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		 <div class="outer">
		  
		    <div class="inner">
		      <c:forEach var="pageNum" begin="1" end="${cars.totalPages}" step="1">
				<a href="?page=${pageNum-1}&word=${word}"> ${ pageNum}Page </a>
				<c:if test="${ pageNum != cars.totalPages}">
			 		<div> <h3> / </h3>  </div>
			 	</c:if>
			</c:forEach>
		    </div>
		    
		    
		  </div>

			
				<form class="form-inline mt-5" action="/car/listfield" method="get">
					<input type="hidden" name="parkid" value="${parkinglot.parkinglotId }">
					<input type="hidden" name="word" value="${word }"> <input
						type="text" name="field" id="field" class="form-control"
						placeholder="차 번호 검색">
					<button class="btn btn-secondary">Search</button>

				</form>
			
		
</div>
