$(document).ready(function(){
	
	
	$("#btnJoin").click(function(){
		
		if($("#username").val() == ""){
			alert("아이디를 입력하세요")
			$("#username").focus()
			return;
		}
		
		if($("#password").val() == ""){
			alert("비밀번호를 입력하세요")
			$("#password").focus()
			return;
		}
		
		if( $("#passwordcheck").val() != $("#password").val()){
			alert("비밀번호가 일치하지 않습니다")
			$("#password").val("")
			$("#passwordcheck").val("")
			$("#password").focus()
			return;
		}
		
		if($("#email").val() == ""){
			alert("이메일을 입력하세요")
			$("#email").focus()
			return;
		}
		
		var postStr = {
				
			"username" : $("#username").val(),
			"password" : $("#password").val(),
			"email" : $("#email").val(),
			"role" :$(":input:radio[name=role]:checked").val()
				
		}
		
		$.ajax({
			
			type : "post",
			url : "/member/join",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(postStr)
		})
		.done(function(){
			alert("회원가입 성공")
			location.href="/member/login"
		})
		
	})// btnJoin
	
	
})// document