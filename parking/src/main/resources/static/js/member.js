$(document).ready(function () {


    $("#btnJoin").click(function () {

        if ($("#bizNum").val() == "") {
            alert("사업자 번호를 입력하세요")
            $("#btnCheckBizNum").focus()
            return;
        }

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
            url: "/register/join",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(postStr)
        })
            .done(function (resp) {
                alert("회원가입이 완료 되었습니다.");
                location.href = "/register/login";
            })
            .fail(function (resp) {
                //console.log(resp)
                $(".error").text("")
                var errorMsg = resp.responseJSON;
                $("#errorId").text(errorMsg.username);
                $("#errorPw").text(errorMsg.password);
                $("#errorName").text(errorMsg.name);
                $("#errorEmail").text(errorMsg.email);
                $("#errorTel").text(errorMsg.tel);
            })

    })// btnJoin


    $("#btnUpdateAcc").click(function () {


        if ($("#bizNum").val() == "") {
            $("#errorBizNum").text("사업자 번호를 입력하세요");
            return;
        }

        var putStr = {
            "username": $("#username").val(),
            "password": $("#password").val(),
            "email": $("#email").val(),
            "tel": $("#tel").val(),
            "name": $("#name").val(),
            "bizNum": $("#bizNum").val(),

        }

        $.ajax({
            type: "PUT",
            url: "/member/update",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(putStr)
        })
            .done(function (resp) {
                alert(resp)
                alert("정보 수정되었습니다")
                location.href = "/member/mypage"
            })
            .fail(function (resp) {
                alert("정보 수정에 실패하였습니다")
                console.log("fail update account :" + resp.responseText + "/" + resp.status)

                $(".error").text("")
                var errorMsg = resp.responseJSON;
                $("#errorName").text(errorMsg.name);
                $("#errorEmail").text(errorMsg.email);
                $("#errorTel").text(errorMsg.tel);
            })

    })


    $("#btnDelAcc").click(function () {

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
            .done(function () {
                alert("success delete")
                location.href = "/"
            })
            .fail(function (request) {
                alert("fail delete")
                console.log("fail delete account :" + request.responseText + "/" + request.status)
                //location.href = "/"
            })

    })

    $("#btnUpdatePwd").click(function () {

        if ($("#password").val() == "") {
            $("#errorPw").text("비밀번호를 입력하세요");
            return;
        }

        if ($("#password").val() != $("#passwordcheck").val()) {
            $("#errorPw").text("비밀번호가 일치하지 않습니다");
            return;
        }

        var password_exp = '^(?=.*\\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}';
        if (!$("#password").val().match(password_exp)) {
            $("#errorPw").text("비밀번호는 영문과 숫자 조합으로 8 ~ 16자리까지 가능합니다.")
            return;
        }

        $.ajax({
            type: "PUT",
            url: "/member/updatePwd",
            data: {
                "password": $("#password").val()
            }
        })
            .done(function () {
                alert("비밀번호가 수정되었습니다")
                location.href = "/register/login"
            })
            .fail(function (resp) {
                alert("비밀번호 수정에 실패하였습니다")
                // console.log("fail :" + request.responseText + "/n / n " + request.status)
                // $(".error").text("")
                // var errorMsg = resp.responseJSON;
                // $("#errorPw").text(errorMsg.password);
            })
    })

    $("#btnCarRegister").click(function () {
        var postStr = {
            "carNum": $("#carNum").val(),
            "carName": $("#carName").val(),
            "carType": $(":input:radio[name=carType]:checked").val()
        }

        $.ajax({
            type: "post",
            url: "/member/carRegister",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(postStr)
        })
            .done(function (resp) {
                alert("차량등록이 완료되었습니다")
                location.href = "/member/mypage"
            })
            .fail(function (resp) {
                alert("차량등록이 실패하였습니다.")
                console.log("fail update account :" + resp.responseText + "/" + resp.status)
            })
    })

})// document