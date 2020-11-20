<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <a href="#" class="primary-btn" onclick="deleteSelected()">선택삭제</a>&emsp;
                        <a href="#" class="primary-btn" onclick="deleteAll('${list}')">전체삭제</a>
                     </div>
                     <div class="col-lg-4 col-md-6">
                        <div
                           class="car__filter__option__item car__filter__option__item--right">
                           <div class="car__search">
                              <form action="dealListAction.cyg" method="post">
                                 <input type="text" name="searchKey" size="10"
                                    placeholder="검색...">
                                 <button type="submit">
                                    <i class="fa fa-search"></i>
                                 </button>
                              </form>
                           </div>
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
                                                src="/resources/img/upload_kjj/${sell.picture }"
                                                alt="">
                                          </c:when>
                                          <c:when test="${empty sell.picture }">
                                             <img style="height: 330px"
                                                src="C:\upload\temp\이미지.jpg"
                                                alt="">
                                          </c:when>
                                       </c:choose>
                                    </div>
                                    <div class="car__item__text">
                                       <div class="car__item__text__inner">
                                          <div class="label-date">${sell.id }</div>
                                          <h5>
                                             <a href="#">${sell.itemName }</a><input type="button" value="수정" style="margin-left: 200px;" onclick="modifyButton(${sell.sellNo})">
                                          </h5>
                                          <ul>
                                             <li><span>${sell.keyword1 }</span></li>
                                             <li><span>${sell.keyword2 }</span></li>
                                             <li><span>${sell.keyword3 }</span></li>
                                          </ul>
                                       </div>
                                       <div class="car__item__price">

                                          <span class="car-option sale"
                                             style="background-color: #d2d2d2;"><input
                                             type="checkbox"
                                             onchange="selectFunction(this, ${sell.sellNo})"></span>
                                          <h6>
                                             <fmt:formatNumber type="number" maxFractionDigits="3"
                                                value="${sell.price }" />
                                             &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <span>
                                                <c:choose>
                                                   <c:when test="${empty wishlist}">
                                                      <a href="#" style="color: black"> <i
                                                         class="fa fa-heart" aria-hidden="true">찜하기</i></a>
                                                   </c:when>
                                                   <c:when test="${!empty wishlist }">
                                                      <c:set var = "don_loop" value = "flase"/>
                                                      <c:set var = "wishNo" value = ""/>
                                                      <c:forEach var="wish" items="${wishlist }">
                                                         <c:if test = "${sell.sellNo eq wish.sellNo}">
                                                             <c:set var = "don_loop" value = "true"/>
                                                             <c:set var = "wishNo" value = "${wish.sellNo}"/>
                                                         </c:if>
                                                      </c:forEach>
                                                      <c:choose>
                                                   <c:when test="${don_loop eq true}">
                                                      <a href="#" style="color: red" onclick="wishListAdd(${sell.sellNo}, ${wishNo})"> <i
                                                         class="fa fa-heart" aria-hidden="true">찜하기</i></a>
                                                   </c:when>
                                                   <c:when test="${don_loop eq false}">
                                                      <a href="#" style="color: black" onclick="wishListAdd(${sell.sellNo}, ${wish.sellNo })"> <i
                                                         class="fa fa-heart" aria-hidden="true">찜하기</i></a>
                                                   </c:when>
                                                      </c:choose>
                                                   </c:when>
                                                </c:choose>
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
            <div class="pagination__option">
               <c:if test="${listModel.startPage > 5 }">
                  <a href="dealListAction.cyg?pageNum=${listModel.startPage -1 }"><span
                     class="arrow_carrot-2left"></span></a>
               </c:if>

               <c:forEach var="pageNo" begin="${listModel.startPage }"
                  end="${listModel.endPage }">
                  <c:choose>
                     <c:when test="${listModel.requestPage == pageNo }">
                        <a class="active" href="dealListAction.cyg?pageNum=${pageNo }">${pageNo }</a>
                     </c:when>
                     <c:otherwise>
                        <a href="dealListAction.cyg?pageNum=${pageNo }">${pageNo }</a>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>

               <c:if test="${listModel.endPage < listModel.totalPageCount }">
                  <a href="dealListAction.cyg?pageNum=${listModel.endPage +1 }"><span
                     class="arrow_carrot-2right"></span></a>
               </c:if>
            </div>
         </div>
      </div>
   </section>
   <!-- Car Section End -->

   <!-- Footer Section Begin -->
   <footer class="footer set-bg"
      data-setbg="/resources/img/footer-bg.jpg">
      <div class="container">
         <div>
            <div class="row">
               <div class="col-lg-6 col-md-6">
                  <div class="footer__contact__title">
                     <h2>고객 센터</h2>
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
         <div class="footer__copyright__text">
            <p>
               Copyright &copy;
               <script>document.write(new Date().getFullYear());</script>
               All rights reserved | This template is made with <i
                  class="fa fa-heart" aria-hidden="true"></i> by <a
                  href="https://colorlib.com" target="_blank">Colorlib</a>
            </p>
         </div>
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

   <!-- Js Plugins -->
   <script src="/resources/js/jquery-3.3.1.min.js"></script>
   <script src="/resources/js/bootstrap.min.js"></script>
   <script
      src="/resources/js/jquery.nice-select.min.js"></script>
   <script src="/resources/js/jquery-ui.min.js"></script>
   <script
      src="/resources/js/jquery.magnific-popup.min.js"></script>
   <script src="/resources/js/mixitup.min.js"></script>
   <script src="/resources/js/jquery.slicknav.js"></script>
   <script src="/resources/js/owl.carousel.min.js"></script>
   <script src="/resources/js/main.js"></script>
   <script type="text/javascript">

   $( document ).ready(function() {
       console.log('${wishlist}');
   });
   
   $( document ).ready(function() {
       console.log('${list}');
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
         location.href = "/sell/deleteSelectedSell?list=" + list;
   }
    else {
       console.log("선택된 항목이 없습니다.");
    }
}
 
 
   function wishListAdd(sellNo, wishSellNo) {    
      console.log(sellNo);
      console.log(wishSellNo);
      if (sellNo != wishSellNo) {
       location.href = "wishListInsertAction.cyg?sellNo=" + sellNo;    
       alert("관심리스트에 추가되었습니다.")
   }
    else if(sellNo === wishSellNo) {       
       alert("이미 관심리스트에 있습니다.")      
    }
   
}  
   
   function modifyButton(input) {
	location.href = "../kjj/modifySellFormAction.kjj?sellNo=" + input;
}
   
   function deleteAll(list) {
		var allSellNo = new Array();
		console.log(list);
		
		while(true){
			if (list.indexOf("sellNo") == -1) {
				break;
			} else {
				list = list.substring(list.indexOf("sellNo") + 7);
				var sellNo = list.substring(0, list.indexOf(","));
				console.log("sellNo : " + sellNo);
				
				list = list.substring(list.indexOf("status") + 7);
				var status = list.substring(0, list.indexOf(","));
				console.log("status : " + status)
				
				if (status == "등록"){
					allSellNo.push(sellNo);	
				
				}
			}
		}
		
		console.log(allSellNo);
		
		location.href = "/sell/deleteSelectedSell?list=" + allSellNo;
	}
 
</script>

</body>
</html>