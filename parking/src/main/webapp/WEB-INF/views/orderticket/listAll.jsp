<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="pagename">
	<h1>정기권 구매내역(전체)</h1>
</div>

<div class="page">

	<div class="container mt-3">
		<table class="table">
			<tr>
				<td>티켓ID</td>
				<td>구매자(아이디)</td>
				<td>주차장명</td>
				<td>티켓종류</td>
				<td>시작일</td>
				<td>만료일</td>
			</tr>
			<c:forEach items="${orderTicketList}" var="orderticket">
				<tr>
					<td>${orderticket.ticketId}</td>
					<td>${orderticket.username}</td>
					<td>${orderticket.parkingName}</td>
					<td><c:choose>
							<c:when test="${orderticket.ticketType==1}">1일권</c:when>
							<c:when test="${orderticket.ticketType==2}">7일권</c:when>
							<c:when test="${orderticket.ticketType==3}">30일권</c:when>
						</c:choose>
					<td><fmt:formatDate value="${orderticket.buyDate}"
							pattern="yyyy-MM-dd" var="buyDate" /> ${buyDate}</td>
					<td><fmt:formatDate value="${orderticket.endDate}"
							pattern="yyyy-MM-dd" var="endDate" /> ${endDate}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>