<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp"%>
<style>
th, td{
	text-align: center; font-size: 1em;
	vertical-align: center;
}
</style>
	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>관심리스트</h2>
						<span>Wish List</span>
					</div>
				</div>
			</div>
		</div>
	
	 <!-- Car Section Begin -->    
        <div class="container">
            <div class="row">
                <div class="col-lg-12">                  
                </div>
                <div class="col-lg-12">
                    <div class="car__filter__option" style="background-color: white;">                    
                        <div class="row">
                             <div class="col-lg-8 col-md-6">
                                <a href="#" class="btn btn-danger" onclick="deleteSelected()">선택삭제</a>&emsp;
                                <a href="#" class="btn btn-danger">전체삭제</a>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="car__filter__option__item car__filter__option__item--right">
                                    <a href="#" class="btn btn-danger">판매자와 대화하기</a>
                                </div>
                            </div>                           
                        </div>
                    </div>
            <div class="row">
						<div class="col-lg-12 col-md-12">
							<table class="table table-hover">
								<colgroup>
									<col style="width: 10%;" />
									<col style="width: 10%;" />
									<col style="width: auto;" />
									<col style="width: 10%;" />
									<col style="width: 10%;" />									
									<col style="width: 10%;" />
									<col style="width: 10%;" />									
									<col style="width: 10%;" />
								</colgroup>
								<thead>
									<tr class="danger">
										<th></th>
										<th></th>
										<th>상품명</th>
										<th>거래방식</th>
										<th>키워드1</th>
										<th>키워드2</th>
										<th>키워드3</th>										
										<th>가격</th>										
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty list }">
											<tr>
												<td colspan="5" align="center">데이터가 없습니다.</td>
											</tr>

										</c:when>
										<c:when test="${!empty list }">
											<c:forEach var="wish" items="${list }">
												<tr style="vertical-align: middle;">
													<td><input type="checkbox" onchange="selectFunction(this, ${wish.wishNo})" style="zoom:2.0;"></td>
													<td><img src="/resources/img/upload_cyg/${wish.picture }"></td>
													<td><h5 style="font-weight: bold;">
														<input id="modalNo" name="modalNo" type="hidden" value="${wish.sellNo }">                                        
														<a class="targetModal" id="targetModal" href="#" 
														data-toggle="modal" data-target="#myModal">${wish.itemName }</a>														
													</h5>											
													<td>${wish.sellId }</td>
													<td>${wish.keyword1 }</td>
													<td>${wish.keyword2 }</td>
													<td>${wish.keyword3 }</td>													
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${wish.price }" /></td>
												</tr>
											</c:forEach>
										</c:when>
									</c:choose>
								</tbody>
							</table>
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
						<h4 class="modal-title" id="myModalLabel">상세보기</h4>
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

var list = new Array();

 function selectFunction(input, wishNo) {
   if (input.checked == true) {
      list.push(wishNo);
      console.log(list);
   } else {
      var index = list.indexOf(wishNo);
      if (index > -1) {
         list.splice(index, 1);
         console.log(list);
      }
   }
}
 function deleteSelected() {
    if (list != "") {
       console.log("삭제 시작");
         location.href = "deleteWish?list=" + list;
   }
    else {
       console.log("선택된 항목이 없습니다.");
    }
}
</script>

<%@include file="../includes/footer.jsp"%>