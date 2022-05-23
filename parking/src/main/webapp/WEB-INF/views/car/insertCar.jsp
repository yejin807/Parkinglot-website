<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body>
<h1>입차</h1>

<a href="/car/list/${parkinglot.parkinglotId }">list</a>

<form>
<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId }">
전체<input type="text" name="maxCnt" id="maxCnt" value="${parkinglot.maxCnt }">대 / 현재
<input type="text" name="currentCnt" id="currentCnt" value="${parkinglot.currentCnt }">대 <br/>

 차량번호 :<input type="text" id="carNum" placeholder="차 번호를 입력하세요" name="carNum">
<button type="button" id="ticketSearch">티켓 유무 검색</button><br/><br/><br/>
 차량 종류 :  
<label for="small"> 소형</label><input class="carType" type="radio" value = "소형" id = "carType" name ="carType" checked> 
<label for="big"> 대형</label><input class="carType" type="radio" value = "대형" id = "carType" name ="carType"> <br/>

<script>		
	$("input:radio[name='carType']:input[value='${orderticket.car.carType}']").attr("checked",true)			
</script>

 정기권 사용 :  
<label for="month"> 월주차</label><input class="parkingType" type="radio" value = "3" id = "parkingType" name ="parkingType" > 
<label for="week"> 주주차</label><input class="parkingType" type="radio" value = "2" id = "parkingType" name ="parkingType"> 
<label for="day"> 일주차</label><input class="parkingType" type="radio" value = "1" id = "parkingType" name ="parkingType"> 
<label for="non"> 사용 안함</label><input class="parkingType" type="radio" value = "0" id = "parkingType" name ="parkingType" checked> <br/>

<script>		
	$("input:radio[name='parkingType']:input[value='${orderticket.ticketType}']").attr("checked",true)			
</script>

<br><br>
<button type="button" class="btn btn-primary" id="btninsert">입차</button>
</form>
		 <script>
			$("#ticketSearch").click(function(){

				
				if(!$("#carNum").val()){
					alert("차 번호를 입력하세요");
					$("#carNum").focus();
					return false;
				}
				$.ajax({
					type:"post",
					url:"/car/ticketcheck/"+$("#parkinglotId").val()+"/"+$("#carNum").val()
				})
				.done(function(resp){
					if(resp=="2"){
						alert("정기권 구매 차량입니다.")
					}else{
						alert("정기권 구매 차량아닙니다.\n입차 정보를 입력하세요")
					}
				})
				.fail(function(e){
					alert("실패")
				})
			})

		$("#btninsert").click(function(){
			
		
			//alert($('input[name="fee"]:checked').id)
			if(!$("#carNum").val()){
				alert("차 번호를 입력하세요");
				$("#carNum").focus();
				return false;
			}
			
			if($("#currentCnt").val()<=0){
				alert("만차입니다.")
				location.href="/car/list/"+$("#parkinglotId").val()
				return;
			}
			if(!confirm("차번호 확인 :"+$("#carNum").val()
					+"\n(차량정보 수정에서 차번호는 수정 하실 수 없습니다.)")){
				$("#carNum").focus();
				return false;
			}

			var dataParam = {
					"carNum" : $("#carNum").val(),
					"parkingType" : $('input[name="parkingType"]:checked').val()
				}
			
			$.ajax({
				type:"post",
				url:"/car/insert/"+$("#parkinglotId").val(),
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(dataParam)
			})
			.done(function(resp){
				if(resp=="success"){
					alert("차 번호:"+$("#carNum").val()+"\n입차를 완료했습니다.")
					location.href="/car/list/"+$("#parkinglotId").val();
				}
			})
			.fail(function(e){
				alert("입차 실패")
			})
		})

		</script>
</body>
</html>