			function minutes(intime,id){
				
			const date1 = new Date();
			
			const date2 = new Date(intime);
	
			const elapsedMSec = date1.getTime() - date2.getTime(); 
			
			const elapsedMin = Math.ceil(elapsedMSec / 1000 / 60);
			//alert(elapsedMin)
			
			document.getElementById(id).innerHTML = elapsedMin;
		} 

		function mleftdays(intime,id){
			
			const date3 = new Date();
			
			const date4 = new Date(intime);
	
			const leftMSec = date3.getTime() - date4.getTime(); 
			
			const useday = Math.floor(leftMSec / (1000 * 3600 * 24));
			
			const mleftday = 30 - useday;
			document.getElementById(id).innerHTML = mleftday;
		} 
			
		function wleftdays(intime,id){
					
					const date5 = new Date();
					
					const date6 = new Date(intime);
			
					const leftMSec = date5.getTime() - date6.getTime(); 
					
					const useday = Math.floor(leftMSec / (1000 * 3600 * 24));
					
					const wleftday = 7 - useday;
					document.getElementById(id).innerHTML = wleftday;
			}
		
		function fee(intime,id){
			
			const date7 = new Date();
			
			const date8 = new Date(intime);
	
			const leftsMSec = date7.getTime() - date8.getTime(); 
			
			const elapsedMin = Math.ceil(leftsMSec / 1000 / 60);
			
			if(elapsedMin <= 10){
				document.getElementById(id).innerHTML = "1500";
				return;
			}else{
			const payfee = 1000*((elapsedMin - 10)/10)+1500;
			document.getElementById(id).innerHTML = payfee;			
			}
			
			}
			
			
function outBtn(num,time){
	if(!confirm("차 번호:"+num+" 출차 할까요?"))
			return false;
			
	let out = new Date();
	let entertime = new Date(time);
	
	let useMSec = out.getTime() - entertime.getTime(); 
			
	let useMin = Math.ceil(useMSec / 1000 / 60);
			if(useMin <= 10){
			alert("요금은 1500원 입니다.")
				
			}else{
			let usefee = 1000*((useMin - 10)/10)+1500;
			alert("요금은 "+usefee+"원 입니다.")				
			}
			
	$.ajax({
		type : "DELETE",
		url : "/car/delete/"+num
		})
		.done( function(resp) {
				alert("차 번호:"+num+"출차완료")
				location.href = "/car/list"
				})
				.fail(function(e){
					alert("차 번호:"+num+"출차실패")
				})
}

function outticketBtn(num,ticket){
	if(!confirm("차 번호:"+num+" 출차 할까요?"))
			return false;
			
	if (ticket == "월주차"){
		alert("요금은 300,000원 입니다.")
	} else if(ticket == "주주차"){
		alert("요금은 100,000원 입니다.")
	} else{
		alert("요금은 50,000원 입니다.")
	}
			
			
	$.ajax({
		type : "DELETE",
		url : "/car/delete/"+num
		})
		.done( function(resp) {
				alert("차 번호:"+num+"출차완료")
				location.href = "/list"
				})
				.fail(function(e){
					alert("차 번호:"+num+"출차실패")
				})
}

function fieldBtn(obj){
	location.href="/car/list?word="+obj.value;

}
