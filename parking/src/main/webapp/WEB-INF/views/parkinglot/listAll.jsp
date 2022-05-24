<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="container">
<h3>주차장 리스트(전체)</h3>
<table class="table table-hover">
<tr>
	<th>주차장명</th>
	<th>주소</th>
	<th>전체주차면수</th>
	<th>주차가능면수</th>
</tr>
<c:forEach items="${parkinglotlist}" var="parkinglot">
	<tr>
		<td><a href="/parkinglot/view/${parkinglot.parkinglotId}">${parkinglot.parkingName}</a></td>
		<td>${parkinglot.addr}</td>
		<td>${parkinglot.maxCnt}</td>
		<td>${parkinglot.currentCnt}</td>
	</tr>
</c:forEach>
</table>
</div>
<script>
function funDel(id){
	if(!confirm("정말로 삭제하시겠습니까?")) return;
	
	$.ajax({
		type : "delete",
		url : "/parkinglot/delete/"+id,
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
</body>
</html>