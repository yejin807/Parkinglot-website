<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="container">
<h3>주차장 리스트(${principal.username}사장님)</h3>
<div>
	<a href="/parkinglot/insert">주차장등록</a> | <a href="/ticket/list" >정기권 재고리스트</a>
</div>
<table class="table table-hover">
<tr>
	<th>주차장ID</th>
	<th>주차장명</th>
	<th>주소</th>
	<th>전체주차면수</th>
	<th>주차가능면수</th>
	<th>정기권판매</th>
	<th>입차등록</th>	
</tr>
<c:forEach items="${parkinglotlist}" var="parkinglot">
	<tr>
		<td>${parkinglot.parkinglotId}</td>
		<td><a href="/parkinglot/view/${parkinglot.parkinglotId}">${parkinglot.parkingName}</a></td>
		<td>${parkinglot.addr}</td>
		<td>${parkinglot.maxCnt}</td>
		<td>${parkinglot.currentCnt}</td>
		<td>
			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='/ticket/sell/${parkinglot.parkinglotId}'">등록</button>
		</td>
		<td>
			<button type="button" class="btn btn-danger btn-sm" onclick="location.href='/car/insert/${parkinglot.parkinglotId}'">입차등록</button>
		</td>
	</tr>
</c:forEach>
</table>
</div>
</body>
</html>