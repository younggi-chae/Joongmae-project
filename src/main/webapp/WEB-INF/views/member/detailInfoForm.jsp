<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>부가정보</title>



<script type="text/javascript">
function imgUpload2(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();

		reader.onload = function(e) {
			console.log(e.target.result);
			document.getElementById("user_img").src = e.target.result;
		}

		reader.readAsDataURL(input.files[0]);
	}
}

function imgClick() {
	document.getElementById("imgUpload").click();

}
</script>

</head>
<body onload="">



	<%@include file="../includes/header.jsp"%>

	<link rel="stylesheet" href="/resources/css/style_jsh.css" type="text/css">


	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>회원가입</h2>
						<span>Sign up</span>
					</div>
				</div>
			</div>

			<div class="limiter">

				<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55"
					style="text-align: center; width: 600px">
					<span class="login100-form-title p-b-32"> 부가정보를 등록하고,<br>다른
						회원들에게 자신을 소개하세요<br> <br> <br>
					</span>

					<p align="center" style="font-size: 20px; font-family:">${member.name}님을
						소개해주세요!</p>


					<pre>
	
		</pre>
		
<%-- 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 --%>
					<img id="user_img"
						src="/resources/img_jsh/user_man.png"
						style="width: 150px; height: 150px; border-radius: 70%; overflow: hidden"
						alt="" onclick="imgClick()">


					<form role="form"  method="post" enctype="multipart/form-data"
						class="login100-form validate-form flex-sb flex-w"
						action="/member/option?${_csrf.parameterName}=${_csrf.token}">


						<input type="hidden" name="id" value="${member.id}"> 
						<input type="file" name="picture" id="imgUpload"
							onchange="imgUpload2(this)" style="display: none;"> 
							<span class="focus-input100"></span>


						<div class="wrap-input100 validate-input m-b-12"
							style="margin-top: 35px">




							<input class="input100" placeholder="한줄소개를 입력하세요" type="text"
								name="introduction">
						</div>
						<span class="focus-input100"></span>



						<div class="container-login100-form-btn" style="margin-top: 50px">

							<input type="submit" class="login100-form-btn" value="부가정보 등록">


						</div>
						<div style="margin: 0 auto">
							<br> <a href="/main">다음에 등록할래요</a>
						</div>
					</form>

				</div>
			</div>
		</div>

	</section>












	<div id="dropDownSelect1"></div>

	<%@include file="../includes/footer.jsp"%>


	<script src="/resources/js/main_jsh.js"></script>

</body>

</html>