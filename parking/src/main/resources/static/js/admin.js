$(document).ready(function () {
    $("tbody").on(
        "click",
        "#bntAdminMemberDel",
        function () {
            console.log(this)
            $.ajax({
                type: "delete",
                url: "/member/admin/delete",
                data: {
                    "username": $(this).data("mid")
                }
            })
                .done(function (resp) {
                    alert("회원 삭제하였습니다." + resp)
                    location.href = "/member/admin/listAll"
                })
                .fail(function (e) {
                    alert("회원 삭제에 실패하였습니다")
                })
        }// function
    )// result.on



    $("#btnUpdateMemberByAdmin").click(function () {
        var putStr = {
            username: $("#username").val(),
            email: $("#email").val(),
            tel: $("#tel").val(),
            name: $("#name").val(),
            bizNum: $("#bizNum").val(),
            gubun: $("#gubun").val()
        }
        $.ajax({
            type: "put",
            url: "/member/admin/memberUpdate",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(putStr)
        })
            .done(function (resp) {
                alert(resp)
                location.href = "/member/admin/listAll"
            })
            .fail(function (e) {
                alert(e)
            })

    }// function
    )// result.on


})