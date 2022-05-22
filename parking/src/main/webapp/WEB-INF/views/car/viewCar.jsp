<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body>
<h1>${car.carNum} 입차 정보 수정</h1>

<form>
차량번호 :<input type="text" id="carNum" name="carNum" value="${car.carNum}" readonly="readonly"><br/>
차량 종류 :  
<label for="small">소형</label><input class="carType" type="radio" value = "소형" id = "carType" name ="carType"> 
<label for="big">대형</label><input class="carType" type="radio" value = "대형" id = "carType" name ="carType"> <br/>

	<script>		
		$("input:radio[name='carType']:input[value='${car.carType}']").attr("checked",true)			
	</script>

주차 유형 :  
<label for="month">월주차</label><input class="fee" type="radio" value = "300000" id = "month" name ="fee" > 
<label for="week">주주차</label><input class="fee" type="radio" value = "100000" id = "week" name ="fee"> <br/>
<label for="day">일주차</label><input class="fee" type="radio" value = "20000" id = "day" name ="fee"> <br/>
<label for="non">자유 주차</label><input class="fee" type="radio" value = "1500" id = "non" name ="fee"> <br/>
	
	<script>		
		$("input:radio[name='fee']:input[value='${car.fee}']").attr("checked",true)			
	</script>

<br><br>
<button type="button" class="btn btn-primary" id="btnupdate">정보 수정</button>
</form>
		 <script>
		 
		 
		$("#btnupdate").click(function(){
			if(!confirm("정말 수정할까요?"))
				return false;
			
				var dataParam = {
						"carNum" : $("#carNum").val(),
						"carType" : $('input[name="carType"]:checked').val(),
						"fee" : $('input[name="fee"]:checked').val(),
						"parkingId": $("#parkinglotId").val()
				}
				$.ajax({
					type:"PUT",
					url :"/car/update/"+$("#carNum").val(),
					data : JSON.stringify(dataParam),
					contentType:"application/json;charset=utf-8",
				})
				.done(function(resp){					
						alert("차 번호:"+resp+" 수정을 완료했습니다.")
						location.href="/car/list";
				})
				.fail(function(){
					alert("실패")
				})
			//alert($('input[name="fee"]:checked').id)			
		})

		</script>
</body>
</html>