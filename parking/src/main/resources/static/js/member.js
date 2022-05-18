$(document).ready(function() {


	$("#btnJoin").click(function() {

		//		if($("#username").val() == ""){
		//			alert("아이디를 입력하세요")
		//			$("#username").focus()
		//			return;
		//		}
		//		
		//		if($("#password").val() == ""){
		//			alert("비밀번호를 입력하세요")
		//			$("#password").focus()
		//			return;
		//		}
		//		
		//		if( $("#passwordcheck").val() != $("#password").val()){
		//			alert("비밀번호가 일치하지 않습니다")
		//			$("#password").val("")
		//			$("#passwordcheck").val("")
		//			$("#password").focus()
		//			return;
		//		}
		//		
		//		if ($("#bizNum").val() == "") {
		//			alert("사업자 번호를 입력하세요")
		//			$("#btnCheckBizNum").focus()
		//			return;
		//		}
		//		
		var postStr = {

			"username": $("#username").val(),
			"password": $("#password").val(),
			"email": $("#email").val(),
			"tel": $("#tel").val(),
			"name": $("#name").val(),
			"bizNum": $("#bizNum").val(),
			"gubun": $("#gubun").val(),
			"role": "ROLE_USER"

		}

		$.ajax({

			type: "post",
			url: "/member/join",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify(postStr)
		})
			.done(function() {
				alert("회원가입 성공")
				location.href = "/member/login"
			})

	})// btnJoin


	$("#btnUpdateAcc").click(function() {

		var putStr = {
			"username": $("#username").val(),
			"password": $("#password").val(),
			"email": $("#email").val(),
			"tel": $("#tel").val(),
			"name": $("#name").val(),
			"bizNum": $("#bizNum").val(),

		}

		$.ajax({
			type: "put",
			url: "/member/update",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify(putStr)
		})
			.done(function(resp) {
				alert(resp)
				location.href = "/"
			})
			.fail(function(request) {
				alert("fail update account")
				console.log("fail update account :" + request.responseText + "/" + request.status)
				location.href = "/"
			})

	})


	$("#btnDelAcc").click(function() {

		if (!confirm("삭제하시겠습니까?")) {
			return;
		}

		$.ajax({
			type: "delete",
			url: "/member/delete",
			data: {
				"username": $("#username").val()
			}
		})
			.done(function() {
				alert("success delete")
				location.href = "/"
			})
			.fail(function(request) {
				alert("fail delete")
				console.log("fail delete account :" + request.responseText + "/" + request.status)
				location.href = "/"
			})

	})

})// document