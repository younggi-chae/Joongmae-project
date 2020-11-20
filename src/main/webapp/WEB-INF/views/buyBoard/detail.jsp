<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../includes/header.jsp" %>
	
	<link rel="stylesheet" href="/resources/css/style_kgj.css" type="text/css">


    <!-- Breadcrumb End -->
    <div class="breadcrumb-option set-bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text__kgj">
                        <h2>${buy.title }</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Begin -->

    <!-- Car Details Section Begin -->
    <section class="car-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                        <div class="car__details__pic__large">
						<c:if test="${buy.id eq member.id }">
							<c:set var="head"
								value="${fn:substring(member.picture, 0, fn:length(member.picture)-4) }"></c:set>
							<c:set var="pattern"
								value="${fn:substring(member.picture, fn:length(head) +1, fn:length(member.picture)) }"></c:set>
							<c:choose>
								<c:when
									test="${pattern == 'jpg' || pattern == 'gif' || pattern == 'png' }">
									<img
										src="/resources/img/upload_cyg/${head }_small.${pattern}">
								</c:when>
								<c:otherwise>
									<img
										src="/resources/img/cars/memberPicture-2_kgj.jpg">
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
                </div>
                <div class="col-lg-6">
                    <div class="car__details__sidebar">
                        <div class="car__details__sidebar__model">
                            <ul>
                                <li>아이디 <span>${buy.id }</span></li>
                                <li>구매희망가격 <span><fmt:formatNumber value="${buy.minPrice }" pattern="##,###"/> ~ <fmt:formatNumber value="${buy.maxPrice }" pattern="##,###"/></span></li>
                                <li>거래방법 <span>${buy.type }</span></li>
                                <c:choose>
                                	<c:when test="${buy.type != '택배거래' }">
                                		<li>직거래 지역 <span>${buy.region }</span></li>
                                	</c:when>
                                </c:choose>
                            </ul>
                            <a href="#" class="primary-btn">판매 등록</a>
                        </div>
                    </div>
                    <c:choose>
                    	<c:when test="${member.id eq buy.id }">
                    		<br>
		                    <div style="float: right;">
		                    	<form action="/buyBoard/delete">
		                    	<input type="hidden" name="buyNo" value="${buy.buyNo }">
		                     	<button type="submit" class="site-btn">삭제</button>
		                     	</form>
		                     </div>
		                     <div style="float: right; margin-right: 10px;">
		                     	<button type="button" class="site-btn" onclick="location.href='/buyBoard/reRegisterForm?buyNo=${buy.buyNo}'">재등록</button>
		                     </div>
	                     </c:when>
                     </c:choose>
                     <div style="float: right; margin-right: 10px;">
                     	<form action="/buyBoard/list?pageNum=${pageMaker.cri.
		                     	pageNum}&amount=${pageMaker.cri.amount}&bigClassifier=${pageMaker.cri.bigClassifier }&mediumClassifier=${pageMaker.cri.
		                     	mediumClassifier }&keyword1=${pageMaker.cri.keyword1 }&keyword2=${pageMaker.cri.keyword2 }&keyword3=${pageMaker
		                     	.cri.keyword3 }&price=${price}" method="post">
		                     	<button type="submit" class="site-btn">목록</button>
		                </form>
		             </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Car Details Section End -->

<%@ include file="../includes/footer.jsp" %>
    
    <script src="/resources/js/main_kgj.js"></script>

</html>