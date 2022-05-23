			function minutes(intime,id){
				
			const date1 = new Date();
			
			const date2 = new Date(intime);
	
			const elapsedMSec = date1.getTime() - date2.getTime(); 
			
			const elapsedMin = Math.ceil(elapsedMSec / 1000 / 60);
			//alert(elapsedMin)
			
			document.getElementById(id).innerHTML = elapsedMin;
		} 

		
		function leftday(parkid,carNum){
			
			location.href= "/car/ticketendcheck/"+carNum+"/"+parkid;
			
		}
		
		function mleftdays(endtime,id){
			
			const date3 = new Date();
			
			const date4 = new Date(endtime);
	
			const leftMSec = date4.getTime() - date3.getTime(); 
			
			const useday = Math.floor(leftMSec / (1000 * 3600 * 24));
			
			const mleftday = 30 - useday;
			document.getElementById(id).innerHTML = mleftday;
		} 

		function wleftdays(endtime,id){
					
					const date5 = new Date();
					
					const date6 = new Date(endtime);
			
					const leftMSec = date6.getTime() - date5.getTime(); 
					
					const useday = Math.floor(leftMSec / (1000 * 3600 * 24));
					
					const wleftday = 7 - useday;
					document.getElementById(id).innerHTML = wleftday;
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
				location.href = "/car/list"+parkid
				})
				.fail(function(e){
					alert("차 번호:"+num+"출차실패")
				})
}

function wordBtn(obj){
	location.href="/car/list/"+$("#parkinglotId").val()+"/?word="+obj.value;

}
