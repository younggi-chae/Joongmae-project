
(function ($) {
    "use strict";


    /*==================================================================
    [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.validate-form').on('submit',function(){
        var check = true;

        for(var i=0; i<input.length; i++) {
            if(validate(input[i]) == false){
                showValidate(input[i]);
                check=false;
            }
        }

        return check;
    });


    $('.validate-form .input100').each(function(){
        $(this).focus(function(){
           hideValidate(this);
        });
    });

    function validate (input) {
        if($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
            if($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
                return false;
            }
        }else if($(input).attr('type') == 'name' || $(input).attr('name') == 'name') {
            if($(input).val().trim().match(/^[가-힝a-zA-Z]{2,}$/) == null)      return false;
        }else if($(input).attr('name') == 'id' || $(input).attr('name') == 'id') {
            if($(input).val().trim().match(/^[a-zA-Z0-9]{4,12}$/) == null)      return false;
        }else if($(input).attr('name') == 'password' || $(input).attr('name') == 'password') {
            if($(input).val().trim().match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/) == null)      return false;
        }
      

        
        else {
            if($(input).val().trim() == ''){
                return false;
            }
        }
    }


    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }
    
    /*==================================================================
    [ Show pass ]*/
    var showPass = 0;
    $('.btn-show-pass').on('click', function(){
        if(showPass == 0) {
            $(this).next('input').attr('type','text');
            $(this).find('i').removeClass('fa-eye');
            $(this).find('i').addClass('fa-eye-slash');
            showPass = 1;
        }
        else {
            $(this).next('input').attr('type','password');
            $(this).find('i').removeClass('fa-eye-slash');
            $(this).find('i').addClass('fa-eye');
            showPass = 0;
        }
        
    });
    



})(jQuery);





$('#sendPhoneNumber').on('click',function(){


    var phoneNumber = $('#phoneNo').val();
    /*Swal.fire('인증번호 발송 완료!')*/


    $.ajax({
        type: "GET",
        url: "/member/check/sendSMS",
        data: {
            "phoneNumber" : phoneNumber
        },
      /*  beforeSend: function(xhr){
            xhr.setRequestHeader(header, token);
        },*/
        success: function(res){
           
           
       
            $('#checkBtn').click(function(){
                if($.trim(res) ==$('#inputCertifiedNumber').val()){
                    alert("인증성공");
                   /*Swal.fire(
                        '인증성공!',
                        '휴대폰 인증이 정상적으로 완료되었습니다.',
                        'success'
                    )*/

    /*                 $.ajax({
                        type: "GET",
                        url: "/update/phone",
                        data: {
                            "phoneNumber" : $('#inputPhoneNumber').val()
                        }
                    })
                    document.location.href="/home"; */
                }else{
                    /*Swal.fire({
                        icon: 'error',
                        title: '인증오류',
                        text: '인증번호가 올바르지 않습니다!',
                        footer: '<a href="#">다음에 인증하기</a>'
                    })*/
                   alert("인증실패");
                }
            })


        }//success
    })//ajax
});



$('#temp').click(function () {



    $.ajax({
        type: "GET",
        url: "/member/idCheck",
        data: {
            "id": $('#id').val()
        },
     /*   beforeSend: function(xhr){
            xhr.setRequestHeader(header, token);
        },*/
        success: function (data) {   
         
    
           if ($.trim(data) == "yes") {
                if ($('#id').val() != '') {
                   
                    $('#checkMsg').html('<p style="color:blue">사용가능한 ID 입니다!</p>');
                }
            } else if(($.trim(data) == "no") ){
                if ($('#id').val() != '') {
                   
                    $('#checkMsg').html('<p style="color:red">이미 사용중인 ID 입니다. 다른 ID를 입력하세요.</p>');
                    $('#id').val('');
                    $('#id').focus();
                }
            }
        }
    })
});

var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');
 

$.ajax({
   type:"post",
   url:"/member/auth/join",
   data:JSON.stringify(data),
   contentType:"application/json;charset=utf-8",
   dataType:"json"
   
   
}).done(function(resp){
   alert("회원가입이 완료되었습니다.");
   
});




