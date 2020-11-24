<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp"%>

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
                    <div class="car__filter__option" style="height: 74px; background-color: white;">                    
                        <div class="row">
                             <div class="col-lg-8 col-md-6">
                                <a href="#" class="primary-btn" onclick="deleteSelected()">선택삭제</a>&emsp;
                                <a href="#" class="primary-btn">전체삭제</a>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="car__filter__option__item car__filter__option__item--right">
                                    <a href="#" class="primary-btn">판매자와 대화하기</a>
                                </div>
                            </div>                           
                        </div>
                    </div>
               <div class="row">
                    	<c:choose>
                    	 <c:when test="${empty list }">
                    			<div class="col-lg-12 col-md-4" align="center"><h4>데이터가 없습니다.</h4></div>
                    		</c:when>
                    		
                    		<c:when test="${!empty list }"> 
                    			<c:forEach var="wish" items="${list }">                            	
                        	<div class="col-lg-4 col-md-4">
                            <div class="car__item">
                                <div class="car__item__pic__slider owl-carousel">
                                 <c:choose>
                                 	<c:when test="${!empty wish.picture }">
                                 		<img  src="/resources/img/upload_cyg/${wish.picture }" alt="" style="height: 330px">
                                 	</c:when>
                                 	<c:when test="${empty wish.picture }">
                                 		<img src="/resources/img/upload_cyg/noImage.jpg" alt="" style="height: 330px">
                                 	</c:when>
                                 </c:choose>
                                </div>
                                <div class="car__item__text">
                                    <div class="car__item__text__inner">
                                        <div class="label-date">${wish.sellId }</div>
                                        <h5><a href="#">${wish.itemName }</a></h5>
                                        <ul>
                                            <li><span>${wish.keyword1 }</span></li>
                                            <li><span>${wish.keyword2 }</span></li>
                                            <li><span>${wish.keyword3 }</span></li>
                                        </ul>
                                    </div>
                                    <div class="car__item__price">
                                        <span class="car-option sale" style="background-color: #d2d2d2;"><input type="checkbox" onchange="selectFunction(this, ${wish.wishNo})"></span>
                                        <h6><fmt:formatNumber type="number" maxFractionDigits="3" value="${wish.price }"/></h6>
                                    </div>
                                </div>
                            </div>                             
                        </div>                        	
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
            </div>       
    </section>
    <!-- Car Section End -->
	
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
   
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
         location.href = "wishDeleteAction.cyg?list=" + list;
   }
    else {
       console.log("선택된 항목이 없습니다.");
    }
}
</script>

<%@include file="../includes/footer.jsp"%>