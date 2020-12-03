<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta id="_csrf" name="_csrf"   th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>Insert title here</title>



<%@include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/style_jsh.css"
	type="text/css">

<c:if test="${userId ne null}">



<section class="services spad">
	
		<div class="row">
			<div class="col-lg-12">
				<div class="section-title">
					<h2>로그인</h2>
					<span>Sign in</span>
				</div>
			</div>

			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55"
				style="float: left; clear: both">
				<span class="login100-form-title p-b-32" style="">
					<h3>중매에 오신것을 환영합니다</h3> <br> <br> <br>
				</span>

<form class="login100-form validate-form flex-sb flex-w" action="/member/login" method="post">


	${nickname}님 반갑습니다!<br/>
	<br/>
	
	<input type="hidden" name="username" value="${userId }">
	<input type="hidden" name="password" value="0000">
	
	<img alt="" src="${pic}" style="width: 350px;  border-radius: 10%; overflow: hidden">
					
<div class="container-login100-form-btn"><br><br><br>
						<input type="submit" class="login100-form-btn"
							style="margin: auto; width: 250px" value="서비스 이용하기">

					</div>


<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

</form>




			</div>
	
		</div>
</section>

</c:if>
<c:if test="${userId eq null}">


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
					<h3>중매에 오신것을 환영합니다</h3> <br> <br> <br>
				</span>




				<form class="login100-form validate-form flex-sb flex-w"
					action="/member/login" method="post">

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />


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
							<input class="input-checkbox100" id="ckb1" type="checkbox"
								name="remember-me"> <label class="label-checkbox100"
								for="ckb1"> Remember me </label>
						</div>

						<div>
							<a href="/member/findMember" class="txt3"> Forgot Password? </a>
						</div>
					</div>
<br><br><br><br>
					<div class="container-login100-form-btn"><br><br><br>
						<input type="submit" class="login100-form-btn"
							style="margin: auto; width: 250px" value="로그인">

					</div>


					
<!-- #######소셜로그인 버튼 들어갈 자리 -->
				<div class="container-login100-form-btn" style="text-align: center;">
					
						<a href="https://kauth.kakao.com/oauth/authorize?client_id=a38a9db2ca25c9b8affcea3c3f017c31&redirect_uri=http://localhost:8081/member/kakao_login&response_type=code"_blank">
							
							<img  width="250px" src="/resources/img_jsh/kakao_login.png" style="margin-left: 70px"/>
						</a>
						
						
						
						<a href="${naver_url }"><img src='/resources/img_jsh/naver_g_c_login.png' width=250 border=0 style="margin-left: 70px"></a>
					</div>	
					
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


		</div>
</section>
<section class="services spad"
	style="padding =top: 300px; padding-bottom: 500px; height: 700px"></section>
</c:if>


<div id="dropDownSelect1"></div>



<%@include file="../includes/footer.jsp"%>
</body>

</html>