<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>
   
   <link rel="stylesheet" href="/resources/css/style_kgj.css" type="text/css">

    <!-- Breadcrumb End -->
    <div class="breadcrumb-option set-bg" data-setbg="/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>구매 게시판</h2>
                        <c:if test="${pageMaker.cri.bigClassifier != null }">
                        <div class="breadcrumb__text">
                           <span>${pageMaker.cri.bigClassifier }</span>
                           <span> > ${pageMaker.cri.mediumClassifier }</span>
                           <span>&nbsp;&nbsp;&nbsp;${pageMaker.cri.keyword1 }</span>
                           <span>/${pageMaker.cri.keyword2 }</span>
                           <span>/${pageMaker.cri.keyword3 }</span>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Begin -->

    <!-- Car Section Begin -->
    <section class="car spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="car__sidebar">
                        <div class="car__filter">
                            <h5>Searching</h5>
                            <br>
                            <form id="searchForm" action="/buyBoard/list" method="post">
                               <p>대분류</p>
                                <select id="bigSelectBox" name="bigClassifier">
                                    <option value="의류" selected="selected">의류</option>
                                    <option value="가전">가전</option>
                                </select>
                                <p>중분류</p>
                                <select id="mediumSelectBox" name="mediumClassifier">
                                    <option value="상의">상의</option>
                                    <option value="하의">하의</option>
                                    <option value="악세사리">악세사리</option>
                                    <option value="냉장고">냉장고</option>
                                    <option value="에어컨">에어컨</option>
                                    <option value="세탁기">세탁기</option>
                                </select>
                                <div class="keyword-input">
                                    <p>키워드1</p>
                                    <input type="text" name="keyword1">
                                </div>
                                <div class="keyword-input">
                                    <p>키워드2</p>
                                    <input type="text" name="keyword2">
                                </div>
                                <div class="keyword-input">
                                    <p>키워드3</p>
                                    <input type="text" name="keyword3">
                                </div>
                                <div class="filter-price">
                                    <p>Price:</p>
                                    <div class="price-range-wrap">
                                        <div class="filter-price-range"></div>
                                        <div class="range-slider">
                                            <div class="price-input">
                                                <input type="text" name="price" id="filterAmount">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="car__filter__btn">
                                   <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                                <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="site-btn">Reset FIlter</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="car__filter__option">
                        <div class="row">
                            <div class="col-lg-6 col-md-6">
                                <div class="car__filter__option__item">
                                <form id="pagecontrolForm" action="/buyBoard/list" method="post">
                                    <h6>페이지보기</h6>
                                    <select id="pageControl">
                                    <c:if test="${pageMaker.cri.amount == 3 }">
                                        <option value="3" selected="selected">3 Page</option>
                                        <option value="6">6 Page</option>
                                        <option value="9">9 Page</option>
                                    </c:if>
                                     <c:if test="${pageMaker.cri.amount == 6 }">
                                        <option value="3">3 Page</option>
                                        <option value="6" selected="selected">6 Page</option>
                                        <option value="9">9 Page</option>
                                    </c:if>
                                     <c:if test="${pageMaker.cri.amount == 9 }">
                                        <option value="3">3 Page</option>
                                        <option value="6">6 Page</option>
                                        <option value="9" selected="selected">9 Page</option>
                                    </c:if>
                                       
                                    </select>
                                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                                <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <c:if test="${pageMaker.cri.bigClassifier != null }">
                                <input type="hidden" name="bigClassifier" value='<c:out value="${ pageMaker.cri.bigClassifier }"/>'>
                                <input type="hidden" name="mediumClassifier" value='<c:out value="${ pageMaker.cri.mediumClassifier }"/>'>
                                <input type="hidden" name="keyword1" value='<c:out value="${ pageMaker.cri.keyword1 }"/>'>
                                <input type="hidden" name="keyword2" value='<c:out value="${ pageMaker.cri.keyword2 }"/>'>
                                <input type="hidden" name="keyword3" value='<c:out value="${ pageMaker.cri.keyword3 }"/>'>
                                <input type="hidden" name="price" value='<c:out value="${ price }"/>'>
                                </c:if>
                                <c:if test="${pageMaker.cri.sort != null }">
                                <input type="hidden" name="sort" value='<c:out value="${ pageMaker.cri.sort }"/>'>
                                </c:if>
                                </form>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6">
                                <div class="car__filter__option__item car__filter__option__item--right">
                                   <form id="sortControlForm" action="/buyBoard/list" method="post">
                                    <h6>정렬</h6>
                                    <select id="sortControl" name="sort">
                                        <c:if test="${pageMaker.cri.sort == 'latest' }">
                                       <option value="latest" selected="selected">최신순</option>
                                        <option value="highPrice">높은 가격순</option>
                                        <option value="lowPrice">낮은 가격순</option>
                                        </c:if>
                                       <c:if test="${pageMaker.cri.sort == 'highPrice' }">
                                       <option value="latest">최신순</option>
                                        <option value="highPrice" selected="selected">높은 가격순</option>
                                        <option value="lowPrice">낮은 가격순</option>
                                        </c:if>
                                        <c:if test="${pageMaker.cri.sort == 'lowPrice' }">
                                        <option value="latest">최신순</option>
                                        <option value="highPrice">높은 가격순</option>
                                        <option value="lowPrice" selected="selected">낮은 가격순</option>
                                        </c:if>
                                    </select>
                                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                                <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <c:if test="${pageMaker.cri.bigClassifier != null }">
                                <input type="hidden" name="bigClassifier" value='<c:out value="${ pageMaker.cri.bigClassifier }"/>'>
                                <input type="hidden" name="mediumClassifier" value='<c:out value="${ pageMaker.cri.mediumClassifier }"/>'>
                                <input type="hidden" name="keyword1" value='<c:out value="${ pageMaker.cri.keyword1 }"/>'>
                                <input type="hidden" name="keyword2" value='<c:out value="${ pageMaker.cri.keyword2 }"/>'>
                                <input type="hidden" name="keyword3" value='<c:out value="${ pageMaker.cri.keyword3 }"/>'>
                                <input type="hidden" name="price" value='<c:out value="${ price }"/>'>
                                </c:if>
                                <c:if test="${pageMaker.cri.sort != null }">
                                <input type="hidden" name="sort" value='<c:out value="${ pageMaker.cri.sort }"/>'>
                                </c:if>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                       <c:forEach var="listBuy" items="${list }">
                           <div class="col-lg-4 col-md-4">
                               <div class="car__item">
                               <img src="/resources/img/cars/memberPicture-2_kgj.jpg">
                                   <div class="car__item__text">
                                       <div class="car__item__text__inner">
                                           <div class="label-date">${listBuy.id }</div>
                                           <h5>
                                           <c:choose>
                                              <c:when test="${pageMaker.cri.bigClassifier eq null }">
                                              <a href="/buyBoard/detail?buyNo=${listBuy.buyNo }&id=${listBuy.id}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri
                                              .amount}&sort=${pageMaker.cri.sort}">
                                                    ${listBuy.title }
                                              </a>
                                           </c:when>
                                           <c:when test="${pageMaker.cri.bigClassifier ne null }">
                                              <a href="/buyBoard/detail?buyNo=${listBuy.buyNo }&id=${listBuy.id}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri
                                              .amount}&bigClassifier=${pageMaker.cri.bigClassifier}&mediumClassifier=${pageMaker.cri.mediumClassifier}&keyword1=${pageMaker
                                              .cri.keyword1}&keyword2=${pageMaker.cri.keyword2}&keyword3=${pageMaker.cri.keyword3}&price=${price}&sort=${pageMaker.cri.sort}">
                                                    ${listBuy.title }
                                              </a>
                                           </c:when>
                                           </c:choose>
                                           </h5>
                                           <ul>
                                           <c:if test="${listBuy.keyword1 != null }">
