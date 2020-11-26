<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

 <meta id="_csrf" name="_csrf"   th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
 

<title>Insert title here</title>

<!-- <!-- sweet Alert 플러그인 -->
<script src="http://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>




<%@include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/style_jsh.css"
	type="text/css">

<script type="text/javascript">


</script>



</head>
<body onload="">




	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>아이디/비밀번호 찾기</h2>
						<span>Sign up</span>
					</div>
				</div>
			</div>

			<div class="limiter">
				<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55"
					style="margin: auto; width: 700px">
					<span class="login100-form-title p-b-32">
				
					</span>

				
		<div class="container">
			<div class="area_inputs wow fadeIn">
				<div class="sub_title font-weight-bold ">
				
					<p>회원가입시 등록한 정보를 입력해주세요.</p>
				</div>
				
		
				
				
				<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#qwe">아이디 찾기</a>
  </li>
  <li class="nav-item">
    <a class="nav-link " data-toggle="tab" href="#asd">비밀번호 찾기</a>
  </li>
 
</ul>
<div class="tab-content">
  <div class="tab-pane fade show active" id="qwe">
    <div id="searchI">
					<div class="form-group">
						<label class="font-weight-bold" for="inputName">이름</label>
						<div>
							<input type="text" class="form-control" id="inputName" name="inputName" placeholder="ex) 고양이">
						</div>
					</div>
					<div class="form-group">
						<label class="font-weight-bold " for="inputPhoneNo">휴대폰번호</label>
						<div>
							<input type="text" class="form-control" id="inputPhoneNo" name="inputPhoneNo" placeholder="ex) 01012345678">
						</div>
					</div>
					<div class="form-group" style="text-align: center">
						<button id="searchBtn" type="button" onclick="idSearch_click()" class="btn btn-primary">확인</button>
					<a class="btn btn-danger"	href="${pageContext.request.contextPath}">취소</a>
					</div>
				</div>
    
    
  </div>
  
  
  <div class="tab-pane fade" id="asd">
    <div id="searchP" >
					<div class="form-group">
						<label class="font-weight-bold " for="inputId">아이디</label>
						<div>
							<input type="text" class="form-control" id="inputId" name="inputId_2" placeholder="ex) abcd12">
						</div>
					</div>
					<div class="form-group">
						<label class="font-weight-bold " for="inputEmail_2">이메일</label>
						<div>
							<input type="email" class="form-control" id="inputEmail_2"	name="inputEmail_2" placeholder="ex) abcd12@gmail.com">
						</div>
					</div>
					<div class="form-group" style="text-align: center">
						<button id="searchBtn2" type="button" onclick="passSearch_click()" class="btn btn-primary ">확인</button>
					<a class="btn btn-danger"	href="${pageContext.request.contextPath}">취소</a>
					
					
					
				</div>
				</div>


</div></div>

  </div>
  
</div>
				
	
				</div>
			</div>
		</div>

	</section>
	<div id="dropDownSelect1"></div>

<%@include file="../includes/footer.jsp"%>

	<script src="/resources/js/main_jsh.js"></script>


</body>

</html>