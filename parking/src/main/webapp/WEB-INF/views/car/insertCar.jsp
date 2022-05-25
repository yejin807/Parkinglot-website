<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="jumbotron jumbotron-fluid">
		<div class="container">
		<h3>입차 등록</h3>
		</div>
	</div>

	<div class="container mt-5">		
			<div class="form-group">

						<input type="hidden" name="checked_car" value="">
						<input type="hidden" name="parkinglotId" id="parkinglotId" value="${parkinglot.parkinglotId }" >
						<input type="hidden" name="maxCnt" id="maxCnt" value="${parkinglot.maxCnt }" class="form-control">
						<input type="hidden" name="currentCnt" id="currentCnt" value="${parkinglot.currentCnt }" class="form-control">
         
            </div>
			<div class="row">
					<div class="col">
						<label for="carNum">차량번호 :</label> 
						<input type="text" id="carNum" placeholder="차 번호를 입력하세요" name="carNum" class="form-control">
					</div>
					<div class="col align-self-end">
						<button type="button" class="btn btn-dark" id="ticketSearch">차량 확인</button>  
					</div>		          
            </div>
		
            <div class="form-group mt-5">
            	<label for="carType">정기권 사용 :</label>
		            <div class="form-check-inline">
					  <label class="form-check-label">
					    <input type="radio" class="form-check-input" name="parkingType" value = "3" id = "parkingType" name ="parkingType">월주차
					  </label>
					</div>
					<div class="form-check-inline">
					  <label class="form-check-label">
					    <input type="radio" class="form-check-input" name="parkingType" value = "2" id = "parkingType" name ="parkingType">주주차
					  </label>
					</div>
					<div class="form-check-inline disabled">
					  <label class="form-check-label">
					    <input type="radio" class="form-check-input" name="parkingType" value = "1" id = "parkingType" name ="parkingType">일주차
					  </label>
					</div>
					<div class="form-check-inline disabled">
					  <label class="form-check-label">
					    <input type="radio" class="form-check-input" name="parkingType" value = "0" id = "parkingType" name ="parkingType" checked="checked">자유주차
					  </label>
					</div>
            </div>
            
             <button type="button" class="btn btn-dark" id="btninsert">입차</button>
             <button type="button" class="btn btn-secondary " onclick="location.href='/car/list/${parkinglot.parkinglotId}'">입차현황</button>
	</div>

		 <script>
			$("#ticketSearch").click(function(){
				$("input[name=checked_car]").val('y');

				
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
					if(resp == "-1"){
						alert("이미 입차되어 있는 차량입니다.")
						$("#carNum").focus();
						return;
					}
					if(resp=="0"){
						alert("정기권 구매 차량아닙니다.\n입차 정보를 입력하세요")
					}else if(resp=="5"){
						alert("정기권 구매 차량이지만 입차 기간이 아닙니다.")
					} else {
						alert("정기권 구매 차량입니다.")
					}
					$("input:radio[name='parkingType']:input[value='"+resp+"']").attr("checked",true)
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
			if($("input[name='checked_car']").val()==''){
		        alert('차량 확인을 해주세요.');
		        $("input[name='checked_car']").eq(0).focus();
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
					"parkingType" : $('input[name="parkingType"]:checked').val(),
					"parkinglotId": $("#parkinglotId").val()
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