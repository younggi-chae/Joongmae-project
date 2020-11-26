<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String id = "";
    if(principal != null) {
        id = auth.getName();
    }
%>
<%@include file="../includes/header.jsp"%>

	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>거래내역 확인</h2>
						<span>Transactional Information</span>
					</div>
				</div>
			</div>
		</div>

		<!-- Car Section Begin -->
		<div class="container">
			<div class="row">
				<div class="col-lg-12"></div>
				<div class="col-lg-12">
					<div class="car__filter__option"
						style="height: 74px; background-color: white;">
						<div class="row">
							<div class="col-lg-8 col-md-6">
								<div class="car__filter__option__item car__filter__option__item--left">
									<select class="selectDeal">
										<option id="whole" value="whole">전체</option>
										<option id="progress" value="progress">진행중</option>
										<option id="complete" value="complete">거래완료</option>
									</select>
								</div>
							</div>							 
						</div>
					</div>
					<div class="row" id="dealList">
						
					</div>					
					<div class='pagination__option' id="pagenation">
					
					</div>
				</div>
			</div>			
		</div>
	</section>
	<!-- Car Section End -->
	
	<!-- modal창 정보 -->	
	<!--  큰창:<div class="modal-dialog"> 작은창 :<div class="modal-dialog modal-sm">  -->		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">							
						<h4 class="modal-title" id="myModalLabel">거래 상세보기</h4>
					</div>
					<div class="modal-body">
					
					</div>
					<div class="modal-footer">
					<form action="/REST/insertReview" method="post" id="reviewBtn" style="border: 1;">
						<span id="star1" onclick="star1Click()">★</span>
						<span id="star2" onclick="star2Click()">★</span>
						<span id="star3" onclick="star3Click()">★</span>
						<span id="star4" onclick="star4Click()">★</span>
						<span id="star5" onclick="star5Click()">★</span>
						<input type="text" name="score" id="starScore" value="5" readonly="readonly" style="width: 10px;">점
						<br>
						<textarea name="contents" style="border: solid;border-width: thin;width: 250px;"></textarea>
						<input type="hidden" name="id" id="reviewId" value="<%=id%>">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						<input type="submit" class="btn btn-primary" value="리뷰쓰기">
					</form>
					<form action="" id="deliveryBtn" style="border: 1;">
						<input type="text" id="deliveryNo" style="border: solid;border-width: thin;width: 250px;">
						<input type="submit" class="btn btn-primary" value="송장 번호 입력">
					</form>
					<form action="" id="deliveryModBtn" style="border: 1;">
						<input type="text" id="deliveryModNo" style="border: solid;border-width: thin;width: 250px;">
						<input type="submit" class="btn btn-primary" value="송장 번호 수정">
					</form>
					<button type="button" class="btn btn-primary" id="depositBtn" onclick="deposit()">입금 완료</button>
					<button type="button" class="btn btn-primary" id="deliveryInfoBtn" onclick="deliveryInfo()">송장 번호 조회</button>
						<button type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>							
					</div>
				</div>					
			</div>				
		  </div>			
	<!-- /.modal -->	


