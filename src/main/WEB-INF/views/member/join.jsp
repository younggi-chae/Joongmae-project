<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

 <meta id="_csrf" name="_csrf"   th:content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
 

<title>Insert title here</title>

<!-- <!-- sweet Alert 플러그인 -->
<script src="http://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> -->



<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



<script type="text/javascript">
	function setCookie(cName, cValue, cDay) {
		var expire = new Date();
		expire.setDate(expire.getDate() + cDay);
		cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
		if (typeof cDay != 'undefined')
			cookies += ';expires=' + expire.toGMTString() + ';';
		document.cookie = cookies;
	}

	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("sample4_roadAddress").value = roadAddr;
						document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("sample4_extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("sample4_extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
</script>



<%@include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/style_jsh.css"
	type="text/css">



</head>
<body onload="">




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
					style="margin: auto; width: 700px">
					<span class="login100-form-title p-b-32">
						<h3>ㅇㅇ에 오신것을 환영합니다</h3>
						<br> <br> <br>
					</span>

					<form role="form"
						class="login100-form validate-form flex-sb flex-w" method="post"
						onsubmit="return validate()" action="/member/join">

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<!-- action="signupAction.sh" -->

						<span class="txt1 p-b-11"> 이름 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="이름을 입력하세요">


							<input class="input100" type="text" name="name" id="name"
								placeholder="실명을 입력하세요"> <span class="focus-input100"></span>
						</div>

						<span class="txt1 p-b-11"> 아이디 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="아이디를 입력하세요">



							<input class="input100" style="width: 61%; float: left"
								type="text" name="id" id="id" placeholder="아이디를 입력하세요">


							<input type="button" id="temp" class="login100-form-btn"
								value="중복체크">



						</div>

						<!-- 경고메세지 출력 -->
						<div id="checkMsg"></div>


						<span class="txt1 p-b-11"> 비밀번호 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="영문자,숫자,특수문자를 포함하여 8자리 이상 입력하세요">
							<span class="btn-show-pass"> <i class="fa fa-eye"></i>
							</span> <input class="input100" placeholder="영문자,숫자,특수문자를 포함 8자리"
								type="password" name="password" id="password"> <span
								class="focus-input100"></span>
						</div>


						<span class="txt1 p-b-11"> 이메일 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="이메일을 입력하세요">


							<input class="input100" type="email" placeholder="이메일을 입력하세요"
								name="email" id="email"> <span class="focus-input100"></span>
						</div>

						<span class="txt1 p-b-11"> 성별 </span>
						<div style="height: 50px"
							class="wrap-input100 validate-input m-b-12"
							data-validate="성별을 체크하세요">
							<label style="font-size: 20px"><input type="radio"
								name="sex" value="m">남자</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label style="font-size: 20px"><input
								type="radio" name="sex" value="w">여자</label> <span
								class="focus-input100"></span>
						</div>


						<span class="txt1 p-b-11"> 전화번호 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="전화번호를 입력하세요">

							<input style="width: 61%; float: left" class="input100"
								placeholder="01012345678" name="phoneNo" id="phoneNo"> <input
								type="button" class="login100-form-btn" id="sendPhoneNumber"
								value="번호확인">

						</div>

						<div class="wrap-input100 validate-input m-b-12"
							data-validate="인증번호">

							<input style="width: 61%; float: left" class="input100"
								placeholder="1234" name="certifiedNo" id="inputCertifiedNumber">




							<input type="button" class="login100-form-btn" id="checkBtn"
								value="인증번호입력">

						</div>




						<span class="txt1 p-b-11"> 우편번호 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="Password is required"
							style="height: 45px; font-family: Raleway-Medium; font-size: 1">

							<input type="text" id="sample4_postcode" placeholder="우편번호">
							<input type="button" onclick="sample4_execDaumPostcode()"
								value="우편번호 찾기">

						</div>

						<div class="wrap-input100 validate-input m-b-12"
							data-validate="Password is required"
							style="height: 45px; font-family: Raleway-Medium">

							<input type="text" id="sample4_roadAddress" name="address"
								placeholder="도로명주소">
							<!--  <input type="text"
                        id="sample4_jibunAddress" name="address" placeholder="지번주소">-->
						</div>

						<span class="txt1 p-b-11"> 상세주소 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="Password is required"
							style="height: 45px; font-family: Raleway-Medium">

							<input type="text" id="sample4_detailAddress">

						</div>



						<span class="txt1 p-b-11"> 계좌번호 </span>
						<div class="wrap-input100 validate-input m-b-12"
							data-validate="Password is required">

							<input class="input100" placeholder="계좌번호를 입력하세요" type="text"
								name="accountNo"> <span class="focus-input100"></span>
						</div>


						<div class="flex-sb-m w-full p-b-48">
							<div class="contact100-form-checkbox"></div>

							<div>
								<a href="#" class="txt3"> </a>
							</div>
						</div>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 

						<div class="container-login100-form-btn">
							<input type="submit" class="login100-form-btn" value="회원가입 하기">


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