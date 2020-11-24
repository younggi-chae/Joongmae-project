<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
										<option value="whole">전체</option>
										<option value="progress">진행중</option>
										<option value="complete">거래완료</option>
									</select>
								</div>
							</div>	
							 <div class="col-lg-4 col-md-6">
								<div class="pull-right">
								<form id='searchForm' action="/myPage/dealList" method='get'>
									<select name='type'>										
										<option value="I"
											<c:out value="${pageMaker.cri.type eq 'I'?'selected':''}"/>>상품명</option>								
									</select> 
									  <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/> 
									  <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
									  <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
									  <button class="btn btn btn-secondary" name="btnSearch" id="btnSearch"><i class="fa fa-search"></i></button>
								</form>
							  </div>  
							</div>				
						</div>
					</div>
					<div class="row" id="selectList">
						<%-- <c:choose>
							<c:when test="${empty list }">
								<div class="col-lg-12 col-md-4" align="center">
									<h4>데이터가 없습니다.</h4>
								</div>
							</c:when>
							<c:when test="${!empty list }">
								<c:forEach var="deal" items="${list }">
									<div class="col-lg-4 col-md-4">
										<div class="car__item">
											<div class="car__item__pic__slider owl-carousel">
												<c:choose>
													<c:when test="${!empty deal.picture }">
														<img style="height: 330px"
															src="/resources/img/upload_cyg/${deal.picture }"
															alt="">
													</c:when>
													<c:otherwise>
														<img style="height: 330px"
															src="/resources/img/upload_cyg/noImg.jpg"
															alt="">
													</c:otherwise>
												</c:choose>
											</div>
											<div class="car__item__text">
												<div class="car__item__text__inner">
													<div class="label-date">${deal.buyId }</div>
													<div class="label-date">${deal.sellId }</div>
													<h5>
														<a href="dealDetailAction.cyg?dealNo=${deal.dealNo }"
															data-toggle="modal" data-target="#myModal">${deal.itemName }</a>
													</h5>
													<ul>
														<li><span>${deal.keyword1 }</span></li>
														<li><span>${deal.keyword2 }</span></li>
														<li><span>${deal.keyword3 }</span></li>
													</ul>
												</div>
												<div class="car__item__price">
													<span class="car-option">${deal.status }</span>
													<c:choose>
														<c:when test="${deal.status == '진행중' }">
															<span class="car-option">${deal.status }</span>
														</c:when>
														<c:otherwise>
															<span class="car-option sale">${deal.status }</span>
														</c:otherwise>
													</c:choose>
													<h6>
														<fmt:formatNumber type="number" maxFractionDigits="3"
															value="${deal.price }" />
													</h6>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
						</c:choose> --%>
					</div>
					</div>
					<div class='pagination__option'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a
								href="${pageMaker.startPage -1}">Previous</a></li>
						</c:if>						
						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}">							
						   <c:choose>
		                     <c:when test="${pageMaker.cri.pageNum == num }">
		                     <li class="paginate_button">
		                        <a class="active" href="${num }">${num }</a>
		                     </li>
		                     </c:when>
		                     <c:otherwise>
		                     <li class="paginate_button">
		                        <a href="${num }">${num }</a>
		                     </li>
		                     </c:otherwise>
		                  </c:choose>								
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage +1 }">Next</a></li>
						</c:if>
					</ul>
				</div>
				<!--  end Pagination -->
			</div>
				<form id='actionForm' action="/myPage/dealList" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
					<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
			    </form>			
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
						<button type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>							
					</div>
				</div>					
			</div>				
		  </div>			
	<!-- /.modal -->	

