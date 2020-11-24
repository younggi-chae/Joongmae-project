<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
<meta name="description" content="HVAC Template">
<meta name="keywords" content="HVAC, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>MyPage</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700;900&display=swap"
	rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/resources/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/resources/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/style_cyg.css" type="text/css">
</head>
<body>		
	<!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__widget">
            <a href="#" class="primary-btn">로그인/회원가입</a>
        </div>
        <div class="offcanvas__logo">
            <a href="./index.html"><img src="/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
    </div>   
<body>   

       <!-- Header Section Begin -->
    <header class="header">
        <div class="container">
            <div class="row">
                <div class="col-lg-2">
                    <div class="header__logo">
                        <a href="./index.html"><img src="/resources/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-10">
                    <div class="header__nav">
                        <nav class="header__menu">
                            <ul>
                                <li class="active"><a href="./index.html">Home</a></li>
                                <li><a href="Controller_kgj/listBuyBoard.kgj">구매 게시판</a></li>
                                <li><a href="./blog.html">구매 등록</a></li>
                                <li><a href="kjj/registerFormAction.kjj">판매 등록</a></li>
                                <li><a href="Mypage/mypageMainAction.cyg">마이페이지</a></li>

                            </ul>
                        </nav>
                        <div class="header__nav__widget">
                            <a href="controller_jsh/loginFormAction.sh" class="primary-btn">로그인/회원가입</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <span class="fa fa-bars"></span>
            </div>
        </div>
    </header>
    <!-- Header Section End -->
	
	<!-- Services Section Begin -->
	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>회원 정보</h2>
						<span>Member Information</span>
					</div>
				</div>
			</div>			
			<div class="row">
				<div class="col-lg-12 col-md-6 col-sm-6">
					<div class="services__item">										
				
			
			<div class="col-lg-12">
				<div class="section-title">	
					<div class="testimonial__item__author__text">			
						<h4>${member.id } 회원님</h4>									
					</div><br>					
						<div class="imgPreview">	
							<img id="regImg" class="rounded-circle" src="/resources/img/upload_cyg/s_${member.picture }" style="width: 140px; height: 140px;">							
				 	</div><br>				  
				  <div class="uploadDiv" align="center">
					<input type="file" id="uploadFile" name="picture" onchange="uploadImg(this)" style="display: none;"/>	
					<input type="button" value="프로필 사진 변경" onclick="document.getElementById('uploadFile').click();"/>
					<button id="uploadBtn">변경하기</button>				
				 </div>	
								 
				</div>				
			</div>											
			<form role="form" action="/myPage/modifyMember" method="post">		
				<input type="hidden" name="id" value="${member.id }">
				<p>이름</p><div><input type="text" name="name" value="${member.name }" placeholder="이름 변경.."></div><br>
				<p>비밀번호</p><div><input type="password" name="password" value="${member.password }" placeholder="비밀번호 변경.."></div><br>		
				<p>이메일</p><div><input type="text" name="email" value="${member.email }" placeholder="이메일 변경.."></div><br>
				<p>전화번호</p><div><input type="text" name="phoneNo" value="${member.phoneNo }" placeholder="전화번호 변경.."></div><br>				
				<p>주소</p><div><input type="text" name="address" id="sample4_jibunAddress"  value="${member.address }" placeholder="주소 변경.."></div>
						  <div> <input type="button" onclick="sample4_execDaumPostcode()" value="지역 찾기"></div><br>				
				<p>한줄소개</p><div><input type="text" name="introduction" value="${member.introduction }" placeholder="한줄소개 변경.."></div><br>				
				<input type="hidden" id="uploadResult" name="picture">
				<button id="modifyBtn" type="submit">정보수정</button>			
			</form>									
		</div>
	</div>			
</div>
		</div>
		<div align="center" id="delete">
			<a href="/myPage/deleteMember?id=${member.id }" class="primary-btn">회원탈퇴</a>
		</div>	
	</section>
		
	<!-- Services Section End -->
	
	
	<script src="/resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		
	 $(document).ready(function(){
		$('#uploadBtn').on("click", function(e){
			var formData = new FormData();
			var inputFile = $('input[name="picture"]');
			var files = inputFile[0].files
			
			console.log(files[0]);
			
			if(!checkExtension(files[0].name, files[0].size)){
				return false;
			}
			
			formData.append("uploadFile", files[0]);			
			
			$.ajax({
				url : '/myPage/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				success : function(result){	
					console.log(files[0].name);
					
					/* var preView = $('#imgPreview');
					var str = "";
					
					if(files[0] != null){
						str += '<img id="regImg" class="rounded-circle" src="/resources/img/upload_cyg/s_' + ${member.picture } + "'>'
					} else {
						str += '<img id="regImg" class="rounded-circle" src="/resources/img/upload_cyg/noImage.jpg">';
					}
					
					preView.append(str); */
					
					$('#uploadResult').attr("value", files[0].name);					
				}
			});
		});
	
	   
			
       var regex = new RegExp("(.*?)\.(txt|zip|exe|pptx|xls|xlsx|xlsm)");
	   var maxSize = 5242880;
	   
	   function checkExtension(fileName, fileSize){
		   if(fileSize >= maxSize){
			   alert("파일 사이즈 초과");
			   return false;
		   }
		   
		   if(regex.test(fileName)){
			   alert("이미지 파일이 아닙니다.")
			   return false;
		   }
		   return true;
	   }
	 });
	 
	 //프로필 사진 변경
	   function uploadImg(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					console.log(e.target.result);
					document.getElementById("regImg").src = e.target.result;
				}

				reader.readAsDataURL(input.files[0]);
			}
		} 
	 
	 	$('#uploadBtn').on("click", function(){
	 		alert("이미지가 변경되었습니다.")
	 	});
	
	 </script>
	 
	 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	 <script>
		//주소찾기 함수
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {               
	                var roadAddr = data.roadAddress; 
	                var extraRoadAddr = '';               
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }                
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }                
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	               
	                var indexOfDong = data.jibunAddress.indexOf('동');                
	                document.getElementById("sample4_jibunAddress").value = data.jibunAddress.substring(0,indexOfDong + 1);
	            
	                if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    var indexOfDong = expJibunAddr.indexOf('동');                    
	                    document.getElementById("sample4_jibunAddress").value = expJibunAddr.substring(0,indexOfDong + 1);                            
	            	}
	            }
	        }).open();
	    }	   
	</script>	
	
<%@include file="../includes/footer.jsp"%>