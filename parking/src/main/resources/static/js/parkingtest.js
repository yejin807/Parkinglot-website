			function minutes(intime,id){
				
			const date1 = new Date();
			
			const date2 = new Date(intime);
	
			const elapsedMSec = date1.getTime() - date2.getTime(); 
			
			const elapsedMin = Math.ceil(elapsedMSec / 1000 / 60);
			//alert(elapsedMin)
			
			document.getElementById(id).innerHTML = elapsedMin;
		} 

		
		function mleftday(parkid,carNum,id1,id2,intime){
		$.ajax({
			type : "get",
			url : "/car/ticketendcheck/"+carNum+"/"+parkid
		})
		.done( function(resp) {
			if(resp=="non"){
				//종료일 구하기
			const today = new Date();			
			const enterday = new Date(intime);
			const endday = enterday.setMonth(enterday.getMonth() + 1);
			const outday = new Date(endday);
			const outday2 = outday.toISOString().substring(0,10);
			document.getElementById(id1).innerHTML = outday2;
				
				//남은 일수 구하기
			const leftMSec = outday.getTime() - today.getTime(); 
			const useday = Math.floor(leftMSec / (1000 * 3600 * 24));
			document.getElementById(id2).innerHTML = useday;
				
			}else{
				document.getElementById(id1).innerHTML = resp;
				
				const date3 = new Date();			
				const date4 = new Date(resp);
				const leftMSec = date4.getTime() - date3.getTime(); 			
				const useday = Math.floor(leftMSec / (1000 * 3600 * 24));			
				document.getElementById(id2).innerHTML = useday;
			
			}
				})
				.fail(function(e){
					alert("fail")
				})
			
			
		}
		
		
		function wleftday(parkid,carNum,id1,id2,intime){
		$.ajax({
			type : "get",
			url : "/car/ticketendcheck/"+carNum+"/"+parkid
		})
		.done( function(resp) {
			if(resp=="non"){
			const today = new Date();//오늘
			const enterday = new Date(intime);
			const endday = enterday.setDate(enterday.getDate() + 7);
			const outday = new Date(endday);
			const outday2 = outday.toISOString().substring(0,10);
			document.getElementById(id1).innerHTML = outday2;	
							
			const leftMSec = outday.getTime() - today.getTime(); 
			const useday = Math.floor(leftMSec / (1000 * 3600 * 24));
			document.getElementById(id2).innerHTML = useday;
				
			}else{
				document.getElementById(id1).innerHTML = resp;
				
				const date3 = new Date();			
				const date4 = new Date(resp);
				const leftMSec = date4.getTime() - date3.getTime(); 			
				const useday = Math.floor(leftMSec / (1000 * 3600 * 24));
				document.getElementById(id2).innerHTML = useday;
			
			}
				})
				.fail(function(e){
					alert("fail")
				})
			
			
		}
			
		function fee(intime,id,increase){
			
			const date7 = new Date();
			
			const date8 = new Date(intime);
	
			const leftsMSec = date7.getTime() - date8.getTime(); 
			
			const elapsedMin = Math.ceil(leftsMSec / 1000 / 60);
			
			if(elapsedMin <= 10){
				document.getElementById(id).innerHTML = increase;
				return;
			}else{
			const payfee = increase*((elapsedMin - 10)/10)+increase;
			document.getElementById(id).innerHTML = payfee;			
			}
			
			}
			
			
function outBtn(num,time,increasebasic,parkid){
	if(!confirm("차 번호:"+num+" 출차 할까요?"))
			return false;
			
	let out = new Date();
	let entertime = new Date(time);
	
	let useMSec = out.getTime() - entertime.getTime(); 
			
	let useMin = Math.ceil(useMSec / 1000 / 60);
			if(useMin <= 10){
			alert("요금은 "+increasebasic+" 원 입니다.")
				
			}else{
			let usefee = increasebasic*((useMin - 10)/10)+1500;
			alert("요금은 "+usefee+"원 입니다.")				
			}
			
	$.ajax({
		type : "DELETE",
		url : "/car/delete/"+num+"/"+parkid
		})
		.done( function(resp) {
				alert("차 번호:"+num+"출차완료")
				location.href = "/car/list/"+parkid
				})
				.fail(function(e){
					alert("차 번호:"+num+"출차실패")
				})
}

function outticketBtn(num,ticket,increaseticket,parkid){
	if(!confirm("차 번호:"+num+" 출차 할까요?"))
			return false;
			
		alert("요금은"+increaseticket+" 원 입니다.")
			
	$.ajax({
		type : "DELETE",
		url : "/car/delete/"+num+"/"+parkid
		})
		.done( function(resp) {
				alert("차 번호:"+num+"출차완료")
				location.href = "/car/list/"+parkid
				})
				.fail(function(e){
					alert("차 번호:"+num+"출차실패")
				})
}

function wordBtn(obj){
	location.href="/car/list/"+$("#parkinglotId").val()+"/?word="+obj.value;

}
