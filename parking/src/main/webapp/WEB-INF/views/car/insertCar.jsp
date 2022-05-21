<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body>
<h1>입차</h1>

<a href="/car/list">list</a>

<form>
<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId }">
<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId }">
<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId }">
차량번호 :<input type="text" id="carNum" placeholder="차 번호를 입력하세요" name="carNum"><br/>
<button type="button" id="carnumSearch">검색</button>
차종 :<input type="text" id="carName" placeholder="차종을 입력하세요" name="carName"><br/>
차량 종류 :  
<label for="small">소형</label><input class="carType" type="radio" value = "소형" id = "carType" name ="carType" checked> 
<label for="big">대형</label><input class="carType" type="radio" value = "대형" id = "carType" name ="carType"> <br/>



정기권 사용 :  
<label for="month">월주차</label><input class="fee" type="radio" value = "300000" id = "month" name ="fee" > 
<label for="week">주주차</label><input class="fee" type="radio" value = "100000" id = "week" name ="fee"> <br/>
<label for="day">일주차</label><input class="fee" type="radio" value = "20000" id = "day" name ="fee"> <br/>
<label for="non">사용 안함</label><input class="fee" type="radio" value = "1500" id = "non" name ="fee" checked> <br/>

<br><br>
<button type="button" class="btn btn-primary" id="btninsert">입차</button>
</form>
		 <script>
			$("#carnumSearch").click(function(){
								
				//alert($('input[name="fee"]:checked').id)
				if(!$("#carNum").val()){
					alert("차 번호를 입력하세요");
					$("#carNum").focus();
					return false;
				}		
				
				$.ajax({
					type:"get",
					url:"/car/search",
					contentType:"application/json;charset=utf-8",
					data:{"carNum" : $("#carNum").val()}
				})
				.done(function(resp){
					if(resp=="success"){
						alert("차 번호:"+$("#carNum").val()+"\n입차를 완료했습니다.")
						location.href="/car/list";
					}
				})
				.fail(function(e){
					alert("입차 실패")
				})
			})
		$("#btninsert").click(function(){
			
		
			//alert($('input[name="fee"]:checked').id)
			if(!$("#carNum").val()){
				alert("차 번호를 입력하세요");
				$("#carNum").focus();
				return false;
			}
			if(!$("#carName").val()){
				alert("차종을 입력하세요");
				$("#carName").focus();
				return false;
			}
			
			if(!confirm("차번호 확인 :"+$("#carNum").val()
					+"\n(차량정보 수정에서 차번호는 수정 하실 수 없습니다.)")){
				$("#carNum").focus();
				return false;
			}

			var dataParam = {
					"carNum" : $("#carNum").val(),
					"carName" : $("#carName").val(),
					"carType" : $('input[name="carType"]:checked').val(),
					"fee" : $('input[name="fee"]:checked').val(),
					"parkingId": $("#parkinglotId").val()
				}
			
			$.ajax({
				type:"post",
				url:"/car/insert",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(dataParam)
			})
			.done(function(resp){
				if(resp=="success"){
					alert("차 번호:"+$("#carNum").val()+"\n입차를 완료했습니다.")
					location.href="/car/list";
				}
			})
			.fail(function(e){
				alert("입차 실패")
			})
		})

		</script>
</body>
</html>