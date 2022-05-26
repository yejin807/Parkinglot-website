<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>


<div class="pagename">
	<h1>정기권 재고리스트(전체)</h1>
</div>

<div class="page">

	<div class="container mt-3">
		<table class="table table-hover">
			<tr>
				<th>주차장명</th>
				<th>1일권</th>
				<th>7일권</th>
				<th>30일권</th>
			</tr>

			<c:forEach items="${ticketlist}" var="ticket">
				<tr>
					<td>${ticket.parkLot.parkingName}</td>
					<td>${ticket.dayStock}</td>
					<td>${ticket.weekStock}</td>
					<td>${ticket.monthStock}</td>
				</tr>
			</c:forEach>
			<tr>
		</table>
	</div>
</div>