<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>


<div class="pagename">
	<h1>주차장 전체리스트</h1>
</div>

<div class="page">
	<div class="container">
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th>주차장명</th>
					<th>주차장주소</th>
					<th>전체주차면수</th>
					<th>주차가능면수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${parkinglotlist}" var="parkinglot">
					<tr>
						<td><a href="/parkinglot/view/${parkinglot.parkinglotId}">${parkinglot.parkingName}</a></td>
						<td>${parkinglot.addr}</td>
						<td>${parkinglot.maxCnt}</td>
						<td>${parkinglot.currentCnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script>
		function funDel(id) {
			if (!confirm("정말로 삭제하시겠습니까?"))
				return;

			$.ajax({
				type : "delete",
				url : "/parkinglot/delete/" + id,
				success : function(resp) {
					if (resp == "success") {
						alert("삭제성공");
						location.href = "/parkinglot/list";
					}
				},
				error : function(e) {
					alert("error:" + e);
				}
			})
		}
	</script>

</div>