<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>


<div class="pagename">
	<h1>주차장 현황</h1>
</div>

<div class="page">
	<div class="container">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th>주차장명</th>
					<th>주소</th>
					<th>전체주차면수</th>
					<th>주차가능면수</th>
					<th>정기권판매</th>
					<th>입차리스트</th>
					<th>입차등록</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${parkinglotlist}" var="parkinglot">
					<tr>
						<td><a href="/parkinglot/view/${parkinglot.parkinglotId}">${parkinglot.parkingName}</a></td>
						<td>${parkinglot.addr}</td>
						<td>${parkinglot.maxCnt}</td>
						<td>${parkinglot.currentCnt}</td>
						<td>
							<button type="button" class="btn btn-primary btn-sm"
								onclick="location.href='/ticket/sell/${parkinglot.parkinglotId}'">등록</button>
						</td>
						<td>
							<button type="button" class="btn btn-secondary btn-sm"
								onclick="location.href='/car/list/${parkinglot.parkinglotId}'">입차현황</button>
						</td>
						<td>
							<button type="button" class="btn btn-danger btn-sm"
								onclick="location.href='/car/insert/${parkinglot.parkinglotId}'">입차</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
