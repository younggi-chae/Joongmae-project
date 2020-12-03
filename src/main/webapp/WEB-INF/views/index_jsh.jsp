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
<meta name="google-site-verification" content="pb9RN2mqNhlQVfHbO4o9zP7B9XW78fumQ9PMIDvELII" />
<meta charset="utf-8">
<title>Insert title here</title>

<meta charset="UTF-8">
<meta name="description" content="HVAC Template">
<meta name="keywords" content="HVAC, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>PROJECT</title>

<%@include file="includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/style_jsh.css"
	type="text/css">



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


	<%@include file="includes/footer.jsp"%>

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

	
 <div id="frogue-container" class="position-right-bottom" data-chatbot="b99e517a-b869-414a-aa15-4b0f2cedbc88" data-user="sk03058@nate.com" data-init-key="value"></div>

<script>
(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "https:\/\/danbee.ai/js/plugins/frogue-embed/frogue-embed.min.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'frogue-embed'));
</script> 

<div id="frogue-container" class="position-right-bottom" data-chatbot="b99e517a-b869-414a-aa15-4b0f2cedbc88" data-user="sk03058@nate.com" data-init-key="value"></div>

<script>
(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "https:\/\/danbee.ai/js/plugins/frogue-embed/frogue-embed.min.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'frogue-embed'));
</script> 

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
