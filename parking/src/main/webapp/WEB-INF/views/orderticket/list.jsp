<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="jumbotron jumbotron-fluid">
	<div class="container">
		<h3>정기권 구매내역</h3>
	</div>
</div>

<div class="container">
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th>주차장명</th>
				<th>차량번호</th>
				<th>티켓종류</th>
				<th>시작일</th>
				<th>만료일</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${orderTicketList}" var="orderticket">
				<tr>
					<td>${orderticket.parkingName}</td>
					<td>${orderticket.carNum}</td>
					<td><c:choose>
							<c:when test="${orderticket.ticketType==1}">1일권</c:when>
							<c:when test="${orderticket.ticketType==2}">7일권</c:when>
							<c:when test="${orderticket.ticketType==3}">30일권</c:when>
						</c:choose>
					<td><fmt:formatDate value="${orderticket.buyDate}"
							pattern="yyyy-MM-dd" var="buyDate" /> ${buyDate}</td>
					<td><fmt:formatDate value="${orderticket.endDate}"
							pattern="yyyy-MM-dd" var="endDate" /> ${endDate}</td>
					<td>
						<c:set var="date" value="<%=new java.util.Date()%>" />
						<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="today"/>
						<c:if test="${orderticket.endDate<today}"><span style="color:red">기간만료</span></c:if>
						<c:if test="${orderticket.endDate>=today}"><span style="color:blue">사용가능</span></c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>