<script src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">		
	
	
	var statusCheck = "";

	$(document).ready(function(){		
		//리스트 출력
		statusCheck = "whole";
		dealList(pageNum);	
	
	//진행중, 거래완료 검색
	 $(".selectDeal").on("change", function(){
		if($(".selectDeal option:selected").val() == 'whole'){
			statusCheck = "whole";
			dealList(pageNum);	
		} else if($(".selectDeal option:selected").val() == 'complete'){
			statusCheck = "complete";
			selectDealList(pageNum, "완료");	
		} else if($(".selectDeal option:selected").val() == 'progress'){
			statusCheck = "progress";
			selectDealList(pageNum, "진행중");	
		}	
	   }); 
	}); 
	
	
	//리스트 Ajax
	function dealList(page){
		var str = "";
		var param = new Object();
		param.page = page || 1;		
				
		$.ajax({
			url : "/myPage/dealListAjax/" + page,
			dataType : "json",
			data : param,
			type : "GET",
			success : function(result){						
				var dealCnt = result.dealCnt;
				 $('#dealList').html("");		
				//Initialize  owl-carousel Plugin			
				 result.list.forEach(function(element){		
					
					str =  '<div class="col-lg-4 col-md-4"><div class="car__item">';						
					str += '<div class="car__item__pic__slider">';
					if(element.picture != null){
					  	str += '<img style="height: 330px;" src="/resources/img/upload_cyg/'+element.picture+'"></div>';
					  } else {
						str += '<img style="height: 330px;" src="/resources/img/upload_cyg/noImage.jpg"></div>';	  
					  }
					str += '<div class="car__item__text"><div class="car__item__text__inner">';
					str += '<div class="label-date">' + element.buyId +'</div>';
					str += '<div class="label-date">' + element.sellId +'</div>';
					str += '<h5><input id="modalNo" name="modalNo" type="hidden" value="' + element.dealNo +'">';
					str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal" style="font-size: 25px;">' + element.itemName +'</a>';
					str += '&emsp;&emsp;&emsp;&emsp;<span>'+ formatDate(element.regDate) +'</span></h5>';
					str += '<ul><li><span>'+ element.keyword1 +'</span></li><li><span>'+ element.keyword2 +'</span></li>';
					str += '<li><span>'+ element.keyword3 +'</span></li></ul></div>';
					if(element.status === "진행중"){
						str += '<div class="car__item__price"><span id="statusColor" class="car-option">'+ element.status+'</span>';
					} else {
						str += '<div class="car__item__price"><span id="statusColor" class="car-option sale">'+ element.status+'</span>';
					}													
					str += '<h6 style="font-size: 18px;">'+ commas(element.price) +'원</h6></div></div></div></div>';			

					 	$('#dealList').append(str);	
					 	showPage(dealCnt);
					});
				}			
			});			
	    }
	
	    //진행중 & 거래완료 Ajax
		function selectDealList(page, status){
					 $('.modal-body').append(str);
					 
					 if (result.sellId == "<%=id%>") {
						 if (result.status == '진행중') {
							$('#reviewBtn').hide();
							$('#depositBtn').hide();
							$('#deliveryBtn').hide();
							$('#deliveryInfoBtn').hide();
							$('#deliveryModBtn').hide();
						} else if (result.status == '입금완료') {
							$('#reviewBtn').hide();
							$('#depositBtn').hide();
							$('#deliveryBtn').show();
							$('#deliveryInfoBtn').hide();
							$('#deliveryModBtn').hide();
						} else if (result.status == '배송중') {
							$('#reviewBtn').hide();
							$('#depositBtn').hide();
							$('#deliveryBtn').hide();
							$('#deliveryInfoBtn').show();
							$('#deliveryModBtn').show();
						} else if (result.status == '완료') {
							$('#reviewBtn').show();
							$('#reviewId').val(result.buyId)
							$('#depositBtn').hide();
							$('#deliveryBtn').hide();
							$('#deliveryInfoBtn').hide();
							$('#deliveryModBtn').hide();
						}
					} else if (result.buyId == "<%=id%>") {
						if (result.status == '진행중') {
							$('#reviewBtn').hide();
							$('#depositBtn').show();
							$('#deliveryBtn').hide();
							$('#deliveryInfoBtn').hide();
							$('#deliveryModBtn').hide();
						} else if (result.status == '입금완료') {
							$('#reviewBtn').hide();
							$('#depositBtn').hide();
							$('#deliveryBtn').hide();
							$('#deliveryInfoBtn').hide();
							$('#deliveryModBtn').hide();
						} else if (result.status == '배송중') {
							$('#reviewBtn').hide();
							$('#depositBtn').hide();
							$('#deliveryBtn').hide();
							$('#deliveryInfoBtn').show();
							$('#deliveryModBtn').hide();
						} else if (result.status == '완료') {
							$('#reviewBtn').show();
							$('#reviewId').val(result.sellId)
							$('#depositBtn').hide();
							$('#deliveryBtn').hide();
							$('#deliveryInfoBtn').hide();
							$('#deliveryModBtn').hide();
						}
							
					}
					 
			   }
			});
		});
		
		function showList(){
			var str = "";
			var param = new Object();			
			param.page = page || 1;		
			param.status = status;
			console.log(status);
			$.ajax({
				url : "/myPage/selectDeal/" + page + "/" + status,
				dataType : "json",
				data : param,
				type : "GET",				
				success : function(result){					
					 var dealCnt = result.dealCnt;
					 $('#dealList').html("");
					result.list.forEach(function(element){
						
						str =  '<div class="col-lg-4 col-md-4"><div class="car__item">';
						str += '<div class="car__item__pic__slider">';
						if(element.picture != null){
						  	str += '<img style="height: 330px;" src="/resources/img/upload_cyg/'+element.picture+'"></div>';
						  } else {
							str += '<img style="height: 330px;" src="/resources/img/upload_cyg/noImage.jpg"></div>';	  
						  }
						str += '<div class="car__item__text"><div class="car__item__text__inner">';
						str += '<div class="label-date">' + element.buyId +'</div>';
						str += '<div class="label-date">' + element.sellId +'</div>';
						str += '<h5><input id="modalNo" name="modalNo" type="hidden" value="' + element.dealNo +'">';
						str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal" style="font-size: 25px;">' + element.itemName +'</a>';
						str += '&emsp;&emsp;&emsp;&emsp;<span>'+ formatDate(element.regDate) +'</span></h5>';
						str += '<ul><li><span>'+ element.keyword1 +'</span></li><li><span>'+ element.keyword2 +'</span></li>';
						str += '<li><span>'+ element.keyword3 +'</span></li></ul></div>';
						if(element.status === "진행중"){
							str += '<div class="car__item__price"><span id="statusColor" class="car-option">'+ element.status+'</span>';
						} else {
							str += '<div class="car__item__price"><span id="statusColor" class="car-option sale">'+ element.status+'</span>';
						}													
						str += '<h6 style="font-size: 18px;">'+ commas(element.price) +'원</h6></div></div></div></div>';	
						
						 $('#dealList').append(str);
						 showPage(dealCnt);
					});
				 }
			});
		}		
		
	    
	    //Deal 상세보기 모달
		$('#dealList').on("click", '.targetModal', function(){
			var modalNo = $(this).prev().val();					
			var str = "";
			$.ajax({
			   url : "/myPage/dealDetail/" + modalNo,
			   dataType : "json",
			   data : modalNo,
			   type : "GET",
			   success : function(result){	
				  $('.modal-body').html("");	
				  
				  str += '<div class="car__details__pic">';
				  str += '	<img src="/resources/img/upload_cyg/'+result.picture+'">';
				  str += '</div>';					 
				  str += '<div class="car__details__sidebar__model">';
				  str += 	'<ul>';
				  str += 		'<li>상품명 :<span>' + result.itemName + '</span></li>';
				  str += 		'<li>판매자 :<span>' + result.sellId + '</span></li>';
				  str += 		'<li>구매자 :<span>' + result.buyId + '</span></li>';
				  str += 	'</ul>';
				  str += '</div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += 	'<ul>';
				  str += 		'<li>거래방식 :<span>' + result.type + '</span></li>';
				  str += 		'<li>거래지역 :<span>' + result.region + '</span></li>';
				  str += 		'<li>상품상태 :<span>' + result.itemCondition + '</span></li>';
				  str += 	'</ul>';
				  str += '</div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += 	'<ul>';
				  str += 		'<li>키워드 :<span>' + result.keyword1 +'</span></li>';
				  str += 		'<li><span>' + result.keyword2 + '</span></li>';
				  str += 		'<li><span>' + result.keyword3 +'</span></li>';
				  str += 	'</ul>';
				  str += '</div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += 	'<ul>';
				  str += 		'<li>대분류 :<span>' + result.bigClassifier + '</span></li>';
				  str += 		'<li>중분류 :<span>' + result.mediumClassifier + '</span></li>';
				  str += 	'</ul>';
				  str += '</div>';
				  str += '<div class="car__details__sidebar__payment">';
				  str += 	'<ul>';
				  str += 		'<li>가격 :<span><fmt:formatNumber type="number" maxFractionDigits="3" value=""/>'+ commas(result.price) +'원</span></li>';
				  str += 	'</ul>';
				  str += '<a href="#" class="primary-btn">판매자와 대화하기</a></div>';			  
				
					 $('.modal-body').append(str);
			   }
			});
		});
	
			
	//페이지 이동
	$("#pagenation").on("click","li a", function(e){
        e.preventDefault();      
        
        var targetPageNum = $(this).attr("href");       
        
        pageNum = targetPageNum;
        
        if(statusCheck == "progress"){
        	selectDealList(pageNum, "진행중");
        }else if(statusCheck == "complete"){
        	selectDealList(pageNum, "완료");
        }else if(statusCheck == "whole"){
        	dealList(pageNum);
        }	       
      }); 		
			
	//페이징 계산 및 출력
	 var pageNum = 1;
	 
	 function showPage(dealCnt){      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9;       
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= dealCnt){
	        endNum = Math.ceil(dealCnt/10.0);
	      }
	      
	      if(endNum * 10 < dealCnt){
	        next = true;
	      }
	      
		  var str = "<ul class='pagination pull-left'>";
	      
	      if(prev){
	        str+= "<li class='paginate_button previous'><a href='"+(startNum -1)+"'>Previous</a></li>";
	      }         
	      
	      for(var i = startNum ; i <= endNum; i++){ 	    	  
	        var active = pageNum == i? "active":"";        
	        str+= "<li class='paginate_button'><a class='"+active+"' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='paginate_button next'><a href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      str += "</ul>";
	         
	      $("#pagenation").html(str);
	    }
	
	 
	//날짜 포맷팅
	 function formatDate(dateVal){
   		var date = new Date(dateVal);
		var year = date.getFullYear();              
   		 var month = (1 + date.getMonth());          
   		 	 month = month >= 10 ? month : '0' + month;  
    	 var day = date.getDate();                  
   		     day = day >= 10 ? day : '0' + day;      
    	return  year + '-' + month + '-' + day;       
	}
	 
	//숫자 콤마 찍기
	function commas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
		

	var searchForm = $("#searchForm");
	$("#searchForm button").on("click",	function(e) {
		if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
		}
			if (!searchForm.find("input[name='keyword']").val()) {
					alert("키워드를 입력하세요");
					return false;
				}

				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				searchForm.submit();
			});