<script src="/resources/js/jquery-3.3.1.min.js"></script>	
<script type="text/javascript">		

	$(document).ready(function(){			
		
		showList();
		
		$(".selectDeal").on("change", function(){
			var str = "";
			var selectDeal = "";			
			
			if($(".selectDeal option:selected").val() == 'whole'){
				
				showList();
			
			} else if($(".selectDeal option:selected").val() == 'complete'){
				$.ajax({
					url : "/myPage/completeDeal",
					dataType : "json",
					data : selectDeal,
					type : "GET",
					success : function(result){						
						 $('#selectList').html("");
						result.complete.forEach(function(element){
							str =  '<div class="col-lg-4 col-md-4"><div class="car__item">';
							str += '<div class="car__item__pic__slider .owl-carousel">';
							if(element.picture != null){
							  	str += '<img style="height: 330px;" src="/resources/img/upload_cyg/'+element.picture+'"></div>';
							  } else {
								str += '<img style="height: 330px;" src="/resources/img/upload_cyg/noImage.jpg"></div>';	  
							  }
							str += '<div class="car__item__text"><div class="car__item__text__inner">';
							str += '<div class="label-date">' + element.buyId +'</div>';
							str += '<div class="label-date">' + element.sellId +'</div>';
							str += '<h5><input id="modalNo" name="modalNo" type="hidden" value="' + element.dealNo +'">';
							str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal">' + element.itemName +'</a></h5>';
							str += '<ul><li><span>'+ element.keyword1 +'</span></li><li><span>'+ element.keyword2 +'</span></li>';
							str += '<li><span>'+ element.keyword3 +'</span></li></ul></div>';
							str += '<div class="car__item__price"><span class="car-option sale">'+ element.status+'</span>';							
							str += '<h6 style="font-size: 18px;">'+ commas(element.price) +'원</h6></div></div></div></div>';
							
							 $('#selectList').append(str);
						});
					 }
				});
			} else if($(".selectDeal option:selected").val() == 'progress'){
				$.ajax({
					url : "/myPage/progressDeal",
					dataType : "json",
					data : selectDeal,
					type : "GET",
					success : function(result){
						 $('#selectList').html("");
						result.progress.forEach(function(element){
							str =  '<div class="col-lg-4 col-md-4"><div class="car__item">';
							str += '<div class="car__item__pic__slider .owl-carousel">';	
							if(element.picture != null){
							  	str += '<img style="height: 330px;" src="/resources/img/upload_cyg/'+element.picture+'"></div>';
							  } else {
								str += '<img style="height: 330px;" src="/resources/img/upload_cyg/noImage.jpg"></div>';	  
							  }
							str += '<div class="car__item__text"><div class="car__item__text__inner">';
							str += '<div class="label-date">' + element.buyId +'</div>';
							str += '<div class="label-date">' + element.sellId +'</div>';
							str += '<h5><input id="modalNo" name="modalNo" type="hidden" value="' + element.dealNo +'">';
							str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal">' + element.itemName +'</a></h5>';
							str += '<ul><li><span>'+ element.keyword1 +'</span></li><li><span>'+ element.keyword2 +'</span></li>';
							str += '<li><span>'+ element.keyword3 +'</span></li></ul></div>';
							str += '<div class="car__item__price"><span class="car-option">'+ element.status+'</span>';							
							str += '<h6 style="font-size: 18px;">'+ commas(element.price) +'원</h6></div></div></div></div>';
							console.log(element.picture);
							 $('#selectList').append(str);					 
							});
						}			
					});				
				}
			});
		
		$('#selectList').on("click", '.targetModal', function(){
			var modalNo = $(this).prev().val();					
			var str = "";
			$.ajax({
			   url : "/myPage/dealDetail/" + modalNo,
			   dataType : "json",
			   data : modalNo,
			   type : "GET",
			   success : function(result){	
				  $('.modal-body').html("");	
				  console.log(result);
				  str += '<div class="car__details__pic"><img src="/resources/img/upload_cyg/'+result.picture+'"></div>';					 
				  str += '<div class="car__details__sidebar__model"><ul><li>상품명 :<span>' + result.itemName + '</span></li>';
				  str += '<li>판매자 :<span>' + result.sellId + '</span></li>';
				  str += '<li>구매자 :<span>' + result.buyId + '</span></li></ul></div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += '<ul><li>거래방식 :<span>' + result.type + '</span></li>';
				  str += '<li>거래지역 :<span>' + result.region + '</span></li>';
				  str += '<li>상품상태 :<span>' + result.itemCondition + '</span></li></ul></div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += '<ul><li>키워드 :<span>' + result.keyword1 +'</span></li><li><span>' + result.keyword2 + '</span></li>';
				  str += '<li><span>' + result.keyword3 +'</span></li></ul></div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += '<ul><li>대분류 :<span>' + result.bigClassifier + '</span></li><li>중분류 :<span>' + result.mediumClassifier + '</span></li></ul></div>';
				  str += '<div class="car__details__sidebar__payment">';
				  str += '<ul><li>가격 :<span><fmt:formatNumber type="number" maxFractionDigits="3" value=""/>'+ commas(result.price) +'원</span></li></ul>';
				  str += '<a href="#" class="primary-btn">판매자와 대화하기</a></div>';			  
				
					 $('.modal-body').append(str);
			   }
			});
		});
		
		function showList(){
			var str = "";
			var selectVar = "";	
			var page = actionForm.find("input[name='pageNum']").val();
			
			$.ajax({
				url : "/myPage/dealListAjax/" + page,
				dataType : "json",
				data : selectVar,
				type : "GET",
				success : function(result){						
					 
					 $('#selectList').html("");		
					//Initialize  owl-carousel Plugin
					
					 result.list.forEach(function(element){				
						
						str =  '<div class="col-lg-4 col-md-4"><div class="car__item">';						
						str += '<div class="car__item__pic__slider .owl-carousel">';
						if(element.picture != null){
						  	str += '<img style="height: 330px;" src="/resources/img/upload_cyg/'+element.picture+'"></div>';
						  } else {
							str += '<img style="height: 330px;" src="/resources/img/upload_cyg/noImage.jpg"></div>';	  
						  }
						str += '<div class="car__item__text"><div class="car__item__text__inner">';
						str += '<div class="label-date">' + element.buyId +'</div>';
						str += '<div class="label-date">' + element.sellId +'</div>';
						str += '<h5><input id="modalNo" name="modalNo" type="hidden" value="' + element.dealNo +'">';
						str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal">' + element.itemName +'</a></h5>';
						str += '<ul><li><span>'+ element.keyword1 +'</span></li><li><span>'+ element.keyword2 +'</span></li>';
						str += '<li><span>'+ element.keyword3 +'</span></li></ul></div>';
						if(element.status === "진행중"){
							str += '<div class="car__item__price"><span id="statusColor" class="car-option">'+ element.status+'</span>';
						} else {
							str += '<div class="car__item__price"><span id="statusColor" class="car-option sale">'+ element.status+'</span>';
						}													
						str += '<h6 style="font-size: 18px;">'+ commas(element.price) +'원</h6></div></div></div></div>';						
					
						 	$('#selectList').append(str);	
						});
					}			
				});			
		    }
		});
	
	function commas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
		
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click",	function(e) {
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']")
			.val($(this).attr("href"));
				actionForm.submit();
			});
	
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
<%@include file="../includes/footer.jsp"%>