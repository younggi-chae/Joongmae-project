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
                  <h2>견적서 확인</h2>
                  <span>Estimate Information</span>
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
                        <a href="#" class="btn btn-danger" onclick="deleteSelected()">선택삭제</a>&emsp;
                        <a href="#" class="btn btn-danger">전체삭제</a>
                     </div>
                      <div class="col-lg-4 col-md-6">										
							<div class="pull-right">
								<form id='searchForm' action="/myPage/sellList" method='get'>
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
               <div class="row">
                  <c:choose>
                     <c:when test="${empty list }">
                        <div class="col-lg-12 col-md-4" align="center">
                           <h4>데이터가 없습니다.</h4>
                        </div>
                     </c:when>

                     <c:when test="${!empty list }">
                        <c:forEach var="sell" items="${list }">
                           <c:if test="${sell.status == '등록'}">
                              <div class="col-lg-4 col-md-4">
                                 <div class="car__item">
                                    <div class="car__item__pic__slider owl-carousel">
                                       <c:choose>
                                          <c:when test="${!empty sell.picture }">
                                             <img style="height: 330px"
                                                src="/resources/img/upload_cyg/${sell.picture }"
                                                alt="">
                                          </c:when>
                                         <c:when test="${empty sell.picture }">
											<img src="/resources/img/upload_cyg/noImage.jpg" style="height: 330px">
										</c:when>
                                       </c:choose>
                                    </div>
                                    <div class="car__item__text">
                                       <div class="car__item__text__inner">
                                          <div class="label-date">${sell.id }</div>
                                          <h5>  
                                          	<input id="modalNo" name="modalNo" type="hidden" value="${sell.sellNo }">                                        
											<a class="targetModal" id="targetModal" href="#" 
												data-toggle="modal" data-target="#myModal">${sell.itemName }</a>
												&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
												<label class="btn btn-light active">
	   											<input type="checkbox" onchange="selectFunction(this, ${sell.sellNo})" autocomplete="off">선택
	  											</label>          									
										  </h5>
												
                                          <ul>
                                             <li><span>${sell.keyword1 }</span></li>
                                             <li><span>${sell.keyword2 }</span></li>
                                             <li><span>${sell.keyword3 }</span></li>
                                          </ul>                                          	
                                       </div>
                                       <div class="car__item__price">                                         
                                          <h6 style="font-size: 25px;">                                                                       	
                                            <fmt:formatNumber type="number" maxFractionDigits="3" value="${sell.price }" />원&emsp;                                          
                                             <span class="sellNoValue">                                             
                                             	<input id="sellNo" name="sellNo" type="hidden" value="${sell.sellNo }">                                        	 	
                                        		<a class="addWish" id ="heart${sell.sellNo}" href="#" style="color: black"> 
                                        		<i class="fa fa-heart" id="heart" aria-hidden="true">찜하기</i></a>
                                             </span>                                                                                 
                                          </h6>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </c:if>
                        </c:forEach>
                     </c:when>
                  </c:choose>
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
         	<form id='actionForm' action="/myPage/sellList" method='get'>
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
						<h4 class="modal-title" id="myModalLabel">견적서 상세보기</h4>
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
   
$(document).ready(function () {		
	
	getWishList();
	
	$(".addWish").on("click", function(){		
		var sellNo = $(this).prev().val();		
		var heart = $(this);			
		
		if(heart.attr("style") === "color: black"){
			$.ajax({
				url : "/myPage/addWishList/" + sellNo,
				data : sellNo,
				type : "POST",
				success : function(result){
					alert(sellNo + " 추가");
					heart.attr("style", "color: red");	
				}				
			});
		} else if(heart.attr("style") === "color: red"){
			$.ajax({
				url : "/myPage/deleteWishList/" + sellNo,
				data : sellNo,
				type : "POST",
				success : function(result){
					alert(sellNo + " 삭제");
					heart.attr("style", "color: black");
				}
			});
		}
		
		});
	});		
	
	function getWishList(){		
		var sellNo = "";
		
		$.ajax({
			url : "/myPage/heartColor",
			dataType: "json",
			data : sellNo,
			type : "GET",
			success : function(result){				
				result.sellList.forEach(function(element){
				  var makeId = "heart"+element.sellNo;
				  
				  if($("#"+makeId).length){					  
					  result.wishList.forEach(function(wishData){						 
						  
						  if(element.sellNo == wishData.sellNo){
							  $("#"+makeId).attr("style", "color: red");
						  }						  
					  });					  
				  }				  
				});						
			}
		});	
	}
	
	
$(document).ready(function () {			
	$('.targetModal').on("click", function(){
		var modalNo = $(this).prev().val();
		console.log(modalNo);
		var list = "";
		var str = "";
		$.ajax({
		   url : "/myPage/sellDetail/" + modalNo,
		   dataType : "json",
		   data : modalNo,
		   type : "GET",
		   success : function(result){			 
			   
			  $('.modal-body').html("");
			  
			  if(result.picture != null){
			  	str += '<div class="car__details__pic"><img id="pic" src="/resources/img/upload_cyg/'+result.picture+'"></div>';
			  } else {
				str += '<div class="car__details__pic"><img id="pic" src="/resources/img/upload_cyg/noImage.jpg"></div>';	  
			  }
			  str += '<div class="car__details__sidebar__model"><ul><li>상품명 :<span>' + result.itemName + '</span></li>';
			  str += '<li>판매자 :<span>' + result.id + '</span></li></ul></div>';			 
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
			  str += '<ul><li>가격 :<span>' + commas(result.price) +'원</span></li></ul>';
			  str += '<a href="#" class="primary-btn">판매자와 대화하기</a></div>';				  
			  
				 $('.modal-body').append(str);
		   }
		});
	});	
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
	
	
	var list = new Array();

	 function selectFunction(input, sellNo) {
	   if (input.checked == true) {
	      list.push(sellNo);
	      console.log(list);
	   } else {
	      var index = list.indexOf(sellNo);
	      if (index > -1) {
	         list.splice(index, 1);
	         console.log(list);
	      }
	   }
	}
	 function deleteSelected() {
	    if (list != "") {
	       console.log("삭제 시작");
	         location.href = "../kjj/deleteSelectedSell.kjj?list=" + list;
	   }
	    else {
	       console.log("선택된 항목이 없습니다.");
	    }
	} 
 
</script>
 <%@include file="../includes/footer.jsp"%>   