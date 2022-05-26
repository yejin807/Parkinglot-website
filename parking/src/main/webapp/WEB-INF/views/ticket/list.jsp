<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>


<div class="pagename">
	<h1>정기권 재고현황</h1>
</div>

<div class="page">

	<div class="container">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th>주차장명</th>
					<th>1일권</th>
					<th>7일권</th>
					<th>30일권</th>
					<th>재고수정</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ticketlist}" var="ticket">
					<tr>
						<td>${ticket.parkLot.parkingName}</td>
						<td>${ticket.dayStock}</td>
						<td>${ticket.weekStock}</td>
						<td>${ticket.monthStock}</td>
						<td><button type="button" class="btn btn-secondary btn-sm"
								onclick="location.href='/ticket/sell/${ticket.parkLot.parkinglotId}'">수정</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