<<<<<<< HEAD
                                           	<li>${listBuy.keyword1 }</li>
                                           </c:if>
                                           <c:if test="${listBuy.keyword2 != null }">
                                           	<li>${listBuy.keyword2 }</li>
                                           </c:if>
                                           <c:if test="${listBuy.keyword3 != null }">
                                           	<li>${listBuy.keyword3 }</li>
=======
                                              <li>${listBuy.keyword1 }</li>
                                           </c:if>
                                           <c:if test="${listBuy.keyword2 != null }">
                                              <li>${listBuy.keyword2 }</li>
                                           </c:if>
                                           <c:if test="${listBuy.keyword3 != null }">
                                              <li>${listBuy.keyword3 }</li>
>>>>>>> refs/heads/master
                                           </c:if>
                                           </ul>
                                       </div>
                                       <div class="car__item__price">
                                       <sec:authorize access="isAnonymous()">
                                           <span class="car-option">가격</span>
                                       </sec:authorize>
                                       <sec:authorize access="isAuthenticated()">
                                             <c:forEach var="alarm" items="${alarm }">
                                              <c:if test="${listBuy.buyNo eq alarm.buyNo }">
                                                 <c:set var="matching" value="true"></c:set>
                                              </c:if>
                                           </c:forEach>
                                           <c:choose>
                                              <c:when test="${matching }">
                                                 <span class="car-option-matching">매칭</span>
                                              </c:when>
                                              <c:otherwise>
                                                 <span class="car-option">가격</span>
                                              </c:otherwise>
                                           </c:choose>
                                       </sec:authorize>
                                           <h6><fmt:formatNumber value="${listBuy.minPrice }" pattern="##,###"/> ~ <fmt:formatNumber value="${listBuy.maxPrice }" pattern="##,###"/></h6>
                                       </div>
                                   </div>
                               </div>
                           </div>
                        </c:forEach>
                    </div>
                    <div class='pagination__option'>
                     <ul class="pagination">
                        <c:if test="${pageMaker.prev}">
                           <li class="paginate_button previous"><a href="${pageMaker.startPage -1}"><span class="arrow_carrot-2left"></span></a></li>
                        </c:if>                  
                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">                     
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
                              href="${pageMaker.endPage + 1 }"><span class="arrow_carrot-2right"></span></a></li>
                        </c:if>
                     </ul>
                  </div>
         <!--  end Pagination -->      
                    <form id="actionForm" action="/buyBoard/list" method="get">
                       <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                       <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                       <c:if test="${pageMaker.cri.bigClassifier != null }">
                       <input type="hidden" name="bigClassifier" value='<c:out value="${ pageMaker.cri.bigClassifier }"/>'>
                       <input type="hidden" name="mediumClassifier" value='<c:out value="${ pageMaker.cri.mediumClassifier }"/>'>
                       <input type="hidden" name="keyword1" value='<c:out value="${ pageMaker.cri.keyword1 }"/>'>
                       <input type="hidden" name="keyword2" value='<c:out value="${ pageMaker.cri.keyword2 }"/>'>
                       <input type="hidden" name="keyword3" value='<c:out value="${ pageMaker.cri.keyword3 }"/>'>
                       <input type="hidden" name="price" value='<c:out value="${ price }"/>'>
                       </c:if>
                       <c:if test="${pageMaker.cri.sort != null }">
                       <input type="hidden" name="sort" value='<c:out value="${ pageMaker.cri.sort }"/>'>
                       </c:if>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- Car Section End -->
    

<%@ include file="../includes/footer.jsp" %>
      
    <script src="/resources/js/main_kgj.js"></script>
    <script src="/resources/js/buyBoard/list.js"></script>
    

</html>