</script>

<script type="text/javascript">
function star1Click() {
	$('#star1').html("★");
	$('#star2').html("☆");
	$('#star3').html("☆");
	$('#star4').html("☆");
	$('#star5').html("☆");
	$('#starScore').val("1");
}

function star2Click() {
	$('#star1').html("★");
	$('#star2').html("★");
	$('#star3').html("☆");
	$('#star4').html("☆");
	$('#star5').html("☆");
	$('#starScore').val("2");
}

function star3Click() {
	$('#star1').html("★");
	$('#star2').html("★");
	$('#star3').html("★");
	$('#star4').html("☆");
	$('#star5').html("☆");
	$('#starScore').val("3");
}

function star4Click() {
	$('#star1').html("★");
	$('#star2').html("★");
	$('#star3').html("★");
	$('#star4').html("★");
	$('#star5').html("☆");
	$('#starScore').val("4");
}

function star5Click() {
	$('#star1').html("★");
	$('#star2').html("★");
	$('#star3').html("★");
	$('#star4').html("★");
	$('#star5').html("★");
	$('#starScore').val("5");
}

function deposit() {
	$.ajax({
		url : "/deal/pay",
		dataType : "json",
		data : selectDeal,
		type : "POST",
		success : function(result){
			alert(result);
		}
	});
}

function deliveryInfo() {
	
}

</script>
<%@include file="../includes/footer.jsp"%>