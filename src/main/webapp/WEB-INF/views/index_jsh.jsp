<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page import="org.springframework.security.core.Authentication"%>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String id = "";
    if(principal != null) {
        id = auth.getName();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<meta charset="UTF-8">
<meta name="description" content="HVAC Template">
<meta name="keywords" content="HVAC, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>PROJECT</title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700;900&display=swap"
	rel="stylesheet">

<!-- css Styles -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/magnific-popup.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/jquery-ui.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/style_jsh.css"
	type="text/css">


<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="/resources/vendor_jsh/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/fonts_jsh/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/fonts_jsh/Linearicons-Free-v1.0.0/icon-font.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/vendor_jsh/animate/animate.css">
<link rel="stylesheet" type="text/css"
	href="/resources/vendor_jsh/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/vendor_jsh/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/vendor_jsh/select2/select2.min.css">
<link rel="stylesheet" type="text/css"
	href="/resources/vendor_jsh/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/util_jsh.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/main_jsh.css">

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


 			<sec:authorize access="isAnonymous()">
				 			 <c:if test="${userId eq null}">
				<a href="/member/login" class="primary-btn">로그인/회원가입</a>
				</c:if>
					 <c:if test="${userId ne null}">
				<a href="/member/logout" class="primary-btn">로그아웃</a>
				</c:if>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				
				<form action="/member/logout" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<button class="primary-btn">로그아웃</button>

</form>

			</sec:authorize>



		</div>
		<div class="offcanvas__logo">


			<a href="/main"><img src="/resources/img/logo.png" alt=""></a>
		</div>
		<div id="mobile-menu-wrap"></div>
	</div>
	<!-- Offcanvas Menu End -->

	<!-- Header Section Begin -->
	<header class="header">

		<div class="container">
			<div class="row">
				<div class="col-lg-2">
					<div class="header__logo">
						<a href="controller_jsh/mainAction.sh"><img
							src="/resources/img/logo.png" alt=""></a>
					</div>
				</div>
				<div class="col-lg-10">
					<div class="header__nav">
						<nav class="header__menu">
							<ul>
								<li class="active"><a
									href="http://localhost:8080/controller_jsh/mainAction.sh">Home</a></li>
								<li><a
									href="http://localhost:8080/Controller_kgj/listBuyBoard.kgj">구매
										게시판</a></li>
								<li><a
									href="http://localhost:8080/Controller_kgj/insertBuyRegistrationForm.kgj">구매
										등록</a></li>


								<li><a
									href=<c:if test="${sessionScope.id !=null}">
                                "http://localhost:8080/kjj/registerFormAction.kjj"
                                </c:if>
									<c:if test="${sessionScope.id ==null}">
                                "#"
                                 </c:if>>판매
										등록</a></li>

								<c:if test="${sessionScope.id !=null}">
									<li><a
										href="/myPage/main">마이페이지</a></li>
								</c:if>

								<c:if test="${sessionScope.id ==null}">
									<li><a href="/myPage/main">마이페이지</a></li>
								</c:if>

							</ul>


						</nav>
						<div class="header__nav__widget">
							<img id="alarmImg" src="" onclick="alarmClick()">


 			<sec:authorize access="isAnonymous()">
				 			 <c:if test="${userId eq null}">
				<a href="/member/login" class="primary-btn">로그인/회원가입</a>
				</c:if>
					 <c:if test="${userId ne null}">
				<a href="/member/logout" class="primary-btn">로그아웃</a>
				</c:if>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				
				<form action="/member/logout" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<button class="primary-btn">로그아웃</button>

</form>

			</sec:authorize>

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

	<!-- Hero Section Begin -->
	<section class="hero spad set-bg"
		data-setbg="/resources/img_jsh/111.png">
		<div class="container">
			<div class="row">
				<div class="col-lg-7"></div>
				<div class="col-lg-5">
					<div class="hero__tab">
						<ul class="nav nav-tabs" role="tablist">

						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-1" role="tabpanel">
								<div class="hero__tab__form">
									<h2>팔고싶은 물건 검색</h2>
									<form
										action="http://localhost:8080/Controller_kgj/listBuyBoard.kgj">
										<div class="select-list">
											<div class="select-list-item">
												<p>대분류</p>
												<select name="bigClassifier">
													<option value="의류">의류</option>
													<option value="가전">가전</option>
												</select>
											</div>
											<div class="select-list-item">
												<p>중분류</p>
												<select name="mediumClassifier">
													<option value="상의">상의</option>
													<option value="하의">하의</option>
													<option value="악세서리">악세서리</option>
													<option value="냉장고">냉장고</option>
													<option value="에어컨">에어컨</option>
													<option value="악세서리">세탁기</option>
												</select>
											</div>
											<div class="select-list-item">
												<p>키워드1</p>
												<input type="text" name="keyword1">
											</div>
											<div class="select-list-item">
												<p>키워드2</p>
												<input type="text" name="keyword2">
											</div>
											<div class="select-list-item">
												<p>키워드3</p>
												<input type="text" name="keyword3">
											</div>
										</div>
										<div class="car-price">
											<p>Price Range:</p>
											<div class="price-range-wrap">
												<div class="price-range"></div>
												<div class="range-slider">
													<div class="price-input">
														<input type="text" id="amount" name="price">
													</div>
												</div>
											</div>
										</div>
										<button type="submit" class="site-btn">Searching</button>
									</form>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Hero Section End -->
	<br>
	<br>
	<br>
	<!-- Services Section Begin -->
	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>Our Service</h2>
						<hr>

						<p
							style="font-size: 22px; font-family: NanumSquareRoundR; color: black">구매
							물품을 찾지 말고 이젠 판매견적서를 받아보세요!</p>
						<p
							style="font-size: 22px; font-family: NanumSquareRoundR; color: black">구매
							물품 등록만 하면, 수많은 판매 견적서들이 내품으로!</p>
						<p
							style="font-size: 22px; font-family: NanumSquareRoundR; color: black">무료로
							견적서를 받아보고 거래하고 싶은 판매자와 연락해 보세요.</p>
					</div>
				</div>
			</div>
			<br>
			<br>
			<br> <br>
			<br>
			<br>
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>인기 키워드</h2>
						<hr>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<h5>자켓</h5>

						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<!--                         <img src="img/services/services-2.png" alt=""> -->
						<h5>야상</h5>
						<!--                         <p>Consectetur adipiscing elit incididunt ut labore et dolore magna aliqua. Risus commodo -->
						<!--                             viverra maecenas.</p> -->
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<!--                         <img src="img/services/services-3.png" alt=""> -->
						<h5>lg그램</h5>
						<!--                         <p>Consectetur adipiscing elit incididunt ut labore et dolore magna aliqua. Risus commodo -->
						<!--                             viverra maecenas.</p> -->
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<!--                         <img src="img/services/services-4.png" alt=""> -->
						<h5>노트북</h5>
						<!--                         <p>Consectetur adipiscing elit incididunt ut labore et dolore magna aliqua. Risus commodo -->
						<!--                             viverra maecenas.</p> -->
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<!--                         <img src="img/services/services-4.png" alt=""> -->
						<h5>후드티</h5>
						<!--                         <p>Consectetur adipiscing elit incididunt ut labore et dolore magna aliqua. Risus commodo -->
						<!--                             viverra maecenas.</p> -->
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<!--                         <img src="img/services/services-4.png" alt=""> -->
						<h5>바버 자켓</h5>
						<!--                         <p>Consectetur adipiscing elit incididunt ut labore et dolore magna aliqua. Risus commodo -->
						<!--                             viverra maecenas.</p> -->
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<!--                         <img src="img/services/services-4.png" alt=""> -->
						<h5>레노바</h5>
						<!--                         <p>Consectetur adipiscing elit incididunt ut labore et dolore magna aliqua. Risus commodo -->
						<!--                             viverra maecenas.</p> -->
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="services__item">
						<!--                         <img src="img/services/services-4.png" alt=""> -->
						<h5>스타일러</h5>
						<!--                         <p>Consectetur adipiscing elit incididunt ut labore et dolore magna aliqua. Risus commodo -->
						<!--                             viverra maecenas.</p> -->
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
			</div>
		</div>
	</section>

	</section>


	<!-- Footer Section Begin -->
	<footer class="footer set-bg"
		data-setbg="/resources/img_jsh/footer.png">
		<div class="container">
			<div>
				<div class="row">
					<div class="col-lg-6 col-md-6">
						<div class="footer__contact__title">
							<h2 style="color: black">고객 센터</h2>
						</div>
					</div>
					<div class="col-lg-6 col-md-6">
						<div class="footer__contact__option">
							<div class="option__item">
								<i class="fa fa-phone"></i> (+12) 345 678 910
							</div>
							<div class="option__item email">
								<i class="fa fa-envelope-o"></i> Colorlib@gmail.com
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-4">
					<div class="footer__about">
						<div class="footer__logo">
							<a href="#"><img src="/resources/img/footer-logo.png" alt=""></a>
						</div>
						<p>Any questions? Let us know in store at 625 Gloria Union,
							California, United Stated or call us on (+1) 96 123 8888</p>
						<div class="footer__social">
							<a href="#" class="facebook"><i class="fa fa-facebook"></i></a> <a
								href="#" class="twitter"><i class="fa fa-twitter"></i></a> <a
								href="#" class="google"><i class="fa fa-google"></i></a> <a
								href="#" class="skype"><i class="fa fa-skype"></i></a>
						</div>
					</div>
				</div>
				<div class="col-lg-2 offset-lg-1 col-md-3">
					<div class="footer__widget">
						<h5>Infomation</h5>
						<ul>
							<li><a href="#"><i class="fa fa-angle-right"></i>
									Purchase</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i>
									Payemnt</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i>
									Shipping</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i> Return</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-2 col-md-3">
					<div class="footer__widget">
						<h5>Infomation</h5>
						<ul>
							<li><a href="#"><i class="fa fa-angle-right"></i>
									Hatchback</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i> Sedan</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i> SUV</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i>
									Crossover</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="footer__brand">
						<h5>Top Brand</h5>
						<ul>
							<li><a href="#"><i class="fa fa-angle-right"></i> Abarth</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i> Acura</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i> Alfa
									Romeo</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i> Audi</a></li>
						</ul>
						<ul>
							<li><a href="#"><i class="fa fa-angle-right"></i> BMW</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i>
									Chevrolet</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i>
									Ferrari</a></li>
							<li><a href="#"><i class="fa fa-angle-right"></i> Honda</a></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="footer__copyright__text">
				<p>
					Copyright &copy;
					<script>document.write(new Date().getFullYear());</script>
					All rights reserved | This template is made with <i
						class="fa fa-heart" aria-hidden="true"></i> by <a
						href="https://colorlib.com" target="_blank">Colorlib</a>
				</p>
			</div>
			<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
		</div>
	</footer>
	<!-- Footer Section End -->

	<!-- Search Begin -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">+</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
			</form>
		</div>
	</div>
	<!-- Search End -->

	<!-- Search End -->

	<div id="myModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알람 목록</h5>
					<button type="button" onclick="closeModal()" class="close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="modalBody"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							onclick="closeModal()" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Js Plugins -->
	<script src="/resources/js/jquery-3.3.1.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/jquery.nice-select.min.js"></script>
	<script src="/resources/js/jquery-ui.min.js"></script>
	<script src="/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/resources/js/mixitup.min.js"></script>
	<script src="/resources/js/jquery.slicknav.js"></script>
	<script src="/resources/js/owl.carousel.min.js"></script>
	<script src="/resources/js/main.js"></script>
	<script src="/resources/js/main_kgj.js"></script>



</body>

</html>

<script type="text/javascript">
function readAlarm(alarmNo) {
	$.ajax({
		url : "/REST/readAlarm",
		data : "alarmNo=" + alarmNo,
		type : "GET",
		success : function(data){
			console.log(data);
		}
	})
}

function alarmClick() {
	var id = "<%=id%>";
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	var count;
	
	$('#myModal').show();
	$('#modalBody').empty();
	$.ajax({
		url : "/REST/alarmList",
		data : "id=" + id,
		type : "GET",
		success : function(data){
			$.each(data, function (i, item) {
				if (item.status == '등록') {
					var str = "<div onclick='readAlarm(" + item.alarmNo + ")'  style='background-color: aqua;margin-bottom:5px;'>";
				} else {
					var str = "<div style='background-color: white;margin-bottom:5px;'>";
				}
				if (item.buyId == id) {
					str += "<a href = 'sell/detail?sellNo=" +item.sellNo + "'>판매자 <b>" + item.sellId + "</b> 님이 ";
					str += "구매자 <b>" + item.buyId + "</b>님께 매칭되었습니다.</a><br></div>"
				} else if (item.sellId == id) {
					str += "<a href = 'buyBoard/detail?buyNo=" +item.buyNo + "&id=" + item.buyId + "'>판매자 <b>" + item.sellId + "</b> 님이 ";
					str += "구매자 <b>" + item.buyId + "</b>님께 매칭되었습니다.</a><br></div>"
				}
				
				$('#modalBody').prepend(str);
            })
		}				
	});
}

function closeModal() {
	$('#myModal').hide();
}

$(document).ready(function() {
	var id = "<%=id%>";
	var header = "${_csrf.headerName}";
	var token = "${_csrf.token}";
	var count;
	console.log(id);
	if (id != "anonymousUser") {
		$.ajax({
			url : "/REST/getAlarmCount",
			data : "id=" + id,
			type : "GET",
			success : function(result){
				count = result;
				console.log(count);
			}				
		});
		
		$.ajax({
			url : "/REST/getAlarmConfig",
			data : "id=" + id,
			type : "GET",
			success : function(result){
				var date = new Date();
				var hours = ("00" + date.getHours()).slice(-2);
				var minutes = ("00" + date.getMinutes()).slice(-2);
				var currentTime = hours + ":" + minutes;
				var startTime = result.alarmStartTime;
				var endTime = result.alarmEndTime;
				
				if (result.isAlarm == 'false') {
					$('#alarmImg').attr("src","/resources/img/alarm_icon.png");
				} else if (id == "") {
					$('#alarmImg').attr("src","");
				} else if (result.isAlarm == 'true') {
					if (currentTime >= startTime && currentTime < endTime) {
						if (count > 0) {
							$('#alarmImg').attr("src","/resources/img/new_icon.png");
						} else {
							$('#alarmImg').attr("src","/resources/img/alarm_icon.png");
						}
					} else {
						$('#alarmImg').attr("src","/resources/img/alarm_icon.png");
					}
				}
			}				
		});
	}
	
	
	
})
</script>
