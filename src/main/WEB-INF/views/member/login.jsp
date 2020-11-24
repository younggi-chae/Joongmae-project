<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<%@include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/style_jsh.css"
	type="text/css">





<section class="services spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="section-title">
					<h2>로그인</h2>
					<span>Sign in</span>
				</div>
			</div>
		</div>

		<div class="limiter">

			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55"
				style="float: left; clear: both">
				<span class="login100-form-title p-b-32" style="">
					<h3>ㅇㅇ에 오신것을 환영합니다</h3> <br> <br> <br>
				</span>



				<h2>
					<c:out value="${error}" />
				</h2>
				<h2>
					<c:out value="${logout}" />
				</h2>



				<form class="login100-form validate-form flex-sb flex-w"
					action="/member/login" method="post">




					<span class="txt1 p-b-11"> Username </span>
					<div class="wrap-input100 validate-input m-b-36"
						data-validate="아이디를 입력하세요">
						<input class="input100" type="text" name="username"> <span
							class="focus-input100"></span>
					</div>

					<span class="txt1 p-b-11"> Password </span>
					<div class="wrap-input100 validate-input m-b-12"
						data-validate="비밀번호를 입력하세요">
						<span class="btn-show-pass"> <i class="fa fa-eye"></i>
						</span> <input class="input100" type="password" name="password">
						<span class="focus-input100"></span>
					</div>

					<div class="flex-sb-m w-full p-b-48">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100"  type="checkbox" name="remember-me"> <label class="label-checkbox100"> Remember me </label>
						</div>

						<div>
							<a href="#" class="txt3"> Forgot Password? </a>
						</div>
					</div>

					<div class="container-login100-form-btn">
						<input type="submit" class="login100-form-btn"
							style="margin: auto" value="로그인">

					</div>


					

					<!-- #######소셜로그인 버튼 들어갈 자리 -->
					<div class="kakao_login" style="text-align: center">
						<a
							href="https://kauth.kakao.com/oauth/authorize?client_id=a714095760769a00001b4e03b10b2c3e&redirect_uri=http://localhost:8081/member/kakao_login&response_type=code"_blank">
							<img width="250px" src="/resources/img_jsh/kakao_login.png" />
						</a>
					</div>	
					
					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
				</form>




			</div>
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55"
				style="float: left; text-align: center">

				<span class="login100-form-title p-b-32" style="text-align: center">

					<h3>아직 회원이 아니신가요?</h3>

				</span> <br>
				<br>
				<br>
				<br> <input type="image" src="../resources/img_jsh/2222.jpg"
					style="width: 380px">
				<p>구매물품을 등록하고, 판매견적서를 받아보세요!</p>
				<br>
				<br>
				<br> <br>

				<div class="container-login100-form-btn">
					<a href="/member/join" class="login100-form-btn" style="margin: auto">가입하고
						서비스 요청하기</a>

				</div>

			</div>




		</div>
</section>


<section class="services spad"
	style="padding =top: 300px; padding-bottom: 500px"></section>

<div id="dropDownSelect1"></div>



<%@include file="../includes/footer.jsp"%>
</body>

</html>