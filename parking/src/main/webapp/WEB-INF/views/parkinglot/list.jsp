<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="container">
<h3>주차장 리스트(사장님)</h3>
<div>
	<a href="/parkinglot/insert">주차장등록</a>
</div>
<table class="table table-hover">
<tr>
	<th>주차장ID</th>
	<th>주차장명</th>
	<th>주소</th>
	<th>전체주차면수</th>
	<th>현재주차면수</th>
	<th>정기권판매</th>
	<th>비고</th>	
</tr>
<c:forEach items="${parkinglotlist}" var="parkinglot">
	<tr>
		<td>${parkinglot.parkinglotId}</td>
		<td><a href="/parkinglot/view/${parkinglot.parkinglotId}">${parkinglot.parkingName}</a></td>
		<td>${parkinglot.addr}</td>
		<td>${parkinglot.maxCnt}</td>
		<td>${parkinglot.currentCnt}</td>
		<td><button type="button" class="btn btn-primary">등록</button></td>
		<td><button type="button" class="btn btn-danger">삭제</button></td>
	</tr>
</c:forEach>

</table>
</div>
</body>
</html>